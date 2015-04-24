package br.jus.tjrr.siga.assinador;

import java.text.SimpleDateFormat;

import org.mozilla.jss.crypto.X509Certificate;

public class Certificate {
	
	private java.security.cert.X509Certificate jdkCert;
	private X509Certificate cert;
	private DN issuer;
	private DN subject;
	private boolean smartCard;
	
	public Certificate(X509Certificate cert, java.security.cert.X509Certificate jdkCert, String nomeModulo)
	{
		this.jdkCert = jdkCert;
		this.issuer = new DN(cert.getIssuerDN().getName());
		this.subject = new DN(cert.getSubjectDN().getName());
		this.cert = cert;
	}
		
	public String getNotBefore(SimpleDateFormat sDf)
	{
		return sDf.format(jdkCert.getNotBefore());
	}
	
	public String getNotAfter(SimpleDateFormat sDf)
	{
		return sDf.format(jdkCert.getNotAfter());
	}

	public DN getIssuer() {
		return issuer;
	}

	public DN getSubject() {
		return subject;
	}
	
	public X509Certificate getMozillaX509Certificate() {
		return cert;
	}
	
	public boolean fromSmartCard(String nomeModulo)
	{
		//TODO: Tentar colocar a leitora para funcionar e ler o nome do módulo Gemalto
		return false;
	}
}
