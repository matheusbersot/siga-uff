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
 * Criado em  21/12/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.siga.dp;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Table;

import br.gov.jfrj.siga.model.Selecionavel;

@Entity
@Table(schema="CORPORATIVO", name="CP_APLICACAO_FERIADO")
public class CpAplicacaoFeriado extends AbstractCpAplicacaoFeriado implements Serializable,
		Selecionavel {

	public String getDescricao() {
		return "";
	}

	public Long getId() {
		return new Long(getIdAplicacao());
	}

	public String getSigla() {
		return "";
	}

	public void setSigla(String sigla) {
		
	}
	
	public Boolean isFeriado(){
		if (getFgFeriado().equals("S"))
			return true;
		return false;
	}
	
	public void setFeriado(Boolean feriado){
		if (feriado)
			setFgFeriado("S");
		else setFgFeriado("N");
	}

}
