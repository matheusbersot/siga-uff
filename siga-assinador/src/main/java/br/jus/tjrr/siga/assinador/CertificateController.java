package br.jus.tjrr.siga.assinador;

import java.io.ByteArrayInputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.Signature;
import java.security.SignatureException;
import java.security.cert.CertificateExpiredException;
import java.security.cert.CertificateFactory;
import java.security.cert.CertificateNotYetValidException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.CryptoStore;
import org.mozilla.jss.crypto.CryptoToken;
import org.mozilla.jss.crypto.ObjectNotFoundException;
import org.mozilla.jss.crypto.PrivateKey;
import org.mozilla.jss.crypto.TokenException;
import org.mozilla.jss.crypto.X509Certificate;
import org.mozilla.jss.pkcs11.PK11Module;

import br.jus.tjrr.siga.assinador.exception.CertificateNotFoundException;

public class CertificateController {

	private static Logger logger = Logger.getLogger(CertificateController.class
			.getName());

	public static ArrayList<Certificate> getValidCertByOrganization(
			String organizacao) throws NotInitializedException  {

		ArrayList<Certificate> certificados = new ArrayList<Certificate>();
		CryptoManager cm = CryptoManager.getInstance();
		
		Enumeration listaModulos = cm.getModules();

		PK11Module modulo = null;
		CryptoToken cToken = null;
		while (listaModulos.hasMoreElements()) {

			modulo = (PK11Module) listaModulos.nextElement();
			System.out.println(modulo.getName());

			Enumeration listaTokens = modulo.getTokens();

			try {

				while (listaTokens.hasMoreElements()) {

					cToken = (CryptoToken) listaTokens.nextElement();

					if (cToken.isPresent()) {

						CryptoStore cStore = cToken.getCryptoStore();
						X509Certificate[] certs = cStore.getCertificates();

						for (int i = 0; i < certs.length; i++) {

							java.security.cert.X509Certificate jdkCert = null;

							try {
								jdkCert = convertToJdkCert(certs[i]);
								jdkCert.checkValidity();
								String issuerDN = certs[i].getIssuerDN()
										.toString();
								String orgProcurada = "O=" + organizacao;
								if (issuerDN.contains(orgProcurada)) {

									certificados.add(new Certificate(certs[i],
											jdkCert, modulo.getName()));
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
		return certificados;
	}

	private static java.security.cert.X509Certificate convertToJdkCert(
			X509Certificate cert) {

		CertificateFactory cf;
		java.security.cert.X509Certificate jdkCert = null;

		try {
			cf = CertificateFactory.getInstance("X.509");

			ByteArrayInputStream bais = new ByteArrayInputStream(
					cert.getEncoded());
			jdkCert = (java.security.cert.X509Certificate) cf
					.generateCertificate(bais);
			bais.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return jdkCert;
	}

	public static Certificate getCertByIssuerAndSubject(String issuer,
			String subject) throws CertificateNotFoundException, NotInitializedException{

		CryptoManager cm = CryptoManager.getInstance();
		
		Enumeration listaModulos = cm.getModules();

		PK11Module modulo = null;
		CryptoToken cToken = null;
		while (listaModulos.hasMoreElements()) {

			modulo = (PK11Module) listaModulos.nextElement();
			System.out.println(modulo.getName());

			Enumeration listaTokens = modulo.getTokens();

			try {

				while (listaTokens.hasMoreElements()) {

					cToken = (CryptoToken) listaTokens.nextElement();

					if (cToken.isPresent()) {

						CryptoStore cStore = cToken.getCryptoStore();
						X509Certificate[] certs = cStore.getCertificates();

						for (int i = 0; i < certs.length; i++) {
							java.security.cert.X509Certificate jdkCert = null;

							try {
								jdkCert = convertToJdkCert(certs[i]);
								jdkCert.checkValidity();
								String issuerDNCert = certs[i].getIssuerDN()
										.toString();
								String subjectDNCert = certs[i].getSubjectDN()
										.toString();
								if (issuerDNCert.compareTo(issuer) == 0
										&& subjectDNCert.compareTo(subject) == 0) {

									return new Certificate(certs[i], jdkCert,
											modulo.getName());
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

		throw new CertificateNotFoundException();
	}

	public static void signDocument(byte[] data, Certificate cert) 
			throws ObjectNotFoundException,TokenException, NotInitializedException, SignatureException, NoSuchAlgorithmException, NoSuchProviderException, InvalidKeyException{

		// get private key
		PrivateKey privKey = CryptoManager.getInstance().findPrivKeyByCert(cert.getMozillaX509Certificate());
		
		//set algorithm, provider and private key to Signature
		Signature s = Signature.getInstance(Constants.ALG_SHA256_WITH_RSA, Constants.MOZILLA_JSS_PROVIDER);
		s.initSign(privKey);
		
		// set data to be signed
		s.update(data);
		
		//signing
		byte signature[] = s.sign();
		
		String base64String = Base64.getEncoder().encodeToString(signature);
		System.out.println(base64String);
		
	}

}
