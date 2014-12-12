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
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.gov.jfrj.siga.base.SigaCalendar;
import br.gov.jfrj.siga.dp.CpMarcador;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExMarca;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;
import br.gov.jfrj.siga.ex.bl.Ex;

public class ExMobilVO extends ExVO {

	ExMobil mob;
	String sigla;
	List<ExMobilVO> apensos = new ArrayList<ExMobilVO>();
	//List<ExDocumentoVO> filhos = new ArrayList<ExDocumentoVO>();
	List<ExDocumentoVO> expedientesFilhosNaoCancelados = new ArrayList<ExDocumentoVO>();
	List<ExDocumentoVO> processosFilhosNaoCancelados = new ArrayList<ExDocumentoVO>();

	List<ExMovimentacaoVO> anexosNaoAssinados = new ArrayList<ExMovimentacaoVO>();
	List<ExMovimentacaoVO> despachosNaoAssinados = new ArrayList<ExMovimentacaoVO>();
	List<ExDocumentoVO> expedientesFilhosNaoJuntados = new ArrayList<ExDocumentoVO>();
	List<ExMovimentacaoVO> pendenciasDeAnexacao = new ArrayList<ExMovimentacaoVO>();

	List<ExMovimentacaoVO> movs = new ArrayList<ExMovimentacaoVO>();
	List<ExMarca> marcasAtivas = new ArrayList<ExMarca>();
	List<DuracaoVO> duracoes = new ArrayList<DuracaoVO>();
	Long byteCount;
	Integer pagInicial;
	Integer pagFinal;
	String tamanhoDeArquivo;
	boolean ocultar;

	public List<ExMovimentacaoVO> getMovs() {
		return movs;
	}

	public void setMovs(List<ExMovimentacaoVO> movs) {
		this.movs = movs;
	}

	public List<ExMarca> getMarcasAtivas() {
		return marcasAtivas;
	}

	public void setMarcasAtivas(List<ExMarca> marcasAtivas) {
		this.marcasAtivas = marcasAtivas;
	}

	public ExMobil getMob() {
		return mob;
	}

	public void setMob(ExMobil mob) {
		this.mob = mob;
	}

	public ExMobilVO(ExMobil mob, DpPessoa titular, DpLotacao lotaTitular,
			boolean completo) throws Exception {
		this(mob, titular, lotaTitular, completo, null, false);
	}

