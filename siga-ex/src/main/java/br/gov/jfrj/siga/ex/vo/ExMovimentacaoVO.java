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

import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANOTACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_APENSACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_CORRENTE;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_INTERMEDIARIO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_PERMANENTE;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_DE_MOVIMENTACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESAPENSACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ELIMINACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_ENCERRAMENTO_DE_VOLUME;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA_EXTERNO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_NOTIFICACAO_PUBL_BI;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO_TRANSITORIO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_REFERENCIA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_VINCULACAO_PAPEL;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_EM_EDITAL_DE_ELIMINACAO;
import static br.gov.jfrj.siga.ex.ExTipoMovimentacao.hasDespacho;

import java.util.Map;
import java.util.TreeMap;

import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.ex.util.ProcessadorReferencias;

public class ExMovimentacaoVO extends ExVO {
	ExMovimentacao mov;
	String classe;
	boolean originadaAqui;
	boolean desabilitada;
	boolean cancelada;
	String descricao;
	long idTpMov;
	String complemento;
	Map<String, ExParteVO> parte = new TreeMap<String, ExParteVO>();
	String dtRegMovDDMMYYHHMMSS;
	String dtFimMovDDMMYYHHMMSS;
	String descrTipoMovimentacao;
	long idMov;
	ExMobilVO mobVO;
	int duracaoSpan;
	int duracaoSpanExibirCompleto;
	String duracao;

	public ExMobilVO getMobVO() {
		return mobVO;
	}

	public ExMovimentacaoVO(ExMobilVO mobVO, ExMovimentacao mov,
			DpPessoa titular, DpLotacao lotaTitular) throws Exception {
		this.mov = mov;
		this.mobVO = mobVO;
		originadaAqui = (this.mov.getExMobil().getId().equals(getMobVO().mob
				.getId()));
		idTpMov = mov.getExTipoMovimentacao().getIdTpMov();

		this.idMov = mov.getIdMov();
		this.dtRegMovDDMMYYHHMMSS = mov.getDtRegMovDDMMYYHHMMSS();
		this.descrTipoMovimentacao = mov.getDescrTipoMovimentacao();
		this.cancelada = mov.getExMovimentacaoCanceladora() != null;

		if (mov.getLotaCadastrante() != null)
			parte.put("lotaCadastrante",
					new ExParteVO(mov.getLotaCadastrante()));
		if (mov.getCadastrante() != null)
			parte.put("cadastrante", new ExParteVO(mov.getCadastrante()));
		if (mov.getLotaSubscritor() != null)
			parte.put("lotaSubscritor", new ExParteVO(mov.getLotaSubscritor()));
		if (mov.getSubscritor() != null)
			parte.put("subscritor", new ExParteVO(mov.getSubscritor()));
		if (mov.getLotaResp() != null)
			parte.put("lotaResp", new ExParteVO(mov.getLotaResp()));
		if (mov.getResp() != null)
			parte.put("resp", new ExParteVO(mov.getResp()));

		descricao = mov.getObs();

		addAcoes(mov, titular, lotaTitular);

		calcularClasse(mov);

		desabilitada = mov.getExMovimentacaoCanceladora() != null
				|| mov.getIdTpMov().equals(
						TIPO_MOVIMENTACAO_CANCELAMENTO_DE_MOVIMENTACAO);

	}

