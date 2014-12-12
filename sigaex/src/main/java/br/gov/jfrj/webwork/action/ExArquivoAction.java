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
/*
 * Criado em  13/09/2005
 *
 */
package br.gov.jfrj.webwork.action;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import br.gov.jfrj.itextpdf.Documento;
import br.gov.jfrj.siga.Service;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cd.service.CdService;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExNivelAcesso;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.ex.util.GeradorRTF;
import br.gov.jfrj.siga.hibernate.ExDao;

import com.lowagie.text.pdf.codec.Base64;

public class ExArquivoAction extends ExActionSupport {
	private InputStream inputStream;

	private String contentDisposition;

	private Integer contentLength;

	public void setContentLength(Integer contentLength) {
		this.contentLength = contentLength;
	}

	public Integer getContentLength() {
		return contentLength;
	}

	public void setContentDisposition(String contentDisposition) {
		this.contentDisposition = contentDisposition;
	}

	public String getContentDisposition() {
		return contentDisposition;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String aExibir() throws Exception {
		try {

			String servernameport = getRequest().getServerName() + ":"
					+ getRequest().getServerPort();
			String contextpath = getRequest().getContextPath();

			// log.info("Iniciando servlet de documentos...");

			@SuppressWarnings("unused")
			ExDao dao = ExDao.getInstance();

			String arquivo = getPar().get("arquivo")[0];

			byte[] certificado = null;
			boolean pacoteAssinavel = getPar().containsKey("certificadoB64");
			
			boolean fB64 = getRequest().getHeader("Accept") != null && getRequest().getHeader("Accept").startsWith("text/vnd.siga.b64encoded"); 

			boolean isPdf = arquivo.endsWith(".pdf");
			boolean isHtml = arquivo.endsWith(".html");
			boolean estampar = !getPar().containsKey("semmarcas");
			boolean completo = getPar().containsKey("completo");
			boolean somenteHash = getPar().containsKey("hash")
					|| getPar().containsKey("HASH_ALGORITHM");
			String hash = null;
			if (somenteHash) {
				hash = getPar().get("hash")[0];
				if (hash == null) {
					hash = getPar().get("HASH_ALGORITHM")[0];
				}
				if (hash != null) {
					if (!(hash.equals("SHA1") || hash.equals("SHA-256")
							|| hash.equals("SHA-512") || hash.equals("MD5")))
						throw new AplicacaoException(
								"Algoritmo de hash inv�lido. Os permitidos s�o: SHA1, SHA-256, SHA-512 e MD5.");
				}
				completo = false;
				estampar = false;
			}

			if (pacoteAssinavel) {
				certificado = Base64.decode(getPar().get("certificadoB64")[0]);
				completo = false;
				estampar = false;
			}

			ExMobil mob = Documento.getMobil(arquivo);
			if (mob == null) {
				throw new AplicacaoException(
						"A sigla informada n�o corresponde a um documento da base de dados.");
			}

			if (!Ex.getInstance().getComp()
					.podeAcessarDocumento(getTitular(), getLotaTitular(), mob)) {
				throw new AplicacaoException("Documento " + mob.getSigla()
						+ " inacess�vel ao usu�rio " + getTitular().getSigla()
						+ "/" + getLotaTitular().getSiglaCompleta() + ".");
			}

			ExMovimentacao mov = Documento.getMov(mob, arquivo);

			// Falta tratar o caso do doc j� assinado, por enquanto estamos
			// contemplando apenas as movimenta��es
			boolean imutavel = (mov != null) && !completo && !estampar
					&& !somenteHash && !pacoteAssinavel;

			String cacheControl = "private";
			final Integer grauNivelAcesso = mob.doc()
					.getExNivelAcessoDoDocumento().getGrauNivelAcesso();
			if (ExNivelAcesso.NIVEL_ACESSO_PUBLICO == grauNivelAcesso
					|| ExNivelAcesso.NIVEL_ACESSO_ENTRE_ORGAOS == grauNivelAcesso)
				cacheControl = "public";

			byte ab[] = null;
			if (isPdf) {
				if (mov != null && !completo && !estampar && hash == null)
					ab = mov.getConteudoBlobpdf();
				else
					ab = Documento.getDocumento(mob, mov, completo, estampar,
							hash, null);
				if (ab == null)
					throw new Exception("PDF inv�lido!");

				String filename = null;
				if (mov != null) {
					filename = mov.getReferencia();
				} else {
					filename = mob.getCodigoCompacto();
				}

				if (pacoteAssinavel) {
					setContentDisposition("attachment; filename=" + filename
							+ ".sa");
					CdService client = Service.getCdService();
					final Date dt = dao().consultarDataEHoraDoServidor();
					getResponse().setHeader("Atributo-Assinavel-Data-Hora", Long.toString(dt.getTime()));
					byte[] sa = client.produzPacoteAssinavel(certificado, certificado, ab, true,
							dt);
					
					return writeByteArray(sa, "application/octet-stream", fB64);
				}

				if (hash != null) {
					setContentDisposition("attachment; filename=" + filename
							+ "." + hash.toLowerCase());
					this.setContentLength(ab.length);
					return writeByteArray(ab, "application/octet-stream", fB64);
				}

				setContentDisposition("filename=" + filename + ".pdf");
			}
			if (isHtml) {
				ab = Documento.getDocumentoHTML(mob, mov, completo,
						contextpath, servernameport);
				if (ab == null)
					throw new Exception("HTML inv�lido!");
			}

			if (imutavel) {
				getResponse().setHeader("Cache-Control", cacheControl);
				// Um ano no cache.
				getResponse().setDateHeader("Expires",
						new Date().getTime() + (365 * 24 * 3600 * 1000L));
			} else {
				// Calcula o hash do documento, mas n�o leva em considera��o
				// para fins de hash os �ltimos bytes do arquivos, pois l�
				// fica armazanada a ID e as datas de cria��o e modifica��o
				// e estas s�o sempre diferente de um pdf para o outro.
				MessageDigest md = MessageDigest.getInstance("MD5");

				int m = match(ab);
				if (m != -1)
					md.update(ab, 0, m);
				else
					md.update(ab);
				String etag = Base64.encodeBytes(md.digest());

				String ifNoneMatch = getRequest().getHeader("If-None-Match");
				getResponse().setHeader("Cache-Control",
						"must-revalidate, " + cacheControl);
				getResponse().setDateHeader("Expires", 0);
				getResponse().setHeader("ETag", etag);

				if ((etag).equals(ifNoneMatch) && ifNoneMatch != null) {
					getResponse()
							.sendError(HttpServletResponse.SC_NOT_MODIFIED);
					return "donothing";
				}
			}
			getResponse().setHeader("Pragma", "");

			return writeByteArray(ab, isPdf ? "application/pdf"
					: "text/html", fB64);
		} catch (Exception e) {
			if (e.getClass().getSimpleName().equals("ClientAbortException"))
				return null;
			throw new ServletException("erro na gera��o do documento.", e);
		}
	}

	// Esta rotina foi criada para verificar se utilizar o StreamResult do
	// WebWork estava causando uma instabilidade no sistema. Ou seja, se havia
	// algum memory leak na rotina de enviar uma stream como resultado. Assim
	// que fique comprovado que n�o h� interfer�ncia, essa rotina deve ser
	// desativada.
	private String writeByteArray(byte[] ab, String contentType, boolean fB64)
			throws IOException {
		if (ab == null)
			throw new RuntimeException("Conte�do inv�lido!");

		if (fB64) {
			ab = Base64.encodeBytes(ab).getBytes();
			contentType = "text/plain";
		}
		
		this.setContentLength(ab.length);

		getResponse().setStatus(200);
		getResponse().setContentLength(getContentLength());
		getResponse().setContentType(contentType);
		if (!getPar().get("arquivo")[0].endsWith(".html"))
			getResponse().setHeader("Content-Disposition",getContentDisposition());
		getResponse().getOutputStream().write(ab);
		getResponse().getOutputStream().flush();
		getResponse().getOutputStream().close();
		return "donothing";
	}

	public String aDownload() throws Exception {
		try {

			String servernameport = getRequest().getServerName() + ":"
					+ getRequest().getServerPort();
			String contextpath = getRequest().getContextPath();

			// log.info("Iniciando servlet de documentos...");

			@SuppressWarnings("unused")
			ExDao dao = ExDao.getInstance();

			String arquivo = getPar().get("arquivo")[0];

			boolean isZip = arquivo.endsWith(".zip");
			boolean isRtf = arquivo.endsWith(".rtf");
			boolean somenteHash = getPar().containsKey("hash")
					|| getPar().containsKey("HASH_ALGORITHM");
			String hash = null;
			if (somenteHash) {
				hash = getPar().get("hash")[0];
				if (hash == null) {
					hash = getPar().get("HASH_ALGORITHM")[0];
				}
				if (hash != null) {
					if (!(hash.equals("SHA1") || hash.equals("SHA-256")
							|| hash.equals("SHA-512") || hash.equals("MD5")))
						throw new AplicacaoException(
								"Algoritmo de hash inv�lido. Os permitidos s�o: SHA1, SHA-256, SHA-512 e MD5.");
				}
			}

			ExMobil mob = Documento.getMobil(arquivo);
			if (mob == null) {
				throw new AplicacaoException(
						"A sigla informada n�o corresponde a um documento da base de dados.");
			}

			if (!Ex.getInstance().getComp()
					.podeAcessarDocumento(getTitular(), getLotaTitular(), mob)) {
				throw new AplicacaoException("Documento " + mob.getSigla()
						+ " inacess�vel ao usu�rio " + getTitular().getSigla()
						+ "/" + getLotaTitular().getSiglaCompleta() + ".");
			}

			ExMovimentacao mov = Documento.getMov(mob, arquivo);

			String cacheControl = "private";
			final Integer grauNivelAcesso = mob.doc()
					.getExNivelAcessoDoDocumento().getGrauNivelAcesso();
			if (ExNivelAcesso.NIVEL_ACESSO_PUBLICO == grauNivelAcesso
					|| ExNivelAcesso.NIVEL_ACESSO_ENTRE_ORGAOS == grauNivelAcesso)
				cacheControl = "public";

			byte ab[] = null;
			if (isZip) {
				ab = mov.getConteudoBlobMov2();

				String filename = mov.getNmArqMov();

				if (hash != null) {
					this.setInputStream(new ByteArrayInputStream(ab));
					this.setContentLength(ab.length);

					setContentDisposition("attachment; filename=" + filename
							+ "." + hash.toLowerCase());
					return "hash";
				}

				setContentDisposition("filename=" + filename);
			}

			if (isRtf) {
				GeradorRTF gerador = new GeradorRTF();
				ab = gerador.geraRTFFOP(mob.getDoc());

				String filename = mob.doc().getCodigo() + ".rtf";

				if (hash != null) {
					this.setInputStream(new ByteArrayInputStream(ab));
					this.setContentLength(ab.length);

					setContentDisposition("attachment; filename=" + filename
							+ "." + hash.toLowerCase());
					return "hash";
				}

				setContentDisposition("filename=" + filename);
			}

			// Calcula o hash do documento, mas n�o leva em considera��o
			// para fins de hash os �ltimos bytes do arquivos, pois l�
			// fica armazanada a ID e as datas de cria��o e modifica��o
			// e estas s�o sempre diferente de um pdf para o outro.
			MessageDigest md = MessageDigest.getInstance("MD5");

			int m = match(ab);
			if (m != -1)
				md.update(ab, 0, m);
			else
				md.update(ab);
			String etag = Base64.encodeBytes(md.digest());

			String ifNoneMatch = getRequest().getHeader("If-None-Match");
			getResponse().setHeader("Cache-Control",
					"must-revalidate, " + cacheControl);
			getResponse().setDateHeader("Expires", 0);
			getResponse().setHeader("ETag", etag);
			getResponse().setHeader("Pragma", "");
			if (ifNoneMatch != null && ifNoneMatch.equals(etag)) {
				getResponse().sendError(HttpServletResponse.SC_NOT_MODIFIED);
				return null;
			}

			this.setInputStream(new ByteArrayInputStream(ab));
			this.setContentLength(ab.length);

			if (isZip)
				return "zip";
			else
				return "rtf";

		} catch (Exception e) {
			throw new ServletException("erro na gera��o do documento.", e);
		}
	}

	static private byte[] idPattern = "/ModDate(D:20".getBytes();
	static private int[] failure = computeFailure();

	/**
	 * Finds the first occurrence of the pattern in the text.
	 */
	static public int match(byte[] text) {

		int j = 0;
		if (text.length == 0)
			return -1;

		for (int i = 0; i < text.length; i++) {
			while (j > 0 && idPattern[j] != text[i]) {
				j = failure[j - 1];
			}
			if (idPattern[j] == text[i]) {
				j++;
			}
			if (j == idPattern.length) {
				return i - idPattern.length + 1;
			}
		}
		return -1;
	}

	/**
	 * Computes the failure function using a boot-strapping process, where the
	 * pattern is matched against itself.
	 */
	static private int[] computeFailure() {
		failure = new int[idPattern.length];
		int j = 0;
		for (int i = 1; i < idPattern.length; i++) {
			while (j > 0 && idPattern[j] != idPattern[i]) {
				j = failure[j - 1];
			}
			if (idPattern[j] == idPattern[i]) {
				j++;
			}
			failure[i] = j;
		}
		return failure;
	}

}