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
package br.gov.jfrj.siga.wf.bl;

import br.gov.jfrj.siga.cp.bl.Cp;

/**
 * Classe que fornece uma inst�ncia do workflow.
 * 
 * @author kpf
 * 
 */
public class Wf extends
		Cp<WfConfiguracaoBL, WfCompetenciaBL, WfBL, WfPropriedadeBL> {

	/**
	 * Retorna uma inst�ncia do sistema de workflow. Atrav�s dessa inst�ncia �
	 * poss�vel acessar a l�gica de neg�cio, compet�ncias e configura��es do
	 * sistema de workflow.
	 * 
	 * @return Inst�ncia de workflow
	 */
	public static Wf getInstance() {
		if (!isInstantiated()) {
			synchronized (Cp.class) {
				if (!isInstantiated()) {
					Wf instance = new Wf();
					setInstance(instance);
					instance.setConf(new WfConfiguracaoBL());
					instance.getConf().setComparator(
							new WfConfiguracaoComparator());
					instance.setComp(new WfCompetenciaBL());
					instance.getComp().setConfiguracaoBL(instance.getConf());
					instance.setBL(new WfBL());
					instance.getBL().setComp(instance.getComp());
					instance.setProp(new WfPropriedadeBL());
				}
			}
		}
		return (Wf) Cp.getInstance();
	}
}
