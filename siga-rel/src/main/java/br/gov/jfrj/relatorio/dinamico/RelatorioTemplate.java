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
package br.gov.jfrj.relatorio.dinamico;

import java.io.File;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.DJBuilderException;

/**
 * USE ESTA CLASSE para a cria��o de relat�rios r�pidos.<br />
 * 
 * Procedimentos para criar relatorios no siga-ex<br />
 * 
 * RESUMO:<BR/>
 * 1) Criar a classe do relat�rio (extends RelatorioTemplate)<br/>
 * 2) Implementar os m�todos:<br/>
 * 2.1) construtor passando um Map <-- Com o par�mentros que podem ser usados no
 * relat�rio.<br/>
 * 2.2) configurarRelatorio() <-- Para definir o layout do relat�rio.<br/>
 * 2.3) processarDados() <-- Para gerar um Set ou List contendo os dados do
 * relat�rio.<br/>
 * 3) Usar o relat�rio:<br/>
 * Exemplo: MeuRelatorio r = new MeuRelatorio(null); r.gerar();
 * JasperViewer.viewReport(r.getRelatorioJasperPrint());
 * 
 * 
 * <br/>
 * 
 * <br />
 * A) Crie a classe do relatorio<br />
 * a.1) Crie um builder baseado no AbstractRelatorioBaseBuilder caso n�o use o
 * RelatorioTemplate ou RelatorioRapido<br />
 * a.2) Crie a classe do relatorio baseada no template
 * (br.gov.jfrj.siga.ex.relatorio.dinamico.RelatorioTemplate.java)<br />
 * <br />
 * 1) Crie o menu do relat�rio (/sigaex/WebContent/paginas/menus/menu.jsp)<br />
 * Exemplo:<br />
 * <li><ww:url id="url" action="relRelatorios"<br />
 * namespace="/expediente/rel"><br />
 * <ww:param name="nomeArquivoRel">relModelos.jsp</ww:param><br />
 * </ww:url> <ww:a href="%{url}">Relat�rio de Modelos</ww:a></li> <br />
 * 
 * 
 * 2) Insira o c�digo de teste do .jsp no relatorio.jsp
 * (/sigaex/WebContent/paginas/expediente/relatorio.jsp) <______ ATEN��O
 * /sigaex/WebContent/paginas/EXPEDIENTE!!!!!!/relatorio.jsp<br />
 * <br />
 * <br />
 * 2.1) Informe o nome do arquivo<br />
 * 2.2) Informe o actionName<br />
 * 2.3) Informe o t�tulo da p�gina<br />
 * 2.4) Informe o nomeRelatorio<br />
 * <br />
 * Exemplo: <br />
 * </c:when><br />
 * <c:when test='${param.nomeArquivoRel eq "NOME_DO_RELATORIO.jsp"}'><br />
 * <c:set var="actionName" scope="request">emiteRelNOME_DO_RELATORIO</c:set><br />
 * <c:set var="titulo_pagina" scope="request">NOME_DO_RELATORIO</c:set><br />
 * <c:set var="nomeRelatorio" scope="request">relNOME_DO_RELATORIO.jsp</c:set><br />
 * </c:when><br />
 * <br />
 * 3) Crie a p�gina .jsp que receber� os par�metros do relat�rio<br />
 * /sigaex/WebContent/paginas/expediente/relatorios/<nomeDoRelatorio>.jsp<br />
 * <br />
 * 4) Crie a action no xwork.xml<br />
 * 4.1) Informe o nome da action (emiteRel...)<br />
 * 4.2) Informe a classe (br.gov.jfrj.webwork.action.ExRelatorioAction)<br />
 * 4.3) Informe o m�todo que tratar� o relat�rio<br />
 * 4.5) Informe o result name = relatorio<br />
 * 4.6) Informe o contentType = application/pdf<br />
 * 4.7) Informe o inputName = inputStream<br />
 * <br />
 * Ex:<br />
 * <br />
 * <action name="emiteRelDocumentosSubordinados"<br />
 * class="br.gov.jfrj.webwork.action.ExRelatorioAction"<br />
 * method="aRelDocumentosSubordinados"><br />
 * <result name="relatorio" type="stream"><br />
 * <param name="contentType">application/pdf</param><br />
 * <param name="inputName">inputStream</param><br />
 * </result><br />
 * </action><br />
 * <br />
 * 5) No br.gov.jfrj.webwork.action.ExRelatorioAction.java inclua o m�todo que
 * vai gerar o relat�rio<br />
 * 5.1) Use um c�digo como esse para gerar o relatorio<br />
 * <br />
 * public String aRelDocumentosSubordinados() throws Exception {<br />
 * <br />
 * Map parametros = new HashMap<String, String>(); <-- Para passar par�metros
 * para o relat�rio<br />
 * <br />
 * <br />
 * Obrigat�rio para
 * Relat�rioRapido--->parametros.put("secaoUsuario",getRequest()
 * .getParameter("secaoUsuario"));<br />
 * <br />
 * parametros.put("lotacao",getRequest().getParameter(
 * "lotacaoDestinatarioSel.sigla"));<br />
 * parametros.put("tipoFormaDoc", getRequest().getParameter("tipoFormaDoc"));<br />
 * parametros.put("incluirSubordinados",
 * getRequest().getParameter("incluirSubordinados"));<br />
 * parametros.put("lotacaoTitular",
 * getRequest().getParameter("lotacaoTitular"));<br />
 * parametros.put("orgaoUsuario",getRequest().getParameter("orgaoUsuario"));<br />
 * parametros.put("link_siga","http://" + getRequest().getServerName() + ":" <br />
 * + getRequest().getServerPort() <br />
 * + getRequest().getContextPath() + "/expediente/doc/exibir.action?id=");<br />
 * <br />
 * RelatorioDocumentosSubordinados rel = new
 * RelatorioDocumentosSubordinados(parametros);<br />
 * <br />
 * rel.gerar();<br />
 * <br />
 * this.setInputStream(new ByteArrayInputStream( rel.getRelatorioPDF()));<br />
 * <br />
 * return "relatorio";<br />
 * <br />
 * <br />
 * 5.1) Na �ltima linha do m�todo coloque (return "relatorio";)<br />
 * <br />
 * 
 * DICA: Para testar o relat�rio na pr�pria classe, use o m�todo main. Exemplo <br/>
 * public static void main(String[] args){<br/>
 * <br/>
 * try {<br/>
 * RelatorioEstatisticaProcedimento rep = new
 * RelatorioEstatisticaProcedimento(null);<br/>
 * rep.gerar();<br/>
 * JasperViewer.viewReport(rep.getRelatorioJasperPrint());<br/>
 * } catch (JRException e) {<br/>
 * // TODO Auto-generated catch block<br/>
 * e.printStackTrace();<br/>
 * } catch (DJBuilderException e) {<br/>
 * // TODO Auto-generated catch block<br/>
 * e.printStackTrace();<br/>
 * } catch (Exception e) {<br/>
 * // TODO Auto-generated catch block<br/>
 * e.printStackTrace();<br/>
 * }<br/>
 * 
 * @author kpf
 * 
 */

