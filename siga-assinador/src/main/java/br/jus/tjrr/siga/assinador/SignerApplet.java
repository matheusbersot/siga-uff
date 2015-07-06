package br.jus.tjrr.siga.assinador;

import java.applet.Applet;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.Security;
import java.security.SignatureException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.UIManager;

import netscape.javascript.JSException;
import netscape.javascript.JSObject;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.ini4j.Ini;
import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.ObjectNotFoundException;
import org.mozilla.jss.crypto.TokenException;

import br.jus.tjrr.siga.assinador.controller.CertificateController;
import br.jus.tjrr.siga.assinador.controller.JSController;
import br.jus.tjrr.siga.assinador.controller.ProgressBarController;
import br.jus.tjrr.siga.assinador.controller.SignatureController;
import br.jus.tjrr.siga.assinador.view.DialogChooseCertificate;
import br.jus.tjrr.siga.assinador.view.DialogPasswordCallback;

public class SignerApplet extends Applet {

	private Logger logger = Logger.getLogger(SignerApplet.class.getName());
	
	private boolean isCopyBtn1;
	private boolean isCopyBtn2;
	private String labelBtn1;
	private String labelBtn2;
	private boolean hasTwoButtons;
	private int colorR;
	private int colorG;
	private int colorB;
	
	private JButton btn1;
	private JButton btn2;

	private void initBouncyCastleProvider() {
		Security.addProvider(new BouncyCastleProvider());
	}

	private void initJsIntegration() {
		JSController.setJsObject((JSObject) JSObject.getWindow(this));
		ProgressBarController.setJsObject((JSObject) JSObject.getWindow(this));
	}

	
	private String getProfilePath() throws Exception
	{
		Map<String, String> env = System.getenv();
		String userHome = env.get("HOME");
		
		Ini ini = null;
		try {
			ini = new Ini(new File(userHome + "/.mozilla/firefox/profiles.ini"));
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha ao abrir arquivo profiles.ini.", e);
			throw new Exception("Falha ao abrir arquivo profiles.ini.");
		}
		
		boolean isDefaultProfile = false;
		int MAX_PROFILES = 20;
		int i = 0;
		String profile = "";
		
		do
		{			
			profile = "Profile" + i;
			String defaultValue = ini.get(profile, "Default");
			isDefaultProfile = (defaultValue.compareTo("0")==0)? false: true;
			++i;
		
		}while((!isDefaultProfile) && (i < MAX_PROFILES));
		
		String folder = ini.get(profile, "Path");
		String path = userHome + "/.mozilla/firefox/" + folder;
		
		return path;
	}
	
	
	private void initJSSProvider() throws Exception {
		
		String profilePath = getProfilePath();
		
		CryptoManager.InitializationValues values = new CryptoManager.InitializationValues(profilePath);
		values.readOnly = true;
		values.passwordCallback = new DialogPasswordCallback();

		try {
			CryptoManager.initialize(values);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha em inicializar o CryptoManager.", e);
		}
	}
	
	private void getParameters()
	{
		isCopyBtn1 = new Boolean(this.getParameter("isCopyBtn1"));
		isCopyBtn2 = new Boolean(this.getParameter("isCopyBtn2"));
		labelBtn1 = this.getParameter("labelBtn1");
		labelBtn2 = this.getParameter("labelBtn2");
		hasTwoButtons = (labelBtn2 != null)? true: false;
		
		if((this.getParameter("backgroundColor_R") == null) || (this.getParameter("backgroundColor_G") == null )
			|| (this.getParameter("backgroundColor_B") == null)) 
		{
			colorR = 255; colorG = 255; colorB = 255;			
		}
		else
		{		
			colorR = new Integer(this.getParameter("backgroundColor_R"));
			colorG = new Integer(this.getParameter("backgroundColor_G"));
			colorB = new Integer(this.getParameter("backgroundColor_B"));
		}
	}

	@Override
	public void init() {

		super.init();

		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha ao carregar o layout do sistema.", e);
		}
		
