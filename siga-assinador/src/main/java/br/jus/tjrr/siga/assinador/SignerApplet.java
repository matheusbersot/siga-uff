package br.jus.tjrr.siga.assinador;

import java.applet.Applet;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.Security;
import java.security.SignatureException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.UIManager;

import netscape.javascript.JSException;
import netscape.javascript.JSObject;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.ObjectNotFoundException;
import org.mozilla.jss.crypto.TokenException;

public class SignerApplet extends Applet {

	private Logger logger = Logger.getLogger(SignerApplet.class.getName());
	private JButton btnSign;	

	private void initBouncyCastleProvider()
	{
    	Security.addProvider(new BouncyCastleProvider()); 
	}
	
	private void initJsIntegration()
	{
		JSController.setJsObject((JSObject) JSObject.getWindow(this));
	}

	private void initJSSProvider() {
		//TODO: tornar essa inicialização dinâmica
		CryptoManager.InitializationValues values = new CryptoManager.InitializationValues("/home/matheus/.mozilla/firefox/azdj7oq4.default");
		values.readOnly = true;
		values.passwordCallback = new DialogPasswordCallback();

		try {
			CryptoManager.initialize(values);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha em inicializar o CryptoManager.", e);
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

		initJSSProvider();
		//initJsIntegration();
		initBouncyCastleProvider();

		btnSign = new JButton();
		btnSign.setLocation(0, 0);
		btnSign.setText("Assinar");
		btnSign.setSize(130, 20);
		btnSign.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				sign();
			}
		});

		add(btnSign);
		setLayout(null);
	}


	private void sign() {

		try {
			HashMap<String, String> certData = chooseCertificate();

			if (certData != null) {

				Certificate cert = CertificateController.getCertByIssuerAndSubject(	certData.get("issuer"),
								                                                    certData.get("subject"));
				// get document 
				ArrayList<byte[]> listDocs = JSController.getDocuments();
				
				if(listDocs.isEmpty())
					throw new Exception("Não há documentos para assinar.");				
				
				// sign document
				String signatureB64 = SignatureController.signDocument(listDocs.get(0), cert);
				System.out.println(signatureB64);
				
				//send signature to SIGADOC
				String urlPost = JSController.getUrlPost();
				if(urlPost == null)
					throw new Exception("Não há dados para urlPost.");
				
				
				//signDocument(url, documentCode, isCopy, signatureB64, signer);								
			}
			
		} catch (ObjectNotFoundException e) {
			JOptionPane.showMessageDialog(this, "Certificado escolhido não foi encontrado.");
			e.printStackTrace();
		} catch (TokenException e) {
			JOptionPane.showMessageDialog(this, "Falha ao acessar um token");
			e.printStackTrace();
		} catch (NotInitializedException e) {
			JOptionPane.showMessageDialog(this,	"Falha em inicializar o CryptoManager.");
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			JOptionPane.showMessageDialog(this, "Chave privada inválida.");
			e.printStackTrace();
		} catch (SignatureException e) {
			JOptionPane.showMessageDialog(this,	"Erro ao criar objeto Signature.");
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			JOptionPane.showMessageDialog(this,	"Algoritmo de assinatura inexistente.");
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			JOptionPane.showMessageDialog(this, "Provider inexistente.");
			e.printStackTrace();
		} catch (JSException e) {
			JOptionPane.showMessageDialog(this, "Erro ao executar parse Json." + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, e);
			e.printStackTrace();
		}
	}

	private HashMap<String, String> chooseCertificate()
			throws Exception {

		ArrayList<Certificate> certList;
		certList = CertificateController.getUserCertListByOrganization("RNP");

		HashMap<String, String> certData = null;
		if (certList.isEmpty()) {
			throw new Exception ("Nenhum certificado válido encontrado.");
		} else  
		{
			// show window to select a certificate 
			DialogChooseCertificate dgChooseCertificate = new DialogChooseCertificate(certList);
			certData = dgChooseCertificate.getResult();
		}
		return certData;
	}

	
}
