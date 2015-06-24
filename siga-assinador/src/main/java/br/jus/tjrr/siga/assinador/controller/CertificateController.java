package br.jus.tjrr.siga.assinador.controller;

import java.io.ByteArrayInputStream;
import java.security.cert.CertificateExpiredException;
import java.security.cert.CertificateFactory;
import java.security.cert.CertificateNotYetValidException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.CryptoStore;
import org.mozilla.jss.crypto.CryptoToken;
import org.mozilla.jss.crypto.TokenException;
import org.mozilla.jss.crypto.X509Certificate;
import org.mozilla.jss.pkcs11.PK11Module;

import br.jus.tjrr.siga.assinador.Certificate;


public class CertificateController {

	private static Logger logger = Logger.getLogger(CertificateController.class
			.getName());

	public static ArrayList<Certificate> getUserCertListByOrganization(
			String org) throws NotInitializedException  {

		ArrayList<Certificate> certList = new ArrayList<Certificate>();
		CryptoManager cm = CryptoManager.getInstance();
		
		Enumeration moduleList = cm.getModules();

		PK11Module module = null;
		CryptoToken cToken = null;
		while (moduleList.hasMoreElements()) {

			module = (PK11Module) moduleList.nextElement();
			
			logger.log(Level.INFO,module.getName() + " - " + module.getLibraryName());

			Enumeration tokenList = module.getTokens();

			try {

				while (tokenList.hasMoreElements()) {

					cToken = (CryptoToken) tokenList.nextElement();

					if (cToken.isPresent()) {

						CryptoStore cStore = cToken.getCryptoStore();
						X509Certificate[] certs = cStore.getCertificates();

						for (int i = 0; i < certs.length; i++) {

							java.security.cert.X509Certificate jdkCert = null;

							try {
								jdkCert = convertToJdkCert(certs[i]);
								jdkCert.checkValidity();
								
								Boolean isCA = (jdkCert.getBasicConstraints() == -1)? Boolean.FALSE: Boolean.TRUE;
								if(!isCA)
								{
									String issuerDN = certs[i].getIssuerDN().toString();
									if (issuerDN.contains("O=" + org)) {
										certList.add(new Certificate(certs[i],jdkCert, module.getName()));
									}
								}								
								
							} catch (CertificateNotYetValidException e) {
								logger.log(Level.INFO, "Certificado "
										+ certs[i].getNickname()
										+ " não válido.");
							} catch (CertificateExpiredException e) {
								logger.log(Level.INFO, "Certificado "
										+ certs[i].getNickname() + " expirado.");
							}
						}
					}
				}
			} catch (TokenException e) {
				logger.log(Level.SEVERE, "Falha em um token.", e);
			}
		}
		return certList;
	}

	public static Certificate getCertByIssuerAndSubject(String issuer,
			String subject) throws Exception{

		CryptoManager cm = CryptoManager.getInstance();
		
		Enumeration moduleList = cm.getModules();

		PK11Module module = null;
		CryptoToken cToken = null;
		while (moduleList.hasMoreElements()) {

			module = (PK11Module) moduleList.nextElement();
			logger.log(Level.INFO,module.getName());

			Enumeration tokenList = module.getTokens();

			try {

				while (tokenList.hasMoreElements()) {

					cToken = (CryptoToken) tokenList.nextElement();

					if (cToken.isPresent()) {

						CryptoStore cStore = cToken.getCryptoStore();
						X509Certificate[] certs = cStore.getCertificates();

						for (int i = 0; i < certs.length; i++) {
							java.security.cert.X509Certificate jdkCert = null;

							try {
								jdkCert = convertToJdkCert(certs[i]);
								jdkCert.checkValidity();
								String issuerDNCert = certs[i].getIssuerDN().toString();
								String subjectDNCert = certs[i].getSubjectDN().toString();
								if (issuerDNCert.compareTo(issuer) == 0
										&& subjectDNCert.compareTo(subject) == 0) {

									return new Certificate(certs[i], jdkCert, module.getName());
									
								}
							} catch (CertificateNotYetValidException e) {
								logger.log(Level.INFO, "Certificado "
										+ certs[i].getNickname()
										+ " não válido.");
							} catch (CertificateExpiredException e) {
								logger.log(Level.INFO, "Certificado "
										+ certs[i].getNickname() + " expirado.");
							}
						}
					}
				}
			} catch (TokenException e) {
				logger.log(Level.SEVERE, "Falha em um token.", e);
			}
		}

		throw new Exception("Certificado escolhido não foi encontrado.");
	}
	
	private static java.security.cert.X509Certificate convertToJdkCert(X509Certificate cert) {

		CertificateFactory cf;
		java.security.cert.X509Certificate jdkCert = null;

		try {
			cf = CertificateFactory.getInstance("X.509");

			ByteArrayInputStream bais = new ByteArrayInputStream(cert.getEncoded());
			jdkCert = (java.security.cert.X509Certificate) cf.generateCertificate(bais);
			bais.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return jdkCert;
	}
}
