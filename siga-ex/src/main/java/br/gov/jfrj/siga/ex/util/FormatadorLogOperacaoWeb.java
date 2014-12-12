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
package br.gov.jfrj.siga.ex.util;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @author eeh Define um formato padr�o para output de logs da aplica��o em
 *         ambiente web. � usado, por exemplo, quando se deseja imprimir, num
 *         dispositivo de sa�da, o estado atual de uma requisi��o sendo
 *         processada. Esta classe apenas gera a linha formatada para output,
 *         que se obt�m por meio do toString()
 */
public class FormatadorLogOperacaoWeb {

	private long tempoOperacao;

	private HttpServletRequest request;

	private String mensagem;

	/**
	 * 
	 * @param request
	 *            Objeto referente � requisi��o cujos dados se quer imprimir em
	 *            log
	 * @param tempoOperacao
	 *            Tempo que a opera��o tem levado desde um momento arbitr�rio,
	 *            que pode ser o in�cio do processamento da requisi��o
	 */
	public FormatadorLogOperacaoWeb(HttpServletRequest request,
			long tempoOperacao) {
		this(request, tempoOperacao, null);
	}

	public FormatadorLogOperacaoWeb(HttpServletRequest request,
			long tempoOperacao, String mensagem) {
		this.tempoOperacao = tempoOperacao;
		this.request = request;
		this.mensagem = mensagem;
	}

	@Override
	public String toString() {
		StringBuffer sbf = new StringBuffer();
		sbf.append("Tempo(ms): ");
		sbf.append(tempoOperacao);
		sbf.append("	");
		if (mensagem != null) {
			sbf.append("Obs.: ");
			sbf.append(mensagem);
			sbf.append("	");
		}
		sbf.append(request.getRequestURI());
		sbf.append("	");
		String paramName = "";
		for (Object paramNameObj : request.getParameterMap().keySet()) {
			paramName = (String) paramName;
			if (!paramName.equals("ts") && !paramName.equals("assinaturaB64")
					&& !paramName.contains("<p>")) {
				sbf.append(paramName);
				sbf.append(": ");
				sbf.append(request.getParameter((String) paramName));
				sbf.append(";  ");
			}
		}
		sbf.append(request.getRemoteHost());
		sbf.append("	");
		return sbf.toString();
	}
}
