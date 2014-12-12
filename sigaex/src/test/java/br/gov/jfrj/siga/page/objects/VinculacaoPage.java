package br.gov.jfrj.siga.page.objects;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import br.gov.jfrj.siga.integration.test.util.IntegrationTestUtil;
import br.gov.jfrj.siga.integration.test.util.PopupExpectedCondition;

public class VinculacaoPage {
	private WebDriver driver;
	
	@FindBy(id="referenciar_gravar_dtMovString")
	private WebElement data;
	
	@FindBy(id="referenciar_gravar_subscritorSel_sigla")
	private WebElement responsavel;
	
	@FindBy(id="referenciar_gravar_documentoRefSel_sigla")
	private WebElement documento;
	
	@FindBy(id="documentoRefSelButton")
	private WebElement botaoDocumento;
	
	@FindBy(xpath="//input[@value='Ok']")
	private WebElement botaoOk;
	
	@FindBy(xpath="//input[@value='Cancela']")
	private WebElement botaoCancela;
	
	private IntegrationTestUtil util;
	
	public VinculacaoPage(WebDriver driver) {
		this.driver = driver;
		util = new IntegrationTestUtil();
	}
	
	public void vincularDocumento(Properties propDocumentos, String codigoDocumento) {
		util.preencheElemento(driver, data, new SimpleDateFormat("ddMMyyyy").format(Calendar.getInstance().getTime()));
		util.preencheElemento(driver, responsavel, propDocumentos.getProperty("responsavel"));
		documento.click();
		new WebDriverWait(driver, 15).until(ExpectedConditions.visibilityOfElementLocated(By.id("subscritorSelSpan")));
		new WebDriverWait(driver, 15).until(ExpectedConditions.elementToBeClickable(botaoDocumento)).click();
		
		System.out.println("WindowHandle size antes: " + driver.getWindowHandles().size());
		botaoDocumento.click();
		
		util.openPopup(driver);
		try {
			PesquisaDocumentoPage buscaPage = PageFactory.initElements(driver, PesquisaDocumentoPage.class);
			buscaPage.buscarDocumento(codigoDocumento);		
			System.out.println("WindowHandle size depois: " + driver.getWindowHandles().size());
		} finally {
			util.changeFromPopup(driver);
		}

		new WebDriverWait(driver, 15).until(ExpectedConditions.titleIs("SIGA - Refer�ncia"));
		new WebDriverWait(driver, 15).until(ExpectedConditions.elementToBeClickable(botaoOk)).click();		
	}
}
