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
package br.gov.jfrj.siga.ex.ext;

import br.gov.jfrj.itextpdf.ConversorHtml;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.SigaExProperties;
import br.gov.jfrj.siga.ex.bl.ExConfiguracaoBL;

/**
 * Classe abstrata que representa uma f�brica (criador) de conversores HTML para
 * PDF.<br/>
 * Esta classe serve como ponto de extens�o, permitindo a substitui��o de
 * tecnologias de convers�o de forma isolada do resto do c�digo. <br/>
 * <br/>
 * 
 * Para criar uma nova extens�o:<br/>
 * <ol>
 * <li>Crie uma classe que estenda AbstractConversorHTMLFactory;</li>
 * <li>Configure arquivo siga.properties com a nova classe criada <br/>
 * Exemplo: <br/>
 * <br/>
 * conversor.html.factory =
 * br.gov.jfrj.siga.ex.ext.ConversorHTMLFactoryMinhaFabrica</li>
 * <li>Sobrescreva os m�todos abstratos</li>
 * </ol>
 * <br/>
 * O SIGA j� fornece uma implementa��o de f�brica padr�o chamada
 * br.gov.jfrj.siga.ex.ext.ConversorHTMLFactoryOpenSource
 * 
 * 
 * 
 * 
 * 
 * @author kpf
 * 
 */
public abstract class AbstractConversorHTMLFactory {

	public static final int CONVERSOR_NHEENGATU = 0;
	public static final int CONVERSOR_FOP = 1;

	private static AbstractConversorHTMLFactory instance;

	protected AbstractConversorHTMLFactory() {

	}

	public static AbstractConversorHTMLFactory getInstance()
			throws AplicacaoException {
		if (instance == null) {
			try {
				instance = (AbstractConversorHTMLFactory) Class.forName(
						SigaExProperties.getConversorHTMLFactory())
						.newInstance();
			} catch (InstantiationException e) {
				e.printStackTrace();
				throw new AplicacaoException(e.getMessage());
			} catch (IllegalAccessException e) {
				e.printStackTrace();
				throw new AplicacaoException(e.getMessage());
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				throw new AplicacaoException(e.getMessage());
			}
		}
		return instance;
	}

	/**
	 * Retorna um conversor baseado na configura��o, documento ou texto a ser
	 * convertido.
	 * 
	 * @param conf
	 * @param doc
	 * @param strHtml
	 * @return
	 * @throws Exception
	 */
	public abstract ConversorHtml getConversor(ExConfiguracaoBL conf,
			ExDocumento doc, String strHtml) throws Exception;

	/**
	 * Retorna um conversor espec�fico
	 * 
	 * @param conversor
	 *            - identifcador do conversor
	 * @return
	 * @throws Exception
	 */
	public abstract ConversorHtml getConversor(int conversor) throws Exception;

	/**
	 * Retorna o conversor padr�o.
	 * 
	 * @return
	 * @throws Exception
	 */
	public abstract ConversorHtml getConversorPadrao() throws Exception;

	/**
	 * Retorna a extens�o do conversor HTML definido na propriedade "conversor.html.ext" do arquivo siga.properties
	 * @return
	 * @throws AplicacaoException
	 */
	public ConversorHtml getExtensaoConversorHTML() throws AplicacaoException {
		// TODO Auto-generated method stub
		return null;
	}
}
