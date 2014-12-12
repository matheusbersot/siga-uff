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
 * Criado em  01/12/2005
 *
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.siga.dp.dao;

import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import net.sf.ehcache.config.CacheConfiguration;

import org.hibernate.CacheMode;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.StatelessSession;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.DefaultNamingStrategy;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.DateUtils;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpGrupo;
import br.gov.jfrj.siga.cp.CpGrupoDeEmail;
import br.gov.jfrj.siga.cp.CpIdentidade;
import br.gov.jfrj.siga.cp.CpModelo;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoGrupo;
import br.gov.jfrj.siga.cp.CpTipoIdentidade;
import br.gov.jfrj.siga.cp.CpTipoPapel;
import br.gov.jfrj.siga.cp.CpUnidadeMedida;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.cp.bl.CpAmbienteEnumBL;
import br.gov.jfrj.siga.cp.bl.CpConfiguracaoBL;
import br.gov.jfrj.siga.cp.bl.CpPropriedadeBL;
import br.gov.jfrj.siga.cp.bl.SituacaoFuncionalEnum;
import br.gov.jfrj.siga.cp.model.HistoricoAuditavel;
import br.gov.jfrj.siga.dp.CpAplicacaoFeriado;
import br.gov.jfrj.siga.dp.CpFeriado;
import br.gov.jfrj.siga.dp.CpLocalidade;
import br.gov.jfrj.siga.dp.CpMarcador;
import br.gov.jfrj.siga.dp.CpOrgao;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.CpPersonalizacao;
import br.gov.jfrj.siga.dp.CpTipoLotacao;
import br.gov.jfrj.siga.dp.CpTipoPessoa;
import br.gov.jfrj.siga.dp.CpUF;
import br.gov.jfrj.siga.dp.DpCargo;
import br.gov.jfrj.siga.dp.DpFuncaoConfianca;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.DpSubstituicao;
import br.gov.jfrj.siga.model.Selecionavel;
import br.gov.jfrj.siga.model.dao.DaoFiltro;
import br.gov.jfrj.siga.model.dao.HibernateUtil;
import br.gov.jfrj.siga.model.dao.ModeloDao;

public class CpDao extends ModeloDao {

	public static final String CACHE_QUERY_SUBSTITUICAO = "query.substituicao";
	public static final String CACHE_QUERY_CONFIGURACAO = "query.configuracao";
	public static final String CACHE_CORPORATIVO = "corporativo";
	public static final String CACHE_QUERY_SECONDS = "query.seconds";
	public static final String CACHE_QUERY_HOURS = "query.hours";
	public static final String CACHE_SECONDS = "seconds";

	public static CpDao getInstance(Session sessao, StatelessSession sessaoStateless) {
		return ModeloDao.getInstance(CpDao.class, sessao, sessaoStateless);
	}
	
	public static CpDao getInstance(Session sessao) {
		return ModeloDao.getInstance(CpDao.class, sessao);
	}

