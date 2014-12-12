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
 * Created Mon Nov 14 13:33:07 GMT-03:00 2005 by MyEclipse Hibernate Tool.
 */
package br.gov.jfrj.siga.ex;

import java.io.Serializable;

/**
 * A class that represents a row in the 'EX_TIPO_DESPACHO' table. This class may
 * be customized as it is never re-generated after being created.
 */
public class ExNivelAcesso extends AbstractExNivelAcesso implements
		Serializable {

	private static final long serialVersionUID = 3256722875116761397L;

	public static final long NIVEL_ACESSO_PUBLICO = 10;

	public static final long NIVEL_ACESSO_ENTRE_ORGAOS = 20;

	public static final long NIVEL_RESERVADO_ENTRE_LOTACOES = 25;

	public static final long NIVEL_ACESSO_PESSOA_SUB = 30;

	public static final long NIVEL_ACESSO_SUB_PESSOA = 40;

	public static final long NIVEL_ACESSO_ENTRE_LOTACOES = 60;

	public static final long NIVEL_ACESSO_PESSOAL = 100;

	public ExNivelAcesso() {
	}

}
