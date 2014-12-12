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
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.hibernate.SessionFactory;
import org.jbpm.graph.def.ProcessDefinition;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.cp.bl.CpConfiguracaoBL;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.dp.dao.CpOrgaoUsuarioDaoFiltro;
import br.gov.jfrj.siga.wf.Permissao;
import br.gov.jfrj.siga.wf.WfConfiguracao;
import br.gov.jfrj.siga.wf.bl.Wf;
import br.gov.jfrj.siga.wf.dao.WfDao;
import br.gov.jfrj.siga.wf.util.WfContextBuilder;

/**
 * Classe que representa as a��es de configura��o do workflow.
 * 
 * @author kpf
 * 
 */
public class WfConfiguracaoAction extends WfSigaActionSupport {

	private static int TIPO_RESP_INDEFINIDO = 0;
	private static int TIPO_RESP_MATRICULA = 1;
	private static int TIPO_RESP_LOTACAO = 2;

	private List<Permissao> listaPermissao = new ArrayList<Permissao>();
	private List<TipoResponsavel> listaTipoResponsavel = new ArrayList<TipoResponsavel>();

	private String orgao;
	private String procedimento;

	private ProcessDefinition pd;

	/**
	 * Inicializa os tipos de respons�veis e suas respectivas express�es, quando
	 * houver.
	 */
	public WfConfiguracaoAction() {

		TipoResponsavel tpIndefinido = new TipoResponsavel(
				TIPO_RESP_INDEFINIDO, "[Indefinido]", "");
		TipoResponsavel tpMatricula = new TipoResponsavel(TIPO_RESP_MATRICULA,
				"Matr�cula", "matricula");
		TipoResponsavel tpLotacao = new TipoResponsavel(TIPO_RESP_LOTACAO,
				"Lota��o", "lotacao");

		listaTipoResponsavel.add(tpIndefinido);
		listaTipoResponsavel.add(tpMatricula);
		listaTipoResponsavel.add(tpLotacao);
	}

	/**
	 * Grava a configura��o da permiss�o. Primeiro, processa-se as altera�es nas
	 * permiss�es existentes e depois processa-se as novas permiss�es. As
	 * permiss�es indefinidas s�o exclu�das da lista de permiss�es.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String aGravarConfiguracao() throws Exception {

		pd = WfContextBuilder.getJbpmContext().getJbpmContext()
				.getGraphSession().findLatestProcessDefinition(procedimento);
		Date horaDoDB = dao().consultarDataEHoraDoServidor();

		if (pd != null) {

			// processa permiss�es existentes
			listaPermissao = getPermissoes(pd);
			for (Permissao perm : listaPermissao) {
				WfConfiguracao cfg = prepararConfiguracao();

				processarPermissao(perm, cfg, horaDoDB);

			}

			// processa nova permiss�o
			WfConfiguracao cfg = prepararConfiguracao();
			Permissao novaPermissao = new Permissao();
			novaPermissao.setId(this.getIdNovaPermissao());
			novaPermissao.setProcedimento(procedimento);

			processarPermissao(novaPermissao, cfg, horaDoDB);

			if (novaPermissao.getPessoa() != null
					|| novaPermissao.getLotacao() != null) {
				listaPermissao.add(novaPermissao);
			}

			// remove permiss�es inv�lidas
			ArrayList<Permissao> listaAux = new ArrayList<Permissao>();
			for (Permissao perm : listaPermissao) {
				if (perm.getPessoa() != null || perm.getLotacao() != null) {
					listaAux.add(perm);
				}
			}

			listaPermissao = listaAux;

			limparCache();
		}

		return "SUCESS";
	}

	/**
	 * Seleciona um procedimento que ter� suas permiss�es configuradas.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String aConfigurar() throws Exception {
		assertAcesso("CONFIGURAR:Configurar iniciadores");

		limparCache();
		pd = WfContextBuilder.getJbpmContext().getJbpmContext()
				.getGraphSession().findLatestProcessDefinition(procedimento);

		if (pd != null) {
			listaPermissao.addAll(getPermissoes(pd));
		}

		return "SUCESS";

	}

	/**
	 * Este m�todo pega os par�metros do request, identifica qual foi a
	 * matr�cula da pessoa selecionada (selecao.tag) e busca o objeto DpPessoa
	 * no banco de dados.
	 * 
	 * @param id
	 * @return Retorna um objeto DpPessoa baseado no id da permiss�o.
	 */
	private DpPessoa extrairPessoa(long id) {
		String keyMatriculaId = "matricula_" + id + "_pessoaSel.id";
		String keyMatriculaSigla = "matricula_" + id + "_pessoaSel.sigla";
		String responsavelId = null;
		String responsavelSigla = null;
		Map parametros = this.getRequest().getParameterMap();
		DpPessoa pessoa = null;

		if (parametros.containsKey(keyMatriculaId)
				&& parametros.containsKey(keyMatriculaSigla)) {
			responsavelId = ((String[]) parametros.get(keyMatriculaId))[0];
			responsavelSigla = ((String[]) parametros.get(keyMatriculaSigla))[0];
			if (!responsavelId.equals("") && !responsavelSigla.equals("")) {
				pessoa = daoPes(new Long(responsavelId));
			}
		}

		return pessoa;
	}

