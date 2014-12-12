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
package br.gov.jfrj.siga.cd.old;

/**
 * @author mparaiso
 * 
 * 
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class InvalidCRLException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8822963356096322149L;

	public InvalidCRLException(final String msg) {

		super(msg);
	}

	public InvalidCRLException(final String msg, final Exception e) {

		super(msg, e);
	}

}
