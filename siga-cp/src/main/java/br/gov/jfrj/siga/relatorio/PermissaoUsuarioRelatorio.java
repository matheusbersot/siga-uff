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
package br.gov.jfrj.siga.relatorio;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import net.sf.jasperreports.engine.JRException;
import ar.com.fdvs.dj.domain.builders.DJBuilderException;
import ar.com.fdvs.dj.domain.constants.Page;
import br.gov.jfrj.relatorio.dinamico.AbstractRelatorioBaseBuilder;
import br.gov.jfrj.relatorio.dinamico.RelatorioRapido;
import br.gov.jfrj.relatorio.dinamico.RelatorioTemplate;
import br.gov.jfrj.siga.acesso.ConfiguracaoAcesso;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
/**
 * Relat�rio indicando todas as permiss�es de um determinado usu�rio
 * @author aym
 *
 */
public class PermissaoUsuarioRelatorio extends RelatorioTemplate{
	private DpPessoa dpPessoa;
	@SuppressWarnings("unchecked")
	public PermissaoUsuarioRelatorio(Map parametros) throws DJBuilderException {
		super(parametros);
		if (parametros.get("idPessoa") == null){
			throw new DJBuilderException("Par�metro idPessoa n�o informado!");
		}
		try {
			Long t_lngIdPessoa = Long.parseLong((String) parametros.get("idPessoa"));
			setDpPessoa(dao().consultar(t_lngIdPessoa, DpPessoa.class, false));
		} catch (Exception e) {
			throw new DJBuilderException("Par�metro idPessoa inv�lido!");
		}
		this.setPageSizeAndOrientation( Page.Page_A4_Landscape());
	}
	@Override
	public AbstractRelatorioBaseBuilder configurarRelatorio()
			throws DJBuilderException, JRException {
		this.setTemplateFile(null);
		this.setTitle("Permiss�o de " 
				        + getDescricaoTipoConfiguracao() 
						+ ": (" 
						+ dpPessoa.getSesbPessoa() +  dpPessoa.getMatricula()
						+ ") " 
						+ dpPessoa.getNomePessoa()  
						); 
		this.addColuna("Servi�o",58,RelatorioRapido.ESQUERDA,false, false);
		this.addColuna("Situa��o",10,RelatorioRapido.ESQUERDA,false, false);
		this.addColuna("Origem", 10,RelatorioRapido.ESQUERDA,false, false);
		this.addColuna("Desde", 12,RelatorioRapido.ESQUERDA,false, false);  
		this.addColuna("Cadastrante", 10,RelatorioRapido.ESQUERDA,false, false);
		return this;
	}
	/**
	 * Processa as configura��es ativas para os v�rios ids da pessoa 
	 * (mesmo id inicial que a pessoa selecionada)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Collection processarDados() {
		ArrayList<String> dados=new ArrayList<String>();
		HashMap<CpServico, ConfiguracaoAcesso> achm = new HashMap<CpServico, ConfiguracaoAcesso>();
		List<CpServico> l = dao().listarServicos();
		try {
			for (CpServico srv : l) {
							ConfiguracaoAcesso ac = ConfiguracaoAcesso.gerar(null, dpPessoa,
									null, null, srv, null);
	
							achm.put(ac.getServico(), ac);
			}
		} catch(Exception e) {
			dados=new ArrayList<String>();
			return dados;
		}
		SortedSet<ConfiguracaoAcesso> acs = new TreeSet<ConfiguracaoAcesso>();
		for (ConfiguracaoAcesso ac : achm.values()) {
			if (ac.getServico().getCpServicoPai() == null) {
				acs.add(ac);
			} else {
				achm.get(ac.getServico().getCpServicoPai()).getSubitens()
						.add(ac);
			}
		}
		for (ConfiguracaoAcesso cfga : new ArrayList<ConfiguracaoAcesso>(acs) ) {
			varrerConfiguracao ( cfga,  dados );
		}
		return dados;
	}
	/**
	 * Varre a �rvore de configura��es (ConfiguracaoAcesso) - organizada  
	 * @param cfga - Configura��o acesso
	 * @param dados - cole��o de linhas do relat�rio
	 */
	private void varrerConfiguracao (ConfiguracaoAcesso cfga, List<String> dados ) {
		processarConfiguracaoAcesso(cfga, dados);
		for ( ConfiguracaoAcesso cfgaSub : cfga.getSubitens()) {
			varrerConfiguracao ( cfgaSub,  dados);
		}
	}
	/**
	 * Preenche os dados com as informa��es da configura��o j� formatados
	 * @param cfga - Configura��o acesso
	 * @param dados - cole��o de linhas do relat�rio
	 */
	private void processarConfiguracaoAcesso(ConfiguracaoAcesso cfga, List<String> dados ) {
		try {dados.add(printSeparadorNivel(cfga.getServico().getNivelHierarquico() ) + printServico(cfga.getServico()));}  catch (Exception e) { dados.add("");}
		try {dados.add(cfga.getSituacao().getDscSitConfiguracao());}  catch (Exception e) { dados.add("");}
		try {dados.add(printOrigem(cfga));}  catch (Exception e) { dados.add("");}
		try {dados.add(printDate(cfga.getInicio()));}  catch (Exception e) { dados.add("");}
		try {dados.add(String.valueOf(cfga.getCadastrante().getSesbPessoa() + cfga.getCadastrante().getMatricula()));}  catch (Exception e) { dados.add("");}
	}
	private String printDate( Date dte) {
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return df.format(dte);
	}
	private String printServico(CpServico srv) {
		return srv.getSiglaSemPartePai() + " - " + srv.getDescricao();
	}
	/**
	 * 
	 * @param nivel o n�vel do servi�o
	 * @return uma string para a indenta��o da descri��o do servi�o
	 */
	private String printSeparadorNivel(int nivel) {
		StringBuffer str = new StringBuffer();
		for (int cta = 0; cta < nivel; cta++) {
			if (cta == (nivel -1) ) {
				str.append(" . ");
			} else {
				str.append("   ");
			}
		}
		return str.toString();
	}
	/**
	 *  @param	configura��o acesso
	 *  @return Uma String representativa da origem
	 */
	private String printOrigem(ConfiguracaoAcesso cfga) {
		return cfga.printOrigemCurta();
	}
	private Long getIdTipoConfiguracao() {
		return CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO;
	}
	private CpTipoConfiguracao getTipoConfiguracao() {
		return dao().consultar(getIdTipoConfiguracao(), CpTipoConfiguracao.class, false);
	}
	private String getDescricaoTipoConfiguracao() {
		return getTipoConfiguracao().getDscTpConfiguracao();
	}
	private CpDao dao() {
		return CpDao.getInstance();
	}
	/**
	 * @return the cpServico
	 */
	public DpPessoa getDpPessoa() {
		return dpPessoa;
	}
	/**
	 * @param cpServico the cpServico to set
	 */
	public void setDpPessoa(DpPessoa dpPessoa) {
		this.dpPessoa = dpPessoa;
	}
	public static void main (String args[]) throws Exception{
	}
}
