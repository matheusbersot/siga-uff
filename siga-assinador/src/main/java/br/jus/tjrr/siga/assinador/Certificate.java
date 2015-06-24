package br.jus.tjrr.siga.assinador;

import java.text.SimpleDateFormat;

import org.mozilla.jss.asn1.INTEGER;
import org.mozilla.jss.crypto.X509Certificate;

public class Certificate {
	
	private java.security.cert.X509Certificate jdkCert;
	private X509Certificate cert;
	private DN issuer;
	private DN subject;
	private INTEGER serialNumber;
	private boolean fromSmartCard;
	
	public Certificate(X509Certificate cert, java.security.cert.X509Certificate jdkCert, String moduleName)
	{
		this.jdkCert = jdkCert;
		this.issuer = new DN(cert.getIssuerDN().getName());
		this.subject = new DN(cert.getSubjectDN().getName());
		this.serialNumber = new INTEGER(cert.getSerialNumber());
		this.cert = cert;
		this.fromSmartCard = (moduleName.compareTo(Constants.INTERNAL_CERTIFICATE) == 0)? false: true;
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
	
	public INTEGER getSerialNumber()
	{
		return serialNumber;
	}	
	
	public X509Certificate getMozillaX509Certificate() {
		return cert;
	}
	
	public java.security.cert.X509Certificate getJdkX509Certificate()
	{
		return jdkCert;
	}
	
	public boolean fromSmartCard()
	{
		return fromSmartCard;
	}
}
