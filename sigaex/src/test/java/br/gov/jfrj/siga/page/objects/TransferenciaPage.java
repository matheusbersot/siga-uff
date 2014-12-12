package br.gov.jfrj.siga.page.objects;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import br.gov.jfrj.siga.integration.test.util.IntegrationTestUtil;

public class TransferenciaPage {
	private WebDriver driver;
	
	@FindBy(id="transferir_gravar_dtMovString")
	private WebElement data;
	
	@FindBy(id="transferir_gravar_subscritorSel_sigla")
	private WebElement subscritor;
	
	@FindBy(id="transferir_gravar_nmFuncaoSubscritor")
	private WebElement funcaoLotacao;
	
	@FindBy(id="transferir_gravar_idTpDespacho")
	private WebElement despacho;	
		
	@FindBy(id="transferir_gravar_tipoResponsavel")
	private WebElement tipoAtendente;	
	
	@FindBy(id="transferir_gravar_lotaResponsavelSel_sigla")
	private WebElement atendente;	
	
	@FindBy(id="transferir_gravar_dtDevolucaoMovString")
	private WebElement dataDevolucao;	
	
	@FindBy(xpath="//input[@value='Ok']")
    private WebElement botaoOk;
    
	@FindBy(xpath="//input[@value='Cancela']")
    private WebElement botaoCancela;
	
	@FindBy(xpath="//input[@value='Visualizar o despacho']")
    private WebElement botaoVisualizarDespacho;
	
	private IntegrationTestUtil util;
/*	
	private String winHandleBefore;
	private String popupHandle;	
	*/
	public TransferenciaPage(WebDriver driver) {
		this.driver = driver;
		util = new IntegrationTestUtil();
	}
	
	public void despacharDocumento(Properties propDocumentos) {
		util.openPopup(driver);
		
		try {
			String URL = driver.getCurrentUrl();
			util.preencheElemento(driver, data, new SimpleDateFormat("ddMMyyyy").format(Calendar.getInstance().getTime()));
			util.preencheElemento(driver, subscritor, propDocumentos.getProperty("siglaSubscritor"));
			util.preencheElemento(driver, funcaoLotacao, propDocumentos.getProperty("funcaoLocalidade"));
			util.getSelect(driver, despacho).selectByVisibleText(propDocumentos.getProperty("despacho"));
			new WebDriverWait(driver, 15).until(util.trocaURL(URL));
			new WebDriverWait(driver, 15).until(ExpectedConditions.elementToBeClickable(botaoOk));
			botaoOk.click();
		} finally {
			util.changeFromPopup(driver);
		}
	}
	
	public void transferirDocumento(Properties propDocumentos) {
		util.openPopup(driver);
		
		try {
			util.getSelect(driver, tipoAtendente).selectByVisibleText(propDocumentos.getProperty("tipoAtendente"));
			util.preencheElemento(driver, atendente, propDocumentos.getProperty("atendente"));
			util.preencheElemento(driver, dataDevolucao, new SimpleDateFormat("ddMMyyyy").format(Calendar.getInstance().getTime()));
			botaoOk.click();
		} finally {
			util.changeFromPopup(driver);
		}
	}
	
	/**
	 * 
	 * @param propDocumentos
	 * @param codigoDocumento
	 * @return
	 */
	public String despachoDocumentoFilho(Properties propDocumentos, String codigoDocumento) {
		util.openPopup(driver);
		String codigoDocumentoJuntado;
		
		try {
			util.getSelect(driver, despacho).selectByVisibleText(propDocumentos.getProperty("despachoTextoLongo"));
			DespachoPage despachoPage = PageFactory.initElements(driver, DespachoPage.class);
			despachoPage.criarDespacho(propDocumentos, Boolean.FALSE);
			
			OperacoesDocumentoPage operacoesDocumentoPage = PageFactory.initElements(driver, OperacoesDocumentoPage.class);
			operacoesDocumentoPage.clicarLinkFinalizar();
			
			operacoesDocumentoPage.clicarLinkRegistrarAssinaturaManual();
			RegistraAssinaturaManualPage registraAssinaturaManualPage = PageFactory.initElements(driver, RegistraAssinaturaManualPage.class);
			registraAssinaturaManualPage.registarAssinaturaManual();
			
			new WebDriverWait(driver, 15).until(ExpectedConditions.presenceOfElementLocated(By.xpath("//h3[1][contains(text(), 'Juntado')]")));			
			operacoesDocumentoPage.clicarLinkDesentranhar();
			new WebDriverWait(driver, 15).until(ExpectedConditions.presenceOfElementLocated(By.xpath("//h3[1][contains(text(), 'Aguardando Andamento')]")));	
			
			operacoesDocumentoPage.clicarlinkJuntar();
			JuntadaDocumentoPage juntadaDocumentoPage = PageFactory.initElements(driver, JuntadaDocumentoPage.class);
			juntadaDocumentoPage.juntarDocumento(propDocumentos, codigoDocumento);
			codigoDocumentoJuntado = operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[4]/div/h2");
			
		} finally {
			util.closePopup(driver);
		}
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		driver.navigate().refresh();
		
		return codigoDocumentoJuntado;
	}
}

