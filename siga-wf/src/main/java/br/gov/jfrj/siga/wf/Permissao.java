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
package br.gov.jfrj.siga.wf;

import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;

/**
 * Esta classe representa uma permiss�o para instacia��o de procedimentos e � utilizada na view configurarInstanciacao.jsp 
 * 
 * @author kpf
 * 
 */
public class Permissao {
    private String procedimento;
    private Long Id;
    private DpPessoa pessoa;
    private DpLotacao lotacao;
    private Integer tipoResponsavel;
    
    /**
     * Retorna o tipo de respons�vel que pode instanciar um procedimento.
     * @return 0 - INDEFINIDO (sem defini��o de permiss�o)
     * 1 - MATRICULA (permiss�o para uma pessoa)
     * 2 - LOTACAO (permiss�o para uma lota��o inteira, ou seja, todos da lota��o)
     */
	public Integer getTipoResponsavel() {
		return tipoResponsavel;
	}
	
    /**
     * Informa o tipo de respons�vel que pode instanciar um procedimento.
     * @return 0 - INDEFINIDO (sem defini��o de permiss�o)
     * 1 - MATRICULA (permiss�o para uma pessoa)
     * 2 - LOTACAO (permiss�o para uma lota��o inteira, ou seja, todos da lota��o)
     */
	public void setTipoResponsavel(Integer tipoResponsavel) {
		this.tipoResponsavel = tipoResponsavel;
	}
	
	/**
	 * Retorna o procedimento referente � permiss�o.
	 * 
	 * @return
	 */
	public String getProcedimento() {
		return procedimento;
	}
	
	/**
	 * Informa o procedimento referente � permiss�o.
	 *  
	 */
	public void setProcedimento(String procedimento) {
		this.procedimento = procedimento;
	}
	
	/**
	 * Retorna a pessoa referente � permiss�o.
	 * @return
	 */
	public DpPessoa getPessoa() {
		return pessoa;
	}
	
	/**
	 * Informa  a pessoa referente � permiss�o.
	 * @param pessoa
	 */
	public void setPessoa(DpPessoa pessoa) {
		this.pessoa = pessoa;
	}
	
	/**
	 *  Retorna a lota��o referente � permiss�o.
	 * @return
	 */
	public DpLotacao getLotacao() {
		return lotacao;
	}
	
	/**
	 * Informa a lota��o referente � permiss�o.
	 * @param lotacao
	 */
	public void setLotacao(DpLotacao lotacao) {
		this.lotacao = lotacao;
	}

	/**
	 * Retorna o id da permiss�o.
	 * @return
	 */
	public Long getId() {
		return Id;
	}
	
	/**
	 * Informa o id da permiss�o.
	 * @param id
	 */
	public void setId(Long id) {
		Id = id;
	}

}
