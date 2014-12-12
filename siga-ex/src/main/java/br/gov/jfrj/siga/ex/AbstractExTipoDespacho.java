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
 */

package br.gov.jfrj.siga.ex;

import java.io.Serializable;

import br.gov.jfrj.siga.model.Objeto;

/**
 * A class that represents a row in the EX_TIPO_DESPACHO table. You can
 * customize the behavior of this class by editing the class,
 * {@link ExTipoDespacho()}.
 */
public abstract class AbstractExTipoDespacho extends Objeto implements Serializable {
	/** The value of the simple descTpDespacho property. */
	private java.lang.String descTpDespacho;

	private String fgAtivo;

	/**
	 * The cached hash code value for this instance. Settting to 0 triggers
	 * re-calculation.
	 */
	private int hashValue = 0;

	/** The composite primary key value. */
	private java.lang.Long idTpDespacho;

	/**
	 * Simple constructor of AbstractExTipoDespacho instances.
	 */
	public AbstractExTipoDespacho() {
	}

	/**
	 * Constructor of AbstractExTipoDespacho instances given a simple primary
	 * key.
	 * 
	 * @param idTpDespacho
	 */
	public AbstractExTipoDespacho(final java.lang.Long idTpDespacho) {
		this.setIdTpDespacho(idTpDespacho);
	}

	/**
	 * Implementation of the equals comparison on the basis of equality of the
	 * primary key values.
	 * 
	 * @param rhs
	 * @return boolean
	 */
	@Override
	public boolean equals(final Object rhs) {
		if ((rhs == null) || !(rhs instanceof ExTipoDespacho))
			return false;
		final ExTipoDespacho that = (ExTipoDespacho) rhs;
		if ((this.getIdTpDespacho() == null ? that.getIdTpDespacho() == null : this.getIdTpDespacho().equals(
				that.getIdTpDespacho()))) {
			if ((this.getDescTpDespacho() == null ? that.getDescTpDespacho() == null : this.getDescTpDespacho().equals(
					that.getDescTpDespacho())))
				return true;
		}
		return false;

	}

	/**
	 * Return the value of the DESC_TP_DESPACHO column.
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getDescTpDespacho() {
		return this.descTpDespacho;
	}

	/**
	 * @return Retorna o atributo fgAtivo.
	 */
	public String getFgAtivo() {
		return fgAtivo;
	}

	/**
	 * Return the simple primary key value that identifies this object.
	 * 
	 * @return java.lang.Long
	 */
	public java.lang.Long getIdTpDespacho() {
		return idTpDespacho;
	}

	/**
	 * Implementation of the hashCode method conforming to the Bloch pattern
	 * with the exception of array properties (these are very unlikely primary
	 * key types).
	 * 
	 * @return int
	 */
	@Override
	public int hashCode() {
		int result = 17;
		int idValue = this.getIdTpDespacho() == null ? 0 : this.getIdTpDespacho().hashCode();
		result = result * 37 + idValue;
		idValue = this.getDescTpDespacho() == null ? 0 : this.getDescTpDespacho().hashCode();
		result = result * 37 + idValue;
		this.hashValue = result;

		return this.hashValue;
	}

	/**
	 * Set the value of the DESC_TP_DESPACHO column.
	 * 
	 * @param descTpDespacho
	 */
	public void setDescTpDespacho(final java.lang.String descTpDespacho) {
		this.descTpDespacho = descTpDespacho;
	}

	/**
	 * @param fgAtivo
	 *            Atribui a fgAtivo o valor.
	 */
	public void setFgAtivo(final String ativo) {
		this.fgAtivo = ativo;
	}

	/**
	 * Set the simple primary key value that identifies this object.
	 * 
	 * @param idTpDespacho
	 */
	public void setIdTpDespacho(final java.lang.Long idTpDespacho) {
		this.idTpDespacho = idTpDespacho;
	}
}
