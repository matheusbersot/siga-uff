/*******************************************************************************
 * Copyright (c) 2006 - 2011 SJRJ.
 * 
 *     This file is part of SIGA.
 * 
 *     SIGA is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     SIGA is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with SIGA.  If not, see <http://www.gnu.org/licenses/>.
 ******************************************************************************/
/*
 * Created Mon Nov 14 13:30:45 GMT-03:00 2005.
 */
package br.gov.jfrj.siga.ex;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.lucene.analysis.br.BrazilianAnalyzer;
import org.apache.xerces.impl.dv.util.Base64;
import org.hibernate.Hibernate;
import org.hibernate.annotations.Entity;
import org.hibernate.search.annotations.Analyzer;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.FieldBridge;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Store;

import br.gov.jfrj.itextpdf.Documento;
import br.gov.jfrj.lucene.HtmlBridge;
import br.gov.jfrj.lucene.PDFBridge;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.ex.util.Compactador;
import br.gov.jfrj.siga.ex.util.DatasPublicacaoDJE;
import br.gov.jfrj.siga.ex.util.ProcessadorHtml;
import br.gov.jfrj.siga.ex.util.ProcessadorReferencias;
import br.gov.jfrj.siga.ex.util.PublicacaoDJEBL;

/**
 * A class that represents a row in the 'EX_MOVIMENTACAO' table. This class may
 * be customized as it is never re-generated after being created.
 */

