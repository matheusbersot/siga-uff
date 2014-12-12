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
 * Created Mon Nov 14 13:33:09 GMT-03:00 2005 by MyEclipse Hibernate Tool.
 */
package br.gov.jfrj.siga.ex;

import br.gov.jfrj.siga.model.Assemelhavel;

/**
 * A class that represents a row in the 'EX_VIA' table. This class may be
 * customized as it is never re-generated after being created.
 */
public class ExVia extends AbstractExVia {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8108242933119138639L;

	/**
	 * Simple constructor of ExVia instances.
	 */
	public ExVia() {
	}

//	public String getDestinacao() {
//		if (getExTipoDestinacao() != null)
//			return getExTipoDestinacao().getDescrTipoDestinacao();
//		else
//			return "";
//	}

	public String getLetraVia() {
		if (getCodVia() != null)
			return new Character((char) (Integer.parseInt(getCodVia()) + 64))
					.toString();
		else
			return "";
	}

	public Long getId() {
		return getIdVia();
	}

	public void setId(Long id) {
		setIdVia(id);
	}

	public boolean semelhante(Assemelhavel obj, int profundidade) {
		return false;
	}

	/* Add customized code below */

}
