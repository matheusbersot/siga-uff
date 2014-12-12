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

import java.util.ArrayList;

import br.gov.jfrj.siga.cp.CpTipoGrupo;

/**
 * Enumerador para os tipos de configura��o permitidas para os grupos
 */
public enum TipoConfiguracaoGrupoEnum {
	PESSOA(0, "Pessoa", new int[] { CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO,
			CpTipoGrupo.TIPO_GRUPO_PERFIL_DE_ACESSO,
			CpTipoGrupo.TIPO_GRUPO_PERFIL_JEE }), LOTACAO(1, "Lota��o",
			new int[] { CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO,
					CpTipoGrupo.TIPO_GRUPO_PERFIL_DE_ACESSO }), CARGO(2,
			"Cargo", new int[] { CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO,
					CpTipoGrupo.TIPO_GRUPO_PERFIL_DE_ACESSO }), FUNCAOCONFIANCA(
			3, "Fun��o de Confian�a", new int[] {
					CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO,
					CpTipoGrupo.TIPO_GRUPO_PERFIL_DE_ACESSO }), EMAIL(4,
			"Email", new int[] { CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO }), FORMULA(
			5, "F�rmula", new int[] { CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO });
	private int codigo;
	private String descricao;
	private int[] idsDeTiposDeGrupo; // 1 - Perfil de acesso, 2 - Pasta

	/**
	 * Obt�m os valores do enumerador para um dado tipo de grupo
	 * 
	 * @param p_ctgTipoGrupo
	 *            CpTipoGrupo O tipo de grupo para o qual se quer os tipos de
	 *            configura��o
	 * @return ArrayList<TipoConfiguracaoGrupoEnum> a lista com os
	 *         TipoConfiguracaoGrupoEnum
	 * 
	 */
	public static ArrayList<TipoConfiguracaoGrupoEnum> valoresParaTipoDeGrupo(
			CpTipoGrupo p_ctgTipoGrupo) {
		ArrayList<TipoConfiguracaoGrupoEnum> t_arlTipo = new ArrayList<TipoConfiguracaoGrupoEnum>();
		for (TipoConfiguracaoGrupoEnum t_enmCfg : TipoConfiguracaoGrupoEnum
				.values()) {
			for (Integer t_intIdTipoGrupo : t_enmCfg.getIdsDeTiposDeGrupo()) {
				if (p_ctgTipoGrupo.getIdTpGrupo().equals(t_intIdTipoGrupo)) {
					t_arlTipo.add(t_enmCfg);
				}
			}
		}
		return t_arlTipo;
	}

	/**
	 * Obt�m um TipoConfiguracaoGrupoEnum para um determinado tipo de grupo e
	 * c�digo caso n�o exista nenhum TipoConfiguracaoGrupoEnum que atenda as
	 * condi��es retorna nulo
	 * 
	 * @param p_ctgTipoGrupo
	 *            CpTipoGrupo O tipo de grupo para o qual se quer os tipos de
	 *            configura��o
	 * @param p_intCodigo
	 *            int O c�digo do TipoConfiguracaoGrupoEnum
	 * @return TipoConfiguracaoGrupoEnum
	 * 
	 */
	public static TipoConfiguracaoGrupoEnum obterPara(
			CpTipoGrupo p_ctgTipoGrupo, int p_intCodigo) {
		for (TipoConfiguracaoGrupoEnum t_enmCfg : TipoConfiguracaoGrupoEnum
				.valoresParaTipoDeGrupo(p_ctgTipoGrupo)) {
			if (t_enmCfg.codigo == p_intCodigo) {
				return t_enmCfg;
			}
		}
		return null;
	}

	/**
	 * Construtor
	 */
	TipoConfiguracaoGrupoEnum(int p_intCodigo, String p_strDescricao,
			int[] p_arr1IntUsoEmTiposDeGrupo) {
		this.codigo = p_intCodigo;
		this.descricao = p_strDescricao;
		this.idsDeTiposDeGrupo = p_arr1IntUsoEmTiposDeGrupo;
	}

	/**
	 * Obt�m o c�digo do tipo d grupo
	 * 
	 * @return o c�digo
	 */
	public int getCodigo() {
		return codigo;
	}

	/**
	 * Obt�m a descri��o do tipo de grupo
	 * 
	 * @return a descri��o
	 */
	public String getDescricao() {
		return descricao;
	}

	/**
	 * Obt�m os ids de tipo de grupo que o TipoConfiguracaoGrupoEnum pode vir a
	 * atender
	 * 
	 * return array com os ids dos tipos de grupo
	 */
	public int[] getIdsDeTiposDeGrupo() {
		return idsDeTiposDeGrupo;
	}
}
