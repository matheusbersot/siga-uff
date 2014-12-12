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
package br.gov.jfrj.siga.ex;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import br.gov.jfrj.itextpdf.Documento;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.model.Objeto;

public abstract class ExArquivo extends Objeto {
	private Integer numPaginas;

	public abstract String getAssinantesCompleto();

	public abstract Set<ExMovimentacao> getAssinaturasDigitais();

	/**
	 * Retorna o n�mero de p�ginas de um arquivo.
	 * 
	 * @return N�mero de p�ginas de um arquivo.
	 * 
	 */
	public Integer getContarNumeroDePaginas() {
		try {
			byte[] abPdf = null;
			abPdf = getPdf();
			if (abPdf == null)
				return null;
			return Documento.getNumberOfPages(abPdf);
		} catch (IOException e) {
			return null;
		}
	}

	/**
	 * Retorna o pdf do documento com stamp. M�todo criado para tentar stampar
	 * um documento que est� sendo anexado.
	 * 
	 * @return pdf com stamp.
	 * 
	 */
	public byte[] getArquivoComStamp() {
		try {
			byte[] abPdf = null;
			abPdf = getPdf();
			if (abPdf == null)
				return null;

			// Verifica se � poss�vel estampar o documento
			try {
				byte[] documentoComStamp = Documento.stamp(abPdf, "", true,
						false, false, false, null, null, null, null, null,
						null, null);

				return documentoComStamp;

			} catch (Exception e) {
				return null;
			}
		} catch (Exception e) {
			return null;
		}
	}

	public abstract Date getData();

	public abstract String getHtml();

	public abstract String getHtmlComReferencias() throws Exception;

	public Long getIdDoc() {
		if (this instanceof ExDocumento) {
			ExDocumento doc = (ExDocumento) this;
			return doc.getIdDoc();
		}
		;

		if (this instanceof ExMovimentacao) {
			ExMovimentacao mov = (ExMovimentacao) this;
			return mov.getIdMov();
		}

		return null;
	}

	public abstract DpLotacao getLotacao();

	/**
	 * Retorna uma mensagem informando quem assinou o documento e o endere�o
	 * onde o usu�rio pode verificar a autenticidade de um documento com base em
	 * um c�digo gerado.
	 * 
	 */
	public String getMensagem() {
		String sMensagem = "";
		if (isAssinadoDigitalmente()) {
			sMensagem += getAssinantesCompleto();
			sMensagem += "Documento N�: " + getSiglaAssinatura()
					+ " - consulta � autenticidade em "
					+ SigaExProperties.getEnderecoAutenticidadeDocs();
		}
		return sMensagem;
	}

	/**
	 * Caso o m�todo esteja sendo executado em um objeto do tipo documento,
	 * retorna a c�digo do documento. Caso o m�todo esteja sendo executado em um
	 * objeto do tipo movimenta��o, retorna o nome do arquivo desta
	 * movimenta��o.
	 * 
	 */
	public String getNome() {
		if (this instanceof ExDocumento) {
			ExDocumento doc = (ExDocumento) this;
			return doc.getCodigo();
		}

		if (this instanceof ExMovimentacao) {
			ExMovimentacao mov = (ExMovimentacao) this;
			return mov.getNmArqMov();
		}
		return null;
	}

	/**
	 * Retorna o n�mero de p�ginas do documento para exibir no dossi�.
	 * 
	 */
	public int getNumeroDePaginasParaInsercaoEmDossie() {
		if (this instanceof ExMovimentacao) {
			ExMovimentacao mov = (ExMovimentacao) this;
			if (mov.getNumPaginasOri() != null)
				return mov.getNumPaginasOri();
		}
		return getNumPaginas();
	}

	public Integer getNumPaginas() {
		return numPaginas;
	}

	public abstract byte[] getPdf();
	
	public abstract boolean isPdf();

	public long getByteCount() {
		byte[] ab = getPdf();
		if (ab == null)
			return 0;
		return ab.length;
	}

	// public byte[] getPdfToHash() throws Exception {
	// byte[] pdf = getPdf();
	// if (pdf == null)
	// return null;
	// return AssinaturaDigital.getHasheableRangeFromPDF(pdf);
	// }
	//
	// public String getPdfToHashB64() throws Exception {
	// return Base64.encode(getPdfToHash());
	// }

	public String getQRCode() {
		if (isAssinadoDigitalmente()) {
			String sQRCode;
			sQRCode = SigaExProperties.getEnderecoAutenticidadeDocs() + "?n="
					+ getSiglaAssinatura();
			return sQRCode;
		}
		return null;
	}

	/**
	 * Quando o objeto for do tipo documento retorna o c�digo compacto do
	 * documento. Quando o objeto for do tipo movimenta��o retorna a refer�ncia
	 * da movimenta��o que � o codigo compacto da movimenta��o mais o id da
	 * movimenta��o.
	 * 
	 */
	public String getReferencia() {
		if (this instanceof ExDocumento) {
			ExDocumento doc = (ExDocumento) this;
			return doc.getCodigoCompacto();
		}

		if (this instanceof ExMovimentacao) {
			ExMovimentacao mov = (ExMovimentacao) this;
			return mov.getReferencia();
		}
		return null;
	}

	/**
	 * Retorna a refer�ncia do objeto mais o extens�o ".html".
	 * 
	 */
	public String getReferenciaHtml() {
		if (getHtml() == null)
			return null;
		return getReferencia() + ".html";
	}

	/**
	 * Retorna a refer�ncia do objeto mais o extens�o ".pdf".
	 * 
	 */
	public String getReferenciaPDF() {
		if (getNumPaginas() == null || getNumPaginas() == 0)
			return null;
		return getReferencia() + ".pdf";
	};
	
	/**
	 * Retorna a refer�ncia do objeto mais o extens�o ".pdf".
	 * 
	 */
	public String getReferenciaZIP() {
		return getReferencia() + ".zip";
	};

	public Map<String, String> getResumo() {
		return null;
	};

	public abstract String getSiglaAssinatura();
	
	public abstract String getSiglaAssinaturaExterna();

	/**
	 * Verifica se um arquivo foi assinado digitalmente.
	 * 
	 * @return Verdadeiro caso o arquivo tenha sido assinado digitalmente e
	 *         Falso caso o arquivo n�o tenha sido assinado digitalmente.
	 * 
	 */
	public boolean isAssinadoDigitalmente() {
		return (getAssinaturasDigitais() != null)
				&& (getAssinaturasDigitais().size() > 0);
	}

	public abstract boolean isCancelado();

	public abstract boolean isRascunho();

	public abstract boolean isSemEfeito();

	public abstract boolean isInternoProduzido();

	public void setNumPaginas(Integer numPaginas) {
		this.numPaginas = numPaginas;
	}
	
	public abstract boolean isCodigoParaAssinaturaExterna(String num);

}