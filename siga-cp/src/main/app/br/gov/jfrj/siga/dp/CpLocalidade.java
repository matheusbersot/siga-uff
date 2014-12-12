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
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.model.Selecionavel;

@Entity
@Table(name = "CP_LOCALIDADE", schema = "CORPORATIVO")
@SuppressWarnings("serial")
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY)
public class CpLocalidade extends AbstractCpLocalidade implements Serializable,
		Selecionavel {
	
	public static List<String> MUNICIPIOS = obterMunicipios();
	@SuppressWarnings("unchecked")
	private static List<String> obterMunicipios() {
		try {
			return Cp.getInstance().getProp().obterMunicipios();
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList();
		}
	}
	/*
	static {
		String[] municipiosArray ={"Angra dos Reis", "Barra do Pira�", "Cachoeiro do Itapemirim", "Campos",
				"Duque de Caxias", "Itabora�", "Itaperuna", "Maca�", "Mag�",
				"Niter�i", "Nova Friburgo", "Nova Igua�u", "Petr�polis", "Resende",
				"Rio de Janeiro", "S�o Gon�alo", "S�o Jo�o de Meriti",
				"S�o Mateus", "S�o Pedro da Aldeia", "Teres�polis", "Tr�s Rios",
				"Vit�ria", "Volta Redonda" }; 
		MUNICIPIOS = Arrays.asList(municipiosArray);
	} */

	public String getDescricao() {
		return getNmLocalidade();
	}

	public Long getId() {
		return new Long(getIdLocalidade());
	}

	public String getSigla() {
		return getNmLocalidade();
	}

	public void setSigla(String sigla) {
		setNmLocalidade(sigla);

	}

}
