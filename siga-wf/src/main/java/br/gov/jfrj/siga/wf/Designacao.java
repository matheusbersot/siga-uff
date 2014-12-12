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
 * Esta classe representa uma designa��o de responsabilidade e � utilizada na view pesquisarDesigna��o.jsp <br/> 
 * 
 * Designa��o de Tarefas (Cadastro de Responsabilidades)

1.CRIA��O
2.OBJETIVO
3.UTILIZA��O
4.COMPONENTES
5.BANCO DE DADOS
6.FUNCIONAMENTO B�SICO
7.OBSERVA��ES

1.CRIA��O
	Funcionalidade iniciada na itera��o 05/10/2009 a 16/10/2009 do SIGAWF.
	
2.OBJETIVO
	Configurar quem s�o os respons�veis por cada tarefa do processo. 

3.UTILIZA��O
	Acesse a op��o "Designar Tarefas" e o processo desejado no quadro de tarefas 
	localizado na p�gina inicial do SIGA-DOC. 

4.COMPONENTES
	4.1 pesquisarDesignacao.jsp (/sigawf/WebContent/WEB-INF/page/workflow/)
		Interface do usu�rio de configura��o e pesquisa de desgna��es
		
	4.2 WfDesignacaoAction.java (/sigawf/src/br/gov/jfrj/siga/wf/webwork/action/)
		Executa a l�gica da funcionalidade de designa��o de resposabilidades. 
		Possui uma classe interna que define o tipo de respons�vel.
		
	4.3 Designacao.java (/siga-wf/src/br/gov/jfrj/siga/wf/)
		Representa uma designa��o de responsabilidade
		
	4.4 xwork.xml (/sigawf/src/)
		Configura��o do webwork que realiza a conex�o entre a interface do usu�rio e 
		l�gica da designa��o de tarefas.
		
	4.5 inbox.jsp (/sigawf/WebContent/WEB-INF/page/workflow/)
		Interface de acesso � funcionalidade

5.BANCO DE DADOS
	
	5.1 CORPORATIVO.CP_CONFIGURACAO
		Registra as informa��es comuns entre configura��es. 
		Determina se uma configura��o est� ativa ou n�o dentre outras informa��es.

	5.2 SIGAWF.WF_CONFIGURACAO
		Registra a configura��o da designa��o da tarefa

6.FUNCIONAMENTO B�SICO
       
	6.1 PESQUISA
       Quando o usu�rio acessa a p�gina inicial, seleciona a op��o "Designar Tarefas" 
       e o processo desejado, o inbox.jsp chama a action pesquisarDesigna��o configurada 
       no xwork.xml. Nesse momento o m�todo WfDesignacaoAction.aPesquisarDesignacao() � 
       chamado e retorna a p�gina pesquisarDesignacao.jsp. A p�gina pesquisarDesignacao.jsp 
       l� as listas de designa��o (com raias e sem raias) e a p�gina � desenhada na tela do 
       usu�rio. 
       
	6.2 GRAVACAO
       O usu�rio define as responsabilidades atrav�s dos componentes de sele��o (sele��o.tag) 
       e clica no bot�o gravar que ativa a action gravarDesignacao que, por sua vez, chama o 
       m�todo WfDesignacaoAction.aGravarDesignacao(). Este m�todo grava as designa��es e retorna 
       a p�gina pesquisarDesignacao.jsp com as informa��es gravadas.

7.OBSERVA��ES       
       Maiores detalhes s�o encontrados no pr�prio c�digo dos componentes respons�veis 
       pela funcionalidade de desigan��o de tarefas.  
 * 
 * @author kpf
 * 
 */
public class Designacao {
	private String procedimento;
	private String raia;
	private Long Id;
	private String tarefa;
	private String nomeDoNo;
	private String expressao;
	private DpPessoa ator;
	private DpLotacao lotaAtor;
	private Integer tipoResponsavel;

