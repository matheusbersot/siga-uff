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
package br.gov.jfrj.siga.ex.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;

import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.dp.CpMarcador;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExMarca;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.ex.util.ExGraphRelacaoDocs;
import br.gov.jfrj.siga.ex.util.ExGraphTramitacao;
import br.gov.jfrj.siga.ex.util.ProcessadorModeloFreemarker;

public class ExDocumentoVO extends ExVO {
	DpPessoa titular;
	DpLotacao lotaTitular;
	ExDocumento doc;
	ExMobil mob;
	String classe;
	List<ExMobilVO> mobs = new ArrayList<ExMobilVO>();
	List<ExDocumentoVO> documentosPublicados = new ArrayList<ExDocumentoVO>();
	ExDocumentoVO boletim;
	Map<ExMobil, Set<ExMarca>> marcasPorMobil = new LinkedHashMap<ExMobil, Set<ExMarca>>();
	String outrosMobsLabel;
	String nomeCompleto;
	String dtDocDDMMYY;
	String subscritorString;
	String classificacaoDescricaoCompleta;
	List<String> tags;
	String destinatarioString;
	String descrDocumento;
	String nmNivelAcesso;
	String paiSigla;
	String tipoDocumento;

	String dtFinalizacao;
	String nmArqMod;
	String conteudoBlobHtmlString;
	String sigla;
	String fisicoOuEletronico;
	boolean fDigital;
	Map<ExMovimentacao, Boolean> cossignatarios = new HashMap<ExMovimentacao, Boolean>();
	String dadosComplementares;
	String forma;
	String modelo;
	String tipoFormaDocumento;
	String cadastranteString;
	String lotaCadastranteString;
	ExGraphTramitacao dotTramitacao;
	ExGraphRelacaoDocs dotRelacaoDocs;
	private List<Object> listaDeAcessos;