	public ExMobilVO(ExMobil mob, DpPessoa titular, DpLotacao lotaTitular,
			boolean completo, Long tpMov, boolean movAssinada) throws Exception {
		this.mob = mob;
		this.sigla = mob.getSigla();

		if (!completo || mob.isEliminado())
			return;

		long tempoIni = System.currentTimeMillis();

		/*
		 * Markenson: O c�digo abaixo foi comentado por quest�es de desempenho.
		 * Deve ser estudada uma maneira mais eficiente de calcular o tamanho
		 * dos PDFs
		 */

		// byteCount, pagIni e pagFim
		// if (mob.getExDocumento().isEletronico()){

		// byteCount = mob.getByteCount();
		// if (byteCount != null && byteCount > 0)
		// tamanhoDeArquivo = FormataTamanhoDeArquivo
		// .converterEmTexto(byteCount);
		// }

		for (ExMobil m : mob.getApensosDiretosExcetoVolumeApensadoAoProximo()) {
			if (m.isEliminado())
				continue;
			apensos.add(new ExMobilVO(m, titular, lotaTitular, false));
		}
		System.out.println(mob.getExDocumento().getCodigoString()
				+ ": aExibir - mobil " + mob.getNumSequencia()
				+ " - adicao apensos: "
				+ (System.currentTimeMillis() - tempoIni));

		tempoIni = System.currentTimeMillis();
		for (ExDocumento d : mob.getExDocumentoFilhoSet()) {
			if (d.isEliminado())
				continue;
			//filhos.add(new ExDocumentoVO(d, null, titular, lotaTitular, false));
			if (!d.isFinalizado() || !d.isCancelado()) {
				if (d.isExpediente())
					expedientesFilhosNaoCancelados.add(new ExDocumentoVO(d,
							null, titular, lotaTitular, false,false));
				else
					processosFilhosNaoCancelados.add(new ExDocumentoVO(d, null,
							titular, lotaTitular, false,false));
			}
		}
		
		for (ExDocumento doc : mob.getDocsFilhosNaoJuntados())
			expedientesFilhosNaoJuntados.add(new ExDocumentoVO(doc, null,
					titular, lotaTitular, false,false));

		System.out.println(mob.getExDocumento().getCodigoString()
				+ ": aExibir - mobil " + mob.getNumSequencia()
				+ " - adicao filhos: "
				+ (System.currentTimeMillis() - tempoIni));

		tempoIni = System.currentTimeMillis();
		addAcoes(mob, titular, lotaTitular);
		System.out
				.println(mob.getExDocumento().getCodigoString()
						+ ": aExibir - mobil " + mob.getNumSequencia()
						+ " - adicao acoes: "
						+ (System.currentTimeMillis() - tempoIni));

		tempoIni = System.currentTimeMillis();

		if (tpMov == null)
			for (ExMovimentacao mov : mob.getCronologiaSet()) {
				movs.add(new ExMovimentacaoVO(this, mov, titular, lotaTitular));
			}
		else
			for (ExMovimentacao mov : mob.getMovimentacoesPorTipo(tpMov)) {
				if (!movAssinada) {
					if (!mov.isAssinada() && !mov.isCancelada())
						movs.add(new ExMovimentacaoVO(this, mov, titular,
								lotaTitular));
				} else {
					if (mov.isAssinada())
						movs.add(new ExMovimentacaoVO(this, mov, titular,
								lotaTitular));
				}
			}

		// Edson: infelizmente, a� embaixo estamos varrendo de novo as movs.
		// Melhorar?

		if (mob.doc().isEletronico()) {
			for (ExMovimentacao mov : mob.getAnexosNaoAssinados())
				anexosNaoAssinados.add(new ExMovimentacaoVO(this, mov, titular,
						lotaTitular));

			for (ExMovimentacao mov : mob.getDespachosNaoAssinados())
				despachosNaoAssinados.add(new ExMovimentacaoVO(this, mov,
						titular, lotaTitular));
		}
		
		if(mob.getPendenciasDeAnexacao() != null) {
			for (ExMovimentacao mov : mob.getPendenciasDeAnexacao())
				pendenciasDeAnexacao.add(new ExMovimentacaoVO(this, mov,
						titular, lotaTitular));
		}
		
		marcasAtivas.addAll(mob.getExMarcaSetAtivas());

		// Calcula o tempo que o documento ficou em cada uma das lota��es por
		// onde ele passou.
		ExMovimentacaoVO movVOIni = null;
		ExMovimentacaoVO movVOUlt = null;
		int i = 1;
		int duracaoSpan = 0;
		Collections.reverse(movs);
		for (ExMovimentacaoVO movVO : movs) {
			if (movVOIni == null) {
				movVOIni = movVO;
			}
			// if (movVO.idTpMov != 14 && !movVO.isCancelada())
			duracaoSpan++;

			if (i == movs.size()
					|| (movVO.mov
							.getExTipoMovimentacao()
							.getId()
							.equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO) && (!movVO
							.isCancelada()))) {
				if (i == movs.size()) {
					duracaoSpan++;
				}
				if (i == movs.size() || movVOUlt == null)
					movVOUlt = movVO;
				SigaCalendar lIni = new SigaCalendar(movVOIni.mov.getDtIniMov()
						.getTime());
				SigaCalendar lFim = new SigaCalendar(movVOUlt.mov.getDtIniMov()
						.getTime());

				DuracaoVO d = new DuracaoVO();
				long l = lFim.getUnixDay() - lIni.getUnixDay();
				if (l == 0) {
					d.setDuracao(lIni.diffCompact(lFim));
					if (d.getDuracao().endsWith("m"))
						d.setDuracao(d.getDuracao() + "in");
				} else {
					d.setDuracao(Long.toString(l) + " dia"
							+ (l == 1L ? "" : "s"));
				}
				// movVOUlt.duracaoSpan = duracaoSpan;
				d.setSpan(duracaoSpan);
				d.setSpanExibirCompleto(duracaoSpan);
				duracoes.add(d);
				movVOIni = movVOUlt;
				duracaoSpan = 0;
			}
			i++;
			movVOUlt = movVO;
		}
		Collections.reverse(movs);
		Collections.reverse(duracoes);

