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
package br.gov.jfrj.siga.cp.bl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.logging.Logger;

import org.hibernate.SessionFactory;
import org.hibernate.proxy.HibernateProxy;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpGrupo;
import br.gov.jfrj.siga.cp.CpIdentidade;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoServico;
import br.gov.jfrj.siga.cp.grupo.ConfiguracaoGrupo;
import br.gov.jfrj.siga.cp.grupo.ConfiguracaoGrupoFabrica;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpCargo;
import br.gov.jfrj.siga.dp.DpFuncaoConfianca;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.dp.dao.CpGrupoDaoFiltro;
import br.gov.jfrj.siga.model.dao.ModeloDao;

/**
 * @author eeh
 * 
 */
public class CpConfiguracaoBL {

	protected Date dtUltimaAtualizacaoCache = null;
	protected boolean cacheInicializado = false;

	protected Comparator<CpConfiguracao> comparator = null;

	protected static HashMap<Long, TreeSet<CpConfiguracao>> hashListas = new HashMap<Long, TreeSet<CpConfiguracao>>();

	public static int PESSOA = 1;

	public static int LOTACAO = 2;

	public static int FUNCAO = 3;

	public static int ORGAO = 4;

	public static int CARGO = 5;

	public static int SERVICO = 6;

	public static int IDENTIDADE = 7;

	public static int TIPO_LOTACAO = 8;

	public static int GRUPO = 9;

	public static int COMPLEXO = 10;

	public Comparator<CpConfiguracao> getComparator() {
		return comparator;
	}

	public void setComparator(Comparator<CpConfiguracao> comparator) {
		this.comparator = comparator;
	}

	public CpDao dao() {
		return CpDao.getInstance();
	}

	public CpConfiguracao createNewConfiguracao() {
		return new CpConfiguracao();
	}

	public HashMap<Long, TreeSet<CpConfiguracao>> getHashListas() {
		if (!cacheInicializado){
			inicializarCache();
		}

		return hashListas;
	}

	// public CpSituacaoConfiguracao buscaSituacao(T cpConfiguracao)
	// throws Exception {
	// T cpConfiguracaoResult = buscaConfiguracao(cpConfiguracao,
	// new int[] { 0 });
	// if (cpConfiguracaoResult != null)
	// return cpConfiguracaoResult.getCpSituacaoConfiguracao();
	// else
	// return cpConfiguracao.getCpTipoConfiguracao().getSituacaoDefault();
	// }

	public TreeSet<CpConfiguracao> getListaPorTipo(Long idTipoConfig)
			throws Exception {
			return getHashListas().get(idTipoConfig);
	}

	private synchronized void atualizarCache(Long idTipoConfig) {
			if (!cacheInicializado){
				inicializarCache();
				return;
			}
			Date dt = CpDao.getInstance().consultarDataUltimaAtualizacao();
	
			if (dtUltimaAtualizacaoCache == null || dt.after(dtUltimaAtualizacaoCache)) {
	
				SessionFactory sfCpDao = CpDao.getInstance().getSessao()
						.getSessionFactory();
				
				sfCpDao.evict(CpConfiguracao.class);
	
	
				List<CpConfiguracao> alteracoes = dao().consultarConfiguracoesDesde(dtUltimaAtualizacaoCache);
				Logger.getLogger("siga.conf.cache").fine("N�mero de altera��es no cache: " + alteracoes.size());
				if (alteracoes.size() > 0){
					evitarLazy(alteracoes);
					inicializarCache(idTipoConfig);
					
					for (CpConfiguracao cpConfiguracao : alteracoes) {
						Long idTpConf = cpConfiguracao.getCpTipoConfiguracao().getIdTpConfiguracao();
						inicializarCache(idTpConf);
						if (cpConfiguracao.ativaNaData(dt)){
							hashListas.get(idTpConf).add(cpConfiguracao);	
						}else{
							hashListas.get(idTpConf).remove(cpConfiguracao);
						}
					}
				}
	
				dtUltimaAtualizacaoCache = dt;
			}
	}

