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
 * Criado em  21/12/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.siga.dp;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.util.Collections;
import java.util.ListIterator;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.ColumnResult;
import javax.persistence.Entity;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQuery;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Formula;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.model.Assemelhavel;
import br.gov.jfrj.siga.model.Historico;
import br.gov.jfrj.siga.model.Selecionavel;
import br.gov.jfrj.siga.sinc.lib.Desconsiderar;
import br.gov.jfrj.siga.sinc.lib.Sincronizavel;
import br.gov.jfrj.siga.sinc.lib.SincronizavelSuporte;

@Table(name = "DP_PESSOA", schema = "CORPORATIVO")
@Entity
@SqlResultSetMapping(name = "scalar", columns = @ColumnResult(name = "dt"))
@NamedNativeQuery(name = "consultarDataEHoraDoServidor", query = "SELECT sysdate dt FROM dual", resultSetMapping = "scalar")
@NamedQuery(name = "consultarPorIdInicialDpPessoa", query = "select pes from DpPessoa pes where pes.idPessoaIni = :idPessoaIni and pes.dataFimPessoa = null")
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class DpPessoa extends AbstractDpPessoa implements Serializable,
		Selecionavel, Historico, Sincronizavel, Comparable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5743631829922578717L;

	@Formula(value = "REMOVE_ACENTO(NOME_PESSOA)")
	@Desconsiderar
	private String nomePessoaAI;

	public DpPessoa() {

	}

	public Long getIdLotacao() {
		if (getLotacao() == null)
			return null;
		return getLotacao().getIdLotacao();
	}

	public boolean isFechada() {
		if (getDataFimPessoa() == null)
			return false;
		Set<DpPessoa> setPessoas = getPessoaInicial().getPessoasPosteriores();
		if (setPessoas != null)
			for (DpPessoa l : setPessoas)
				if (l.getDataFimPessoa() == null)
					return false;

		return true;
	}

	public Long getIdCargo() {
		if (getCargo() == null)
			return null;
		return getCargo().getIdCargo();
	}

	public Long getIdFuncaoConfianca() {
		if (getFuncaoConfianca() == null)
			return null;
		return getFuncaoConfianca().getIdFuncao();
	}

	public String iniciais(String s) {
		final StringBuilder sb = new StringBuilder(10);
		boolean f = true;

		s = s.replace(" E ", " ");
		s = s.replace(" DA ", " ");
		s = s.replace(" DE ", " ");
		s = s.replace(" DO ", " ");

		for (int i = 0; i < s.length(); i++) {
			final char c = s.charAt(i);
			if (f) {
				sb.append(c);
				f = false;
			}
			if (c == ' ') {
				f = true;
			}
		}
		return sb.toString();
	}

	public Long getId() {
		return super.getIdPessoa();
	}

	public void setId(Long id) {
		setIdPessoa(id);
	}

	public String getSigla() {
		String sesbPessoa = getSesbPessoa();
		Long matricula = getMatricula();
		
		return sesbPessoa != null && matricula != null ? getSesbPessoa() + getMatricula().toString() : "";
	}

	public String getIniciais() {
		// return iniciais(getNomePessoa());
		return getSigla();
	}

	public String getDescricao() {
		return getNomePessoa();
	}

	public String getDescricaoIniciaisMaiusculas() {
		return Texto.maiusculasEMinusculas(getDescricao());
	}

	public void setSigla(final String sigla) {
		final Pattern p1 = Pattern.compile("^([A-Za-z][A-Za-z0-9])([0-9]+)");
		final Matcher m = p1.matcher(sigla);
		if (m.find()) {
			setSesbPessoa(m.group(1).toUpperCase());
			setMatricula(Long.parseLong(m.group(2)));
		}
	}

	public String getNomePessoaAI() {
		return nomePessoaAI;
	}

	public void setNomePessoaAI(String nomePessoaAI) {
		this.nomePessoaAI = nomePessoaAI;
	}

	public boolean equivale(Object other) {
		if (other == null)
			return false;
		return this.getIdInicial().longValue() == ((DpPessoa) other)
				.getIdInicial().longValue();
	}

	public Long getIdInicial() {
		return getIdPessoaIni();
	}

	public String getFuncaoString() {
		if (getFuncaoConfianca() != null)
			return getFuncaoConfianca().getNomeFuncao();
		return getCargo().getNomeCargo();
	}

	public String getPadraoReferenciaInvertido() {
		if (getPadraoReferencia() != null && !getPadraoReferencia().equals("")) {
			//Caso o padr�o de refer�ncia n�o esteja no formado utilizado pela SJRJ.
			//Retorna o padr�o cadastrado no BD sem inverter.
			try {
				String partes[] = getPadraoReferencia().split("-");
				String partesConcat = partes[1] + "-" + partes[0];
				if (partes.length > 2)
					partesConcat += "-" + partes[2];
				return partesConcat;
			} catch (Exception e) {
				return getPadraoReferencia();
			}
		} else
			return "";
	}

	@Override
	public String getSiglaCompleta() {
		return getSigla();
	}

	// M�todos necess�rios para ser "Sincronizavel"
	//
	public Date getDataFim() {
		return getDataFimPessoa();
	}

	public Date getDataInicio() {
		return getDataInicioPessoa();
	}

	public String getDescricaoExterna() {
		return getDescricao();
	}

	public String getIdExterna() {
		return getIdePessoa();
	}

	public String getLoteDeImportacao() {
		return getOrgaoUsuario().getId().toString();
	}

	public int getNivelDeDependencia() {
		return SincronizavelSuporte.getNivelDeDependencia(this);
	}

	public boolean semelhante(Assemelhavel obj, int nivel) {
		return SincronizavelSuporte.semelhante(this, obj, nivel);
	}

	public void setDataFim(Date dataFim) {
		setDataFimPessoa(dataFim);
	}

	public void setDataInicio(Date dataInicio) {
		setDataInicioPessoa(dataInicio);
	}

	public void setIdExterna(String idExterna) {
		setIdePessoa(idExterna);
	}

	public void setIdInicial(Long idInicial) {
		setIdPessoaIni(idInicial);
	}

	public void setLoteDeImportacao(String loteDeImportacao) {
	}

	public boolean isBloqueada() throws AplicacaoException {
		return Cp.getInstance().getComp().isPessoaBloqueada(this);
	}

	//
	// Fun��es utilizadas nas f�rmulas de inclus�o em grupos de email.
	//

	public boolean tipoLotacaoSiglaIgual(String s) {
		if (this.getLotacao() == null)
			return false;
		if (this.getLotacao().getCpTipoLotacao() == null)
			return false;
		return this.getLotacao().getCpTipoLotacao().getSiglaTpLotacao()
				.toLowerCase().equals(s.toLowerCase());
	}

	public boolean tipoLotacaoSiglaContem(String s) {
		if (this.getLotacao() == null)
			return false;
		if (this.getLotacao().getCpTipoLotacao() == null)
			return false;
		return contem(this.getLotacao().getCpTipoLotacao().getSiglaTpLotacao(),
				"", s);
	}

	public boolean tipoLotacaoDescricaoContem(String s) {
		if (this.getLotacao() == null)
			return false;
		if (this.getLotacao().getCpTipoLotacao() == null)
			return false;
		return contem("", this.getLotacao().getCpTipoLotacao()
				.getDscTpLotacao(), s);
	}

	public boolean tipoLotacaoContem(String s) {
		if (this.getLotacao() == null)
			return false;
		if (this.getLotacao().getCpTipoLotacao() == null)
			return false;
		return contem(this.getLotacao().getCpTipoLotacao().getSiglaTpLotacao(),
				this.getLotacao().getCpTipoLotacao().getDscTpLotacao(), s);
	}

	public boolean lotacaoSiglaIgual(String s) {
		if (this.getLotacao() == null)
			return false;
		return this.getLotacao().getSigla().toLowerCase()
				.equals(s.toLowerCase());
	}

	public boolean lotacaoSiglaContem(String s) {
		if (this.getLotacao() == null)
			return false;
		return contem(this.getLotacao().getSigla(), "", s);
	}

	public boolean lotacaoDescricaoContem(String s) {
		if (this.getLotacao() == null)
			return false;
		return contem("", this.getLotacao().getDescricao(), s);
	}

	public boolean lotacaoContem(String s) {
		if (this.getLotacao() == null)
			return false;
		return contem(this.getLotacao().getSigla(), this.getLotacao()
				.getDescricao(), s);
	}

	public boolean cargoSiglaIgual(String s) {
		if (this.getCargo() == null)
			return false;
		return this.getCargo().getSigla().toLowerCase().equals(s.toLowerCase());
	}

	public boolean cargoSiglaContem(String s) {
		if (this.getCargo() == null)
			return false;
		return contem(this.getCargo().getSigla(), "", s);
	}

	public boolean cargoDescricaoContem(String s) {
		if (this.getCargo() == null)
			return false;
		return contem("", this.getCargo().getDescricao(), s);
	}

	public boolean cargoContem(String s) {
		if (this.getCargo() == null)
			return false;
		return contem(this.getCargo().getSigla(), this.getCargo()
				.getDescricao(), s);
	}

	public boolean funcaoSiglaIgual(String s) {
		if (this.getFuncaoConfianca() == null)
			return false;
		return this.getFuncaoConfianca().getSigla().toLowerCase()
				.equals(s.toLowerCase());
	}

	public boolean funcaoSiglaContem(String s) {
		if (this.getFuncaoConfianca() == null)
			return false;
		return contem(this.getFuncaoConfianca().getSigla(), "", s);
	}

	public boolean funcaoDescricaoContem(String s) {
		if (this.getFuncaoConfianca() == null)
			return false;
		return contem("", this.getFuncaoConfianca().getDescricao(), s);
	}

	public boolean funcaoContem(String s) {
		if (this.getFuncaoConfianca() == null)
			return false;
		return contem(this.getFuncaoConfianca().getSigla(), this
				.getFuncaoConfianca().getDescricao(), s);
	}

	private boolean contem(String sigla, String descricao, String s) {
		s = s.toLowerCase();
		return sigla.toLowerCase().contains(s)
				|| descricao.toLowerCase().contains(s);
	}

	public DpPessoa getPessoaAtual() {
		DpPessoa pesIni = getPessoaInicial();
		Set<DpPessoa> setPessoas = pesIni.getPessoasPosteriores();
		if (setPessoas != null)
			for (DpPessoa p : setPessoas)
				return p;
		return this;
	}

	/**
	 * retorna se ativo na data
	 * 
	 * @param dt
	 *            * data quando ser saber se estava ativa
	 * @return true or false
	 */
	public boolean ativaNaData(Date dt) {
		if (dt == null)
			return this.getDataFim() == null;
		if (dt.before(this.getDataInicio()))
			return false;
		// dt >= DtIni
		if (this.getDataFim() == null)
			return true;
		if (dt.before(this.getDataFim()))
			return true;
		return false;
	}

	public String getNomeAbreviado() {
		if (getNomePessoa() == null)
			return "";
		String a[] = getNomePessoa().split(" ");

		String nomeAbreviado = "";
		for (String n : a) {
			if (nomeAbreviado.length() == 0)
				nomeAbreviado = n.substring(0, 1).toUpperCase()
						+ n.substring(1).toLowerCase();
			// else if (!"|DA|DE|DO|DAS|DOS|E|".contains("|" + n + "|"))
			// nomeAbreviado += " " + n.substring(0, 1) + ".";
		}
		return nomeAbreviado;
	}

	public String getPrimeiroNomeEIniciais() {
		if (getNomePessoa() == null)
			return "";
		String a[] = getNomePessoa().split(" ");

		String nomeAbreviado = "";
		for (String n : a) {
			if (nomeAbreviado.length() == 0)
				nomeAbreviado = n.substring(0, 1).toUpperCase()
						+ n.substring(1).toLowerCase();
			else if (!"|DA|DE|DO|DAS|DOS|E|".contains("|" + n + "|"))
				nomeAbreviado += " " + n.substring(0, 1) + ".";
		}
		return nomeAbreviado;
	}

	public Long getHisIdIni() {
		return getIdPessoaIni();
	}

	public void setHisIdIni(Long hisIdIni) {
		setIdPessoaIni(hisIdIni);
	}

	public Date getHisDtIni() {
		return getDataInicioPessoa();
	}

	public void setHisDtIni(Date hisDtIni) {
		setDataInicioPessoa(hisDtIni);
	}

	public Date getHisDtFim() {
		return getDataFimPessoa();
	}

	public void setHisDtFim(Date hisDtFim) {
		setDataFimPessoa(hisDtFim);
	}

	public Integer getHisAtivo() {
		return getHisDtFim() != null ? 1 : 0;
	}

	public void setHisAtivo(Integer hisAtivo) {
		//
	}
	
	public String getEmailPessoaAtual() {
		try{
			return getPessoaAtual().getEmailPessoa();
		}catch (Exception e) {
			return getEmailPessoa();
		}
		
	}
	
    /**
     * Retorna a data de in�cio da pessoa no formato dd/mm/aa HH:MI:SS,
     * por exemplo, 01/02/10 14:10:00.
     * 
     * @return Data de in�cio da pessoa no formato dd/mm/aa HH:MI:SS, por
     *         exemplo, 01/02/10 14:10:00.
     * 
     */
    public String getDtInicioPessoaDDMMYYHHMMSS() {
            if (getDataInicioPessoa() != null) {
                    final SimpleDateFormat df = new SimpleDateFormat(
                                    "dd/MM/yy HH:mm:ss");
                    return df.format(getDataInicioPessoa());
            }
            return "";
    }
    
    /**
     * Retorna a data de fim da pessoa no formato dd/mm/aa HH:MI:SS,
     * por exemplo, 01/02/10 14:10:00.
     * 
     * @return Data de in�cio da fim no formato dd/mm/aa HH:MI:SS, por
     *         exemplo, 01/02/10 14:10:00.
     * 
     */
    public String getDtFimPessoaDDMMYYHHMMSS() {
            if (getDataFimPessoa() != null) {
                    final SimpleDateFormat df = new SimpleDateFormat(
                                    "dd/MM/yy HH:mm:ss");
                    return df.format(getDataFimPessoa());
            }
            return "";
    }	
	
    public int compareTo(Object o) {
        DpPessoa other = (DpPessoa) o;

        return getNomePessoa().compareTo(other.getNomePessoa());
    }

	@Override
	public String toString() {
		return getSiglaCompleta();
	}
    
   /**
    * M�todo que filtra o pessoaPosteriores para que apare�a somente o hist�rico com informa��es corporativas, comparando 
    * uma linha da lista com a pr�xima para verificar se ocorreu alguma altera��o de lota��o, fun��o ou padr�o.
    * @return lista com hist�rico referentes as seguintes informa��es: lota��es, fun��o e padr�o.
    */
    public List<DpPessoa> getHistoricoInfoCorporativas() {
    	//transforma um treeSet (pessoaPosteriores) em um list para que se possa percorrer a lista do fim para o come�o 
    	List<DpPessoa> listaPessoaPosterioresA = new ArrayList<DpPessoa>(getPessoaInicial().getPessoasPosteriores());
    	List<DpPessoa> listaPessoaPosterioresB = listaPessoaPosterioresA;
    	List<DpPessoa> listaHistoricoPessoa = new ArrayList<DpPessoa>();
    	//define que o iterator come�a pelo fim da lista 
    	ListIterator<DpPessoa> itPessoaPosteriorA = listaPessoaPosterioresA.listIterator(listaPessoaPosterioresA.size());
    	ListIterator<DpPessoa> itPessoaPosteriorB = listaPessoaPosterioresB.listIterator(listaPessoaPosterioresB.size());
    	DpPessoa pessoaPost = null;
    	DpPessoa pessoaHist = null;
    	
		if (itPessoaPosteriorB.hasPrevious()) {
			pessoaHist = itPessoaPosteriorB.previous();
			listaHistoricoPessoa.add(pessoaHist);
		}
    	while (itPessoaPosteriorB.hasPrevious() ) {
			pessoaPost = itPessoaPosteriorA.previous();
			pessoaHist = itPessoaPosteriorB.previous();
			//verifica se a lota��o da lista listaPessoaPosterioresA � a mesma que da lista listaPessoaPosterioresB, 
			//que est� um registro a frente (linha seguinte)
			//somente adiciona na lista listaHistoricoPessoa,que ser� retornada pelo m�todo, caso as lota��es sejam diferentes
			if(!pessoaHist.getLotacao().getSigla().equals(pessoaPost.getLotacao().getSigla())) 
				listaHistoricoPessoa.add(pessoaHist);
			//verifica se o padr�o de refer�ncia da lista listaPessoaPosterioresA � o mesma que da lista listaPessoaPosterioresB
			else if((pessoaHist.getPadraoReferencia() == null ^ pessoaPost.getPadraoReferencia() == null) || 
						((pessoaHist.getPadraoReferencia() != null && pessoaPost.getPadraoReferencia() != null) &&
								!pessoaHist.getPadraoReferencia().equals(pessoaPost.getPadraoReferencia())) ) 
				listaHistoricoPessoa.add(pessoaHist);	
			//verifica se a fun��o de confian�a da lista listaPessoaPosterioresA � a mesma que da lista listaPessoaPosterioresB
			else if((pessoaHist.getFuncaoConfianca() == null ^ pessoaPost.getFuncaoConfianca() == null) || 
						((pessoaHist.getFuncaoConfianca() != null && pessoaPost.getFuncaoConfianca() != null) &&
								!pessoaHist.getFuncaoConfianca().getNomeFuncao().equals(pessoaPost.getFuncaoConfianca().getNomeFuncao())) ) 
				listaHistoricoPessoa.add(pessoaHist);				
    	}
    	Collections.reverse(listaHistoricoPessoa);
    	return listaHistoricoPessoa;
    } 

}