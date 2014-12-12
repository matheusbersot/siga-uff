/*
 * The Nheengatu Project : a free Java library for HTML  abstraction.
 *
 * Project Info:  http://www.aryjr.com/nheengatu/
 * Project Lead:  Ary Rodrigues Ferreira Junior
 *
 * (C) Copyright 2005, 2006 by Ary Junior
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
package com.aryjr.nheengatu.openoffice.calc;

import java.io.IOException;

import com.aryjr.nheengatu.document.Document;

/**
 * 
 * Can generate a Calc document of OpenOffice.
 * 
 * @version $Id: CalcDocument.java,v 1.1 2007/12/26 15:57:43 tah Exp $
 * @author <a href="mailto:junior@aryjr.com">Ary Junior</a>
 * 
 */
public class CalcDocument extends Document {
	private String title = "New Calc Document";

	public CalcDocument() {
		setName(getName() + ".sxc");
	}

	/**
	 * 
	 * Create a ImpressDocument.
	 * 
	 * @param name
	 *            The name without the extencion ".sxc".
	 */
	public CalcDocument(final String name) {
		setName(name + ".sxc");
	}

	/**
	 * 
	 * Create a ImpressDocument.
	 * 
	 * @param path
	 *            The file's path on the filesystem.
	 * @param name
	 *            The name without the extencion ".sxc".
	 */
	public CalcDocument(final String path, final String name) {
		setPath(path);
		setName(name + ".sxc");
	}

	/**
	 * 
	 * Sets the document's title.
	 * 
	 * @param title
	 *            The document's title on the filesystem.
	 */
	public void setTitle(final String title) {
		this.title = title;
	}

	/**
	 * 
	 * Gets the document's title.
	 * 
	 */
	public String getTitle() {
		return this.title;
	}

	/**
	 * 
	 * Generate a PDF file with the contents of the Body object defined.
	 * 
	 */
	public void generateFile() throws IOException {
	}

}
/**
 * 
 * $Log: CalcDocument.java,v $
 * Revision 1.1  2007/12/26 15:57:43  tah
 * *** empty log message ***
 *
 * Revision 1.3  2006/07/05 16:00:51  nts
 * Refatorando para melhorar qualidade do c�digo
 *
 * Revision 1.2  2006/04/11 19:43:51  tah
 * *** empty log message ***
 * Revision 1.1 2006/04/03 21:30:45 tah Utilizando o
 * nheengatu
 * 
 * Revision 1.3 2006/01/01 13:45:35 aryjr Feliz 2006!!!
 * 
 * Revision 1.2 2005/12/16 14:06:36 aryjr Problem with cell heights solved!!!
 * 
 * Revision 1.1 2005/11/14 12:17:42 aryjr Renomeando os pacotes.
 * 
 * Revision 1.1 2005/09/10 23:43:38 aryjr Passando para o java.net.
 * 
 * Revision 1.2 2005/07/02 01:18:57 aryjunior Site do projeto.
 * 
 * Revision 1.1 2005/06/19 14:16:33 aryjunior Preparando o suporte ao
 * OpenOffice.
 * 
 * 
 */
