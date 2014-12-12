package br.gov.jfrj.siga.dp.dao;

import java.io.UnsupportedEncodingException;

import org.hibernate.Hibernate;

public class CpDaoUtil {

	public static java.sql.Blob createBlob(String conteudo) {
		try {
			return Hibernate.createBlob(conteudo.getBytes("ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			throw new Error(e);
		}
	}

}
