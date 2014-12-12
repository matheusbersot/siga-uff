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
 * Criado em 23/11/2005
 */

package br.gov.jfrj.webwork.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import br.gov.jfrj.siga.dp.DpPessoa;

import com.opensymphony.xwork.Action;

public class ExGadgetAction extends ExActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1630775520737927455L;
	private List listEstados;
	private ExMobilSelecao documentoViaSel;
	private Integer idTpFormaDoc;
	private Boolean apenasQuadro;

	public Boolean getApenasQuadro() {
		return apenasQuadro;
	}

	public void setApenasQuadro(Boolean apenasQuadro) {
		this.apenasQuadro = apenasQuadro;
	}

	public Integer getIdTpFormaDoc() {
		return idTpFormaDoc;
	}

	public void setIdTpFormaDoc(Integer idTpMarca) {
		this.idTpFormaDoc = idTpMarca;
	}

	public ExMobilSelecao getDocumentoViaSel() {
		return documentoViaSel;
	}

	public void setDocumentoViaSel(final ExMobilSelecao documentoViaSel) {
		this.documentoViaSel = documentoViaSel;
	}

	@Override
	public String execute() throws Exception {
		if (getIdTpFormaDoc() == null || getIdTpFormaDoc() == 0)
			throw new Exception(
					"C�digo do tipo de marca (Processos ou Expedientes) n�o foi informado");
		listEstados = dao().consultarPaginaInicial(getTitular(),
				getLotaTitular(), getIdTpFormaDoc());
		
		if (param("idTpMarcadorExcluir") != null) {
			String as[] = param("idTpMarcadorExcluir").split(",");
			Set<Integer> excluir = new HashSet<Integer>();
			for (String s : as) {
				excluir.add(Integer.valueOf(s));
			}
			List listEstadosReduzida = new ArrayList<Object[]>();
			for (Object o : listEstados) {
				if (!excluir.contains((Integer) ((Object[]) o)[0])) {
					listEstadosReduzida.add(o);
				}
			}
			listEstados = listEstadosReduzida;
		}

		if (super.getTitular() == null) 
			throw new Exception(
					"Titular nulo, verificar se usu�rio est� ativo no RH");
		super.getRequest().setAttribute(
				"_cadastrante",
				super.getTitular().getSigla()
						+ "@"
						+ super.getLotaTitular().getOrgaoUsuario()
								.getSiglaOrgaoUsu()
						+ super.getLotaTitular().getSigla());
		return Action.SUCCESS;
	}

	public String test() throws Exception {
		DpPessoa pes = daoPes(param("matricula"));
		if (getIdTpFormaDoc() == null || getIdTpFormaDoc() == 0)
			setIdTpFormaDoc(1);
		setTitular(pes);
		setLotaTitular(pes.getLotacao());
		return execute();
	}

	public List getListEstados() {
		return listEstados;
	}

	public void setListEstados(final List listEstados) {
		this.listEstados = listEstados;
	}

}
