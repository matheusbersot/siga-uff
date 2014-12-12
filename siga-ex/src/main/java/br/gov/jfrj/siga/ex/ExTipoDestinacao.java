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
 * Created Mon Nov 14 13:33:07 GMT-03:00 2005 by MyEclipse Hibernate Tool.
 */
package br.gov.jfrj.siga.ex;

import java.io.Serializable;

import br.gov.jfrj.siga.hibernate.ExDao;

/**
 * A class that represents a row in the 'EX_TIPO_DESTINACAO' table. This class
 * may be customized as it is never re-generated after being created.
 */
public class ExTipoDestinacao extends AbstractExTipoDestinacao implements
		Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8791659138846087059L;

	public static final long TIPO_DESTINACAO_ELIMINACAO = 1;

	public static final long TIPO_DESTINACAO_GUARDA_PERMANENTE = 2;
	
	public static final long TIPO_DESTINACAO_SETOR_COMPETENTE = 58;

	// Edson: isto est� estranho. Ver solu�ao melhor.
	public static ExTipoDestinacao guardaPermanente() {
		return ExDao.getInstance().consultar(TIPO_DESTINACAO_GUARDA_PERMANENTE,
				ExTipoDestinacao.class, false);
	}

	/**
	 * Simple constructor of ExTipoDestinacao instances.
	 */
	public ExTipoDestinacao() {
	}

}