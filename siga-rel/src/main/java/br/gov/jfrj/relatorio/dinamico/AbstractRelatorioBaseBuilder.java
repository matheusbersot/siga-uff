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


import java.awt.Color;
import java.io.File;
import java.net.URL;
import java.text.DateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.HorizontalBandAlignment;
import ar.com.fdvs.dj.domain.AutoText;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.DJBuilderException;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.Transparency;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;


/**
 * Base para a gera��o de relat�rio din�micos.<BR>
 * Para criar um relat�rio personalizado, extenda essa classe.<BR>
 * Para criar relat�rios r�pidos use a classe RelatorioTemplate ou RelatorioRapido.<BR>
 * <BR> 
 * Esta classe basicamente coloca o bras�o da Justi�a e define os estilos b�sicos.
 */

public abstract class AbstractRelatorioBaseBuilder extends DynamicReportBuilder {

	protected JRDataSource ds;
	protected DynamicReport dr;
	
	protected Style estiloTitulo;
	protected Style estiloSubtitulo;
	protected Style estiloTituloColuna;
	protected Style estiloColuna;
	protected Style estiloTituloGrupo;
	
	protected Map parametros;
	
	public AbstractRelatorioBaseBuilder(Map parametros) throws DJBuilderException{
		
		this.parametros = parametros;

		this.setAllowDetailSplit(false);
		this.setReportLocale(new Locale("pt","BR"));

		estiloTitulo = new Style();
		estiloTitulo.setName("estiloTitulo");
		estiloTitulo.setFont(new Font(14,"Arial",true));
		estiloTitulo.setTextColor(Color.BLACK);
		this.addStyle(estiloTitulo);
	
		estiloSubtitulo = new Style();
		estiloSubtitulo.setName("estiloSubtitulo");
		estiloSubtitulo.setFont(Font.ARIAL_MEDIUM_BOLD);
		estiloSubtitulo.setTextColor(Color.BLACK);
		this.addStyle(estiloSubtitulo);
		
		estiloTituloColuna = new Style();
		estiloTituloColuna.setName("estiloTituloColuna");
		estiloTituloColuna.setFont(Font.ARIAL_MEDIUM_BOLD);
		estiloTituloColuna.setBorderBottom(Border.PEN_1_POINT);
		estiloTituloColuna.setBackgroundColor(Color.gray);
		estiloTituloColuna.setTextColor(Color.white);
		estiloTituloColuna.setHorizontalAlign(HorizontalAlign.CENTER);
		estiloTituloColuna.setVerticalAlign(VerticalAlign.MIDDLE);
		estiloTituloColuna.setTransparency(Transparency.OPAQUE);
		this.addStyle(estiloTituloColuna);
	
		estiloColuna = new Style();
		estiloColuna.setName("estiloColuna");
		estiloColuna.setFont(Font.ARIAL_SMALL);
		estiloColuna.setTextColor(Color.BLACK);
		estiloColuna.setBorder(Border.THIN);
		this.addStyle(estiloColuna);
		
		estiloTituloGrupo = new Style();
		estiloTituloGrupo.setName("estiloTituloGrupo");
		estiloTituloGrupo.setFont(new Font(12,"Arial",true));
		estiloTituloGrupo.setBorderTop(Border.THIN);
		estiloTituloGrupo.setBackgroundColor(Color.white);
		estiloTituloGrupo.setTextColor(Color.black);
		estiloTituloGrupo.setHorizontalAlign(HorizontalAlign.LEFT);
		estiloTituloGrupo.setVerticalAlign(VerticalAlign.MIDDLE);
		estiloTituloGrupo.setTransparency(Transparency.OPAQUE);
		this.addStyle(estiloTituloGrupo);
		
		this.setDefaultStyles(estiloTitulo,estiloSubtitulo, estiloTituloColuna, estiloColuna);

		this.setTemplateFile("RelatorioBase.jrxml");
	
		this.setPrintBackgroundOnOddRows(true);

		AutoText dataCriacao = new AutoText(AutoText.AUTOTEXT_CUSTOM_MESSAGE,AutoText.POSITION_HEADER,HorizontalBandAlignment.RIGHT);
		String textoDataCriacao = DateFormat.getDateInstance(DateFormat.SHORT, new Locale("pt","br")).format(new Date());
		dataCriacao.setMessageKey("Emiss�o:" + textoDataCriacao);
//		this.addAutoText(dataCriacao);
		
        AutoText pagina = new AutoText(AutoText.AUTOTEXT_PAGE_X_OF_Y,AutoText.POSITION_FOOTER,HorizontalBandAlignment.CENTER);
        pagina.setWidth(new Integer(100));
        pagina.setWidth2(new Integer(100));
//        this.addAutoText(pagina);

	}
	
	/**
	 * Configura os dados que ser�o exibidos no relat�rio com Query.
	 * 
	 *  @param dados
	 *  Os beans da consulta s�o usados para preencher o relat�rio.
	 *  Para essa modalidade funcionar corretamente, � necess�rio que o 
	 *  relat�rio tenha seus campos com nomes id�nticos aos m�todos de acesso do bean.
	 *  Exemplo: Use setColumnProperty(nome,...) para um bean.getNome()
	 *  
	 */
//	public void setDados(Query dados) throws Exception{
//		List lista = ((Query)dados).list();
//		ds = new JRBeanCollectionDataSource(lista);
//	}
	
	public abstract void setDados(Collection dados) throws Exception;
	/**
	 *  Configura os dados que ser�o exibidos no relat�rio com Collections
	 *  de Maps.
	 * @param dados
	 * Cada item da collection deve ser um Map<String,String>, onde
	 * o "key" � o nome do campo no relat�rio e o "value" o seu conte�do
	 * 
	 * @throws Exception
	 */
	public void setDadosColecaoMap(Collection<Map<String,String>> dados) throws Exception{
		ds = new JRMapCollectionDataSource(dados);	
	}
	
	/**
	 * M�todo que retorna o relat�rio no formato JasperPrint.<br/>
	 * Pode ser usado para visualizar no JasperViewer (sem precisar tratar o PDF) durante a fase de 
	 * contru��o do relat�rio.
	 * 
	 * Exemplo de uso:
	 * JasperViewer.viewReport(relatorio.getRelatorio());
	 * @return
	 * @throws JRException
	 */
	public JasperPrint getRelatorioJasperPrint() throws JRException {
		dr = this.build();
	    //return DynamicJasperHelper.generateJasperPrint(dr, new ClassicLayoutManager(), ds, parametros);
		return DynamicJasperHelper.generateJasperPrint(dr, new LayoutRelatorioDinamico(), ds, parametros);
		
	}
	
	protected Style copiarEstilo(Style estilo) {
		Style style = new Style();

		style.setBackgroundColor(estilo.getBackgroundColor());
		style.setBorderColor(estilo.getBorderColor());
		style.setTransparency(estilo.getTransparency());
		style.setTextColor(estilo.getTextColor());
		style.setBorder(estilo.getBorder());
		style.setFont(estilo.getFont());
		style.setPadding(estilo.getPadding());
		style.setRadius(estilo.getRadius());
		style.setVerticalAlign(estilo.getVerticalAlign());
		style.setHorizontalAlign(estilo.getHorizontalAlign());
		style.setRotation(estilo.getRotation());
		style.setStreching(estilo.getStreching());

		return style;
	}
}