	protected void inicializarCache(Long idTipoConfig) {
		if (idTipoConfig!= null && hashListas.get(idTipoConfig) == null){
			TreeSet<CpConfiguracao> tree = new TreeSet<CpConfiguracao>(comparator);
			List<CpConfiguracao> results = (List<CpConfiguracao>) dao().consultarConfiguracoesPorTipo(idTipoConfig);
			evitarLazy(results);
			tree.addAll(results);
			hashListas.put(idTipoConfig, tree);
		}
	}

	/**
	 * Varre as entidades definidas na configura��o para evitar que o hibernate
	 * guarde vers�es lazy delas.
	 * 
	 * @param listaCfg
	 *            - lista de configura��es que podem ter objetos lazy
	 */
	protected void evitarLazy(List<CpConfiguracao> provResults) {
		for (CpConfiguracao cfg : provResults) {
			if (cfg.getCpSituacaoConfiguracao() != null){
				cfg.getCpSituacaoConfiguracao().getDscSitConfiguracao();
			}
			if (cfg.getOrgaoUsuario() != null)
				cfg.getOrgaoUsuario().getDescricao();
			if (cfg.getComplexo() != null)
				cfg.getComplexo().getNomeComplexo();
			if (cfg.getLotacao() != null)
				cfg.getLotacao().getSigla();
			if (cfg.getCargo() != null)
				cfg.getCargo().getDescricao();
			if (cfg.getFuncaoConfianca() != null)
				cfg.getFuncaoConfianca().getDescricao();
			if (cfg.getDpPessoa() != null){
				cfg.getDpPessoa().getDescricao();
//				cfg.getDpPessoa().getPessoaAtual().getDescricao();
			}
			if (cfg.getCpTipoConfiguracao() != null)
				cfg.getCpTipoConfiguracao().getDscTpConfiguracao();
			if (cfg.getCpServico() != null)
				cfg.getCpServico().getDescricao();
			if (cfg.getCpIdentidade() != null)
				cfg.getCpIdentidade().getNmLoginIdentidade();
			if (cfg.getCpGrupo() != null)
				cfg.getCpGrupo().getDescricao();
			if (cfg.getCpTipoLotacao() != null)
				cfg.getCpTipoLotacao().getDscTpLotacao();
			if (cfg.getHisIdcIni() != null)
				cfg.getHisIdcIni().getDpPessoa().getDescricao();
			if (cfg.getHisIdcFim() != null)
				cfg.getHisIdcFim().getDpPessoa().getDescricao();
		}
	}

	public void limparCacheSeNecessario() throws Exception {
		atualizarCache(null);
	}

	/**
	 * Limpa o cache do hibernate. Como as configura��es s�o mantidas em cache
	 * por motivo de performance, as altera��es precisam ser atualizadas para
	 * que possam valer imediatamente.
	 * 
	 * @throws Exception
	 */
	public void limparCache(CpTipoConfiguracao cpTipoConfig) throws Exception {

		atualizarCache(cpTipoConfig!=null?cpTipoConfig.getIdTpConfiguracao():null);

	}