@Entity
@Indexed
public class ExMovimentacao extends AbstractExMovimentacao implements
		Serializable, Comparable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2559924666592487436L;
	
	private byte[] cacheConteudoBlobMov;
	
	/**
	 * Simple constructor of ExMovimentacao instances.
	 */
	public ExMovimentacao() {
	}

	/**
	 * Constructor of ExMovimentacao instances given a simple primary key.
	 * 
	 * @param idMov
	 */
	public ExMovimentacao(final java.lang.Long idMov) {
		super(idMov);
	}

	@Override
	public Long getIdMov() {
		return super.getIdMov();
	}

	public String getConteudoBlobString() throws UnsupportedEncodingException {
		return new String(getConteudoBlobMov2(), "ISO-8859-1");
	}

	public String getConteudoBlobPdfB64() {
		return Base64.encode(getConteudoBlobpdf());
	}

	/* Add customized code below */

	@Field(name = "descrTipoMovimentacao", index = Index.TOKENIZED, store = Store.COMPRESS)
	@Analyzer(impl = BrazilianAnalyzer.class)
	public String getDescrTipoMovimentacao() {
		String s = getExTipoMovimentacao().getSigla();
		if (getCadastrante() == null || getSubscritor() == null)
			return s;
		if (!getSubscritor().getId().equals(getCadastrante().getId()))
			s = s + " de Ordem";
		if (getExMovimentacaoCanceladora() != null)
			s = s + " (Cancelada)";
		return s;
	}

	public byte[] getConteudoBlobMov2() {

		if (cacheConteudoBlobMov == null)
			cacheConteudoBlobMov = br.gov.jfrj.siga.cp.util.Blob
					.toByteArray(getConteudoBlobMov());
		return cacheConteudoBlobMov;

	}
	
	public String getLotaPublicacao() {
		Map<String, String> atributosXML = new HashMap<String, String>();	    
		try{		
			String xmlString = this.getConteudoXmlString("boletimadm");
			if (xmlString != null){
				atributosXML = PublicacaoDJEBL.lerXMLPublicacao(xmlString);
				return atributosXML.get("UNIDADE");
			}			
			return PublicacaoDJEBL.obterUnidadeDocumento(this.getExDocumento());
		}catch (Exception e){
			return "Erro na leitura do arquivo XML (lota��o de publica��o)";
			
		}
		
	}
	
	public String getDescrPublicacao() {
		Map<String, String> atributosXML = new HashMap<String, String>();
		try{
			String xmlString = this.getConteudoXmlString("boletimadm");
			if (xmlString != null){
				atributosXML = PublicacaoDJEBL.lerXMLPublicacao(this.getConteudoXmlString("boletimadm"));
				return atributosXML.get("DESCREXPEDIENTE");
			}
			return this.getExDocumento().getDescrDocumento();	
		}catch (Exception e){
			return "Erro na leitura do arquivo XML (descri��o de publica��o)";
		}
		
	}

	@Field(name = "idTpMov", store = Store.COMPRESS)
	public Long getIdTpMov() {
		return getExTipoMovimentacao().getIdTpMov();
	}

	public void setConteudoBlobMov2(byte[] blob) {
		if (blob != null)
			setConteudoBlobMov(Hibernate.createBlob(blob));
		cacheConteudoBlobMov = blob;
	}

	/**
	 * Retorna a data da movimenta��o no formato dd/mm/aa, por exemplo,
	 * 01/02/10.
	 * 
	 * @return Data da movimenta��o no formato dd/mm/aa, por exemplo, 01/02/10.
	 * 
	 */
	@Field(name = "dtMovDDMMYY", store = Store.COMPRESS)
	public String getDtMovDDMMYY() {
		if (getDtMov() != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yy");
			return df.format(getDtMov());
		}
		return "";
	}

	/**
	 * Retorna a data de in�cio da movimenta��o no formato dd/mm/aa, por
	 * exemplo, 01/02/10.
	 * 
	 * @return Data de in�cio da movimenta��o no formato dd/mm/aa, por exemplo,
	 *         01/02/10.
	 * 
	 */
	public String getDtRegMovDDMMYY() {
		if (getDtIniMov() != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yy");
			return df.format(getDtIniMov());
		}
		return "";
	}

	/**
	 * Retorna a data de in�cio da movimenta��o no formato dd/mm/aa HH:MI:SS,
	 * por exemplo, 01/02/10 14:10:00.
	 * 
	 * @return Data de in�cio da movimenta��o no formato dd/mm/aa HH:MI:SS, por
	 *         exemplo, 01/02/10 14:10:00.
	 * 
	 */
	public String getDtRegMovDDMMYYHHMMSS() {
		if (getDtIniMov() != null) {
			final SimpleDateFormat df = new SimpleDateFormat(
					"dd/MM/yy HH:mm:ss");
			return df.format(getDtIniMov());
		}
		return "";
	}

	/**
	 * Retorna a data de in�cio da movimenta��o no formato dd/mm/aaaa HH:MI:SS,
	 * por exemplo, 01/02/2010 14:10:00.
	 * 
	 * @return Data de in�cio da movimenta��o no formato dd/mm/aaaa HH:MI:SS,
	 *         por exemplo, 01/02/2010 14:10:00.
	 * 
	 */
	public String getDtRegMovDDMMYYYYHHMMSS() {
		if (getDtIniMov() != null) {
			final SimpleDateFormat df = new SimpleDateFormat(
					"dd/MM/yyyy HH:mm:ss");
			return df.format(getDtIniMov());
		}
		return "";
	}

	/**
	 * Retorna a data de retorno da movimenta��o no formato dd/mm/aa, por
	 * exemplo, 01/02/10.
	 * 
	 * @return Data de retorno da movimenta��o no formato dd/mm/aa, por exemplo,
	 *         01/02/10.
	 * 
	 */
	public String getDtFimMovDDMMYY() {
		if (getDtFimMov() != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yy");
			return df.format(getDtFimMov());
		}
		return "";
	}
	
	/**
	 * Retorna a data de retorno da movimenta��o no formato dd/mm/aa HH:MI:SS,
	 * por exemplo, 01/02/10 14:10:00.
	 * 
	 * @return Data de retorno da movimenta��o no formato dd/mm/aa HH:MI:SS, por
	 *         exemplo, 01/02/10 14:10:00.
	 * 
	 */
	public String getDtFimMovDDMMYYHHMMSS() {
		if (getDtFimMov() != null) {
			final SimpleDateFormat df = new SimpleDateFormat(
					"dd/MM/yy HH:mm:ss");
			return df.format(getDtFimMov());
		}
		return "";
	}
	
	/**
	 * Retorna a data da movimenta��o por extenso. no formato "Rio de Janeiro,
	 * 01 de fevereiro de 2010", por exemplo.
	 * 
	 * @return Data da movimenta��o por extenso. no formato "Rio de Janeiro, 01
	 *         de fevereiro de 2010", por exemplo.
	 */
	public String getDtExtenso() {
		SimpleDateFormat df1 = new SimpleDateFormat();
		try {
			df1.applyPattern("dd/MM/yyyy");
			df1.applyPattern("dd 'de' MMMM 'de' yyyy.");

			String s = getNmLocalidade();

			DpLotacao lotaBase = null;
			if (getLotaTitular() != null)
				lotaBase = getLotaTitular();
			else if (getLotaSubscritor() != null)
				lotaBase = getLotaSubscritor();
			else if (getLotaCadastrante() != null)
				lotaBase = getLotaCadastrante();

			if (s == null && lotaBase != null) {
				s = lotaBase.getLocalidadeString();
				/*
				 * s = getLotaTitular().getOrgaoUsuario().getMunicipioOrgaoUsu()
				 * + ", ";
				 */
			}

			return s + ", " + df1.format(getDtMov()).toLowerCase();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * Retorna verdadeiro se a diferen�a entre a data de disponibiliza��o no DJE
	 * e a data atual for igual a 2 e falso caso contr�rio.
	 * 
	 * @return Verdadeiro se a diferen�a entre a data de disponibiliza��o no DJE
	 *         e a data atual for igual a 2 e falso caso contr�rio.
	 */
	public boolean isARemeterHojeDJE() {
		try {
			DatasPublicacaoDJE d = new DatasPublicacaoDJE(getDtDispPublicacao());
			return d.isDisponibilizacaoDMais2();
		} catch (AplicacaoException ae) {
			return false;
		}
	}

	/**
	 * Retorna a descri��o da movimenta��o.
	 * 
	 * @return Descri��o da movimenta��o.
	 */
	@Field(name = "descrMov", index = Index.TOKENIZED, store = Store.COMPRESS)
	@Analyzer(impl = BrazilianAnalyzer.class)
	@Override
	public String getDescrMov() {
		// TODO Auto-generated method stub
		return super.getDescrMov();
	}

	/**
	 * Retorna informa��es da movimenta��o como Nome do �rg�o Externo,
	 * Observa��o do �rg�o, Descri��o do Tipo de Movimenta��o e Descri��o da
	 * Movimenta��o.
	 * 
	 * @return Informa��es da movimenta��o como Nome do �rg�o Externo,
	 *         Observa��o do �rg�o, Descri��o do Tipo de Movimenta��o e
	 *         Descri��o da Movimenta��o.
	 */
	public String getObs() {
		String s = "";
		if (getOrgaoExterno() != null)
			s = s + getOrgaoExterno().getNmOrgao();

		if (getObsOrgao() != null) {
			if (s.length() > 0)
				s = s + "; ";

			s = s + getObsOrgao().trim();

			final String provObs = getObsOrgao().trim();
			if (!provObs.endsWith(".") && !provObs.endsWith("!")
					&& !provObs.endsWith("?"))
				s = s + ". ";
			else
				s = s + " ";
		}

		if (getExTipoDespacho() != null)
			s = s + getExTipoDespacho().getDescTpDespacho();

		if (getDescrMov() != null) {
			s = s + getDescrMov();
		}

		return s;
	}

	/**
	 * Retorna o n�mero de sequ�ncia da via como um inteiro.
	 * 
	 * @return N�mero de sequ�ncia como um inteiro se for uma via e 0 caso
	 *         contr�rio.
	 */
	public int getNumVia2() {
		return getExMobil().isVia() ? getExMobil().getNumSequencia().intValue()
				: 0;
	}

	/**
	 * Retorna o n�mero de sequ�ncia da via como uma String.
	 * 
	 * @return N�mero de sequ�ncia como uma String se for uma via e "" caso
	 *         contr�rio.
	 */
	@Field(name = "numVia", index = Index.NO, store = Store.COMPRESS)
	public String getNumViaString() {
		if (getNumVia2() == 0)
			return "";
		return String.valueOf(getNumVia2());
	}

	public int compareTo(final Object o) {
		try {
			final ExMovimentacao mov = (ExMovimentacao) o;
			int i = getDtIniMov().compareTo(mov.getDtIniMov());
			if (i != 0)
				return i;
			i = getIdMov().compareTo(mov.getIdMov());
			return i;
		} catch (final Exception ex) {
			return 0;
		}
	}

	/**
	 * Retorna o nome do respons�vel pela movimenta��o.
	 * 
	 * @return Nome do respons�vel pela movimenta��o.
	 */
	public String getRespString() {
		if (getOrgaoExterno() != null)
			return getObs();
		else {
			String strReturn = "";
			if (getLotaResp() != null)
				strReturn = getLotaResp().getDescricao();
			if (getResp() != null)
				strReturn = strReturn + " - " + getResp().getDescricao();
			return strReturn;
		}
	}

	/**
	 * Retorna o nome do respons�vel pela movimenta��o.
	 * 
	 * @return Nome do respons�vel pela movimenta��o.
	 */
	public String getCadastranteString() {
		String strReturn = "";
		if (getLotaResp() != null)
			strReturn = getLotaResp().getDescricao();
		if (getResp() != null)
			strReturn = strReturn + " - " + getResp().getDescricao();
		return strReturn;
	}
	
	public String getConteudoBlobHtmlB64() {
		return Base64.encode(getConteudoBlobHtml());
	}

	public void setConteudoBlobHtml(final byte[] conteudo) {
		setConteudoBlob("doc.htm", conteudo);
	}

	public void setConteudoBlobPdf(final byte[] conteudo) {
		setConteudoBlob("doc.pdf", conteudo);
	}

	public void setConteudoBlobForm(final byte[] conteudo) {
		setConteudoBlob("doc.form", conteudo);
	}

	public void setConteudoBlobXML(final String nome, final byte[] conteudo) {
		setConteudoBlob(nome + ".xml", conteudo);
	}

	public void setConteudoBlobRTF(final String nome, final byte[] conteudo) {
		setConteudoBlob(nome + ".rtf", conteudo);
	}

	public void setConteudoBlob(final String nome, final byte[] conteudo) {
		final Compactador zip = new Compactador();
		final byte[] arqZip = getConteudoBlobMov2();
		byte[] conteudoZip = null;
		if (arqZip == null || (zip.listarStream(arqZip) == null)) {
			if (conteudo != null) {
				conteudoZip = zip.compactarStream(nome, conteudo);
			} else {
				conteudoZip = null;
			}
		} else {
			if (conteudo != null) {
				conteudoZip = zip.adicionarStream(nome, conteudo, arqZip);
			} else {
				conteudoZip = zip.removerStream(nome, arqZip);
			}
		}
		setConteudoBlobMov2(conteudoZip);
	}

	@Field(name = "conteudoBlobMovHtml", index = Index.TOKENIZED)
	@Analyzer(impl = BrazilianAnalyzer.class)
	@FieldBridge(impl = HtmlBridge.class)
	public byte[] getConteudoBlobHtml() {
		return getConteudoBlob("doc.htm");
	}

	public String getConteudoBlobHtmlString() {
		if (getConteudoBlobHtml() == null) {
			return null;
		}
		try {
			return new String(getConteudoBlobHtml(), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			return new String(getConteudoBlobHtml());
		}
	}

	@Field(name = "conteudoBlobMovPdf", index = Index.TOKENIZED)
	@Analyzer(impl = BrazilianAnalyzer.class)
	@FieldBridge(impl = PDFBridge.class)
	public byte[] getConteudoBlobPdfNecessario() {
		if (getConteudoBlobHtml() == null)
			return getConteudoBlobpdf();
		return null;
	}

	/**
	 * Retorna o documento relacionado a movimenta��o.
	 * 
	 * @return Documento relacionado a movimenta��o.
	 */
	public ExDocumento getExDocumento() {
		return super.getExMobil().getExDocumento();
	}

	public byte[] getConteudoBlobpdf() {
		try {
			if (getConteudoTpMov().equals("application/zip"))
				return getConteudoBlob("doc.pdf");
			if (getConteudoTpMov().equals("application/pdf"))
				return getConteudoBlobMov2();
		} catch (Exception ex) {
			return null;
		}
		return null;
	}

	public byte[] getConteudoBlobForm() {
		return getConteudoBlob("doc.form");
	}

	public byte[] getConteudoBlobXML() {
		return getConteudoBlobXML("doc.xml");
	}

	public byte[] getConteudoBlobXML(String nome) {
		if (!nome.contains(".xml"))
			nome += ".xml";
		return getConteudoBlob(nome);
	}

	public String getConteudoXmlString(String nome) throws UnsupportedEncodingException {
		
		byte[] xmlByte = this.getConteudoBlobXML(nome);
		if(xmlByte != null)
			return new String(xmlByte,"ISO-8859-1");
		
		return null;		
	}
	
	public byte[] getConteudoBlobRTF() {
		return getConteudoBlob("doc.rtf");
	}

	public byte[] getConteudoBlob(final String nome) {
		final byte[] conteudoZip = getConteudoBlobMov2();
		byte[] conteudo = null;
		final Compactador zip = new Compactador();
		if (conteudoZip != null) {
			conteudo = zip.descompactarStream(conteudoZip, nome);
		}
		return conteudo;
	}

	public void setConteudoBlobHtmlString(final String s) throws Exception {
		final String sHtml = (new ProcessadorHtml()).canonicalizarHtml(s,
				false, true, false, false, false);
		setConteudoBlob("doc.htm", sHtml.getBytes("ISO-8859-1"));
	}

	/**
	 * Retorna o nome da Fun��o do Subscritor da Movimenta��o.
	 * 
	 * @return Nome da Fun��o do Subscritor da Movimenta��o.
	 */
	public java.lang.String getNmFuncao() {
		if (getNmFuncaoSubscritor() == null)
			return null;
		String a[] = getNmFuncaoSubscritor().split(";");
		if (a.length < 1)
			return null;
		if (a[0].length() == 0)
			return null;
		return a[0];
	}

	/**
	 * Retorna o nome do arquivo anexado a movimenta��o.
	 * 
	 * @return Nome do arquivo anexado a movimenta��o.
	 */
	@Field(name = "nmArqmov", store = Store.COMPRESS)
	public String getNmArqMov() {
		String s = super.getNmArqMov();

		if (s != null) {
			s = s.trim();
			if (s.length() == 0)
				return null;
		}
		return s;
	}
	
	/**
	 * Retorna o nome do arquivo anexado a movimenta��o sem extens�o.
	 * 
	 * @return Nome do arquivo anexado a movimenta��o sem extens�o.
	 */
	@Field(name = "nmArqmov", store = Store.COMPRESS)
	public String getNmArqMovSemExtensao() {
		String s = super.getNmArqMov();

		if (s != null) {
			s = s.trim();
			if (s.length() == 0)
				return null;
			
			try {
				return s.split("\\.")[0];	
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}
		
		return s;
	}

	/**
	 * Retorna o nome da lota��o do subscritor da movimenta��o.
	 * 
	 * @return Nome da lota��o do subscritor da movimenta��o.
	 */
	public java.lang.String getNmLotacao() {
		if (getNmFuncaoSubscritor() == null)
			return null;
		String a[] = getNmFuncaoSubscritor().split(";");
		if (a.length < 2)
			return null;
		if (a[1].length() == 0)
			return null;
		return a[1];
	}

	/**
	 * Retorna o nome da localidade da lota��o do subscritor da movimenta��o.
	 * 
	 * @return Nome da localidade da lota��o do subscritor da movimenta��o.
	 */
	public java.lang.String getNmLocalidade() {
		if (getNmFuncaoSubscritor() == null)
			return null;
		String a[] = getNmFuncaoSubscritor().split(";");
		if (a.length < 3)
			return null;
		if (a[2].length() == 0)
			return null;
		return a[2];
	}

	/**
	 * Retorna o nome do subscritor da movimenta��o.
	 * 
	 * @return Nome do subscritor da movimenta��o.
	 */
	public java.lang.String getNmSubscritor() {
		if (getNmFuncaoSubscritor() == null)
			return null;
		String a[] = getNmFuncaoSubscritor().split(";");
		if (a.length < 4)
			return null;
		if (a[3].length() == 0)
			return null;
		return a[3];
	}

	/**
	 * Retorna o c�digo da movimenta��o de refer�ncia da movimenta��o Atual.
	 * 
	 * @return C�digo da movimenta��o de refer�ncia da movimenta��o Atual.
	 */
	public java.lang.String getReferencia() {
		return getExMobil().getCodigoCompacto() + ":" + getIdMov();
		/*
		 * este atributo � utilizado p/ compor nmPdf (abaixo), n�o retirar o
		 * caracter ":" /* pois este � utilizado no m�todo
		 * ExMovimentacaoAction.recuperarAssinaturaAppletB64()
		 */
	}

	public java.lang.String getNmPdf() {
		return getReferencia() + ".pdf";
	}

	// public String getNumViaToChar() {
	// if (getNumVia2() == 0)
	// return "";
	//
	// return "" + Character.toChars(getNumVia2() + 64)[0];
	// }
	//
	// public String getNumViaDocPaiToChar() {
	// return ""
	// + Character.toChars(getExMobilPai().getNumSequencia()
	// .intValue() + 64)[0];
	// }
	//
	// public String getNumViaDocRefToChar() {
	// return ""
	// + Character.toChars(getExMobilRef().getNumSequencia()
	// .intValue() + 64)[0];
	// }

	@Override
	public String getHtml() {
		return getConteudoBlobHtmlString();
	}

	@Override
	public String getHtmlComReferencias() throws Exception {
		return getConteudoBlobHtmlStringComReferencias();
	}

	private String getConteudoBlobHtmlStringComReferencias() throws Exception {
		String sHtml = getConteudoBlobHtmlString();
		ProcessadorReferencias pr = new ProcessadorReferencias();
		pr.ignorar(this.getExMobil().getExDocumento().getSigla());
		pr.ignorar(this.getExMobil().getSigla());
		sHtml = pr.marcarReferencias(sHtml);
		return sHtml;
	}

	@Override
	public byte[] getPdf() {
		return getConteudoBlobpdf();
	}

	@Override
	public boolean isPdf() {
		return (getNumPaginas() != null && getNumPaginas() > 0) || (getPdf() != null);
	}

	/**
	 * Retorna a data da movimenta��o.
	 * 
	 * @return Data da movimenta��o.
	 */
	@Override
	public Date getData() {
		return getDtMov();
	}

	/**
	 * verifica se uma movimenta��o est� cancelada. Uma movimenta��o est�
	 * cancelada quando o seu atributo movimentacaoCanceladora est� preenchido
	 * com um c�digo de movimenta��o de cancelamento.
	 * 
	 * @return Verdadeiro se a movimenta��o est� cancelada e Falso caso
	 *         contr�rio.
	 */
	public boolean isCancelada() {
		return getExMovimentacaoCanceladora() != null;
	}

	/**
	 * verifica se uma movimenta��o � canceladora, ou seja, se � do tipo
	 * Cancelamento de Movimenta��o.
	 * 
	 * @return Verdadeiro ou Falso.
	 */
	public boolean isCanceladora() {
		return getExTipoMovimentacao() != null
				&& getExTipoMovimentacao()
						.getIdTpMov()
						.equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_DE_MOVIMENTACAO);
	}

	/**
	 * verifica se uma movimenta��o de anexa��o de arquivo est� assinada e n�o
	 * est� cancelada. Este tipo de movimenta��o est� assinada quando existe
	 * alguma movimenta��o de assinatura de movimenta��o com o seu atributo
	 * movimentacaoReferenciadora igual ao c�digo da movimenta��o de anexa��o de
	 * arquivo.
	 * 
	 * @return Verdadeiro se a movimenta��o est� assinada e Falso caso
	 *         contr�rio.
	 */
	public boolean isAssinada() {
		if (!this.isCancelada()
				&& this.getExMovimentacaoReferenciadoraSet() != null) {
			for (ExMovimentacao movRef : this
					.getExMovimentacaoReferenciadoraSet()) {
				if (movRef.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO
						|| movRef.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO)
					return true;
			}
		}
		return false;
	}

	public String getSiglaAssinatura() {
		return getExDocumento().getIdDoc()
				+ "."
				+ getIdMov()
				+ "-"
				+ Math.abs((getExDocumento().getDescrCurta() + getIdMov())
						.hashCode() % 10000);
	}
	
	public String getSiglaAssinaturaExterna() {
		return getExDocumento().getIdDoc()
				+ "."
				+ getIdMov()
				+ "-"
				+ Math.abs((getExDocumento().getDescrCurta() + getIdMov() + "AssinaturaExterna")
						.hashCode() % 10000);
	}

	public Set<ExMovimentacao> getAssinaturasDigitais() {
		TreeSet<ExMovimentacao> movs = new TreeSet<ExMovimentacao>();
		movs.addAll(getApenasAssinaturas());
		movs.addAll(getApenasConferenciasCopia());
		return movs;
	}

	/**
	 * Retorna uma cole��o de movimenta��es dos tipo:
	 * ASSINATURA_DIGITAL_MOVIMENTACAO.
	 * 
	 * @return Cole��o de movimenta��es de assinaturas digitais.
	 */
	public Set<ExMovimentacao> getApenasAssinaturas() {
		Set<ExMovimentacao> set = new TreeSet<ExMovimentacao>();

		for (ExMovimentacao m : getExMovimentacaoReferenciadoraSet()) {
			if ((m.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO)
					&& m.getExMovimentacaoCanceladora() == null) {
				set.add(m);
			}
		}
		return set;
	}

	/**
	 * Retorna uma cole��o de movimenta��es dos tipo
	 * CONFERENCIA_COPIA_DOCUMENTO.
	 * 
	 * @return Cole��o de movimenta��es de confer�ncias de c�pia.
	 */
	public Set<ExMovimentacao> getApenasConferenciasCopia() {
		Set<ExMovimentacao> set = new TreeSet<ExMovimentacao>();

		for (ExMovimentacao m : getExMovimentacaoReferenciadoraSet()) {
			if ((m.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO)
					&& m.getExMovimentacaoCanceladora() == null) {
				set.add(m);
			}
		}
		return set;
	}

	public String getAssinantesString() {
		return Documento.getAssinantesString(getApenasAssinaturas());
	}

	public String getConferentesString() {
		return Documento.getAssinantesString(getApenasConferenciasCopia());
	}

	public String getAssinantesCompleto() {
		String conferentes = getConferentesString();
		String assinantes = getAssinantesString();
		String retorno = "";
		retorno += assinantes.length() > 0 ? "Assinado digitalmente por "
				+ assinantes + ".\n" : "";
		retorno += conferentes.length() > 0 ? "C�pia conferida com documento original por "
				+ conferentes + ".\n"
				: "";
		return retorno;
	}

	/**
	 * verifica se uma movimenta��o est� cancelada. Uma movimenta��o est�
	 * cancelada quando o seu atributo movimentacaoCanceladora est� preenchido
	 * com um c�digo de movimenta��o de cancelamento.
	 * 
	 * @return Verdadeiro se a movimenta��o est� cancelada e Falso caso
	 *         contr�rio.
	 */
	@Override
	public boolean isCancelado() {
		return isCancelada();
	}

	@Override
	public boolean isRascunho() {
		// TODO Auto-generated method stub
		if(getExTipoMovimentacao().getIdTpMov().equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO)
				&& mob().doc().isEletronico() && !isAssinada())
			return true;
		
		return false;
	}

	@Override
	public boolean isSemEfeito() {
		if(getExDocumento().isSemEfeito()) {
			//N�o gera marca de "Sem Efeito em Folha de Desentranhamento"
			if(getExTipoMovimentacao().getId() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA)
				return false;
			else
				return true;
		}
		
		return false;
	}

	/**
	 * Retorna da lota��o do titular da movimenta��o.
	 * 
	 * @return Lota��o do titular da movimenta��o.
	 */
	@Override
	public DpLotacao getLotacao() {
		return getLotaTitular();
	}

	/**
	 * Retorna uma descri��o da movimenta��o formada pelos campos: Sigla,
	 * Descri��o do Tipo de Movimenta��o e Descri��o da Movimenta��o.
	 * 
	 * @return Uma descri��o da movimenta��o
	 */
	@Override
	public String toString() {
		return getExMobil().getSigla() + ": "
				+ getExTipoMovimentacao().getDescricao() + ": " + getDescrMov();
	}

	/**
	 * @return Verdadeiro se o tipo de movimenta��o for CANCELAMENTO_JUNTADA ou
	 *         CANCELAMENTO_DE_MOVIMENTACAO e Falso caso contr�rio
	 */
	public boolean isInserirDocumentoNoDossieDoMobilRef() {
		return getExTipoMovimentacao().getId() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA
				|| getExTipoMovimentacao().getId() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_DE_MOVIMENTACAO;
	}

	/**
	 * @return Data de in�cio da movimenta��o de refer�ncia se o m�todo
	 *         isInserirDocumentoNoDossieDoMobilRef() for verdadeiro ou retorna
	 *         a data de in�cio da movimenta��o caso contr�rio.
	 * 
	 */
	public Date getDtIniMovParaInsercaoEmDossie() {
		if (getExTipoMovimentacao() == null)
			return null;
		if (isInserirDocumentoNoDossieDoMobilRef()) {
			return getExMovimentacaoRef().getDtIniMov();
		}
		return getDtIniMov();
	}

	/**
	 * Retorna o Mobil relacionado a movimenta��o atual.
	 * 
	 * @return Data de in�cio da movimenta��o de refer�ncia se o m�todo
	 *         isInserirDocumentoNoDossieDoMobilRef() for verdadeiro ou retorna
	 *         a data de in�cio da movimenta��o caso contr�rio.
	 * 
	 */
	public ExMobil mob() {
		// TODO Auto-generated method stub
		return getExMobil();
	}

	@Override
	public boolean isInternoProduzido() {
		switch (getExTipoMovimentacao().getIdTpMov().intValue()) {
		case (int) ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO:
			return false;
		}
		// TODO Auto-generated method stub
		return true;
	}
	
	public boolean isUltimaMovimentacao() {
		return getIdMov().equals(getExMobil().getUltimaMovimentacao().getIdMov());
	}

	@Override
	public boolean isCodigoParaAssinaturaExterna(String num) {

		int hash = Integer.parseInt(num.substring(num.indexOf("-") + 1));

		for (ExMovimentacao mov : getExDocumento().getExMovimentacaoSet())
			if (Math.abs((getExDocumento().getDescrCurta() + mov.getIdMov() + "AssinaturaExterna")
					.hashCode() % 10000) == hash)
				return true;
		return false;

	}
}