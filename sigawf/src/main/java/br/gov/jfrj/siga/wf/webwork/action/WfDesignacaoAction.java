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
package br.gov.jfrj.siga.wf.webwork.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.SessionFactory;
import org.jbpm.graph.def.ProcessDefinition;
import org.jbpm.taskmgmt.def.Swimlane;
import org.jbpm.taskmgmt.def.Task;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.dp.dao.CpOrgaoUsuarioDaoFiltro;
import br.gov.jfrj.siga.wf.Designacao;
import br.gov.jfrj.siga.wf.WfConfiguracao;
import br.gov.jfrj.siga.wf.bl.Wf;
import br.gov.jfrj.siga.wf.dao.WfDao;
import br.gov.jfrj.siga.wf.util.WfContextBuilder;

public class WfDesignacaoAction extends WfSigaActionSupport {

	private static int TIPO_RESP_INDEFINIDO = 0;
	private static int TIPO_RESP_MATRICULA = 1;
	private static int TIPO_RESP_LOTACAO = 2;
	private static int TIPO_RESP_LOTA_SUP = 3;
	private static int TIPO_RESP_SUP_HIER = 4;
	private static int TIPO_RESP_EXPRESSAO = 5;

	private List<Designacao> listaDesignacao = new ArrayList<Designacao>();
	private List<Designacao> listaDesignacaoRaia = new ArrayList<Designacao>();
	private List<Designacao> listaDesignacaoTarefa = new ArrayList<Designacao>();
	private List<TipoResponsavel> listaTipoResponsavel = new ArrayList<TipoResponsavel>();
	private Map<Integer, TipoResponsavel> mapaTipoResponsavel = new HashMap<Integer, TipoResponsavel>();

	private Set<String> raiaProcessada = new HashSet();

	private String orgao;
	private String procedimento;
	// private String procedimentoGravado;

	private ProcessDefinition pd;

	/**
	 * Inicializa os tipos de respons�veis e suas respectivas express�es, quando
	 * houver.
	 */
	public WfDesignacaoAction() {
		TipoResponsavel tpIndefinido = new TipoResponsavel(
				TIPO_RESP_INDEFINIDO, "[Indefinido]", "");
		TipoResponsavel tpMatricula = new TipoResponsavel(TIPO_RESP_MATRICULA,
				"Matr�cula", "matricula");
		TipoResponsavel tpLotacao = new TipoResponsavel(TIPO_RESP_LOTACAO,
				"Lota��o", "lotacao");
		TipoResponsavel tpLotaSuperior = new TipoResponsavel(
				TIPO_RESP_LOTA_SUP, "Lota��o Superior",
				"previous --> group() --> superior_group");
		TipoResponsavel tpSupHier = new TipoResponsavel(TIPO_RESP_SUP_HIER,
				"Superior Hier�rquico", "previous --> chief");
		TipoResponsavel tpExpressao = new TipoResponsavel(TIPO_RESP_EXPRESSAO,
				"Express�o", "");

		listaTipoResponsavel.add(tpIndefinido);
		listaTipoResponsavel.add(tpMatricula);
		listaTipoResponsavel.add(tpLotacao);
		listaTipoResponsavel.add(tpLotaSuperior);
		listaTipoResponsavel.add(tpSupHier);
		listaTipoResponsavel.add(tpExpressao);

		for (TipoResponsavel tr : listaTipoResponsavel) {
			mapaTipoResponsavel.put(tr.id, tr);
		}
	}

	/**
	 * O relat�rio ainda n�o est� ativo.
	 */
	public void aGerarRelatorioDesignacao() {

	}