	/**
	 * @param mov
	 * @param titular
	 * @param lotaTitular
	 * @throws Exception
	 */
	private void addAcoes(ExMovimentacao mov, DpPessoa titular,
			DpLotacao lotaTitular) throws Exception {
		if (complemento == null)
			complemento = "";

		if (idTpMov == TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO) {
			descricao = "";
			addAcao(null, "Verificar", "/expediente/mov", "assinar_verificar",
					true, null, "&ajax=true&id=" + mov.getIdMov().toString(),
					null, null, null);
		}

		if (idTpMov == TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO) {
			descricao = Texto.maiusculasEMinusculas(mov.getObs());
		}

		if (idTpMov == TIPO_MOVIMENTACAO_ANOTACAO) {
			descricao = mov.getObs();
			addAcao(null,
					"Excluir",
					"/expediente/mov",
					"excluir",
					Ex.getInstance()
							.getComp()
							.podeExcluirAnotacao(titular, lotaTitular,
									mov.mob(), mov));
		}

		if (idTpMov == TIPO_MOVIMENTACAO_VINCULACAO_PAPEL) {
			addAcao(null,
					"Cancelar",
					"/expediente/mov",
					"cancelar",
					Ex.getInstance()
							.getComp()
							.podeCancelarVinculacaoPapel(titular, lotaTitular,
									mov.mob(), mov));
		}

		if (idTpMov == TIPO_MOVIMENTACAO_REFERENCIA) {
			addAcao(null,
					"Cancelar",
					"/expediente/mov",
					"cancelar",
					Ex.getInstance()
							.getComp()
							.podeCancelarVinculacaoDocumento(titular,
									lotaTitular, mov.mob(), mov));
		}

		if (mov.getNumPaginas() != null
				|| idTpMov == TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO
				|| idTpMov == TIPO_MOVIMENTACAO_ANEXACAO) {
			// A acao pode ser melhorada para mostrar o icone do pdf antes do
			// nome do arquivo.
			// <c:url var='anexo' value='/anexo/${mov.idMov}/${mov.nmArqMov}' />
			// tipo="${mov.conteudoTpMov}" />
			addAcao(null, mov.getNmArqMov(), "/arquivo",
					"exibir", mov.getNmArqMov() != null, null,
					"&popup=true&arquivo=" + mov.getReferenciaPDF(), null, null, null);

			if (idTpMov == TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO) {
				addAcao(null,
						"Excluir",
						"/expediente/mov",
						"excluir",
						Ex.getInstance()
								.getComp()
								.podeExcluirCosignatario(titular, lotaTitular,
										mov.mob(), mov));
			}

			if (idTpMov == TIPO_MOVIMENTACAO_ANEXACAO) {
				if (!mov.isCancelada() && !mov.mob().doc().isSemEfeito()
						&& !mov.mob().isEmTransito()) {
					addAcao(null,
							"Excluir",
							"/expediente/mov",
							"excluir",
							Ex.getInstance()
									.getComp()
									.podeExcluirAnexo(titular, lotaTitular,
											mov.mob(), mov));
					addAcao(null,
							"Cancelar",
							"/expediente/mov",
							"cancelar",
							Ex.getInstance()
									.getComp()
									.podeCancelarAnexo(titular, lotaTitular,
											mov.mob(), mov));
					addAcao(null, "Assinar/Conferir c�pia", "/expediente/mov",
							"exibir", true, null, "&popup=true", null, null, null);
				}
			}

			if (hasDespacho(idTpMov)) {
				if (!mov.mob().doc().isSemEfeito())
					addAcao(null,
							"Cancelar",
							"/expediente/mov",
							"cancelar",
							Ex.getInstance()
									.getComp()
									.podeCancelarDespacho(titular, lotaTitular,
											mov.mob(), mov));
			}

			if (idTpMov != TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO
					&& idTpMov != TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO
					&& idTpMov != TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO
					&& idTpMov != TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO
					&& idTpMov != TIPO_MOVIMENTACAO_ANEXACAO) {
				if (!mov.isCancelada() && !mov.mob().doc().isSemEfeito())
					
					if((idTpMov == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO
							|| idTpMov == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO
							|| idTpMov == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA
							|| idTpMov == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA
							|| idTpMov == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA)
							&& mov.isAssinada())
						
						addAcao(
								"printer",
								"Ver",
								"/arquivo",
								"exibir",
								Ex.getInstance().getComp()
										.podeVisualizarImpressao(titular, lotaTitular, mov.mob()),
								null, "&popup=true&arquivo=" + mov.getReferenciaPDF(), null, null, null);

					else if(!(mov.isAssinada() && mov.mob().isEmTransito())) {
						addAcao(null, "Ver/Assinar", "/expediente/mov", "exibir",
								true, null, "&popup=true", null, null, null);
					}
			}

			if (mov.getExMovimentacaoReferenciadoraSet() != null) {
				boolean fAssinaturas = false;
				boolean fConferencias = false;
				String complementoConferencias = "";

				for (ExMovimentacao movRef : mov
						.getExMovimentacaoReferenciadoraSet()) {
					if (movRef.getIdTpMov() == TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO) {
						complemento += (complemento.length() > 0 ? ", " : "")
								+ Texto.maiusculasEMinusculas(movRef.getObs());
						fAssinaturas = true;
					} else if (movRef.getIdTpMov() == TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO) {
						complementoConferencias += (complementoConferencias
								.length() > 0 ? ", " : "")
								+ Texto.maiusculasEMinusculas(movRef.getObs());
						fConferencias = true;
					}

				}
				if (fAssinaturas)
					complemento = " | Assinado por: " + complemento;

				if (fConferencias)
					complemento += " | C�pia conferida por: "
							+ complementoConferencias;
			}
		}

		if (idTpMov == TIPO_MOVIMENTACAO_JUNTADA
				|| idTpMov == TIPO_MOVIMENTACAO_JUNTADA_EXTERNO) {
			descricao = null;
			if (originadaAqui) {
				if (mov.getExMobilRef() != null) {
					
					String mensagemPos = null;
					
					if(!mov.getExMobilRef().getExDocumento().getDescrDocumento().equals(mov.getExMobil().getExDocumento().getDescrDocumento()))
						mensagemPos = " Descri��o: " +  mov.getExMobilRef().getExDocumento().getDescrDocumento();
					
					
					addAcao(null, mov.getExMobilRef().getSigla(),
							"/expediente/doc", "exibir", true, null, "sigla="
									+ mov.getExMobilRef().getSigla(),
							"Juntado ao documento: ", mensagemPos, null);
				} else {
					descricao = "Juntado ao documento: " + mov.getDescrMov();
				}
			} else {
				
				String mensagemPos = null;
				
				if(!mov.getExMobil().getExDocumento().getDescrDocumento().equals(mov.getExMobilRef().getExDocumento().getDescrDocumento()))
					mensagemPos = " Descri��o: " + mov.getExDocumento().getDescrDocumento();
				
				
				
				addAcao(null, mov.getExMobil().getSigla(), "/expediente/doc",
						"exibir", true, null, "sigla="
								+ mov.getExMobil().getSigla(),
						"Documento juntado: ", mensagemPos, null);
			}
		}
		
		if (idTpMov == TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA) {
			descricao = null;
			if (originadaAqui) {
				if (mov.getExMobilRef() != null) {
					
					String mensagemPos = null;
					
					if(!mov.getExMobilRef().getExDocumento().getDescrDocumento().equals(mov.getExMobil().getExDocumento().getDescrDocumento()))
						mensagemPos = " Descri��o: " +  mov.getExMobilRef().getExDocumento().getDescrDocumento();
					
					
					addAcao(null, mov.getExMobilRef().getSigla(),
							"/expediente/doc", "exibir", true, null, "sigla="
									+ mov.getExMobilRef().getSigla(),
							"Desentranhado do documento: ", mensagemPos, null);
				} else {
					descricao = "Desentranhado do documento: " + mov.getDescrMov();
				}
			} else {
				
				String mensagemPos = null;
				
				if(!mov.getExMobil().getExDocumento().getDescrDocumento().equals(mov.getExMobilRef().getExDocumento().getDescrDocumento()))
					mensagemPos = " Descri��o: " + mov.getExDocumento().getDescrDocumento();
				
				
				
				addAcao(null, mov.getExMobil().getSigla(), "/expediente/doc",
						"exibir", true, null, "sigla="
								+ mov.getExMobil().getSigla(),
						"Documento desentranhado: ", mensagemPos, null);
			}
		}

		if (idTpMov == TIPO_MOVIMENTACAO_APENSACAO) {
			descricao = null;
			if (originadaAqui) {
				addAcao(null, mov.getExMobilRef().getSigla(),
						"/expediente/doc", "exibir", true, null, "sigla="
								+ mov.getExMobilRef().getSigla(),
						"Apensado ao documento: ", null, null);
			} else {
				addAcao(null, mov.getExMobil().getSigla(), "/expediente/doc",
						"exibir", true, null, "sigla="
								+ mov.getExMobil().getSigla(),
						"Documento apensado: ", null, null);
			}
		}

		if (idTpMov == TIPO_MOVIMENTACAO_DESAPENSACAO) {
			descricao = null;
			if (originadaAqui) {
				addAcao(null, mov.getExMobilRef().getSigla(),
						"/expediente/doc", "exibir", true, null, "sigla="
								+ mov.getExMobilRef().getSigla(),
						"Desapensado do documento: ", null, null);
			} else {
				addAcao(null, mov.getExMobil().getSigla(), "/expediente/doc",
						"exibir", true, null, "sigla="
								+ mov.getExMobil().getSigla(),
						"Documento desapensado: ", null, null);
			}
		}

		if (idTpMov == TIPO_MOVIMENTACAO_NOTIFICACAO_PUBL_BI) {
			addAcao(null, mov.getExMobilRef().getSigla(), "/expediente/doc",
					"exibir", true, null, "sigla="
							+ mov.getExMobilRef().getSigla(),
					"Publicado no Boletim Interno: ",
					" em " + mov.getDtMovDDMMYY(), null);
		}

		if (idTpMov == TIPO_MOVIMENTACAO_REFERENCIA) {
			descricao = null;
			if (originadaAqui) {
				addAcao(null, mov.getExMobilRef().getSigla(),
						"/expediente/doc", "exibir", true, null, "sigla="
								+ mov.getExMobilRef().getSigla(),
						"Ver tamb�m: ",  " Descri��o: " + mov.getExMobilRef().getExDocumento().getDescrDocumento(), null);
			} else {
				addAcao(null, mov.getExMobil().getSigla(), "/expediente/doc",
						"exibir", true, null, "sigla="
								+ mov.getExMobil().getSigla(), "Ver tamb�m: ",
								" Descri��o: " + mov.getExDocumento().getDescrDocumento(), null);
			}
		}
		
		if (idTpMov == TIPO_MOVIMENTACAO_INCLUSAO_EM_EDITAL_DE_ELIMINACAO){
			descricao = null;
			if (originadaAqui) {
				addAcao(null, mov.getExMobilRef().getSigla(),
						"/expediente/doc", "exibir", true, null, "sigla="
								+ mov.getExMobilRef().getSigla(),
						"", null, null);
			} else {
				addAcao(null, mov.getExMobil().getSigla(), "/expediente/doc",
						"exibir", true, null, "sigla="
								+ mov.getExMobil().getSigla(), "",
						null, null);
			}
		}
		
		if (idTpMov == TIPO_MOVIMENTACAO_ELIMINACAO){
			descricao = null;
			if (originadaAqui) {
				//N�o faz nada, pois o documento eliminado nunca � exibido
			} else {
				descricao = mov.getExMobil().getSigla();
			}
		}

		if (idTpMov == TIPO_MOVIMENTACAO_ARQUIVAMENTO_CORRENTE
				|| idTpMov == TIPO_MOVIMENTACAO_ARQUIVAMENTO_INTERMEDIARIO
				|| idTpMov == TIPO_MOVIMENTACAO_ARQUIVAMENTO_PERMANENTE) {
			if (!mov.isCancelada())
				addAcao(null, "Protocolo", "/expediente/mov", "protocolo_arq",
						true, null, "pessoa="
								+ (mov.getCadastrante() == null ? "null" : mov
										.getCadastrante().getSigla()) + "&dt="
								+ mov.getDtRegMovDDMMYYYYHHMMSS()
								+ "&popup=true", null, null, null);
		}

		if (idTpMov == TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA
				|| idTpMov == TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA
				|| idTpMov == TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA
				|| idTpMov == TIPO_MOVIMENTACAO_TRANSFERENCIA
				|| idTpMov == TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA
				|| idTpMov == TIPO_MOVIMENTACAO_RECEBIMENTO_TRANSITORIO) {
			String pre =  null;
			if(mov.getDtFimMovDDMMYY() != ""){
				pre = "Devolver at� " + mov.getDtFimMovDDMMYY() + " | ";
			}
			if (!mov.isCancelada())
				addAcao(null, "Protocolo", "/expediente/mov",
						"protocolo_transf", true, null,
						"pessoa="
								+ (mov.getCadastrante() == null ? "null" : mov
										.getCadastrante().getSigla()) + "&dt="
								+ mov.getDtRegMovDDMMYYYYHHMMSS()
								+ "&popup=true", pre, null, null);
		}

		if (idTpMov == TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO) {
			addAcao(null, mov.getNmArqMov(), "/arquivo", "download.action",
					mov.getNmArqMov() != null, null, "arquivo=" + mov.getReferenciaZIP(), null, null, null);
		}

		if (descricao != null && descricao.equals(mov.getObs())) {
			descricao = ProcessadorReferencias.marcarReferenciasParaDocumentos(
					descricao, null);
		}
	}