	/**
	 * Este m�todo pega os par�metros do request, identifica qual foi a sigla da
	 * lota��o selecionada (selecao.tag) e busca o objeto DpLotacao no banco de
	 * dados.
	 * 
	 * @param id
	 * @return Retorna um objeto DpLotacao baseado no id da permiss�o.
	 */
	private DpLotacao extrairLotacao(long id) {
		String keyLotacaoId = "lotacao_" + id + "_lotacaoSel.id";
		String keyLotacaoSigla = "lotacao_" + id + "_lotacaoSel.sigla";
		String responsavelId = null;
		String responsavelSigla = null;
		Map parametros = this.getRequest().getParameterMap();
		DpLotacao lotacao = null;

		if (parametros.containsKey(keyLotacaoId)
				&& parametros.containsKey(keyLotacaoSigla)) {
			responsavelId = ((String[]) parametros.get(keyLotacaoId))[0];
			responsavelSigla = ((String[]) parametros.get(keyLotacaoSigla))[0];
			if (!responsavelId.equals("") && !responsavelSigla.equals("")) {
				lotacao = daoLot(new Long(responsavelId));
			}
		}
		return lotacao;
	}

	/**
	 * Retorna a lista de configura��es definidas para uma permiss�o.
	 * 
	 * @param perm
	 *            -
	 * @return Lista de permiss�es j� gravadas no banco de dados.
	 * @throws Exception
	 */
	private List<WfConfiguracao> getConfiguracaoExistente(Permissao perm)
			throws Exception {
		WfConfiguracao fltConfigExistente = new WfConfiguracao();

		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_INSTANCIAR_PROCEDIMENTO,
				CpTipoConfiguracao.class, false);
		CpOrgaoUsuarioDaoFiltro fltOrgao = new CpOrgaoUsuarioDaoFiltro();
		fltOrgao.setSigla(orgao);
		CpOrgaoUsuario orgaoUsuario = (CpOrgaoUsuario) WfDao.getInstance()
				.consultarPorSigla(fltOrgao);

		fltConfigExistente.setCpTipoConfiguracao(tipoConfig);
		fltConfigExistente.setOrgaoUsuario(orgaoUsuario);
		fltConfigExistente.setProcedimento(procedimento);
		fltConfigExistente.setDpPessoa(perm.getPessoa());
		fltConfigExistente.setLotacao(perm.getLotacao());