	/**
	 * Grava a configura��o da designa��o. Inicialmente processa-se as raias e
	 * depois as tarefas, desativa-se as configura��es antigas e retorna �
	 * p�gina pesquisarDesigna��o.jsp com os dados gravados.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String aGravarDesignacao() throws Exception {

		selecionarApenasUmOrgao();
		pd = WfContextBuilder.getJbpmContext().getJbpmContext()
				.getGraphSession().findLatestProcessDefinition(procedimento);
		Date horaDoDB = dao().consultarDataEHoraDoServidor();
		Set<Long> raiasGravadas = new HashSet<Long>();

		listaDesignacaoRaia = getDesignacaoSwimlanes(pd);
		for (Designacao d : listaDesignacaoRaia) {
			d.setAtor(null);
			d.setLotaAtor(null);
			d.setExpressao(null);
			d.setTipoResponsavel(null);
		}
		listaDesignacaoTarefa = getDesignacaoTarefas(pd);
		for (Designacao d : listaDesignacaoTarefa) {
			d.setAtor(null);
			d.setLotaAtor(null);
			d.setExpressao(null);
			d.setTipoResponsavel(null);
		}

		if (pd != null) {
			for (Object o : pd.getTaskMgmtDefinition().getTasks().values()) {
				Task t = (Task) o;

				WfConfiguracao cfg = prepararConfiguracao();

				if (t.getSwimlane() != null) { // se task est� em uma raia
					listaDesignacaoRaia = processarRaia(t.getSwimlane(), cfg,
							horaDoDB, raiasGravadas);
				} else {
					listaDesignacaoTarefa = processarTarefa(t, cfg, horaDoDB);
				}

			}

			limparCache();
		}

		// this.procedimentoGravado = procedimento;
		return "SUCESS";
	}

	/**
	 * L� as defini��es gravadas no banco e exibe na p�gina.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String aPesquisarDesignacao() throws Exception {
		assertAcesso("DESIGNAR:Designar tarefas");

		selecionarApenasUmOrgao();

		limparCache();
		pd = WfContextBuilder.getJbpmContext().getJbpmContext()
				.getGraphSession().findLatestProcessDefinition(procedimento);

		if (pd != null) {
			listaDesignacaoRaia.addAll(getDesignacaoSwimlanes(pd));
			listaDesignacaoTarefa.addAll(getDesignacaoTarefas(pd));
		}

		return "SUCESS";

	}

	/**
	 * Este c�digo foi criadoporque a caixa de sele��o na linha 82 do arquivo
	 * pesquisarDesignacao.jsp est� considerando m�ltiplas sele��es embora
	 * esteja definido multiple="false". Segundo o site
	 * http://jira.opensymphony.com/browse/WW-1188 isso � um bug.
	 * */
	private void selecionarApenasUmOrgao() {
		if (orgao != null) {
			String[] lista = orgao.split(",");
			if (lista.length > 0) {
				orgao = lista[lista.length - 1].trim();
			}
		}
	}

	/**
	 * Como na p�gina pesquisarDesigna��o.jsp os componentes de sele��o dos
	 * atores s�o din�micos, � necess�ria a extra��o dos dados diretamente dos
	 * par�metros do request. O prefixo "matricula_" � difinido na p�gina
	 * pesquisaDesignacao.jsp e os sufixos "_pessoaSel.id" e "_pessoaSel.sigla"
	 * s�o definidos na TAG selecao.tag
	 * 
	 * @param id
	 *            da tarefa
	 * @return Um objeto DpPessoa do ator selecionado na p�gina.
	 */
	private DpPessoa extrairAtor(long id) {
		String keyMatriculaId = "matricula_" + id + "_pessoaSel.id";
		String keyMatriculaSigla = "matricula_" + id + "_pessoaSel.sigla";
		String responsavelId = null;
		String responsavelSigla = null;
		Map parametros = this.getRequest().getParameterMap();
		DpPessoa ator = null;

		if (parametros.containsKey(keyMatriculaId)
				&& parametros.containsKey(keyMatriculaSigla)) {
			responsavelId = ((String[]) parametros.get(keyMatriculaId))[0];
			responsavelSigla = ((String[]) parametros.get(keyMatriculaSigla))[0];
			if (!responsavelId.equals("") && !responsavelSigla.equals("")) {
				ator = daoPes(new Long(responsavelId));
			}
		}

		return ator;
	}

