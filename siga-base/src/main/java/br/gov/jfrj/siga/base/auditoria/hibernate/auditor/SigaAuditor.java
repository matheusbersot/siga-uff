package br.gov.jfrj.siga.base.auditoria.hibernate.auditor;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.cfg.Configuration;

import br.gov.jfrj.siga.base.auditoria.hibernate.enums.SigaLogCategoryEnum;

public abstract class SigaAuditor {
	
	protected static final Logger log = Logger.getLogger( "[AUDITORIA]" );
	protected Configuration cfg;
	
	public SigaAuditor( Configuration cfg ) {
		if ( cfg == null ) {
			log.error( "N�o foi poss�vel instanciar o auditor" );
			throw new IllegalArgumentException("Hibernate Configuration n�o pode ser nulo.");
		}
		this.cfg = cfg;
	}
	
	public static SigaAuditor configuraAuditoria( SigaAuditor auditor ) {
		
		if ( auditor == null ) {
			log.error("A configura��o da auditoria � inv�lida");
			throw new IllegalStateException("O SigaAuditor � nulo");
		}
		
		// bruno.lacerda@avantiprima.com.br
		// adicionando listeners e interceptors de auditoria para logar tempo de cada chamada ao Oracle por entidade
		// if ( auditor.isAuditoriaHabilitada() ) {
			if ( auditor.isListenersAuditoriaHabilitados() ) {
				auditor.configuraListenersDeAuditoria();
			}
			if ( auditor.isInterceptorAuditoriaHabilitado() ) {
				auditor.configuraInterceptorDeAuditoria();
			}
		// }
		
		return auditor;
	}
	
	protected static Logger getLog(){ return log; }
	
	public abstract SigaAuditor configuraListenersDeAuditoria();
	
	public abstract SigaAuditor configuraInterceptorDeAuditoria();
	
	public abstract boolean isAuditoriaHabilitada();
	
	public abstract boolean isListenersAuditoriaHabilitados();
	
	public abstract boolean isInterceptorAuditoriaHabilitado();
	
	public abstract int getTempoLimiteParaLogarListeners();
	public static int getTempoLimite(String tempoLimiteLogListenerPropertyName) {
		String strTempoLimite = System.getProperty( tempoLimiteLogListenerPropertyName );
		if ( !StringUtils.isNumeric( strTempoLimite ) ) {
			log.error( "O valor da propriedade que define o tempo limite para logar nos listeners � inv�lida" );
			throw new IllegalStateException( "O valor da propriedade que define o tempo limite para logar nos listeners � inv�lida" );
		}
		return Integer.parseInt( strTempoLimite );
	}
	
	public abstract String getCategoriaDeLogParaListeners();
	public String getCategoriaDeLog(String categoriaLogListenerPropertyName) {
		String categoriaDeLog = System.getProperty( categoriaLogListenerPropertyName );
		if ( StringUtils.isNotBlank( categoriaDeLog )) {
			if ( SigaLogCategoryEnum.valueOf( categoriaDeLog.toUpperCase() ) != null ) {
				return SigaLogCategoryEnum.valueOf( categoriaDeLog.toUpperCase() ).getValue();
			} else {
				log.error( "O valor da propriedade que define a categoria de log para logar nos listeners ou interceptor � inv�lida" );
				throw new IllegalStateException( "O valor da propriedade que define a categoria de log para logar nos listeners ou interceptor � inv�lida" );
			}
		} else {
			log.error( "O valor da propriedade que define a categoria de log para logar nos listeners � nula" );
			throw new IllegalStateException( "O valor da propriedade que define a categoria de log para logar nos listeners � nula" );
		}
	}
	
	public abstract String getCategoriaDeLogParaInterceptor();
	
}
