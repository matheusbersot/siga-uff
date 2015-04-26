package br.jus.tjrr.siga.assinador;

import java.applet.Applet;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.Signature;
import java.security.SignatureException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.UIManager;

import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.ObjectNotFoundException;
import org.mozilla.jss.crypto.TokenException;

import br.jus.tjrr.siga.assinador.exception.CertificateNotFoundException;

public class AppletAssinador extends Applet {

	private Logger logger = Logger.getLogger(AppletAssinador.class.getName());
	private JButton btnAssinar;

	// private JSObject jsObject;

	@Override
	public void init() {
		super.init();
		// jsObject = (JSObject) JSObject.getWindow(AppletAssinador.this);

		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha ao carregar o layout.", e);
		}

		initCryptoManager();

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

				// obter documento para assinar
				String dados = new String("AAAAAAAAAAAAAAA");
				byte[] data = dados.getBytes();
				CertificateController.signDocument(data, cert);
			}

		} catch (CertificateNotFoundException e) {
			JOptionPane.showMessageDialog(this,
					"Certificado escolhido n�o foi encontrado.");
		} catch (ObjectNotFoundException e) {
			JOptionPane.showMessageDialog(this,
					"Certificado escolhido n�o foi encontrado.");
		} catch (TokenException e) {
			JOptionPane.showMessageDialog(this, "Falha ao acessar um token");
		} catch (NotInitializedException e) {
			JOptionPane.showMessageDialog(this,
					"Falha em inicializar o CryptoManager.");
		} catch (InvalidKeyException e) {
			JOptionPane.showMessageDialog(this, "Chave privada inv�lida.");
		} catch (SignatureException e) {
			JOptionPane.showMessageDialog(this,
					"Erro ao criar objeto Signature.");
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			JOptionPane.showMessageDialog(this,
					"Algoritmo de assinatura inexistente.");
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			JOptionPane.showMessageDialog(this, "Provider inexistente.");
		} 
	}

	public HashMap<String, String> escolherCertificado()
			throws NotInitializedException {

		ArrayList<Certificate> listaCertificados;
		listaCertificados = CertificateController
				.getValidCertByOrganization("RNP");

		HashMap<String, String> dadosCertificadoEscolhido = null;
		if (listaCertificados.isEmpty()) {
			JOptionPane.showMessageDialog(this,
					"Nenhum certificado v�lido encontrado.");
		} else // exibe janela para selecionar o certificado
		{
			DialogEscolhaCertificado dgEscolhaCertificado = new DialogEscolhaCertificado(
					listaCertificados);
			dadosCertificadoEscolhido = dgEscolhaCertificado.getResult();
		}
		return dadosCertificadoEscolhido;
	}

	/*
	 * private Object chamarMetodoJS(String metodo) { return
	 * jsObject.eval(metodo); }
	 * 
	 * private Object chamarMetodoJS(String metodo, Object[] parametros) {
	 * return jsObject.call(metodo, parametros); }
	 */

}
