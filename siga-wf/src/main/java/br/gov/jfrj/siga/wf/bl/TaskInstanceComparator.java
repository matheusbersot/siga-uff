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
package br.gov.jfrj.siga.wf.bl;

import java.util.Comparator;

import org.jbpm.taskmgmt.exe.TaskInstance;

public class TaskInstanceComparator implements Comparator<TaskInstance> {

	/**
	 * Compara dois objetos TaskInstance. Retorna zero (0) se os objetos s�o
	 * "iguais", retorna (1) se a PRIORIDADE ou ID do primeiro objeto (o1) for
	 * maior doque o segundo objeto (o2). Retorna (-1), caso contr�rio. ESTE
	 * C�DIGO EST� DUPLICADO EM WfDocumentoAction.java.
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
