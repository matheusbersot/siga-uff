package br.jus.tjrr.siga.assinador.controller;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SignatureException;
import java.security.cert.CertificateEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.codec.binary.Base64;
import org.bouncycastle.cert.X509CertificateHolder;
import org.bouncycastle.cert.jcajce.JcaCertStore;
import org.bouncycastle.cms.CMSException;
import org.bouncycastle.cms.CMSProcessableByteArray;
import org.bouncycastle.cms.CMSSignedData;
import org.bouncycastle.cms.CMSSignedDataGenerator;
import org.bouncycastle.cms.CMSTypedData;
import org.bouncycastle.cms.jcajce.JcaSignerInfoGeneratorBuilder;
import org.bouncycastle.operator.ContentSigner;
import org.bouncycastle.operator.OperatorCreationException;
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;
import org.bouncycastle.operator.jcajce.JcaDigestCalculatorProviderBuilder;
import org.bouncycastle.util.Store;
import org.mozilla.jss.CryptoManager;
import org.mozilla.jss.CryptoManager.NotInitializedException;
import org.mozilla.jss.crypto.ObjectNotFoundException;
import org.mozilla.jss.crypto.PrivateKey;
import org.mozilla.jss.crypto.TokenException;

import br.jus.tjrr.siga.assinador.Certificate;
import br.jus.tjrr.siga.assinador.Constants;

public class SignatureController {	
	
	public static String signDocument(byte[] data, Certificate cert) 
			throws ObjectNotFoundException, TokenException, NotInitializedException, 
			CertificateEncodingException, OperatorCreationException, CMSException, IOException, 
			NoSuchAlgorithmException, NoSuchProviderException, InvalidKeyException, SignatureException{

    
		// get private key
		PrivateKey privateKey =  CryptoManager.getInstance().findPrivKeyByCert(cert.getMozillaX509Certificate());
		
		// certificate used to code signed data (public key)
		X509CertificateHolder x509CertHolder = new X509CertificateHolder(cert.getJdkX509Certificate().getEncoded());
		
	    List<X509CertificateHolder> certList = new ArrayList<X509CertificateHolder>();
	    certList.add(x509CertHolder); 		 
	    Store certs = new JcaCertStore(certList);


		// data to be signed
        CMSTypedData inf = new CMSProcessableByteArray(data);

        // algorithm used to sign data
        ContentSigner sha1Signer = new JcaContentSignerBuilder(Constants.ALG_SHA1_WITH_RSA)
                                                            .setProvider(Constants.MOZILLA_JSS_PROVIDER)
                                                            .build(privateKey);
      
        CMSSignedDataGenerator gen = new CMSSignedDataGenerator();
		
		gen.addSignerInfoGenerator(
		                new JcaSignerInfoGeneratorBuilder(
		                     new JcaDigestCalculatorProviderBuilder().setProvider("BC").build())
		                     .build(sha1Signer, x509CertHolder));
		
		gen.addCertificate(x509CertHolder);
		
		//creating pkcs7 detached signature
		CMSSignedData sigData = gen.generate(inf, false);
		String signatureB64 = Base64.encodeBase64String(sigData.getEncoded());
		
		return signatureB64;		
	}
}
