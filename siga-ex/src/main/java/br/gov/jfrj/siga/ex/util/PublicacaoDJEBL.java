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
package br.gov.jfrj.siga.ex.util;

import java.io.ByteArrayOutputStream;
import java.io.StringReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.constants.Style;
import org.apache.axis.constants.Use;
import org.apache.axis.description.OperationDesc;
import org.apache.axis.description.ParameterDesc;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.xml.sax.ContentHandler;
import org.xml.sax.helpers.AttributesImpl;

import br.gov.jfrj.siga.AxisClientAlternativo;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExTpDocPublicacao;
import br.gov.jfrj.siga.ex.SigaExProperties;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.persistencia.ExMobilDaoFiltro;

import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

public class PublicacaoDJEBL {

	public static int MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR = 526;

	public static int MODELO_FORMULARIO_PUBLICACAO_DJF2R_LICITACAO_CONTRATOS = 527;

	public static int MODELO_FORMULARIO_PUBLICACAO_DJF2R = 230;

	private static String xmlRetornado;

	public static String getXmlRetornado() {
		return xmlRetornado;
	}

	public static void setXmlRetornado(String xmlRetornado) {
		PublicacaoDJEBL.xmlRetornado = xmlRetornado;
	}

	public static void segundoRetorno(Date data, String tipoCaderno,
			String secao, String soLerXml) throws Exception {
		String xml = buscarSegundoRetorno(data, tipoCaderno, secao);
		if (!soLerXml.equals("sim"))
			lerXMLSegundoRetorno(data, xml);
	}

	private static void lerXMLSegundoRetorno(Date data, String xml)
			throws Exception {
		// TODO Auto-generated method stub
		StringReader st = new StringReader(xml);
		SAXBuilder sb = new SAXBuilder();

		Document dc = sb.build(st);

		Element retornoPublicacao = dc.getRootElement();		

		List elementos = retornoPublicacao.getChildren();
		Iterator i = elementos.iterator();

		while (i.hasNext()) {
			try {
				Element elemento = (Element) i.next();
				String numeroDoDocumento = elemento
						.getAttributeValue("NUMDOCUMENTO");
				String paginaDaPublicacao = elemento
						.getAttributeValue("PAGPUBLICACAO");

				final ExMobilDaoFiltro daoViaFiltro = new ExMobilDaoFiltro();
				daoViaFiltro.setSigla(numeroDoDocumento);

				final ExDao exDao = ExDao.getInstance();

				final ExMobil docVia;
				docVia = exDao.consultarPorSigla(daoViaFiltro);

				if (docVia != null)
					Ex.getInstance().getBL()
							.registrarDisponibilizacaoPublicacao(docVia, data,
									paginaDaPublicacao);
			} catch (Exception e) {
				int a = 0;

			}
		}
	}

