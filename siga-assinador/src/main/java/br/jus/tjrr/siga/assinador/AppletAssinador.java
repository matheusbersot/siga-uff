package br.jus.tjrr.siga.assinador;

import java.applet.Applet;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
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

import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.ObjectNotFoundException;
import org.mozilla.jss.crypto.TokenException;

import br.jus.tjrr.siga.assinador.exception.CertificateNotFoundException;

public class AppletAssinador extends Applet {

	private Logger logger = Logger.getLogger(AppletAssinador.class.getName());
	private JButton btnAssinar;	

	@Override	
	public void init() {
		
		super.init();
		
		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha ao carregar o layout.", e);
		}

		initCryptoManager();
		initJsIntegration();

		btnAssinar = new JButton();
		btnAssinar.setLocation(0, 0);
		btnAssinar.setText("Assinar");
		btnAssinar.setSize(130, 20);
		btnAssinar.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				assinar();
			}
		});

		add(btnAssinar);
		setLayout(null);
	}
	
	public void initJsIntegration()
	{
		JSController.setJsObject( (JSObject) JSObject.getWindow(AppletAssinador.this));
	}

	public void initCryptoManager() {
		// Inicializa o Provider "Mozilla-JSS" e o ambiente do CryptoManager
		CryptoManager.InitializationValues valores = new CryptoManager.InitializationValues(
				"/home/matheus/.mozilla/firefox/o0sq08ia.default-1429543362699");
		valores.readOnly = true;
		valores.passwordCallback = new DialogPasswordCallback();

		try {
			CryptoManager.initialize(valores);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha em inicializar o CryptoManager.", e);
		}
	}

	public void assinar() {

		try {
			HashMap<String, String> dadosCertificado = escolherCertificado();

			if (dadosCertificado != null) {

				Certificate cert = CertificateController
						.getCertByIssuerAndSubject(
								dadosCertificado.get("issuer"),
								dadosCertificado.get("subject"));
				
				// obter documentos para assinar
				ArrayList<byte[]> listDocs = JSController.getDocuments();				
				
				// assinar documentos
				String signatureB64 = CertificateController.signDocument(listDocs.get(0), cert);
				JOptionPane.showMessageDialog(this, signatureB64);				
			}

		} catch (CertificateNotFoundException e) {
			JOptionPane.showMessageDialog(this,
					"Certificado escolhido não foi encontrado.");
		} catch (ObjectNotFoundException e) {
			JOptionPane.showMessageDialog(this,
					"Certificado escolhido não foi encontrado.");
		} catch (TokenException e) {
			JOptionPane.showMessageDialog(this, "Falha ao acessar um token");
		} catch (NotInitializedException e) {
			JOptionPane.showMessageDialog(this,
					"Falha em inicializar o CryptoManager.");
		} catch (InvalidKeyException e) {
			JOptionPane.showMessageDialog(this, "Chave privada inválida.");
		} catch (SignatureException e) {
			JOptionPane.showMessageDialog(this,
					"Erro ao criar objeto Signature.");
		} catch (NoSuchAlgorithmException e) {
			JOptionPane.showMessageDialog(this,
					"Algoritmo de assinatura inexistente.");
		} catch (NoSuchProviderException e) {
			JOptionPane.showMessageDialog(this, "Provider inexistente.");
		} catch (JSException e) {
			JOptionPane.showMessageDialog(this, "Erro ao executar parse Json." + e.getMessage());
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "Não foi possível completar a operação: " + e);
		}
	}

	private HashMap<String, String> escolherCertificado()
			throws NotInitializedException {

		ArrayList<Certificate> listaCertificados;
		listaCertificados = CertificateController
				.getValidCertByOrganization("RNP");

		HashMap<String, String> dadosCertificadoEscolhido = null;
		if (listaCertificados.isEmpty()) {
			JOptionPane.showMessageDialog(this,
					"Nenhum certificado válido encontrado.");
		} else // exibe janela para selecionar o certificado
		{
			DialogEscolhaCertificado dgEscolhaCertificado = new DialogEscolhaCertificado(
					listaCertificados);
			dadosCertificadoEscolhido = dgEscolhaCertificado.getResult();
		}
		return dadosCertificadoEscolhido;
	}

	
}
