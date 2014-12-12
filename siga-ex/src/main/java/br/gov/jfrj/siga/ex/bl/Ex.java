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
package br.gov.jfrj.siga.ex.bl;

import br.gov.jfrj.siga.cp.bl.Cp;

/**
 * Classe que fornece uma inst�ncia do workflow.
 * 
 * @author kpf
 * 
 */
public class Ex extends
		Cp<ExConfiguracaoBL, ExCompetenciaBL, ExBL, ExPropriedadeBL> {

	/**
	 * Retorna uma inst�ncia do sistema de workflow. Atrav�s dessa inst�ncia �
	 * poss�vel acessar a l�gica de neg�cio, compet�ncias e configura��es do
	 * sistema de workflow.
	 * 
	 * @return Inst�ncia de workflow
	 */
	public static Ex getInstance() {
		if (!isInstantiated()) {
			synchronized (Cp.class) {
				if (!isInstantiated()) {
					Ex instance = new Ex();
					setInstance(instance);
					instance.setConf(new ExConfiguracaoBL());
					instance.getConf().setComparator(
							new ExConfiguracaoComparator());
					instance.setComp(new ExCompetenciaBL());
					instance.getComp().setConfiguracaoBL(instance.getConf());
					instance.setBL(new ExBL());
					instance.getBL().setComp(instance.getComp());
					instance.setProp(new ExPropriedadeBL());
				}
			}
		}
		return (Ex) Cp.getInstance();
	}
}
