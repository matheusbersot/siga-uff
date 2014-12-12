package br.gov.jfrj.siga.base.util;

import org.apache.commons.lang.StringUtils;

import br.gov.jfrj.siga.base.AplicacaoException;

public abstract class MatriculaUtils {
	
	/**
	 * 
	 * @param matricula
	 * @return a parte num�rica da matr�cula
	 * @throws AplicacaoException
	 */
	public static Long getParteNumerica(String matricula) throws AplicacaoException {
		
		validaPreenchimentoMatricula( matricula );
		String strParteNumerica = matricula.substring( 2, matricula.length() );
		if ( !StringUtils.isNumeric( strParteNumerica ) ) {
			throw new AplicacaoException( "A parte num�rica da matr�cula � inv�lida. Matr�cula: " + matricula + ". Parte Num�rica: " + strParteNumerica );
		}
		
		return Long.parseLong( strParteNumerica );
	}

	public static String getSigla(String matricula) throws AplicacaoException {
		validaPreenchimentoMatricula( matricula );
		String sigla = matricula.substring( 0, 2 );
		if ( StringUtils.isNumeric( sigla ) ) {
			throw new AplicacaoException( "A sigla da matr�cula � inv�lida. Matr�cula: " + matricula + ". Sigla: " + sigla );
		}
		
		return sigla;
	}
	
	protected static void validaPreenchimentoMatricula(String matricula)
			throws AplicacaoException {
		if ( StringUtils.isBlank( matricula ) || matricula.length() <= 2 ) {
			throw new AplicacaoException( "A matr�cula informada � nula ou inv�lida. Matr�cula: " + matricula );
		}
	}

}