public abstract class RelatorioTemplate extends RelatorioRapido {

	private Collection dados;
	protected AbstractRelatorioBaseBuilder relatorio;

	/**
	 * Caso o relat�rio precise receber par�metros, use o construtor para
	 * obrigar o utilizador do relat�rio a inform�-los. O ideal � que as
	 * valida��es dos par�metros sejam feitas aqui no construtor<br />
	 * Exemplo: <br />
	 * public RelatorioDocumentosSubordinados(Map parametros) throws
	 * DJBuilderException {
	 * 
	 * super(parametros); if (parametros.get("secaoUsuario") == null){ throw new
	 * DJBuilderException("Par�metro secaoUsuario n�o informado!"); } if
	 * (parametros.get("link_siga") == null){ throw new
	 * DJBuilderException("Par�metro link_siga n�o informado!"); } }
	 */
	public RelatorioTemplate(Map parametros) throws DJBuilderException {
		super(parametros);
	}

	public void gerar() throws Exception {

		relatorio = configurarRelatorio();
		dados = processarDados();
		if (dados!=null && dados.size() > 0) {
			relatorio.setDados(dados);
		} else {
			throw new Exception("N�o h� dados para gerar o relat�rio!");
		}

	}

	/**
	 * Classe que permite o uso do Design Pattern Template Method.
	 * 
	 * Implemente este m�todo para definir o desenho do relat�rio usando um
	 * builder. Use a classe RelatorioRapido como builder para gerar relat�rios
	 * r�pidos.<BR>
	 * Caso queira um builder de relat�rio personalizado, estenda a classe
	 * AbstractRelatorioBaseBuilder.<BR>
	 * 
	 * <br />
	 * Exemplo:<br />
	 * public AbstractRelatorioBaseBuilder configurarRelatorio() throws
	 * DJBuilderException, JRException {
	 * 
	 * this.setTitle("Relat�rio de Documentos em Setores Subordinados");
	 * this.addColuna("Setor", 0,RelatorioRapido.ESQUERDA,true);
	 * this.addColuna("Documento", 25,RelatorioRapido.ESQUERDA,false,true);
	 * this.addColuna("Descri��o", 50,RelatorioRapido.ESQUERDA,false);
	 * this.addColuna("Respons�vel", 30,RelatorioRapido.ESQUERDA,false);
	 * this.addColuna("Situa��o", 30,RelatorioRapido.ESQUERDA,false);
	 * 
	 * return this; }
	 * 
	 * @return Retorna um builder de relat�rios.
	 * @throws DJBuilderException
	 * @throws JRException
	 * @throws ColumnBuilderException 
	 */
	public abstract AbstractRelatorioBaseBuilder configurarRelatorio()
			throws DJBuilderException, JRException, ColumnBuilderException;

