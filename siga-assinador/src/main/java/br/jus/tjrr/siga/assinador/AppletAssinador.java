package br.jus.tjrr.siga.assinador;

import java.applet.Applet;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.security.Signature;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.UIManager;

import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.crypto.ObjectNotFoundException;

public class AppletAssinador extends Applet {

	private Logger logger = Logger.getLogger(AppletAssinador.class.getName());

	private Signature signature = null;

	private JButton btnAssinar;

	//private JSObject jsObject;

	@Override
	public void init() {
		super.init();
		//jsObject = (JSObject) JSObject.getWindow(AppletAssinador.this);

		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha ao carregar o layout.", e);
		}

		// Inicializa o Provider "Mozilla-JSS" e o ambiente do CryptoManager
		CryptoManager.InitializationValues valores = new CryptoManager.InitializationValues(
				"/home/matheus/.mozilla/firefox/o0sq08ia.default-1429543362699");
		valores.readOnly = true;

		try {
			CryptoManager.initialize(valores);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Falha em inicializar o CryptoManager.", e);
		}

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

	public void assinar() {
		
		HashMap<String, String> dadosCertificado = escolherCertificado();
		
		if(dadosCertificado != null){
			
			try{
				Certificate cert = CertificateController.getCertByIssuerAndSubject(dadosCertificado.get("issuer"),
						dadosCertificado.get("subject"));
			}catch(ObjectNotFoundException e)
			{
				JOptionPane.showMessageDialog(this, "Certificado escolhido não foi encontrado."); 
			}
		}		
		
		/*
		 * if (!assinador.isWindows()) { //perguntar senha do keystore
		 * DialogoSenha dialogoSenha = new DialogoSenha(); password =
		 * dialogoSenha.getResult(); }
		 */
	}

	public HashMap<String, String> escolherCertificado() {

		ArrayList<Certificate> listaCertificados = CertificateController.getValidCertByOrganization("RNP");
		
		HashMap<String, String> dadosCertificadoEscolhido = null; 
		if (listaCertificados.isEmpty()) 
		{ 
			JOptionPane.showMessageDialog(this, "Nenhum certificado válido encontrado."); 
		} 
		else  //exibe janela para selecionar o certificado
	    {   
			DialogEscolhaCertificado dgEscolhaCertificado = new DialogEscolhaCertificado(listaCertificados);
			dadosCertificadoEscolhido = dgEscolhaCertificado.getResult();			
		} 
		return dadosCertificadoEscolhido;
	}

	/*private Object chamarMetodoJS(String metodo) {
		return jsObject.eval(metodo);
	}

	private Object chamarMetodoJS(String metodo, Object[] parametros) {
		return jsObject.call(metodo, parametros);
	}*/

}
