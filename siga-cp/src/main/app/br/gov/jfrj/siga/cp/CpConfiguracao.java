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
 * Criado em  12/12/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.siga.cp;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.model.Assemelhavel;
import br.gov.jfrj.siga.sinc.lib.SincronizavelSuporte;

@Entity
@Table(name = "CP_CONFIGURACAO", schema = "CORPORATIVO")
@Inheritance(strategy = InheritanceType.JOINED)
@NamedQueries({
		@NamedQuery(name = "consultarDataUltimaAtualizacao", query = ""
				+ "select max(cpcfg.hisDtIni), max(cpcfg.hisDtFim) "
				+ "from CpConfiguracao cpcfg"),
		@NamedQuery(name = "consultarCpConfiguracoes", query = "from "
				+ "CpConfiguracao cpcfg where (:idTpConfiguracao is null or "
				+ "cpcfg.cpTipoConfiguracao.idTpConfiguracao = :idTpConfiguracao)"),
		@NamedQuery(name = "consultarCpConfiguracoesPorTipo", query = " from "
				+ "CpConfiguracao cpcfg where (cpcfg.cpTipoConfiguracao.idTpConfiguracao = :idTpConfiguracao)"
				+ "and hisDtFim is null")

})
public class CpConfiguracao extends AbstractCpConfiguracao {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3624557793773660738L;

	public CpConfiguracao() {
	}

	public boolean isEspecifica(CpConfiguracao filtro) {
		if (filtro.getDpPessoa() != null)
			return getDpPessoa() != null;
		if (filtro.getLotacao() != null)
			return getLotacao() != null;
		if (filtro.getOrgaoUsuario() != null)
			return getOrgaoUsuario() != null;
		if (filtro.getCpGrupo() != null)
			return getCpGrupo() != null
					&& getCpGrupo().getId().equals(filtro.getCpGrupo().getId());
		return false;
	}

	public Long getId() {
		return getIdConfiguracao();
	}

	public void setId(Long id) {
		setIdConfiguracao(id);
	}

	public boolean semelhante(Assemelhavel obj, int nivel) {
		return SincronizavelSuporte.semelhante(this, obj, nivel);
	}

	/**
	 * 
	 * @return retorna o objeto que � a origem da configura��o
	 */
	public Object getOrigem() {
		if (getDpPessoa() != null) {
			return getDpPessoa();
		} else if (getLotacao() != null) {
			return getLotacao();
		} else if (getCpGrupo() != null) {
			return getCpGrupo();
		} else if (getOrgaoUsuario() != null) {
			return getOrgaoUsuario();
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
			return ((DpLotacao) ori).getSiglaLotacao();
		} else if (ori instanceof CpGrupo) {
			return ((CpGrupo) ori).getSiglaGrupo();
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
		} else if (ori instanceof CpGrupo) {
			return ((CpGrupo) ori).getDescricao();
		} else if (ori instanceof CpOrgaoUsuario) {
			return ((CpOrgaoUsuario) ori).getNmOrgaoUsu();
		} else {
			return new String();
		}
	}

	public boolean ativaNaData(Date dt) {
		return super.ativoNaData(dt);
	}

	/**
	 * Retorna a data de fim de vig�ncia no formato dd/mm/aa HH:MM:SS, por
	 * exemplo, 01/02/10 17:52:23.
	 */
	public String getHisDtFimDDMMYY_HHMMSS() {
		if (getHisDtFim() != null) {
			final SimpleDateFormat df = new SimpleDateFormat(
					"dd/MM/yy HH:mm:ss");
			return df.format(getHisDtFim());
		}
		return "";
	}

	public String getHisDtIniDDMMYY() {
		if (getHisDtIni() != null) {
			final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yy");
			return df.format(getHisDtIni());
		}
		return "";
	}
	
	/**
	 * Retorna a configura��o atual no hist�rico desta configura��o
	 * 
	 * @return CpConfiguracao
	 */
	public CpConfiguracao getConfiguracaoAtual() {
		CpConfiguracao ini = getConfiguracaoInicial();
		Set<CpConfiguracao> setConfs = ini.getConfiguracoesPosteriores();
		if (setConfs != null)
			for (CpConfiguracao l : setConfs)
				return l;

		return this;
	}
	
	@Override
	public String toString() {
		return  "id: " + getId()
				+ " ,pessoa: " + (getDpPessoa()!=null?getDpPessoa().getNomePessoa():"")
				+ " ,lotacao: " + (getLotacao()!=null?getLotacao().getSigla():"")
				+ " ,situa��o: " + (getCpSituacaoConfiguracao()!=null?getCpSituacaoConfiguracao().getDscSitConfiguracao():"")
				+ " ,tipo conf: " + (getCpTipoConfiguracao().getDscTpConfiguracao());
	}

}
