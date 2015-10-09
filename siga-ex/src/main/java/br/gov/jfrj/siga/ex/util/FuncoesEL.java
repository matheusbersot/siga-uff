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

import java.io.StringReader;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.MaskFormatter;

import org.xml.sax.InputSource;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.ConexaoHTTP;
import br.gov.jfrj.siga.base.Contexto;
import br.gov.jfrj.siga.base.ReaisPorExtenso;
import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.dp.CpLocalidade;
import br.gov.jfrj.siga.dp.CpOrgao;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.dp.dao.DpPessoaDaoFiltro;
import br.gov.jfrj.siga.ex.ExArquivo;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExEditalEliminacao;
import br.gov.jfrj.siga.ex.ExModelo;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExTermoEliminacao;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;
import br.gov.jfrj.siga.ex.ExTpDocPublicacao;
import br.gov.jfrj.siga.ex.ExTratamento;
import br.gov.jfrj.siga.ex.ExVia;
import br.gov.jfrj.siga.ex.SigaExProperties;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.ex.bl.BIE.HierarquizadorBoletimInterno;
import br.gov.jfrj.siga.ex.bl.BIE.HierarquizadorBoletimInternoCJF;
import br.gov.jfrj.siga.ex.bl.BIE.HierarquizadorBoletimInternoES;
import br.gov.jfrj.siga.ex.bl.BIE.HierarquizadorBoletimInternoTRF2;
import br.gov.jfrj.siga.ex.bl.BIE.NodoMenor;
import br.gov.jfrj.siga.hibernate.ExDao;
import freemarker.ext.dom.NodeModel;

public class FuncoesEL {
	public static ExDao dao() {
		return ExDao.getInstance();
	}

	public static String concat(final String s, final String s2) {
		return s + s2;
	}

	public static String replace(final String texto, final String oldChar,
			final String newChar) {
		return texto.replace(oldChar, newChar);
	}

	public static Boolean has(final String[] as, final String s) {
		for (final String sAux : as)
			if (sAux.equals(s))
				return true;
		return false;


	}

	public static Boolean extraiCamposDescrAutomatica(final String s) {
		return null;
	}

	public static HierarquizadorBoletimInterno obterHierarquizadorBIE(
			CpOrgaoUsuario orgao, ExDocumento d) {
		return new HierarquizadorBoletimInterno(orgao, Ex.getInstance().getBL()
				.obterDocumentosBoletim(d));

	}


	public static HierarquizadorBoletimInternoTRF2 obterHierarquizadorBIETRF2(
			CpOrgaoUsuario orgao, ExDocumento d) {
		return new HierarquizadorBoletimInternoTRF2(orgao, Ex.getInstance()
				.getBL().obterDocumentosBoletim(d));
	}

	public static HierarquizadorBoletimInternoES obterHierarquizadorBIEES(
			CpOrgaoUsuario orgao, ExDocumento d) {
		return new HierarquizadorBoletimInternoES(orgao, Ex.getInstance()
				.getBL().obterDocumentosBoletim(d));
	}


	public static HierarquizadorBoletimInternoCJF obterHierarquizadorBIECJF(
			CpOrgaoUsuario orgao, ExDocumento d) {
		return new HierarquizadorBoletimInternoCJF(orgao, Ex.getInstance()
				.getBL().obterDocumentosBoletim(d));
	}


