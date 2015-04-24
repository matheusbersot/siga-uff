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

	AC_RAIZ_ICPEDU_V2(
			"AC_RAIZ_ICPEDU_V2",
			Base64.decode("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")),
	AC_PESSOAS_P5(
			"AC_PESSOAS_P5",
			Base64.decode("MIIGIzCCBAugAwIBAgIBCDANBgkqhkiG9w0BAQUFADBbMQswCQYDVQQGEwJCUjEP"
					+ "MA0GA1UEChMGSUNQRURVMQwwCgYDVQQKEwNSTlAxDjAMBgNVBAsTBUdPUEFDMR0w"
					+ "GwYDVQQDExRBQyBSYWl6IGRhIElDUEVEVSBWMjAeFw0xNTAzMjgwMDIxMzBaFw0z"
					+ "NTAzMjgwMDIxMzBaMIGIMRYwFAYDVQQDEw1BQyBQZXNzb2FzIFA1MQswCQYDVQQI"
					+ "EwJTQzELMAkGA1UEBhMCQlIxHTAbBgkqhkiG9w0BCQEWDmNjZEBpY3AuZWR1LmJy"
					+ "MQwwCgYDVQQKEwNSTlAxDzANBgNVBAsTBklDUEVkdTEWMBQGA1UEBxMNRmxvcmlh"
					+ "bm9wb2xpczCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAL78iamBZps5"
					+ "YSv4kUx3Qp9J7tDAYBZYKPaQbe5aiTqbDYEH6yR3Q/0HZJsXWR8wov0vk6XiexiM"
					+ "0gFgLnLy5HrECH5Ehh6JNDaBbYJINipNdvllQizDc7KIKkEKKFbC7TnRCPfHUkc/"
					+ "66RyMyQXgBKegTPO65J5baBpMQZCRlEMPhkg7NWDNl3J1cF97PtDGOZGB9XAv9tv"
					+ "xxnkeWmj84/J+9M6ArpuK6IcS2LjmlubPtRVj9shZm52JzDliCJuqM8pMgw6W4J2"
					+ "pDLjJp7EOTKU14eKuolMlvW5F6FDoy19fkpzchMpcZ3KpMG+xbsxcdPa3C6sXpet"
					+ "clao9tBRtOX8rlE9eISSRy3btmz2VmJRlFfmtI6q6dDLdm71wbEX7+fi3kimgReT"
					+ "NzVwuglhaH/NSniX9bjKn1aVHSMmDOdcuEmlY9Sj2Uzt0hL40/mjXziYVQ/Nm6J/"
					+ "pUiBqHFADeDjyCFef5s9J7eSt7/GWJPwKusQaPYhjfJQSwMTKBe1LNkSJwYVDzm6"
					+ "2nZxlR/fN9h4pGPJEHV5oLS3RNRdSn9RqPs2CkP5R0FyD/L5b9M1yd8wEsJzZUi3"
					+ "Z0bacg/Y5IZ2dlwNtLwz3KtTiVLQDh2lxxPFVAyGw8pAUwDb7sFipovQ++BMoZtM"
					+ "LFBt5OvzM2T1WqNhuppVi1S5FHuk2Nm1AgMBAAGjgcMwgcAwDAYDVR0TBAUwAwEB"
					+ "/zCBgwYDVR0jBHwweoAUgoJLN16y2HnezTDh1R0+CeNlJrehX6RdMFsxCzAJBgNV"
					+ "BAYTAkJSMQ8wDQYDVQQKEwZJQ1BFRFUxDDAKBgNVBAoTA1JOUDEOMAwGA1UECxMF"
					+ "R09QQUMxHTAbBgNVBAMTFEFDIFJhaXogZGEgSUNQRURVIFYyggEBMB0GA1UdDgQW"
					+ "BBRW1dZkdxOZEnMmHmnaufuGq+hTvzALBgNVHQ8EBAMCAYYwDQYJKoZIhvcNAQEF"
					+ "BQADggIBAI62/ygR9WdERrDsJUrSi65b+em8JxeGzVtIhPGWN8rNLfvM7f1oKX5b"
					+ "Poo6v+8zT8PRfiR4Wr69WLFo5W2Zw9hGFOOLDcOMZUcEKW4zQ33k/BOggce0A/D0"
					+ "AgMWj80hDeZNke9xN/J0HiloAfLBqYy6t18EYiN4cRyrNWtsudlnhMm7Kpma5XCX"
					+ "sakC7xCA32hACheNunFvPZtgzWkNmnr/8DEzEhheq0qd7Bjl72JLbzZtUWsgRclS"
					+ "h/yeFHCb8qBiuMpL10V7kfgR6Q5wXkxGiNs7iqKCo+1yCoOMm7hvei5lvcWsZwkU"
					+ "sJSnlmNQQlxiGFo/L9qih6uYZgX9XRUzcw9BJ4I4HYtYzqrUMtan/5Hw4umjdosY"
					+ "Y1ImNJQ+0uihMJMIK4jOaKxzZh6QrQqNsh7afHrLImPFRAl7O9lQZ85MDc4J1vUg"
					+ "vh29BD0iWJzTe6u9QFOruiSICJTUqybLhpHkmSmK3T2xXdGrQJGaHip0mzbRfEng"
					+ "rkz0A46Av039eE/g/aD1de0ZbOynx7eLDK/+qk0cPlKyVTiq2cB93fke5eQko8sE"
					+ "pESS0glxKJgnpk0xyB/p1Pqv4WhMC9p1HHn3G/1k+juBVUp/ti57mQoMwcLNzV+M"
					+ "sWIZgYT0P845/zK3POqeT3txaXlLzhmkrCmYgeVPhBY7iNPlqq9w"));					
	 

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