	/**
	 * 
	 * Obt�m a configura��o a partir de um filtro, como uma consulta comum a uma
	 * entidade. O par�metro atributoDesconsideradoFiltro deve-se ao seguinte:
	 * para se escolher a configura��o a ser retornada do bando, s�o
	 * consideradas na base as configura��es que n�o possuam algum campo
	 * preenchido que nulo no filtro, a n�o ser que esse atributo tenha sido
	 * passado atrav�s desse par�metro. Se nenhuma lista de configura��es for
	 * informada, busca todas as configura��es para o TipoDeConfiguracao
	 * constante no filtro.
	 * 
	 * @param cpConfiguracaoFiltro
	 * @param atributoDesconsideradoFiltro
	 * @param lista
	 * @return
	 * @throws Exception
	 */
	public CpConfiguracao buscaConfiguracao(
			CpConfiguracao cpConfiguracaoFiltro,
			int atributoDesconsideradoFiltro[], Date dtEvn) throws Exception {
		deduzFiltro(cpConfiguracaoFiltro);

		Set<Integer> atributosDesconsiderados = new LinkedHashSet<Integer>();
		for (int i = 0; i < atributoDesconsideradoFiltro.length; i++) {
			atributosDesconsiderados.add(atributoDesconsideradoFiltro[i]);
		}

		SortedSet<CpPerfil> perfis = null;
		if (cpConfiguracaoFiltro.getCpTipoConfiguracao() != null
				&& cpConfiguracaoFiltro
						.getCpTipoConfiguracao()
						.getIdTpConfiguracao()
						.equals(CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO)) {
			perfis = consultarPerfisPorPessoaELotacao(
					cpConfiguracaoFiltro.getDpPessoa(),
					cpConfiguracaoFiltro.getLotacao(), dtEvn);

			// Quando o filtro especifica um perfil, ou seja, estamos tentando
			// avaliar as permiss�es de um determinado perfil, ele e todos os
			// seus pais devem ser inseridos na lista de perfis
			if (cpConfiguracaoFiltro.getCpGrupo() != null) {
				perfis = new TreeSet<CpPerfil>();
				Object g = cpConfiguracaoFiltro.getCpGrupo();
				while (true) {
					if (g instanceof HibernateProxy) {
						g = ((HibernateProxy) g).getHibernateLazyInitializer()
								.getImplementation();
					}
					if (g instanceof CpPerfil) {
						perfis.add((CpPerfil) g);
						g = ((CpGrupo) g).getCpGrupoPai();
						if (g == null)
							break;
					} else
						break;
				}
				if (perfis.size() == 0)
					perfis = null;
			}
		}

		TreeSet<CpConfiguracao> lista = null;
		// try {
		lista = getListaPorTipo(cpConfiguracaoFiltro.getCpTipoConfiguracao()
				.getIdTpConfiguracao());
		// } catch (Exception e) {
		// System.out.println(e.getStackTrace());
		// }

		for (CpConfiguracao cpConfiguracao : lista) {
			if ((!cpConfiguracao.ativaNaData(dtEvn))
					|| (cpConfiguracao.getCpSituacaoConfiguracao() != null && cpConfiguracao
							.getCpSituacaoConfiguracao()
							.getIdSitConfiguracao()
							.equals(CpSituacaoConfiguracao.SITUACAO_IGNORAR_CONFIGURACAO_ANTERIOR))
					|| !atendeExigencias(cpConfiguracaoFiltro,
							atributosDesconsiderados, cpConfiguracao, perfis))
				continue;
			return cpConfiguracao;
		}
		return null;
	}

	private SortedSet<CpPerfil> consultarPerfisPorPessoaELotacao(
			DpPessoa pessoa, DpLotacao lotacao, Date dtEvn) throws Exception {
		if (pessoa == null && lotacao == null)
			return null;
		TreeSet<CpConfiguracao> lista = getListaPorTipo(CpTipoConfiguracao.TIPO_CONFIG_PERTENCER);

		SortedSet<CpPerfil> perfis = new TreeSet<CpPerfil>();
		if (pessoa != null) {
			for (CpConfiguracao cfg : lista) {
				if (cfg.getCpGrupo() == null)
					continue;
				Object g = cfg.getCpGrupo();
				if (g instanceof HibernateProxy) {
					g = ((HibernateProxy) g).getHibernateLazyInitializer()
							.getImplementation();
				}
				if (!cfg.ativaNaData(dtEvn) || !(g instanceof CpPerfil))
					continue;
				if (cfg.getDpPessoa() != null
						&& !cfg.getDpPessoa().equivale(pessoa))
					continue;

				if (cfg.getCargo() != null
						&& !cfg.getCargo().equivale(pessoa.getCargo()))
					continue;

				if (cfg.getFuncaoConfianca() != null
						&& !cfg.getFuncaoConfianca().equivale(
								pessoa.getFuncaoConfianca()))
					continue;

				if (cfg.getLotacao() != null
						&& !cfg.getLotacao().equivale(lotacao))
					continue;

				if (cfg.getOrgaoUsuario() != null
						&& !cfg.getLotacao().getOrgaoUsuario()
								.equivale(lotacao.getOrgaoUsuario()))
					continue;

				do {
					perfis.add((CpPerfil) g);
					g = ((CpPerfil) g).getCpGrupoPai();
					if (g instanceof HibernateProxy) {
						g = ((HibernateProxy) g).getHibernateLazyInitializer()
								.getImplementation();
					}
				} while (g != null);
			}
		}
		return perfis;
	}