	public ExDocumentoVO(ExDocumento doc, ExMobil mob, DpPessoa titular,
			DpLotacao lotaTitular, boolean completo, boolean exibirAntigo)
			throws Exception {
		this.titular = titular;
		this.lotaTitular = lotaTitular;
		this.doc = doc;
		this.mob = mob;
		this.sigla = doc.getSigla();
		this.descrDocumento = doc.getDescrDocumento();

		if (!completo)
			return;

		this.nomeCompleto = doc.getNomeCompleto();
		this.dtDocDDMMYY = doc.getDtDocDDMMYY();
		this.subscritorString = doc.getSubscritorString();
		this.cadastranteString = doc.getCadastranteString();
		if (doc.getLotaCadastrante() != null)
			this.lotaCadastranteString = "("
					+ doc.getLotaCadastrante().getSigla() + ")";
		else
			this.lotaCadastranteString = "";

		if (doc.getExClassificacaoAtual() != null)
			this.classificacaoDescricaoCompleta = doc.getExClassificacaoAtual()
					.getAtual().getDescricaoCompleta();
		this.destinatarioString = doc.getDestinatarioString();
		if (doc.getExNivelAcesso() != null)
			this.nmNivelAcesso = doc.getExNivelAcesso().getNmNivelAcesso();
		this.listaDeAcessos = doc.getListaDeAcessos();
		if (doc.getExMobilPai() != null)
			this.paiSigla = doc.getExMobilPai().getSigla();
		if (doc.getExTipoDocumento() != null)
			switch (doc.getExTipoDocumento().getId().intValue()) {
			case 1:
				this.tipoDocumento = "interno";
				break;
			case 2:
				this.tipoDocumento = "interno_importado";
				break;
			case 3:
				this.tipoDocumento = "externo";
				break;
			}
		if (doc.getExFormaDocumento().getExTipoFormaDoc() != null)
			switch (doc.getExFormaDocumento().getExTipoFormaDoc().getId()
					.intValue()) {
			case 1:
				this.tipoFormaDocumento = "expediente";
				break;
			case 2:
				this.tipoFormaDocumento = "processo_administrativo";
				break;
			}

		this.dtFinalizacao = doc.getDtFinalizacaoDDMMYY();
		if (doc.getExModelo() != null)
			this.nmArqMod = doc.getExModelo().getNmArqMod();

		this.conteudoBlobHtmlString = doc
				.getConteudoBlobHtmlStringComReferencias();

		if (doc.isEletronico()) {
			this.classe = "header_eletronico";
			this.fisicoOuEletronico = "Documento Eletr�nico";
			this.fDigital = true;
		} else {
			this.classe = "header";
			this.fisicoOuEletronico = "Documento F�sico";
			this.fDigital = false;
		}

		for (ExMovimentacao movCossig : doc.getMovsCosignatario())
			cossignatarios.put(
					movCossig,
					Ex.getInstance()
							.getComp()
							.podeExcluirCosignatario(titular, lotaTitular,
									doc.getMobilGeral(), movCossig));

		this.forma = doc.getExFormaDocumento() != null ? doc
				.getExFormaDocumento().getDescricao() : "";
		this.modelo = doc.getExModelo() != null ? doc.getExModelo().getNmMod()
				: "";

		if (mob != null) {
			SortedSet<ExMobil> mobsDoc;
			if (doc.isProcesso())
				mobsDoc = doc.getExMobilSetInvertido();
			else
				mobsDoc = doc.getExMobilSet();

			for (ExMobil m : mobsDoc) {
				if (mob.isGeral() || m.isGeral()
						|| mob.getId().equals(m.getId()))
					mobs.add(new ExMobilVO(m, titular, lotaTitular, completo));
			}

			addAcoes(doc, titular, lotaTitular, exibirAntigo);
		}

		addDadosComplementares();

		tags = new ArrayList<String>();
		if (doc.getExClassificacao() != null) {
			String classificacao = doc.getExClassificacao().getDescricao();
			if (classificacao != null && classificacao.length() != 0) {
				String a[] = classificacao.split(": ");
				for (String s : a) {
					String ss = "@" + Texto.slugify(s, true, true);
					if (!tags.contains(ss)) {
						tags.add(ss);
					}
				}
			}
		}
		if (doc.getExModelo() != null) {
			String ss = "@"
					+ Texto.slugify(doc.getExModelo().getNmMod(), true, true);
			if (!tags.contains(ss)) {
				tags.add(ss);
			}
		}

		if (doc.getDocumentosPublicadosNoBoletim() != null) {
			for (ExDocumento documentoPublicado : doc
					.getDocumentosPublicadosNoBoletim()) {
				documentosPublicados.add(new ExDocumentoVO(documentoPublicado));
			}
		}

		if (doc.getPublicadoNoBoletim() != null)
			boletim = new ExDocumentoVO(doc.getPublicadoNoBoletim());

	}

	public List<Object> getListaDeAcessos() {
		return listaDeAcessos;
	}

	public ExDocumentoVO(ExDocumento doc) throws Exception {
		this.doc = doc;
		this.sigla = doc.getSigla();
		this.nomeCompleto = doc.getNomeCompleto();
		this.dtDocDDMMYY = doc.getDtDocDDMMYY();
		this.descrDocumento = doc.getDescrDocumento();
		if (doc.isEletronico()) {
			this.classe = "header_eletronico";
			this.fisicoOuEletronico = "Documento Eletr�nico";
			this.fDigital = true;
		} else {
			this.classe = "header";
			this.fisicoOuEletronico = "Documento F�sico";
			this.fDigital = false;
		}
	}

