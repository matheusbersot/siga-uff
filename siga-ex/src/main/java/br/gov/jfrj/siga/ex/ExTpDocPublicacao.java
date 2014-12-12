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
 * Criado em  12/12/2005
 *
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.siga.ex;

import java.io.Serializable;

public class ExTpDocPublicacao extends AbstractExTpDocPublicacao implements
		Serializable {
	
	public static int TIPO_MATERIA_ATO_ORDINATORIO = 1;
	public static int TIPO_MATERIA_DECISAO = 2;
	public static int TIPO_MATERIA_DESPACHO = 3;
	public static int TIPO_MATERIA_EDITAL = 4;
	public static int TIPO_MATERIA_INFORMACAO_DE_SECRETARIA = 5;
	public static int TIPO_MATERIA_ORDEM_DE_SERVIÇO = 6;
	public static int TIPO_MATERIA_PORTARIA = 7;
	public static int TIPO_MATERIA_SENTENCA = 8;
	public static int TIPO_MATERIA_ACORDAO = 9;
	public static int TIPO_MATERIA_EXTRATOS_DE_CONTRATO = 85;
	public static int TIPO_MATERIA_TERMOS_ADITIVOS = 125;
	public static int TIPO_MATERIA_ATAS_DE_REGISTRO_DE_PRECOS = 126;

	public String getIdDocPublicacaoString(){
		return getIdDocPublicacao().toString();
	}
	
	public void setIdDocPublicacaoString(String id){
		setIdDocPublicacao(Long.parseLong(id));
	}
	
}