	public static String buscarSegundoRetorno(Date data, String tipoCaderno,
			String secao) throws Exception {
		Service service = new Service();
		OperationDesc oper;

		// opera��o------------------------------------------------
		oper = new OperationDesc();
		oper.setName("GerarRespostaStatusPublicacoes");
		oper.addParameter(new QName("http://tempuri.org/", "_enmAreaJudicial"),
				new QName("http://www.w3.org/2001/XMLSchema", "EAreaJudicial"),
				String.class, ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/", "_enmJudAdmTipo"),
				new QName("http://www.w3.org/2001/XMLSchema",
						"EJudicialAdministrativo"), String.class,
				ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/",
				"_dtmDataDisponibilizacao"), new QName(
				"http://www.w3.org/2001/XMLSchema", "dateTime"), Date.class,
				ParameterDesc.IN, false, false);
		// define o tipo de retorno
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema",
				"base64Binary"));
		oper.setReturnClass(byte[].class);
		oper.setReturnQName(new QName("http://tempuri.org/",
				"GerarRespostaStatusPublicacoesResult"));
		oper.setStyle(Style.WRAPPED);
		oper.setUse(Use.LITERAL);

		// call--------------------------------------------------

		Call call = (Call) service.createCall();
		call.setOperation(oper);
		call
				.setTargetEndpointAddress(new URL(SigaExProperties
						.getServidorDJE()));
		call.setOperationName(new QName("http://tempuri.org/",
				"GerarRespostaStatusPublicacoes"));
		call.setProperty(Call.SOAPACTION_USE_PROPERTY, Boolean.TRUE);
		call.setProperty(Call.SOAPACTION_URI_PROPERTY,
				"http://tempuri.org/GerarRespostaStatusPublicacoes");

		String xmlRetorno;

		if (tipoCaderno.equals("J"))
			xmlRetorno = new String((byte[]) call.invoke(new Object[] { secao,
					"Judicial", data }));
		else
			xmlRetorno = new String((byte[]) call.invoke(new Object[] { secao,
					"Administrativo", data }));

		System.out.println("DJE Busca Publicacoes "
				+ new SimpleDateFormat("dd/MM/yyyy").format(data) + ":"
				+ xmlRetorno);

		setXmlRetornado(xmlRetorno);

		return xmlRetornado;
	}

	public static String enviarTRF(ExMovimentacao mov) throws Exception {

		/*
		 * AxisClient axis = new AxisClient(
		 * "http://djewebtrf.jf.trf2.gov.Br/DJE.WebServices/WsPrimeiraInstancia.asmx"
		 * , "http://tempuri.org/", "RecebeDocumentos",
		 * "http://tempuri.org/RecebeDocumentos"); Object obj = axis .call(new
		 * Object[] { org.bouncycastle.util.encoders.Base64
		 * .encode(mov.getConteudoBlobMov2()) });
		 */

		System.out.println("DJE: prestes a chamarrrr servi�o");
		try {
			AxisClientAlternativo cliente = new AxisClientAlternativo(
					SigaExProperties.getServidorDJE(), "RecebeDocumentos", true);

			cliente.setParam(new Object[] { mov.getConteudoBlobMov2() });
			Object o = cliente.call();
			return new String((byte[]) o);
		} catch (Throwable t) {
			System.out.print("DJE erro: " + t.getMessage() + " "
					+ t.getCause().getMessage() + " ");
			throw new Exception(t);
		}
	}

	public static void primeiroEnvio(ExMovimentacao mov) throws Exception {

		String conteudoXML = enviarTRF(mov);

		System.out.println("\n\n DJE envio " + mov.getExDocumento().getCodigo()
				+ ", retorno: " + conteudoXML);

		verificaRetornoErrosTRF(conteudoXML);
	}

	/*
	 * Rotina central para tratamento dos erros retornados pelo TRF atrav�s do
	 * XML. Atualmente, as mensagens de erro s�o apenas associadas aos seus
	 * respectivos c�digos de erro e n�meros de expedientes, para formar uma
	 * exce��o �nica, mas a �d�ia � que aqui, quando necess�rio, seja tomada a
	 * decis�o adequada a cada tipo de erro, de acordo com o seu c�digo
	 */
	public static void verificaRetornoErrosTRF(String xml) throws Exception {
		StringReader st = new StringReader(xml);
		SAXBuilder sb = new SAXBuilder();
		Document dc;

		try {
			dc = sb.build(st);
		} catch (Exception e) {
			String xmlAlterado = "<?" + xml;
			st = new StringReader(xmlAlterado);
			dc = sb.build(st);
		}

		Element retornoPublicacao = dc.getRootElement();
		String codErro = retornoPublicacao.getAttributeValue("CODRETORNO");
		if (codErro == null)
			codErro = retornoPublicacao.getChildTextTrim("CODIGO");

		if (codErro != null && !codErro.equals("0")) {
			String descricaoErro = retornoPublicacao
					.getAttributeValue("DESCRICAO");
			if (descricaoErro == null)
				descricaoErro = retornoPublicacao.getChildText("DESCRICAO");
			if (descricaoErro == null)
				descricaoErro = retornoPublicacao.getValue();

			throw new AplicacaoException("TRF -> ERRO: " + codErro
					+ " DESCRI��O: " + descricaoErro);
		}

	}
	
	public static Map<String, String> lerXMLPublicacao(String xml) throws Exception {
		
		Map<String, String> atributosXML = new HashMap<String, String>();
		StringReader st = new StringReader(xml);
		SAXBuilder sb = new SAXBuilder();
		Document dc = null;
		
		try {
			dc = sb.build(st);
		} catch (Exception e) {
			String xmlAlterado = "<?" + xml;
			st = new StringReader(xmlAlterado);
			dc = sb.build(st);
		}
		
		Element texPublicacao = dc.getRootElement();
		
		Element elemento = texPublicacao.getChild("IDENTIFICACAO");		
		atributosXML.put("TIPOARQ", elemento.getAttributeValue("TIPOARQ"));
		atributosXML.put("CADERNO", elemento.getAttributeValue("CADERNO"));
		atributosXML.put("SECAO", elemento.getAttributeValue("SECAO"));
		atributosXML.put("UNIDADE", elemento.getAttributeValue("UNIDADE"));
		atributosXML.put("DATADISPONIBILIZACAO", elemento.getAttributeValue("DATADISPONIBILIZACAO"));
		atributosXML.put("TIPODOC", elemento.getAttributeValue("TIPODOC"));
		atributosXML.put("MATRICULAUSUARIO", elemento.getAttributeValue("MATRICULAUSUARIO"));		
		
		elemento = texPublicacao.getChild("EXPEDIENTE");
		atributosXML.put("NUMEXPEDIENTE", elemento.getAttributeValue("NUMEXPEDIENTE"));
		atributosXML.put("DESCREXPEDIENTE", elemento.getAttributeValue("DESCREXPEDIENTE"));
		
		return atributosXML;	
		
	}
	

	public static byte[] gerarXMLPublicacao(ExMovimentacao mov,
			String tipoMateria, String lotPublicacao, String descrPublicacao) throws Exception {

		ExDocumento movDoc = mov.getExDocumento();

		Map<String, String> docForm = movDoc.getForm();

		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		OutputFormat outputFormat = new OutputFormat("XML", "ISO-8859-1", false);
		outputFormat.setIndent(0);
		outputFormat.setIndenting(false);

		XMLSerializer serializer = new XMLSerializer(baos, outputFormat);

		ContentHandler handler = serializer.asContentHandler();
		handler.startDocument();
		handler.startElement("", "", "PUBLICACAODJE", null);

		AttributesImpl attIdentificacao = new AttributesImpl();

		attIdentificacao.addAttribute("", "", "TIPOARQ", "String", "A");

		attIdentificacao.addAttribute("", "", "CADERNO", "String", tipoMateria);
		
		if(movDoc.getOrgaoUsuario().getAcronimoOrgaoUsu().equals("JFRJ"))
			attIdentificacao.addAttribute("", "", "SECAO", "String", String
					.valueOf("SJRJ"));
		else if(movDoc.getOrgaoUsuario().getAcronimoOrgaoUsu().equals("JFES"))
			attIdentificacao.addAttribute("", "", "SECAO", "String", String
					.valueOf("SJES"));
		else
			attIdentificacao.addAttribute("", "", "SECAO", "String", String
				.valueOf(movDoc.getOrgaoUsuario().getAcronimoOrgaoUsu()));

//		String auxStr = obterUnidadeDocumento(mov.getExDocumento());

		attIdentificacao.addAttribute("", "", "UNIDADE", "String", lotPublicacao);

		final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		attIdentificacao.addAttribute("", "", "DATADISPONIBILIZACAO", "Date",
				df.format(mov.getDtDispPublicacao()));

		long idMod = mov.getExDocumento().getExModelo().getHisIdIni();
		if (idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR
				|| idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R_LICITACAO_CONTRATOS
				|| idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R)
			attIdentificacao.addAttribute("", "", "TIPODOC", "Integer", docForm
					.get("idTipoMateria"));
		else {
			ExTpDocPublicacao tpDocPubl = ExDao.getInstance()
					.consultarPorModelo(movDoc.getExModelo());
			attIdentificacao.addAttribute("", "", "TIPODOC", "Integer", String
					.valueOf(tpDocPubl.getIdDocPublicacao().longValue()));
		}

		String sMatricula;
		if (movDoc.getSubscritor() != null) {
			sMatricula = obterSiglaAlternativa(movDoc.getSubscritor());
		} else {
			sMatricula = obterSiglaAlternativa(movDoc.getCadastrante());
		}

		// Est� sendo acrescentado um zero no final das matr�culas dos ju�zes do
		// ES, pois a matr�cula deles s� possem 4 digitos
		// E o DJE no tribunal exigia 5 d�gitos. Em conversar com o Marcelo
		// Santos, ele sugeriu que fosse feita esta altera��o, pois eles n�o
		// teria condi��es de realiz�-la.
		if (sMatricula.length() == 6)
			sMatricula = sMatricula + "0";

		attIdentificacao.addAttribute("", "", "MATRICULAUSUARIO", "String",
				String.valueOf(sMatricula));

		handler.startElement("", "", "IDENTIFICACAO", attIdentificacao);
		handler.endElement("", "", "IDENTIFICACAO");

		AttributesImpl attsExpediente = new AttributesImpl();
		attsExpediente.addAttribute("", "", "NUMEXPEDIENTE", "String", movDoc
				.getCodigo());

		if (docForm.containsKey("tituloMateria"))
			attsExpediente.addAttribute("", "", "DESCREXPEDIENTE", "String",
					docForm.get("tituloMateria"));
		else
			attsExpediente.addAttribute("", "", "DESCREXPEDIENTE", "String",
					descrPublicacao);
		handler.startElement("", "", "EXPEDIENTE", attsExpediente);
		handler.endElement("", "", "EXPEDIENTE");
		handler.endElement("", "", "PUBLICACAODJE");
		handler.endDocument();

		byte[] retorno = baos.toByteArray();

		System.out.println("DJE envio " + mov.getExDocumento().getCodigo()
				+ ", xml gerado: " + new String(retorno));

		baos.close();

		return retorno;

	}

	private static String obterSiglaAlternativa(DpPessoa pess) {
		return (pess.getOrgaoUsuario().getIdOrgaoUsu() == 3 ? "TR" : pess
				.getOrgaoUsuario().getSigla())
				+ pess.getMatricula().toString();
	}

	public static String obterUnidadeDocumento(ExDocumento doc)
			throws Exception {
		String nomeLota, nomeLotaFinal = "";
//		ExDocumento movDoc = mov.getExDocumento();
		Map<String, String> docForm = doc.getForm();

		if ((doc.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R
				|| doc.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R_LICITACAO_CONTRATOS || doc
				.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR)
				&& docForm.get("lotOrigem_lotacaoSel.sigla") != null)
			nomeLota = docForm.get("lotOrigem_lotacaoSel.sigla");
		else {
			if (doc.getTitular() != null)
				nomeLota = doc.getLotaTitular().getSigla();
			else
				nomeLota = doc.getLotaSubscritor().getSigla();

			String funcaoLower = doc.getNmFuncaoSubscritor();
			if (funcaoLower != null) {
				funcaoLower = funcaoLower.toLowerCase();
				if (funcaoLower.contains("diretor")
						&& funcaoLower.contains("foro"))
					nomeLota = "DIRFO";
			}
		}

		nomeLotaFinal = nomeLota;

		if (doc.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R
				|| doc.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR) {
			if (docForm.get("juizDistribuidor").equals("Sim")) {
				nomeLota = "JD";
				Matcher m = Pattern.compile("^.+(-[A-Z]{2,4})").matcher(
						nomeLotaFinal);
				if (m.find())
					nomeLota += m.group(1);
			}
		}

		nomeLotaFinal = nomeLota;

		return nomeLotaFinal;
	}

	public static String obterSugestaoTipoMateria(ExDocumento doc) {
		if (doc.getExModelo().getHisIdIni() == PublicacaoDJEBL.MODELO_FORMULARIO_PUBLICACAO_DJF2R_LICITACAO_CONTRATOS)
			return "A";
		else if (doc.getExModelo().getHisIdIni() == PublicacaoDJEBL.MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR)
			return "J";
		else if (doc.getLotaSubscritor() != null
				&& doc.getLotaSubscritor().getLotacaoPai() != null
				&& doc.getLotaSubscritor().getLotacaoPai().getSigla().equals(
						"SJRJ")
				&& !doc.getLotaSubscritor().getSigla().equals("DIRFO")) {

			if (doc.getNmFuncaoSubscritor() != null
					&& doc.getNmFuncaoSubscritor().toLowerCase().contains(
							"diretor")
					&& doc.getNmFuncaoSubscritor().toLowerCase().contains(
							"foro"))
				return "'A'";
			else
				return "'J'";
		}

		return "'A'";
	}

	public static List<ExTpDocPublicacao> obterListaTiposMaterias(Long idMod) {
		List<ExTpDocPublicacao> lista = ExDao.getInstance().listarExTiposDocPublicacao();
		List<ExTpDocPublicacao> listaFinal = new ArrayList<ExTpDocPublicacao>();

		for (ExTpDocPublicacao docPubl : lista) {
			if (docPubl.getCarater() != null) {
				if ((idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR && docPubl
						.getCarater().equals("J"))
						|| (idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R_LICITACAO_CONTRATOS && docPubl
								.getCarater().equals("A"))
						|| idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R)
					listaFinal.add(docPubl);
			} else {
				if (idMod == MODELO_FORMULARIO_PUBLICACAO_DJF2R)
					listaFinal.add(docPubl);
			}
		}

		return listaFinal;
	}

	public static boolean obterObrigatoriedadeTipoCaderno(ExDocumento doc) {
		return doc.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R_LICITACAO_CONTRATOS
				|| doc.getExModelo().getHisIdIni() == MODELO_FORMULARIO_PUBLICACAO_DJF2R_VARAS_JEFS_TR;
	}

	public static void cancelarRemessaPublicacao(ExMovimentacao movCancelamento)
			throws Exception {

		ExMovimentacao mov = movCancelamento.getExMovimentacaoRef();

		DatasPublicacaoDJE datas = new DatasPublicacaoDJE(mov
				.getDtDispPublicacao());

		if (!datas.isDisponibilizacaoMaiorQueDMais1())
			throw new AplicacaoException(
					"N�o � poss�vel cancelar a remessa no dia da assinatura (data de disponibiliza��o - 1)");
		Service service = new Service();
		OperationDesc oper;

		// opera��o------------------------------------------------
		oper = new OperationDesc();
		oper.setName("ExcluirDocumento");
		oper.addParameter(new QName("http://tempuri.org/", "_strNumero"),
				new QName("http://www.w3.org/2001/XMLSchema", "string"),
				String.class, ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/", "_enmTipo"),
				new QName("http://www.w3.org/2001/XMLSchema",
						"EJudicialAdministrativo"), String.class,
				ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/", "_strUsuario"),
				new QName("http://www.w3.org/2001/XMLSchema", "string"),
				String.class, ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/", "_blnMatricula"),
				new QName("http://www.w3.org/2001/XMLSchema", "boolean"),
				Boolean.class, ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/", "_strSiglaUnidade"),
				new QName("http://www.w3.org/2001/XMLSchema", "string"),
				String.class, ParameterDesc.IN, false, false);
		oper.addParameter(new QName("http://tempuri.org/", "_enmAreaJudicial"),
				new QName("http://www.w3.org/2001/XMLSchema", "EAreaJudicial"),
				String.class, ParameterDesc.IN, false, false);

		// define o tipo de retorno
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema",
				"base64Binary"));
		oper.setReturnClass(byte[].class);
		oper.setReturnQName(new QName("http://tempuri.org/",
				"ExcluirDocumentoResult"));
		oper.setStyle(Style.WRAPPED);
		oper.setUse(Use.LITERAL);

		// call--------------------------------------------------

		Call call = (Call) service.createCall();
		call.setOperation(oper);
		call
				.setTargetEndpointAddress(new URL(SigaExProperties
						.getServidorDJE()));
		call.setOperationName(new QName("http://tempuri.org/",
				"ExcluirDocumento"));
		call.setProperty(Call.SOAPACTION_USE_PROPERTY, Boolean.TRUE);
		call.setProperty(Call.SOAPACTION_URI_PROPERTY,
				"http://tempuri.org/ExcluirDocumento");

		String siglaUnidade = mov.getLotaPublicacao();

		System.out.println("\n\n DJE exclusao "
				+ mov.getExDocumento().getCodigo()
				+ ", envio: "
				+ mov.getExDocumento().getCodigo()
				+ ", Administrativo"
				+ ", "
				+ Boolean.TRUE
				+ ", "
				+ siglaUnidade
				+ ", "
				+ movCancelamento.getLotaCadastrante().getOrgaoUsuario()
						.getAcronimoOrgaoUsu());
		
		String sAcronimoOrgaoUsu = null;
		
		if(movCancelamento.getLotaCadastrante().getOrgaoUsuario().getAcronimoOrgaoUsu().equals("JFRJ"))
			sAcronimoOrgaoUsu = "SJRJ";
		else if(movCancelamento.getLotaCadastrante().getOrgaoUsuario().getAcronimoOrgaoUsu().equals("JFES"))
			sAcronimoOrgaoUsu = "SJES";
		else
			sAcronimoOrgaoUsu = movCancelamento.getLotaCadastrante().getOrgaoUsuario().getAcronimoOrgaoUsu();

		String xmlRetorno = new String((byte[]) call.invoke((new Object[] {
				mov.getExDocumento().getCodigo(),
				"Administrativo",
				movCancelamento.getCadastrante().getSigla(),
				Boolean.TRUE,
				siglaUnidade, sAcronimoOrgaoUsu }))).substring(3);

		System.out
				.println("\n\n DJE exclusao "
						+ mov.getExDocumento().getCodigo() + ", retorno: "
						+ xmlRetorno);
		int a = 1;
		verificaRetornoErrosTRF(xmlRetorno);
	}
}
