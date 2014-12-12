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
 * Criado em  13/09/2005
 *
 * To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.siga.libs.webwork;

import java.util.List;

import com.opensymphony.xwork.Action;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.dp.CpOrgao;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.dp.dao.CpOrgaoDaoFiltro;
import br.gov.jfrj.siga.model.Selecionavel;

public class CpOrgaoAction extends SigaSelecionavelActionSupport<CpOrgao, CpOrgaoDaoFiltro> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1098577621835510117L;	
	
	private Long id;
	private String nmOrgao;
	private String siglaOrgao;
	private char ativo;
	private Long idOrgaoUsu;
	
	
	public char getAtivo() {
		return ativo;
	}

	public void setAtivo(char ativo) {
		this.ativo = ativo;
	}

	public String getNmOrgao() {
		return nmOrgao;
	}

	public void setNmOrgao(String nmOrgao) {
		this.nmOrgao = nmOrgao;
	}

	public String getSiglaOrgao() {
		return siglaOrgao;
	}

	public void setSiglaOrgao(String siglaOrgao) {
		this.siglaOrgao = siglaOrgao;
	}

	public Long getIdOrgaoUsu() {
		return idOrgaoUsu;
	}

	public Long getId() {
		return id;
	}

	public void setIdOrgaoUsu(Long idOrgaoUsu) {
		this.idOrgaoUsu = idOrgaoUsu;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public CpOrgao daoOrgao(long id) {
		return dao().consultar(id, CpOrgao.class, false);
	}

	@Override
	public CpOrgaoDaoFiltro createDaoFiltro() {
		final CpOrgaoDaoFiltro flt = new CpOrgaoDaoFiltro();
		flt.setNome(Texto.removeAcentoMaiusculas(getNome()));
		return flt;
	}
	
	@Override
	public Selecionavel selecionarPorNome(final CpOrgaoDaoFiltro flt) throws AplicacaoException {
		
		// Procura por nome
		flt.setNome(Texto.removeAcentoMaiusculas(flt.getSigla()));
		flt.setSigla(null);
		final List l = CpDao.getInstance().consultarPorFiltro(flt);
		if (l != null)
			if (l.size() == 1)
				return (CpOrgao) l.get(0);
		return null;
	}
	
	public String aListar() throws Exception {
		
		setItens(CpDao.getInstance().consultarCpOrgaoOrdenadoPorNome());
		
		return Action.SUCCESS;
	}
	
	public String aExcluir() throws Exception {
		assertAcesso("FE:Ferramentas;CAD_ORGAO: Cadastrar Org�os");
		if (getId() != null) {
			try {
				dao().iniciarTransacao();
				CpOrgao orgao = daoOrgao(getId());				
				dao().excluir(orgao);				
				dao().commitTransacao();				
			} catch (final Exception e) {
				dao().rollbackTransacao();
				throw new AplicacaoException("Erro na exclus�o de Org�o", 0, e);
			}
		} else
			throw new AplicacaoException("ID n�o informada");

		return Action.SUCCESS;
	}
	
	public String aEditar() throws Exception {

		if (getId() != null) {
			CpOrgao orgao = daoOrgao(getId());	
			this.setNmOrgao(orgao.getNmOrgao());
			this.setSiglaOrgao(orgao.getSigla());
			if (orgao.getAtivo() != null && !orgao.getAtivo().isEmpty())
				this.setAtivo(orgao.getAtivo().charAt(0));
			else
				this.setAtivo('N');
			this.setIdOrgaoUsu(orgao.getOrgaoUsuario().getId());
		}
		
		return Action.SUCCESS;
	}
	
	public String aEditarGravar() throws Exception {
		assertAcesso("FE:Ferramentas;CAD_ORGAO: Cadastrar Org�os");
		
		if(this.getNmOrgao() == null)
			throw new AplicacaoException("Nome do �rg�o Externo n�o informado");
		
		if(this.getSiglaOrgao() == null)
			throw new AplicacaoException("Sigla do �rg�o Externo n�o informada");
		
		CpOrgao orgao;		
		if (getId() == null)
			orgao = new CpOrgao();
		else
			orgao = daoOrgao(getId());	
		
		orgao.setNmOrgao(this.getNmOrgao());
		orgao.setSigla(this.getSiglaOrgao());
		if (this.getIdOrgaoUsu() != null && this.getIdOrgaoUsu() != 0) {
			CpOrgaoUsuario orgaoUsuario = new CpOrgaoUsuario();
			orgaoUsuario = dao().consultar(this.getIdOrgaoUsu(), CpOrgaoUsuario.class, false);	
			orgao.setOrgaoUsuario(orgaoUsuario);
		}else
			orgao.setOrgaoUsuario(null);
		
		orgao.setAtivo(String.valueOf(this.getAtivo()));
		
		try {
			dao().iniciarTransacao();
			dao().gravar(orgao);
			dao().commitTransacao();			
		} catch (final Exception e) {
			dao().rollbackTransacao();
			throw new AplicacaoException("Erro na grava��o", 0, e);
		}
		
		return Action.SUCCESS;
	}
}