	/**
	 * Retorna o tipo de respons�vel desigando para a tarefa.
	 * 
	 * @return retorna 0 para INDEFINIDO (Sem designa��o), retorna 1 para
	 *         MATRICULA (Matr�cula de uma pessoa [DpPessoa]), retorna 2 para
	 *         LOTACAO (Sigla de uma lota��o) retorna 3 para LOTA_SUP (Lota��o
	 *         hierarquicamente superior da pessoa designada na tarefa anterior)
	 *         retorna 4 para SUP_HIER (Superior hier�rquico da pessoa designada
	 *         na tarefa anterior)
	 */
	public Integer getTipoResponsavel() {
		return tipoResponsavel;
	}

	/**
	 * Informa o tipo de respons�vel desigando para a tarefa.
	 * 
	 * @return retorna 0 para INDEFINIDO (Sem designa��o), retorna 1 para
	 *         MATRICULA (Matr�cula de uma pessoa [DpPessoa]), retorna 2 para
	 *         LOTACAO (Sigla de uma lota��o) retorna 3 para LOTA_SUP (Lota��o
	 *         hierarquicamente superior da pessoa designada na tarefa anterior)
	 *         retorna 4 para SUP_HIER (Superior hier�rquico da pessoa designada
	 *         na tarefa anterior)
	 */
	public void setTipoResponsavel(Integer tipoResponsavel) {
		this.tipoResponsavel = tipoResponsavel;
	}

	/**
	 * Retorna o procedimento referente � designa��o.
	 * 
	 * @return
	 */
	public String getProcedimento() {
		return procedimento;
	}

	/**
	 * Informa o procedimento referente � designa��o.
	 * 
	 * @param procedimento
	 */
	public void setProcedimento(String procedimento) {
		this.procedimento = procedimento;
	}

	/**
	 * Retorna a raia referente � designa��o.
	 * 
	 * @return
	 */
	public String getRaia() {
		return raia;
	}

	/**
	 * Informa a raia referente � designa��o.
	 * 
	 * @param raia
	 */
	public void setRaia(String raia) {
		this.raia = raia;
	}

	/**
	 * Retorna a tarefa referente � designa��o.
	 * 
	 * @return
	 */
	public String getTarefa() {
		return tarefa;
	}

	/**
	 * Informa a tarefa referente � designa��o.
	 * 
	 * @param tarefa
	 */
	public void setTarefa(String tarefa) {
		this.tarefa = tarefa;
	}

	/**
	 * Retorna a express�o de uma designa��o. As express�es existentes s�o :
	 * "previous --> group() --> superior_group" para Lota��o superior e
	 * "previous --> chief" para superior hier�rquico.
	 * 
	 * @return
	 */
	public String getExpressao() {
		return expressao;
	}

	/**
	 * Informa a express�o de uma designa��o. As express�es existentes s�o :
	 * "previous --> group() --> superior_group" para Lota��o superior e
	 * "previous --> chief" para superior hier�rquico.
	 * @param expressao
	 */
	public void setExpressao(String expressao) {
		this.expressao = expressao;
	}

	/**
	 * Retorna o ator referente � designa��o.
	 * @return
	 */
	public DpPessoa getAtor() {
		return ator;
	}

	/**
	 * Informa o ator referente � designa��o. 
	 * @param ator
	 */
	public void setAtor(DpPessoa ator) {
		this.ator = ator;
	}

	/**
	 * Retorna a lota��o referente � designa��o.
	 * @return
	 */
	public DpLotacao getLotaAtor() {
		return lotaAtor;
	}

	/**
	 * Informa a lota��o referente � designa��o.
	 * @param lotaAtor
	 */
	public void setLotaAtor(DpLotacao lotaAtor) {
		this.lotaAtor = lotaAtor;
	}

	/**
	 * Retorna o ID da designa��o.
	 * @return
	 */
	public Long getId() {
		return Id;
	}

	/**
	 * Informa o ID da designa��o.
	 * @param id
	 */
	public void setId(Long id) {
		Id = id;
	}

	public void setNomeDoNo(String nomeDoNo) {
		this.nomeDoNo = nomeDoNo;
	}

	public String getNomeDoNo() {
		return nomeDoNo;
	}

}