	/**
	 * 
	 * Obt�m a situa��o a partir de um filtro, como uma consulta comum a uma
	 * entidade. O par�metro atributoDesconsideradoFiltro deve-se ao seguinte:
	 * para se escolher a situa��o a ser retornada, s�o consideradas na base as
	 * configura��es que n�o possuam algum campo preenchido que nulo no filtro,
	 * a n�o ser que esse atributo tenha sido passado atrav�s desse par�metro.
	 * Caso nenhuma configura��o seja selecionada, a situa��o default do tipo de
	 * configura��o ser� retornada.
	 * 
	 * @param cpConfiguracaoFiltro
	 * @param atributoDesconsideradoFiltro
	 * @return
	 * @throws Exception
	 */
	public CpSituacaoConfiguracao buscaSituacao(
			CpConfiguracao cpConfiguracaoFiltro,
			int atributoDesconsideradoFiltro[], TreeSet<CpConfiguracao> lista)
			throws Exception {
		CpConfiguracao cfg = buscaConfiguracao(cpConfiguracaoFiltro,
				atributoDesconsideradoFiltro, null);
		if (cfg != null) {
			return cfg.getCpSituacaoConfiguracao();
		}
		return cpConfiguracaoFiltro.getCpTipoConfiguracao()
				.getSituacaoDefault();
	}