	public static Boolean podeRemeterPorConfiguracao(DpPessoa titular,
			DpLotacao lotaTitular) throws Exception {
		if (lotaTitular == null)
			return false;
		return Ex
				.getInstance()
				.getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_REMESSA_PARA_PUBLICACAO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);

	}

	public static Boolean podeArquivarPermanentePorConfiguracao(
			DpPessoa titular, DpLotacao lotaTitular) throws Exception {
		if (lotaTitular == null)
			return false;
		return Ex
				.getInstance()
				.getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_PERMANENTE,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);

	}
	
	public static Boolean podeArquivarIntermediarioPorConfiguracao(
			DpPessoa titular, DpLotacao lotaTitular) throws Exception {
		if (lotaTitular == null)
			return false;
		return Ex
				.getInstance()
				.getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_INTERMEDIARIO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);

	}

	public static Boolean podeDefinirPublicadoresPorConfiguracao(
			DpPessoa titular, DpLotacao lotaTitular) throws Exception {
		if (lotaTitular == null)
			return false;
		return Ex
				.getInstance()
				.getConf()
				.podePorConfiguracao(titular, lotaTitular,
						CpTipoConfiguracao.TIPO_CONFIG_DEFINIR_PUBLICADORES);

	}

	public static String reaisPorExtenso(final String s) {
		if (s == null)
			return null;
		String temp = s;
		temp = temp.replaceAll("\\.", "");
		temp = temp.replaceAll("\\,", ".");
		ReaisPorExtenso r = new ReaisPorExtenso(new BigDecimal(temp));
		return r.toString();
	}

	public static String removeAcento(final String s) {
		return Texto.removeAcento(s);
	}

	public static String removeAcentoMaiusculas(final String s) {
		return Texto.removeAcentoMaiusculas(s);
	}

	public static String maiusculasEMinusculas(String s) {
		return Texto.maiusculasEMinusculas(s);
	}

	public static String primeiraMaiuscula(String s) {
		return Texto.primeiraMaiuscula(s);
	}

	public static DpPessoa pessoa(Long id) throws AplicacaoException {
		if (id == null || id == 0)
			return null;

		return dao().consultar(id, DpPessoa.class, false);
	}

	public static Boolean podeUtilizarExtensaoEditor(DpLotacao lota, Long idMod)
			throws Exception {
		ExModelo mod = dao().consultar(idMod, ExModelo.class, false);
		return Ex
				.getInstance()
				.getConf()
				.podePorConfiguracao(null, lota, mod,
						CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_EXTENSAO_EDITOR);
	}

	public static List<CpLocalidade> consultarPorUF(String siglaUF) {
		return dao().consultarLocalidadesPorUF(siglaUF);
	}

	public static DpLotacao lotacao(Long id) throws AplicacaoException {
		if (id == null || id == 0)
			return null;

		return dao().consultar(id, DpLotacao.class, false);
	}


	public static CpOrgao orgao(Long id) throws AplicacaoException {
		if (id == null || id == 0)
			return null;

		return dao().consultar(id, CpOrgao.class, false);
	}

	public static String destinacaoPorNumeroVia(ExDocumento doc, Short i) {
		ExVia via = doc.via(new Short(i.shortValue()));
		String s = null;
		if (via != null && via.getExTipoDestinacao() != null) {
			s = via.getExTipoDestinacao().getDescrTipoDestinacao();
		}
		return s;
	}

	public static List<DpPessoa> pessoasPorLotacao(Long id,
			Boolean incluirSublotacoes) throws Exception {
		if (id == null || id == 0)
			return null;

		DpLotacao lotacao = dao().consultar(id, DpLotacao.class, false);

		List<DpLotacao> lotacoes = dao().listarLotacoes();
		List<DpLotacao> sublotacoes = new ArrayList<DpLotacao>();
		sublotacoes.add(lotacao);

		if (incluirSublotacoes) {
			boolean continuar = true;
			while (continuar) {
				continuar = false;
				for (DpLotacao lot : lotacoes) {
					if (sublotacoes.contains(lot))
						continue;
					if (sublotacoes.contains(lot.getLotacaoPai())) {
						if (!lot.isSubsecretaria()) {
							sublotacoes.add(lot);
							continuar = true;
						}
					}
				}
			}
		}

		List<DpPessoa> lstCompleta = new ArrayList<DpPessoa>();
		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		String estagiario = "ESTAGIARIO";
		String juizFederal = "JUIZ FEDERAL";
		String juizFederalSubstituto = "JUIZ SUBSTITUTO";
		flt.setNome("");
		for (DpLotacao lot : sublotacoes) {
			flt.setLotacao(lot);
			List<DpPessoa> lst = dao().consultarPorFiltro(flt);
			// final DpCargoDao daoCargo = getFabrica().createDpCargoDao();
			// List <DpCargo> cargo= daoCargo.listarTodos();

			for (DpPessoa pes : lst) {
				if (pes.getCargo() == null
						|| pes.getCargo().getNomeCargo() == null) {
					continue;
				}
				String cargo = pes.getCargo().getNomeCargo().toUpperCase();
				if (!cargo.contains(juizFederal)
						&& !cargo.contains(juizFederalSubstituto)
						&& !(cargo.contains(estagiario)))
					lstCompleta.add(pes);
			}

			// for (DpPessoa pes : lst) {
			// for(DpCargo carg : cargo)
			// if(carg.getIdCargo().equals(pes.getIdCargo())&&
			// ((!(carg.getNomeCargo().contains(juizFederal))) &&
			// (!(carg.getNomeCargo().contains(juizFederalSubstituto)))&&(!(carg.getNomeCargo().contains(estagiario)))))
			// lstCompleta.add(pes);
			// }
		}

		return lstCompleta;
	}

	public static String fixFontSize(String html, String tamanho) {

		// Pattern p1 = Pattern.compile("^([0-9\\.\\-/]+) ([^\r\n]+)\r\n");
		Pattern p1 = Pattern.compile(
				"<((?:p|td|div|span)[^>]*) style=\"([^\"]*)\"([^>]*)>",
				Pattern.CASE_INSENSITIVE);
		Pattern p2 = Pattern.compile("(font-size:[^;]*)(;?)",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p1.matcher(html);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			String all = m.group();
			String begin = m.group(1);
			String style = m.group(2);
			Matcher m2 = p2.matcher(style);
			if (m2.find()) {
				if (style.contains("font-size-no-fix: yes")) {
					style = style.replace("font-size-no-fix: yes;", "");
					style = style.replace("; font-size-no-fix: yes", "");
					style = style.replace("font-size-no-fix: yes", "");
				} else {
					style = style.replace(m2.group(), "font-size:" + tamanho
							+ m2.group(2));
				}
			} else {
				style = "font-size:" + tamanho + ";" + style;
			}
			String end = m.group(3);
			m.appendReplacement(sb, "<" + begin + " style=\"" + style + "\""
					+ end + ">");
		}
		m.appendTail(sb);

		Pattern p3 = Pattern.compile("<(p|td|div|span)([^>]*)>",
				Pattern.CASE_INSENSITIVE);
		Matcher m3 = p3.matcher(sb.toString());
		StringBuffer sb2 = new StringBuffer();
		String style = "font-size:" + tamanho + ";";
		while (m3.find()) {
			String all = m3.group();
			String begin = m3.group(1);
			String end = m3.group(2);
			if (!end.contains("style=")) {
				m3.appendReplacement(sb2, "<" + begin + " style=\"" + style
						+ "\"" + end + ">");
			} else {
				m3.appendReplacement(sb2, "<" + begin + end + ">");
			}
		}
		m3.appendTail(sb2);

		String htmlFinal = sb2.toString();
		htmlFinal = htmlFinal.replaceAll(
				"font-size:11pt;PAGE-BREAK-AFTER: always",
				"PAGE-BREAK-AFTER: always");

		return htmlFinal;

	}

	public static String obterTituloMateriaLivre(NodoMenor nodoMenor,
			ExDocumento doc, Integer i) {
		return HierarquizadorBoletimInterno.obterTituloMateriaLivre(nodoMenor,
				doc, i);
	}

	public static String obterBlobMateriaLivre(NodoMenor nodoMenor,
			ExDocumento doc, Integer i) {
		return HierarquizadorBoletimInterno.obterBlobMateriaLivre(nodoMenor,
				doc, i);
	}

	public static ExTratamento tratamento(String autoridade, String genero) {
		return ExTratamento.tratamento(autoridade, genero);
	}

	public static String enxugaHtml(String html) {
		return HierarquizadorBoletimInterno.enxugaHtml(html);
	}

	/*
	public static List<Object[]> gerarEntrevistaEditalEliminacao(
			ExDocumento edital) {
		return ExEditalEliminacao.gerarEntrevista(edital);
	}

	public static List<ExMobil> obterInclusosNoEditalComBaseNaEntrevista(
			ExDocumento edital) {
		return ExEditalEliminacao
				.obterInclusosNoEditalComBaseNaEntrevista(edital);
	}

	public static List<Object[]> obterInclusosNoEdital(Long idMobilEdital) {
		ExMobil edital = dao().consultar(idMobilEdital, ExMobil.class, false);
		return ExEditalEliminacao.obterInclusosNoEdital(edital.getExDocumento());
	}

	public static void eliminarInclusosNoTermo(ExDocumento termo,
			DpPessoa cadastrante, DpLotacao lotaCadastrante) {
		ExTermoEliminacao.eliminarInclusosNoTermo(termo, cadastrante,
				lotaCadastrante);
	}*/
	
	public static ExEditalEliminacao editalEliminacao(ExDocumento doc){
		return new ExEditalEliminacao(doc);
	}
	
	public static ExTermoEliminacao termoEliminacao(ExDocumento doc){
		return new ExTermoEliminacao(doc);
	}

	public static String verificaGenero(String autoridade) {
		return ExTratamento.genero(autoridade);
	}

	public static String cargoPessoa(Long idPessoa) throws AplicacaoException {
		DpPessoa pes = dao().consultar(idPessoa, DpPessoa.class, false);
		if (pes != null)
			return pes.getCargo().getNomeCargo();

		return null;
	}

	public static String lotacaoPessoa(Long idPessoa) throws AplicacaoException {
		DpPessoa pes = dao().consultar(idPessoa, DpPessoa.class, false);
		if (pes != null)
			return pes.getLotacao().getNomeLotacao();

		return null;
	}

	public static Map<String, List<ExDocumento>> buscaDocumentosAssinadosAgrupadosPorMetadado(
			CpOrgaoUsuario usu, Long idMod, String ini, String fim,
			String nomeMetadado) throws AplicacaoException {

		final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Date dtIni = null;
		Date dtFim = null;
		try {
			dtIni = df.parse(ini);
			dtFim = df.parse(fim);
			Calendar c = Calendar.getInstance();
			c.setTime(dtFim);
			c.add(Calendar.DAY_OF_MONTH, 1);
			dtFim = c.getTime();
		} catch (final ParseException e) {
			return null;
		} catch (final NullPointerException e) {
			return null;
		}

		Map<String, List<ExDocumento>> m = new HashMap<String, List<ExDocumento>>();
		ExModelo mod = dao().consultar(idMod, ExModelo.class, false);

		List<ExDocumento> documentos = dao().consultarPorModeloEAssinatura(usu,
				mod, dtIni, dtFim);

		// List<ExDocumento> documentos = daoDocumento.listarTodos();

		for (ExDocumento doc : documentos)
			if ((doc.getExModelo().getIdMod().equals(idMod))) {
				String motivo = doc.getForm().get(nomeMetadado);
				if (!m.containsKey(motivo)) {
					List<ExDocumento> l = new ArrayList<ExDocumento>();
					l.add(doc);
					m.put(motivo, l);
				} else {
					m.get(motivo).add(doc);
				}
			}

		return m;
	}

	public static List<ExDocumento> buscaDocumentosAssinados(
			CpOrgaoUsuario usu, Long[] idsModelo, String ini, String fim)
			throws AplicacaoException {

		if (usu == null) {
			return null;
		}
		final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Date dtIni = null;
		Date dtFim = null;
		try {
			dtIni = df.parse(ini);
			dtFim = df.parse(fim);
			Calendar c = Calendar.getInstance();
			c.setTime(dtFim);
			c.add(Calendar.DAY_OF_MONTH, 1);
			dtFim = c.getTime();
		} catch (final ParseException e) {
			return null;
		} catch (final NullPointerException e) {
			return null;
		}

		Map<String, List<ExDocumento>> m = new HashMap<String, List<ExDocumento>>();
		List<ExDocumento> documentos = new ArrayList<ExDocumento>();

		for (Long idMod : idsModelo) {
			ExModelo mod = dao().consultar(idMod, ExModelo.class, false);
			List<ExDocumento> l = dao().consultarPorModeloEAssinatura(usu, mod,
					dtIni, dtFim);
			if (l != null)
				documentos.addAll(l);
		}

		return documentos;
	}

	public static List<ExDocumento> buscaDocumentosParaPublicar(
			String publicacao, CpOrgaoUsuario usu) throws AplicacaoException {

		if (usu == null) {
			return null;
		}

		if (!publicacao.equals("BI")) {
			return null;
		}

		List<ExDocumento> l = dao().consultarPorModeloParaPublicar(usu);

		return l;
	}

	public static DpLotacao lotacaoPorNivelMaximo(DpLotacao lot,
			Integer iNivelMaximo) throws AplicacaoException {
		if (iNivelMaximo == null || iNivelMaximo == 0)
			return null;

		return lot.getLotacaoPorNivelMaximo(iNivelMaximo);
	}

	public static String quebraLinhas(String frase) {
		String string2 = "";
		String string1 = "";
		String[] aux = frase.split(" ");
		int x = 8;
		for (String aux1 : aux) {
			if ((string1 + aux1).length() < x)
				string1 = string1 + " " + aux1;

			else {
				string1 = string1 + "<br>" + aux1;
				x = x + 12;

			}
		}

		return string1.replaceAll("/", "/<br>");
	}

	public static String calculaData(String quatDias, String ini) {
		final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Date dtInicial = null;
		Integer dias;
		try {
			dias = Integer.parseInt(quatDias);
			dtInicial = df.parse(ini);
			Calendar c = Calendar.getInstance();
			c.setTime(dtInicial);
			c.add(Calendar.DAY_OF_MONTH, dias - 1);
			dtInicial = c.getTime();
		} catch (final ParseException e) {
			return null;
		} catch (final NullPointerException e) {
			return null;
		}
		return df.format(dtInicial);
	}

	public static String calculaDiferencaDatas(String dataFim, String dataIni) {
		final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Date dtInicial = null;
		Date dtFinal = null;
		String diferenca = null;
		try {
			dtInicial = df.parse(dataIni);
			dtFinal = df.parse(dataFim);
			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			c1.setTime(dtInicial);
			c2.setTime(dtFinal);
			long milis1 = c1.getTimeInMillis();
			long milis2 = c2.getTimeInMillis();
			long diff = milis2 - milis1;
			long diffdays = diff / (24 * 60 * 60 * 1000) + 1;
			diferenca = String.valueOf(diffdays);
		} catch (final ParseException e) {
			return null;
		} catch (final NullPointerException e) {
			return null;
		}
		return diferenca;
	}

	public static Float monetarioParaFloat(String monetario) {
		try {
			return Float.parseFloat(monetario.replace(".", "")
					.replace(",", "."));
		} catch (Exception e) {
			return null;
		}
	}

	public static String mesModData(String data) {
		String split[] = data.split("/");
		if (split.length < 3)
			return data;
		return split[1] + "/" + split[2];
	}

	public static String floatParaMonetario(Float valor1) {
		Float valor2;
		if (valor1 < 0) {
			valor2 = Float.parseFloat(valor1.toString().replace("-", ""));
			DecimalFormat formatter = new DecimalFormat("#,##0.00");
			String s = formatter.format(valor2);
			if (s.substring(s.length() - 3, s.length() - 2).equals(".")) {
				return s.replace(".", "*").replace(",", ".").replace("*", ",");
			} else {
				return "-" + s;
			}
		} else {
			DecimalFormat formatter = new DecimalFormat("#,##0.00");
			String s = formatter.format(valor1);
			if (s.substring(s.length() - 3, s.length() - 2).equals(".")) {
				return s.replace(".", "*").replace(",", ".").replace("*", ",");
			} else {
				return s;
			}
		}
	}

	public static String stringParaMinuscula(String string) {
		String stringAux1 = string.substring(0, 1);
		String stringAux2 = string.substring(1).toLowerCase();
		return stringAux1 + stringAux2;
	}

	public static String quebraString(String frase) {
		String string2 = "";
		String string1 = "";
		String[] aux = frase.split(" ");
		int x = 8;
		for (String aux1 : aux) {
			if ((string1 + aux1).length() < x)
				string1 = string1 + " " + aux1;

			else {
				string1 = string1 + "<br>" + aux1;
				x = x + 12;

			}
		}

		return string1.replaceAll("/", "/<br>");
	}

	public static String stringParaMinusculaNomes(String string) {
		String strSplit[] = string.split(" ");
		String stringFinal = "";
		String stringAux1;
		String stringAux2;
		for (int i = 0; i < strSplit.length; i++) {
			if (strSplit[i] != "de" || strSplit[i] != "do"
					|| strSplit[i] != "da") {
				stringAux1 = strSplit[i].substring(0, 1);
				stringAux2 = strSplit[i].substring(1).toLowerCase();
				stringFinal = stringFinal + stringAux1 + stringAux2 + " ";
			} else {
				stringFinal = stringFinal + strSplit[i];
			}
		}
		return stringFinal;
	}

	public static Long monetarioParaLong(String monetario) {
		if (monetario == null)
			return null;
		monetario = monetario.replace(
				monetario.substring((monetario.length() - 3),
						(monetario.length())), "");
		return Long.parseLong(monetario.replace(".", ""));

	}

	public static Boolean contains(String str, String sub) {
		return str.contains(sub);
	}

	public static Boolean criarWorkflow(String nomeProcesso, ExDocumento d,
			DpPessoa cadastrante, DpPessoa titular, DpLotacao lotaCadastrante,
			DpLotacao lotaTitular) throws Exception {

		// Nato: Nesse caso, o titular � considerado o subscritor do documento.
		// N�o sei se isso � 100% correto, mas acho que � uma abordagem bastante
		// razo�vel.
		// Markenson: Conversando com o Renato, alteramos o titular para o
		// titular do sistema
		// e n�o do documento.
		Ex.getInstance()
				.getBL()
				.criarWorkflow(cadastrante,
						titular == null ? cadastrante : titular,
						lotaTitular == null ? lotaCadastrante : lotaTitular, d,
						nomeProcesso);
		return true;
	}

	public static String processarModelo(ExArquivo docOuMov, String acao,
			Map parameters, String preenchRedirect) throws Exception {
		Map<String, String> params = new HashMap<String, String>();

		if (!preenchRedirect.trim().equals("")) {
			String allParams[] = preenchRedirect.split("&");
			for (String paramNameAndValue : allParams) {
				if (!paramNameAndValue.trim().equals("")) {
					String[] splittedNameAndValue = paramNameAndValue
							.split("=");
					if (splittedNameAndValue.length > 1)
						params.put(splittedNameAndValue[0], URLDecoder.decode(
								splittedNameAndValue[1], "UTF-8"));
				}
			}
		} else {
			Map<String, String[]> pcast = (Map<String, String[]>) parameters;

			if (docOuMov instanceof ExDocumento)
				params.putAll(((ExDocumento) docOuMov).getForm());

			StringBuilder sb = new StringBuilder();
			for (String key : pcast.keySet()) {
				String s[] = pcast.get(key);
				if (s.length == 1) {
					params.put(key, s[0]);
				} else if (s.length > 1) {
					sb.setLength(0);
					boolean fFirstTime = true;
					for (String ss : s) {
						if (fFirstTime)
							fFirstTime = false;
						else {
							sb.append(",");
						}
						sb.append(ss);
					}
					params.put(key, sb.toString());
				}
			}
		}

		try {
			if (docOuMov instanceof ExDocumento)
				return Ex
						.getInstance()
						.getBL()
						.processarModelo((ExDocumento) docOuMov, acao, params,
								null);
			else if (docOuMov instanceof ExMovimentacao)
				return Ex
						.getInstance()
						.getBL()
						.processarModelo((ExMovimentacao) docOuMov, acao,
								params, null);
		} catch (Exception ex) {
			return ex.getMessage();
		}
		return null;
	}

	public static Object resource(String name) {
		return Contexto.resource(name);
	}

	public static long idadeEmAnos(String data) throws ParseException {

		DateFormat df = DateFormat.getDateInstance();
		Date date = df.parse(data);
		return (new Date().getTime() - date.getTime()) / (31536000000L);
	}

	/**
	 * Aplica o formato de CPF. Ex: 12345678910 para 123.456.789-10
	 * 
	 * @param cpf
	 *            - CPF formatado.
	 * @return
	 */
	public static String formatarCPF(String cpf) {

		// Se CPF j� vem formatado, devolve cpf
		Pattern p = Pattern
				.compile("[0-9]{2,3}?\\.[0-9]{3}?\\.[0-9]{3}?\\-[0-9]{2}?");
		Matcher m = p.matcher(cpf);

		if (m.find()) {
			return cpf;
		}

		// O texto � truncado para 11 caracteres caso seja maior
		if (cpf.length() > 11) {
			cpf = cpf.substring(0, 11);
		}

		// Determina o n�mero de zeros � esquerda
		int numZerosAEsquerda = 11 - cpf.length();

		// aplica os zeros � esquerda
		for (int i = 0; i < numZerosAEsquerda; i++) {
			cpf = "0" + cpf;
		}

		// extrai cada termo
		String termo1, termo2, termo3, termo4;
		termo1 = cpf.substring(0, 3);
		termo2 = cpf.substring(3, 6);
		termo3 = cpf.substring(6, 9);
		termo4 = cpf.substring(9);

		return termo1 + "." + termo2 + "." + termo3 + "-" + termo4;
	}
	
	/**
	 * Aplica o formato de CNP. Ex: 1234567891012 para 12.345.678/9101-23
	 * 
	 * @param cnpj
	 *            - CNPJ formatado.
	 * @return
	 * @throws ParseException 
	 */
	public static String formatarCNPJ(String cnpj) throws ParseException  {
		if(cnpj != null) {
			cnpj = cnpj.replaceAll("\\.", "").replaceAll("\\/", "").replaceAll("\\-", "");
			
			MaskFormatter mf = new MaskFormatter("##.###.###/####-##");  
		    mf.setValueContainsLiteralCharacters(false);  
		    return mf.valueToString(cnpj);
		}
		
		return "";
	}

	public static String classNivPadr(String s) {
		if (s.trim().length() == 0)
			return "";
		String classe, nivel, padrao, teste = s.substring(0, 1);
		int tem = teste.indexOf('N');
		char aux = '"';
		if (tem < 0) {
			classe = s.substring(0, 1);
			nivel = s.substring(2, 4);
			padrao = s.substring(5);
		} else {
			classe = s.substring(3, 4);
			nivel = s.substring(0, 2);
			padrao = s.substring(4);
		}

		if (nivel.indexOf('A') > 0)
			nivel = "Auxiliar";

		if (nivel.indexOf('I') > 0)
			nivel = "Intermedi�rio";

		if (nivel.indexOf('S') > 0)
			nivel = "Superior";

		return "N�vel " + nivel + ", Classe " + aux + classe + aux
				+ ", Padr�o " + aux + padrao + aux;
	}

	public static String buscarLotacaoPorSigla(String sigla, Long idOrgaoUsu)
			throws AplicacaoException {

		CpOrgaoUsuario orgaoUsu = new CpOrgaoUsuario();
		orgaoUsu.setIdOrgaoUsu(idOrgaoUsu);

		final DpLotacao lotacao = new DpLotacao();
		lotacao.setSigla(sigla);
		lotacao.setOrgaoUsuario(orgaoUsu);

		final DpLotacao lotRetorno = CpDao.getInstance().consultarPorSigla(
				lotacao);

		return lotRetorno.getDescricao();
	}

	public static String obterExtensaoBuscaTextual(CpOrgaoUsuario orgao,
			String valFullText) throws Exception {
		ProcessadorModeloFreemarker p = new ProcessadorModeloFreemarker();
		Map attrs = new HashMap();
		attrs.put("valFullText", valFullText);
		attrs.put("nmMod", "macro extensaoBuscaTextual");
		attrs.put("template", "[@extensaoBuscaTextual/]");
		return p.processarModelo(orgao, attrs, null);
	}

	public static String obterExtensaoEditor(CpOrgaoUsuario orgao, String nome,
			String conteudo, String serverAndPort) throws Exception {
		ProcessadorModeloFreemarker p = new ProcessadorModeloFreemarker();
		Map attrs = new HashMap();
		attrs.put("serverAndPort", serverAndPort);
		attrs.put("nomeExtensaoJsp", nome);
		attrs.put("conteudoExtensaoJsp", conteudo);
		attrs.put("nmMod", "macro extensaoEditor");
		attrs.put("template", "[@extensaoEditor/]");
		return p.processarModelo(orgao, attrs, null);
	}




	public static String obterExtensaoAssinador(CpOrgaoUsuario orgao,
			String requestScheme, String requestServerName,

			String requestLocalPort, String urlPath, String jspServer,
			String nextURL, String botao, String lote) throws Exception {
		ProcessadorModeloFreemarker p = new ProcessadorModeloFreemarker();
		Map attrs = new HashMap();
		String chaveUrl = null;
		String urlStr = null;


		attrs.put("code_base_path",
				SigaExProperties.getAssinaturaCodebasePath());
		attrs.put("messages_url_path",
				SigaExProperties.getAssinaturaMessagesURLPath());
		attrs.put("policy_url_path",
				SigaExProperties.getAssinaturaPorlicyUrlPath());


		attrs.put("request_scheme", requestScheme);
		attrs.put("request_serverName", requestServerName);
		attrs.put("request_localPort", requestLocalPort);
		attrs.put("urlPath", urlPath);
		attrs.put("jspServer", jspServer);
		attrs.put("nextURL", nextURL);
		attrs.put("botao", botao);
		attrs.put("lote", lote);
		attrs.put("nmMod", "macro extensaoAssinador");
		attrs.put("template", "[@extensaoAssinador/]");
		return p.processarModelo(orgao, attrs, null);
	}


	public static boolean contemTagHTML(String parametro) {
		return parametro.split("\\<.*\\>").length > 1;
	}
	
	/**
	 * Retorna a data no formato dd/mm/aaaa, por exemplo, 01/02/2010.
	*/
	public static String getDataDDMMYYYY(Date data) {
		if (data != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			return df.format(data);
		}
		return "";
	}
	
	public static List<ExTpDocPublicacao> listaPublicacao(Long idMod) {
		ExModelo mod = dao().consultar(idMod, ExModelo.class, false);
		return PublicacaoDJEBL.obterListaTiposMaterias(mod.getHisIdIni());
	}
	
	public static CalculoPCD calculoPCD(String cargo, String funcao, DpPessoa beneficiario, String dataInicio, String dataFim, 
			Boolean solicitaAuxTransporte, Boolean carroOficial, Integer pernoite, Float descontoSalario, Float valorConcedido, Boolean executorMandado ) {
		CalculoPCD calculo = new CalculoPCD();
		
		calculo.setCargo(cargo);
		calculo.setFuncao(funcao);
		calculo.setBeneficiario(beneficiario);
		calculo.setDataInicio(dataInicio);
		calculo.setDataFim(dataFim);
		calculo.setSolicitaAuxTransporte(solicitaAuxTransporte);
		calculo.setCarroOficial(carroOficial);
		calculo.setPernoite(pernoite);
		calculo.setDescontoSalario(descontoSalario);
		calculo.setValorConcedido(valorConcedido);
		calculo.setExecutorMandado(executorMandado);
		
		
		return calculo;
	}
	
	public static List<ExDocumento> listaDocsAPublicarBoletim(CpOrgaoUsuario orgaoUsuario) {
		final List<ExDocumento> l = dao().consultarPorModeloParaPublicar(orgaoUsuario);
		return l;
	}	
	
	
	public static List<ExDocumento> listaDocsAPublicarBoletimPorDocumento(ExDocumento doc) {
        if (doc.getIdDoc() != null) {
                        final List<ExDocumento> l = dao().consultarPorBoletimParaPublicar(doc);
                        return l;
        }

        return null;
	}
	
	public static String webservice(String url, String corpo, Integer timeout) {
		try {
			HashMap<String,String> headers = new HashMap<String, String>();
			headers.put("Content-Type", "text/xml;charset=UTF-8");
			String s = ConexaoHTTP.get(url, headers, timeout, corpo);
			return s;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	public static NodeModel parseXML(String xml) throws Exception  {
		xml = URLDecoder.decode(xml, "UTF-8");
		// Remover todos os namespaces
		xml = xml.replaceAll("(</?)[a-z]+:", "$1");
		xml = xml.replaceAll("( xmlns(:[a-z]+)?=\"[^\"]+\")","");
		xml = xml.replaceAll(" ([a-z]+:)([a-zA-Z]+=\"[^\"]+\")"," $2");
		InputSource inputSource = new InputSource( new StringReader( xml ) );
		return freemarker.ext.dom.NodeModel.parse(inputSource);
	}
	
	public static boolean orgaoUsuarioPresenteNoCabecalhoModelo() throws Exception {
		return SigaExProperties.isOrgaoUsuarioPresenteNoCabecalhoModelo();		
	}
	
	public static boolean requisicaoVeioDoLinuxEFirefox(HttpServletRequest request){
		String userAgent =  request.getHeader("user-agent");
		boolean resultado = false;
		if(userAgent.indexOf("Linux") != -1 && userAgent.indexOf("Firefox") != -1){
			resultado = true;
		}
		return resultado;		
	}
}
