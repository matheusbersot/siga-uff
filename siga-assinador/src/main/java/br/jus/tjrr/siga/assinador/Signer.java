package br.jus.tjrr.siga.assinador;

import java.io.IOException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.Provider;
import java.security.Security;
import java.security.cert.CertificateException;
import java.security.cert.CertificateExpiredException;
import java.security.cert.CertificateNotYetValidException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Signer {

    private KeyStore keyStore = null;

    private boolean windows;

    private Logger logger = Logger.getLogger(Signer.class.getName());

    
    public Signer() {
        windows = System.getProperty("os.name").contains("Windows");
    }    

    public KeyStore carregarKeyStore(char[] password) throws NoSuchProviderException, KeyStoreException, CertificateException, NoSuchAlgorithmException, IOException {

        Provider[] providers = Security.getProviders();
        for (int i = 0; i < providers.length; i++) {
            final String name = providers[i].getName();
            System.out.println(name);
        }
    	
        if (System.getProperty("os.name").contains("Windows")) {
            //Windows
            keyStore = KeyStore.getInstance("Windows-MY", "SunMSCAPI");
            keyStore.load(null, null);
        } else {
            //Linux
            keyStore = KeyStore.getInstance("PKCS11", "SunPKCS11");
            
            /*try {
                keyStore.load(pkcs11LoadStoreParameter);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Erro ao carregar keyStore", e);
            }*/
        }
        return keyStore;
    }

    public List<String> listAliases() {
        ArrayList<String> listAliases = new ArrayList<String>();

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");

        try {
            Iterator<String> iterator = Collections.list(keyStore.aliases()).iterator();

            while (iterator.hasNext()) {
                String alias = iterator.next();
                X509Certificate x509Certificate = (X509Certificate) keyStore.getCertificate(alias);
                try {
                    x509Certificate.checkValidity();
                    listAliases.add(alias);
                } catch (CertificateNotYetValidException e) {
                    logger.log(Level.INFO, "Certificado para o alias " + alias + " não válido.");
                } catch (CertificateExpiredException e) {
                    logger.log(Level.INFO, "Certificado para o alias " + alias + " expirado.");
                }
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erro ao carregar lista de aliases", e);
        }

        return listAliases;
    }

    public boolean isWindows() {
        return windows;
    }

    public void setWindows(boolean windows) {
        this.windows = windows;
    }

}
