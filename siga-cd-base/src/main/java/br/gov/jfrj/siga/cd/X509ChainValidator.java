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
package br.gov.jfrj.siga.cd;

import java.security.InvalidAlgorithmParameterException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.cert.CRLException;
import java.security.cert.CertPath;
import java.security.cert.CertPathValidator;
import java.security.cert.CertPathValidatorException;
import java.security.cert.CertStore;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.CollectionCertStoreParameters;
import java.security.cert.PKIXCertPathChecker;
import java.security.cert.PKIXCertPathValidatorResult;
import java.security.cert.PKIXParameters;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.Vector;

import org.bouncycastle.jce.provider.X509CRLObject;

/**
 * Classe respons�vel por realizar a valida��o de um certificado. � verificada
 * toda a cadeia de certifica��o, assim como as CRLs dos certificados existentes
 * na cadeia. Por default, X509ChainValidator n�o faz a verifica��o das CRLs.
 * Para tanto deve-se chamar o m�todo checkCRL(true).
 * 
 * @author mparaiso
 */
public class X509ChainValidator {
	private static final String XCN_OID_ENHANCED_KEY_USAGE = "2.5.29.37";
	/** */
	private Vector<X509Certificate> certChain;

	/** */
	@SuppressWarnings("unchecked")
	private Set trustedAnchors;

	/** */
	@SuppressWarnings("unchecked")
	private Collection crls;

	/** */
	private boolean checkCRL = false;

	private X509Certificate certificates[];

	@SuppressWarnings("unchecked")
	public Collection getCrls() {
		return crls;
	}

	/**
	 * M�todo interno para ler todas CRLs de todos os certificados passados para
	 * o objeto.
	 * 
	 * Este m�todo varre todos os certificados passados para este objeto no
	 * construtor e monta uma lista com as CRLs dos certificados. Isso � feito
	 * para que se possa testar o status de revoga��o dos mesmos. � importante
	 * lembrar que este m�todo normalmente s� � utilizado caso a verifica��o de
	 * CRL estiver habilitada.
	 * 
	 * Este m�todo usa o CRLLocator para abrir o certificado e baixar a CRL.
	 * 
	 * @see br.com.certisign.utlis.CRLLocator
	 * 
	 * @throws ChainValidationException
	 */
	public static Collection<X509CRLObject> getCRLs(X509Certificate[] certChain)
			throws ChainValidationException {
		Collection<X509CRLObject> crls = new Vector<X509CRLObject>();

		try {
			for (X509Certificate cert : certChain) {
				final CRLLocator crl = new CRLLocator(cert);
				if (crl.uri != null)
					crls.add(crl.getCRL());
			}
		} catch (final InvalidCRLException e) {
			throw new ChainValidationException(
					"Falha ao carregar a CRL do certificado! ", e);
		} catch (CRLException e) {
			throw new ChainValidationException("Falha na CRL do certificado! ",
					e);
		}
		return crls;
	}

	/**
	 * Este m�todo gera, a partir de uma cadeia de certificados completa, uma
	 * cadeia de certificados v�lida para o algor�tmo de valida��o de cadeias
	 * PKIX. � levado em considera��o que a cadeia de certificados passada como
	 * par�metro esteja bem formada e em ordem crescente, ou seja, o primeiro
	 * certificado deve ser o certificado a ser autenticado, seguido do
	 * certificado do seu emissor (AC Intermedi�ria) e assim por diante.
	 * 
	 * @param certificados
	 *            - Cadeia de certificados completa, incluindo o certificado
	 *            raiz.
	 * @return A cadeia de certificados sem o certificado raiz.
	 */
	@SuppressWarnings("unchecked")
	private Vector getWellFormedChain(final X509Certificate certificates[]) {

		final Vector wellFormedChain = new Vector();

		// O certificado raiz � descartado, considerando-se que � o �ltimo da
		// matriz de certificados passada.
		for (int index = 0; index < certificates.length - 1; index++) {
			wellFormedChain.add(certificates[index]);
		}

		return wellFormedChain;
	}

	/**
	 * Construtor para X509ChainValidator. S�o passados a cadeia de certificados
	 * a ser validada, assim como os roots v�lidos para a valida��o da cadeia.
	 * 
	 * @param certCadeia
	 *            Deve ser uma cadeia de certificados v�lida, de acordo com o
	 *            PKIX.
	 * @param trustedAnchors
	 *            Um ou mais certificados raiz.
	 */
	@SuppressWarnings({ "unchecked" })
	public X509ChainValidator(final X509Certificate certChain[],
			final Set trustedAnchors, final X509CRLObject crlArray[]) {
		this.certificates = certChain;
		this.certChain = this.getWellFormedChain(certChain);
		this.trustedAnchors = trustedAnchors;
		if (crlArray != null) {
			crls = new Vector();

			for (X509CRLObject crl : crlArray) {
				this.crls.add(crl);
			}
		}
	}