	/**
	 * @param mov
	 */
	private void calcularClasse(ExMovimentacao mov) {
		if (mov.getExMovimentacaoCanceladora() == null) {
			if (originadaAqui) {
				switch (mov.getExTipoMovimentacao().getIdTpMov().intValue()) {
				case (int) TIPO_MOVIMENTACAO_ANEXACAO:
					classe = "anexacao";
					break;
				case (int) TIPO_MOVIMENTACAO_NOTIFICACAO_PUBL_BI:
					classe = "publicacao";
					break;
				case (int) TIPO_MOVIMENTACAO_ANOTACAO:
					classe = "anotacao";
					break;
				}
			}

			switch (mov.getExTipoMovimentacao().getIdTpMov().intValue()) {
			case (int) TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO:
			case (int) TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO:
				classe = "assinaturaMov";
				break;

			case (int) TIPO_MOVIMENTACAO_ARQUIVAMENTO_CORRENTE:
			case (int) TIPO_MOVIMENTACAO_ARQUIVAMENTO_PERMANENTE:
			case (int) TIPO_MOVIMENTACAO_ARQUIVAMENTO_INTERMEDIARIO:
				classe = "arquivamento";
				break;
			case (int) TIPO_MOVIMENTACAO_JUNTADA:
				classe = "juntada";
				break;
			case (int) TIPO_MOVIMENTACAO_JUNTADA_EXTERNO:
				classe = "juntada_externo";
				break;
			case (int) TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA:
				classe = "desentranhamento";
				break;
			case (int) TIPO_MOVIMENTACAO_REFERENCIA:
				classe = "vinculo";
				break;
			case (int) TIPO_MOVIMENTACAO_ENCERRAMENTO_DE_VOLUME:
				classe = "encerramento_volume";
				break;
			case (int) TIPO_MOVIMENTACAO_APENSACAO:
				classe = "apensacao";
				break;
			case (int) TIPO_MOVIMENTACAO_DESAPENSACAO:
				classe = "desapensacao";
				break;
			case (int) TIPO_MOVIMENTACAO_DESPACHO:
			case (int) TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA:
			case (int) TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA:
			case (int) TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA:
				classe = "despacho";
				break;
			case (int) TIPO_MOVIMENTACAO_TRANSFERENCIA:
			case (int) TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA:
			case (int) TIPO_MOVIMENTACAO_RECEBIMENTO_TRANSITORIO:
				classe = "transferencia";
				break;
			case (int) TIPO_MOVIMENTACAO_RECEBIMENTO:
				classe = "recebimento";
				break;
			case (int) ExTipoMovimentacao.TIPO_MOVIMENTACAO_CRIACAO:
				classe = "criacao";
				break;
			}
		}
	}