		List<WfConfiguracao> cfgExistente = WfDao.getInstance().consultar(
				fltConfigExistente);
		List<WfConfiguracao> resultado = new ArrayList<WfConfiguracao>();
		// Melhorar isso: o filtro por pessoa ou lota��o n�o est� funcionando
		for (WfConfiguracao c : cfgExistente) {
			if ((c.getDpPessoa() != null || c.getLotacao() != null)
					&& c.getHisDtFim() == null
					&& c.getIdConfiguracao().equals(perm.getId())) {
				resultado.add(c);
			}
		}

		return resultado;
	}

	/**
	 * Retorna a lista de permiss�es definidas para uma defini��o de
	 * procedimento.
	 * 
	 * @param pd
	 *            - Defini��o de processo
	 * @return - Lista de permiss�es
	 * @throws Exception
	 */
	private List<Permissao> getPermissoes(ProcessDefinition pd)
			throws Exception {

		CpOrgaoUsuarioDaoFiltro fltOrgao = new CpOrgaoUsuarioDaoFiltro();
		fltOrgao.setSigla(orgao);
		CpOrgaoUsuario orgaoUsuario = (CpOrgaoUsuario) WfDao.getInstance()
				.consultarPorSigla(fltOrgao);

		List<Permissao> resultado = new ArrayList<Permissao>();

		TreeSet<CpConfiguracao> cfg = Wf.getInstance().getConf()
				.getListaPorTipo(
						CpTipoConfiguracao.TIPO_CONFIG_INSTANCIAR_PROCEDIMENTO);
		for (CpConfiguracao c : cfg) {

			if (c instanceof WfConfiguracao) {
				WfConfiguracao wfC = (WfConfiguracao) c;
				if (wfC.getProcedimento() != null
						&& wfC.getProcedimento().equals(procedimento)
						&& wfC.getHisDtFim() == null) {

					Permissao perm = new Permissao();
					perm.setProcedimento(procedimento);
					perm.setId(c.getIdConfiguracao());

					perm.setPessoa(c.getDpPessoa());
					perm.setLotacao(c.getLotacao());

					if (perm.getPessoa() != null) {
						perm.setTipoResponsavel(TIPO_RESP_MATRICULA);
					}
					if (perm.getLotacao() != null) {
						perm.setTipoResponsavel(TIPO_RESP_LOTACAO);
					}

					resultado.add(perm);
				}
			}
		}

		return resultado;

	}

	/**
	 * Retorna a lista de permiss�es. Este m�todo � utilizado para montar a
	 * view.
	 * 
	 * @return
	 */
	public List<Permissao> getListaPermissao() {
		return listaPermissao;
	}

	/**
	 * Retorna a lista de �rg�os. Este m�todo � utilizado para montar a view.
	 * 
	 * @return
	 */
	public List<CpOrgaoUsuario> getListaOrgao() {
		return dao().listarOrgaosUsuarios();
	}

	/**
	 * Retorna a lista dos tipos de respons�veis. Este m�todo � utilizado para
	 * montar a view.
	 * 
	 * @return
	 */
	public List<TipoResponsavel> getListaTipoResponsavel() {
		return listaTipoResponsavel;
	}

	/**
	 * Retorna o �rg�o selecionado. Este m�todo � utilizado para montar a view.
	 * 
	 * @return
	 */
	public String getOrgao() {
		return orgao;
	}

	/**
	 * Retorna o procedimento selecionado. Este m�todo � utilizado para montar a
	 * view.
	 * 
	 * @return
	 */
	public String getProcedimento() {
		return procedimento;
	}

	/**
	 * M�todo utilizado para gravar uma nova configura��o. ATEN��O: ESTE M�TODO
	 * PROVAVELMENTE PODE SER ELIMINADO EM UM REFACTORING.
	 * 
	 * @param cfg
	 * @throws Exception
	 */
	private void gravarNovaConfig(WfConfiguracao cfg) throws Exception {
		WfDao.getInstance().gravarComHistorico(cfg, getIdentidadeCadastrante());
	}

	/**
	 * Torna uma configura��o existente inv�lida. A invalida��o da configura��o
	 * normalmente ocorre ao se criar uma nova configura��o. A configura��o
	 * antiga torna-se inv�lida mas continua sendo mantida no banco de dados
	 * para fins de hist�rico.
	 * 
	 * @param cfgExistente
	 *            - Configura��o a ser invalidada
	 * @param dataFim
	 *            - Data que define o fim da validade da configura��o, ou seja,
	 *            data de invalida��o.
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
	 * Limpa o cache do hibernate. Como as configura��es s�o mantidas em cache
	 * por motivo de performance, as altera��es precisam ser atualizadas para
	 * que possam valer imediatamente.
	 * 
	 * @throws Exception
	 */
	public void limparCache() throws Exception {

		SessionFactory sfWfDao = WfDao.getInstance().getSessao()
				.getSessionFactory();
		SessionFactory sfCpDao = CpDao.getInstance().getSessao()
				.getSessionFactory();

		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_INSTANCIAR_PROCEDIMENTO,
				CpTipoConfiguracao.class, false);

		Wf.getInstance().getConf().limparCacheSeNecessario();

		sfWfDao.evict(CpConfiguracao.class);
		sfWfDao.evict(WfConfiguracao.class);
		sfCpDao.evict(DpLotacao.class);

		sfWfDao.evictQueries(CpDao.CACHE_QUERY_CONFIGURACAO);

		return;

	}

	/**
	 * Inicia um objeto WfConfiguracao de modo que possa receber as
	 * configura��es definidas pelo usu�rio.
	 * 
	 * @return - Configura��o pronta para receber as configura��es.
	 */
	private WfConfiguracao prepararConfiguracao() {
		WfConfiguracao cfg = new WfConfiguracao();
		CpTipoConfiguracao tipoConfig = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_INSTANCIAR_PROCEDIMENTO,
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
	 * Processa as permiss�es definidas pelo usu�rio. S�o extra�dos os dados do
	 * request, definida a data de in�cio da configura��o, definidas as
	 * permiss�es, definida a invalida��o da configura��o antiga e atualizada a
	 * vis�o do usu�rio.
	 * 
	 * @param permissao
	 *            - Permiss�o a ser processada
	 * @param cfg
	 *            - Configura��o preparada para receber as novas configura��es
	 * @param horaDoBD
	 *            - Hora do banco de dados. A data/hora de in�cio de vig�ncia
	 *            deve ser a mesma da invalida��o da configura��o anterior.
	 * @throws Exception
	 */
	private void processarPermissao(Permissao permissao, WfConfiguracao cfg,
			Date horaDoBD) throws Exception {
		DpLotacao lotacao = null;
		DpPessoa pessoa = null;

		lotacao = extrairLotacao(permissao.getId());
		pessoa = extrairPessoa(permissao.getId());

		if (pessoa != null || lotacao != null) {// se
			// configura��o
			// definida
			cfg.setDpPessoa(pessoa);
			cfg.setLotacao(lotacao);

			cfg.setHisDtIni(horaDoBD);

			for (WfConfiguracao cfgExistente : getConfiguracaoExistente(permissao)) {
				invalidarConfiguracao(cfgExistente, horaDoBD);
			}

			permissao.setPessoa(pessoa);
			permissao.setLotacao(lotacao);

			CpSituacaoConfiguracao sit = new CpSituacaoConfiguracao();
			sit.setIdSitConfiguracao(CpSituacaoConfiguracao.SITUACAO_PODE);
			cfg.setCpSituacaoConfiguracao(sit);
			gravarNovaConfig(cfg);
			permissao.setId(cfg.getIdConfiguracao()); // deixa de usar a id
			// tempor�ria

			// atualiza os dados da vis�o
			if (pessoa != null) {
				permissao.setPessoa(pessoa);
				permissao.setTipoResponsavel(TIPO_RESP_MATRICULA);
			}

			if (lotacao != null) {
				permissao.setLotacao(lotacao);
				permissao.setTipoResponsavel(TIPO_RESP_LOTACAO);
			}

		} else {
			for (WfConfiguracao cfgExistente : getConfiguracaoExistente(permissao)) {
				invalidarConfiguracao(cfgExistente, horaDoBD);
			}

			permissao.setPessoa(pessoa);
			permissao.setLotacao(lotacao);
		}

	}

	/**
	 * Define a lista de permiss�es.
	 * 
	 * @param listaPermissao
	 */
	public void setListaPermissao(List<Permissao> listaPermissao) {
		this.listaPermissao = listaPermissao;
	}

	/**
	 * Define o �rg�o que ter� as permiss�es configuradas.
	 * 
	 * @param orgao
	 */
	public void setOrgao(String orgao) {
		this.orgao = orgao;
	}

	/**
	 * Define o procedimento que ter� as permiss�es configuradas.
	 * 
	 * @param procedimento
	 */
	public void setProcedimento(String procedimento) {
		this.procedimento = procedimento;
	}

	/**
	 * Retorna um id TEMPOR�RIO para uma nova configura��o definida pelo
	 * usu�rio. Para que n�o haja conflito de ID's foi escolhido o �ltimo valor
	 * do tipo long.
	 * 
	 * @return - ID tempor�rio.
	 */
	public Long getIdNovaPermissao() {
		return Long.MAX_VALUE;
	}

	/**
	 * Classe interna que define o tipo de respons�vel.
	 * 
	 * @author kpf
	 * 
	 */
	class TipoResponsavel {
		int id;
		String texto;
		String valor;

		/**
		 * M�todo construtor.
		 * 
		 * @param id
		 *            - Tipo de respons�vel. Pode ser TIPO_RESP_INDEFINIDO = 0
		 *            (quando for indefinido), TIPO_RESP_MATRICULA = 1 (Quando
		 *            for permiss�o para uma pessoa) ou TIPO_RESP_LOTACAO = 2
		 *            (quando for permiss�o para uma lota��o);
		 * @param texto
		 *            - Nome amig�vel do tipo de respons�vel. Este texto �
		 *            utilizado na view.
		 * @param valor
		 *            - Uma EXPRESS�O Quando o tipo de respons�vel for uma
		 *            express�o, "matricula" quando for uma pessoa ou "lotacao"
		 *            quando for uma lotacao.
		 */
		public TipoResponsavel(int id, String texto, String valor) {
			this.setId(id);
			this.setTexto(texto);
			this.setValor(valor);
		}

		/**
		 * Retorna o tipo de respons�vel.
		 * 
		 * @return
		 */
		public int getId() {
			return id;
		}

		/**
		 * Retorna o nome amig�vel do tipo de respons�vel. Utilizado na view.
		 * 
		 * @return
		 */
		public String getTexto() {
			return texto;
		}

		/**
		 * Retorna o valor do respons�vel. Por exemplo, retorna uma express�o
		 * (por exemplo, previous --> chefe()) quando o respons�vel for definido
		 * por uma express�o
		 * 
		 * @return
		 */
		public String getValor() {
			return valor;
		}

		/**
		 * Define o id do tipo de respons�vel. Pode ser TIPO_RESP_INDEFINIDO = 0
		 * (quando for indefinido), TIPO_RESP_MATRICULA = 1 (Quando for
		 * permiss�o para uma pessoa) ou TIPO_RESP_LOTACAO = 2 (quando for
		 * permiss�o para uma lota��o);
		 * 
		 * @param id
		 */
		public void setId(int id) {
			this.id = id;
		}

		/**
		 * Define o texto amig�vel do tipo de respons�vel. Utilizado na view.
		 * 
		 * @param texto
		 */
		public void setTexto(String texto) {
			this.texto = texto;
		}

		/**
		 * Define o valor do tipo de respons�vel. Por exemplo, retorna uma
		 * express�o (por exemplo, previous --> chefe()) quando o respons�vel
		 * for definido por uma express�o
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