	/**
	 * Informa se a raia j� foi exibida na p�gina. Uilizada pela p�gina
	 * pesquisarDesigna��o.jsp.
	 * 
	 * @param nome
	 * @return
	 */
	public boolean isRaiaProcessada(String nome) {
		if (raiaProcessada.contains(nome)) {
			return true;
		} else {
			raiaProcessada.add(nome);
		}
		return false;
	}

	/**
	 * Como na p�gina pesquisarDesigna��o.jsp os componentes de sele��o das
	 * express�es s�o din�micas, � necess�ria a extra��o dos dados diretamente
	 * dos par�metros do request. O prefixo "tipoResponsavel_" � definido na
	 * p�gina pesquisarDesignacao.jsp
	 * 
	 * @param id
	 *            da tarefa
	 * @return Um objeto String com a express�o que equivale ao item
	 *         selecionado.
	 */
	private String extrairExpressao(long id) {

		String keyExpressao = "tipoResponsavel_" + id;
		String expressaoId = "expressao_" + id;
		Map parametros = this.getRequest().getParameterMap();
		String expressao = null;

		if (!this.getRequest().getParameterMap().containsKey(keyExpressao))
			return null;

		String responsavel = ((String[]) parametros.get(keyExpressao))[0];
		if (responsavel == null || responsavel.equals(""))
			return null;

		int idResp = new Integer(responsavel).intValue();

		if (idResp != TIPO_RESP_LOTA_SUP && idResp != TIPO_RESP_SUP_HIER
				&& idResp != TIPO_RESP_EXPRESSAO)
			return null;

		for (TipoResponsavel tr : listaTipoResponsavel) {
			if (tr.getId() == idResp) {
				expressao = tr.getValor();
				if (expressao == null || expressao.length() == 0) {
					expressao = ((String[]) parametros.get(expressaoId))[0];
				}
			}
		}
		return expressao;
	}

	/**
	 * Como na p�gina pesquisarDesigna��o.jsp os componentes de sele��o das
	 * lota��es s�o din�micas, � necess�ria a extra��o dos dados diretamente dos
	 * par�metros do request. O prefixo "lotacao_" � difinido na p�gina
	 * pesquisaDesignacao.jsp e os sufixos "_lotacaoSel.id" e
	 * "_lotacaoSel.sigla" s�o definidos na TAG selecao.tag
	 * 
	 * @param id
	 *            da tarefa
	 * @return Um objeto DpPessoa do ator selecionado na p�gina
	 */
	private DpLotacao extrairLotaAtor(long id) {
		String keyLotacaoId = "lotacao_" + id + "_lotacaoSel.id";
		String keyLotacaoSigla = "lotacao_" + id + "_lotacaoSel.sigla";
		String responsavelId = null;
		String responsavelSigla = null;
		Map parametros = this.getRequest().getParameterMap();
		DpLotacao lotaAtor = null;

		if (parametros.containsKey(keyLotacaoId)
				&& parametros.containsKey(keyLotacaoSigla)) {
			responsavelId = ((String[]) parametros.get(keyLotacaoId))[0];
			responsavelSigla = ((String[]) parametros.get(keyLotacaoSigla))[0];
			if (!responsavelId.equals("") && !responsavelSigla.equals("")) {
				lotaAtor = daoLot(new Long(responsavelId));
			}
		}
		return lotaAtor;
	}

	/**
	 * Busca um configura��o do tipo TIPO_CONFIG_DESIGNAR_TAREFA no banco de
	 * dados, caso exista.
	 * 
	 * @param nome
	 *            - Nome da raia ou tarefa.
	 * @param isRaia
	 *            - Determina se o par�metro anterior � uma raia ou tarefa.
	 * @return
	 * @throws Exception
	 */
	private WfConfiguracao getConfiguracaoExistente(String nome, boolean isRaia)
			throws Exception {
		WfConfiguracao fltConfigExistente = new WfConfiguracao();

		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_DESIGNAR_TAREFA,
				CpTipoConfiguracao.class, false);
		CpOrgaoUsuarioDaoFiltro fltOrgao = new CpOrgaoUsuarioDaoFiltro();
		fltOrgao.setSigla(orgao);
		CpOrgaoUsuario orgaoUsuario = (CpOrgaoUsuario) WfDao.getInstance()
				.consultarPorSigla(fltOrgao);

