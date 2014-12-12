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

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.security.cert.CRLException;
import java.security.cert.X509Certificate;
import java.util.Properties;

import org.bouncycastle.asn1.ASN1InputStream;
import org.bouncycastle.asn1.ASN1Sequence;
import org.bouncycastle.asn1.x509.CertificateList;
import org.bouncycastle.jce.provider.X509CRLObject;


/**
 * @author mparaiso
 * 
 * Classe respons�vel por buscar a CRL de um determinado Certificado. Esta CRL
 * pode ser obtida diretamente de um ponto de distribui��o de CRL, na Internet,
 * ou localmente. A busca da CRL � determinada pelo m�todo construtor usado.
 * 
 */
public class CRLLocator {

	byte crl[];

	X509Certificate certificate = null;

	String uri;

	/**
	 * M�todo utilit�rio usado para fazer a leitura do InputStream de uma CRL
	 * (Tanto de arquivo como da Web)
	 * 
	 * @param crl
	 * @throws IOException
	 */
	private void createCRL(final InputStream crl) throws IOException {

		final ByteArrayOutputStream output = new ByteArrayOutputStream();

		int leitor;

		while ((leitor = crl.read()) != -1) {

			output.write(leitor);
		}

		crl.close();

		this.crl = output.toByteArray();
	}

	/**
	 * Este m�todo buscar� a CRL localmente. Para tanto, deve-se utilizar o
	 * m�todo construtor CRLLocator(String uri), onde uri � o local onde a CRL
	 * pode ser encontrada.
	 * 
	 * @throws IOException
	 * 
	 */
	private void getLocalCRL() throws IOException {

		final InputStream crlFile = new FileInputStream(this.uri);
		this.createCRL(crlFile);

	}

	/**
	 * Quando a classe � instanciada usando CRLLocator(X509Certificate
	 * certificate) a busca pela CRL � feita remotamente. O endere�o do ponto de
	 * distribui��o da CRL � retirado diretamente do certificado passado para o
	 * construtor da classe. Para que seja poss�vel acessar a CRL remotamente �
	 * necess�rio que conex�es � Internet, via HTTP, sejam poss�veis.
	 * 
	 * @throws IOException
	 * @throws IOException
	 * 
	 * @throws Exception
	 * 
	 * @throws Exception
	 */
	private void getRemoteCRL() throws IOException {

		byte[] ba = CRLCache.getCRL(this.uri);

		if (ba != null) {
			crl = ba;
			return;
		}

		URL url = null;
		HttpURLConnection con = null;

		Properties systemProperties = System.getProperties();
		// systemProperties.setProperty("http.proxyHost", "10.10.1.55");
		// systemProperties.setProperty("http.proxyHost", "10.10.1.191");
		systemProperties
				.setProperty("http.proxyHost", SigaCdProperties.getProxyHost());
		systemProperties.setProperty("http.proxyPort", SigaCdProperties.getProxyHost());

		url = new URL(this.uri);
		con = (HttpURLConnection) url.openConnection();
		// con.setRequestProperty("Proxy-Authorization", "Basic " + "");
		// new sun.misc.BASE64Encoder().encode("tah:pwd".getBytes())

		con.setDoOutput(true);
		con.setRequestMethod("GET");
		con.connect();
		final InputStream response = con.getInputStream();

		this.createCRL(response);

		con.disconnect();

		CRLCache.putCRL(this.uri, this.crl);
	}

	/**
	 * M�todo construtor que permite a busca de CRLs remotamente. A URL do ponto
	 * de distribui��o de CRLs � retirada diretamente do certificado.
	 * 
	 * @param certificate
	 *            Certificado X509 que est� sendo verificado.
	 */
	public CRLLocator(final X509Certificate certificate) {

		this.certificate = certificate;

		int auxIndex, auxEndIndex;
		final byte crlExtension[] = certificate.getExtensionValue("2.5.29.31"); // 2.5.29.31
		// ==
		// CRL
		// Distribution
		// Points
		if (crlExtension == null) {
			this.uri = null;
			return;
		}
		this.uri = new String(crlExtension);
		auxIndex = this.uri.indexOf("http://");
		auxEndIndex = this.uri.indexOf(".crl");
		this.uri = this.uri.substring(auxIndex, auxEndIndex + 4);
		// auxIndex = this.uri.lastIndexOf("http://");
		// this.uri = this.uri.substring(auxIndex);
		// System.out.println(this.uri);
	}

	/**
	 * M�todo construtor que permite a busca de CRLs localmente. A CRL referente
	 * ao certificado a ser verificado deve estar dispon�vel em disco.
	 * 
	 * @param uri
	 *            Caminho completo para a CRL referente ao certificado que est�
	 *            sendo verificado. Exemplo: 'C:\CRLs\Cert.crl'
	 */
	public CRLLocator(final String uri) {

		this.uri = uri;
	}

	/**
	 * Uma vez carregada a CRL, tanto localmente como remotamente, � poss�vel
	 * salv�-la em disco para uso posterior.
	 * 
	 * @param path
	 *            Caminho completo para onde a CRL deve ser salva. Exemplo:
	 *            'C:\MinhasCrls\Lista.crl'
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public void crlToFile(final String path) throws FileNotFoundException,
			IOException {

		if (this.crl != null) {

			FileOutputStream file;
			file = new FileOutputStream(path);
			file.write(this.crl);
		}
	}

	/**
	 * Caso tenha sido usado o construtor CRLLocator(X509Certificate
	 * certificate) � poss�vel recuperar o certificado que foi passado para
	 * CRLLocator. Caso o contrutor CRLLocator(String uri) tenha sido usado,
	 * ent�o � retornado null.
	 * 
	 * @return o certificado X509 passado pelo m�todo construtor.
	 */
	public X509Certificate getX509Certificate() {

		return this.certificate;
	}

	/**
	 * Uma vez instanciado o objeto, � poss�vel fazer a busca da CRL referente
	 * ao certificado a ser verificado. A CRL � retornada, independente do
	 * construtor utilizado, desde que esteja dispon�vel.
	 * 
	 * @return um objeto X509CRLObject para uso posterior.
	 * @throws CRLException
	 */
	public X509CRLObject getCRL() throws InvalidCRLException, CRLException {

		try {
			if (this.certificate != null)
				this.getRemoteCRL();
			else
				this.getLocalCRL();

			// Maneira um pouco mais dificil de instanciar um X509CRLObject
			final ByteArrayInputStream bis = new ByteArrayInputStream(this.crl);
			final ASN1InputStream stream = new ASN1InputStream(bis);
			final CertificateList cl = new CertificateList(
					(ASN1Sequence) stream.readObject());

			return new SigaX509CRLObject(cl);

		} catch (final MalformedURLException e) {

			throw new InvalidCRLException(
					"URL de acesso a CRL est� mal formada ou � inv�lida! ("
							+ this.uri + ")", e);

		} catch (final ProtocolException e) {

			throw new InvalidCRLException(
					"Falha ao setar o m�todo HTTP/GET para fazer o download da CRL! ("
							+ this.uri + ")", e);

		} catch (final IOException e) {

			throw new InvalidCRLException("Falha ao gerar a CRL! (" + this.uri
					+ ")", e);
		}
	}
}
