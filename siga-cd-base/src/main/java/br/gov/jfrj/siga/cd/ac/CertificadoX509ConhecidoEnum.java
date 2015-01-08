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

import java.security.cert.X509Certificate;
import java.util.ArrayList;
/**
 * Enumerador dos certificados X509 conhecidos
 * @author aym
 *
 */
public enum CertificadoX509ConhecidoEnum {
	AC_RAIZ_CURSO(CertificadoACEnum.AC_RAIZ_CURSO.toX509Certificate()),
	AC_SAEC_CURSO(CertificadoACEnum.AC_SAEC_CURSO.toX509Certificate())
	;
	
	
	X509Certificate certificado;
	
	CertificadoX509ConhecidoEnum(X509Certificate certificado) {
		this.certificado = certificado;
	}
	/**
	 * Obt�m todos os certificados X509 conhecidos
	 * @return
	 */
	public static ArrayList<X509Certificate> obterCertificados() {
		ArrayList<X509Certificate> knownCertsList = new ArrayList<X509Certificate>();
		for (CertificadoX509ConhecidoEnum certX509 : CertificadoX509ConhecidoEnum.values()) {
			 knownCertsList.add(certX509.getCertificado());
		 }
		return knownCertsList;
	}
	/**
	 * obt�m o certificado X509 correspondente
	 * @return
	 */
	public X509Certificate  getCertificado() {
		return this.certificado;
	}
	
}
