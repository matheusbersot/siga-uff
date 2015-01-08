/*******************************************************************************
 * Copyright (c) 2006 - 2011 SJRJ.
 * 
 *     This file is part of SIGA.
 * 
 *     SIGA is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     SIGA is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with SIGA.  If not, see <http://www.gnu.org/licenses/>.
 ******************************************************************************/
package br.gov.jfrj.siga.cd.ac;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import java.io.ByteArrayInputStream;
import java.security.cert.CertificateException;
import java.security.cert.TrustAnchor;
import java.security.cert.X509Certificate;
import java.security.cert.CertificateFactory;

/**
 * Enumerador de Certificados de Autoridades Certificadoras (AC)
 * 
 * Sempre que um novo certificado deva ser tratado pelo(s) sistema(s) que
 * utilizam o siga-cd deva ser considerado, o mesmo deve ser inserido neste
 * enumerador
 * 
 * @author aym
 * 
 */
public enum CertificadoACEnum {

	AC_RAIZ_CURSO(
			"AC_RAIZ_CURSO",
			Base64.decode("MIIDBDCCAeygAwIBAgIBATANBgkqhkiG9w0BAQ0FADAzMRYwFAYDVQQDEw1BQyBS"
					+ "YWl6IEN1cnNvMQwwCgYDVQQKEwNSTlAxCzAJBgNVBAYTAkJSMB4XDTEzMTAwNDEw"
					+ "NDQwN1oXDTMzMDkyOTEwNDQwN1owMzEWMBQGA1UEAxMNQUMgUmFpeiBDdXJzbzEM"
					+ "MAoGA1UEChMDUk5QMQswCQYDVQQGEwJCUjCCASIwDQYJKoZIhvcNAQEBBQADggEP"
					+ "ADCCAQoCggEBANG1QHleeZZDLDtFRdX6g7eh3iqi9DK0nUyf+hZO7K78NtKr6Qm/"
					+ "aeKo7fAL1gn4h3h8vVcMbmjuSKF0+srgR4bwXdlSPaggEBbKsc46kEGwAXbvSzwf"
					+ "FeCGMpjxs1RzcONPkC6MS0ihi5u1AvdpL21WROn+VeBmEi1D5zt6sFrvuV3fIbNo"
					+ "LrGSeBneNTS1ySiY7X0rEPXD3BcpGqIsHnJDZr7Jdf65OmgZyqipCIA4AMuZ9wGi"
					+ "ukbyO2lm4hSmqBFYEXChKidSBlz2FGahqYInDW6fnr3wvf8gggXgV6XrOKFfsa/J"
					+ "qd2G130WUxLx/O/LC5dePvuo6fsMne3tIcMCAwEAAaMjMCEwDwYDVR0TAQH/BAUw"
					+ "AwEB/zAOBgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQENBQADggEBAInqfmZWNOSg"
					+ "+vYCybp7F9VfRumdy7OejSwJdZxy+MXI6cZPBw7sI0JvdJ9INzAEuWS3/awIEbh8"
					+ "y/D4DSNjR/Dh13yZ+yfSraGdGJPrV+CghH64BbBOQCtE57qo1CE/oIeSXXUZYbTM"
					+ "ccFV0YCZ961rKGiUXf8b5kISb22g+5RXAoNFnpipZL+TflxBCOxfPy1t+oOGVH86"
					+ "3gdC8Iqc3jNyvQkSLix+vfnhq2OIAdOcAYvYX6OhLe+hceDq4QbaYz5wL2SsaSob"
					+ "HeL3TcstgUeG9ibtRus9Yr6yjwBVUcl2B3ozbEdbSOaKKtiLz1Qho8YofsKRvOt1"
					+ "HaR5xWiMEI4=")),
	AC_SAEC_CURSO(
			"AC_SAEC_CURSO",
			Base64.decode("MIIEZDCCA0ygAwIBAgIBFTANBgkqhkiG9w0BAQUFADAzMRYwFAYDVQQDEw1BQyBS"
					+ "YWl6IEN1cnNvMQwwCgYDVQQKEwNSTlAxCzAJBgNVBAYTAkJSMB4XDTE0MTExODA5"
					+ "MjYwOFoXDTI0MTExNTA5MjYwOFowFTETMBEGA1UEAxMKU0FFQyBDdXJzbzCCAiIw"
					+ "DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKjUqnI8o0Am0dJShrsi7ixtj+Y4"
					+ "wHL55fnfRpIgobJnplV5wDJPgKzBOXlXehfno9UxMmeZj7IxI/jzSctYCYx3ng8v"
					+ "SgiXdjVFrCe8f6/yoqthMV5Gz1LuOmHFEi/KFHjUGhqbxa7lLziJQBkS2U+qQuy6"
					+ "2fcYPhgt5zrDcf5KBZUyTK8fU8fIBPlsFTKBkUlMcVJkGJNo/UOIrEDrDEBwI0pp"
					+ "vb1ZH4CvthshN31I5kbPg67V4a17XEsmv39eCioesDxKp6kbaBcPfRS6kTEPzlpS"
					+ "uJJPqrwxOImwOSmDVqbWWvUggbUl1tRe0Kp3Xlon2vfperRJvmlG/7CqJKYSIa1T"
					+ "i+3NWMzYYjAZiVVFT9d+ww6IMaia734M7wmya6RAj9PJTzdjWsCxOP3uWEIzkT8X"
					+ "hmzjdhrQ1hFKhaO16+6Y3BXIU/zfwysPu7JGGwdgG2OZxfHPCSY7Crzl9H3STV8V"
					+ "2jeBJVm/3HRHPgOvcHGASGzs6isbHttiEfUkahbHDDFjYQ44mzWJ3AeUu1APD7pg"
					+ "ihLWGFqmZx2oq/ANTGJSOBMPOMfQM4I5LYn7UUigWdIEfFjPNJGDPWor7TWegawO"
					+ "kHnv36Ag5179HwtfqIkkLJ5cZO9gHVrXfgfhIbgEqVK6qQ7/NQ9WoVe4WAYvC7ON"
					+ "ow0C+lWMR8ZVZionAgMBAAGjgaAwgZ0wHQYDVR0OBBYEFHOUjkrSFqlx9vl9lL83"
					+ "PjWaBRZDMFsGA1UdIwRUMFKAFLYH2KL4V/oQAC6dUF5xy0Ef7tInoTekNTAzMRYw"
					+ "FAYDVQQDEw1BQyBSYWl6IEN1cnNvMQwwCgYDVQQKEwNSTlAxCzAJBgNVBAYTAkJS"
					+ "ggEBMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgGGMA0GCSqGSIb3DQEB"
					+ "BQUAA4IBAQBQC9vGrwXwib9nAfWuguy3289wwwzcxQdi89c+RKjmQejSm+LvkDKi"
					+ "OSddTjBobd5BaFiAS8dkh+PwwY6VyvZdcC646TTs7s38MPWE8e7VKsgnXlF2nQJY"
					+ "CNwS5kujiYNYxVbcnjG/GTrjPgSipbSLb7kAiL5oQzg7zqHmg7iYzys35ZZ+vB1A"
					+ "USV/Ym9X/wNP59R0+DdmnpT+dZaNcdf95YcVTC8Ya6admsZLnNvOUf4ECJChxJc8"
					+ "IGQOUOiJsxaes5lYazweC/lWwo6YPmzP0C7xwT4simkoTmbJwUI1S6I3Fgse3gZ+"
					+ "Zi2F9SbI8jKmpuXQ/H/8kUGhJ1MPApoL")
			)

