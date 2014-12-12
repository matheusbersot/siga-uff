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
package br.gov.jfrj.siga.model;

import java.util.Date;

public interface Historico extends Assemelhavel {
	public Long getIdInicial();

	public boolean equivale(Object other);

	public Long getId();
	
	public void setId(Long id);

	public Long getHisIdIni();

	public void setHisIdIni(Long hisIdIni);

	public Date getHisDtIni();

	public void setHisDtIni(Date hisDtIni);

	public Date getHisDtFim();

	public void setHisDtFim(Date hisDtFim);

	public Integer getHisAtivo();

	public void setHisAtivo(Integer hisAtivo);
}