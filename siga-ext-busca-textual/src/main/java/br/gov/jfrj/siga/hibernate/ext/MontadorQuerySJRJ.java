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
package br.gov.jfrj.siga.hibernate.ext;

import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;

public class MontadorQuerySJRJ implements IMontadorQuery{

	IMontadorQuery montadorPrincipal = null;
	/**
	 * Monta query com BLOB. 
	 */
	public String montaQueryConsultaporFiltro(final IExMobilDaoFiltro flt,
			DpPessoa titular, DpLotacao lotaTitular, boolean apenasCount) {

		StringBuffer sbf = null;
		if (montadorPrincipal!=null){
			sbf = new StringBuffer(montadorPrincipal.montaQueryConsultaporFiltro(flt, titular, lotaTitular, apenasCount));	
		}else{
			sbf = new StringBuffer(); 
		}
		
		if (flt.getFullText() != null && !flt.getFullText().trim().equals("")) {
			
			String s = flt.getFullText();
			while (s.contains("  "))
				s = s.replace("  ", " ");
			s = s.replaceAll(" ", " AND ");
			
			
			String sqlExMovimentacao  = " exists (from ExMarca label1"
									  + "         inner join label1.exMobil mob1"
									  + "		  inner join label1.exMobil.exMovimentacaoSet mov "
									  + "         where mob1.idMobil = mob.idMobil"
									  + "         and CONTAINS(mov.conteudoBlobMov, '" + s + "', 1) > 0))";
	
			int indice = sbf.indexOf("order by");
			if (indice > 0){
				sbf.insert(indice-1, " and (CONTAINS(doc.conteudoBlobDoc, '" + s + "', 0) > 0)" 
									+ " or " + sqlExMovimentacao );			
			}
			else
			{
				sbf.append(" and (CONTAINS(doc.conteudoBlobDoc, '");
				sbf.append(s);
				sbf.append("', 0) > 0");
				sbf.append(" or " + sqlExMovimentacao);
			}
			
			
			/*String sqlExMovimentacao  = " inner join label.exMobil.exMovimentacaoSet mov ";
			
			int indice = sbf.indexOf("where");
			if (indice > 0){
				sbf.insert(indice-1, sqlExMovimentacao);
			}
			
			String s = flt.getFullText();
			while (s.contains("  "))
				s = s.replace("  ", " ");
			s = s.replaceAll(" ", " AND ");
			
			indice = sbf.indexOf("order by");
			if (indice > 0){
				sbf.insert(indice-1, " and (CONTAINS(doc.conteudoBlobDoc, '" + s + "', 0) > 0" 
									+ " or CONTAINS(mov.conteudoBlobMov, '" + s + "', 1) > 0)" );			
			}
			else
			{
				sbf.append(" and (CONTAINS(doc.conteudoBlobDoc, '");
				sbf.append(s);
				sbf.append("', 0) > 0");
				sbf.append(" or CONTAINS(mov.conteudoBlobMov, '");
				sbf.append(s);
				sbf.append("', 1) > 0)");
			}	*/
		}
		
		return sbf.toString();

	}

	@Override
	public void setMontadorPrincipal(IMontadorQuery montadorQueryPrincipal) {
		this.montadorPrincipal = montadorQueryPrincipal;
	}

}
