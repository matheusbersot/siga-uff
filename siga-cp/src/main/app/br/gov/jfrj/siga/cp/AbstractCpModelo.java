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
package br.gov.jfrj.siga.cp;

import static javax.persistence.GenerationType.SEQUENCE;

import java.sql.Blob;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.SequenceGenerator;

import br.gov.jfrj.siga.cp.model.HistoricoAuditavelSuporte;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.sinc.lib.Desconsiderar;

@MappedSuperclass
public abstract class AbstractCpModelo extends HistoricoAuditavelSuporte {
	private static final long serialVersionUID = -3468035660039727667L;

	/** The primary key value. */
	
	@SequenceGenerator(name="generator", sequenceName="CP_MODELO_SEQ")
	@Id 
	@GeneratedValue(strategy=SEQUENCE, generator="generator")
    @Column(name="ID_MODELO", nullable=false)
	@Desconsiderar
	private java.lang.Long idMod;

	/** The value of the simple conteudoBlobMod property. */
@Column(name="CONTEUDO_BLOB_MOD")
	private Blob conteudoBlobMod;

	@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="ID_ORGAO_USU")
	private CpOrgaoUsuario cpOrgaoUsuario;

	/**
	 * Return the value of the primary key column.
	 * 
	 * @return java.lang.Long
	 */
	public java.lang.Long getIdMod() {
		return idMod;
	}

	/**
	 * Return the value of the CONTEUDO_BLOB_MOD column.
	 * 
	 * @return java.lang.String
	 */
	public Blob getConteudoBlobMod() {
		return this.conteudoBlobMod;
	}

	/**
	 * /** Set the simple primary key value that identifies this object.
	 * 
	 * @param idMod
	 */
	public void setIdMod(final java.lang.Long idMod) {
		this.idMod = idMod;
	}

	/**
	 * Set the value of the CONTEUDO_BLOB_MOD column.
	 * 
	 * @param conteudoBlobMod
	 */
	public void setConteudoBlobMod(Blob conteudoBlobMod) {
		this.conteudoBlobMod = conteudoBlobMod;
	}

	public CpOrgaoUsuario getCpOrgaoUsuario() {
		return cpOrgaoUsuario;
	}

	public void setCpOrgaoUsuario(CpOrgaoUsuario cpOrgaoUsuario) {
		this.cpOrgaoUsuario = cpOrgaoUsuario;
	}

}