		fltConfigExistente.setCpTipoConfiguracao(tipoConfig);
		fltConfigExistente.setOrgaoUsuario(orgaoUsuario);
		fltConfigExistente.setProcedimento(procedimento);

		if (isRaia) {
			fltConfigExistente.setRaia(nome);
		} else {
			fltConfigExistente.setTarefa(nome);
		}

		CpConfiguracao cfgExistente = Wf.getInstance().getConf()
				.buscaConfiguracao(fltConfigExistente, new int[] { 0 }, null);

		return (WfConfiguracao) cfgExistente;
	}

	/**
	 * Monta a lista de designa��es que se referem �s raias.
	 * 
	 * @param pd
	 *            - Objeto ProcessDefinition
	 * @return - Lista de designa��es
	 * @throws Exception
	 */
	private List<Designacao> getDesignacaoSwimlanes(ProcessDefinition pd)
			throws Exception {

		WfConfiguracao cfgFiltro = new WfConfiguracao();

		CpOrgaoUsuarioDaoFiltro fltOrgao = new CpOrgaoUsuarioDaoFiltro();
		fltOrgao.setSigla(orgao);
		CpOrgaoUsuario orgaoUsuario = (CpOrgaoUsuario) WfDao.getInstance()
				.consultarPorSigla(fltOrgao);

		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_DESIGNAR_TAREFA,
				CpTipoConfiguracao.class, false);

		cfgFiltro.setCpTipoConfiguracao(tipoConfig);
		cfgFiltro.setOrgaoUsuario(orgaoUsuario);
		cfgFiltro.setProcedimento(procedimento);

		List<Designacao> resultado = new ArrayList<Designacao>();

		for (Object s : pd.getTaskMgmtDefinition().getSwimlanes().values()) {
			Swimlane raia = (Swimlane) s;

			for (Object t : raia.getTasks()) {
				Task tarefa = (Task) t;
				Designacao d = new Designacao();
				d.setProcedimento(procedimento);
				d.setId(tarefa.getId());
				d.setNomeDoNo(tarefa.getTaskNode() == null ? "" : tarefa
						.getTaskNode().getName());
				d.setTarefa(tarefa.getName());
				d.setRaia(raia.getName());
				cfgFiltro.setRaia(raia.getName());

				WfConfiguracao cfg = (WfConfiguracao) Wf.getInstance()
						.getConf()
						.buscaConfiguracao(cfgFiltro, new int[] { 0 }, null);

				if (cfg != null) {
					d.setAtor(cfg.getAtor());
					d.setLotaAtor(cfg.getLotaAtor());

					if (cfg.getExpressao() != null) {
						d.setExpressao(cfg.getExpressao());
						for (TipoResponsavel tr : listaTipoResponsavel) {
							if (tr.getValor().equals(d.getExpressao())) {
								d.setTipoResponsavel(tr.getId());
							}
						}
						if (d.getTipoResponsavel() == null) {
							d.setTipoResponsavel(TIPO_RESP_EXPRESSAO);
							d.setExpressao(cfg.getExpressao());
						}
					}
				}

				if (d.getAtor() != null) {
					d.setTipoResponsavel(TIPO_RESP_MATRICULA);
				}
				if (d.getLotaAtor() != null) {
					d.setTipoResponsavel(TIPO_RESP_LOTACAO);
				}

				resultado.add(d);
			}

		}

		return resultado;
	}

	/**
	 * Monta a lista de designa��es que se referem �s tarefas.
	 * 
	 * @param pd
	 *            - Objeto ProcessDefinition
	 * @return - Lista de designa��es
	 * @throws Exception
	 */
	private List<Designacao> getDesignacaoTarefas(ProcessDefinition pd)
			throws Exception {

		WfConfiguracao cfgFiltro = new WfConfiguracao();

		CpOrgaoUsuarioDaoFiltro fltOrgao = new CpOrgaoUsuarioDaoFiltro();
		fltOrgao.setSigla(orgao);
		CpOrgaoUsuario orgaoUsuario = (CpOrgaoUsuario) WfDao.getInstance()
				.consultarPorSigla(fltOrgao);

		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_DESIGNAR_TAREFA,
				CpTipoConfiguracao.class, false);

		cfgFiltro.setCpTipoConfiguracao(tipoConfig);
		cfgFiltro.setOrgaoUsuario(orgaoUsuario);
		cfgFiltro.setProcedimento(procedimento);

		List<Designacao> resultado = new ArrayList<Designacao>();
		for (Object o : pd.getTaskMgmtDefinition().getTasks().values()) {
			Task t = (Task) o;
			if (t.getSwimlane() == null) {
				Designacao d = new Designacao();
				d.setProcedimento(procedimento);
				d.setId(t.getId());
				d.setNomeDoNo(t.getTaskNode() == null ? "" : t.getTaskNode()
						.getName());
				d.setTarefa(t.getName());
				cfgFiltro.setTarefa(d.getTarefa());

				WfConfiguracao cfg = (WfConfiguracao) Wf.getInstance()
						.getConf()
						.buscaConfiguracao(cfgFiltro, new int[] { 0 }, null);

				if (cfg != null) {
					d.setAtor(cfg.getAtor());
					d.setLotaAtor(cfg.getLotaAtor());

					if (cfg.getExpressao() != null) {
						d.setExpressao(cfg.getExpressao());
						for (TipoResponsavel tr : listaTipoResponsavel) {
							if (tr.getValor().equals(d.getExpressao())) {
								d.setTipoResponsavel(tr.getId());
							}
						}
						if (d.getTipoResponsavel() == null) {
							d.setTipoResponsavel(TIPO_RESP_EXPRESSAO);
							d.setExpressao(cfg.getExpressao());
						}
					}
				}
				if (d.getAtor() != null) {
					d.setTipoResponsavel(TIPO_RESP_MATRICULA);
				}
				if (d.getLotaAtor() != null) {
					d.setTipoResponsavel(TIPO_RESP_LOTACAO);
				}

				resultado.add(d);
			}
		}

		return resultado;

	}

	/**
	 * Retorna a lista de designa��es atribu�das �s raias. Este m�todo � usado
	 * pela p�gina pesquisarDesigna��o.jsp
	 * 
	 * @return Lista de designa��es
	 */
	public List<Designacao> getListaDesignacaoRaia() {
		return listaDesignacaoRaia;
	}

	/**
	 * Retorna a lista de designa��es atribu�das �s tarefas. Este m�todo � usado
	 * pela p�gina pesquisarDesigna��o.jsp
	 * 
	 * @return Lista de designa��es
	 */
	public List<Designacao> getListaDesignacaoTarefa() {
		return listaDesignacaoTarefa;
	}

	/**
	 * Retorna a lista de �rg�os que podem ter designa��es definidas. Este
	 * m�todo � usado pela p�gina pesquisarDesigna��o.jsp
	 * 
	 * @return Lista de �rg�os
	 */
	public List<CpOrgaoUsuario> getListaOrgao() {
		return dao().listarOrgaosUsuarios();
	}

	/**
	 * Retorna a lista de procedimentos que podem ter designa��es definidas.
	 * Este m�todo � usado pela p�gina pesquisarDesigna��o.jsp
	 * 
	 * @return Lista de defini��es de processo
	 */
	public List<ProcessDefinition> getListaProcedimento() {
		List<ProcessDefinition> lista = WfContextBuilder.getJbpmContext()
				.getJbpmContext().getGraphSession()
				.findLatestProcessDefinitions();
		// Markenson: O c�digo abaixo foi inserido para evitar a carga de
		// definic�es de processos defeituosos
		// Esse problema foi detectado quando o Orlando fez o deploy de um
		// processo sem definir o nome
		// O tratamento de deploys deve fazer essa verifica��o
		List<ProcessDefinition> resultado = new ArrayList<ProcessDefinition>();
		for (ProcessDefinition p : lista) {
			if (p.getName() != null) {
				resultado.add(p);
			}
		}

		return resultado;
	}

	/**
	 * Retorna a lista de tipos de respons�veis que podem ter designa��es
	 * definidas. Este m�todo � usado pela p�gina pesquisarDesigna��o.jsp
	 * 
	 * @return Lista de designa��es
	 */
	public List<TipoResponsavel> getListaTipoResponsavel() {
		return listaTipoResponsavel;
	}

	/**
	 * Retorna o �rg�o selecionado.
	 * 
	 * @return Nome do �rg�o selecionado
	 */
	public String getOrgao() {
		return orgao;
	}

	/**
	 * Retorna o procedimento selecionado.
	 * 
	 * @return Nome do �rg�o selecionado
	 */
	public String getProcedimento() {
		return procedimento;
	}

	/**
	 * Grava a nova configura��o no banco de dados.
	 * 
	 * @param cfg
	 *            - Configura��o a ser gravada
	 * @throws Exception
	 */
	private void gravarNovaConfig(WfConfiguracao cfg) throws Exception {
		WfDao.getInstance().gravarComHistorico(cfg, getIdentidadeCadastrante());
	}

	/**
	 * Desativa uma configura��o existente.
	 * 
	 * @param cfgExistente
	 *            - objecto da configura��o existente
	 * @param dataFim
	 *            - data em que a configura��o ser� desativada
	 * @throws AplicacaoException
	 */
	private void invalidarConfiguracao(WfConfiguracao cfgExistente, Date dataFim)
			throws AplicacaoException {
		if (cfgExistente != null && cfgExistente.getHisDtFim() == null) {
			cfgExistente.setHisDtFim(dataFim);
			WfDao.getInstance().gravarComHistorico(cfgExistente,
					getIdentidadeCadastrante());
		}
	}

	/**
	 * Limpa o cache do hibernate. Como as configura��es s�o armazenadas em
	 * cache por serem pouco modificadas, faz-se necess�rio limpar o cache
	 * quando as configura��es s�o alteradas ou inclu�das, sen�o as
	 * configura��es somente ser�o v�lidas quando o session factory for
	 * reinicializado.
	 * 
	 * @throws Exception
	 */
	public void limparCache() throws Exception {

		SessionFactory sfWfDao = WfDao.getInstance().getSessao()
				.getSessionFactory();
		SessionFactory sfCpDao = CpDao.getInstance().getSessao()
				.getSessionFactory();

		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_DESIGNAR_TAREFA,
				CpTipoConfiguracao.class, false);

		Wf.getInstance().getConf().limparCacheSeNecessario();

		sfWfDao.evict(CpConfiguracao.class);
		sfWfDao.evict(WfConfiguracao.class);
		sfCpDao.evict(DpLotacao.class);

		sfWfDao.evictQueries(CpDao.CACHE_QUERY_CONFIGURACAO);

		return;

	}

	/**
	 * Prepara um objeto para receber uma nova configura��o.
	 * 
	 * @return Objeto apto a receber uma configura��o.
	 */
	private WfConfiguracao prepararConfiguracao() {
		WfConfiguracao cfg = new WfConfiguracao();
		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_DESIGNAR_TAREFA,
				CpTipoConfiguracao.class, false);
		CpOrgaoUsuarioDaoFiltro fltOrgao = new CpOrgaoUsuarioDaoFiltro();
		fltOrgao.setSigla(orgao);
		CpOrgaoUsuario orgaoUsuario = (CpOrgaoUsuario) WfDao.getInstance()
				.consultarPorSigla(fltOrgao);

		cfg.setCpTipoConfiguracao(tipoConfig);
		cfg.setOrgaoUsuario(orgaoUsuario);
		cfg.setProcedimento(procedimento);
		return cfg;
	}

	/**
	 * Processa as designa��es definidas para raia extraindo as informa��es do
	 * request.
	 * 
	 * @param raia
	 *            - Raia a ser processada
	 * @param cfg
	 *            - Configura��o pr�-processada que receber� as informa��es de
	 *            designa��o.
	 * @param horaDoBD
	 *            - Hora que ser� utilizada em todas as opera��es do banco de
	 *            dados fazendo com que todas as altera��es tenham o mesmo
	 *            hor�rio.
	 * @param raiasGravadas
	 * @return
	 * @throws Exception
	 */
	private List<Designacao> processarRaia(Swimlane raia, WfConfiguracao cfg,
			Date horaDoBD, Set<Long> raiasGravadas) throws Exception {

		if (!raiasGravadas.contains(raia.getId())) { // se a swimlane n�o foi
			// gravada ainda

			for (Object o : raia.getTasks()) {
				Task tarefaRaia = (Task) o;

				DpLotacao lotaAtor = null;
				DpPessoa ator = null;
				String expressao = null;

				lotaAtor = extrairLotaAtor(tarefaRaia.getId());
				ator = extrairAtor(tarefaRaia.getId());
				expressao = extrairExpressao(tarefaRaia.getId());

				if (ator != null || lotaAtor != null || expressao != null) {// se
					// configura��o
					// definida
					cfg.setAtor(ator);
					cfg.setLotaAtor(lotaAtor);
					cfg.setExpressao(expressao);

					cfg.setRaia(raia.getName());
					cfg.setHisDtIni(horaDoBD);

					WfConfiguracao cfgExistente = getConfiguracaoExistente(
							raia.getName(), true);
					invalidarConfiguracao(cfgExistente, horaDoBD);

					gravarNovaConfig(cfg);

					// atualiza os dados da vis�o
					for (Designacao d : listaDesignacaoRaia) {
						if (d.getRaia().equals(
								tarefaRaia.getSwimlane().getName())) {
							d.setAtor(null);
							d.setLotaAtor(null);
							d.setExpressao(null);
							if (ator != null) {
								d.setAtor(ator);
								d.setTipoResponsavel(TIPO_RESP_MATRICULA);
							}

							if (lotaAtor != null) {
								d.setLotaAtor(lotaAtor);
								d.setTipoResponsavel(TIPO_RESP_LOTACAO);
							}

							if (expressao != null) {
								d.setExpressao(expressao);
								for (TipoResponsavel tr : listaTipoResponsavel) {
									if (tr.getValor().equals(expressao)) {
										d.setTipoResponsavel(tr.getId());
									}
								}
							}
						}
					}
					break;

				} else { // configuracao indefinida
					WfConfiguracao cfgExistente = getConfiguracaoExistente(
							raia.getName(), true);
					invalidarConfiguracao(cfgExistente, horaDoBD);
				}

			}

			raiasGravadas.add(raia.getId());

		}

		return listaDesignacaoRaia;
	}

	/**
	 * Processa as designa��es definidas para a tarefa extraindo as informa��es
	 * do request.
	 * 
	 * @param t
	 *            - Tarefa a ser processada
	 * @param cfg
	 *            - Configura��o pr�-processada que receber� as informa��es de
	 *            designa��o.
	 * @param horaDoBD
	 *            - Hora que ser� utilizada em todas as opera��es do banco de
	 *            dados fazendo com que todas as altera��es tenham o mesmo
	 *            hor�rio.
	 * @return
	 * @throws Exception
	 */
	private List<Designacao> processarTarefa(Task t, WfConfiguracao cfg,
			Date horaDoBD) throws Exception {
		DpLotacao lotaAtor = null;
		DpPessoa ator = null;
		String expressao = null;

		lotaAtor = extrairLotaAtor(t.getId());
		ator = extrairAtor(t.getId());
		expressao = extrairExpressao(t.getId());

		if (ator != null || lotaAtor != null || expressao != null) {// se
			// configura��o
			// definida
			cfg.setAtor(ator);
			cfg.setLotaAtor(lotaAtor);
			cfg.setExpressao(expressao);

			cfg.setTarefa(t.getName());
			cfg.setHisDtIni(horaDoBD);

			WfConfiguracao cfgExistente = getConfiguracaoExistente(t.getName(),
					false);
			invalidarConfiguracao(cfgExistente, horaDoBD);

			gravarNovaConfig(cfg);
			// atualiza os dados da vis�o
			for (Designacao d : listaDesignacaoTarefa) {
				if (d.getTarefa().equals(t.getName())) {
					d.setAtor(null);
					d.setLotaAtor(null);
					d.setExpressao(null);
					if (ator != null) {
						d.setAtor(ator);
						d.setTipoResponsavel(TIPO_RESP_MATRICULA);
					}

					if (lotaAtor != null) {
						d.setLotaAtor(lotaAtor);
						d.setTipoResponsavel(TIPO_RESP_LOTACAO);
					}

					if (expressao != null) {
						d.setExpressao(expressao);
						for (TipoResponsavel tr : listaTipoResponsavel) {
							if (tr.getValor().equals(expressao)) {
								d.setTipoResponsavel(tr.getId());
							}
						}
					}

				}
			}

		} else { // configuracao indefinida
			WfConfiguracao cfgExistente = getConfiguracaoExistente(t.getName(),
					false);
			invalidarConfiguracao(cfgExistente, horaDoBD);
		}
		return listaDesignacaoTarefa;

	}

	/**
	 * Define a lista de designa��es.
	 * 
	 * @param listaDesignacao
	 */
	public void setListaDesignacao(List<Designacao> listaDesignacao) {
		this.listaDesignacao = listaDesignacao;
	}

	/**
	 * Define a lista de designa��es para um determinada raia.
	 * 
	 * @param listaDesignacaoRaia
	 */
	public void setListaDesignacaoRaia(List<Designacao> listaDesignacaoRaia) {
		this.listaDesignacaoRaia = listaDesignacaoRaia;
	}

	/**
	 * Define a lista de designa��es para um determinada tarefa.
	 * 
	 * @param listaDesignacaoTarefa
	 */
	public void setListaDesignacaoTarefa(List<Designacao> listaDesignacaoTarefa) {
		this.listaDesignacaoTarefa = listaDesignacaoTarefa;
	}

	/**
	 * Define o �rg�o.
	 * 
	 * @param orgao
	 */
	public void setOrgao(String orgao) {
		this.orgao = orgao;
	}

	/**
	 * Define o procedimento.
	 * 
	 * @param procedimento
	 */
	public void setProcedimento(String procedimento) {
		this.procedimento = procedimento;
	}

	/**
	 * Classe que representa o tipo do respons�vel designado.
	 * 
	 * @author kpf
	 * 
	 */
	class TipoResponsavel {
		int id;
		/**
		 * Texto amig�vel que representa o tipo de respons�vel.
		 */
		String texto;

		/**
		 * Texto da express�o ou identificador do tipo de respons�vel.
		 */
		String valor;

		/**
		 * Construtor da classe TipoRespons�vel.
		 * 
		 * @param id
		 * @param texto
		 * @param valor
		 */
		public TipoResponsavel(int id, String texto, String valor) {
			this.setId(id);
			this.setTexto(texto);
			this.setValor(valor);
		}

		/**
		 * Retorna o id do tipo de respons�vel.
		 * 
		 * @return
		 */
		public int getId() {
			return id;
		}

		/**
		 * Retorna o texto amig�vel do Tipo de respons�vel
		 * 
		 * @return
		 */
		public String getTexto() {
			return texto;
		}

		/**
		 * Retorna o valor do tipo de respons�vel, por exemplo, a express�o
		 * associada ao tipo de respons�vel.
		 * 
		 * @return
		 */
		public String getValor() {
			return valor;
		}

		/**
		 * Define o id do tipo de respons�vel.
		 * 
		 * @param id
		 */
		public void setId(int id) {
			this.id = id;
		}

		/**
		 * Define o texto amig�vel do tipo de respons�vel.
		 * 
		 * @param texto
		 */
		public void setTexto(String texto) {
			this.texto = texto;
		}

		/**
		 * Define o valor (por exemplo, a express�o) do tipo de respons�vel.
		 * 
		 * @param valor
		 */
		public void setValor(String valor) {
			this.valor = valor;
		}

		/**
		 * Retorna o texto amig�vel do tipo de respons�vel.
		 */
		public String toString() {
			return this.getTexto();
		}
	}
}
