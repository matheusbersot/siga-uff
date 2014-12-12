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
 *
 * 
 */
package br.gov.jfrj.siga.base;


/**
 * @author SEANS Classe padr�o para tratamenteo de erros nos Sistemas
 * 
 */
public class AplicacaoException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3346798706685517274L;
	private int codigoErro;

	/**
	 * Construtor padr�o para a Classe
	 * 
	 */
	public AplicacaoException() {
		this(null, 0, null);

	}

	/**
	 * Construtor da Classe que atribui uma mensagem
	 * 
	 * @param message -
	 *            Descri��o do motivo da exce��o
	 */
	public AplicacaoException(final String message) {
		this(message, 0);

	}

	/**
	 * 
	 * Construtor da Classe que atribui uma mensagem e c�digo de Identifica��o
	 * 
	 * @param message -
	 *            Descri��o do motivo da exce��o
	 * @param codigo -
	 *            C�digo de identifica��o da exce��o para
	 */
	public AplicacaoException(final String message, final int codigo) {
		this(message, codigo, null);
	}

	/**
	 * 
	 * Construtor da Classe que atribui uma mensagem, um c�digo de Identifica��o
	 * e uma causa para a exce��o
	 * 
	 * @param message -
	 *            Descri��o do motivo da exce��o
	 * @param codigo -
	 *            C�digo de identifica��o da exce��o para
	 * @param causa -
	 *            Objeto da classe Throwable que gerou esta exce��o
	 */
	public AplicacaoException(final String message, final int codigo, final Throwable causa) {
		super(message, causa);
		this.codigoErro = codigo;
	}

	/**
	 * @return Retorna o atributo codigo.
	 */
	public int getCodigoErro() {
		return codigoErro;
	}
}