	/**
	 * @param cfgFiltro
	 * @param atributosDesconsiderados
	 * @param cfg
	 * @param perfis
	 */
	public boolean atendeExigencias(CpConfiguracao cfgFiltro,
			Set<Integer> atributosDesconsiderados, CpConfiguracao cfg,
			SortedSet<CpPerfil> perfis) {
		if (cfg.getCpServico() != null
				&& ((cfgFiltro.getCpServico() != null
						&& !cfgFiltro.getCpServico().equivale(
								cfg.getCpServico()) || ((cfgFiltro
						.getCpServico() == null) && !atributosDesconsiderados
						.contains(SERVICO)))))
			return false;

		if (cfg.getCpGrupo() != null
				&& (cfgFiltro.getCpGrupo() != null
						&& !cfg.getCpGrupo().equivale(cfgFiltro.getCpGrupo()) || ((cfgFiltro
						.getCpGrupo() == null) && !atributosDesconsiderados
						.contains(GRUPO))
						&& (perfis != null && !perfisContemGrupo(cfg, perfis))))
			return false;

		if (cfg.getCpIdentidade() != null
				&& ((cfgFiltro.getCpIdentidade() != null
						&& !cfg.getCpIdentidade().equivale(
								cfgFiltro.getCpIdentidade()) || ((cfgFiltro
						.getCpIdentidade() == null) && !atributosDesconsiderados
						.contains(IDENTIDADE)))))
			return false;

		if (cfg.getDpPessoa() != null
				&& ((cfgFiltro.getDpPessoa() != null
						&& !cfg.getDpPessoa().equivale(cfgFiltro.getDpPessoa()) || ((cfgFiltro
						.getDpPessoa() == null) && !atributosDesconsiderados
						.contains(PESSOA)))))
			return false;

		if (cfg.getLotacao() != null
				&& ((cfgFiltro.getLotacao() != null
						&& !cfg.getLotacao().equivale(cfgFiltro.getLotacao()) || ((cfgFiltro
						.getLotacao() == null) && !atributosDesconsiderados
						.contains(LOTACAO)))))
			return false;

		if (cfg.getComplexo() != null
				&& ((cfgFiltro.getComplexo() != null
						&& !cfg.getComplexo().equals(cfgFiltro.getComplexo()) || ((cfgFiltro
						.getComplexo() == null) && !atributosDesconsiderados
						.contains(COMPLEXO)))))
			return false;

		if (cfg.getFuncaoConfianca() != null
				&& ((cfgFiltro.getFuncaoConfianca() != null && !cfg
						.getFuncaoConfianca().getIdFuncao()
						.equals(cfgFiltro.getFuncaoConfianca().getIdFuncao())) || ((cfgFiltro
						.getFuncaoConfianca() == null) && !atributosDesconsiderados
						.contains(FUNCAO))))
			return false;

		if (cfg.getOrgaoUsuario() != null
				&& ((cfgFiltro.getOrgaoUsuario() != null && !cfg
						.getOrgaoUsuario().getIdOrgaoUsu()
						.equals(cfgFiltro.getOrgaoUsuario().getIdOrgaoUsu())) || ((cfgFiltro
						.getOrgaoUsuario() == null) && !atributosDesconsiderados
						.contains(ORGAO))))
			return false;

		if (cfg.getCargo() != null
				&& ((cfgFiltro.getCargo() != null && !cfg.getCargo()
						.getIdCargo().equals(cfgFiltro.getCargo().getIdCargo())) || ((cfgFiltro
						.getCargo() == null) && !atributosDesconsiderados
						.contains(CARGO))))
			return false;

		if (cfg.getCpTipoLotacao() != null
				&& ((cfgFiltro.getCpTipoLotacao() != null && !cfg
						.getCpTipoLotacao().getIdTpLotacao()
						.equals(cfgFiltro.getCpTipoLotacao().getIdTpLotacao())) || ((cfgFiltro
						.getCpTipoLotacao() == null) && !atributosDesconsiderados
						.contains(TIPO_LOTACAO))))
			return false;
		
		if (cfg.getOrgaoObjeto() != null
				&& ((cfgFiltro.getOrgaoObjeto() != null && !cfg
						.getOrgaoObjeto().getIdOrgaoUsu()
						.equals(cfgFiltro.getOrgaoObjeto().getIdOrgaoUsu())) || ((cfgFiltro
						.getOrgaoObjeto() == null) && !atributosDesconsiderados
						.contains(ORGAO))))
			return false;

		return true;
	}

	/**
	 * Verifica se a configuracao refere-se a um perfil ao qual a pessoa/lotacao
	 * pertence
	 * 
	 * @param cfg
	 *            - A configura��o a ser verificada
	 * @param perfis
	 *            - os perfis da pessoa/lotacao
	 * @return
	 */
	private boolean perfisContemGrupo(CpConfiguracao cfg,
			SortedSet<CpPerfil> perfis) {
		for (CpPerfil cpPerfil : perfis) {
			if (cpPerfil.equivale(cfg.getCpGrupo())) {
				return true;
			}
		}

		return false;
	}