	;

	private final String nome;
	private final byte[] certificado;

	CertificadoACEnum(String nome, byte[] certificado) {
		this.nome = nome;
		this.certificado = certificado;
	}

	public String getNome() {
		return nome;
	}

	public byte[] getCertificado() {
		return this.certificado;
	}

	public String toString() {
		return nome;
	}

	public boolean seHomonimaA(CertificadoACEnum outra) {
		if (outra == null)
			return false;
		return outra.getNome().equals(this.getNome());
	}

	public boolean seTemCertificadoIdenticoA(CertificadoACEnum outra) {
		if (outra == null)
			return false;
		if (outra.getCertificado().length != this.getCertificado().length)
			return false;
		for (int i = 0; i < outra.getCertificado().length; i++) {
			if (outra.getCertificado()[i] != this.getCertificado()[i])
				return false;
		}
		return true;
	}

	/**
	 * obtém o certificado como TrustAnchor (Certificado auto assinado
	 * confiável)
	 * 
	 * @return
	 */
	public TrustAnchor toTrustAnchor() {
		try {
			return new TrustAnchor(
					(X509Certificate) (CertificateFactory.getInstance("X.509")).generateCertificate(new ByteArrayInputStream(
							this.getCertificado())), null);
		} catch (CertificateException e) {
			return null;
		}

	}

	/**
	 * obtém o certificado como X509Certificate
	 * 
	 * @return
	 */
	public X509Certificate toX509Certificate() {
		try {
			return (X509Certificate) (CertificateFactory.getInstance("X.509"))
					.generateCertificate(new ByteArrayInputStream(this
							.getCertificado()));
		} catch (CertificateException e) {
			return null;
		}
	}
}
