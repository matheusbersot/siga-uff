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
package br.gov.jfrj.siga.wf.util;

import java.util.List;
import java.util.Map;

import org.jbpm.context.def.VariableAccess;
import org.jbpm.graph.exe.ExecutionContext;
import org.jbpm.mail.Mail;
import org.jbpm.taskmgmt.def.TaskController;

import br.gov.jfrj.siga.wf.bl.Wf;

/**
 * Classe que representa o servi�o de e-mail. Esta classe � definida em
 * siga-wf/src/jbpm.cfg.xml.
 * 
 * @author kpf
 * 
 */
public class WfMail extends Mail {

	private Long tiId;
	private List<VariableAccess> docAccessVariables;
	private Map docVariables;

	private static final long serialVersionUID = -1530708539893196841L;

	/**
	 * Retorna o texto do e-mail. Esse m�todo inclui automaticamente rodap� com
	 * informa��es da tarefa correspondente ao e-mail.
	 */
	@Override
	public String getText() {
		String rodape = "\n\n----------\n";
		if (tiId != null) {
			rodape += "Link para a tarefa no SIGA-WF: " + Wf.getInstance().getProp().getMailLinkTarefa()
					+ this.tiId + "\n";
		}

		if (docAccessVariables != null) {
			for (VariableAccess v : docAccessVariables) {
				if (v.getMappedName().startsWith("doc_") && !v.isWritable()
						&& v.isReadable()
						&& docVariables.get(v.getMappedName()) != null) {
					
					rodape += "Link para o "
							+ v.getVariableName()
							+ " no SIGA: " + Wf.getInstance().getProp().getMailLinkDocumento()
							+ docVariables.get(v.getMappedName()) + "\n";
				}

			}
		}
		rodape += "Mensagem gerada automaticamente pelo sistema SIGA.";
		return super.getText() + rodape;
	}


	/**
	 * Ao iniciar a manipula��o do e-mail, esse m�todo captura as informa��es
	 * sobre os documentos do SIGA-DOC que se referem � tarefa que enviou o
	 * e-mail.
	 */
	@Override
	public void execute(ExecutionContext executionContext) {
		if (executionContext.getTaskInstance() != null) {
			tiId = executionContext.getTaskInstance().getId();
			TaskController tc = executionContext.getTaskInstance().getTask()
					.getTaskController();
			if (tc != null) {
				this.docAccessVariables = executionContext.getTaskInstance()
						.getTask().getTaskController().getVariableAccesses();

				this.docVariables = executionContext.getTaskInstance()
						.getContextInstance().getVariables();
			}

		}
		super.execute(executionContext);
	}

	/**
	 * Envia o e-mail.
	 */
	@Override
	public void send() {
		// Para debugar o workflow, o ideal e desabilitar os emails e apenas
		// log�-los no System.out.
//		super.getBccRecipients().add("xxx@xxx.com.br");
		super.send();
		// System.out.println(this.toString());
	}

}
