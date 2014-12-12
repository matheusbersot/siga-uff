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
package br.gov.jfrj.siga.wf.webwork.action;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeMap;

import org.jbpm.context.def.VariableAccess;
import org.jbpm.db.GraphSession;
import org.jbpm.taskmgmt.exe.TaskInstance;

import br.gov.jfrj.siga.wf.bl.Wf;
import br.gov.jfrj.siga.wf.util.WfContextBuilder;

import com.opensymphony.xwork.Action;

/**
 * Classe repons�vel pelas actions relativas � documentos.
 * 
 * @author kpf
 * 
 */
public class WfDocumentoAction extends WfSigaActionSupport {

	protected String sigla;

	protected Integer maxvia;

	protected Map<String, List<WfTaskVO>> mobilMap = new TreeMap<String, List<WfTaskVO>>();

	protected SortedSet<TaskInstance> taskInstances;

	/**
	 * Classe utilizada para comparar duas TaskInstance.
	 * 
	 * @author kpf
	 * 
	 */
	private class TaskInstanceComparator implements Comparator<TaskInstance> {

		/**
		 * Compara dois objetos TaskInstance. Retorna zero (0) se os objetos s�o
		 * "iguais", retorna (1) se a PRIORIDADE ou ID do primeiro objeto (o1)
		 * for maior doque o segundo objeto (o2). Retorna (-1), caso contr�rio.
		 * ESTE C�DIGO EST� DUPLICADO EM WfInboxAction.java.
		 */
		public int compare(TaskInstance o1, TaskInstance o2) {
			if (o1.getPriority() > o2.getPriority())
				return 1;
			if (o1.getPriority() < o2.getPriority())
				return -1;
			if (o1.getId() > o2.getId())
				return 1;
			if (o1.getId() < o2.getId())
				return -1;
			return 0;
		}

	}

	/**
	 * Retorna o mapa de mobil.
	 * 
	 * @return
	 */
	public Map<String, List<WfTaskVO>> getMobilMap() {
		return mobilMap;
	}

	/**
	 * Define o mapa de mobil.
	 * 
	 * @param mobilMap
	 */
	public void setMobilMap(Map<String, List<WfTaskVO>> mobilMap) {
		this.mobilMap = mobilMap;
	}

	/**
	 * Verifica se as tarefas que est�o designadas para o usu�rio est�o
	 * associadas a documentos do SIGA-DOC (por interm�dio da vari�vel iniciada
	 * com o prefixo "doc_". Se estiver, chama o m�todo addTask(). Este m�todo
	 * executado quando a action "doc.action" for chamada.
	 */
	public String execute() throws Exception {

		GraphSession graph = WfContextBuilder.getJbpmContext()
				.getGraphSession();

		// taskInstances = WfInboxAction.getTaskList(getCadastrante(),
		// getTitular(), getLotaTitular());
		taskInstances = Wf.getInstance().getBL().getTaskList(sigla);
		for (TaskInstance ti : taskInstances) {
			if (ti.getTask().getTaskController() != null) {
				List<VariableAccess> variableAccesses = (List<VariableAccess>) ti
						.getTask().getTaskController().getVariableAccesses();

				for (VariableAccess _variable : variableAccesses) {
					String name = _variable.getMappedName();
					if (name != null && name.startsWith("doc_")) {
						String value = (String) ti.getContextInstance()
								.getVariable(name);
						if (value != null) {
							if (value.startsWith(sigla)) {
								addTask(ti, value);
							}
						}
					}
				}
			}
		}

		return Action.SUCCESS;
	}

	/**
	 * Monta o objeto WfTaskVO (view object, que ser� usado na interface do
	 * usu�rio).
	 * 
	 * @param taskInstance
	 * @param variableAccesses
	 * @param siglaDoc
	 * @throws Exception
	 */
	private void addTask(TaskInstance taskInstance, String siglaDoc)
			throws Exception {
		WfTaskVO task = new WfTaskVO(taskInstance, sigla, getTitular(),
				getLotaTitular());
		if (!mobilMap.containsKey(siglaDoc)) {
			mobilMap.put(siglaDoc, new ArrayList<WfTaskVO>());
		}
		List<WfTaskVO> tasks = mobilMap.get(siglaDoc);
		tasks.add(task);
	}

	/**
	 * Retorna a sigla.
	 * 
	 * @return
	 */
	public String getSigla() {
		return sigla;
	}

	/**
	 * Define a sigla.
	 * 
	 * @param sigla
	 */
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	/**
	 * Retona o n�mero m�ximo de vias.
	 * 
	 * @return
	 */
	public Integer getMaxvia() {
		return maxvia;
	}

	/**
	 * Define o n�mero m�ximo de vias.
	 * 
	 * @param maxvia
	 */
	public void setMaxvia(Integer maxvia) {
		this.maxvia = maxvia;
	}

}
