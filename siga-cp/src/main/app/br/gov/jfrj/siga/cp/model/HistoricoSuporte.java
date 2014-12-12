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
package br.gov.jfrj.siga.cp.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import br.gov.jfrj.siga.model.Assemelhavel;
import br.gov.jfrj.siga.model.Historico;
import br.gov.jfrj.siga.model.Objeto;
import br.gov.jfrj.siga.sinc.lib.Desconsiderar;

@MappedSuperclass
public abstract class HistoricoSuporte extends Objeto implements Historico,
		Assemelhavel {

	@Column(name = "HIS_ID_INI")
	@Desconsiderar
	private Long hisIdIni;

	@Column(name = "HIS_DT_INI")
	@Desconsiderar
	private Date hisDtIni;

	@Column(name = "HIS_DT_FIM")
	@Desconsiderar
	private Date hisDtFim;

	@Transient
	//@Column(name = "HIS_ATIVO")
	@Desconsiderar
	private Integer hisAtivo;

	/**
	 * Atribui o hisAtivo j� que o mesmo � sempre calculado
	 */
	public void setAtivo() {
		this.hisAtivo = this.hisDtFim == null ? 1 : 0;
	}

	public Long getHisIdIni() {
		return hisIdIni;
	}

	public void setHisIdIni(Long hisIdIni) {
		this.hisIdIni = hisIdIni;
	}

	public Date getHisDtIni() {
		return hisDtIni;
	}

	public void setHisDtIni(Date hisDtIni) {
		this.hisDtIni = hisDtIni;
	}

	public Date getHisDtFim() {
		this.setAtivo();
		return hisDtFim;
	}

	public void setHisDtFim(Date hisDtFim) {
		this.hisDtFim = hisDtFim;
		this.setAtivo();
	}

	public Integer getHisAtivo() {
		this.setAtivo();
		return hisAtivo;
	}

	public boolean isAtivo() {
		return this.hisDtFim == null;
	}

	public void setHisAtivo(Integer hisAtivo) {
		this.setAtivo();
		// this.hisAtivo = hisAtivo;
	}

	public boolean equivale(Object other) {
		return this.getHisIdIni().equals(((Historico) other).getIdInicial());
	}

	public Long getIdInicial() {
		return getHisIdIni();
	}

	/**
	 * Verifica se estava ativo em uma determinada data
	 * 
	 * @param dt
	 *            data em que se quer verificar se estava ativo
	 * @return true or false
	 */
	public boolean ativoNaData(Date dt) {
		if (dt == null)
			return this.getHisDtFim() == null;
		if (this.getHisDtIni() != null && dt.before(this.getHisDtIni()))
			return false;
		// dt >= DtIni
		if (this.getHisDtFim() == null)
			return true;
		if (dt.before(this.getHisDtFim()))
			return true;
		return false;
	}
}