	/**
	 * Este m�todo realiza a valida��o da cadeia de certificados. Caso checkCRL
	 * esteja true, ent�o � feita a valida��o de revoga��o dos certificados em
	 * rela��o as suas CRLs. Todos os certificados da cadeia s�o verifificados,
	 * n�o apenas o certificados apresentado, mas tamb�m os das ACs
	 * intermedi�rias. Caso a cadeia de certificados esteja v�lida, ent�o
	 * validateChain retorna void. Caso contr�rio uma exce��o � lan�ada.
	 * 
	 * @throws ChainValidationException
	 *             indica que houve um problema na valida��o da cadeia.
	 */
	@SuppressWarnings("unchecked")
	public void validateChain(Date dtSigned) throws ChainValidationException {
		try {
			final CertificateFactory cf = CertificateFactory.getInstance(
					"X.509", "BC");
			// CertificateFactory cf = CertificateFactory.getInstance( "X.509");
			final CertPath cp = cf.generateCertPath(this.certChain);

			final PKIXParameters params = new PKIXParameters(trustedAnchors);
			params.addCertPathChecker(new PKIXCertPathChecker() {

				@Override
				public void init(boolean forward)
						throws CertPathValidatorException {
				}

				@Override
				public boolean isForwardCheckingSupported() {
					return true;
				}

				@Override
				public Set<String> getSupportedExtensions() {
					Set<String> s = new TreeSet<String>();
					s.add(XCN_OID_ENHANCED_KEY_USAGE);
					return s;
				}

				@Override
				public void check(Certificate cert,
						Collection<String> unresolvedCritExts)
						throws CertPathValidatorException {
					if (unresolvedCritExts.contains(XCN_OID_ENHANCED_KEY_USAGE))
						unresolvedCritExts.remove(XCN_OID_ENHANCED_KEY_USAGE);
				}
			});

			params.setExplicitPolicyRequired(false);// Nao obrigatorio, pois
			// false e o default
			params.setRevocationEnabled(this.checkCRL);
			// params.setRevocationEnabled(false);

			if (this.checkCRL) {
				if (crls == null)
					crls = getCRLs(certChain
							.toArray(new X509Certificate[certChain.size()]));
				final Collection col = new ArrayList();
				col.addAll(this.crls);
				for (X509Certificate cert : this.certificates)
					col.add(cert);
				final CollectionCertStoreParameters csParams = new CollectionCertStoreParameters(
						col);
				final CertStore cs = CertStore.getInstance("Collection",
						csParams);
				final List certStores = new Vector();
				certStores.add(cs);
				params.setCertStores(certStores);
			}

			params.setTrustAnchors(this.trustedAnchors);
			params.setDate(dtSigned);

			final CertPathValidator cpv = CertPathValidator.getInstance("PKIX",
					"BC");
			// CertPathValidator cpv = CertPathValidator.getInstance("PKIX");

			@SuppressWarnings("unused")
			PKIXCertPathValidatorResult result = null;

			// Estamos com o seguinte problema: Quando utilizamos as rotinas da
			// SUN, funciona, mas seria necess�rio possuir todas as CRLs,
			// inclusive as mais antiga, pois quando informamos a data, ele
			// exclui CRLs que nao est�o v�lidas nessa data.

			result = (PKIXCertPathValidatorResult) cpv.validate(cp, params);
		} catch (final CertificateException e) {
			throw new ChainValidationException(
					"Falha na cria��o do caminho dos certificados (CertPath)!"
							+ " Verifique se a cadeia de certificados existente � uma v�lida!\n",
					e);
		} catch (final InvalidAlgorithmParameterException e) {
			throw new ChainValidationException(
					"Falha na leitura dos certificados raizes (TrustedAnchor)! "
							+ "Verifique se os certificados raizes passados s�o v�lidos!\n",
					e);
		} catch (final NoSuchAlgorithmException e) {
			throw new ChainValidationException(
					"Falha na cria��o do CertStore! Os par�metros passados"
							+ " para a cria��o do CertStore podem estar com problemas!\n",
					e);
		} catch (final NoSuchProviderException e) {
			throw new ChainValidationException(
					"O provedor criptogr�fico especificado n�o est� dispon�vel!\n",
					e);
		} catch (final CertPathValidatorException e) {
			// for (X509CRLObject x : (Collection<X509CRLObject>) this.crls)
			// System.out.println(x.getIssuerDN() + " - " + x.getThisUpdate()
			// + " - " + x.getNextUpdate());
			//
			throw new ChainValidationException(
					"N�o foi poss�vel validar a cadeia de certificados!\n Caso as CRLs"
							+ " tenham sido verificadas � poss�vel que algum certificado da cadeia esteja revogado!\n"
							+ e);
		}
	}

	/**
	 * Por padr�o a verifica��o de CRLs fica desabilitada. Para habilit�-la �
	 * necess�rio setar checkCRL(true)
	 * 
	 * @param checkCRL
	 *            - True para verificar as CRLs da cadeia de certificados
	 */
	public void checkCRL(final boolean checkCRL) {
		this.checkCRL = checkCRL;
	}

	/**
	 * M�todo para descobrir se a verifica��o de CRLs ser� usada ou n�o.
	 * 
	 * @return Estado atual da verifica��o de CRL.
	 */
	public boolean isCheckCRL() {
		return this.checkCRL;
	}

}
