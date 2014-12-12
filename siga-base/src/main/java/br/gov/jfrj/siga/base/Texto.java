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
package br.gov.jfrj.siga.base;

import java.io.UnsupportedEncodingException;

public class Texto {

	/**
	 * Remove os acentos da string e coloca os caracteres em letras mai�sculas
	 * 
	 * @param acentuado
	 *            - String acentuada
	 * @return String sem acentos
	 */
	public static String removeAcentoMaiusculas(String acentuado) {
		if (acentuado == null)
			return null;
		return removeAcento(acentuado.toUpperCase());
	}

	/**
	 * Remove os acentos da string
	 * 
	 * @param acentuado
	 *            - String acentuada
	 * @return String sem acentos
	 */
	public static String removeAcento(String acentuado) {
		if (acentuado == null)
			return null;
		String temp = new String(acentuado);
		temp = temp.replaceAll("[����]", "A");
		temp = temp.replaceAll("[���]", "E");
		temp = temp.replaceAll("[���]", "I");
		temp = temp.replaceAll("[����]", "O");
		temp = temp.replaceAll("[����]", "U");
		temp = temp.replaceAll("[�]", "C");
		temp = temp.replaceAll("[����]", "a");
		temp = temp.replaceAll("[���]", "e");
		temp = temp.replaceAll("[���]", "i");
		temp = temp.replaceAll("[����]", "o");
		temp = temp.replaceAll("[����]", "u");
		temp = temp.replaceAll("[�]", "c");
		return temp;
	}

	public String iniciais(String s) {
		final StringBuilder sb = new StringBuilder(10);
		boolean f = true;

		s = s.replace(" E ", " ");
		s = s.replace(" DA ", " ");
		s = s.replace(" DE ", " ");
		s = s.replace(" DO ", " ");

		for (int i = 0; i < s.length(); i++) {
			final char c = s.charAt(i);
			if (f) {
				sb.append(c);
				f = false;
			}
			if (c == ' ') {
				f = true;
			}
		}
		return sb.toString();
	}

	public static String maiusculasEMinusculas(String s) {
		final StringBuilder sb = new StringBuilder(s.length());
		boolean f = true;

		for (short i = 0; i < s.length(); i++) {
			String ch = s.substring(i, i + 1);
			if (!ch.toUpperCase().equals(ch.toLowerCase())) {
				if (f) {
					sb.append(ch.toUpperCase());
					f = false;
				} else
					sb.append(ch.toLowerCase());
			} else {
				sb.append(ch);
				f = true;
			}
		}

		s = sb.toString();

		s = s.replace(" E ", " e ");
		s = s.replace(" Da ", " da ");
		s = s.replace(" Das ", " das ");
		s = s.replace(" De ", " de ");
		s = s.replace(" Do ", " do ");
		s = s.replace(" Dos ", " dos ");

		return s;
	}

	public static String primeiraMaiuscula(String string) {
		String stringAux1 = string.substring(0, 1);
		String stringAux2 = string.substring(1).toLowerCase();
		return stringAux1 + stringAux2;
	}

	public static String extrai(final String sSource, final String sBegin,
			final String sEnd) throws UnsupportedEncodingException {
		final Integer iBegin = sSource.indexOf(sBegin);
		final Integer iEnd = sSource.indexOf(sEnd);

		if (iBegin == -1 || iEnd == -1)
			return null;

		final String sResult = sSource
				.substring(iBegin + sBegin.length(), iEnd);
		return sResult;
	}

	public static String extraiTudo(final String sSource, final String sBegin,
			final String sEnd) throws UnsupportedEncodingException {

		int startPos = 0;

		Integer iBegin = sSource.indexOf(sBegin, startPos);
		Integer iEnd = sSource.indexOf(sEnd, startPos);
		String sResult = "";

		while (iBegin != -1 && iEnd != -1) {
			sResult = sResult
					+ sSource.substring(iBegin + sBegin.length(), iEnd);
			startPos = iEnd + sEnd.length();
			iBegin = sSource.indexOf(sBegin, startPos);
			iEnd = sSource.indexOf(sEnd, startPos);
		}

		return sResult;
	}

	public static String removerEspacosExtra(String texto) {
		return texto.replaceAll("\\s{2,}", " ");
	}

	public static String inciaisMaiuscula(String texto) {
		if (texto == null) {
			return texto;
		}
		char caracteres[] = texto.toCharArray();
		for (int i = 0; i < caracteres.length; i++) {
			if (i == 0 || String.valueOf(caracteres[i - 1]).equals(" ")) {
				caracteres[i] = Character.toUpperCase(caracteres[i]);
			} else {
				caracteres[i] = Character.toLowerCase(caracteres[i]);
			}
		}

		return String.valueOf(caracteres);
	}

	public static String slugify(String string, boolean lowercase,
			boolean underscore) {
		if (string == null)
			return null;
		string = string.trim();
		if (string.length() == 0)
			return null;
		string = removeAcento(string);
		// Apostrophes.
		string = string.replaceAll("([a-z])'s([^a-z])", "$1s$2");
		string = string.replaceAll("[^\\w]", "-").replaceAll("-{2,}", "-");
		// Get rid of any - at the start and end.
		string.replaceAll("-+$", "").replaceAll("^-+", "");

		if (underscore)
			string.replaceAll("-", "_");

		return (lowercase ? string.toLowerCase() : string);
	}

}