	public void exibe() {
		List<Long> movimentacoesPermitidas = new ArrayList<Long>();

		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA_A_DOCUMENTO_EXTERNO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA_EXTERNO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANOTACAO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DISPONIBILIZACAO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO_BOLETIM);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_PUBLICACAO_BOLETIM);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_PEDIDO_PUBLICACAO);
		movimentacoesPermitidas
				.add(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ENCERRAMENTO_DE_VOLUME);

		List<Long> marcasGeralPermitidas = new ArrayList<Long>();
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_A_ELIMINAR);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_ARQUIVADO_CORRENTE);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_ARQUIVADO_INTERMEDIARIO);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_ARQUIVADO_PERMANENTE);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_EM_EDITAL_DE_ELIMINACAO);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_PUBLICACAO_SOLICITADA);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_PUBLICADO);
		marcasGeralPermitidas
				.add(CpMarcador.MARCADOR_RECOLHER_PARA_ARQUIVO_PERMANENTE);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_REMETIDO_PARA_PUBLICACAO);
		marcasGeralPermitidas
				.add(CpMarcador.MARCADOR_TRANSFERIR_PARA_ARQUIVO_INTERMEDIARIO);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_PENDENTE_DE_ASSINATURA);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_COMO_SUBSCRITOR);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_REVISAR);
		marcasGeralPermitidas
				.add(CpMarcador.MARCADOR_ANEXO_PENDENTE_DE_ASSINATURA);
		marcasGeralPermitidas
				.add(CpMarcador.MARCADOR_TRANSFERIR_PARA_ARQUIVO_INTERMEDIARIO);
		marcasGeralPermitidas.add(CpMarcador.MARCADOR_PENDENTE_DE_ANEXACAO);

		for (ExMobilVO mobVO : mobs) {

			// Limpa as Movimenta��es
			List<ExMovimentacaoVO> movimentacoesFinais = new ArrayList<ExMovimentacaoVO>();
			List<ExMovimentacao> juntadasRevertidas = new ArrayList<ExMovimentacao>();

			for (ExMovimentacaoVO exMovVO : mobVO.getMovs()) {
				if (movimentacoesPermitidas.contains(exMovVO.getIdTpMov())) {
					if (exMovVO.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA) {
						juntadasRevertidas.add(exMovVO.getMov()
								.getExMovimentacaoRef());
						// Edson: se n�o gerou pe�a, nem mostra o
						// desentranhamento
						if (exMovVO.getMov().getConteudoBlobMov() == null)
							continue;
					}
					if (!exMovVO.isCancelada()
							&& !juntadasRevertidas.contains(exMovVO.getMov()))
						movimentacoesFinais.add(exMovVO);
				}

			}

			mobVO.setMovs(movimentacoesFinais);
		}

		ExMobilVO mobilGeral = null;
		ExMobilVO mobilEspecifico = null;

		for (ExMobilVO mobilVO : mobs) {
			if (mobilVO.getMob().isGeral())
				mobilGeral = mobilVO;
			else
				mobilEspecifico = mobilVO;
		}

		for (ExMobil cadaMobil : doc.getExMobilSet()) {
			if (!cadaMobil.isGeral())
				marcasPorMobil.put(cadaMobil, cadaMobil.getExMarcaSet());
		}

		if (mobilEspecifico != null && mobilGeral != null) {
			mobilEspecifico.getAcoes().addAll(mobilGeral.getAcoes());
			mobilEspecifico.getMovs().addAll(mobilGeral.getMovs());
			mobilEspecifico.anexosNaoAssinados
					.addAll(mobilGeral.anexosNaoAssinados);
			for (ExMarca m : mobilGeral.getMarcasAtivas())
				if (marcasGeralPermitidas.contains(m.getCpMarcador()
						.getIdMarcador()))
					mobilEspecifico.getMarcasAtivas().add(m);
			for (ExMarca m : mobilGeral.getMob().getExMarcaSet())
				if (marcasGeralPermitidas.contains(m.getCpMarcador()
						.getIdMarcador()))
					for (ExMobil cadaMobil : marcasPorMobil.keySet())
						marcasPorMobil.get(cadaMobil).add(m);
			mobs.remove(mobilGeral);
		}

		// Edson: mostra lista de vias/volumes s� se n�mero de
		// vias/volumes al�m do geral for > que 1 ou se o m�bil
		// tiver informa��es que n�o aparecem no topo da tela
		if (doc.getExMobilSet().size() > 2 || mob.temMarcaNaoAtiva())
			outrosMobsLabel = doc.isProcesso() ? "Volumes" : "Vias";

		this.dotTramitacao = new ExGraphTramitacao(mob);
		this.dotRelacaoDocs = new ExGraphRelacaoDocs(mob, titular);

	}

	/**
	 * @param doc
	 * @param titular
	 * @param lotaTitular
	 * @throws Exception
	 */
	private void addAcoes(ExDocumento doc, DpPessoa titular,
			DpLotacao lotaTitular, boolean exibirAntigo) throws Exception {
		ExVO vo = this;
		for (ExMobilVO mobvo : mobs) {
			if (mobvo.getMob().isGeral())
				vo = mobvo;
		}

		ExMobil mob = doc.getMobilGeral();

		vo.addAcao("folder_magnify", "Visualizar Dossi�", "/expediente/doc",
				"exibirProcesso", Ex.getInstance().getComp()
						.podeVisualizarImpressao(titular, lotaTitular, mob));

		vo.addAcao(
				"printer",
				"Visualizar Impress�o",
				"/arquivo",
				"exibir",
				Ex.getInstance().getComp()
						.podeVisualizarImpressao(titular, lotaTitular, mob),
				null, "&popup=true&arquivo=" + doc.getReferenciaPDF(), null,
				null, null);

		vo.addAcao(
				"lock",
				"Finalizar",
				"/expediente/doc",

				"finalizar",
				Ex.getInstance().getComp()
						.podeFinalizar(titular, lotaTitular, mob),
				"Confirma a finaliza��o do documento?", null, null, null,
				"once");

		// addAcao("Finalizar e Assinar", "/expediente/mov",
		// "finalizar_assinar",
		// podeFinalizarAssinar(titular, lotaTitular, mob),
		// "Confirma a finaliza��o do documento?", null, null, null);

		vo.addAcao("pencil", "Editar", "/expediente/doc", "editar", Ex
				.getInstance().getComp().podeEditar(titular, lotaTitular, mob));

		vo.addAcao(
				"delete",
				"Excluir",
				"/expediente/doc",
				"excluir",
				Ex.getInstance().getComp()
						.podeExcluir(titular, lotaTitular, mob),
				"Confirma a exclus�o do documento?", null, null, null, "once");

		vo.addAcao("user_add", "Incluir Cossignat�rio", "/expediente/mov",
				"incluir_cosignatario", Ex.getInstance().getComp()
						.podeIncluirCosignatario(titular, lotaTitular, mob));

		vo.addAcao(
				"attach",
				"Anexar Arquivo",
				"/expediente/mov",
				"anexar",
				Ex.getInstance().getComp()
						.podeAnexarArquivo(titular, lotaTitular, mob));
		vo.addAcao(
				"tag_yellow",
				"Fazer Anota��o",
				"/expediente/mov",
				"anotar",
				Ex.getInstance().getComp()
						.podeFazerAnotacao(titular, lotaTitular, mob));

		vo.addAcao("folder_user", "Definir Perfil", "/expediente/mov",
				"vincularPapel", Ex.getInstance().getComp()
						.podeFazerVinculacaoPapel(titular, lotaTitular, mob));

		vo.addAcao(
				"cd",
				"Download do Conte�do",
				"/expediente/doc",
				"anexo",
				Ex.getInstance().getComp()
						.podeDownloadConteudo(titular, lotaTitular, mob));

		vo.addAcao("add", "Criar Via", "/expediente/doc", "criarVia", Ex
				.getInstance().getComp()
				.podeCriarVia(titular, lotaTitular, mob), null, null, null,
				null, "once");

		vo.addAcao(
				"add",
				"Abrir Novo Volume",
				"/expediente/doc",
				"criarVolume",
				Ex.getInstance().getComp()
						.podeCriarVolume(titular, lotaTitular, mob),
				"Confirma a abertura de um novo volume?", null, null, null,
				"once");

		vo.addAcao(
				"link_add",
				"Criar Subprocesso",
				"/expediente/doc",
				"editar",
				Ex.getInstance().getComp()
						.podeCriarSubprocesso(titular, lotaTitular, mob), null,
				"mobilPaiSel.sigla=" + getSigla() + "&idForma="
						+ mob.doc().getExFormaDocumento().getIdFormaDoc(),
				null, null, null);

		vo.addAcao(
				"script_edit",
				"Registrar Assinatura Manual",
				"/expediente/mov",
				"registrar_assinatura",
				Ex.getInstance().getComp()
						.podeRegistrarAssinatura(titular, lotaTitular, mob));

		vo.addAcao(
				"script_key",
				"Assinar Digitalmente",
				"/expediente/mov",
				"assinar",
				Ex.getInstance().getComp()
						.podeAssinar(titular, lotaTitular, mob));

		if (doc.isFinalizado() && doc.getNumExpediente() != null) {
			// documentos finalizados
			if (mob.temAnexos())
				vo.addAcao("script_key", "Assinar Anexos", "/expediente/mov",
						"assinar_anexos_geral", true);

			vo.addAcao(
					"link_add",
					"Criar Anexo",
					"/expediente/doc",
					"editar",
					Ex.getInstance()
							.getComp()
							.podeAnexarArquivoAlternativo(titular, lotaTitular,
									mob), null,
					"criandoAnexo=true&mobilPaiSel.sigla=" + getSigla(), null,
					null, null);
		}

		vo.addAcao("shield", "Redefinir N�vel de Acesso", "/expediente/mov",
				"redefinir_nivel_acesso", Ex.getInstance().getComp()
						.podeRedefinirNivelAcesso(titular, lotaTitular, mob));

		vo.addAcao(
				"book_add",
				"Solicitar Publica��o no Boletim",
				"/expediente/mov",
				"boletim_agendar",
				Ex.getInstance()
						.getComp()
						.podeBotaoAgendarPublicacaoBoletim(titular,
								lotaTitular, mob));

		vo.addAcao(
				"book_link",
				"Registrar Publica��o do BIE",
				"/expediente/mov",
				"boletim_publicar",
				Ex.getInstance()
						.getComp()
						.podeBotaoAgendarPublicacaoBoletim(titular,
								lotaTitular, mob), null, null, null, null,
				"once");

		vo.addAcao(
				"error_go",
				"Refazer",
				"/expediente/doc",

				"refazer",
				Ex.getInstance().getComp()
						.podeRefazer(titular, lotaTitular, mob),
				"Esse documento ser� cancelado e seus dados ser�o copiados para um novo expediente em elabora��o. Prosseguir?",
				null, null, null, "once");

		vo.addAcao(
				"arrow_divide",
				"Duplicar",
				"/expediente/doc",
				"duplicar",
				Ex.getInstance().getComp()
						.podeDuplicar(titular, lotaTitular, mob),
				"Esta opera��o criar� um expediente com os mesmos dados do atual. Prosseguir?",
				null, null, null, "once");

		// test="${exibirCompleto != true}" />
		vo.addAcao(
				"eye",
				"Exibir Informa��es Completas",
				"/expediente/doc",
				"exibirAntigo",
				Ex.getInstance()
						.getComp()
						.podeExibirInformacoesCompletas(titular, lotaTitular,
								mob)
						&& !exibirAntigo, null, null, null, null, null);

		vo.addAcao(
				"eye",
				"Exibir Informa��es Completas",
				"/expediente/doc",
				"exibirAntigo",
				Ex.getInstance()
						.getComp()
						.podeExibirInformacoesCompletas(titular, lotaTitular,
								mob)
						&& exibirAntigo, null, "&exibirCompleto=true", null,
				null, null);

		vo.addAcao(
				"report_link",
				"Agendar Publica��o no DJE",
				"/expediente/mov",
				"agendar_publicacao",
				Ex.getInstance().getComp()
						.podeAgendarPublicacao(titular, lotaTitular, mob));

		vo.addAcao(
				"report_add",
				"Solicitar Publica��o no DJE",
				"/expediente/mov",
				"pedir_publicacao",
				Ex.getInstance().getComp()
						.podePedirPublicacao(titular, lotaTitular, mob));

		// <ww:param name="idFormaDoc">60</ww:param>
		vo.addAcao(
				"arrow_undo",
				"Desfazer Cancelamento",
				"/expediente/doc",
				"desfazerCancelamentoDocumento",
				Ex.getInstance()
						.getComp()
						.podeDesfazerCancelamentoDocumento(titular,
								lotaTitular, mob),
				"Esta opera��o anular� o cancelamento do documento e tornar� o documento novamente edit�vel. Prosseguir?",
				null, null, null, "once");

		vo.addAcao(
				"delete",
				"Cancelar Documento",
				"/expediente/doc",
				"tornarDocumentoSemEfeito",
				Ex.getInstance()
						.getComp()
						.podeTornarDocumentoSemEfeito(titular, lotaTitular, mob),
				"Esta opera��o tornar� esse documento sem efeito. Prosseguir?",
				null, null, null, "once");
	}

	public void addDadosComplementares() throws Exception {
		ProcessadorModeloFreemarker p = new ProcessadorModeloFreemarker();
		Map attrs = new HashMap();
		attrs.put("nmMod", "macro dadosComplementares");
		attrs.put("template", "[@dadosComplementares/]");
		attrs.put("doc", this.getDoc());
		dadosComplementares = p.processarModelo(doc.getOrgaoUsuario(), attrs,
				null);
	}

	public String getClasse() {
		return classe;
	}

	public String getClassificacaoDescricaoCompleta() {
		return classificacaoDescricaoCompleta;
	}

	public String getConteudoBlobHtmlString() {
		return conteudoBlobHtmlString;
	}

	public String getDescrDocumento() {
		return descrDocumento;
	}

	public String getDestinatarioString() {
		return destinatarioString;
	}

	public ExDocumento getDoc() {
		return doc;
	}

	public ExMobil getMob() {
		return mob;
	}

	public String getDtDocDDMMYY() {
		return dtDocDDMMYY;
	}

	public String getDtFinalizacao() {

		return dtFinalizacao;
	}

	public List<ExMobilVO> getMobs() {
		return mobs;
	}

	public String getNmArqMod() {
		return nmArqMod;
	}

	public String getNmNivelAcesso() {
		return nmNivelAcesso;
	}

	public String getNomeCompleto() {
		return nomeCompleto;
	}

	public String getPaiSigla() {
		return paiSigla;
	}

	public String getSigla() {
		return sigla;
	}

	public String getSiglaCurtaSubProcesso() {
		if (doc.isProcesso() && doc.getExMobilPai() != null) {
			try {
				return sigla.substring(sigla.length() - 3, sigla.length());
			} catch (Exception e) {
				return sigla;
			}
		}

		return "";

	}

	public String getSubscritorString() {
		return subscritorString;
	}

	public String getTipoDocumento() {
		return tipoDocumento;
	}

	public String getFisicoOuEletronico() {
		return fisicoOuEletronico;
	}

	public boolean isDigital() {
		return fDigital;
	}

	@Override
	public String toString() {
		String s = getSigla() + "[" + getAcoes() + "]";
		for (ExMobilVO m : getMobs()) {
			s += "\n" + m.toString();
		}
		return s;
	}

	public String getDadosComplementares() {
		return dadosComplementares;
	}

	public String getForma() {
		return forma;
	}

	public void setForma(String forma) {
		this.forma = forma;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public String getTipoFormaDocumento() {
		return tipoFormaDocumento;
	}

	public String getCadastranteString() {
		return cadastranteString;
	}

	public String getLotaCadastranteString() {
		return lotaCadastranteString;
	}

	public String getOutrosMobsLabel() {
		return outrosMobsLabel;
	}

	public ExGraphTramitacao getDotTramitacao() {
		return dotTramitacao;
	}

	public ExGraphRelacaoDocs getDotRelacaoDocs() {
		return dotRelacaoDocs;
	}

	public List<ExDocumentoVO> getDocumentosPublicados() {
		return documentosPublicados;
	}

	public ExDocumentoVO getBoletim() {
		return boletim;
	}

	public Map<ExMobil, Set<ExMarca>> getMarcasPorMobil() {
		return marcasPorMobil;
	}

	public void setMarcasPorMobil(Map<ExMobil, Set<ExMarca>> marcasPorMobil) {
		this.marcasPorMobil = marcasPorMobil;
	}
	
	public Map<ExMovimentacao, Boolean> getCossignatarios() {
		return cossignatarios;
	}

	public void setCossignatarios(Map<ExMovimentacao, Boolean> cossignatarios) {
		this.cossignatarios = cossignatarios;
	}

}