	public static CpDao getInstance() {
		return ModeloDao.getInstance(CpDao.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpOrgao> consultarPorFiltro(final CpOrgaoDaoFiltro o) {
		return consultarPorFiltro(o, 0, 0);
	}

	@SuppressWarnings("unchecked")
	public List<CpOrgao> consultarPorFiltro(final CpOrgaoDaoFiltro o,
			final int offset, final int itemPagina) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorFiltroCpOrgao");
			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			final List<CpOrgao> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<CpOrgao> consultarCpOrgaoOrdenadoPorNome() {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarCpOrgaoOrdenadoPorNome");
			final List<CpOrgao> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<CpFeriado> listarCpFeriadoPorDescricao() {
		try {
			final Query query = getSessao().getNamedQuery(
					"listarCpFeriadoOrdenadoPorDescricao");
			final List<CpFeriado> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public CpOrgao consultarPorSigla(final CpOrgao o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaCpOrgao");
		query.setString("siglaOrgao", o.getSiglaOrgao());

		final List<CpOrgao> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	@SuppressWarnings("unchecked")
	public CpServico consultarPorSigla(final CpServico o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaCpServico");
		query.setString("siglaServico", o.getSiglaServico());
		query.setLong("idServicoPai", o.getCpServicoPai() == null ? 0 : o
				.getCpServicoPai().getIdServico());

		// Renato: Comentei a linha abaixo pois n�o entendi porque foi feito
		// dessa forma.
		// query.setFlushMode(FlushMode.MANUAL);

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_HOURS);

		final List<CpServico> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	@SuppressWarnings("unchecked")
	public CpServico consultarCpServicoPorChave(String chave) {
		// Cria uma cache region espec�fica da classe para garantir que os
		// objetos armazenados por uma aplica��o n�o seja recuperados por outra.
		// Isso causa ClassCastException.
		final String cRegion = CACHE_CORPORATIVO + "_"
				+ this.getClass().getSimpleName();
		Cache cache = CacheManager.getInstance().getCache(cRegion);
		if (cache == null) {
			CacheManager manager = CacheManager.getInstance();
			manager.addCache(cRegion);
			cache = manager.getCache(cRegion);
			CacheConfiguration config;
			config = cache.getCacheConfiguration();
			config.setEternal(true);
			config.setMaxElementsInMemory(10000);
			config.setOverflowToDisk(false);
			config.setMaxElementsOnDisk(0);
		}
		Element element;
		if ((element = cache.get(chave)) != null) {
			return (CpServico) element.getValue();
		}

		StringBuilder sb = new StringBuilder(50);
		boolean supress = false;
		for (int i = 0; i < chave.length(); i++) {
			final char ch = chave.charAt(i);
			if (ch == ';') {
				sb.append('-');
				supress = false;
				continue;
			}
			if (ch == ':') {
				supress = true;
				continue;
			}
			if (!supress)
				sb.append(ch);
		}
		String sigla = sb.toString();

		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaStringCpServico");
		query.setString("siglaServico", sigla);

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_HOURS);

		final List<CpServico> l = query.list();
		if (l.size() != 1)
			return null;

		// For�a a carga de algums campos para garantir o lazy load.
		CpServico srv = (CpServico) l.get(0).getImplementation();
		Object o1 = srv.getCpServicoPai().getDescricao();
		Object o2 = srv.getCpTipoServico().getDscTpServico();

		cache.put(new Element(chave, srv));
		return l.get(0);
	}

	public Selecionavel consultarPorSigla(final CpOrgaoDaoFiltro flt) {
		final CpOrgao o = new CpOrgao();
		o.setSigla(flt.getSigla());
		return consultarPorSigla(o);
	}

	// public int consultarQuantidade(final DaoFiltro o) {
	// if (o instanceof CpOrgaoDaoFiltro)
	// return consultarQuantidade((CpOrgaoDaoFiltro) o);
	// if (o instanceof CpOrgaoUsuarioDaoFiltro)
	// return consultarQuantidade((CpOrgaoUsuarioDaoFiltro) o);
	// if (o instanceof DpCargoDaoFiltro)
	// return consultarQuantidade((DpCargoDaoFiltro) o);
	// if (o instanceof DpFuncaoConfiancaDaoFiltro)
	// return consultarQuantidade((DpFuncaoConfiancaDaoFiltro) o);
	// if (o instanceof DpLotacaoDaoFiltro)
	// return consultarQuantidade((DpLotacaoDaoFiltro) o);
	// if (o instanceof DpPessoaDaoFiltro)
	// return consultarQuantidade((DpPessoaDaoFiltro) o);
	// return 0;
	// }

	public int consultarQuantidade(final DaoFiltro o) throws Exception,
			SecurityException, IllegalAccessException,
			InvocationTargetException, NoSuchMethodException {
		Class[] argType = { o.getClass() };
		return (Integer) this.getClass()
				.getMethod("consultarQuantidade", argType).invoke(this, o);
	}

	public Selecionavel consultarPorSigla(final DaoFiltro o) throws Exception,
			SecurityException, IllegalAccessException,
			InvocationTargetException, NoSuchMethodException {
		Class[] argType = { o.getClass() };
		return (Selecionavel) this.getClass()
				.getMethod("consultarPorSigla", argType).invoke(this, o);
	}

	public int consultarQuantidade(final CpOrgaoDaoFiltro o) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarQuantidadeCpOrgao");
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	public List consultarPorFiltro(final DaoFiltro o) throws Exception {
		return consultarPorFiltro(o, 0, 0);
	}

	public List consultarPorFiltro(final DaoFiltro o, final int offset,
			final int itemPagina) throws Exception {
		Class[] argType = { o.getClass(), Integer.TYPE, Integer.TYPE };
		return (List) this.getClass().getMethod("consultarPorFiltro", argType)
				.invoke(this, o, offset, itemPagina);
	}

	@SuppressWarnings("unchecked")
	public List<CpOrgaoUsuario> consultarPorFiltro(
			final CpOrgaoUsuarioDaoFiltro o) {
		return consultarPorFiltro(o, 0, 0);
	}

	@SuppressWarnings("unchecked")
	public List<CpOrgaoUsuario> consultarPorFiltro(
			final CpOrgaoUsuarioDaoFiltro o, final int offset,
			final int itemPagina) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorFiltroCpOrgao");
			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			query.setCacheable(true);
			query.setCacheRegion(CACHE_QUERY_HOURS);

			final List<CpOrgaoUsuario> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public CpOrgaoUsuario consultarPorSigla(final CpOrgaoUsuario o) {
		final Query query = getSessao().getNamedQuery(
				"consultarSiglaOrgaoUsuario");
		query.setString("sigla", o.getSiglaOrgaoUsu());

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_HOURS);

		final List<CpOrgaoUsuario> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	public Selecionavel consultarPorSigla(final CpOrgaoUsuarioDaoFiltro flt) {
		final CpOrgaoUsuario o = new CpOrgaoUsuario();
		o.setSigla(flt.getSigla());
		return consultarPorSigla(o);
	}

	public int consultarQuantidade(final CpOrgaoUsuarioDaoFiltro o) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarQuantidadeCpOrgao");
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			query.setCacheable(true);
			query.setCacheRegion(CACHE_QUERY_HOURS);

			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	@SuppressWarnings("unchecked")
	public List<DpCargo> consultarPorFiltro(final DpCargoDaoFiltro o) {
		return consultarPorFiltro(o, 0, 0);
	}

	@SuppressWarnings("unchecked")
	public List<DpCargo> consultarPorFiltro(final DpCargoDaoFiltro o,
			final int offset, final int itemPagina) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorFiltroDpCargo");
			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			if (o.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", o.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			final List<DpCargo> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public DpCargo consultarPorSigla(final DpCargo o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaDpCargo");
		query.setLong("idCargoIni", o.getIdCargoIni());

		final List<DpCargo> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	public Selecionavel consultarPorSigla(final DpCargoDaoFiltro flt) {
		final DpCargo o = new DpCargo();
		o.setSigla(flt.getSigla());
		return consultarPorSigla(o);
	}

	public int consultarQuantidade(final DpCargoDaoFiltro o) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarQuantidadeDpCargo");
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			if (o.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", o.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	@SuppressWarnings("unchecked")
	public List<DpFuncaoConfianca> consultarPorFiltro(
			final DpFuncaoConfiancaDaoFiltro o) {
		return consultarPorFiltro(o, 0, 0);
	}

	@SuppressWarnings("unchecked")
	public List<DpFuncaoConfianca> consultarPorFiltro(
			final DpFuncaoConfiancaDaoFiltro o, final int offset,
			final int itemPagina) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorFiltroDpFuncaoConfianca");
			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);

			if (o.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", o.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			final List<DpFuncaoConfianca> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<CpAplicacaoFeriado> listarAplicacoesFeriado(final CpAplicacaoFeriado apl) {
		final Query query = getSessao().getNamedQuery(
				"listarAplicacoesFeriado");
		query.setLong("cpOcorrenciaFeriado", apl.getCpOcorrenciaFeriado().getId());

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_HOURS);

		final List<CpAplicacaoFeriado> l = query.list();
		return l;
	}
	

	@SuppressWarnings("unchecked")
	public DpFuncaoConfianca consultarPorSigla(final DpFuncaoConfianca o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaDpFuncaoConfianca");
		query.setLong("idFuncao", o.getIdFuncao());
		if (o.getOrgaoUsuario() != null)
			query.setLong("idOrgaoUsu", o.getOrgaoUsuario().getIdOrgaoUsu());
		else
			query.setLong("idOrgaoUsu", 0);

		final List<DpFuncaoConfianca> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	public Selecionavel consultarPorSigla(final DpFuncaoConfiancaDaoFiltro flt) {
		final DpFuncaoConfianca o = new DpFuncaoConfianca();
		o.setSigla(flt.getSigla());
		CpOrgaoUsuario cpOrgao = new CpOrgaoUsuario();
		cpOrgao.setIdOrgaoUsu(flt.getIdOrgaoUsu());
		o.setOrgaoUsuario(cpOrgao);
		return consultarPorSigla(o);
	}

	public int consultarQuantidade(final DpFuncaoConfiancaDaoFiltro o) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarQuantidadeDpFuncaoConfianca");
			String s = o.getNome();
			if (s != null)
				s = s.replace(' ', '%');
			query.setString("nome", s);
			if (o.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", o.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	public List<DpPessoa> consultarPessoasComFuncaoConfianca(Long idFuncao) {
		final Query query = getSessao().getNamedQuery(
				"consultarPessoasComFuncaoConfianca");
		query.setLong("idFuncaoConfianca", idFuncao);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<DpPessoa> consultarPessoasComCargo(Long idCargo) {
		final Query query = getSessao().getNamedQuery(
				"consultarPessoasComCargo");
		query.setLong("idCargo", idCargo);
		return query.list();
	}

	public List<DpLotacao> consultarPorFiltro(final DpLotacaoDaoFiltro o) {
		return consultarPorFiltro(o, 0, 0);
	}

	@SuppressWarnings("unchecked")
	public List<DpLotacao> consultarPorFiltro(final DpLotacaoDaoFiltro o,
			final int offset, final int itemPagina) {
		try {
			final Query query;

			if (!o.isBuscarFechadas())
				query = getSessao()
						.getNamedQuery("consultarPorFiltroDpLotacao");
			else
				query = getSessao().getNamedQuery(
						"consultarPorFiltroDpLotacaoInclusiveFechadas");
			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			query.setString("nome", o.getNome() == null ? "" : o.getNome()
					.replace(' ', '%'));

			if (o.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", o.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			query.setCacheable(true);
			query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
			final List<DpLotacao> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public DpLotacao consultarPorSigla(final DpLotacao o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaDpLotacao");
		query.setString("siglaLotacao", o.getSigla());
		if (o.getOrgaoUsuario() != null) 
			if (o.getOrgaoUsuario().getIdOrgaoUsu() != null) 
				query.setLong("idOrgaoUsu", o.getOrgaoUsuario().getIdOrgaoUsu());
			else 
				query.setLong("idOrgaoUsu", consultarPorSigla(o.getOrgaoUsuario()).getId());	
		else
			query.setLong("idOrgaoUsu", 0);

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
		final List<DpLotacao> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	@SuppressWarnings("unchecked")
	public DpLotacao consultarPorIdInicial(Class<DpLotacao> clazz,
			final Long idInicial) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorIdInicialDpLotacao");
		query.setLong("idLotacaoIni", idInicial);

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
		final List<DpLotacao> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	@SuppressWarnings("unchecked")
	public DpLotacao consultarPorIdInicialInclusiveLotacaoFechada(
			Class<DpLotacao> clazz, final Long idInicial) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorIdInicialDpLotacaoInclusiveFechada");
		query.setLong("idLotacaoIni", idInicial);

		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
		final List<DpLotacao> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	public Selecionavel consultarPorSigla(final DpLotacaoDaoFiltro flt) {
		final DpLotacao o = new DpLotacao();
		o.setSigla(flt.getSigla());
		if (o.getOrgaoUsuario() == null && flt.getIdOrgaoUsu() != null){
			CpOrgaoUsuario cpOrgaoUsu = consultar(flt.getIdOrgaoUsu(), CpOrgaoUsuario.class, false);
			o.setOrgaoUsuario(cpOrgaoUsu);
		}
		
		
/*		CpOrgaoUsuario cpOrgao = new CpOrgaoUsuario();
		cpOrgao.setIdOrgaoUsu(flt.getIdOrgaoUsu());
		o.setOrgaoUsuario(cpOrgao);*/
		return consultarPorSigla(o);
	}

	public int consultarQuantidade(final DpLotacaoDaoFiltro o) {
		try {
			final Query query;

			if (!o.isBuscarFechadas())
				query = getSessao().getNamedQuery(
						"consultarQuantidadeDpLotacao");
			else
				query = getSessao().getNamedQuery(
						"consultarQuantidadeDpLotacaoInclusiveFechadas");

			query.setString("nome", o.getNome().replace(' ', '%'));

			if (o.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", o.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			query.setCacheable(true);
			query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	public Selecionavel consultarPorSigla(final CpGrupoDaoFiltro flt)
			throws AplicacaoException {
		final CpGrupo o = CpGrupo.getInstance(flt.getIdTpGrupo());
		o.setSigla(flt.getSigla());
		return consultarPorSigla(o);
	}

	@SuppressWarnings("unchecked")
	public CpGrupo consultarPorSigla(final CpGrupo o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaCpGrupo");
		query.setString("siglaGrupo", o.getSigla());
		if (o.getOrgaoUsuario() != null)
			query.setLong("idOrgaoUsu", o.getOrgaoUsuario().getIdOrgaoUsu());
		else
			query.setLong("idOrgaoUsu", 0);
		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_HOURS);
		final List<CpGrupo> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	@SuppressWarnings("unchecked")
	public CpPerfil consultarPorSigla(final CpPerfil o) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaCpGrupo");
		query.setString("siglaGrupo", o.getSigla());
		if (o.getOrgaoUsuario() != null)
			query.setLong("idOrgaoUsu", o.getOrgaoUsuario().getIdOrgaoUsu());
		else
			query.setLong("idOrgaoUsu", 0);
		query.setCacheable(true);
		query.setCacheRegion(CACHE_QUERY_HOURS);
		final List<CpPerfil> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	public int consultarQuantidade(final CpGrupoDaoFiltro o) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarQuantidadeCpGrupoPorCpTipoGrupoId");
			if (o.getIdTpGrupo() != null) {
				query.setLong("idTpGrupo", o.getIdTpGrupo());
			} else {
				query.setLong("idTpGrupo", 0);
			}
			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	@SuppressWarnings("unchecked")
	public List<CpGrupo> consultarPorFiltro(final CpGrupoDaoFiltro o,
			final int offset, final int itemPagina) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarCpGrupoPorCpTipoGrupoId");
			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			if (o.getIdTpGrupo() != null) {
				query.setLong("idTpGrupo", o.getIdTpGrupo());
			} else {
				query.setLong("idTpGrupo", 0);
			}
			final List<CpGrupo> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	public DpPessoa consultarPorCpf(final long cpf) {

		final Query qry = getSessao().getNamedQuery("consultarPorCpf");
		qry.setLong("cpfPessoa", cpf);
		final DpPessoa pes = (DpPessoa) qry.uniqueResult();
		return pes;
	}

	public DpPessoa consultarPorEmail(final String email) {

		final Query qry = getSessao().getNamedQuery("consultarPorEmail");
		qry.setString("emailPessoa", email);
		final DpPessoa pes = (DpPessoa) qry.uniqueResult();
		return pes;
	}

	@SuppressWarnings("unchecked")
	public DpPessoa consultarPorSigla(final DpPessoa o) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorSiglaDpPessoa");
			query.setString("sesb", o.getSesbPessoa());
			query.setLong("matricula", o.getMatricula());
			/*
			 * if (o.getOrgaoUsuario().getIdOrgaoUsu() != null)
			 * query.setLong("idOrgaoUsu", o.getOrgaoUsuario().getIdOrgaoUsu());
			 * else query.setLong("idOrgaoUsu", 0);
			 */

			final List<DpPessoa> l = query.list();
			if (l.size() != 1)
				return null;
			return l.get(0);
		} catch (final NullPointerException e) {
			return null;
		}
	}

	/**
	 * retorna a pessoa pelo sesb+matricula
	 * 
	 * @param principal
	 * @return
	 */
	public DpPessoa getPessoaPorPrincipal(String principal) {
		DpPessoa pessoaTemplate = new DpPessoa();
		pessoaTemplate.setSesbPessoa(principal.substring(0, 2));
		pessoaTemplate.setMatricula(Long.parseLong(principal.substring(2)));
		DpPessoa pessoaNova = CpDao.getInstance().consultarPorSigla(
				pessoaTemplate);
		return pessoaNova;
	}

	@SuppressWarnings("unchecked")
	public DpPessoa consultarPorIdInicial(final Long idInicial) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorIdInicialDpPessoa");
			query.setLong("idPessoaIni", idInicial);

			query.setCacheable(true);
			query.setCacheRegion(CACHE_QUERY_HOURS);

			final List<DpPessoa> l = query.list();
			if (l.size() != 1)
				return null;
			return l.get(0);
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<DpPessoa> consultarPorIdInicialInclusiveFechadas(
			final Long idInicial) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorIdInicialDpPessoaInclusiveFechadas");
			query.setLong("idPessoaIni", idInicial);

			return query.list();
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public DpPessoa consultarPorIdInicialInclusiveLotacaoFechada(
			final Long idInicial) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorIdInicialDpLotacaoInclusiveFechada");
			query.setLong("idPessoaIni", idInicial);

			final List<DpPessoa> l = query.list();
			if (l.size() != 1)
				return null;
			return l.get(0);
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<CpUF> consultarUF() {

		Query query = getSessao().createQuery(
				"from CpUF l order by l.nmUF");
		List l = query.list();
		return l;
	}
	
	@SuppressWarnings("unchecked")
	public List<CpLocalidade> consultarLocalidadesPorUF(final CpUF cpuf) {

		Query query = getSessao().createQuery(
				"from CpLocalidade l where l.UF.idUF = "
						+ cpuf.getIdUF().intValue());
		List l = query.list();
		return l;
	}

	@SuppressWarnings("unchecked")
	public List<CpLocalidade> consultarLocalidadesPorUF(final String siglaUF) {

		Query query = getSessao().createQuery(
				"from CpLocalidade l where l.UF.nmUF = :siglaUF");
		query.setString("siglaUF", siglaUF);
		List l = query.list();
		return l;
	}
	
	@SuppressWarnings("unchecked")
	public List<CpLocalidade> consultarLocalidades() {

		Query query = getSessao().createQuery(
				"from CpLocalidade l order by l.nmLocalidade");
		List l = query.list();
		return l;
	}	

	@SuppressWarnings("unchecked")
	public CpPersonalizacao consultarPersonalizacao(DpPessoa pes) {
		final Query query = getSessao()
				.getNamedQuery("consultarPersonalizacao");
		query.setLong("idPessoaIni", pes.getIdPessoaIni());

		// query.setCacheable(true);
		// query.setCacheRegion("query.CpPersonalizacao");
		final List<CpPersonalizacao> l = query.list();
		if (l.size() != 1)
			return null;
		return l.get(0);
	}

	public List<DpPessoa> consultarPorFiltro(final DpPessoaDaoFiltro flt) {
		return consultarPorFiltro(flt, 0, 0);
	}

	@SuppressWarnings("unchecked")
	public List<DpPessoa> consultarAtivasNaDataOrgao(final Date dt,
			final CpOrgaoUsuario org) {
		final Query query;
		query = getSessao().getNamedQuery("consultarAtivasNaDataOrgao");
		query.setLong("idOrgaoUsu", org.getIdOrgaoUsu());
		query.setDate("dt", dt);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<DpPessoa> consultarPorFiltro(final DpPessoaDaoFiltro flt,
			final int offset, final int itemPagina) {
		try {
			final Query query;

			if (!flt.isBuscarFechadas())
				query = getSessao().getNamedQuery("consultarPorFiltroDpPessoa");
			else
				query = getSessao().getNamedQuery(
						"consultarPorFiltroDpPessoaInclusiveFechadas");

			if (offset > 0) {
				query.setFirstResult(offset);
			}
			if (itemPagina > 0) {
				query.setMaxResults(itemPagina);
			}
			query.setString("nome",
					flt.getNome().toUpperCase().replace(' ', '%'));

			if (!flt.isBuscarFechadas())
				query.setString("situacaoFuncionalPessoa",
						flt.getSituacaoFuncionalPessoa());

			if (flt.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", flt.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);

			if (flt.getLotacao() != null)
				query.setLong("lotacao", flt.getLotacao().getId());
			else
				query.setLong("lotacao", 0);

			final List<DpPessoa> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<DpPessoa> consultarPorOrgaoUsuDpPessoaInclusiveFechadas(
			final long idOrgaoUsu) {
		try {
			final Query query = getSessao().getNamedQuery(
					"consultarPorOrgaoUsuDpPessoaInclusiveFechadas");

			query.setLong("idOrgaoUsu", idOrgaoUsu);

			final List<DpPessoa> l = query.list();
			return l;
		} catch (final NullPointerException e) {
			return null;
		}
	}

	public int consultarQuantidade(final DpPessoaDaoFiltro flt) {
		try {
			final Query query;

			if (!flt.isBuscarFechadas())
				query = getSessao()
						.getNamedQuery("consultarQuantidadeDpPessoa");
			else
				query = getSessao().getNamedQuery(
						"consultarQuantidadeDpPessoaInclusiveFechadas");

			query.setString("nome",
					flt.getNome().toUpperCase().replace(' ', '%'));

			if (!flt.isBuscarFechadas())
				query.setString("situacaoFuncionalPessoa",
						flt.getSituacaoFuncionalPessoa());

			if (flt.getIdOrgaoUsu() != null)
				query.setLong("idOrgaoUsu", flt.getIdOrgaoUsu());
			else
				query.setLong("idOrgaoUsu", 0);
			if (flt.getLotacao() != null)
				query.setLong("lotacao", flt.getLotacao().getId());
			else
				query.setLong("lotacao", 0);

			final int l = ((Long) query.uniqueResult()).intValue();
			return l;
		} catch (final NullPointerException e) {
			return 0;
		}
	}

	public Selecionavel consultarPorSigla(final DpPessoaDaoFiltro flt) {
		final DpPessoa o = new DpPessoa();
		o.setSigla(flt.getSigla());
		/*
		 * CpOrgaoUsuario cpOrgao = new CpOrgaoUsuario();
		 * cpOrgao.setIdOrgaoUsu(flt.getIdOrgaoUsu());
		 * o.setOrgaoUsuario(cpOrgao);
		 */
		return consultarPorSigla(o);
	}

	@SuppressWarnings("unchecked")
	public List<DpSubstituicao> consultarSubstituicoesPermitidas(
			final DpSubstituicao exemplo) throws SQLException {
		try {
			Query query = null;
			query = getSessao().getNamedQuery(
					"consultarSubstituicoesPermitidas");
			query.setLong("idSubstitutoIni", exemplo.getSubstituto()
					.getIdPessoaIni());
			query.setLong("idLotaSubstitutoIni", exemplo.getLotaSubstituto()
					.getIdLotacaoIni());
			// query.setCacheable(true);
			// query.setCacheRegion(CACHE_QUERY_SUBSTITUICAO);
			return query.list();
		} catch (final IllegalArgumentException e) {
			throw e;
		} catch (final Exception e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<DpSubstituicao> consultarOrdemData(final DpSubstituicao exemplo)
			throws SQLException {
		try {
			Query query = null;
			query = getSessao().getNamedQuery("consultarOrdemData");
			query.setLong("idTitularIni", exemplo.getTitular().getIdPessoaIni());
			query.setLong("idLotaTitularIni", exemplo.getLotaTitular()
					.getIdLotacaoIni());
			// query.setCacheable(true);
			// query.setCacheRegion(CACHE_QUERY_SUBSTITUICAO);
			return query.list();
		} catch (final IllegalArgumentException e) {
			throw e;
		} catch (final Exception e) {
			return null;
		}
	}

	public CpIdentidade consultaIdentidadeCadastrante(final String nmUsuario,
			boolean fAtiva) throws AplicacaoException {
		List<CpIdentidade> lista = consultaIdentidadesCadastrante(nmUsuario,
				fAtiva);
		// obt�m preferencialmente identidade de formul�rio - �nico formato que
		// existia anteriormente
		for (CpIdentidade idLista : lista) {
			if (idLista.getCpTipoIdentidade().isTipoFormulario()) {
				return idLista;
			}
		}
		// se n�o encontrar, retorna o primeiro, como era antes.
		final CpIdentidade id = lista.get(0);
		return id;
	}

	@SuppressWarnings("unchecked")
	public List<CpIdentidade> consultaIdentidadesCadastrante(
			final String nmUsuario, boolean fAtiva) throws AplicacaoException {
		try {
			final Query qry = getSessao().getNamedQuery(
					fAtiva ? "consultarIdentidadeCadastranteAtiva"
							: "consultarIdentidadeCadastrante");
			qry.setString("nmUsuario", nmUsuario);
			// Verifica se existe numeros no login do usu�rio
			if (nmUsuario.substring(2).matches("^[0-9]*$"))
				qry.setString("sesbPessoa", nmUsuario.substring(0, 2));
			else
				qry.setString("sesbPessoa", "RJ"); // se n�o h� n�meros atribui
			// RJ
			// por default

			// Cache was disabled because it would interfere with the
			// "change password" action.
			qry.setCacheable(true);
			qry.setCacheRegion(CACHE_QUERY_SECONDS);
			final List<CpIdentidade> lista = (List<CpIdentidade>) qry.list();
			if (lista.size() == 0) {
				throw new AplicacaoException(
						"N�o foi poss�vel localizar a identidade do usu�rio '"
								+ nmUsuario + "'.");
			}
			return lista;
		} catch (Throwable e) {
			throw new AplicacaoException(
					"Ocorreu um erro tentando localizar a identidade do usu�rio '"
							+ nmUsuario + "'.", 0, e);
		}
	}

	@SuppressWarnings("unchecked")
	public List<CpIdentidade> consultaIdentidades(final DpPessoa pessoa) {
		final Query qry = getSessao().getNamedQuery("consultarIdentidades");
		qry.setLong("idPessoaIni", pessoa.getIdInicial());
		qry.setCacheable(false);
		final List<CpIdentidade> lista = qry.list();
		return lista;
	}

	/*
	 * @SuppressWarnings("unchecked") public Usuario
	 * consultaUsuarioCadastrante(final String nmUsuario) { try { final Query
	 * qry = getSessao().getNamedQuery( "consultarUsuarioCadastrante");
	 * qry.setString("nmUsuario", nmUsuario); // Verifica se existe numeros no
	 * login do usu�rio if (nmUsuario.substring(2).matches("^[0-9]*$"))
	 * qry.setString("sesbPessoa", nmUsuario.substring(0, 2)); else
	 * qry.setString("sesbPessoa", "RJ"); // se n�o h� n�meros atribui // RJ //
	 * por default
	 * 
	 * qry.setCacheable(true); qry.setCacheRegion("query.UsuarioCadastrante");
	 * final List<Object[]> lista = qry.list(); if (lista.size() == 0) { throw
	 * new AplicacaoException( "N�o foi poss�vel localizar o usu�rio '" +
	 * nmUsuario + "'."); } final Object[] par = lista.get(0); final Usuario usu
	 * = (Usuario) par[0]; final DpPessoa pess = (DpPessoa) par[1];
	 * usu.setPessoa(pess); return usu; } catch (Throwable e) { Auto-generated
	 * catch block e.printStackTrace(); return null; } }
	 * 
	 * public Usuario consultaUsuarioCadastranteAtivo(final String nmUsuario)
	 * throws Exception { // Nato: comentei porque estava muito dificil de
	 * debugar erros de banco // de dados quando as excecoes nao sao lancadas
	 * aqui. // try { final Query qry = getSessao().getNamedQuery(
	 * "consultarUsuarioCadastranteAtivo"); qry.setString("nmUsuario",
	 * nmUsuario); // Verifica se existe numeros no login do usu�rio if
	 * (nmUsuario.substring(2).matches("^[0-9]*$")) qry.setString("sesbPessoa",
	 * nmUsuario.substring(0, 2)); else qry.setString("sesbPessoa", "RJ"); // se
	 * n�o h� n�meros atribui // RJ // por default
	 * 
	 * qry.setCacheable(true);
	 * qry.setCacheRegion("query.UsuarioCadastranteAtivo"); final List<Object[]>
	 * lista = qry.list(); if (lista.size() == 0) { throw new
	 * AplicacaoException( "N�o foi poss�vel localizar o usu�rio '" + nmUsuario
	 * + "'."); } final Object[] par = lista.get(0); final Usuario usu =
	 * (Usuario) par[0]; final DpPessoa pess = (DpPessoa) par[1];
	 * usu.setPessoa(pess); return usu; // Nato: comentei porque estava muito
	 * dificil de debugar erros de banco // de dados quando as excecoes nao sao
	 * lancadas aqui. // } catch (Throwable e) { // block //
	 * e.printStackTrace(); // return null; // } }
	 */
	public List<DpPessoa> pessoasPorLotacao(Long id,
			Boolean incluirSublotacoes, Boolean somenteServidor,
			SituacaoFuncionalEnum situacoesFuncionais)
			throws AplicacaoException {
		if (id == null || id == 0)
			return null;

		DpLotacao lotacao = consultar(id, DpLotacao.class, false);

		List<DpLotacao> sublotacoes = new ArrayList<DpLotacao>();
		sublotacoes.add(lotacao);
		if (incluirSublotacoes) {
			List<DpLotacao> lotacoes = listarLotacoes();
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
		for (DpLotacao lot : sublotacoes) {

			Criteria c = HibernateUtil.getSessao().createCriteria(
					DpPessoa.class);
			c.createAlias("cargo", "c");

			c.add(Restrictions.eq("lotacao.id", lot.getId()));
			if (somenteServidor) {
				c.add(Restrictions.not(Restrictions.in("c.nomeCargo",
						new String[] { "ESTAGIARIO", "JUIZ SUBSTITUTO",
								"JUIZ FEDERAL" })));
			}

			c.add(Restrictions.in("situacaoFuncionalPessoa",
					situacoesFuncionais.getValor()));

			c.add(Restrictions.isNull("dataFimPessoa"));

			c.addOrder(Order.asc("nomePessoa"));

			lstCompleta.addAll((List<DpPessoa>) c.list());

		}
		return lstCompleta;
	}

	public List<DpPessoa> pessoasPorLotacao(Long id,
			Boolean incluirSublotacoes, Boolean somenteServidor) {
		return pessoasPorLotacao(id, incluirSublotacoes, somenteServidor,
				SituacaoFuncionalEnum.APENAS_ATIVOS);
	}

	public DpPessoa consultarPorCpfMatricula(final long cpf, long matricula) {

		final Query qry = getSessao().getNamedQuery("consultarPorCpfMatricula");
		qry.setLong("cpfPessoa", cpf);
		qry.setLong("matricula", matricula);
		final DpPessoa pes = (DpPessoa) qry.uniqueResult();
		return pes;
	}

	public Date consultarDataEHoraDoServidor() throws AplicacaoException {
		SQLQuery sql = (SQLQuery) getSessao().getNamedQuery(
				"consultarDataEHoraDoServidor");

		List result = sql.list();
		if (result.size() != 1)
			throw new AplicacaoException(
					"N�o foi poss�vel obter a data e a hora atuais do servidor.");

		return (Date) ((result.get(0)));
	}

	public Date consultarDataUltimaAtualizacao() throws AplicacaoException {
		Query sql = getSessaoStateless().getNamedQuery(
				"consultarDataUltimaAtualizacao");

		
		sql.setCacheable(false);
		List result = sql.list();
		if (result.size() != 1)
			throw new AplicacaoException(
					"N�o foi poss�vel obter a data e a hora de atualiza��o das configura��es.");

		Date dtIni = (Date) ((Object[]) (result.get(0)))[0];
		Date dtFim = (Date) ((Object[]) (result.get(0)))[1];
		return DateUtils.max(dtIni, dtFim);
	}

	public Date dt() throws AplicacaoException {
		return consultarDataEHoraDoServidor();
	}

	public List<CpConfiguracao> consultar(final CpConfiguracao exemplo) {
		Query query = getSessao().getNamedQuery("consultarCpConfiguracoes");

		query.setLong("idTpConfiguracao", exemplo.getCpTipoConfiguracao()
				.getIdTpConfiguracao());

		query.setCacheable(false);
		// query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
		return query.list();
	}

	public List<CpConfiguracao> consultarConfiguracoesPorTipo(final Long idTipoConfig) {
		Query query = getSessao().getNamedQuery("consultarCpConfiguracoesPorTipo");

		query.setLong("idTpConfiguracao", idTipoConfig);

		query.setCacheable(false);

		return query.list();

	}


	public List<CpConfiguracao> porLotacaoPessoaServicoTipo(
			final CpConfiguracao exemplo) {
		Query query = getSessao().getNamedQuery(
				"consultarCpConfiguracoesPorLotacaoPessoaServicoTipo");
		query.setLong("idPessoa", exemplo.getDpPessoa().getIdPessoa());
		query.setLong("idLotacao", exemplo.getLotacao().getIdLotacao());
		query.setLong("idTpConfiguracao", exemplo.getCpTipoConfiguracao()
				.getIdTpConfiguracao());
		query.setLong("idServico", exemplo.getCpServico().getIdServico());
		// kpf: com o cache true, as configura��es s�o exibidas de forma forma
		// errada ap�s a primeira
		query.setCacheable(false);
		// query.setCacheRegion(CACHE_QUERY_CONFIGURACAO);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> listarAtivos(Class<T> clazz, String dtFim,
			long orgaoUsuario) {
		// Criteria crit = getSessao().createCriteria(getPersistentClass());
		// return crit.list();
		// DetachedCriteria criteria = DetachedCriteria.forClass(clazz).add(
		// Property.forName(dtFim).isNull()).add(
		// Property.forName("orgaoUsuario.idOrgaoUsu").eq(orgaoUsuario));

		return findByCriteria(clazz, Property.forName(dtFim).isNull(), Property
				.forName("orgaoUsuario.idOrgaoUsu").eq(orgaoUsuario));
	}

	public <T> List<T> listarAtivos(Class<T> clazz, String orderBy) {
		Criteria c = getSessao().createCriteria(clazz);

		if (orderBy != null) {
			c.addOrder(Order.asc(orderBy));
		}

		c.add(Restrictions.eq("hisAtivo", 1));

		return c.list();

	}

	public <T> T consultarAtivoPorIdInicial(Class<T> clazz, Long hisIdIni) {
		Criteria c = getSessao().createCriteria(clazz);

		c.add(Restrictions.eq("hisIdIni", hisIdIni));
		c.add(Restrictions.eq("hisAtivo", 1));

		T obj = null;
		try {
			obj = (T) c.list().get(0);
		} catch (Exception e) {

		}

		return obj;
	}

	/**
	 * Importa logins e senhas do antigo esquema ACESSO_TOMCAT
	 * 
	 * @return
	 * @throws SQLException
	 * @throws NumberFormatException
	 * @throws SQLException
	 * @throws BadPaddingException
	 * @throws IllegalBlockSizeException
	 * @throws NoSuchPaddingException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws AplicacaoException
	 */
	public void importarAcessoTomcat() throws SQLException,
			InvalidKeyException, NoSuchAlgorithmException,
			NoSuchPaddingException, IllegalBlockSizeException,
			BadPaddingException, AplicacaoException {
		final Date dt = consultarDataEHoraDoServidor();
		String s = "SELECT * FROM ACESSO_TOMCAT.USUARIO";

		final Connection conn = getSessao().connection();
		final PreparedStatement ps = conn.prepareStatement(s);
		final String j = ps.toString();

		final ResultSet rset = ps.executeQuery();

		CpTipoIdentidade tid = consultar(1, CpTipoIdentidade.class, false);
		while (rset.next()) {
			final String login = (String) rset.getObject(1);
			final String senha = (String) rset.getObject(2);
			Long cpf;
			try {
				cpf = ((BigDecimal) rset.getObject(4)).longValue();
			} catch (NullPointerException e1) {
				System.out.println("CPF nulo:" + login);
				continue;
			}
			if (!Character.isDigit(login.charAt(2))) {
				System.out.println("Login sem matr�cula:" + login);
				continue;
			}
			final long longmatricula = Long.parseLong(login.substring(2));

			DpPessoa pessoa;
			try {
				pessoa = consultarPorCpfMatricula(cpf, longmatricula);
			} catch (org.hibernate.NonUniqueResultException e) {
				System.out.println("Mais de um registro retornado:" + login);
				continue;
			}
			if (pessoa == null) {
				System.out.println("Pessoa n�o localizada:" + login);
				continue;
			}

			CpIdentidade id = new CpIdentidade();
			id.setCpOrgaoUsuario(pessoa.getOrgaoUsuario());
			id.setCpTipoIdentidade(tid);
			id.setDpPessoa(pessoa);
			id.setDscSenhaIdentidade(senha);

			// BASE64Encoder encoderBase64 = new BASE64Encoder();
			// String chave =
			// encoderBase64.encode(id.getDpPessoa().getIdInicial()
			// .toString().getBytes());
			// String senhaCripto = encoderBase64.encode(Criptografia
			// .criptografar(senha, chave));
			// id.setDscSenhaIdentidadeCripto(senhaCripto);
			// id.setDscSenhaIdentidadeCriptoSinc(senhaCripto);

			id.setDtCancelamentoIdentidade(null);
			id.setDtCriacaoIdentidade(dt);
			id.setDtExpiracaoIdentidade(null);
			id.setHisDtFim(null);
			id.setHisDtIni(dt);
			// id.setIdCpIdentidade(null);
			id.setNmLoginIdentidade(login);
			gravar(id);
			id.setHisIdIni(id.getIdIdentidade());
			gravar(id);
		}
	}

	public HistoricoAuditavel gravarComHistorico(HistoricoAuditavel oNovo,
			HistoricoAuditavel oAntigo, Date dt,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {
		if (dt == null)
			dt = CpDao.getInstance().consultarDataEHoraDoServidor();
		oNovo.setHisDtIni(dt);
		if (oAntigo == null) {
			return gravarComHistorico(oNovo, identidadeCadastrante);
		}

		if (oNovo.semelhante(oAntigo, 0)) {
			return oAntigo;
		}

		oAntigo.setHisDtFim(dt);
		gravarComHistorico(oAntigo, identidadeCadastrante);
		return gravarComHistorico(oNovo, identidadeCadastrante);
	}

	public HistoricoAuditavel gravarComHistorico(
			final HistoricoAuditavel entidade,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {
		if (entidade.getHisDtIni() != null && entidade.getHisIdcIni() == null)
			entidade.setHisIdcIni(identidadeCadastrante);
		if (entidade.getHisDtFim() != null && entidade.getHisIdcFim() == null)
			entidade.setHisIdcFim(identidadeCadastrante);
		entidade.setHisAtivo(entidade.getHisDtFim() == null ? 1 : 0);
		getSessao().saveOrUpdate(entidade);
		if (entidade.getHisIdIni() == null && entidade.getId() != null) {
			entidade.setHisIdIni(entidade.getId());
			getSessao().update(entidade);
		}
		try {
			invalidarCache(entidade);
			Cp.getInstance().getConf().limparCacheSeNecessario();
		} catch (Exception e) {
			throw new AplicacaoException("N�o foi poss�vel limpar o cache.", 0,
					e);
		}
		return entidade;
	}

	public <T> T gravar(final T entidade) {
		getSessao().saveOrUpdate(entidade);
		invalidarCache(entidade);
		return entidade;
	}

	public void invalidarCache(Object entidade) {
		if (entidade == null)
			return;
		SessionFactory sfCpDao = CpDao.getInstance().getSessao()
				.getSessionFactory();
		if (entidade instanceof DpSubstituicao) {
			sfCpDao.evict(DpSubstituicao.class);
			sfCpDao.evictQueries(CACHE_QUERY_SUBSTITUICAO);
		}
	}

	static public AnnotationConfiguration criarHibernateCfg(String datasource)
			throws Exception {

		AnnotationConfiguration cfg = new AnnotationConfiguration();

		cfg.setProperty("hibernate.connection.datasource", datasource);
		configurarHibernate(cfg);

		return cfg;
	}

	static public AnnotationConfiguration criarHibernateCfg(
			String connectionUrl, String username, String password)
			throws Exception {
		AnnotationConfiguration cfg = new AnnotationConfiguration();
		cfg.setProperty("hibernate.connection.url", connectionUrl);
		cfg.setProperty("hibernate.connection.username", username);
		cfg.setProperty("hibernate.connection.password", password);
		cfg.setProperty("hibernate.connection.driver_class",
				"oracle.jdbc.driver.OracleDriver");
		cfg.setProperty("c3p0.min_size", "5");
		cfg.setProperty("c3p0.max_size", "20");
		cfg.setProperty("c3p0.timeout", "300");
		cfg.setProperty("c3p0.max_statements", "50");
		configurarHibernate(cfg);
		return cfg;
	}
	
	static public AnnotationConfiguration criarHibernateCfg(
			CpAmbienteEnumBL ambiente) throws Exception {
		CpPropriedadeBL prop = Cp.getInstance().getProp();
		prop.setPrefixo(ambiente.getSigla());
		return criarHibernateCfg(ambiente, prop);
	}

	static public AnnotationConfiguration criarHibernateCfg(
			CpAmbienteEnumBL ambiente, CpPropriedadeBL prop) throws Exception {
		
		AnnotationConfiguration cfg = new AnnotationConfiguration();

		// Isto � para manter o naming strategy do hibernate 3.5 na vers�o 3.6
		cfg.setNamingStrategy(DefaultNamingStrategy.INSTANCE);
		cfg.setProperty("hibernate.connection.url", prop.urlConexao());
		cfg.setProperty("hibernate.connection.username",
				prop.usuario());
		cfg.setProperty("hibernate.connection.password",
				prop.senha());
		cfg.setProperty("hibernate.connection.driver_class",
				prop.driverConexao());
		cfg.setProperty("c3p0.min_size", prop.c3poMinSize());
		cfg.setProperty("c3p0.max_size", prop.c3poMaxSize());
		cfg.setProperty("c3p0.timeout", prop.c3poTimeout());
		cfg.setProperty("c3p0.max_statements", prop.c3poMaxStatements());

		cfg.setProperty("hibernate.jdbc.use_streams_for_binary", "true");

		configurarHibernate(cfg);
		return cfg;
	}

	static private void configurarHibernate(AnnotationConfiguration cfg)
			throws Exception {
		cfg.setProperty("hibernate.dialect",
				"org.hibernate.dialect.Oracle10gDialect");

		cfg.setProperty("hibernate.transaction.factory_class",
				"org.hibernate.transaction.JDBCTransactionFactory");
		cfg.setProperty("hibernate.current_session_context_class", "thread");
		cfg.setProperty("hibernate.query.substitutions", "true 1, false 0");

		// Alterado para compatibilizar com hibernate 3.61
		cfg.setProperty("hibernate.cache.provider_class",
				"org.hibernate.cache.SingletonEhCacheProvider");
		// cfg.setProperty("hibernate.cache.region.factory_class",
		// "net.sf.ehcache.hibernate.EhCacheRegionFactory");
		// "net.sf.ehcache.hibernate.SingletonEhCacheRegionFactory");

		cfg.setProperty("hibernate.cache.use_second_level_cache", "true");
		cfg.setProperty("hibernate.cache.use_query_cache", "true");
		cfg.setProperty("hibernate.cache.use_minimal_puts", "false");
		cfg.setProperty("hibernate.max_fetch_depth", "3");
		cfg.setProperty("hibernate.default_batch_fetch_size", "1000");
		// cfg.setProperty("hibernate.cache.provider_configuration_file_resource_path","classpath:ehcache.xml");

		// descomentar para inpecionar o SQL
		// cfg.setProperty("hibernate.show_sql", "true");
		// cfg.setProperty("hibernate.format_sql", "true");
		// cfg.setProperty("hibernate.use_sql_comments", "true");
		// Disable second-level cache.
		// <property
		// name="cache.provider_class">org.hibernate.cache.NoCacheProvider</property>
		// <property name="cache.use_query_cache">false</property>

		cfg.addClass(br.gov.jfrj.siga.dp.DpCargo.class);
		cfg.addClass(br.gov.jfrj.siga.dp.DpFuncaoConfianca.class);
		cfg.addClass(br.gov.jfrj.siga.dp.DpLotacao.class);
		cfg.addClass(br.gov.jfrj.siga.dp.DpPessoa.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpOrgao.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpOrgaoUsuario.class);
		cfg.addClass(br.gov.jfrj.siga.dp.DpSubstituicao.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpFeriado.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpOcorrenciaFeriado.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpAplicacaoFeriado.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpLocalidade.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpUF.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpPersonalizacao.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpTipoPessoa.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpConfiguracao.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpSituacaoConfiguracao.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpTipoConfiguracao.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpServico.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpTipoGrupo.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpGrupo.class);
		cfg.addClass(br.gov.jfrj.siga.dp.CpTipoLotacao.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpTipoPapel.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpPapel.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpTipoServico.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpTipoIdentidade.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpIdentidade.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpModelo.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpUnidadeMedida.class);
		cfg.addClass(br.gov.jfrj.siga.cp.CpComplexo.class);

		// <!--
		// <mapping resource="br/gov/jfrj/siga/dp/CpTipoMarcador.hbm.xml" />
		// <mapping resource="br/gov/jfrj/siga/dp/CpMarcador.hbm.xml" />
		// <mapping resource="br/gov/jfrj/siga/dp/CpTipoMarca.hbm.xml" />
		// <mapping resource="br/gov/jfrj/siga/dp/CpMarca.hbm.xml" />
		// -->

		CacheManager manager = CacheManager.getInstance();
		Cache cache;
		CacheConfiguration config;

		if (!manager.cacheExists(CACHE_QUERY_HOURS)) {
			manager.addCache(CACHE_QUERY_HOURS);
			cache = manager.getCache(CACHE_QUERY_HOURS);
			config = cache.getCacheConfiguration();
			config.setTimeToIdleSeconds(3600);
			config.setTimeToLiveSeconds(36000);
			config.setEternal(false);
			config.setMaxElementsInMemory(10000);
			config.setOverflowToDisk(false);
			config.setMaxElementsOnDisk(0);
		}

		if (!manager.cacheExists(CACHE_QUERY_SECONDS)) {
			manager.addCache(CACHE_QUERY_SECONDS);
			cache = manager.getCache(CACHE_QUERY_SECONDS);
			config = cache.getCacheConfiguration();
			config.setTimeToIdleSeconds(5);
			config.setTimeToLiveSeconds(5);
			config.setEternal(false);
			config.setMaxElementsInMemory(10000);
			config.setOverflowToDisk(false);
			config.setMaxElementsOnDisk(0);
		}

		if (!manager.cacheExists(CACHE_QUERY_SUBSTITUICAO)) {
			manager.addCache(CACHE_QUERY_SUBSTITUICAO);
			cache = manager.getCache(CACHE_QUERY_SUBSTITUICAO);
			config = cache.getCacheConfiguration();
			config.setTimeToIdleSeconds(300);
			config.setTimeToLiveSeconds(3600);
			config.setEternal(false);
			config.setMaxElementsInMemory(10000);
			config.setOverflowToDisk(false);
			config.setMaxElementsOnDisk(0);
		}

		if (!manager.cacheExists(CACHE_SECONDS)) {
			manager.addCache(CACHE_SECONDS);
			cache = manager.getCache(CACHE_SECONDS);
			config = cache.getCacheConfiguration();
			config.setTimeToIdleSeconds(5);
			config.setTimeToLiveSeconds(5);
			config.setEternal(false);
			config.setMaxElementsInMemory(10000);
			config.setOverflowToDisk(false);
			config.setMaxElementsOnDisk(0);
		}

		if (!manager.cacheExists(CACHE_CORPORATIVO)) {
			manager.addCache(CACHE_CORPORATIVO);
			cache = manager.getCache(CACHE_CORPORATIVO);
			config = cache.getCacheConfiguration();
			config.setEternal(true);
			config.setMaxElementsInMemory(10000);
			config.setOverflowToDisk(false);
			config.setMaxElementsOnDisk(0);
		}

		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpTipoLotacao",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.DpLotacao",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpTipoPessoa",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.DpPessoa",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy(
				"br.gov.jfrj.siga.dp.DpFuncaoConfianca",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpOrgaoUsuario",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.DpCargo",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpOrgao",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpLocalidade",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpUF",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.CpFeriado",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpTipoServico",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpServico",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy(
				"br.gov.jfrj.siga.cp.CpTipoConfiguracao",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpTipoIdentidade",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpTipoPapel",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpTipoGrupo",
				"nonstrict-read-write", CACHE_CORPORATIVO);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpIdentidade",
				"nonstrict-read-write", CACHE_SECONDS);
		cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.dp.DpSubstituicao",
				"nonstrict-read-write", CACHE_QUERY_SUBSTITUICAO);

		// Desabilitado pois o hibernate n�o permite cache de blobs.
		// cfg.setCacheConcurrencyStrategy("br.gov.jfrj.siga.cp.CpModelo",
		// "nonstrict-read-write", CACHE_SECONDS);
	}

	public DpPessoa getPessoaFromSigla(String sigla) {
		DpPessoa p = new DpPessoa();
		p.setSigla(sigla);
		DpPessoa ator = consultarPorSigla(p);
		return ator;
	}

	public DpLotacao getLotacaoFromSigla(String sigla) {
		DpLotacaoDaoFiltro flt = new DpLotacaoDaoFiltro();
		flt.setSiglaCompleta(sigla);
		return (DpLotacao) consultarPorSigla(flt);
	}

	public CpOrgao getOrgaoFromSigla(String sigla) {
		CpOrgao o = new CpOrgao();
		o.setSigla(sigla);
		return consultarPorSigla(o);
	}
	
	public CpOrgao getOrgaoFromSiglaExata(String sigla) {
		CpOrgao o = new CpOrgao();
		o.setSigla(sigla);
		
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaExataCpOrgao");
		query.setString("siglaOrgao", o.getSiglaOrgao());

		final List<CpOrgao> l = query.list();
		if (l.size() > 0)
			return l.get(0);
		
		return null;
	}
	
	public List<CpOrgaoUsuario> consultaCpOrgaoUsuario() {
		final Query qry = getSessao().getNamedQuery("consultarCpOrgaoUsuario");

		// Renato: Alterei para fazer cache. N�o vejo porque n�o possamos fazer
		// cache dessa consulta.
		qry.setCacheable(true);
		qry.setCacheRegion(CACHE_QUERY_HOURS);

		final List<CpOrgaoUsuario> lista = qry.list();
		return lista;
	}

	public List<CpModelo> consultaCpModelos() {
		final List<CpOrgaoUsuario> listaOrgUsu = consultaCpOrgaoUsuario();
		listaOrgUsu.add(0, null);
		final Query qry = getSessao().getNamedQuery("consultarCpModelos");

		qry.setCacheable(true);
		qry.setCacheRegion(CACHE_QUERY_SECONDS);

		final List<CpModelo> lista = qry.list();
		final List<CpModelo> listaFinal = new ArrayList<CpModelo>();

		for (CpOrgaoUsuario orgUsu : listaOrgUsu) {
			boolean fFound = false;
			for (CpModelo mod : lista) {
				if ((mod.getCpOrgaoUsuario() == null && orgUsu == null)
						|| (mod.getCpOrgaoUsuario() != null && orgUsu != null && mod
								.getCpOrgaoUsuario().getId()
								.equals(orgUsu.getId()))) {
					listaFinal.add(mod);
					fFound = true;
				}
			}
			if (!fFound) {
				CpModelo modNew = new CpModelo();
				modNew.setCpOrgaoUsuario(orgUsu);
				listaFinal.add(modNew);
			}
		}
		return listaFinal;
	}

	public List<CpModelo> listarModelosOrdenarPorNome(String script)
			throws Exception {
		final Criteria crit = getSessao().createCriteria(CpModelo.class);
		crit.add(Property.forName("hisDtFim").isNull());
		crit.createAlias("cpOrgaoUsuario", "o", Criteria.LEFT_JOIN);
		crit.addOrder(Order.desc("o.siglaOrgaoUsu"));
		List<CpModelo> l = new ArrayList<CpModelo>();
		for (CpModelo mod : (List<CpModelo>) crit.list())
			if (script != null && script.trim().length() != 0) {
				if (mod.getConteudoBlobString() != null
						&& mod.getConteudoBlobString().contains(script))
					l.add(mod);
			} else
				l.add(mod);
		return l;
	}

	public CpServico consultarPorSiglaCpServico(String siglaServico) {
		final Query query = getSessao().getNamedQuery(
				"consultarPorSiglaStringCpServico");
		query.setString("siglaServico", siglaServico);
		// query.setFlushMode(FlushMode.MANUAL);
		final List<CpServico> l = query.list();
		if (l.size() != 1) {
			return null;
		}

		return l.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<CpOrgaoUsuario> listarOrgaosUsuarios() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpOrgaoUsuario.class);
	}
	
	@SuppressWarnings("unchecked")
	public List<CpOrgao> listarOrgaos() {
		return findByCriteria(CpOrgao.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpServico> listarServicos() {
		return findByCriteria(CpServico.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpTipoGrupo> listarTiposGrupo() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpTipoGrupo.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpConfiguracao> listarConfiguracoes() {
		return findByCriteria(CpConfiguracao.class);
	}

	@SuppressWarnings("unchecked")
	public List<DpLotacao> listarLotacoes() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, DpLotacao.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpTipoLotacao> listarTiposLotacao() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpTipoLotacao.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpTipoPessoa> listarTiposPessoa() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpTipoPessoa.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpTipoPapel> listarTiposPapel() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpTipoPapel.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpFeriado> listarFeriados() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpFeriado.class);
	}

	@SuppressWarnings("unchecked")
	public List<CpSituacaoConfiguracao> listarSituacoesConfiguracao() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS,
				CpSituacaoConfiguracao.class);
	}

	public List<CpTipoConfiguracao> listarTiposConfiguracao() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS,
				CpTipoConfiguracao.class);
	}

	public List<CpUnidadeMedida> listarUnidadesMedida() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpUnidadeMedida.class);
	}

	public List<CpMarcador> listarMarcadores() {
		return findAndCacheByCriteria(CACHE_QUERY_HOURS, CpMarcador.class);
	}

	public List<CpGrupoDeEmail> listarGruposDeEmail() {
		return findByCriteria(CpGrupoDeEmail.class);
	}

	public void excluirComHistorico(HistoricoAuditavel entidade, Date dt,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {

		if (dt == null) {
			dt = consultarDataEHoraDoServidor();
		}
		entidade.setHisDtFim(dt);
		entidade.setHisIdcFim(identidadeCadastrante);
		entidade.setHisAtivo(0);

		gravarComHistorico(entidade, identidadeCadastrante);

	}

	public List<CpGrupo> getGruposGeridos(DpPessoa titular,
			DpLotacao lotaTitular, Long idCpTipoGrupo) throws Exception {
		CpGrupoDaoFiltro flt = new CpGrupoDaoFiltro();
		flt.setIdTpGrupo(idCpTipoGrupo.intValue());
		List<CpGrupo> itgGrupos = consultarPorFiltro(flt, 0, 0);

		Iterator<CpGrupo> it = itgGrupos.iterator();

		while (it.hasNext()) {
			CpGrupo cpGrp = it.next();
			CpConfiguracaoBL bl = Cp.getInstance().getConf();
			if (!bl.podePorConfiguracao(titular, lotaTitular, cpGrp,
					CpTipoConfiguracao.TIPO_CONFIG_GERENCIAR_GRUPO)) {
				it.remove();
			}

		}
		return itgGrupos;
	}

	@SuppressWarnings("unchecked")
	public Object consultaDadosBasicos(final String nmUsuario)
			throws AplicacaoException {
		try {
			final Query qry = getSessao()
					.getNamedQuery("consultarDadosBasicos");
			qry.setString("nmUsuario", nmUsuario);
			// Verifica se existe numeros no login do usu�rio
			if (nmUsuario.substring(2).matches("^[0-9]*$"))
				qry.setString("sesbPessoa", nmUsuario.substring(0, 2));
			else
				// se n�o h� n�meros atribui RJ por default
				qry.setString("sesbPessoa", "RJ");

			// Cache was disabled because it would interfere with the
			// "change password" action.
			// qry.setCacheable(true);
			// qry.setCacheRegion("query.IdentidadeCadastrante");

			final Object obj = qry.list();
			return obj;
		} catch (Throwable e) {
			throw new AplicacaoException(
					"Ocorreu um erro tentando carregar os dados b�sicos para o usu�rio '"
							+ nmUsuario + "'.", 0, e);
		}
	}

	public List<DpPessoa> consultarPorMatriculaEOrgao(Long matricula,
			Long idOrgaoUsu, boolean pessoasFinalizadas, boolean ordemDesc) {
		Criteria c = HibernateUtil.getSessao().createCriteria(DpPessoa.class);
		c.add(Restrictions.eq("matricula", matricula));
		c.add(Restrictions.eq("orgaoUsuario.idOrgaoUsu", idOrgaoUsu));

		if (pessoasFinalizadas) {
			c.add(Restrictions.isNotNull("dataFimPessoa"));
		} else {
			c.add(Restrictions.isNull("dataFimPessoa"));
		}
		if (ordemDesc) {
			c.addOrder(Order.desc("dataInicioPessoa"));
		} else {
			c.addOrder(Order.asc("dataInicioPessoa"));
		}

		return c.list();

	}

	public List<?> consultarFechadosPorIdExterna(Class<?> clazz,
			String idExterna, Long idOrgaoUsu) {
		if (clazz == DpLotacao.class) {
			Criteria c = HibernateUtil.getSessao().createCriteria(
					DpLotacao.class);
			c.add(Restrictions.eq("ideLotacao", idExterna));
			c.add(Restrictions.eq("orgaoUsuario.idOrgaoUsu", idOrgaoUsu));
			c.add(Restrictions.isNotNull("dataFimLotacao"));
			c.addOrder(Order.desc("dataInicioLotacao"));
			return c.list();
		}

		if (clazz == DpCargo.class) {
			Criteria c = HibernateUtil.getSessao()
					.createCriteria(DpCargo.class);
			c.add(Restrictions.eq("ideCargo", idExterna));
			c.add(Restrictions.eq("orgaoUsuario.idOrgaoUsu", idOrgaoUsu));
			c.add(Restrictions.isNotNull("dataFimCargo"));
			c.addOrder(Order.desc("dataInicioCargo"));
			return c.list();
		}

		if (clazz == DpFuncaoConfianca.class) {
			Criteria c = HibernateUtil.getSessao().createCriteria(
					DpFuncaoConfianca.class);
			c.add(Restrictions.eq("ideFuncao", idExterna));
			c.add(Restrictions.eq("orgaoUsuario.idOrgaoUsu", idOrgaoUsu));
			c.add(Restrictions.isNotNull("dataFimFuncao"));
			c.addOrder(Order.desc("dataInicioFuncao"));
			return c.list();
		}

		return null;
	}

	public List<CpConfiguracao> consultarConfiguracoesDesde(
			Date desde) {
		Criteria c = HibernateUtil.getSessao().createCriteria(CpConfiguracao.class);
		LogicalExpression confsAtivas = Restrictions.and(Restrictions.ge("hisDtIni", desde),Restrictions.isNull("hisDtFim"));
		LogicalExpression confsInativas = Restrictions.and(Restrictions.ge("hisDtFim", desde),Restrictions.isNotNull("hisDtFim"));
		c.add(Restrictions.or(confsAtivas,confsInativas));
		return c.list();
	}

}