	/**
	 * 
	 * M�todo com implementa��o completa, chamado pelas outras sobrecargas
	 * 
	 * @param cpTpDoc
	 * @param cpFormaDoc
	 * @param cpMod
	 * @param cpClassificacao
	 * @param cpVia
	 * @param cpTpMov
	 * @param cargo
	 * @param cpOrgaoUsu
	 * @param dpFuncaoConfianca
	 * @param dpLotacao
	 * @param dpPessoa
	 * @param nivelAcesso
	 * @param idTpConf
	 * @throws Exception
	 */
	public boolean podePorConfiguracao(CpOrgaoUsuario cpOrgaoUsu,
			DpLotacao dpLotacao, DpCargo cargo,
			DpFuncaoConfianca dpFuncaoConfianca, DpPessoa dpPessoa,
			CpServico cpServico, CpIdentidade cpIdentidade, CpGrupo cpGrupo,
			long idTpConf) throws Exception {

		CpConfiguracao cfgFiltro = createNewConfiguracao();

		cfgFiltro.setCargo(cargo);
		cfgFiltro.setOrgaoUsuario(cpOrgaoUsu);
		cfgFiltro.setFuncaoConfianca(dpFuncaoConfianca);
		cfgFiltro.setLotacao(dpLotacao);
		cfgFiltro.setDpPessoa(dpPessoa);
		cfgFiltro.setCpServico(cpServico);
		cfgFiltro.setCpIdentidade(cpIdentidade);
		cfgFiltro.setCpTipoLotacao(dpLotacao != null ? dpLotacao
				.getCpTipoLotacao() : null);
		cfgFiltro.setCpGrupo(cpGrupo);

		cfgFiltro.setCpTipoConfiguracao(CpDao.getInstance().consultar(idTpConf,
				CpTipoConfiguracao.class, false));

		CpConfiguracao cfg = (CpConfiguracao) buscaConfiguracao(cfgFiltro,
				new int[] { 0 }, null);

		CpSituacaoConfiguracao situacao;
		if (cfg != null) {
			situacao = cfg.getCpSituacaoConfiguracao();
		} else {
			situacao = cfgFiltro.getCpTipoConfiguracao().getSituacaoDefault();
		}

		if (situacao != null
				&& situacao.getIdSitConfiguracao() == CpSituacaoConfiguracao.SITUACAO_PODE)
			return true;
		return false;
	}

	/**
	 * 
	 * Usado para se verificar se uma pessoa pode realizar uma determinada
	 * opera��o no documento
	 * 
	 * @param dpPessoa
	 * @param dpLotacao
	 * @param idTpConf
	 * @throws Exception
	 */
	public boolean podePorConfiguracao(DpPessoa dpPessoa, DpLotacao dpLotacao,
			long idTpConf) throws Exception {
		return podePorConfiguracao(null, dpLotacao, null, null, dpPessoa, null,
				null, null, idTpConf);

	}

	public boolean podePorConfiguracao(DpPessoa dpPessoa, DpLotacao dpLotacao,
			CpServico cpServico, long idTpConf) throws Exception {
		return podePorConfiguracao(null, dpLotacao, null, null, dpPessoa,
				cpServico, null, null, idTpConf);

	}

	public boolean podePorConfiguracao(DpPessoa dpPessoa, long idTpConf)
			throws Exception {
		return podePorConfiguracao(null, null, null, null, dpPessoa, null,
				null, null, idTpConf);
	}

	public boolean podePorConfiguracao(DpLotacao dpLotacao, long idTpConf)
			throws Exception {
		return podePorConfiguracao(null, dpLotacao, null, null, null, null,
				null, null, idTpConf);
	}

	public boolean podePorConfiguracao(CpIdentidade cpIdentidade, long idTpConf)
			throws Exception {
		return podePorConfiguracao(null, null, null, null, null, null,
				cpIdentidade, null, idTpConf);
	}

	public boolean podePorConfiguracao(DpPessoa dpPessoa, DpLotacao dpLotacao,
			CpGrupo cpGrupo, long idTpConf) throws Exception {
		return podePorConfiguracao(null, dpLotacao, null, null, dpPessoa, null,
				null, cpGrupo, idTpConf);
	}