		int j = 0;
		int span = 0;
		for (ExMovimentacaoVO movVO : movs) {
			span++;
			if (movVO.idTpMov == 14 || movVO.isCancelada()) {
				duracoes.get(j).setSpan(duracoes.get(j).getSpan() - 1);
			}
			if (span == duracoes.get(j).getSpanExibirCompleto()) {
				j++;
				span = 0;
			}
		}

		// Ocultar movimenta��es de cancelamento
		j = 0;
		span = 0;
		for (ExMovimentacaoVO movVO : movs) {
			if (movVO.idTpMov != 14 && !movVO.isCancelada()) {
				if (span == 0) {
					movVO.duracao = duracoes.get(j).getDuracao();
					movVO.duracaoSpan = duracoes.get(j).getSpan();
					span = duracoes.get(j).getSpan();
					j++;
				}
				span--;
			}
		}

		// Exibir completo
		j = 0;
		span = 0;
		for (ExMovimentacaoVO movVO : movs) {
			if (span == 0) {
				movVO.duracao = duracoes.get(j).getDuracao();
				movVO.duracaoSpanExibirCompleto = duracoes.get(j)
						.getSpanExibirCompleto();
				span = duracoes.get(j).getSpanExibirCompleto();
				j++;
			}
			span--;
		}

