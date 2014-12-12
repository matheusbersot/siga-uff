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
package br.gov.jfrj.siga.ex;

import java.util.ArrayList;
import java.util.List;

import br.gov.jfrj.siga.dp.DpLotacao;

public class ExTratamento extends AbstractExTratamento {
	
	ExTratamento(String autoridade, String genero, String formaDeTratamento, String abreviatura, 
			String vocativo, String formaDeEnderecamento) {
		this.autoridade = autoridade;
		this.genero = genero;
		this.formaDeTratamento = formaDeTratamento;
		this.abreviatura = abreviatura;
		this.vocativo = vocativo;
		this.formaDeEnderecamento = formaDeEnderecamento;
	}
	
	public static List<ExTratamento> todosTratamentos() {
		ArrayList<ExTratamento> l = new ArrayList<ExTratamento>();
		
		l.add(new ExTratamento("Presidente da Rep�blica", "F", "Vossa Excel�ncia", "V. Ex�.", "Excelent�ssima Senhora Presidenta da Rep�blica", "Excelent�ssima Senhora"));
		l.add(new ExTratamento("Presidente da Rep�blica", "M", "Vossa Excel�ncia", "V. Ex�.", "Excelent�ssimo Senhor Presidente da Rep�blica", "Excelent�ssimo Senhor"));
		l.add(new ExTratamento("Vice-Presidente da Rep�blica", "F", "Vossa Excel�ncia", "V. Ex�." , "Excel�ntissima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Vice-Presidente da Rep�blica", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Chefe de Gabinete Civil", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Chefe de Gabinete Civil", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Chefe de Gabinete Militar da Presid�ncia da Rep�blica", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Chefe de Gabinete Militar da Presid�ncia da Rep�blica", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Consultor-Geral da Rep�blica", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Consultor-Geral da Rep�blica", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Corregedor do Tribunal Regional Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Corregedora do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Corregedor do Tribunal Regional Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Corregedor do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Ministro de Estado", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Ministro de Estado", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Consultor-Geral da Rep�blica", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Consultor-Geral da Rep�blica", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Oficial General das For�as Armadas", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Membro do Congresso Nacional", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�. Deputada"));
		l.add(new ExTratamento("Membro do Congresso Nacional", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr. Deputado"));
		l.add(new ExTratamento("Presidente do Supremo Tribunal Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Supremo Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Presidente do Supremo Tribunal Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Supremo Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Membro do Supremo Tribunal Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Membro do Supremo Tribunal", "Excelent�ssima Senhora Juiza "));
		l.add(new ExTratamento("Membro do Supremo Tribunal Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Membro do Supremo Tribunal", "Excelent�ssimo Senhor Juiz "));
		l.add(new ExTratamento("Presidente do Tribunal Superior", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Presidente do Tribunal Superior", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Membro do Tribunal Superior", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Membro do Tribunal Superior", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Presidente do Tribunal de Contas da Uni�o", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Presidente do Tribunal de Contas da Uni�o", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Membro do Tribunal de Contas da Uni�o", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Membro do Tribunal de Contas da Uni�o", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Presidente do Tribunal Regional Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Desembargadora Federal"));
		l.add(new ExTratamento("Presidente do Tribunal Regional Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Desembargador Federal"));
		l.add(new ExTratamento("Membro do Tribunal Regional Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Desembargadora Federal"));
		l.add(new ExTratamento("Membro do Tribunal Regional Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Desembargador Federal"));
		l.add(new ExTratamento("Presidente do Tribunal de Justi�a", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Presidente do Tribunal de Justi�a", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Membro do Tribunal de Justi�a", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora Presidente do Tribunal", "Excelent�ssima Senhora Juiza"));
		l.add(new ExTratamento("Membro do Tribunal de Justi�a", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor Presidente do Tribunal", "Excelent�ssimo Senhor Juiz"));
		l.add(new ExTratamento("Juiz Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Senhora Juiza", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Juiz Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Senhor Juiz", "Exm�. Sr. Dr."));
		l.add(new ExTratamento("Juiz em geral", "F", "Vossa Excel�ncia", "V. Ex�." , "Senhora Juiza", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Juiz em geral", "M", "Vossa Excel�ncia", "V. Ex�." , "Senhor Juiz", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Auditor da Justi�a Militar", "F", "Vossa Excel�ncia", "V. Ex�." , "Senhora Juiza", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Auditor da Justi�a Militar", "M", "Vossa Excel�ncia", "V. Ex�." , "Senhor Juiz", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Procurador-Geral da Rep�blica", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Procurador-Geral da Rep�blica", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Procurador-Geral junto ao Tribunal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Procurador-Geral junto ao Tribunal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Embaixador", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Embaixador", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr�. Dr�."));
		l.add(new ExTratamento("Governador de Estado e do Distrito Federal", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Governador de Estado e do Distrito Federal", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Presidente da Assembl�ia Legislativa", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Presidente da Assembl�ia Legislativa", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Membro da Assembl�ia Legislativa", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Membro da Assembl�ia Legislativa", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Secret�rio de Estado do Governo Estadual", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Secret�rio de Estado do Governo Estadual", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Prefeito", "F", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssima Senhora", "Exm�. Sr�."));
		l.add(new ExTratamento("Prefeito", "M", "Vossa Excel�ncia", "V. Ex�." , "Excelent�ssimo Senhor", "Exm�. Sr."));
		l.add(new ExTratamento("Reitor de Universidade", "F", "Vossa Magnific�ncia", "V. Mag�" , "Magn�fico Reitor", "Exm�. Sr�."));
		l.add(new ExTratamento("Reitor de Universidade", "M", "Vossa Magnific�ncia", "V. Mag�" , "Magn�fico Reitor", "Exm�. Sr."));
		l.add(new ExTratamento("Cardeal", "M", "Vossa Emin�ncia ou Vossa Emin�ncia Reverend�ssima", "V. Em�.ou V. Em�. Revm�" , "Eminent�ssimo Senhor", "Eminent�ssimo Senhor D."));
		l.add(new ExTratamento("Bispo e Arcebispo", "M", "Vossa Excel�ncia Reverend�ssima", "V. Ex�. Revm�" , "Reverend�ssimo Senhor", "Reverend�ssimo Senhor D."));
		l.add(new ExTratamento("Monsenhor, C�nego", "M", "Vossa Senhoria Reverend�ssima", "V. S�. Revm�" , "Reverend�ssimo Senhor", "Reverend�ssimo SenhorPadre "));
		l.add(new ExTratamento("Dirigente administrativo e Procurador", "F", "Vossa Senhoria", "V. S�." , "Senhora", "Sr�."));
		l.add(new ExTratamento("Dirigente administrativo e Procurador", "M", "Vossa Senhoria", "V. S�." , "Senhor", "Sr."));
		l.add(new ExTratamento("[Outros]", "F", "Vossa Senhoria", "V. S�." , "Prezada Senhora", "Sr�."));
		l.add(new ExTratamento("[Outros]", "M", "Vossa Senhoria", "V. S�." , "Prezado Senhor", "Sr."));
		
		return l;
	}
	public static String genero(String autoridade){
		
		List <ExTratamento> todosTratamentos=ExTratamento.todosTratamentos(); 
		for (ExTratamento trat : todosTratamentos){
			if(trat.getAutoridade().equals(autoridade) && trat.getGenero().equals("F"))	
				return trat.getGenero();
		
			if(trat.getAutoridade().equals(autoridade) && trat.getGenero().equals("M"))	
				return trat.getGenero();
		}	
		 
		return null;
		
	}
	
	public static ExTratamento tratamento(String autoridade, String genero){
		
		List <ExTratamento> todosTratamentos=ExTratamento.todosTratamentos(); 
		
		for (ExTratamento trat : todosTratamentos) {
			if((trat.getAutoridade().equals(autoridade)) && (trat.getGenero().equals(genero)))
				return trat;

		}
		return null;
	}
}