	public String getClasse() {
		return classe;
	}

	public String getComplemento() {
		return complemento;
	}

	public String getDescricao() {
		if (descricao != null) {
			descricao = descricao.trim();
			if (descricao.length() == 0)
				return null;
		}
		return descricao;
	}

	public Object getDescrTipoMovimentacao() {
		return descrTipoMovimentacao;
	}

	public String getDisabled() {
		if (desabilitada)
			return "disabled";
		return "";
	}

	public Object getDtRegMovDDMMYYHHMMSS() {
		return dtRegMovDDMMYYHHMMSS;
	}

	public Object getDtRegMovDDMMYY() {
		return dtRegMovDDMMYYHHMMSS.substring(0, 8);
	}

	public Object getDtFimMovDDMMYYHHMMSS(){
		return dtFimMovDDMMYYHHMMSS;
	}
	public long getIdMov() {
		return idMov;
	}

	public long getIdTpMov() {
		return idTpMov;
	}

	public ExMobilVO getMobilVO() {
		// TODO Auto-generated method stub
		return mobVO;
	}

	public ExMovimentacao getMov() {
		return mov;
	}

	public Map<String, ExParteVO> getParte() {
		return parte;
	}

	public boolean isCancelada() {
		return cancelada;
	}

	public boolean isDesabilitada() {
		return desabilitada;
	}