	/**
	 * Implemente este m�todo para processar os dados que ser�o exibidos no
	 * relat�rio. � neste m�todo que se faz as consultas a um banco de dados,
	 * por exemplo. <br />
	 * CUIDADO: A cole��o de dados deve ser ordenada, sen�o os dados v�o
	 * aparecer desordenados no relat�rio. Exemplo:<br />
	 * public Collection processarDados() {
	 * 
	 * List<String> d = new LinkedList<String>(); Query q =
	 * HibernateUtil.getSessao().createQuery("from ExModelo order by
	 * exFormaDocumento.descrFormaDoc");
	 * 
	 * for (Iterator<ExModelo> iterator = q.list().iterator();
	 * iterator.hasNext();) { ExModelo modelo = (ExModelo) iterator.next();
	 * d.add(modelo.getExFormaDocumento().getDescrFormaDoc());
	 * d.add(modelo.getNmMod()); d.add(modelo.getExClassificacao().getSigla());
	 * d.add(modelo.getExClassCriacaoVia().getSigla()); }
	 * 
	 * return d; }
	 * 
	 * 
	 * @return Retorna um Collection contendo os dados do relat�rio.
	 */
	public abstract Collection processarDados() throws Exception;

	/**
	 * M�todo que gera o relat�rio em PDF.<br>
	 * 
	 * @throws JRException
	 */
	public byte[] getRelatorioPDF() throws JRException {
		return JasperExportManager.exportReportToPdf(relatorio
				.getRelatorioJasperPrint());
		// JasperViewer.viewReport(relatorio.getRelatorio());
	}

	public StringBuffer getRelatorioHTML() throws JRException {
		JRHtmlExporter htmlExp = new JRHtmlExporter();

		htmlExp.setParameter(JRExporterParameter.JASPER_PRINT,
				relatorio.getRelatorioJasperPrint());
		StringBuffer sb = new StringBuffer();
		htmlExp.setParameter(JRHtmlExporterParameter.IMAGES_DIR, new File(
				RelatorioTemplate.class.getResource("/").getFile()));
		htmlExp.setParameter(JRHtmlExporterParameter.IMAGES_MAP,
				new HashMap<String, Object>());
		htmlExp.setParameter(JRHtmlExporterParameter.IMAGES_URI, "");
		htmlExp.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR,
				true);
		htmlExp.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER, sb);

		htmlExp.exportReport();
		return sb;
	}

}
