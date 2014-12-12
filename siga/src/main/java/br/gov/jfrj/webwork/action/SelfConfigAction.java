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
 * Criado em 23/11/2005
 */

package br.gov.jfrj.webwork.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoServico;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.cp.bl.SituacaoFuncionalEnum;
import br.gov.jfrj.siga.dp.CpTipoLotacao;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.libs.rpc.FaultMethodResponseRPC;
import br.gov.jfrj.siga.libs.rpc.SimpleMethodResponseRPC;
import br.gov.jfrj.siga.libs.webwork.SigaActionSupport;

import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.Preparable;

public class SelfConfigAction 	extends SigaActionSupport 
								implements Preparable {
	// prepara��o do ambiente
	private CpTipoConfiguracao cpTipoConfiguracaoUtilizador;
	private CpTipoConfiguracao cpTipoConfiguracaoAConfigurar;
	private List<CpServico> cpServicosDisponiveis;
	/*private CpSituacaoConfiguracao cpSituacaoPadrao;
	
	private List<CpSituacaoConfiguracao> cpSituacoesPossiveis;
	*/
	// edi��o
	private DpLotacao dpLotacaoConsiderada;
	private List<DpPessoa> dpPessoasDaLotacao; 
	private List<CpConfiguracao> cpConfiguracoesAdotadas;
	// grava��o - parametros
	private String idPessoaConfiguracao;
	private String idServicoConfiguracao;
	private String idSituacaoConfiguracao;
	private Long idTipoConfiguracao;
	
	// grava��o - retorno
	private String respostaXMLStringRPC;
	private String resultadoRetornoAjax;
	private String mensagemRetornoAjax;
	private String idPessoaRetornoAjax;
	private String idServicoRetornoAjax;
	private String idSituacaoRetornoAjax;
	//
	public void prepare() throws Exception {
		setDpPessoasDaLotacao(new ArrayList<DpPessoa>());
		setCpConfiguracoesAdotadas(new ArrayList<CpConfiguracao>());
		setCpTipoConfiguracaoUtilizador(obterCpTipoConfiguracaoUtilizador());
		setCpTipoConfiguracaoAConfigurar(obterCpTipoConfiguracaoAConfigurar(CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO));
		setCpServicosDisponiveis(  obterServicosDaLotacaoEfetiva());

	}
	public String execute() {
		return Action.SUCCESS;
	}
	/**
	 *  Executa a a��o que prepara a edi��o da interface de configura��o 
	 * @throws Exception 
	 *   
	 */
	public String aEditar() throws Exception {
		if (seUsuarioPodeExecutar()) {
			DpLotacao t_dltLotacao = obterLotacaoEfetiva();
			setDpLotacaoConsiderada(t_dltLotacao);
			if (t_dltLotacao != null) {
				// TODO: _LAGS - verificar op��o para sublota��es
				setDpPessoasDaLotacao(dao().pessoasPorLotacao(t_dltLotacao.getIdLotacao(), false,false,SituacaoFuncionalEnum.ATIVOS_E_CEDIDOS));
				setCpConfiguracoesAdotadas(obterConfiguracoesDasPessoasDaLotacaoConsiderada());
			}
			return "edita";
		} else {
			throw new AplicacaoException("Acesso n�o permitido !");
			
		}
	}
	public String aGravar() throws Exception {
		if (seUsuarioPodeExecutar()) {
			try {
				DpLotacao t_dplLotacao = obterLotacaoEfetiva();
				Long t_lngIdPessoa = Long.parseLong(idPessoaConfiguracao);
				DpPessoa t_dppPessoa = dao().consultar(t_lngIdPessoa,DpPessoa.class,false);
				Long t_lngIdServico = Long.parseLong(idServicoConfiguracao);
                CpServico t_cpsServico = dao().consultar(t_lngIdServico, CpServico.class, false);
                Long t_lngIdSituacao = Long.parseLong(idSituacaoConfiguracao);
                CpSituacaoConfiguracao t_cstSituacao = dao().consultar(t_lngIdSituacao,CpSituacaoConfiguracao.class, false);
                Cp.getInstance().getBL().configurarAcesso(null,t_dplLotacao.getOrgaoUsuario()
                											  ,t_dplLotacao
                											  ,t_dppPessoa
                											  ,t_cpsServico
                											  ,t_cstSituacao
                											  ,obterCpTipoConfiguracaoAConfigurar(idTipoConfiguracao)
                											  ,getIdentidadeCadastrante());
                // pesquisa novamente o item gravado
                CpConfiguracao t_cfgConfigGravada = obterConfiguracao(	t_dplLotacao,
																	  	t_dppPessoa,
																	  	obterCpTipoConfiguracaoAConfigurar(idTipoConfiguracao),
																		t_cpsServico);
                
                t_cfgConfigGravada.toString();
                // devolve os ids como confirma��o
				HashMap<String, String> t_hmpRetorno = new HashMap<String, String>();
				t_hmpRetorno.put("idpessoa", /*idPessoaConfiguracao*/ String.valueOf(t_cfgConfigGravada.getDpPessoa().getIdPessoa()));
				t_hmpRetorno.put("idservico", /*idServicoConfiguracao*/String.valueOf(t_cfgConfigGravada.getCpServico().getIdServico()));
				t_hmpRetorno.put("idsituacao", /*idSituacaoConfiguracao*/String.valueOf(t_cfgConfigGravada.getCpSituacaoConfiguracao().getIdSitConfiguracao()) );
				SimpleMethodResponseRPC t_smrResposta = new SimpleMethodResponseRPC();
				t_smrResposta.setMembersFrom(t_hmpRetorno);
				setRespostaXMLStringRPC(t_smrResposta.toXMLString());	
			} catch (Exception e) {
				CpDao.rollbackTransacao();
				FaultMethodResponseRPC t_fmrRetorno = new FaultMethodResponseRPC();
				t_fmrRetorno.set(0, e.getMessage());
				setRespostaXMLStringRPC(t_fmrRetorno.toXMLString());
			}
		} else {
			FaultMethodResponseRPC t_fmrRetorno = new FaultMethodResponseRPC();
			t_fmrRetorno.set(0, "Acesso n�o permitido !");
			setRespostaXMLStringRPC(t_fmrRetorno.toXMLString());
		}
        return "grava";
   }
	
	/**
	 * Retorna as configura��es para as pessoas da lota��o considerada   
	 *  
	 */
	private List<CpConfiguracao> obterConfiguracoesDasPessoasDaLotacaoConsiderada() throws AplicacaoException {
		ArrayList<CpConfiguracao> t_arlConfig = new ArrayList<CpConfiguracao>();
		for (DpPessoa t_dppPessoa : getDpPessoasDaLotacao() ) {
			for (CpServico t_cpsServico : getCpServicosDisponiveis()) {
				CpConfiguracao t_cfgConfigPessoaLotacao = obterConfiguracao(getDpLotacaoConsiderada(),
															t_dppPessoa,
															getCpTipoConfiguracaoAConfigurar(),
															t_cpsServico);
				if (t_cfgConfigPessoaLotacao == null) {
					CpConfiguracao t_cpcConfigNovo = new CpConfiguracao();
					t_cpcConfigNovo.setLotacao(getDpLotacaoConsiderada());
					t_cpcConfigNovo.setDpPessoa(t_dppPessoa);
					t_cpcConfigNovo.setCpTipoConfiguracao(getCpTipoConfiguracaoAConfigurar());
					t_cpcConfigNovo.setCpServico(t_cpsServico);
					t_cpcConfigNovo.setCpSituacaoConfiguracao(obterSituacaoPadrao(t_cpsServico));
					t_arlConfig.add(t_cpcConfigNovo);
				} else {
					t_arlConfig.add(t_cfgConfigPessoaLotacao);
				}
			}
		}
		return t_arlConfig;
	}
	/**
	 * Retorna a configura��o para a pessoa, lota��o e cpTipoConfiguracaoAConfigurar  
	 *  
	 */
	private CpConfiguracao obterConfiguracao(DpLotacao p_dltLotacao,
											 DpPessoa p_dpsPessoa,
											 CpTipoConfiguracao p_ctcTipoConfig,
											 CpServico p_cpsServico
											 ) {
		CpConfiguracao t_cfgConfigExemplo  = new CpConfiguracao();
		t_cfgConfigExemplo.setLotacao(p_dltLotacao);
		t_cfgConfigExemplo.setDpPessoa(p_dpsPessoa);
		t_cfgConfigExemplo.setCpTipoConfiguracao(p_ctcTipoConfig);
		t_cfgConfigExemplo.setCpServico(p_cpsServico);
		
		CpConfiguracao cpConf = null;
		try {
			cpConf = Cp.getInstance().getConf().buscaConfiguracao(t_cfgConfigExemplo,
					new int[] { 0 }, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return cpConf;
		
	}
	/**
	 *  Retorna os servi�os cuja configura��o possui 
	 *  tipo de configura��o com o id igual a ID_TIPO_CONFIGURACAO_PARA_SERVICOS 
	 * @throws AplicacaoException 
	 *
	private List<CpServico> obterServicosDisponiveis() throws AplicacaoException {
		ArrayList<CpServico> t_arlServico = new ArrayList<CpServico> ();
		try {
			CpConfiguracao t_cpcConfiguracaoExemplo = new CpConfiguracao();
			t_cpcConfiguracaoExemplo.setCpTipoConfiguracao(getCpTipoConfiguracaoUtilizador());
			ArrayList<CpConfiguracao> t_arlConf = (ArrayList<CpConfiguracao>) dao().consultar(t_cpcConfiguracaoExemplo);
			for (CpConfiguracao t_cpcConfig : t_arlConf ) {
				if (t_cpcConfig.getCpServico() != null) {
					if (! t_arlServico.contains(t_cpcConfig.getCpServico())) {
						t_arlServico.add(t_cpcConfig.getCpServico());
					}
				}
			}
		} catch (Exception e) {
			throw new AplicacaoException("Erro ao obter os servi�os !");
		}
		return t_arlServico;
	}/
	/**
	 *  Retorna o tipo de configura��o que o utilizador da interface  
	 *  tem permiss�o
	 */
	private CpTipoConfiguracao obterCpTipoConfiguracaoUtilizador() {
		CpTipoConfiguracao t_tcfTipo = dao().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_HABILITAR_SERVICO_DE_DIRETORIO
				//CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO
				, CpTipoConfiguracao.class
				, false);
		
		return t_tcfTipo;
	}
	/**
	 *  Retorna o tipo de configura��o a Configurar  
	 *  
	 */
	private CpTipoConfiguracao obterCpTipoConfiguracaoAConfigurar(Long idTipoConfiguracao) {
		CpTipoConfiguracao t_tcfTipo = dao().consultar(
				idTipoConfiguracao
				, CpTipoConfiguracao.class
				, false);
		return t_tcfTipo;
	}
	
	/**
	 *  Retorna a situacao padr�o para um dado servico
	 * 
	 */
	private CpSituacaoConfiguracao obterSituacaoPadrao(CpServico p_cpsServico) {
		return p_cpsServico.getCpTipoServico().getSituacaoDefault();
	}
	/**
	 *  Retorna as situacoes possivis para um servico  
	 *  
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<CpSituacaoConfiguracao> obterSituacoesPossiveis(CpServico p_cpsServico) {
		return (ArrayList<CpSituacaoConfiguracao>) p_cpsServico.getCpTipoServico().getCpSituacoesConfiguracaoSet();
	}
	/**
	 *  Retorna a lota��o do usu�rio ou a lota��o na qual ele
	 *  substitui algu�m
	 */
	private DpLotacao obterLotacaoEfetiva() {
		if (getLotaTitular() != null)  {
			if (getLotaTitular().getIdLotacao() != getCadastrante().getLotacao().getIdLotacao()) {
				return getLotaTitular();
			}
		}
		if (getCadastrante()  != null) {
			return getCadastrante().getLotacao();
		}
		return null;
	}
	/**
	 *  Retorna o tipo de lota��o do usu�rio 
	 *  ou o tipo de lota��o na qual ele substitui algu�m
	 */
	private CpTipoLotacao obterTipoDeLotacaoEfetiva() {
		/*  C�digo definitivo
		 * return obterLotacaoEfetiva().getCpTipoLotacao();
		 * abaixo codigo tempor�rio : usado nos testes iniciais
		 */
		//return dao().consultar(100L, CpTipoLotacao.class, false);
		return obterLotacaoEfetiva().getCpTipoLotacao();
	}
	/**
	 *  Obt�m, os servicos da lota��o efetiva
	 */
	@SuppressWarnings("unchecked")
	private ArrayList<CpServico> obterServicosDaLotacaoEfetiva() {
		CpTipoLotacao t_ctlTipoLotacao = obterTipoDeLotacaoEfetiva();
		final Query query = dao().getSessao().getNamedQuery("consultarCpConfiguracoesPorTipoLotacao");
		query.setLong("idTpLotacao", t_ctlTipoLotacao.getIdTpLotacao());
		ArrayList<CpConfiguracao> t_arlConfigServicos = (ArrayList<CpConfiguracao>) query.list();
		ArrayList<CpServico> t_arlServicos = new ArrayList<CpServico>();
		for (CpConfiguracao t_cfgConfiguracao : t_arlConfigServicos) {
			t_arlServicos.add(t_cfgConfiguracao.getCpServico());
		}
		return t_arlServicos;
	}
	/**
	 *  Obt�m, os tipos de servico da lota��o efetiva
	 */
	private ArrayList<CpTipoServico> obterTiposServicosDaLotacaoEfetiva() {
		ArrayList<CpServico> t_arlServicos = obterServicosDaLotacaoEfetiva();
		ArrayList <CpTipoServico> t_arlTipoServico = new ArrayList<CpTipoServico>();
		for (CpServico t_csrServico : t_arlServicos  ) {
			if (!t_arlTipoServico.contains(t_csrServico.getCpTipoServico())) {
				t_arlTipoServico.add(t_csrServico.getCpTipoServico());
			}
		}
		return t_arlTipoServico;
	}
	/**
	 * Obt�m servicos poss�veis para a loa��o efetiva de um determinado tipo  
	 */
	private ArrayList<CpServico> obterServicosDaLotacaoEfetivaParaOTipo(CpTipoServico p_ctsTipo) {
		ArrayList<CpServico> t_arlTodosServicos  = obterServicosDaLotacaoEfetiva();
		ArrayList<CpServico> t_arlServicosDoTipo  =  new ArrayList<CpServico>();
		for (CpServico t_cpsServico : t_arlTodosServicos) {
			if (t_cpsServico.getCpTipoServico().equals(p_ctsTipo)) {
				t_arlServicosDoTipo.add(t_cpsServico);
			}
		}
		return t_arlServicosDoTipo;
	}
	
	/**
	 *  Retorna a lota��o do usu�rio ou a lota��o de quem 
	 *  ele substitui 
	 */
	private DpPessoa obterPessoaEfetiva() {
		if (getTitular() != null)  {
			return getTitular();
		}
		if (getCadastrante()  != null) {
			return getCadastrante();
		}
		return null;
	}
	
	public Set<DpPessoa> getPessoasGrupoSegManual(){
		return Cp.getInstance().getConf().getPessoasGrupoSegManual(obterLotacaoEfetiva());
	}
	
	public Long getIdSitConfiguracaoConfManual(Long idPessoa, Long idServico) throws Exception{
		DpPessoa pes = dao().consultar(idPessoa, DpPessoa.class, false);
		CpServico svc = dao().consultar(idServico, CpServico.class, false);
		boolean podeSvc = Cp.getInstance().getConf().podePorConfiguracao(pes, obterLotacaoEfetiva(),svc,CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO_OUTRA_LOTACAO);

		if (podeSvc){
			return CpSituacaoConfiguracao.SITUACAO_PODE;
		}else{
			return CpSituacaoConfiguracao.SITUACAO_NAO_PODE; 
		}
		
	}
	
	public String aInserirPessoaExtra() throws AplicacaoException{
		DpPessoa pes = dao().consultar(paramLong("pessoaExtra_pessoaSel.id"), DpPessoa.class,false);
		if (pes.getLotacao().equivale(obterLotacaoEfetiva())){
			throw new AplicacaoException("A pessoa selecionada deve ser de outra lota��o!");
		}
		
		
		/*
		 * MELHORAR: Permite a inclus�o apenas de pessoas ativas. 
		 * Isso deve ser melhorado, pois ainda n�o existe uma refer�ncia nem mapeamento no hibernate
		 *  para a descri��o da situa��o funciona da pessoa. 
		 * */
		if(!pes.getSituacaoFuncionalPessoa().equals("1")){
			if (pes.getSituacaoFuncionalPessoa().equals("2")){
				throw new AplicacaoException("N�o � poss�vel inserir uma pessoa que est� CEDIDA!<br/>Por favor, abra um chamado para o suporte t�cnico.");
			}else{
				throw new AplicacaoException("A pessoa n�o est� com situa��o funcional ATIVA! Situa��o atual: " + pes.getSituacaoFuncionalPessoa() + "<br/>Por favor, abra um chamado para o suporte t�cnico.");	
			}
			
		}
		
		
		
		CpTipoConfiguracao tpConf =  obterCpTipoConfiguracaoAConfigurar(getIdTipoConfiguracaoUtilizarServicoOutraLotacao());
		Cp.getInstance().getBL().configurarAcesso(null, pes.getOrgaoUsuario(), obterLotacaoEfetiva(), pes, null, null, tpConf, getIdentidadeCadastrante());
		
		return Action.SUCCESS;
	}
	
	public String aExcluirPessoaExtra() throws AplicacaoException{
		DpPessoa pes = dao().consultar(paramLong("pessoaId"), DpPessoa.class,false);
		CpTipoConfiguracao tpConf =  obterCpTipoConfiguracaoAConfigurar(getIdTipoConfiguracaoUtilizarServicoOutraLotacao());
		Cp.getInstance().getConf().excluirPessoaExtra(pes,obterLotacaoEfetiva(),tpConf,getIdentidadeCadastrante());
	
		return Action.SUCCESS;
	}


	/**
	 *  Retorna se o usu�rio ou quem ele substitui pode
	 *  pode executar a interface
	 */
	private boolean seUsuarioPodeExecutar() {
		// TODO: _LAGS - obterPessoaEfetiva() e ver se � diretor
		/// ID_TIPO_CONFIGURACAO_PODE_EXECUTAR_SERVICO = new Long(202);
		return true;
	}

	/**
	 * @return the dpLotacaoConsiderada
	 */
	public DpLotacao getDpLotacaoConsiderada() {
		return dpLotacaoConsiderada;
	}

	/**
	 * @param dpLotacaoConsiderada the dpLotacaoConsiderada to set
	 */
	public void setDpLotacaoConsiderada(DpLotacao dpLotacaoConsiderada) {
		this.dpLotacaoConsiderada = dpLotacaoConsiderada;
	}

	/**
	 * @return the dpPessoasDaLotacao
	 */
	public List<DpPessoa> getDpPessoasDaLotacao() {
		return dpPessoasDaLotacao;
	}

	/**
	 * @param dpPessoasDaLotacao the dpPessoasDaLotacao to set
	 */
	public void setDpPessoasDaLotacao(List<DpPessoa> dpPessoasDaLotacao) {
		this.dpPessoasDaLotacao = dpPessoasDaLotacao;
	}
	/**
	 * @return the cpTipoConfiguracaoUtilizador
	 */
	public CpTipoConfiguracao getCpTipoConfiguracaoUtilizador() {
		return cpTipoConfiguracaoUtilizador;
	}
	/**
	 * @param cpTipoConfiguracaoUtilizador the cpTipoConfiguracaoUtilizador to set
	 */
	public void setCpTipoConfiguracaoUtilizador(
			CpTipoConfiguracao cpTipoConfiguracaoUtilizador) {
		this.cpTipoConfiguracaoUtilizador = cpTipoConfiguracaoUtilizador;
	}
	/**
	 * @return the cpTipoConfiguracaoAConfigurar
	 */
	public CpTipoConfiguracao getCpTipoConfiguracaoAConfigurar() {
		return cpTipoConfiguracaoAConfigurar;
	}
	/**
	 * @param cpTipoConfiguracaoAConfigurar the cpTipoConfiguracaoAConfigurar to set
	 */
	public void setCpTipoConfiguracaoAConfigurar(
			CpTipoConfiguracao cpTipoConfiguracaoAConfigurar) {
		this.cpTipoConfiguracaoAConfigurar = cpTipoConfiguracaoAConfigurar;
	}
	/**
	 * @return the cpConfiguracoesAdotadas
	 */
	public List<CpConfiguracao> getCpConfiguracoesAdotadas() {
		return cpConfiguracoesAdotadas;
	}
	/**
	 * @param cpConfiguracoesAdotadas the cpConfiguracoesAdotadas to set
	 */
	public void setCpConfiguracoesAdotadas(
			List<CpConfiguracao> cpConfiguracoesAdotadas) {
		this.cpConfiguracoesAdotadas = cpConfiguracoesAdotadas;
	}
	/**
	 * @return the idPessoaConfiguracao
	 */
	public String getIdPessoaConfiguracao() {
		return idPessoaConfiguracao;
	}
	/**
	 * @param idPessoaConfiguracao the idPessoaConfiguracao to set
	 */
	public void setIdPessoaConfiguracao(String idPessoaConfiguracao) {
		this.idPessoaConfiguracao = idPessoaConfiguracao;
	}
	/**
	 * @return the idServicoConfiguracao
	 */
	public String getIdServicoConfiguracao() {
		return idServicoConfiguracao;
	}
	/**
	 * @param idServicoConfiguracao the idServicoConfiguracao to set
	 */
	public void setIdServicoConfiguracao(String idServicoConfiguracao) {
		this.idServicoConfiguracao = idServicoConfiguracao;
	}
	/**
	 * @return the idSituacaoConfiguracao
	 */
	public String getIdSituacaoConfiguracao() {
		return idSituacaoConfiguracao;
	}
	/**
	 * @param idSituacaoConfiguracao the idSituacaoConfiguracao to set
	 */
	public void setIdSituacaoConfiguracao(String idSituacaoConfiguracao) {
		this.idSituacaoConfiguracao = idSituacaoConfiguracao;
	}
	/**
	 * @return the resultadoRetornoAjax
	 */
	public String getResultadoRetornoAjax() {
		return resultadoRetornoAjax;
	}
	/**
	 * @param resultadoRetornoAjax the resultadoRetornoAjax to set
	 */
	public void setResultadoRetornoAjax(String resultadoRetornoAjax) {
		this.resultadoRetornoAjax = resultadoRetornoAjax;
	}
	/**
	 * @return the mensagemRetornoAjax
	 */
	public String getMensagemRetornoAjax() {
		return mensagemRetornoAjax;
	}
	/**
	 * @param mensagemRetornoAjax the mensagemRetornoAjax to set
	 */
	public void setMensagemRetornoAjax(String mensagemRetornoAjax) {
		this.mensagemRetornoAjax = mensagemRetornoAjax;
	}
	/**
	 * @return the idPessoaRetornoAjax
	 */
	public String getIdPessoaRetornoAjax() {
		return idPessoaRetornoAjax;
	}
	/**
	 * @param idPessoaRetornoAjax the idPessoaRetornoAjax to set
	 */
	public void setIdPessoaRetornoAjax(String idPessoaRetornoAjax) {
		this.idPessoaRetornoAjax = idPessoaRetornoAjax;
	}
	/**
	 * @return the idServicoRetornoAjax
	 */
	public String getIdServicoRetornoAjax() {
		return idServicoRetornoAjax;
	}
	/**
	 * @param idServicoRetornoAjax the idServicoRetornoAjax to set
	 */
	public void setIdServicoRetornoAjax(String idServicoRetornoAjax) {
		this.idServicoRetornoAjax = idServicoRetornoAjax;
	}
	/**
	 * @return the idSituacaoRetornoAjax
	 */
	public String getIdSituacaoRetornoAjax() {
		return idSituacaoRetornoAjax;
	}
	/**
	 * @param idSituacaoRetornoAjax the idSituacaoRetornoAjax to set
	 */
	public void setIdSituacaoRetornoAjax(String idSituacaoRetornoAjax) {
		this.idSituacaoRetornoAjax = idSituacaoRetornoAjax;
	}
	/**
	 * @return the respostaXMLStringRPC
	 */
	public String getRespostaXMLStringRPC() {
		return respostaXMLStringRPC;
	}
	/**
	 * @param respostaXMLStringRPC the respostaXMLStringRPC to set
	 */
	public void setRespostaXMLStringRPC(String respostaXMLStringRPC) {
		this.respostaXMLStringRPC = respostaXMLStringRPC;
	}
	/**
	 * @return the cpServicosDisponiveis
	 */
	public List<CpServico> getCpServicosDisponiveis() {
		return cpServicosDisponiveis;
	}
	/**
	 * @param cpServicosDisponiveis the cpServicosDisponiveis to set
	 */
	public void setCpServicosDisponiveis(List<CpServico> cpServicosDisponiveis) {
		this.cpServicosDisponiveis = cpServicosDisponiveis;
	}
	public void setIdTipoConfiguracao(Long idTipoConfiguracao) {
		this.idTipoConfiguracao = idTipoConfiguracao;
	}
	public Long getIdTipoConfiguracao() {
		return idTipoConfiguracao;
	}

	public Long getIdTipoConfiguracaoUtilizarServico(){
		return CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO;
	}
	public Long getIdTipoConfiguracaoUtilizarServicoOutraLotacao(){
		return CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO_OUTRA_LOTACAO;
	}

	
}