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
package br.gov.jfrj.siga.sinc.lib.test;

import br.gov.jfrj.siga.sinc.lib.SincronizavelSuporte;

public class Filho extends SincronizavelSuporte {
	public String nome;
	public Filho pai;
	public Filho mae;

	public Filho(String idExterna, String nome, Filho pai, Filho mae) {
		super();
		this.setIdExterna(idExterna);
		this.nome = nome;
		this.pai = pai;
		this.mae = mae;
	}
}
