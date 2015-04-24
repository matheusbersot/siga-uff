package br.jus.tjrr.siga.assinador.exception;

public class CertificateNotFoundException extends Exception {

	public CertificateNotFoundException() {
		super();
	}
	
	public CertificateNotFoundException(String msg) {
		super(msg);
	}

	public String getMessage() {
		return super.getMessage();
	}

}
