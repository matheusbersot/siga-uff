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
package br.gov.jfrj.siga.acesso;

import java.util.Date;
import java.util.SortedSet;
import java.util.TreeSet;

import org.hibernate.proxy.HibernateProxy;

import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;

/**
 * Uma configura��o de acesso � a representa��o de uma configura��o
 * (CpConfiguracao) com o objetivo espec�fico de controlar o acesso a
 * determinado servi�o. A entidade que est� sendo configurada pode ser um �rg�o
 * usu�rio, uma lota��o, uma pessoa, uma identidade ou um perfil.
 */
@SuppressWarnings("unchecked")
public class ConfiguracaoAcesso implements Comparable {
	private boolean defaultConfiguration;
	private DpLotacao lotacao;
	private CpOrgaoUsuario orgao;
	private CpPerfil perfil;
	private DpPessoa pessoa;
	private CpServico servico;
	private CpSituacaoConfiguracao situacao;
	private Date inicio;
	private DpPessoa cadastrante;
	private SortedSet<ConfiguracaoAcesso> subitens = new TreeSet<ConfiguracaoAcesso>();

	public int compareTo(Object o) {
		CpServico srv = ((ConfiguracaoAcesso) o).getServico();
		int i = getServico().getDscServico().compareTo(srv.getDscServico());
		if (i != 0)
			return i;
		return getServico().getIdServico().compareTo(srv.getIdServico());
	}

	static public ConfiguracaoAcesso gerar(CpPerfil perfil, DpPessoa pessoa,
			DpLotacao lotacao, CpOrgaoUsuario orgao, CpServico servico,
			Date dtEvn) throws Exception {
		CpConfiguracao cfgFiltro = new CpConfiguracao();
		cfgFiltro.setCpGrupo(perfil);
		cfgFiltro.setDpPessoa(pessoa);
		cfgFiltro.setLotacao(lotacao);
		cfgFiltro.setOrgaoUsuario(orgao);
		cfgFiltro.setCpServico(servico);
		CpTipoConfiguracao tipo = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO,
				CpTipoConfiguracao.class, false);
		cfgFiltro.setCpTipoConfiguracao(tipo);
		CpConfiguracao cfg = Cp.getInstance().getConf().buscaConfiguracao(
				cfgFiltro, new int[0], dtEvn);
		ConfiguracaoAcesso ac = new ConfiguracaoAcesso();
		if (cfg == null) {
			ac.setSituacao(tipo.getSituacaoDefault());
			ac.setDefault(true);
		} else {
			ac.setSituacao(cfg.getCpSituacaoConfiguracao());
			ac.setDefault(!cfg.isEspecifica(cfgFiltro));
			if (cfg.getCpGrupo() != null) {
				Object g = cfg.getCpGrupo();
				if (g instanceof HibernateProxy) {
					g = ((HibernateProxy) g).getHibernateLazyInitializer()
							.getImplementation();
				}
				if (g instanceof CpPerfil)
					ac.setPerfil((CpPerfil) g);
			}
			ac.setPessoa(cfg.getDpPessoa());
			ac.setLotacao(cfg.getLotacao());
			ac.setOrgao(cfg.getOrgaoUsuario());
			ac.setInicio(cfg.getHisDtIni());
			if (cfg.getHisIdcIni() == null) {
				ac.setCadastrante(null);
			} else {
				ac.setCadastrante(cfg.getHisIdcIni().getDpPessoa());
			}
		}
		ac.setServico(servico);
		return ac;
	}

	public DpLotacao getLotacao() {
		return lotacao;
	}

	public CpOrgaoUsuario getOrgao() {
		return orgao;
	}

	public CpPerfil getPerfil() {
		return perfil;
	}

	public DpPessoa getPessoa() {
		return pessoa;
	}

	public CpServico getServico() {
		return servico;
	}

	public CpSituacaoConfiguracao getSituacao() {
		return situacao;
	}

	public SortedSet<ConfiguracaoAcesso> getSubitens() {
		return subitens;
	}

	public boolean isDefault() {
		return defaultConfiguration;
	}

	public void setDefault(boolean defaultConfiguration) {
		this.defaultConfiguration = defaultConfiguration;
	}

	public void setLotacao(DpLotacao lotacao) {
		this.lotacao = lotacao;
	}

	public void setOrgao(CpOrgaoUsuario orgao) {
		this.orgao = orgao;
	}

	public void setPerfil(CpPerfil perfil) {
		this.perfil = perfil;
	}

	public void setPessoa(DpPessoa pessoa) {
		this.pessoa = pessoa;
	}

	public void setServico(CpServico servico) {
		this.servico = servico;
	}

	public void setSituacao(CpSituacaoConfiguracao situacao) {
		this.situacao = situacao;
	}

	public void setSubitens(SortedSet<ConfiguracaoAcesso> subitens) {
		this.subitens = subitens;
	}

	/**
	 * @return the inicio
	 */
	public Date getInicio() {
		return inicio;
	}

	/**
	 * @param inicio
	 *            the inicio to set
	 */
	public void setInicio(Date inicio) {
		this.inicio = inicio;
	}

	/**
	 * @return the cadastrante
	 */
	public DpPessoa getCadastrante() {
		return cadastrante;
	}

	/**
	 * @param cadastrante
	 *            the cadastrante to set
	 */
	public void setCadastrante(DpPessoa cadastrante) {
		this.cadastrante = cadastrante;
	}

	/**
	 * 
	 * @return retorna o objeto que � a origem da configura��o
	 */
	public Object getOrigem() {
		if (getPessoa() != null) {
			return getPessoa();
		} else if (getLotacao() != null) {
			return getLotacao();
		} else if (getPerfil() != null) {
			return getPerfil();
		} else if (getOrgao() != null) {
			return getOrgao();
		} else {
			return null;
		}
	}

	/**
	 * 
	 * @return retorna uma string representativa da origem para exibi��es curtas
	 */
	public String printOrigemCurta() {
		Object ori = getOrigem();
		if (ori instanceof DpPessoa) {
			DpPessoa pes = (DpPessoa) ori;
			return (pes.getSesbPessoa() + pes.getMatricula());
		} else if (ori instanceof DpLotacao) {
			return ((DpLotacao) ori).getSigla();
		} else if (ori instanceof CpPerfil) {
			return ((CpPerfil) ori).getDescricao();
		} else if (ori instanceof CpOrgaoUsuario) {
			return ((CpOrgaoUsuario) ori).getSiglaOrgaoUsu();
		} else {
			return new String();
		}
	}

	/**
	 * 
	 * @return retorna uma String representativa da origem
	 */
	public String printOrigem() {
		Object ori = getOrigem();
		if (ori instanceof DpPessoa) {
			return ((DpPessoa) ori).getNomePessoa();
		} else if (ori instanceof DpLotacao) {
			return ((DpLotacao) ori).getNomeLotacao();
		} else if (ori instanceof CpPerfil) {
			return ((CpPerfil) ori).getDescricao();
		} else if (ori instanceof CpOrgaoUsuario) {
			return ((CpOrgaoUsuario) ori).getNmOrgaoUsu();
		} else {
			return new String();
		}
	}

}
