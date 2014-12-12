package br.gov.jfrj.siga.integration.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import br.gov.jfrj.siga.page.objects.EditaDocumentoPage;
import br.gov.jfrj.siga.page.objects.MemorandoPage;
import br.gov.jfrj.siga.page.objects.OficioPage;
import br.gov.jfrj.siga.page.objects.OperacoesDocumentoPage;
import br.gov.jfrj.siga.page.objects.PortariaPage;
import br.gov.jfrj.siga.page.objects.PrincipalPage;

public class CriacaoDocumentoIT extends IntegrationTestBase{
	private PrincipalPage principalPage;
	private EditaDocumentoPage editaDocumentoPage;
	private OperacoesDocumentoPage operacoesDocumentoPage;
	private Properties propDocumentos = new Properties();
	
	@Parameters({ "baseURL", "login", "password" })
	public CriacaoDocumentoIT(String baseURL, String login, String password) {
		super(baseURL, login, password);
	}

	@BeforeClass	
	@Parameters("infoDocumentos")
	public void setUp(String infoDocumentos) {
		File file = new File(infoDocumentos);
		try {
			efetuaLogin();
			propDocumentos.load(new FileInputStream(file));
			driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
			principalPage = PageFactory.initElements(driver, PrincipalPage.class);
			editaDocumentoPage = PageFactory.initElements(driver, EditaDocumentoPage.class);
			operacoesDocumentoPage = PageFactory.initElements(driver, OperacoesDocumentoPage.class);
		} catch (Exception e) {
			e.printStackTrace();
			driver.quit();
		} 
	}
	
	@BeforeMethod
	public void paginaInicial() {
		try {
			System.out.println("BeforeMethod... Titulo p�gina: " + driver.getTitle());
			if(!driver.getTitle().equals("SIGA - P�gina Inicial")) {
				driver.get(baseURL + "/siga");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Test(enabled = true)
	public void criaDocumentoExterno() {
		principalPage.clicarBotaoNovoDocumentoEx();
		editaDocumentoPage.preencheDocumentoExterno(propDocumentos);
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/table[1]/tbody/tr[3]/td/table/tbody/tr/td[1]/p")
				.contains("Expediente Externo N� TMP"), true, "Texto Expediente Externo N� TMP n�o foi encontrado!");
		operacoesDocumentoPage.clicarLinkEditar();
	}

	@Test(enabled = true)
	public void criaDocumentoInternoImportado() {
		principalPage.clicarBotaoNovoDocumentoEx();
		editaDocumentoPage.preencheDocumentoInternoImportado(propDocumentos);
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/table[2]/tbody/tr/td[1]/b")
				.contains("Expediente Interno N� TMP"), true, "Texto Expediente Interno N� TMP n�o foi encontrado!");
	}
	
	@Test(enabled = true)
	public void criaMemorando() {
		MemorandoPage memorandoPage = PageFactory.initElements(driver, MemorandoPage.class);
		principalPage.clicarBotaoNovoDocumentoEx();
		memorandoPage.criaMemorando(propDocumentos);
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/table/tbody/tr[1]/td/p")
				.contains("MEMORANDO N� TMP"), true, "Texto MEMORANDO N� TMP n�o foi encontrado!");
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/span/p[1]")
				.contains("Atenciosamente"), true, "Fecho n�o encontrado");
	}
	
	@Test(enabled = true)
	public void criaPortaria() {
		PortariaPage portariaPage = PageFactory.initElements(driver, PortariaPage.class);
		principalPage.clicarBotaoNovoDocumentoEx();
		portariaPage.criaPortaria(propDocumentos);
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/table[1]/tbody/tr/td/p")
				.contains("PORTARIA N� TMP"), true, "Texto PORTARIA N� TMP n�o foi encontrado!");
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/table[2]/tbody/tr/td[2]/p")
				.contains("Testes de Integra��o"), true, "Informa��o sobre o que Disp�e o documento n�o encontrada!");
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/div/p[1]/span")
				.contains("Exmo. Sr. Juiz Federal"), true, "Texto do memorando n�o encontrado!");
	}
	
	@Test(enabled = true)
	public void criaOficio() {
		OficioPage oficioPage = PageFactory.initElements(driver, OficioPage.class);
		principalPage.clicarBotaoNovoDocumentoEx();
		oficioPage.criaOficio(propDocumentos);
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/table[1]/tbody/tr[1]/td/p")
				.contains("OF�CIO N� TMP"), true, "Texto OF�CIO N� TMP n�o foi encontrado!");
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("//table/tbody/tr/td/span/p[contains(.,'"+ propDocumentos.getProperty("enderecoDestinatario") + "')]")
				.contains("Rio de Janeiro"), true, "Endere�o n�o encontrado!");
		Assert.assertEquals(operacoesDocumentoPage.getTextoVisualizacaoDocumento("/html/body/div[5]/div[1]/div/table/tbody/tr/td/span/div/p[2]")
				.contains("Senhora Juiza"), true, "Forma de Tratamento n�o encontrada!");
	}
	
	@AfterClass
	public void tearDown() throws Exception {
		driver.quit();
	}
}