		try{		
			getParameters();
			
			setBackground(new Color(colorR,colorG,colorB));
			
			initJSSProvider();
			initJsIntegration();
			initBouncyCastleProvider();	
			
			btn1 = new JButton();
			btn1.setLocation(0, 0);
			btn1.setText(labelBtn1);
		
			btn1.setSize((150*labelBtn1.length())/17, 30);
			btn1.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent actionEvent) {
					sign(isCopyBtn1);
				}
			});
	
			add(btn1);
			
			if(hasTwoButtons){
				btn2 = new JButton();
				btn2.setLocation((150*labelBtn1.length())/17 + 20, 0);
				btn2.setText(labelBtn2);
			
				btn2.setSize((150*labelBtn2.length())/17, 30);
				btn2.addActionListener(new ActionListener() {
					@Override
					public void actionPerformed(ActionEvent actionEvent) {
						sign(isCopyBtn2);
					}
				});
				add(btn2);
			}	
				
			setLayout(null);
		
		}catch(Exception e){
			JOptionPane.showMessageDialog(this, e.getMessage());
			e.printStackTrace();
		}
	}

	private void sign(boolean isCopy) {

		try {
			
			int qtyDocuments = JSController.getQtyDocuments();
			
			int numSteps = 3 + 3*qtyDocuments;
			ProgressBarController.setNumSteps(numSteps);			
		
			HashMap<String, String> certData = chooseCertificate();
			
			if(certData != null) // cancel button wasn't pressed
			{
				ProgressBarController.restartIndex();
				ProgressBarController.runProgressBar();

				ProgressBarController.setMessage("Obtendo dados do certificado...");					
				ProgressBarController.nextStep();
				
				Certificate cert = CertificateController.getCertByIssuerAndSubject(	certData.get("issuer"),
								                                                    certData.get("subject"));
				
				ProgressBarController.setMessage("Buscando informações de documentos no servidor...");					
				ProgressBarController.nextStep();
	
				// get documents
				HashMap<String, Document> listDocs = JSController.getDocuments();
				
				if(listDocs.isEmpty())
					throw new Exception("Não há documentos para assinar.");				
				
				Iterator<Entry<String, Document>> it = listDocs.entrySet().iterator();
				while (it.hasNext()) {
					Entry<String, Document> pair = it.next();
					
					String documentCode = pair.getKey();
					
					ProgressBarController.setMessage(documentCode + ": Buscando no servidor...");					
					ProgressBarController.nextStep();
				
					byte[] contentDoc = JSController.getDocumentContent(pair);
					
					if(isCopy)
						ProgressBarController.setMessage(documentCode + ": Conferindo documento...");	
					else
						ProgressBarController.setMessage(documentCode + ": Assinando documento...");					
					
					ProgressBarController.nextStep();
				    
				    // sign document
					String signatureB64 = SignatureController.signDocument(contentDoc, cert);
		
					ProgressBarController.setMessage(documentCode + ": Gravando assinatura...");					
					ProgressBarController.nextStep();
					
					//send signature to SIGADOC
					JSController.sendDataToSigadoc(pair.getKey(), isCopy, signatureB64, cert.getSubject().getCommonName());
					
				}	
				
				ProgressBarController.setMessage("Concluído, redirecionando...");
				ProgressBarController.nextStep();
				Thread.sleep(500); //500ms	
				ProgressBarController.finalizeProgressBar();
		
				//redirect to document page
				JSController.redirectToDocumentPage();
				
			}			
			//TODO: Criar códigos de erro e uma mensagem geral. Ex: Um erro ocorreu no processo de assinatura. (COD = 0X00);
		} catch (ObjectNotFoundException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this, "Certificado escolhido não foi encontrado.");
			e.printStackTrace();
		} catch (TokenException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this, "Falha ao acessar um token");
			e.printStackTrace();
		} catch (NotInitializedException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this,	"Falha em inicializar o CryptoManager.");
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this, "Chave privada inválida.");
			e.printStackTrace();
		} catch (SignatureException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this,	"Erro ao criar objeto Signature.");
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this,	"Algoritmo de assinatura inexistente.");
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this, "Provider inexistente.");
			e.printStackTrace();
		} catch (JSException e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this, "Erro ao executar parse Json." + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			ProgressBarController.finalizeProgressBar();
			JOptionPane.showMessageDialog(this, e.getMessage());
			e.printStackTrace();
		}
	}

	private HashMap<String, String> chooseCertificate() throws Exception {

		ArrayList<Certificate> certList;
		certList = CertificateController.getUserCertListByOrganization("RNP");

		HashMap<String, String> certData = null;
		if (certList.isEmpty()) {
			throw new Exception("Nenhum certificado válido encontrado.");
		} else {
			// show window to select a certificate
			DialogChooseCertificate dgChooseCertificate = new DialogChooseCertificate(
					certList);
			certData = dgChooseCertificate.getResult();
		}
		return certData;
	}

}