	public boolean isOriginadaAqui() {
		return originadaAqui;
	}

	public void setClasse(String classe) {
		this.classe = classe;
	}

	public void setDesabilitada(boolean desabilitada) {
		this.desabilitada = desabilitada;
	}

	public void setMov(ExMovimentacao mov) {
		this.mov = mov;
	}

	public void setOriginadaAqui(boolean originadaAqui) {
		this.originadaAqui = originadaAqui;
	}

	@Override
	public String toString() {
		return getMobilVO().getSigla() + ":" + getIdMov() + " - "
				+ getDescrTipoMovimentacao() + " - " + getDescricao() + "["
				+ getAcoes() + "] " + getDisabled();
	}

	public int getDuracaoSpan() {
		return duracaoSpan;
	}

	public void setDuracaoSpan(int duracaoSpan) {
		this.duracaoSpan = duracaoSpan;
	}

	public String getDuracao() {
		return duracao;
	}

	public void setDuracao(String duracao) {
		this.duracao = duracao;
	}

	public int getDuracaoSpanExibirCompleto() {
		return duracaoSpanExibirCompleto;
	}

	public void setDuracaoSpanExibirCompleto(int duracaoSpanExibirCompleto) {
		this.duracaoSpanExibirCompleto = duracaoSpanExibirCompleto;
	}

}
