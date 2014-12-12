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
import java.sql.Blob;

import br.gov.jfrj.siga.cp.model.HistoricoAuditavelSuporte;

/**
 * A class that represents a row in the EX_MODELO table. You can customize the
 * behavior of this class by editing the class, {@link ExModelo()}.
 */
public abstract class AbstractExModelo extends HistoricoAuditavelSuporte implements Serializable {
	/** The value of the simple conteudoBlobMod property. */
	private Blob conteudoBlobMod;

	/** The value of the simple conteudoTpBlob property. */
	private java.lang.String conteudoTpBlob;

	/** The value of the simple descMod property. */
	private java.lang.String descMod;

	private ExClassificacao exClassCriacaoVia;

	private ExClassificacao exClassificacao;

	private ExFormaDocumento exFormaDocumento;

	private ExNivelAcesso exNivelAcesso;

	/**
	 * The cached hash code value for this instance. Settting to 0 triggers
	 * re-calculation.
	 */
	private int hashValue = 0;

	/** The value of the exModeloTipologiaSet one-to-many association. */

	/** The composite primary key value. */
	private java.lang.Long idMod;

	private java.lang.String nmArqMod;

	/** The value of the simple nomeModelo property. */
	private java.lang.String nmMod;

	// private Set classificacaoSet;

	/**
	 * Simple constructor of AbstractExModelo instances.
	 */
	public AbstractExModelo() {
	}

	/**
	 * Constructor of AbstractExModelo instances given a simple primary key.
	 * 
	 * @param idMod
	 */
	public AbstractExModelo(final java.lang.Long idMod) {
		this.setIdMod(idMod);
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
		if ((rhs == null) || !(rhs instanceof ExModelo))
			return false;
		final ExModelo that = (ExModelo) rhs;
		if ((this.getIdMod() == null ? that.getIdMod() == null : this
				.getIdMod().equals(that.getIdMod()))) {
			if ((this.getDescMod() == null ? that.getDescMod() == null : this
					.getDescMod().equals(that.getDescMod())))
				return true;
		}
		return false;

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
	 * Return the value of the CONTEUDO_TP_BLOB column.
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getConteudoTpBlob() {
		return this.conteudoTpBlob;
	}

	/**
	 * Return the value of the DESC_MOD column.
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getDescMod() {
		return this.descMod;
	}

	public ExClassificacao getExClassCriacaoVia() {
		return exClassCriacaoVia;
	}

	public ExClassificacao getExClassificacao() {
		return exClassificacao;
	}

	/*    *//**
			 * @return Retorna o atributo tipologiaSet.
			 */
	/*
	 * public Set getClassificacaoSet() { return classificacaoSet; }
	 */

	public ExFormaDocumento getExFormaDocumento() {
		return exFormaDocumento;
	}

	/**
	 * Return the simple primary key value that identifies this object.
	 * 
	 * @return java.lang.Long
	 */
	public java.lang.Long getIdMod() {
		return idMod;
	}

	/*    *//**
			 * @param classificacaoSet
			 *            Atribui a classificacaoSet o valor.
			 */
	/*
	 * public void setClassificacaoSet(Set classificacaoSet) {
	 * this.classificacaoSet = classificacaoSet; }
	 */

	public java.lang.String getNmArqMod() {
		return nmArqMod;
	}

	/**
	 * Return the value of the NM_MOD column.
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getNmMod() {
		return this.nmMod;
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
		int idValue = this.getIdMod() == null ? 0 : this.getIdMod().hashCode();
		result = result * 37 + idValue;
		idValue = this.getDescMod() == null ? 0 : this.getDescMod().hashCode();
		result = result * 37 + idValue;
		this.hashValue = result;

		return this.hashValue;
	}

	/**
	 * Set the value of the CONTEUDO_BLOB_MOD column.
	 * 
	 * @param conteudoBlobMod
	 */
	public void setConteudoBlobMod(Blob conteudoBlobMod) {
		this.conteudoBlobMod = conteudoBlobMod;
	}

	/**
	 * Set the value of the CONTEUDO_TP_BLOB column.
	 * 
	 * @param conteudoTpBlob
	 */
	public void setConteudoTpBlob(final java.lang.String conteudoTpBlob) {
		this.conteudoTpBlob = conteudoTpBlob;
	}

	/**
	 * Set the value of the DESC_MOD column.
	 * 
	 * @param descMod
	 */
	public void setDescMod(final java.lang.String descMod) {
		this.descMod = descMod;
	}

	public void setExClassCriacaoVia(ExClassificacao exClassCriacaoVia) {
		this.exClassCriacaoVia = exClassCriacaoVia;
	}

	public void setExClassificacao(final ExClassificacao exClassificacao) {
		this.exClassificacao = exClassificacao;
	}

	public void setExFormaDocumento(final ExFormaDocumento exFormaDocumento) {
		this.exFormaDocumento = exFormaDocumento;
	}

	/**
	 * Set the simple primary key value that identifies this object.
	 * 
	 * @param idMod
	 */
	public void setIdMod(final java.lang.Long idMod) {
		this.hashValue = 0;
		this.idMod = idMod;
	}

	public void setNmArqMod(final java.lang.String nmArqMod) {
		this.nmArqMod = nmArqMod;
	}

	/**
	 * Set the value of the NM_MOD column.
	 * 
	 * @param nmMod
	 */
	public void setNmMod(final java.lang.String nmMod) {
		this.nmMod = nmMod;
	}

	public ExNivelAcesso getExNivelAcesso() {
		return exNivelAcesso;
	}

	public void setExNivelAcesso(ExNivelAcesso exNivelAcesso) {
		this.exNivelAcesso = exNivelAcesso;
	}
}
