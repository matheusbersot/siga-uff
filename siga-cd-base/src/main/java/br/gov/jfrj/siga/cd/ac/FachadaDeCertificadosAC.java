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

import java.io.ByteArrayInputStream;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.security.cert.TrustAnchor;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Collection;

import javax.security.auth.x500.X500Principal;

/**
 * Fachada para acesso aos Certificados
 * 
 * @author aym
 * 
 */
public class FachadaDeCertificadosAC {
	/**
	 * Monta e ordena uma cadeia de certificados juntamente com os certificados
	 * conhecidos e �ncoras confi�veis
	 * 
	 * @param certs
	 *            cadeia de certificados recebida para a ordena��o
	 * @return
	 * @throws Exception
	 */
	public static X509Certificate[] montarCadeiaOrdenadaECompleta(
			Collection<X509Certificate> certs) throws Exception {
		final ArrayList<X509Certificate> certsList = new ArrayList<X509Certificate>();
		// adiciona os certificados recebidos (par�metro) � lista de
		// certificados
		for (final Certificate cert : certs) {
			final ByteArrayInputStream bais = new ByteArrayInputStream(cert
					.getEncoded());
			final X509Certificate x509 = (X509Certificate) (CertificateFactory
					.getInstance("X.509")).generateCertificate(bais);
			certsList.add(0, x509);
		}
		// Acrescenta os certificados faltantes para completar a cadeia
		//
		boolean fContinue;
		do {
			fContinue = false;
			for (X509Certificate x509 : certsList) {
				boolean fFound = false;
				X500Principal issuer = x509.getIssuerX500Principal();
				for (X509Certificate otherX509 : certsList) {
					if (issuer.equals(otherX509.getSubjectX500Principal())) {
						fFound = true;
						break;
					}
				}
				if (!fFound) {
					for (X509Certificate otherX509 : CertificadoX509ConhecidoEnum
							.obterCertificados()) {
						if (issuer.equals(otherX509.getSubjectX500Principal())) {
							certsList.add(otherX509);
							fFound = true;
							fContinue = true;
							break;
						}
					}
				}
				if (fContinue)
					break;
				if (!fFound) {
					throw new Exception(
							"N�o foi poss�vel montar a cadeia completa de certifica��o");
				}
			}
		} while (fContinue);

		// APARENTEMENTE ISSO EST� CORRETO, NO ENTANTO, NO ACROBAT O CARIMBO N�O
		// APARECE. DEVE SER PORQUE EST� DANDO ERRO DE VALIDA��O POR FALTA DE UM
		// FLAG "CRICTICAL".

		int cCerts = certsList.size();
		final ArrayList<X509Certificate> certsListSorted = new ArrayList<X509Certificate>();
		boolean hasTrustedAnchor = false;
		for (X509Certificate x509 : certsList) {
			for (TrustAnchor trustedAnchor : TrustAnchorEnum
					.obterTrustAnchors()) {
				if (!hasTrustedAnchor
						&& trustedAnchor.getTrustedCert().equals(x509)) {
					hasTrustedAnchor = true;
					certsListSorted.add(trustedAnchor.getTrustedCert());
				}
			}
			// if (trustedAnchors.contains(x509))
		}
		if (!hasTrustedAnchor)
			throw new Exception(
					"Cadeia de certifica��o n�o est� relacionada com a ra�z da ICP-Brasil");

		boolean fExit = false;
		while (!fExit) {
			fExit = true;
			for (X509Certificate x509 : certsList) {
				if (x509.getIssuerX500Principal().equals(
						certsListSorted.get(0).getSubjectX500Principal())
						&& !x509.equals(certsListSorted.get(0))) {
					certsListSorted.add(0, x509);
					fExit = false;
				}
			}
		}

		if (certsListSorted.size() != cCerts)
			throw new Exception(
					"Cadeia de certifica��o n�o est� corretamente encadeada ou n�o est� relacionada com a ra�z da ICP-Brasil");

		// X509Certificate cadeiaTotal[];
		final X509Certificate cadeiaTotal[] = new X509Certificate[certsListSorted
				.size()];
		certsListSorted.toArray(cadeiaTotal);
		return cadeiaTotal;
	}
	public static ArrayList<TrustAnchor> getTrustAnchors() {
		return TrustAnchorEnum.obterTrustAnchors();
	}
	public static ArrayList<X509Certificate> getCertificadosConhecidos() {
		return CertificadoX509ConhecidoEnum.obterCertificados();
	}
}