	/**
	 * Infere configura��es �bvias. Por exemplo, se for informada a pessoa, a
	 * lota��o, �rg�o etc. j� ser�o preenchidos automaticamente.
	 * 
	 * @param cpConfiguracao
	 */
	public void deduzFiltro(CpConfiguracao cpConfiguracao) {

		if (cpConfiguracao == null)
			return;

		if (cpConfiguracao.getCpIdentidade() != null) {
			if (cpConfiguracao.getDpPessoa() == null)
				cpConfiguracao.setDpPessoa(cpConfiguracao.getCpIdentidade()
						.getDpPessoa());
		}

		if (cpConfiguracao.getDpPessoa() != null) {
			if (cpConfiguracao.getLotacao() == null)
				cpConfiguracao.setLotacao(cpConfiguracao.getDpPessoa()
						.getLotacao());
			if (cpConfiguracao.getCargo() == null)
				cpConfiguracao
						.setCargo(cpConfiguracao.getDpPessoa().getCargo());
			if (cpConfiguracao.getFuncaoConfianca() == null)
				cpConfiguracao.setFuncaoConfianca(cpConfiguracao.getDpPessoa()
						.getFuncaoConfianca());
		}

		if (cpConfiguracao.getLotacao() != null)
			if (cpConfiguracao.getOrgaoUsuario() == null)
				cpConfiguracao.setOrgaoUsuario(cpConfiguracao.getLotacao()
						.getOrgaoUsuario());
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

	@SuppressWarnings("static-access")
	public Boolean podeUtilizarServicoPorConfiguracao(DpPessoa titular,
			DpLotacao lotaTitular, String servicoPath) throws Exception {
		try {
			if (titular == null || lotaTitular == null)
				return false;

			CpServico srv = null;
			CpServico srvPai = null;
			CpServico srvRecuperado = null;

			srvRecuperado = dao().consultarCpServicoPorChave(servicoPath);
			if (srvRecuperado == null) {
				// Constroi uma linha completa, tipo full path
				for (String s : servicoPath.split(";")) {
					String[] asParts = s.split(":"); // Separa a sigla da
														// descri��o
					String sSigla = asParts[0];
					srv = new CpServico();
					srv.setSiglaServico(srvPai != null ? srvPai.getSigla()
							+ "-" + sSigla : sSigla);
					srv.setCpServicoPai(srvPai);
					srvRecuperado = dao().consultarPorSigla(srv);
					if (srvRecuperado == null) {
						CpTipoServico tpsrv = dao().consultar(
								CpTipoServico.TIPO_CONFIG_SISTEMA,
								CpTipoServico.class, false);
						String sDesc = (asParts.length > 1 ? asParts[1] : "");
						srv.setDscServico(sDesc);
						srv.setCpServicoPai(srvPai);
						srv.setCpTipoServico(tpsrv);
						dao().iniciarTransacao();
						srvRecuperado = dao().gravar(srv);
						dao().commitTransacao();
					}
					srvPai = srvRecuperado;
				}
			}
			return Cp
					.getInstance()
					.getConf()
					.podePorConfiguracao(titular, lotaTitular, srvRecuperado,
							CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO);
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * Localiza as ConfiguracaoGrupoEmail pertencentes a um determinado grupo
	 * 
	 * @param CpGrupo
	 *            p_grpGrupo - O grupo que deseja localizar.
	 * 
	 * @throws Exception
	 */
	public ArrayList<ConfiguracaoGrupo> obterCfgGrupo(CpGrupo grp)
			throws Exception {

		ArrayList<ConfiguracaoGrupo> aCfgGrp = new ArrayList<ConfiguracaoGrupo>();
		ConfiguracaoGrupoFabrica fabrica = new ConfiguracaoGrupoFabrica();
		try {
			for (CpConfiguracao cfg : Cp
					.getInstance()
					.getConf()
					.getListaPorTipo(
							/* tpCfgPertencer */CpTipoConfiguracao.TIPO_CONFIG_PERTENCER)) {
				if (cfg.getCpGrupo() == null || !cfg.getCpGrupo().equivale(grp)
						|| cfg.getHisDtFim() != null)
					continue;
				ConfiguracaoGrupo cfgGrp = fabrica.getInstance(cfg);
				aCfgGrp.add(cfgGrp);
			}
		} catch (Exception e) {
			throw new AplicacaoException("Erro obtendo configura��es", 0, e);
		}
		return aCfgGrp;
	}

	/**
	 * Retorna as pessoas que podem acessar o grupos de seguran�a da lota��o
	 * 
	 * @param lot
	 * @return
	 */
	public Set<DpPessoa> getPessoasGrupoSegManual(DpLotacao lot) {

		Set<DpPessoa> resultado = new HashSet<DpPessoa>();
		try {
			limparCacheSeNecessario();
			Set<CpConfiguracao> configs = Cp
					.getInstance()
					.getConf()
					.getListaPorTipo(
							CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO_OUTRA_LOTACAO);
			for (CpConfiguracao c : configs) {
				DpPessoa pesAtual = CpDao.getInstance().consultarPorIdInicial(c.getDpPessoa().getIdInicial());
				if (c.getDpPessoa().equivale(pesAtual)) {
					if (c.getHisAtivo() == 1
							&& pesAtual.getDataFim() == null
							&& c.getLotacao().getIdInicial()
									.equals(lot.getIdInicial())) {
						resultado.add(pesAtual);
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return resultado;

	}

	public Set<DpLotacao> getLotacoesGrupoSegManual(DpPessoa pes) {
		Set<DpLotacao> resultado = new HashSet<DpLotacao>();
		try {
			limparCacheSeNecessario();
			Set<CpConfiguracao> configs = Cp
					.getInstance()
					.getConf()
					.getListaPorTipo(
							CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO_OUTRA_LOTACAO);
			for (CpConfiguracao c : configs) {
				DpLotacao lotacaoAtual = c.getLotacao().getLotacaoAtual();
				if (c.getHisAtivo() == 1
						&& lotacaoAtual.getDataFim() == null
						&& c.getDpPessoa().getIdInicial()
								.equals(pes.getIdInicial())) {
					resultado.add(lotacaoAtual);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return resultado;

	}

	public void excluirPessoaExtra(DpPessoa pes, DpLotacao lot,
			CpTipoConfiguracao tpConf, CpIdentidade identidadeCadastrante) {
		ModeloDao.iniciarTransacao();
		try {
			Set<CpConfiguracao> configs = getListaPorTipo(tpConf
					.getIdTpConfiguracao());
			for (CpConfiguracao c : configs) {
				if (c.getHisDtFim() == null && c.getDpPessoa().equivale(pes)
						&& c.getLotacao().equivale(lot)) {
					c.setHisDtFim(dao().consultarDataEHoraDoServidor());
					dao().gravarComHistorico(c, identidadeCadastrante);
				}
			}
			ModeloDao.commitTransacao();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public boolean podeGerirAlgumGrupo(DpPessoa titular, DpLotacao lotaTitular,
			Long idCpTipoGrupo) throws Exception {
		return dao().getGruposGeridos(titular, lotaTitular, idCpTipoGrupo)
				.size() > 0;
	}

	public boolean podeGerirGrupo(DpPessoa titular, DpLotacao lotaTitular,
			Long idCpGrupo, Long idCpTipoGrupo) {

		try {
			CpGrupoDaoFiltro flt = new CpGrupoDaoFiltro();
			CpGrupo cpGrp = CpDao.getInstance().consultar(idCpGrupo,
					CpGrupo.class, false);
			flt.setIdTpGrupo(idCpTipoGrupo.intValue());
			CpConfiguracaoBL bl = Cp.getInstance().getConf();

			return bl.podePorConfiguracao(titular, lotaTitular, cpGrp,
					CpTipoConfiguracao.TIPO_CONFIG_GERENCIAR_GRUPO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public synchronized void inicializarCache() {
		if (!cacheInicializado){
			Logger.getLogger("siga.conf.cache").info("Inicializando cache de configura��es via " + this.getClass().getSimpleName());
			long inicio = System.currentTimeMillis();

			List<CpTipoConfiguracao> tiposConfiguracao = CpDao.getInstance().listarTiposConfiguracao();
			for (CpTipoConfiguracao cpTpConf : tiposConfiguracao) {
				try{
			        inicializarCache(cpTpConf.getIdTpConfiguracao());
				}catch(Exception e){
					Logger.getLogger("siga.conf.cache").warning("N�o foi poss�vel inicializar o cache CP_TIPO_CONFIGURACAO [" + cpTpConf.getDscTpConfiguracao() + "] ID: [" + cpTpConf.getIdTpConfiguracao() + "]");
				}
			}
			cacheInicializado = true;
			
			Logger.getLogger("siga.conf.cache").info("Cache de configura��es inicializado em ms: " + (System.currentTimeMillis() - inicio));
		}
	}

}
