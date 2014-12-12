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

import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.bl.CpConfiguracaoComparator;
import br.gov.jfrj.siga.wf.WfConfiguracao;

/**
 * Classe que permite a compara��o entre duas configura��es de workflow.
 * 
 * @author kpf
 * 
 */
public class WfConfiguracaoComparator extends CpConfiguracaoComparator {

	/**
	 * Compara duas configura��es.
	 * 
	 */
	public int compare(CpConfiguracao c1, CpConfiguracao c2) {

		int i = super.compareSelectedFields(c1, c2);
		if (i != 0)
			return i;

		if (c1 instanceof WfConfiguracao && c2 instanceof WfConfiguracao) {
			WfConfiguracao wfC1 = (WfConfiguracao) c1;
			WfConfiguracao wfC2 = (WfConfiguracao) c2;

			if (wfC1.getProcedimento() == null
					&& wfC2.getProcedimento() != null)
				return 1;
			else if (wfC1.getProcedimento() != null
					&& wfC2.getProcedimento() == null)
				return -1;

			if (wfC1.getRaia() == null && wfC2.getRaia() != null)
				return 1;
			else if (wfC1.getRaia() != null && wfC2.getRaia() == null)
				return -1;

			if (wfC1.getTarefa() == null && wfC2.getTarefa() != null)
				return 1;
			else if (wfC1.getTarefa() != null && wfC2.getTarefa() == null)
				return -1;
		}

		i = super.untieSelectedFields(c1, c2);
		if (i != 0)
			return i;

		return c1.getIdConfiguracao().compareTo(c2.getIdConfiguracao());
	}
}
