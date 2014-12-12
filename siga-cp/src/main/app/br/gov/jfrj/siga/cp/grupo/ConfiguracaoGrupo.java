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
package br.gov.jfrj.siga.cp.grupo;

import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpGrupo;
/**
 *  Uma configura��o de grupo � a representa��o de uma configura��o (CpConfiguracao) 
 *  com o objetivo espec�fico de configurar um grupo, seja ele grupo de email
 *  , grupo de acesso a um recurso ou programa, etc.
 */
public abstract class ConfiguracaoGrupo {
	private CpConfiguracao cpConfiguracao ;
	private CpGrupo cpGrupo;
	private TipoConfiguracaoGrupoEnum tipo;
	// apenas para uso em EL 
	protected String conteudoConfiguracao;
	protected String siglaConteudoConfiguracao;
	protected Long idConteudoConfiguracao;
	protected String descricaoConteudoConfiguracao;
	//
	public ConfiguracaoGrupo() {
		tipo = obterTipoPadrao();
	}
	/**
	 * @return the cpConfiguracao
	 */
	public CpConfiguracao getCpConfiguracao() {
		return cpConfiguracao;
	}

	/**
	 * @param cpConfiguracao the cpConfiguracao to set
	 */
	public void setCpConfiguracao(CpConfiguracao cpConfiguracao) {
		this.cpConfiguracao = cpConfiguracao;
	}

	/**
	 * @return the cpGrupo
	 */
	public CpGrupo getCpGrupo() {
		return cpGrupo;
	}

	/**
	 * @param cpGrupo the cpGrupo to set
	 */
	public void setCpGrupo(CpGrupo cpGrupo) {
		this.cpGrupo = cpGrupo;
	}
	/**
	 * atualizar os atributos da configura��o (cpConfiguracao) a partir dos atributos da inst�ncia
	*/
	public abstract void atualizarCpConfiguracao() ;
	/**
	 * atualizar dos atributos da inst�ncia a partir dos atributos da configura��o (cpConfiguracao) 
	*/
	public abstract void atualizarDeCpConfiguracao();
	/**
	 * @return the tipo
	 */
	public TipoConfiguracaoGrupoEnum getTipo() {
		return tipo;
	}

	/**
	 * @param tipo the tipo to set
	 */
	public void setTipo(TipoConfiguracaoGrupoEnum tipo) {
		this.tipo = tipo;
	}

	public abstract void setConteudoConfiguracao(String p_strConteudo) ;
	/**
	 * Retorna o conte�do da configura��o 
	 * Dependendo do tipo da configura��o, pode ser um id, um e-mail, uma f�rmula, etc. 
	 * 
	 * @return 	String o conte�do da configura��o
	 */
	public abstract String getConteudoConfiguracao() ;
	/**
	 * Retorna o conte�do da configura��o 
	 * Dependendo do tipo da configura��o, pode ser um id, um e-mail, uma f�rmula, etc. 
	 * 
	 * @return 	String o conte�do da configura��o
	 */
	public abstract String getSiglaConteudoConfiguracao() ;
	public abstract void setSiglaConteudoConfiguracao(String p_strConteudo) ;
	/**
	 * Retorna a sigla do conteudo de uma configura��o
	 * Dependendo do tipo da configura��o, � a sigla da pessoa, da configura��o , etc. 
	 * 
	 * @return 	String a sigla do conte�do da configuracao 
	 */
	public abstract Long getIdConteudoConfiguracao() ;
	public abstract void setIdConteudoConfiguracao(Long p_lngId) ;
	/**
	 * Retorna o id do conteudo de uma configura��o
	 * Dependendo do tipo da configura��o, � a descri��o da pessoa, da configura��o , etc. 
	 * 
	 * @return 	String a descri��o do conte�do da configuracao 
	 */
	public abstract String getDescricaoConteudoConfiguracao();
	public abstract void setDescricaoConteudoConfiguracao(String p_strDescricao);
	/**
	 * Retorna o id do conteudo de uma configura��o
	 * Dependendo do tipo da configura��o, � o id da pessoa, da configura��o , etc. 
	 * 
	 * @return 	Long o id do conte�do da configuracao 
	 */
	public abstract TipoConfiguracaoGrupoEnum obterTipoPadrao();
}
