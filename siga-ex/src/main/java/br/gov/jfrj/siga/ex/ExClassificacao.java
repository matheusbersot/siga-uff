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
 * Created Mon Nov 14 13:36:35 GMT-03:00 2005 by MyEclipse Hibernate Tool.
 */
package br.gov.jfrj.siga.ex;

import java.io.Serializable;
import java.util.Set;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.ex.util.MascaraUtil;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.model.Assemelhavel;
import br.gov.jfrj.siga.model.Selecionavel;

/**
 * A class that represents a row in the 'EX_CLASSIFICACAO' table. This class may
 * be customized as it is never re-generated after being created.
 */
public class ExClassificacao extends AbstractExClassificacao implements
		Serializable, Selecionavel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5783951238385826556L;

	/**
	 * Simple constructor of ExClassificacao instances.
	 */
	public ExClassificacao() {
	}


	public Long getId() {
		return getIdClassificacao();
	}

	private String Zeros(final long l, final int i) {
		String s = Long.toString(l);
		while (s.length() < i)
			s = "0" + s;
		return s;
	}

	/**
	 * Verifica se uma classifica��o � do tipo intermedi�ria.
	 * 

	 * @return Verdadeiro caso a classifica��o seja do tipo intermedi�ria e
	 *         Falso caso a classifica��o n�o seja do tipo intermedi�ria.
	 * 
	 */
	public boolean isIntermediaria() throws AplicacaoException {
		if (getExViaSet() == null) {
			return true;
		}
		if (getExViaSet() != null && getExViaSet().size() == 1) {
			ExVia via = (ExVia) (getExViaSet().toArray()[0]);
			if (via.getCodVia() == null) {
				return true;
			}
		}
		if (getExViaSet() != null && getExViaSet().size() == 0) {
			return true;
		}
		return false;
	}



	/**
	 * Retorna a sigla de uma classifica��o.
	 * 
	 */
	public String getSigla() {
		return getCodificacao();
	}

	/**
	 * Informa a sigla de uma classifica��o.
	 * 
	 * @param sigla
	 * 
	 */
	public void setSigla(final String sigla) {
		setCodificacao(sigla);
	}

	/**


	 * Retorna a descri��o de uma classifica��o. A descri��o de uma
	 * classifica��o � formada pela descri��o do Assunto, da classe e da
	 * subclasse.
	 * 
	 * @param sigla
	 * 
	 */
	public String getDescricao() {
		return ExDao.getInstance().consultarDescricaoExClassificacao(this);
	}

	/**
	 * Retorna a sigla e a descri��o simples, ou seja, n�o trazendo a informa��o
	 * completa sobre a hierarquia a que a classifica��o pertence.
	 * 
	 * @param sigla
	 * 
	 */
	public String getDescricaoSimples() {
		return getSigla() + " - " + getDescrClassificacao();
	}

	public String getDescricaoCompleta() {
		return getSigla() + " - " + getDescricao();
	}

	public String getNome() {
		return getDescrClassificacao();
	}

	public Integer getNumVias() {
		return getExViaSet().size();
	}

	public String getDestinacoesFinais() {
		return "";
	}


	public ExClassificacao getClassificacaoAtual() {
		ExClassificacao classIni = getClassificacaoInicial();
		if (classIni != null) {
			Set<ExClassificacao> setClassificacoes = classIni.getClassificacoesPosteriores();
			if (setClassificacoes != null)
				for (ExClassificacao c : setClassificacoes)
					return c;
		}
		return this;
	}


	/**
	 * Verifica se uma classifica��o est� fechada.
	 * 

	 * @return Verdadeiro se a classifica��o est� fechado e falso caso
	 *         contr�rio.
	 * 
	 */
	public boolean isFechada() {
		if (this.getHisDtFim() == null)


			return false;

		return getAtual().getHisDtFim() != null;
	}
	
	public ExClassificacao getAtual() {
		ExClassificacao ini = getClassificacaoInicial();
		if (ini == null)
			ini = this;
		Set<ExClassificacao> set = ini.getClassificacoesPosteriores();
		if (set != null)
			for (ExClassificacao c : set)
				return c;
		return this;
	}

	public void setId(Long id) {
		setIdClassificacao(id);


	}

	public boolean semelhante(Assemelhavel obj, int profundidade) {
		return false;
	}


	public int getNivel() {
		return MascaraUtil.getInstance().calcularNivel(this.getCodificacao());
	}


	@Override
	public String toString() {
		return getCodificacao() + " " + getDescricao();
	}
}