		System.out.println(mob.getExDocumento().getCodigoString()
				+ ": aExibir - mobil " + mob.getNumSequencia()
				+ " - adicao movs: " + (System.currentTimeMillis() - tempoIni));

	}

	/**
	 * @param mob
	 * @param titular
	 * @param lotaTitular
	 * @throws Exception
	 */
	private void addAcoes(ExMobil mob, DpPessoa titular, DpLotacao lotaTitular)
			throws Exception {
		if (!mob.isGeral()) {
			addAcao("application_side_tree",
					"Visualizar Dossi�",
					"/expediente/doc",
					"exibirProcesso",
					Ex.getInstance().getComp()
							.podeVisualizarImpressao(titular, lotaTitular, mob),
					null, null, null, null, "once");

			addAcao("printer",
					"Visualizar Impress�o",
					"/arquivo",
					"exibir",
					Ex.getInstance().getComp()
							.podeVisualizarImpressao(titular, lotaTitular, mob),
					null, "&popup=true&arquivo=" + mob.getReferenciaPDF(),
					null, null, null);

			addAcao("link_add",
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
		addAcao("link_break", "Desentranhar", "/expediente/mov",
				"cancelar_juntada", Ex.getInstance().getComp()
						.podeCancelarJuntada(titular, lotaTitular, mob), null,
				null, null, null, "once");

		addAcao("link_delete",
				"Desapensar",
				"/expediente/mov",
				"desapensar",
				Ex.getInstance().getComp()
						.podeDesapensar(titular, lotaTitular, mob), null, null,
				null, null, "once");

		addAcao("email_open",
				"Receber",
				"/expediente/mov",
				"receber",
				Ex.getInstance().getComp()
						.podeReceber(titular, lotaTitular, mob), null, null,
				null, null, "once");

		addAcao("email_edit",
				"Despachar/Transferir",
				"/expediente/mov",
				"transferir",
				Ex.getInstance().getComp()
						.podeDespachar(titular, lotaTitular, mob)
						|| Ex.getInstance().getComp()
								.podeTransferir(titular, lotaTitular, mob),
				null, "&popup=true", null, null, null);

		if (mob.isVia() || mob.isVolume()) {
			addAcao("attach",
					"Anexar Arquivo",
					"/expediente/mov",
					"anexar",
					Ex.getInstance().getComp()
							.podeAnexarArquivo(titular, lotaTitular, mob));
			addAcao("tag_yellow",
					"Fazer Anota��o",
					"/expediente/mov",
					"anotar",
					Ex.getInstance().getComp()
							.podeFazerAnotacao(titular, lotaTitular, mob));
		}

		addAcao("package", "Arq. Corrente", "/expediente/mov",
				"arquivar_corrente_gravar", Ex.getInstance().getComp()
						.podeArquivarCorrente(titular, lotaTitular, mob), null,
				null, null, null, "once");

		addAcao("database_add",
				"Indicar para Guarda Permanente",
				"/expediente/mov",
				"indicar_permanente",
				Ex.getInstance().getComp()
						.podeIndicarPermanente(titular, lotaTitular, mob));

		addAcao("database_delete",
				"Reverter Ind. Guarda Permanente",
				"/expediente/mov",
				"reverter_indicacao_permanente",
				Ex.getInstance()
						.getComp()
						.podeReverterIndicacaoPermanente(titular, lotaTitular,
								mob));

		addAcao("page_red",
				"Retirar de Edital de Elimina��o",
				"/expediente/mov",
				"retirar_de_edital_eliminacao",
				Ex.getInstance()
						.getComp()
						.podeRetirarDeEditalEliminacao(titular, lotaTitular,
								mob));

		addAcao("table_edit",
				"Reclassificar",
				"/expediente/mov",
				"reclassificar",
				Ex.getInstance().getComp()
						.podeReclassificar(titular, lotaTitular, mob));

		addAcao("table", "Avaliar", "/expediente/mov", "avaliar", Ex
				.getInstance().getComp().podeAvaliar(titular, lotaTitular, mob));

		addAcao("hourglass_add",
				"Sobrestar",
				"/expediente/mov",
				"sobrestar_gravar",
				Ex.getInstance().getComp()
						.podeSobrestar(titular, lotaTitular, mob), null, null,
				null, null, "once");

		addAcao("database",
				"Recolher ao Arq. Permanente",
				"/expediente/mov",
				"arquivar_permanente_gravar",
				Ex.getInstance().getComp()
						.podeBotaoArquivarPermanente(titular, lotaTitular, mob),
				null, null, null, null, "once");

		addAcao("box",
				"Arq. Intermedi�rio",
				"/expediente/mov",
				"arquivar_intermediario",
				Ex.getInstance()
						.getComp()
						.podeBotaoArquivarIntermediario(titular, lotaTitular,
								mob), null, null, null, null, "once");

		addAcao("package_go", "Desarq. Corrente", "/expediente/mov",
				"reabrir_gravar", Ex.getInstance().getComp()
						.podeDesarquivarCorrente(titular, lotaTitular, mob),
				null, null, null, null, "once");

		addAcao("box_go",
				"Desarq. Intermedi�rio",
				"/expediente/mov",
				"desarquivar_intermediario_gravar",
				Ex.getInstance()
						.getComp()
						.podeBotaoDesarquivarIntermediario(titular,
								lotaTitular, mob), null, null, null, null,
				"once");

		addAcao("hourglass_delete", "Desobrestar", "/expediente/mov",
				"desobrestar_gravar", Ex.getInstance().getComp()
						.podeDesobrestar(titular, lotaTitular, mob), null,
				null, null, null, "once");

		addAcao("link", "Juntar", "/expediente/mov", "juntar", Ex.getInstance()
				.getComp().podeJuntar(titular, lotaTitular, mob));

		addAcao("page_find",
				"Vincular",
				"/expediente/mov",
				"referenciar",
				Ex.getInstance().getComp()
						.podeReferenciar(titular, lotaTitular, mob));

		addAcao("link_add", "Apensar", "/expediente/mov", "apensar", Ex
				.getInstance().getComp().podeApensar(titular, lotaTitular, mob));

		// N�o aparece a op��o de Cancelar Movimenta��o para documentos
		// tempor�rios
		if (mob.getExDocumento().isFinalizado()
				&& mob.getUltimaMovimentacaoNaoCancelada() != null
				&& mob.getUltimaMovimentacaoNaoCancelada()
						.getExTipoMovimentacao().getIdTpMov() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO)
			addAcao("arrow_undo",
					"Desfazer "
							+ mob.getDescricaoUltimaMovimentacaoNaoCancelada(),
					"/expediente/mov",
					"cancelarMovimentacao",
					Ex.getInstance()
							.getComp()
							.podeCancelarMovimentacao(titular, lotaTitular, mob),
					"Confirma o cancelamento da �ltima movimenta��o("
							+ mob.getDescricaoUltimaMovimentacaoNaoCancelada()
							+ ")?", null, null, null, "once"); // popup,
		// exibir+completo,
		// confirmacao

		addAcao("folder_page_white", "Encerrar Volume", "/expediente/mov",
				"encerrar_volume_gravar", Ex.getInstance().getComp()
						.podeEncerrarVolume(titular, lotaTitular, mob),
				"Confirma o encerramento do volume?", null, null, null, "once");

		addAcao("cancel", "Cancelar Via", "/expediente/mov",
				"cancelarMovimentacao", Ex.getInstance().getComp()
						.podeCancelarVia(titular, lotaTitular, mob),
				"Confirma o cancelamento da via?", null, null, null, "once");

		addAcao("brick", "Autuar", "/expediente/doc", "editar", Ex
				.getInstance().getComp().podeAutuar(titular, lotaTitular, mob),
				null, "idMobilAutuado=" + mob.getId() + "&autuando=true", null,
				null, null);
	}

	public String getMarcadoresEmHtml(DpPessoa pess, DpLotacao lota) {
		StringBuilder sb = new StringBuilder();

		// Marcacoes para a propria lotacao e para a propria pessoa ou sem
		// informacao de pessoa
		//
		for (ExMarca mar : getMarcasAtivas()) {
			if (mar.getCpMarcador().getIdMarcador() != CpMarcador.MARCADOR_EM_TRANSITO
					&& mar.getCpMarcador().getIdMarcador() != CpMarcador.MARCADOR_EM_TRANSITO_ELETRONICO
					&& ((mar.getDpLotacaoIni() != null && lota.getIdInicial()
							.equals(mar.getDpLotacaoIni().getIdInicial())) || mar
							.getDpLotacaoIni() == null)
					&& (mar.getDpPessoaIni() == null || pess.getIdInicial()
							.equals(mar.getDpPessoaIni().getIdInicial()))) {
				if (sb.length() > 0)
					sb.append(", ");
				sb.append(mar.getCpMarcador().getDescrMarcador());
			}
		}

		// Marcacoes para a propria lotacao e para outra pessoa
		//
		if (sb.length() == 0) {
			for (ExMarca mar : getMarcasAtivas()) {
				if (mar.getCpMarcador().getIdMarcador() != CpMarcador.MARCADOR_EM_TRANSITO
						&& mar.getCpMarcador().getIdMarcador() != CpMarcador.MARCADOR_EM_TRANSITO_ELETRONICO) {
					if (sb.length() > 0)
						sb.append(", ");
					if ((mar.getDpLotacaoIni() != null && lota.getIdInicial()
							.equals(mar.getDpLotacaoIni().getIdInicial()))
							&& (mar.getDpPessoaIni() != null && !pess
									.getIdInicial()
									.equals(mar.getDpPessoaIni().getIdInicial()))) {
						sb.append(mar.getCpMarcador().getDescrMarcador());
						sb.append(" [<span title=\"");
						sb.append(mar.getDpPessoaIni().getNomePessoa());
						sb.append("\">");
						sb.append(mar.getDpPessoaIni().getSigla());
						sb.append("</span>]");
					}
				}
			}
		}

		// Marcacoes para qualquer outra pessoa ou lotacao
		//
		if (sb.length() == 0) {
			for (ExMarca mar : getMarcasAtivas()) {
				if (mar.getCpMarcador().getIdMarcador() != CpMarcador.MARCADOR_EM_TRANSITO
						&& mar.getCpMarcador().getIdMarcador() != CpMarcador.MARCADOR_EM_TRANSITO_ELETRONICO) {
					if (sb.length() > 0)
						sb.append(", ");
					sb.append(mar.getCpMarcador().getDescrMarcador());
					if (mar.getDpLotacaoIni() != null
							|| mar.getDpPessoaIni() != null) {
						sb.append(" [");
						if (mar.getDpLotacaoIni() != null) {
							sb.append(mar.getDpLotacaoIni().getLotacaoAtual()
									.getSigla());
						}
						if (mar.getDpPessoaIni() != null) {
							if (mar.getDpLotacaoIni() != null) {
								sb.append(", ");
							}
							sb.append(" [<span title=\"");
							sb.append(mar.getDpPessoaIni().getNomePessoa());
							sb.append("\">");
							sb.append(mar.getDpPessoaIni().getSigla());
							sb.append("</span>]");
						}
						sb.append("]");
					}
				}
			}
		}
		if (sb.length() == 0)
			return null;
		return sb.toString();
	}

	public String getDescricaoCompletaEMarcadoresEmHtml(DpPessoa pess,
			DpLotacao lota) {
		String m = getMarcadoresEmHtml(pess, lota);
		if (m == null)
			return getMob().getDescricaoCompleta();
		return getMob().getDescricaoCompleta() + " - " + m;
	}

	public String getSigla() {
		return sigla;
	}

	public List getApensos() {
		return apensos;
	}

	/*public List getFilhos() {
		return filhos;
	}*/

	public List getExpedientesFilhosNaoCancelados() {
		return expedientesFilhosNaoCancelados;
	}

	public List getAnexosNaoAssinados() {
		return anexosNaoAssinados;
	}

	public List getDespachosNaoAssinados() {
		return despachosNaoAssinados;
	}

	public List getExpedientesFilhosNaoJuntados() {
		return expedientesFilhosNaoJuntados;
	}

	public List getProcessosFilhosNaoCancelados() {
		return processosFilhosNaoCancelados;
	}

	public List<ExMovimentacaoVO> getPendenciasDeAnexacao() {
		return pendenciasDeAnexacao;
	}

	@Override
	public String toString() {
		return getSigla() + "[" + getAcoes() + "] ";
	}

	public List<DuracaoVO> getDuracoes() {
		return duracoes;
	}

	public void setDuracoes(List<DuracaoVO> duracoes) {
		this.duracoes = duracoes;
	}

	public Long getByteCount() {
		return byteCount;
	}

	public Integer getPagInicial() {
		return pagInicial;
	}

	public Integer getPagFinal() {
		return pagFinal;
	}

	public String getTamanhoDeArquivo() {
		return tamanhoDeArquivo;
	}

	public boolean isPendencias() {
		return anexosNaoAssinados.size() > 0
				|| despachosNaoAssinados.size() > 0
				|| expedientesFilhosNaoJuntados.size() > 0
				|| pendenciasDeAnexacao.size() > 0;
	}

}