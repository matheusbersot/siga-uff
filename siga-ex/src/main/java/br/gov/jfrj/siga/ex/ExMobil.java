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
package br.gov.jfrj.siga.ex;

import static br.gov.jfrj.siga.dp.CpMarcador.*;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.log4j.Logger;

import br.gov.jfrj.siga.dp.CpMarca;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.ex.util.CronologiaComparator;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.model.Selecionavel;
import br.gov.jfrj.siga.persistencia.ExMobilDaoFiltro;

@Entity
@Table(name = "EX_MOBIL")
public class ExMobil extends AbstractExMobil implements Serializable,
		Selecionavel, Comparable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger log = Logger.getLogger(ExMobil.class);

	/**
	 * Retorna A penï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada de um Mobil.
	 * 
	 * @return Penï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada de um Mobil.
	 * 
	 */
	public ExMovimentacao getPenultimaMovimentacaoNaoCancelada() {
		final Set<ExMovimentacao> movs = getExMovimentacaoSet();

		ExMovimentacao mov = null;
		ExMovimentacao penMov = null;
		for (final Object element : movs) {
			final ExMovimentacao movIterate = (ExMovimentacao) element;

			if (movIterate.getExTipoMovimentacao().getIdTpMov() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_DE_MOVIMENTACAO
					&& movIterate.getExMovimentacaoCanceladora() == null) {
				if (mov == null && penMov == null) {
					mov = movIterate;
				} else {
					penMov = mov;
					mov = movIterate;
				}
			}
		}
		return penMov;
	}

	/**
	 * Retorna as movimentaï¿½ï¿½es de um Mobil de acordo com um tipo especï¿½fico de
	 * movimentaï¿½ï¿½o.
	 * 
	 * @param tpMov
	 * 
	 * @return Lista de movimentaï¿½ï¿½es de um Mobil de acordo com um tipo
	 *         especï¿½fico de movimentaï¿½ï¿½o.
	 * 
	 */
	public List<ExMovimentacao> getMovimentacoesPorTipo(long tpMov) {

		final Set<ExMovimentacao> movs = getExMovimentacaoSet();
		List<ExMovimentacao> movsTp = new ArrayList<ExMovimentacao>();

		if (movs != null)
			for (final ExMovimentacao m : movs) {
				if (m.getExTipoMovimentacao().getIdTpMov().equals(tpMov))
					movsTp.add(m);
			}
		return movsTp;
	}

	/**
	 * Verifica se um Mobil ï¿½ do tipo Geral.
	 * 
	 * @return Verdadeiro se um Mobil for do tipo Geral e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isGeral() {
		/*
		 * bruno.lacerda@avantiprima.com.br - 30/07/2012 Verifica se
		 * getExTipoMobil() ï¿½ diferente de nulo antes de chamar o mï¿½todo
		 * getIdTipoMobil() do objeto
		 */
		// return getExTipoMobil().getIdTipoMobil() ==
		// ExTipoMobil.TIPO_MOBIL_GERAL;
		return getExTipoMobil() != null
				&& getExTipoMobil().getIdTipoMobil() == ExTipoMobil.TIPO_MOBIL_GERAL;
	}

	/**
	 * Verifica se um Mobil ï¿½ do tipo Via.
	 * 
	 * @return Verdadeiro se um Mobil for do tipo Via e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isVia() {
		/*
		 * bruno.lacerda@avantiprima.com.br - 30/07/2012 Verifica se
		 * getExTipoMobil() ï¿½ diferente de nulo antes de chamar o mï¿½todo
		 * getIdTipoMobil() do objeto
		 */
		// return getExTipoMobil().getIdTipoMobil() ==
		// ExTipoMobil.TIPO_MOBIL_VIA;
		return getExTipoMobil() != null
				&& getExTipoMobil().getIdTipoMobil() == ExTipoMobil.TIPO_MOBIL_VIA;
	}

	/**
	 * Verifica se um Mobil ï¿½ do tipo Volume.
	 * 
	 * @return Verdadeiro se um Mobil for do tipo Volume e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isVolume() {
		/*
		 * bruno.lacerda@avantiprima.com.br - 30/07/2012 Verifica se
		 * getExTipoMobil() ï¿½ diferente de nulo antes de chamar o mï¿½todo
		 * getIdTipoMobil() do objeto
		 */
		// return getExTipoMobil().getIdTipoMobil() ==
		// ExTipoMobil.TIPO_MOBIL_VOLUME;
		return getExTipoMobil() != null
				&& getExTipoMobil().getIdTipoMobil() == ExTipoMobil.TIPO_MOBIL_VOLUME;
	}

	/**
	 * Verifica se um Mobil ï¿½ do tipo Geral de um doc do tipo Processo.
	 * 
	 * @return Verdadeiro ou Falso.
	 * 
	 */
	public boolean isGeralDeProcesso() {
		return isGeral() && doc().isProcesso();
	}

	/**
	 * Verifica se um Mobil ï¿½ do tipo Geral de um doc do tipo Expediente.
	 * 
	 * @return Verdadeiro ou Falso.
	 * 
	 */
	public boolean isGeralDeExpediente() {
		return isGeral() && doc().isExpediente();
	}

	/**
	 * Verifica se um Mobil estï¿½ Cancelado.
	 * 
	 * @return Verdadeiro se um Mobil estï¿½ Cancelado e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isCancelada() {
		/*
		 * bruno.lacerda@avantiprima.com.br - 30/07/2012 Verifica se
		 * getExTipoMobil() ï¿½ diferente de nulo antes de chamar o mï¿½todo
		 * getIdTipoMobil() do objeto
		 */
		// return (getExTipoMobil().getIdTipoMobil() ==
		// ExTipoMobil.TIPO_MOBIL_VIA && getUltimaMovimentacaoNaoCancelada() ==
		// null);
		return getExTipoMobil() != null
				&& (getExTipoMobil().getIdTipoMobil() == ExTipoMobil.TIPO_MOBIL_VIA || getExTipoMobil()
						.getIdTipoMobil() == ExTipoMobil.TIPO_MOBIL_VOLUME)
				&& getUltimaMovimentacaoNaoCancelada() == null;
	}

	/**
	 * Retorna a descriï¿½ï¿½o do documento relacionado ao Mobil como um link em
	 * html.
	 * 
	 * @return A descriï¿½ï¿½o do documento relacionado ao Mobil como um link em
	 *         html.
	 * 
	 */
	public String getDescricao() {
		final Integer popW = 700;
		final Integer popH = 500;
		final String winleft = "(screen.width - " + popW + ") / 2";
		final String winUp = "(screen.height - " + popH + ") / 2";
		final String winProp = "'width=" + popW + ",height=" + popH
				+ ",left='+" + winleft + "+',top='+" + winUp
				+ "+',scrollbars=yes,resizable'";
		String s = "<a href=\"javascript:void(0)\" onclick=\"window.open('/sigaex/expediente/doc/exibir.action?popup=true&idmob="
				+ getIdMobil();

		String descricaoCurta = null;
		ExDocumento exDocumento = getExDocumento();

		if (exDocumento != null) {
			try {
				descricaoCurta = exDocumento.getDescrCurta();
			} catch (Exception e) {
				log.warn(
						"[getDescricao] - Nï¿½o foi possï¿½vel recuperar a descriï¿½ï¿½o curta do Documento. Retornando descriï¿½ï¿½o em branco.",
						e);
				descricaoCurta = "";
			}
		} else {
			log.warn("[getDescricao] - O Documento informado ï¿½ nulo.");
		}

		if (descricaoCurta == null) {
			descricaoCurta = "";
		}

		s = s + "', 'documento', " + winProp + ")\">" + descricaoCurta + "</a>";

		return s;
	}

	/**
	 * Retorna a sigla mais a descriï¿½ï¿½o do documento relacionado ao Mobil.
	 * 
	 * @return A sigla mais a descriï¿½ï¿½o do documento relacionado ao Mobil.
	 * 
	 */
	public String getSiglaEDescricaoCompleta() {
		return getSigla() + " - " + getDescricaoCompleta();

	}

	/**
	 * Retorna a descriï¿½ï¿½o do tipo de documento mais o cï¿½digo do documento e a
	 * descriï¿½ï¿½o do documento.
	 * 
	 * @return A descriï¿½ï¿½o do tipo de documento mais o cï¿½digo do documento e a
	 *         descriï¿½ï¿½o do documento.
	 * 
	 */
	public String getNomeCompleto() {
		String s = getExDocumento().getExFormaDocumento().getExTipoFormaDoc()
				.getDescricao()
				+ ": " + getExDocumento().getCodigoString() + ": "; // getNomeCompleto();
		s += getDescricaoCompleta();
		return s;
	}

	/**
	 * Retorna o nï¿½mero de sequï¿½ncia, a descriï¿½ï¿½o de tipo de mobil mais a
	 * descriï¿½ï¿½o do tipo de destinaï¿½ï¿½o.
	 * 
	 * @return O nï¿½mero de sequï¿½ncia, a descriï¿½ï¿½o de tipo de mobil mais a
	 *         descriï¿½ï¿½o do tipo de destinaï¿½ï¿½o.
	 */
	public String getDescricaoCompleta() {
		return getDescricaoCompleta(true);
	}

	/**
	 * Retorna o nï¿½mero de sequï¿½ncia e a descriï¿½ï¿½o de tipo de mobil
	 * 
	 * @return O nï¿½mero de sequï¿½ncia, a descriï¿½ï¿½o de tipo de mobil
	 */
	public String getDescricaoCompletaSemDestinacao() {
		return getDescricaoCompleta(false);
	}

	private String getDescricaoCompleta(boolean incluindoTpDestinacao) {
		String descTipoMobil = getExTipoMobil().getDescTipoMobil();

		if (isGeral())
			return descTipoMobil;

		if (isVia()) {
			ExVia via = getDoc().via(getNumSequencia().shortValue());
			if (via != null && via.getExTipoDestinacao() != null
					&& via.getExTipoDestinacao().getFacilitadorDest() != null) {
				descTipoMobil = via.getExTipoDestinacao().getFacilitadorDest();
			}
		}

		String s = getNumSequencia() + (isVia() ? "&ordf; " : "&ordm; ")
				+ descTipoMobil;

		if (incluindoTpDestinacao && isVia()) {
			ExVia via = getDoc().via(getNumSequencia().shortValue());
			if (via != null && via.getExTipoDestinacao() != null) {
				s += " (" + via.getExTipoDestinacao().getDescrTipoDestinacao()
						+ ")";
			}
		}

		return s;
	}

	/**
	 * Informa a sigla de um mobil.
	 * 
	 * @param sigla
	 */
	public void setSigla(String sigla) {
		sigla = sigla.trim().toUpperCase();

		Map<String, CpOrgaoUsuario> mapAcronimo = new TreeMap<String, CpOrgaoUsuario>();
		for (CpOrgaoUsuario ou : ExDao.getInstance().listarOrgaosUsuarios()) {
			mapAcronimo.put(ou.getAcronimoOrgaoUsu(), ou);
		}
		String acronimos = "";
		for (String s : mapAcronimo.keySet()) {
			acronimos += "|" + s;
		}

		final Pattern p2 = Pattern.compile("^TMP-?([0-9]{1,7})");
		final Pattern p1 = Pattern
				.compile("^([A-Za-z0-9]{2}"
						+ acronimos
						+ ")?-?([A-Za-z]{3})?-?(?:([0-9]{4})/?)??([0-9]{1,5})(\\.?[0-9]{1,3})?(?:((?:-?[a-zA-Z]{1})|(?:-[0-9]{1,2}))|((?:-?V[0-9]{1,2})))?$");
		final Pattern p3 = Pattern.compile("(23069)\\.?([0-9]{6})/?([0-9]{4})-?([0-9]{2})-?(V[0-9]{2})?");
		
		final Matcher m2 = p2.matcher(sigla);
		final Matcher m1 = p1.matcher(sigla);
		final Matcher m3 = p3.matcher(sigla);

		if (getExDocumento() == null) {
			final ExDocumento doc = new ExDocumento();
			setExDocumento(doc);
		}

		if (m2.find()) {  //DOCUMENTOS EM ELABORAÇÃO/TEMPORÁRIOS 
			if (m2.group(1) != null)
				getExDocumento().setIdDoc(new Long(m2.group(1)));
			return;
		}
		
		if (m3.find()) //PROCESSO ADMINISTRATIVO UFF
		{
			final String msgErro = "Erro na leitura do código do processo administrativo.";			
			
			final String siglaOrgaoUsuario = "UFF";
			
			if (mapAcronimo.containsKey(siglaOrgaoUsuario)) {
				getExDocumento().setOrgaoUsuario(mapAcronimo.get(siglaOrgaoUsuario));
			} else {
				CpOrgaoUsuario orgaoUsuario = new CpOrgaoUsuario();
				orgaoUsuario.setSiglaOrgaoUsu(siglaOrgaoUsuario);

				orgaoUsuario = ExDao.getInstance().consultarPorSigla(orgaoUsuario);

				getExDocumento().setOrgaoUsuario(orgaoUsuario);
			}
			
			final String siglaFormaDocumento = "ADM";
			ExFormaDocumento formaDoc = new ExFormaDocumento();
			formaDoc.setSiglaFormaDoc(siglaFormaDocumento);			
			formaDoc = ExDao.getInstance().consultarPorSigla(formaDoc);
			
			if (formaDoc != null)
				getExDocumento().setExFormaDocumento(formaDoc);
			else
				throw new Error(msgErro);
			
			if (m3.group(2) != null) 
           	 getExDocumento().setNumExpediente(Long.parseLong(m3.group(2)));
			else
				throw new Error(msgErro);

            if (m3.group(3) != null) 
           	 getExDocumento().setAnoEmissao(Long.parseLong(m3.group(3)));
            else
				throw new Error(msgErro);
            
            if (m3.group(5) != null) {
				String vsNumVolume = m3.group(5).toUpperCase();
				if (vsNumVolume.contains("-"))
					vsNumVolume = vsNumVolume.substring(vsNumVolume
							.indexOf("-") + 1);
				if (vsNumVolume.contains("V"))
					vsNumVolume = vsNumVolume.substring(vsNumVolume
							.indexOf("V") + 1);
				Integer vshNumVolume = new Integer(vsNumVolume);
				setExTipoMobil(ExDao.getInstance()
						.consultar(ExTipoMobil.TIPO_MOBIL_VOLUME,
								ExTipoMobil.class, false));
				setNumSequencia(vshNumVolume);
			} else {
				setExTipoMobil(ExDao.getInstance().consultar(
						ExTipoMobil.TIPO_MOBIL_GERAL, ExTipoMobil.class, false));
			}
             
		}

		if (m1.find()) { //OUTROS DOCUMENTOS

			if (m1.group(1) != null) {
				try {
					if (mapAcronimo.containsKey(m1.group(1))) {
						getExDocumento().setOrgaoUsuario(
								mapAcronimo.get(m1.group(1)));
					} else {
						CpOrgaoUsuario orgaoUsuario = new CpOrgaoUsuario();
						orgaoUsuario.setSiglaOrgaoUsu(m1.group(1));

						orgaoUsuario = ExDao.getInstance().consultarPorSigla(
								orgaoUsuario);

						getExDocumento().setOrgaoUsuario(orgaoUsuario);
					}
				} catch (final Exception ce) {

				}
			}

			if (m1.group(2) != null) {
				try {
					ExFormaDocumento formaDoc = new ExFormaDocumento();
					formaDoc.setSiglaFormaDoc(m1.group(2));
					formaDoc = ExDao.getInstance().consultarPorSigla(formaDoc);
					if (formaDoc != null)
						getExDocumento().setExFormaDocumento(formaDoc);
				} catch (final Exception ce) {
					throw new Error(ce);
				}
			}

			if (m1.group(3) != null)
				getExDocumento().setAnoEmissao(Long.parseLong(m1.group(3)));
			// else {
			// Date dt = new Date();
			// getExDocumento().setAnoEmissao((long) dt.getYear());
			// }
			if (m1.group(4) != null)
				getExDocumento().setNumExpediente(Long.parseLong(m1.group(4)));

			// Numero de sequencia do documento filho
			//
			if (m1.group(5) != null) {
				String vsNumSubdocumento = m1.group(5).toUpperCase();
				if (vsNumSubdocumento.contains("."))
					vsNumSubdocumento = vsNumSubdocumento
							.substring(vsNumSubdocumento.indexOf(".") + 1);
				Integer vshNumSubdocumento = new Integer(vsNumSubdocumento);
				if (vshNumSubdocumento != 0) {
					String siglaPai = (m1.group(1) == null ? (getExDocumento()
							.getOrgaoUsuario() != null ? getExDocumento()
							.getOrgaoUsuario().getAcronimoOrgaoUsu() : "") : m1
							.group(1))
							+ (m1.group(2) == null ? "" : m1.group(2))
							+ (m1.group(3) == null ? "" : m1.group(3))
							+ ((m1.group(3) != null && m1.group(4) != null) ? "/"
									: "")
							+ (m1.group(4) == null ? "" : m1.group(4));
					ExMobilDaoFiltro flt = new ExMobilDaoFiltro();
					flt.setSigla(siglaPai);
					ExMobil mobPai = null;
					try {
						mobPai = ExDao.getInstance().consultarPorSigla(flt);
					} catch (Exception e) {
						e.printStackTrace();
					}
					ExDocumento docFilho = mobPai.doc().getMobilGeral()
							.getSubdocumento(vshNumSubdocumento);
					setExDocumento(docFilho);
				}
			}

			// Numero da via
			//
			if (m1.group(6) != null) {
				String vsNumVia = m1.group(6).toUpperCase();
				if (vsNumVia.contains("-"))
					vsNumVia = vsNumVia.substring(vsNumVia.indexOf("-") + 1);
				Integer vshNumVia;
				final String alfabeto = "ABCDEFGHIJLMNOPQRSTUZ";
				final int vi = (alfabeto.indexOf(vsNumVia)) + 1;
				if (vi <= 0)
					vshNumVia = new Integer(vsNumVia);
				else {
					vshNumVia = (new Integer(vi).intValue());
					setExTipoMobil(ExDao.getInstance().consultar(
							ExTipoMobil.TIPO_MOBIL_VIA, ExTipoMobil.class,
							false));
				}
				setNumSequencia(vshNumVia);
			} else if (m1.group(7) != null) {
				String vsNumVolume = m1.group(7).toUpperCase();
				if (vsNumVolume.contains("-"))
					vsNumVolume = vsNumVolume.substring(vsNumVolume
							.indexOf("-") + 1);
				if (vsNumVolume.contains("V"))
					vsNumVolume = vsNumVolume.substring(vsNumVolume
							.indexOf("V") + 1);
				Integer vshNumVolume = new Integer(vsNumVolume);
				setExTipoMobil(ExDao.getInstance()
						.consultar(ExTipoMobil.TIPO_MOBIL_VOLUME,
								ExTipoMobil.class, false));
				setNumSequencia(vshNumVolume);
			} else {
				setExTipoMobil(ExDao.getInstance().consultar(
						ExTipoMobil.TIPO_MOBIL_GERAL, ExTipoMobil.class, false));
			}
		}
	}

	/**
	 * Retorna o cï¿½digo do documento mais o nï¿½mero da via ou do volume.
	 * 
	 * @return O cï¿½digo do documento mais o nï¿½mero da via ou do volume.
	 */
	public String getSigla() {
		if (getExDocumento() == null)
			return null;
		if (getExTipoMobil() == null)
			return null;
		if ((isVia() || isVolume())
				&& (getNumSequencia() == null || getNumSequencia() == 0))
			throw new Error(
					"Via e Volume devem possuir nï¿½mero vï¿½lido de sequencia.");
		String terminacao = getTerminacaoSigla();
		return getExDocumento().getSigla() + (terminacao.equals("") ? "" : "-") + getTerminacaoSigla();
	}
	
	/**
	 * Retorna o cï¿½digo do documento resumido mais o nï¿½mero da via ou do volume.
	 * 
	 * @return O cï¿½digo do documento resumido mais o nï¿½mero da via ou do volume.
	 */
	public String getSiglaResumida(CpOrgaoUsuario orgao, ExDocumento docRef){
		if (getExDocumento() == null)
			return null;
		if (getExTipoMobil() == null)
			return null;
		if ((isVia() || isVolume())
				&& (getNumSequencia() == null || getNumSequencia() == 0))
			throw new Error(
					"Via e Volume devem possuir nï¿½mero vï¿½lido de sequencia.");
		String codigoDoc = getExDocumento().getCodigoResumido(orgao, docRef);
		String terminacao = getTerminacaoSigla();
		return codigoDoc + (terminacao.equals("") || codigoDoc.equals("") ? "" : "-") + getTerminacaoSigla();
	}

	/**
	 * Retorna o cï¿½digo do documento mais o nï¿½mero da via ou do volume.
	 * 
	 * @return O cï¿½digo do documento mais o nï¿½mero da via ou do volume.
	 */
	public static String getSigla(String codigoDocumento, Integer numSequencia,
			Long idTipoMobil) {
		if (codigoDocumento == null)
			return null;
		if (idTipoMobil == null)
			return null;

		if ((idTipoMobil == ExTipoMobil.TIPO_MOBIL_VIA || idTipoMobil == ExTipoMobil.TIPO_MOBIL_VOLUME)
				&& (numSequencia == null || numSequencia == 0))
			throw new Error(
					"Via e Volume devem possuir nï¿½mero vï¿½lido de sequencia.");
		if (idTipoMobil == ExTipoMobil.TIPO_MOBIL_VIA) {
			final String alfabeto = "ABCDEFGHIJLMNOPQRSTUZ";

			// as vias vï¿½o atï¿½ a letra 'U', se passar disso, assume letra 'Z'
			if (numSequencia <= 20) {
				final String vsNumVia = alfabeto.substring(numSequencia - 1,
						numSequencia);
				return codigoDocumento + "-" + vsNumVia;
			} else {
				final String vsNumVia = "Z";
				return codigoDocumento + "-" + vsNumVia;
			}
		} else if (idTipoMobil == ExTipoMobil.TIPO_MOBIL_VOLUME) {
			final String vsNumVolume = "V"
					+ (numSequencia < 10 ? "0" + numSequencia : numSequencia);
			return codigoDocumento + "-" + vsNumVolume;
		} else {
			return codigoDocumento;
		}
	}

	/*
	 * public Long getId() { if (getExDocumento() == null) return null;
	 * ExMovimentacao mov = getExDocumento()
	 * .getUltimaMovimentacaoNaoCancelada(getNumVia()); if (mov == null) return
	 * null; return mov.getIdMov(); }
	 */

	/**
	 * Se esse documento estiver juntado, retorna o pai Senï¿½o, retorna null
	 * 
	 */
	public ExMobil getMobilPrincipal() {

		if (getExMobilPai() == null)
			return this;

		return getExMobilPai().getMobilPrincipal();
	}

	/**
	 * Retorna a sigla sem os sinais "-" e "/".
	 * 
	 * @return A sigla sem os sinais "-" e "/".
	 * 
	 */
	public String getCodigoCompacto() {
		String s = getSigla();
		if (s == null)
			return null;
		return s.replace("-", "").replace("/", "");
	}

	/**
	 * Retorna a sigla.
	 * 
	 * @return A sigla.
	 * 
	 */
	public Object getCodigo() {
		return getSigla();
	}

	/**
	 * Retorna o documento relacionado ao Mobil.
	 * 
	 * @return O documento relacionado ao Mobil.
	 * 
	 */
	public ExDocumento doc() {
		return getExDocumento();
	}

	/**
	 * 
	 * 
	 * 
	 * Retorna se o mï¿½bil recebeu alguma movimentaï¿½ï¿½o do tipo informado que nï¿½o
	 * tenha sido cancelada.
	 * 
	 * @param tpMov
	 * @return
	 */
	public boolean sofreuMov(long tpMov) {

		return sofreuMov(tpMov, 0);
	}

	/**
	 * Retorna se o mï¿½bil recebeu alguma movimentaï¿½ï¿½o do tipo informado que nï¿½o
	 * tenha sido cancelada e tambï¿½m nï¿½o tenha sido revertida pela movimentaï¿½ï¿½o
	 * de reversï¿½o do tipo informado.
	 * 
	 * @param tpMov
	 * @param tpMovReversao
	 * @return
	 */
	public boolean sofreuMov(long tpMov, long tpMovReversao) {
		return sofreuMov(tpMov, tpMovReversao, this);
	}

	/**
	 * 
	 * Retorna se um mï¿½bil mob recebeu alguma movimentaï¿½ï¿½o do tipo informado que
	 * nï¿½o tenha sido cancelada e tambï¿½m nï¿½o tenha sido revertida pela
	 * movimentaï¿½ï¿½o de reversï¿½o do tipo informado.
	 * 
	 * @param tpMov
	 * @param tpMovReversao
	 * @return
	 */

	public boolean sofreuMov(long tpMov, long tpMovReversao, ExMobil mob) {
		return sofreuMov(new long[] { tpMov }, new long[] { tpMovReversao },
				mob);
	}

	/**
	 * Retorna se o mï¿½bil recebeu alguma movimentaï¿½ï¿½o de um dos tipos informados
	 * que nï¿½o tenha sido cancelada e tambï¿½m nï¿½o tenha sido revertida pela
	 * movimentaï¿½ï¿½o de reversï¿½o do tipo informado.
	 * 
	 * @param tpMovs
	 * @param tpMovReversao
	 * @return
	 */
	public boolean sofreuMov(long[] tpMovs, long tpMovReversao) {
		return sofreuMov(tpMovs, new long[] { tpMovReversao }, this);
	}

	/**
	 * Retorna se um mï¿½bil mob recebeu alguma movimentaï¿½ï¿½o de um dos tipos
	 * informados que nï¿½o tenha sido cancelada e tambï¿½m nï¿½o tenha sido revertida
	 * pela movimentaï¿½ï¿½o de reversï¿½o do tipo informado.
	 * 
	 * @param tpMovs
	 * @param tpMovReversao
	 * @param mob
	 * @return
	 */
	public boolean sofreuMov(long[] tpMovs, long[] tpMovReversao, ExMobil mob) {
		return getUltimaMovimentacao(tpMovs, tpMovReversao, mob, false, null) != null;
	}

	/**
	 * Retorna a ï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada que o mï¿½bil recebeu.
	 * 
	 * @return
	 */
	public ExMovimentacao getUltimaMovimentacaoNaoCancelada() {
		return getUltimaMovimentacaoNaoCancelada(0L);
	}

	/**
	 * Retorna a ï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada de um tipo especï¿½fico que o
	 * mï¿½bil recebeu.
	 * 
	 * @param tpMov
	 * @return
	 */
	public ExMovimentacao getUltimaMovimentacaoNaoCancelada(long tpMov) {
		return getUltimaMovimentacaoNaoCancelada(tpMov, 0L);
	}

	/**
	 * Retorna a ï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada de um tipo especï¿½fico que o
	 * mï¿½bil recebeu e que nï¿½o tenha sido revertida pela movimentaï¿½ï¿½o de
	 * reversï¿½o do tipo especificado.
	 * 
	 * @param tpMov
	 * @param tpMovReversao
	 * @return
	 */
	public ExMovimentacao getUltimaMovimentacaoNaoCancelada(long tpMov,
			long tpMovReversao) {
		return getUltimaMovimentacao(new long[] { tpMov },
				new long[] { tpMovReversao }, this, false, null);
	}

	/**
	 * Retorna a ï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada que o mï¿½bil recebeu, com base
	 * nas informaï¿½ï¿½es constantes na movimentaï¿½ï¿½o informada como parï¿½metro.
	 * 
	 * @param movParam
	 * @return
	 */
	public ExMovimentacao getUltimaMovimentacaoNaoCancelada(
			ExMovimentacao movParam) {
		return getUltimaMovimentacao(new long[] { movParam
				.getExTipoMovimentacao().getIdTpMov() }, new long[] { 0L },
				this, false, movParam.getDtMov());
	}

	/**
	 * Retorna A ï¿½ltima movimentaï¿½ï¿½o de um Mobil.
	 * 
	 * @return ï¿½ltima movimentaï¿½ï¿½o de um Mobil.
	 * 
	 */
	public ExMovimentacao getUltimaMovimentacao() {
		return getUltimaMovimentacao(0L);
	}

	/**
	 * Retorna a ï¿½ltima movimentaï¿½ï¿½o de um tipo especï¿½fico que o mï¿½bil recebeu.
	 * 
	 * @param tpMov
	 * @return
	 */
	public ExMovimentacao getUltimaMovimentacao(long tpMov) {
		return getUltimaMovimentacao(new long[] { tpMov }, new long[] { 0L },
				this, true, null);
	}

	/**
	 * Retorna a ï¿½ltima movimentaï¿½ï¿½o (cancelada ou nï¿½o, conforme o parï¿½metro
	 * permitirCancelada) que o mï¿½bil mob recebeu e que seja de um dos tpMovs
	 * informados, que nï¿½o tenha sido revertida por uma movimentaï¿½ï¿½o do
	 * tpMovReversao e que tenha ocorrido na data dt
	 * 
	 * @param tpMovs
	 * @param tpMovReversao
	 * @param mob
	 * @param permitirCancelada
	 * @param dt
	 * @return
	 */
	public ExMovimentacao getUltimaMovimentacao(long[] tpMovs,
			long[] tpMovsReversao, ExMobil mob, boolean permitirCancelada,
			Date dt) {

		if (mob == null)
			return null;

		Set<ExMovimentacao> movSet = mob.getExMovimentacaoSet();
		if (movSet == null || movSet.size() == 0)
			return null;

		ExMovimentacao movReturn = null;
		for (ExMovimentacao mov : movSet) {
			if (!permitirCancelada
					&& (mov.isCancelada() || mov.isCanceladora()))
				continue;

			if (tpMovs.length == 0 || tpMovs[0] == 0L)
				movReturn = mov;
			else
				for (long t : tpMovs)
					if (mov.getExTipoMovimentacao().getIdTpMov() == t)

						if (dt == null
								|| (dt != null && mov.getDtMov().equals(dt))) {
							movReturn = mov;
							break;
						}

			for (long t : tpMovsReversao)
				if (mov.getExTipoMovimentacao().getIdTpMov() == t) {
					movReturn = null;
					break;
				}
		}
		return movReturn;
	}

	/**
	 * Verifica se o mobil estï¿½ arquivado corrente
	 */
	public boolean isArquivadoCorrente() {
		return sofreuMov(
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_CORRENTE,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESARQUIVAMENTO_CORRENTE,
				getMobilParaMovimentarDestinacao());
	}

	/**
	 * Verifica se o mobil estï¿½ arquivado permanente
	 */
	public boolean isArquivadoPermanente() {
		return sofreuMov(
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_PERMANENTE,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESARQUIVAMENTO_CORRENTE,
				getMobilParaMovimentarDestinacao());
	}

	/**
	 * Verifica se o mobil estï¿½ arquivado intermediï¿½rio
	 */
	public boolean isArquivadoIntermediario() {
		return sofreuMov(
				new long[] { ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_INTERMEDIARIO },
				new long[] {
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESARQUIVAMENTO_CORRENTE,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESARQUIVAMENTO_INTERMEDIARIO },
				getMobilParaMovimentarDestinacao());
	}

	/**
	 * Verifica se o mobil estï¿½ em arquivo, seja corrente, intermediï¿½rio ou
	 * permanente
	 */
	public boolean isArquivado() {
		return isArquivadoCorrente() || isArquivadoIntermediario()
				|| isArquivadoPermanente();
	}

	/**
	 * Verifica se o mobil estï¿½ sobrestado
	 */
	public boolean isSobrestado() {
		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_SOBRESTAR,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESOBRESTAR);
	}

	/**
	 * Verifica se um Mobil estï¿½ em trï¿½nsito. Um Mobil estï¿½ em trï¿½nsito quando
	 * ele possui movimentaï¿½ï¿½es nï¿½o canceladas dos tipos: TRANSFERENCIA,
	 * DESPACHO_TRANSFERENCIA, DESPACHO_TRANSFERENCIA_EXTERNA ou
	 * TRANSFERENCIA_EXTERNA e nï¿½o possuem movimentaï¿½ï¿½o de recebimento.
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ em trï¿½nsito e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isEmTransito() {

		return sofreuMov(
				new long[] {
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA },

				ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO);

	}

	/**
	 * Verifica se um Mobil recebeu movimentaï¿½ï¿½o de inclusï¿½o em edital de
	 * eliminaï¿½ï¿½o, nï¿½o revertida pela de retirada de edital de eliminaï¿½ï¿½o.
	 * 
	 * @return Verdadeiro ou Falso
	 */
	public boolean isEmEditalEliminacao() {
		return !isEliminado()
				&& sofreuMov(
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_EM_EDITAL_DE_ELIMINACAO,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_RETIRADA_DE_EDITAL_DE_ELIMINACAO,
						getMobilParaMovimentarDestinacao());
	}

	/**
	 * Retorna se o mï¿½bil sofreu movimentaï¿½ï¿½o de eliminaï¿½ï¿½o.
	 * 
	 * @return
	 */
	public boolean isEliminado() {

		//Edson: prejudicando performance, devido aos lugares em que ï¿½ chamado
		//Ver jeito melhor de verificar se estï¿½ eliminado
		return false;
		/*
		if (isGeral() && doc().isExpediente())
			return doc().isEliminado();

		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ELIMINACAO, 0,
				getMobilParaMovimentarDestinacao());*/
	}

	/**
	 * Verifica se um Mobil recebeu movimentaï¿½ï¿½o de indicaï¿½ï¿½o para guarda
	 * permanente. Se o mï¿½bil for um volume, considera o geral do processo.
	 * 
	 * @return Verdadeiro ou Falso
	 */
	public boolean isindicadoGuardaPermanente() {
		return sofreuMov(
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_INDICACAO_GUARDA_PERMANENTE,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_REVERSAO_INDICACAO_GUARDA_PERMANENTE,
				getMobilParaMovimentarDestinacao());
	}

	/**
	 * Verifica se um Mobil estï¿½ em trï¿½nsito interno. Um Mobil estï¿½ em trï¿½nsito
	 * interno quando ele possui movimentaï¿½ï¿½es nï¿½o canceladas dos tipos:
	 * TRANSFERENCIA ou DESPACHO_TRANSFERENCIA e nï¿½o possuem movimentaï¿½ï¿½o de
	 * recebimento.
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ em trï¿½nsito interno e Falso caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean isEmTransitoInterno() {

		return sofreuMov(new long[] {
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA },

		ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO);

	}

	/**
	 * Verifica se um Mobil estï¿½ em trï¿½nsito externo. Um Mobil estï¿½ em trï¿½nsito
	 * externo quando ele possui movimentaï¿½ï¿½es nï¿½o canceladas dos tipos:
	 * DESPACHO_TRANSFERENCIA_EXTERNA ou TRANSFERENCIA_EXTERNA e nï¿½o possuem
	 * movimentaï¿½ï¿½o de recebimento.
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ em trï¿½nsito externo e Falso caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean isEmTransitoExterno() {

		return sofreuMov(
				new long[] {
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA,

						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA },

				ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO);

	}

	/**
	 * Verifica se um Mobil estï¿½ juntado a outro. Um Mobil estï¿½ em juntado a
	 * outro quando ele possui movimentaï¿½ï¿½es nï¿½o canceladas dos tipos: JUNTADA
	 * ou JUNTADA_EXTERNO e nï¿½o possuem movimentaï¿½ï¿½o de cancelamento de juntada.
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ juntado a outro e Falso caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean isJuntado() {

		return sofreuMov(new long[] {
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA_EXTERNO },

		ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA);

	}

	public boolean isPendenteDeAnexacao() {
		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_PENDENCIA_DE_ANEXACAO);
	}

	/**
	 * Verifica se um Mobil estï¿½ juntado a outro mobil do tipo interno. Um Mobil
	 * estï¿½ em juntado a outro mobil do tipo interno quando ele possui
	 * movimentaï¿½ao nï¿½o cancelada do tipo: JUNTADA e nï¿½o possue movimentaï¿½ï¿½o de
	 * cancelamento de juntada.
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ juntado a outro mobil do tipo interno
	 *         e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isJuntadoInterno() {

		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA,

		ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA);

	}

	/**
	 * Verifica se um Mobil estï¿½ juntado a outro mobil do tipo externo. Um Mobil
	 * estï¿½ em juntado a outro mobil do tipo externo quando ele possui
	 * movimentaï¿½ao nï¿½o cancelada do tipo: JUNTADA_EXTERNO e nï¿½o possue
	 * movimentaï¿½ï¿½o de cancelamento de juntada.
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ juntado a outro mobil do tipo externo
	 *         e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isJuntadoExterno() {

		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA_EXTERNO,

		ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA);

	}

	/**
	 * Verifica se um Mobil estï¿½ apensado a outro mobil. Um Mobil estï¿½ apensado
	 * a outro mobil quando ele possui movimentaï¿½ao do tipo: APENSACAO e nï¿½o
	 * possue movimentaï¿½ï¿½o de desapensaï¿½ï¿½o
	 * 
	 * @return Verdadeiro se o Mobil estï¿½ apensado a outro mobil e Falso caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean isApensado() {

		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_APENSACAO,

		ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESAPENSACAO);

	}

	/**
	 * Retorna o Mobil pai do Mobil atual.
	 * 
	 * @return Mobil pai do Mobil atual.
	 * 
	 */
	public ExMobil getExMobilPai() {
		ExMobil m = null;
		for (ExMovimentacao mov : getExMovimentacaoSet()) {
			if (mov.isCancelada())
				continue;
			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA)
				m = mov.getExMobilRef();
			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA)
				m = null;
		}
		return m;
	}

	public ExMovimentacao anexoPendente(final String descrMov,
			final boolean fIncluirCancelados) {
		if (getExMovimentacaoSet() == null)
			return null;

		ExMobil m = null;
		for (ExMovimentacao mov : getExMovimentacaoSet()) {
			if ((!fIncluirCancelados) && mov.isCancelada())
				continue;
			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_PENDENCIA_DE_ANEXACAO) {
				if (descrMov == null) {
					return mov;
				}
				if (descrMov.equals(mov.getDescrMov()))
					return mov;
			}
		}
		return null;
	}

	public Long getId() {
		return getIdMobil();
	}

	/**
	 * Retorna a descriï¿½ï¿½o da ï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada.
	 * 
	 * @return Descriï¿½ï¿½o da ï¿½ltima movimentaï¿½ï¿½o nï¿½o cancelada.
	 * 
	 */
	public String getDescricaoUltimaMovimentacaoNaoCancelada() {
		ExMovimentacao mov = getUltimaMovimentacaoNaoCancelada();
		if (mov == null)
			return null;
		return mov.getExTipoMovimentacao().getDescricao();
	}

	/**
	 * Retorna o documento relacionado ao Mobil atual.
	 * 
	 * @return Documento relacionado ao Mobil atual.
	 * 
	 */
	public ExDocumento getDoc() {
		return doc();
	}

	public java.util.Set<ExMovimentacao> getCronologiaSet() {
		final TreeSet<ExMovimentacao> set = new TreeSet<ExMovimentacao>(
				new CronologiaComparator());
		set.addAll(getExMovimentacaoSet());
		set.addAll(getExMovimentacaoReferenciaSet());
		return set;
	}

	public int compareTo(Object o) {
		if (this == o)
			return 0;
		ExMobil other = (ExMobil) o;
		int i;
		i = other.getExDocumento().getIdDoc()
				.compareTo(getExDocumento().getIdDoc());
		if (i != 0)
			return -i;
		i = other.getExTipoMobil().getIdTipoMobil()
				.compareTo(getExTipoMobil().getIdTipoMobil());
		if (i != 0)
			return i;
		return getNumSequencia().compareTo(other.getNumSequencia());
	}

	public List<ExArquivoNumerado> getArquivosNumerados() {
		return getExDocumento().getArquivosNumerados(this);
	}

	/**
	 * Retorna a descriï¿½ï¿½o dos marcadores relacionado ao Mobil atual.
	 * 
	 * @return Descriï¿½ï¿½o dos marcadores relacionado ao Mobil atual.
	 * 
	 */
	public String getMarcadores() {
		StringBuilder sb = new StringBuilder();
		for (ExMarca mar : getExMarcaSetAtivas()) {
			if (sb.length() > 0)
				sb.append(", ");
			sb.append(mar.getCpMarcador().getDescrMarcador());
		}
		if (sb.length() == 0)
			return null;
		return sb.toString();
	}

	/**
	 * Retorna a descriï¿½ï¿½o completa (descriï¿½ï¿½o, lotaï¿½ï¿½o, pessoa e datas de
	 * inï¿½cio e fim) dos marcadores relacionados ao Mobil atual, incluindo os
	 * nï¿½o ativos no momento.
	 * 
	 * @return Descriï¿½ï¿½o dos marcadores relacionado ao Mobil atual.
	 * 
	 */
	public String getMarcadoresDescrCompleta(boolean apenasTemporalidade) {
		StringBuilder marcas = new StringBuilder();

		Set<ExMarca> set = apenasTemporalidade ? getExMarcaSetTemporalidade()
				: getExMarcaSet();
		for (CpMarca mar : set) {
			marcas.append(mar.getCpMarcador().getDescrMarcador());
			marcas.append(" [");
			marcas.append(mar.getDpPessoaIni() != null ? mar.getDpPessoaIni()

			.getSigla() : "");
			marcas.append(", ");

			marcas.append(mar.getDpLotacaoIni() != null ? mar.getDpLotacaoIni()

			.getSiglaLotacao() : "");
			marcas.append(", ");
			marcas.append(mar.getDtIniMarcaDDMMYYYY());
			marcas.append(", ");

			marcas.append(mar.getDtFimMarcaDDMMYYYY());

			marcas.append("] ");

		}
		return marcas.toString();

	}
	
	/**
	 * Retorna o Mobil Mestre relacionado ao Mobil atual.
	 * 
	 * @return Mobil Mestre relacionado ao Mobil atual.
	 * 
	 */
	public ExMobil getMestre() {
		ExMobil m = null;
		for (ExMovimentacao mov : getExMovimentacaoSet()) {
			if (mov.isCancelada())
				continue;
			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_APENSACAO)
				m = mov.getExMobilRef();
			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESAPENSACAO)
				m = null;
		}
		return m;
	}

	/**
	 * Se o mobil em questï¿½o for o grande mestre de uma cadeia de apensaï¿½ï¿½o, ele
	 * deve retornar "this".
	 * 
	 * @return Retorna o mestre de ï¿½ltimo nivel, ou seja, o mestre de todos os
	 *         mestres dessa apensacao.
	 */
	public ExMobil getGrandeMestre() {
		ExMobil m = getMestre();
		if (m == null) {
			if (getApensos().size() != 0)
				return this;
		}
		while (m != null) {
			ExMobil m2 = m.getMestre();
			if (m2 == null)
				return m;
			else
				m = m2;
		}
		return null;
	}

	/**
	 * 
	 * @return Retorna todos os apensos desse mobil para baixo. Nï¿½o inclui o
	 *         prï¿½prio mobil que estï¿½ sendo chamado.
	 */
	public SortedSet<ExMobil> getApensos() {
		return getApensos(false, false);
	}

	public SortedSet<ExMobil> getApensosDiretosExcetoVolumeApensadoAoProximo() {
		return getApensos(true, true);
	}

	public SortedSet<ExMobil> getApensos(boolean omitirApensosIndiretos,
			boolean omitirVolumesApensadosAosProximos) {
		SortedSet<ExMobil> set = new TreeSet<ExMobil>();
		return getApensos(set, omitirApensosIndiretos,
				omitirVolumesApensadosAosProximos);
	}

	public SortedSet<ExMobil> getApensos(SortedSet<ExMobil> set,
			boolean omitirApensosIndiretos,
			boolean omitirVolumesApensadosAosProximos) {
		for (ExMovimentacao mov : getExMovimentacaoReferenciaSet()) {
			if (!ExTipoMovimentacao.hasApensacao(mov.getIdTpMov()))
				continue;
			ExMobil mobMestre = mov.getExMobil().getMestre();
			if (this.equals(mobMestre)) {
				if (!set.contains(mov.getExMobil())) {
					if (!omitirVolumesApensadosAosProximos
							|| !mov.getExMobil().isVolumeApensadoAoProximo())
						set.add(mov.getExMobil());
					if (!omitirApensosIndiretos)
						mov.getExMobil().getApensos(set,
								omitirApensosIndiretos,
								omitirVolumesApensadosAosProximos);
				}
			}
		}
		return set;
	}

	/**
	 * Retorna, num Set, os mï¿½biles que tenham sido juntados a este mï¿½bil, de
	 * modo recursivo ou nï¿½o, conforme parï¿½metro.
	 * 
	 * @param recursivo
	 * @return
	 */
	public Set<ExMobil> getJuntados(boolean recursivo) {
		Set<ExMobil> set = new LinkedHashSet<ExMobil>();
		for (ExMovimentacao mov : getExMovimentacaoReferenciaSet())
			if (!mov.isCancelada()) {
				if (mov.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA)
					set.add(mov.getExMobil());
				if (mov.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA)
					set.remove(mov.getExMobil());
			}
		if (!recursivo)
			return set;
		else {
			Set<ExMobil> setRecursivo = new LinkedHashSet<ExMobil>();
			for (ExMobil mob : set) {
				setRecursivo.add(mob);
				setRecursivo.addAll(mob.getJuntadosRecursivo());
			}
			return setRecursivo;
		}

	}
	
	/**
	 * Retorna, num Set, os mï¿½biles que tenham sido referenciados a este mï¿½bil
	 * ou vice-versa.
	 * 
	 * @param recursivo
	 * @return
	 */
	public Set<ExMobil> getVinculados() {
		Set<ExMobil> set = new LinkedHashSet<ExMobil>();
		for (ExMovimentacao mov : getCronologiaSet())
			if (!mov.isCancelada()) {
				if (mov.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REFERENCIA){
					set.add(mov.getExMobilRef());
					set.add(mov.getExMobil());
				}
			}
		set.remove(this);
		if (!isGeral())
			set.addAll(doc().getMobilGeral().getVinculados());
		return set;
	}

	/**
	 * Retorna os mï¿½biles que tenham sido juntados a este mï¿½bil, sem
	 * recursividade.
	 * 
	 * @return
	 */
	public Set<ExMobil> getJuntados() {
		return getJuntados(false);
	}

	/**
	 * Retorna todos os mï¿½biles, de modo recursivo, que tenham sido juntados a
	 * este mï¿½bil.
	 * 
	 * @return
	 */
	public Set<ExMobil> getJuntadosRecursivo() {
		return getJuntados(true);
	}

	/**
	 * Retorna um Set contendo este mï¿½bil e todos os que foram juntados a ele,
	 * de modo recursivo.
	 * 
	 * @return
	 */
	public SortedSet<ExMobil> getMobilETodosOsJuntados() {
		TreeSet<ExMobil> setFinal = new TreeSet<ExMobil>();
		setFinal.add(this);
		setFinal.addAll(getJuntadosRecursivo());
		return setFinal;

	}

	@Override
	public String toString() {
		return getSigla();
	}

	@Override
	public boolean equals(Object obj) {
		if (this.getIdMobil() == null)
			return super.equals(obj);
		ExMobil other = (ExMobil) obj;
		if (other == null || other.getIdMobil() == null)
			return false;
		return this.getIdMobil().equals(other.getIdMobil());
	}

	public SortedSet<ExMobil> getMobilETodosOsApensos() {
		return getMobilETodosOsApensos(false);
	}

	public SortedSet<ExMobil> getMobilETodosOsApensos(
			boolean fOmitirVolumesApensadosAosProximos) {
		SortedSet<ExMobil> set = new TreeSet<ExMobil>();
		ExMobil mobGrandeMestre = getGrandeMestre();
		if (mobGrandeMestre != null) {
			set.add(mobGrandeMestre);
			mobGrandeMestre.getApensos(set, false,
					fOmitirVolumesApensadosAosProximos);
		} else {
			set.add(this);
		}
		return set;
	}

	/**
	 * Verifica se um volume estï¿½ encerrado. Um volume estï¿½ encerrado se ele
	 * possui movimentaï¿½ï¿½o nï¿½o cancelada do tipo ENCERRAMENTO DE VOLUME.
	 * 
	 * @return Verdadeiro se o volume estï¿½ encerrado e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isVolumeEncerrado() {
		return sofreuMov(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ENCERRAMENTO_DE_VOLUME);
	}

	/**
	 * Verifica se um Mobil do tipo Volume estï¿½ Apensado ao prï¿½ximo Mobil. Para
	 * saber o prï¿½ximo Mobil ï¿½ utilizado o nï¿½mero de sequï¿½ncia do Mobil.
	 * 
	 * @return Verdadeiro se o Mobil estiver apensado ao prï¿½ximo volume e Falso
	 *         caso contrï¿½rio.
	 * 
	 */
	public boolean isVolumeApensadoAoProximo() {
		if (getMestre() == null)
			return false;
		if (!isVolume())
			return false;
		if (!getMestre().isVolume())
			return false;
		if (!getNumSequencia().equals(getMestre().getNumSequencia() - 1))
			return false;
		if (!getMestre().doc().getIdDoc().equals(doc().getIdDoc()))
			return false;
		return true;
	}

	/**
	 * Retorna a lista de movimentaï¿½ï¿½es de anexaï¿½ï¿½o nï¿½o assinadas
	 * 
	 * @return Verdadeiro se o Mobil possui anexos nï¿½o assinados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public List<ExMovimentacao> getAnexosNaoAssinados() {

		List<ExMovimentacao> naoAssinados = new ArrayList<ExMovimentacao>();
		Date dataDeInicioDeObrigacaoDeAssinatura = null;

		try {

			dataDeInicioDeObrigacaoDeAssinatura = SigaExProperties
					.getDataInicioObrigacaoDeAssinarAnexoEDespacho();
		} catch (Exception e) {

		}

		for (ExMovimentacao mov : this.getExMovimentacaoSet()) {
			if (!mov.isCancelada()) {
				if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO)
					if (mov.isAssinada())
						continue;
					else {
						if (dataDeInicioDeObrigacaoDeAssinatura != null
								&& mov.getDtMov().before(
										dataDeInicioDeObrigacaoDeAssinatura))
							continue;
						naoAssinados.add(mov);
					}
			}
		}
		return naoAssinados;
	}
	
	/**
	 * Retorna a lista de movimentaï¿½ï¿½es de pendï¿½ncia anexaï¿½ï¿½o
	 * 
	 * @return Verdadeiro se o Mobil possui pendï¿½ncia de anexos e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public List<ExMovimentacao> getPendenciasDeAnexacao() {

		List<ExMovimentacao> pendenciasDeAnexacao = new ArrayList<ExMovimentacao>();

		for (ExMovimentacao mov : this.getExMovimentacaoSet()) {
			if (!mov.isCancelada() && mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_PENDENCIA_DE_ANEXACAO)
				pendenciasDeAnexacao.add(mov);
		}

		return pendenciasDeAnexacao;
	}
	
	/**
	 * Verifica se um Mobil possui Pendï¿½ncias de Anexaï¿½ï¿½o
	 * 
	 * @return Verdadeiro se o Mobil possui pendï¿½ncias de anexos e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean temPendenciasDeAnexacao() {
		return getPendenciasDeAnexacao().size() > 0;
	}

	/**
	 * Verifica se um Mobil possui Anexos Pendentes de Assinatura
	 * 
	 * @return Verdadeiro se o Mobil possui anexos nï¿½o assinados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean temAnexosNaoAssinados() {
		return getAnexosNaoAssinados().size() > 0;
	}

	/**
	 * Retorna a lista de despachos nï¿½o assinados
	 * 
	 * @return Verdadeiro se o Mobil possui anexos nï¿½o assinados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public List<ExMovimentacao> getDespachosNaoAssinados() {
		List<ExMovimentacao> naoAssinados = new ArrayList<ExMovimentacao>();
		Date dataDeInicioDeObrigacaoDeAssinatura = null;

		try {
			dataDeInicioDeObrigacaoDeAssinatura = SigaExProperties
					.getDataInicioObrigacaoDeAssinarAnexoEDespacho();
		} catch (Exception e) {

		}
		for (ExMovimentacao mov : this.getExMovimentacaoSet()) {
			if (!mov.isCancelada()) {
				if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO
						|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO
						|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA
						|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA
						|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA)
					if (mov.isAssinada())
						continue;
					else {
						if (dataDeInicioDeObrigacaoDeAssinatura != null
								&& mov.getDtMov().before(
										dataDeInicioDeObrigacaoDeAssinatura))
							continue;
						naoAssinados.add(mov);
					}
			}
		}
		return naoAssinados;
	}

	/**
	 * Verifica se um Mobil possui Anexos Pendentes de Assinatura
	 * 
	 * @return Verdadeiro se o Mobil possui anexos nï¿½o assinados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean temDespachosNaoAssinados() {
		return getDespachosNaoAssinados().size() > 0;
	}

	/**
	 * Retorna a lista de expedientes filhos nï¿½o juntados
	 * 
	 * @return Verdadeiro se o Mobil possui anexos nï¿½o assinados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public List<ExDocumento> getDocsFilhosNaoJuntados() {
		Set<ExMobil> todosOsMeusJuntados = getJuntados();
		List<ExDocumento> meusFilhosNaoJuntados = new ArrayList<ExDocumento>();
		for (ExDocumento docFilho : getExDocumentoFilhoSet()) {
			if (!docFilho.isExpediente() || docFilho.isCancelado() 
				|| docFilho.isArquivado() || docFilho.isSemEfeito())
				continue;
			boolean juntado = false;
			for (ExMobil mobFilho : docFilho.getExMobilSet()) {
				if (todosOsMeusJuntados.contains(mobFilho))
					juntado = true;
			}
			if (!juntado)
				meusFilhosNaoJuntados.add(docFilho);
		}
		return meusFilhosNaoJuntados;
	}

	/**
	 * Verifica se um Mobil possui documentos filhos nï¿½o juntados
	 * 
	 * @return Verdadeiro se o Mobil possui anexos nï¿½o assinados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean temDocsFilhosNaoJuntados() {
		return getDocsFilhosNaoJuntados().size() > 0;
	}

	/**
	 * Verifica se um Mobil possui arquivos anexados
	 * 
	 * @return Verdadeiro se o Mobil possui arquivos anexados e False caso
	 *         contrï¿½rio.
	 * 
	 */
	public boolean temAnexos() {
		boolean b = false;
		for (ExMovimentacao movAss : this.getExMovimentacaoSet()) {
			if (movAss.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO){
				b = true;
				break;
			}
		}
		return b;

	}

	public boolean temDocumentosJuntados() {
		boolean b = false;
		for (ExMovimentacao movRef : getExMovimentacaoReferenciaSet()) {
			if (!movRef.isCancelada())
				if (movRef.getExTipoMovimentacao().getId() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA)
					b = true;
				else if (movRef.getExTipoMovimentacao().getId() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA)
					b = false;
		}
		return b;
	}

	/**
	 * Retorna se o mï¿½bil possui algum apensado a si.
	 * 
	 * @return
	 */
	public boolean temApensos() {
		return getApensos() != null && getApensos().size() > 0;
	}

	/**
	 * Verifica se um Mobil do tipo Volume estï¿½ Apensado a outro Mobil do mesmo
	 * Processo.
	 * 
	 * @return Verdadeiro se o Mobil estiver apensado a outro volume do mesmo
	 *         processo e Falso caso contrï¿½rio.
	 * 
	 */
	public boolean isApensadoAVolumeDoMesmoProcesso() {
		if (getMestre() == null)
			return false;
		if (!isVolume())
			return false;
		if (!getMestre().isVolume())
			return false;
		if (!getMestre().doc().getIdDoc().equals(doc().getIdDoc()))
			return false;
		return true;
	}

	/**
	 * Retorna o ï¿½ltimo documento que ï¿½ filho do Mobil atual.
	 * 
	 * @return ï¿½ltimo documento que ï¿½ filho do Mobil atual.
	 * 
	 */
	public int getNumUltimoSubdocumento() {
		int maxNumSubdocumento = 0;
		for (ExDocumento d : getExDocumentoFilhoSet()) {
			if (d.getNumSequencia() == null)
				continue;
			if (d.getNumSequencia() > maxNumSubdocumento) {
				maxNumSubdocumento = d.getNumSequencia();
			}
		}
		return maxNumSubdocumento;
	}

	/**
	 * Retorna um documento filho do Mobil atual de acordo com o nï¿½mero de
	 * sequï¿½ncia informado.
	 * 
	 * @param numSubdocumento
	 * 
	 * @return Documento filho do Mobil atual de acordo com o nï¿½mero de
	 *         sequï¿½ncia informado.
	 * 
	 */
	public ExDocumento getSubdocumento(int numSubdocumento) {
		for (final ExDocumento d : getExDocumentoFilhoSet()) {
			if (d.getNumSequencia() == null)
				continue;
			if (d.getNumSequencia() == numSubdocumento) {
				return d;
			}
		}
		return null;
	}

	public boolean isNumeracaoUnicaAutomatica() {
		return doc().isNumeracaoUnicaAutomatica();
	}

	public List<ExArquivoNumerado> filtrarArquivosNumerados(ExMovimentacao mov,
			boolean bCompleto) {
		ExMobil mobPrincipal = getMobilPrincipal();

		List<ExArquivoNumerado> arquivosNumerados = null;

		arquivosNumerados = mobPrincipal.getExDocumento().getArquivosNumerados(
				mobPrincipal);

		List<ExArquivoNumerado> ans = new ArrayList<ExArquivoNumerado>();
		int i = 0;
		if (mov != null) {
			// Se for uma movimentacao, remover todos os arquivos alem da
			// movimentacao
			for (ExArquivoNumerado an : arquivosNumerados) {
				if (an.getArquivo() instanceof ExMovimentacao) {
					if (((ExMovimentacao) an.getArquivo()).getIdMov().equals(
							mov.getIdMov())) {
						ans.add(an);
						break;
					}
				}
			}
		} else if (mobPrincipal != this) {
			// Se for um documento juntado, remover todos os documentos que alem
			// dele e de seus anexos
			ExArquivoNumerado an;
			for (i = 0; i < arquivosNumerados.size(); i++) {
				an = arquivosNumerados.get(i);
				if (an.getArquivo() instanceof ExDocumento) {
					if (((ExDocumento) an.getArquivo()).getIdDoc().equals(
							getExDocumento().getIdDoc())
							&& an.getMobil().equals(this)) {
						ans.add(an);
						break;
					}
				}
			}
		} else {
			ans.add(arquivosNumerados.get(0));
		}
		if (bCompleto && i != -1) {
			for (int j = i + 1; j < arquivosNumerados.size(); j++) {
				ExArquivoNumerado anSub = arquivosNumerados.get(j);
				if (anSub.getNivel() <= arquivosNumerados.get(i).getNivel())
					break;
				ans.add(anSub);
			}
		}
		return ans;
	}

	public Long getByteCount() {
		if (getExMobilPai() != null)
			return null;
		long l = 0;

		List<ExArquivoNumerado> arquivosNumerados = getExDocumento()
				.getArquivosNumerados(this);

		for (int i = 0; i < arquivosNumerados.size(); i++)
			l += arquivosNumerados.get(i).getArquivo().getByteCount();

		return l;
	}

	/**
	 * Retorna as movimentaï¿½ï¿½es de um Mobil que estï¿½o canceladas.
	 * 
	 * @return Lista de movimentaï¿½ï¿½es de um Mobil que estï¿½o canceladas.
	 * 
	 */
	public List<ExMovimentacao> getMovimentacoesCanceladas() {

		final Set<ExMovimentacao> movs = getExMovimentacaoSet();
		List<ExMovimentacao> movsCanceladas = new ArrayList<ExMovimentacao>();

		if (movs != null)
			for (final ExMovimentacao mov : movs) {
				if (mov.isCancelada())
					movsCanceladas.add(mov);
			}
		return movsCanceladas;
	}

	public int getTotalDePaginas() {
		int totalDePaginas = 0;

		for (ExArquivoNumerado arquivo : getArquivosNumerados()) {

			totalDePaginas += arquivo.getNumeroDePaginasParaInsercaoEmDossie();
		}

		return totalDePaginas;
	}

	public int getTotalDePaginasSemAnexosDoMobilGeral() {
		int totalDePaginasDoGeral = 0;

		if (getDoc().getMobilGeral().temAnexos()) {
			totalDePaginasDoGeral = getDoc().getMobilGeral()
					.getTotalDePaginas();
		}

		return getTotalDePaginas() - totalDePaginasDoGeral;
	}

	public SortedSet<ExMarca> getExMarcaSetAtivas() {
		SortedSet<ExMarca> finalSet = new TreeSet<ExMarca>();
		Date dt = new Date();
		for (ExMarca m : getExMarcaSet())
			if ((m.getDtIniMarca() == null || m.getDtIniMarca().before(dt))
					&& (m.getDtFimMarca() == null || m.getDtFimMarca()
							.after(dt)))
				finalSet.add(m);
		return finalSet;
	}
	
	public boolean temMarcaNaoAtiva(){
		Date dt = new Date();
		for (ExMarca m : getExMarcaSet())
			if ((m.getDtIniMarca() != null && m.getDtIniMarca().after(dt))
					|| (m.getDtFimMarca() != null && m.getDtFimMarca()
							.before(dt)))
				return true;
		return false;
	}

	public SortedSet<ExMarca> getExMarcaSetTemporalidade() {
		SortedSet<ExMarca> setFinal = new TreeSet<ExMarca>();
		for (ExMarca m : getExMarcaSet()) {
			long idM = m.getCpMarcador().getIdMarcador();
			if (idM == MARCADOR_ARQUIVADO_CORRENTE
					|| idM == MARCADOR_TRANSFERIR_PARA_ARQUIVO_INTERMEDIARIO
					|| idM == MARCADOR_ARQUIVADO_INTERMEDIARIO
					|| idM == MARCADOR_RECOLHER_PARA_ARQUIVO_PERMANENTE
					|| idM == MARCADOR_ARQUIVADO_PERMANENTE
					|| idM == MARCADOR_A_ELIMINAR
					|| idM == MARCADOR_EM_EDITAL_DE_ELIMINACAO
					|| idM == MARCADOR_ELIMINADO)
				setFinal.add(m);
		}
		return setFinal;
	}

	/**
	 * Retorna o tempo de permanï¿½ncia deste mï¿½bil no arquivo corrente conforme o
	 * PCTT.
	 * 
	 * @return
	 */
	public ExTemporalidade getTemporalidadeCorrente() {
		ExVia viaPCTT = getViaPCTT();
		return viaPCTT != null ? viaPCTT.getTemporalidadeCorrente() : null;
	}

	/**
	 * Retorna o tempo de permanï¿½ncia deste mï¿½bil no arquivo corrente conforme o
	 * PCTT, considerando as temporalidades de todos os outros mï¿½biles da ï¿½rvore
	 * de juntados, predominando a maior delas.
	 * 
	 * @return
	 */
	public ExTemporalidade getTemporalidadeCorrenteEfetiva() {
		ExTemporalidade tmpCorrentePredominante = null;
		for (ExMobil mob : getArvoreMobilesParaAnaliseDestinacao()) {
			final ExTemporalidade tmpCorrente = mob.getTemporalidadeCorrente();
			if (tmpCorrentePredominante == null
					|| (tmpCorrente != null && tmpCorrente
							.compareTo(tmpCorrentePredominante) > 0))
				tmpCorrentePredominante = tmpCorrente;
		}
		return tmpCorrentePredominante;
	}

	/**
	 * Retorna se o mï¿½bil tem atrelado um tempo de permanï¿½ncia no arquivo
	 * corrente, mesmo que ele nï¿½o seja fixo e mensurï¿½vel. Essa avaliaï¿½ï¿½o
	 * considera todos os mï¿½biles juntados.
	 * 
	 * @return
	 */
	public boolean temTemporalidadeCorrente() {
		return getTemporalidadeCorrenteEfetiva() != null;
	}

	/**
	 * Retorna o tempo de permanï¿½ncia deste mï¿½bil no arquivo intermediï¿½rio
	 * conforme o PCTT.
	 * 
	 * @return
	 */
	public ExTemporalidade getTemporalidadeIntermediario() {
		ExVia viaPCTT = getViaPCTT();
		return viaPCTT != null ? viaPCTT.getTemporalidadeIntermediario() : null;
	}

	/**
	 * Retorna o tempo de permanï¿½ncia deste mï¿½bil no arquivo intermediï¿½rio
	 * conforme o PCTT, considerando as temporalidades de todos os outros
	 * mï¿½biles da ï¿½rvore de juntados, predominando a maior delas.
	 * 
	 * @return
	 */
	public ExTemporalidade getTemporalidadeIntermediarioEfetiva() {
		ExTemporalidade tmpIntermedPredominante = null;
		for (ExMobil mob : getArvoreMobilesParaAnaliseDestinacao()) {
			final ExTemporalidade tmpIntermed = mob
					.getTemporalidadeIntermediario();
			if (tmpIntermedPredominante == null
					|| (tmpIntermed != null && tmpIntermed
							.compareTo(tmpIntermedPredominante) > 0))
				tmpIntermedPredominante = tmpIntermed;
		}
		return tmpIntermedPredominante;
	}

	/**
	 * Retorna se o mï¿½bil tem atrelado um tempo de permanï¿½ncia no arquivo
	 * intermediï¿½rio, mesmo que ele nï¿½o seja fixo e mensurï¿½vel. Essa avaliaï¿½ï¿½o
	 * considera todos os mï¿½biles juntados.
	 * 
	 * @return
	 */
	public boolean temTemporalidadeIntermediario() {
		return getTemporalidadeIntermediarioEfetiva() != null;
	}

	public String getReferencia() {
		return getCodigoCompacto();
	}

	/**
	 * Retorna a referï¿½ncia do objeto mais o extensï¿½o ".html".
	 * 
	 */
	public String getReferenciaHtml() {
		return getReferencia() + ".html";
	}

	/**
	 * Retorna a referï¿½ncia do objeto mais o extensï¿½o ".pdf".
	 * 
	 */
	public String getReferenciaPDF() {
		return getReferencia() + ".pdf";
	};

	/**
	 * Retorna a referï¿½ncia do objeto mais o extensï¿½o ".rtf".
	 * 
	 */
	public String getReferenciaRTF() {
		return getReferencia() + ".rtf";
	};

	/**
	 * Verifica se o mobil estï¿½ na mesma lotaï¿½ï¿½o de outro
	 * 
	 */
	public boolean estaNaMesmaLotacao(ExMobil outroMobil) {
		if (getUltimaMovimentacao() != null
				&& outroMobil.getUltimaMovimentacao() != null)
			return getUltimaMovimentacao().getLotaResp().equivale(
					outroMobil.getUltimaMovimentacao().getLotaResp());

		return false;
	}

	/**
	 * Retorna a destinaï¿½ï¿½o final deste mï¿½bil conforme o PCTT.
	 * 
	 * @return
	 */
	public ExTipoDestinacao getExDestinacaoFinal() {
		ExVia viaPCTT = getViaPCTT();
		return viaPCTT != null ? viaPCTT.getExDestinacaoFinal() : null;
	}

	/**
	 * Retorna a destinaï¿½ï¿½o final deste mï¿½bil conforme o PCTT, considerando a
	 * destinaï¿½ï¿½o de todos os outros mï¿½biles da ï¿½rvore de juntados, predominando
	 * a guarda permanente sobre a eliminaï¿½ï¿½o.
	 * 
	 * @return
	 */
	public ExTipoDestinacao getExDestinacaoFinalEfetiva() {
		ExTipoDestinacao destinacaoPredominante = null;
		for (ExMobil mob : getArvoreMobilesParaAnaliseDestinacao())
			if (mob.getExDestinacaoFinal() != null
					&& mob.getExDestinacaoFinal()
							.getIdTpDestinacao()
							.equals(ExTipoDestinacao.TIPO_DESTINACAO_GUARDA_PERMANENTE))
				return mob.getExDestinacaoFinal();
			else if (mob.isindicadoGuardaPermanente())
				return ExTipoDestinacao.guardaPermanente();
			else
				destinacaoPredominante = mob.getExDestinacaoFinal();
		return destinacaoPredominante;
	}

	/**
	 * Retorna se a destinaï¿½ï¿½o final do mï¿½bil ï¿½ guarda permanente. Essa
	 * avaliaï¿½ï¿½o considera todos os mï¿½biles juntados e a existï¿½ncia de indicaï¿½ï¿½o
	 * para guarda permanente.
	 * 
	 * @return
	 */
	public boolean isDestinacaoGuardaPermanente() {
		ExTipoDestinacao dest = getExDestinacaoFinalEfetiva();
		return dest != null
				&& dest.getIdTpDestinacao().equals(
						ExTipoDestinacao.TIPO_DESTINACAO_GUARDA_PERMANENTE);
	}

	/**
	 * Retorna se a destinaï¿½ï¿½o final do mï¿½bil ï¿½ eliminaï¿½ï¿½o. Essa avaliaï¿½ï¿½o
	 * considera todos os mï¿½biles juntados e a existï¿½ncia de indicaï¿½ï¿½o para
	 * guarda permanente.
	 * 
	 * @return
	 */
	public boolean isDestinacaoEliminacao() {
		ExTipoDestinacao dest = getExDestinacaoFinalEfetiva();
		return dest != null
				&& dest.getIdTpDestinacao().equals(
						ExTipoDestinacao.TIPO_DESTINACAO_ELIMINACAO);
	}

	/**
	 * Retorna a via da tabela de classificaï¿½ï¿½ correspondente a este mï¿½bil. Caso
	 * seja mï¿½bil de processo, a via serï¿½ sempre a de nï¿½mero 1.
	 * 
	 * @return
	 */
	public ExVia getViaPCTT() {
		Short numVia = doc().isProcesso() || isGeral() ? 1 : getNumSequencia()
				.shortValue();

		ExVia via = getExDocumento().via(numVia);

		if (via != null)
			return via;

		return getExDocumento().via((short) 1);
	}

	/**
	 * Retorna o mï¿½bil que representa este para fins de movimentaï¿½ï¿½o de
	 * destinaï¿½ï¿½o, ou seja, o mï¿½bil que, representando este, recebe as
	 * movimentaï¿½ï¿½es de destinaï¿½ï¿½o (arquivamento, inclusï¿½o em edital, etc). Se
	 * este mï¿½bil for uma via, ela mesma ï¿½ retornada. Se for volume ou geral de
	 * processo, o geral ï¿½ retornado. Geral de expediente retorna nulo, pois nï¿½o
	 * sofre movimentaï¿½ï¿½o de destinaï¿½ï¿½o nem ï¿½ representado por outro mï¿½bil.
	 * 
	 * @return
	 */
	private ExMobil getMobilParaMovimentarDestinacao() {
		if (isVia())
			return this;
		else if (doc().isProcesso())
			return doc().getMobilGeral();
		return null;
	}

	/**
	 * Retorna os mï¿½biles <b>do documento deste mï¿½bil</b> que deverï¿½o ser
	 * percorridos para se concluir a temporalidade e a destinaï¿½ï¿½o deste mï¿½bil.
	 * Se este mï¿½bil for geral (seja de expediente ou de processo) ou volume,
	 * todos os mï¿½biles do documento serï¿½o retornados. Se for uma via de
	 * expediente, apenas ela serï¿½ retornada.
	 * 
	 * @return
	 */
	private Set<ExMobil> getMobilesDoDocParaAnaliseDestinacao() {
		SortedSet<ExMobil> set = new TreeSet<ExMobil>();
		if (doc().isProcesso() || isGeral())
			set.addAll(doc().getExMobilSet());
		else
			set.add(this);
		return set;
	}

	/**
	 * Retorna, numa lista, o conjunto de mï¿½biles que formam uma unidade para
	 * fins de destinaï¿½ï¿½o. Essa lista faz varreduras horizontais (mï¿½biles do
	 * documento) e verticais (relaï¿½ï¿½es de juntada entre mï¿½biles).
	 * 
	 * @return
	 */
	public Set<ExMobil> getArvoreMobilesParaAnaliseDestinacao() {

		Set<ExMobil> set = new LinkedHashSet<ExMobil>();
		for (ExMobil mob : getMobilesDoDocParaAnaliseDestinacao())
			for (ExMobil mob2 : mob.getMobilPrincipal()
					.getMobilesDoDocParaAnaliseDestinacao())
				for (ExMobil mob3 : mob2.getMobilETodosOsJuntados())
					if (!mob3.isVolume())
						set.add(mob3);
		return set;
	}

	public String getTerminacaoSigla() {
		if (isVia()) {
			final String alfabeto = "ABCDEFGHIJLMNOPQRSTUZ";

			// as vias vï¿½o atï¿½ a letra 'U', se passar disso, assume letra 'Z'
			if (getNumSequencia() <= 20) {
				return alfabeto.substring(
						getNumSequencia() - 1, getNumSequencia());
			} else {
				return "Z";
			}
		} else if (isVolume()) {
			return "V"
					+ (getNumSequencia() < 10 ? "0" + getNumSequencia()
							: getNumSequencia());
		} else {
			return "";
		}
		//return getSigla().substring(getSigla().lastIndexOf("-")+1);
	}
}