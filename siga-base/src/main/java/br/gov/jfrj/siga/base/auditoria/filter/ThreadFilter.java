package br.gov.jfrj.siga.base.auditoria.filter;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.cfg.Configuration;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.SigaBaseProperties;
import br.gov.jfrj.siga.base.auditoria.hibernate.util.SigaHibernateAuditorLogUtil;

/**
 * Filtro base para implementa��o dos ThreadFilters
 * 
 * @author bruno.lacerda@avantiprima.com.br
 * 
 */
public abstract class ThreadFilter implements Filter {

	private static final String ASPAS = "\"";
	private static final String SEPARADOR = ";";
	private boolean isAuditaThreadFilter;
	private static final Logger log = Logger.getLogger(ThreadFilter.class);

	public ThreadFilter() {
		this.isAuditaThreadFilter = SigaBaseProperties
				.getBooleanValue("audita.thread.filter");
	}

	/**
	 * Marca o momento em que o ThreadFilter iniciou a execu��o do m�todo
	 * doFilter e grava a URL que est� sendo executada. Estes dados ser�o
	 * utilizados para gerar o Log do tempo gastu durante a execu��o do filtro
	 * para a URL em quest�o.</br> <b>Obs:</b> Para que funcione, � necess�rio
	 * que a propriedade <i>audita.thread.filter</i> esteja definida como
	 * <i>true</i> no arquivo <i>siga.properties</i>.
	 * 
	 * @param request
	 */
	protected StringBuilder iniciaAuditoria(final ServletRequest request) {

		final StringBuilder csv = new StringBuilder();

		if (this.isAuditaThreadFilter) {

			HttpServletRequest r = (HttpServletRequest) request;

			String hostName = this.getHostName();
			String contexto = this.getContexto(r);
			String uri = r.getRequestURI();
			String action = this.getAction(uri, contexto);
			String queryString = r.getQueryString();
			String userPrincipalName = this.getUserPrincipalName(r);

			appendEntreAspas(csv, hostName);
			appendEntreAspas(csv, contexto);
			appendEntreAspas(csv, action);
			appendEntreAspas(csv, queryString);
			appendEntreAspas(csv, userPrincipalName);
			appendEntreAspas(csv, r.getRequestURL());

			SigaHibernateAuditorLogUtil.iniciaMarcacaoDeTempoGasto();
		}

		return csv;
	}

	/**
	 * 
	 * @param request
	 * @return Matr�cula do Usu�rio obtida atrav�s do m�todo getName da
	 *         implementa��o da interface Principal
	 */
	protected String getUserPrincipalName(HttpServletRequest request) {
		return request.getUserPrincipal() != null ? request.getUserPrincipal()
				.getName() : "";
	}

	/**
	 * Marca o momento em que o ThreadFilter terminou a execu��o do m�todo
	 * doFilter loga a URL que est� sendo executada e o tempo gasto durante o
	 * processo.</br> <b>Obs:</b> Para que funcione, � necess�rio que a
	 * propriedade <i>audita.thread.filter</i> esteja definida como <i>true</i>
	 * no arquivo <i>siga.properties</i>.
	 */
	protected void terminaAuditoria(final StringBuilder csv) {

		if (this.isAuditaThreadFilter && csv != null) {

			String tempoGastoFormatado = SigaHibernateAuditorLogUtil
					.getTempoGastoFormatado();
			long tempoGastoMillisegundos = SigaHibernateAuditorLogUtil
					.getTempoGastoMilliSegundos();

			appendEntreAspas(csv, tempoGastoFormatado);
			appendEntreAspas(csv, tempoGastoMillisegundos);

			log.info(csv);
		}
	}

	/**
	 * Extrai o contexto da aplica��o a partir da requisi��o
	 * 
	 * @param request
	 * @return Contexto da aplica��o
	 */
	private String getContexto(HttpServletRequest request) {
		String contexto = request.getContextPath();
		if (StringUtils.isNotBlank(contexto)) {
			contexto = contexto.substring(1);
		}
		return contexto;
	}

	protected String getAction(String uri, String contexto) {
		String action = null;
		if (StringUtils.isNotBlank(uri) && StringUtils.isNotBlank(contexto)) {
			action = uri.replaceFirst(contexto, "");
		}
		return StringUtils.isNotBlank(action) ? action.substring(1) : action;
	}

	protected String getHostName() {
		String hostName = null;
		try {
			hostName = InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			log.warn(
					"N�o foi poss�vel identificar o nome do Host para adicion�-lo ao Log por CSV",
					e);
			e.printStackTrace();
		}
		return hostName;
	}

	private StringBuilder appendEntreAspas(StringBuilder csv, Object o) {
		return csv.append(SEPARADOR).append(ASPAS).append(o).append(ASPAS);
	}

	/**
	 * Loga como error as exce��es que vierem a acontecer durante a execu��o dos
	 * ThreadFiltesr
	 * 
	 * @param request
	 * @param ex
	 */
	protected void logaExcecaoAoExecutarFiltro(final ServletRequest request,
			final Exception ex) {

		HttpServletRequest httpRequest = (HttpServletRequest) request;

		String url = httpRequest.getRequestURL().toString();
		String queryString = httpRequest.getQueryString() != null ? "?"
				+ httpRequest.getQueryString() : "";
		String principalName = httpRequest.getUserPrincipal() != null ? httpRequest
				.getUserPrincipal().getName() : "convidado";

		String mensagemErro = this.montaMensagemErroExcecoes(ex);

		// N�o logar AplicacaoException, pois � erro de l�gica de neg�cio e n�o falha do sistema
		if (ex instanceof AplicacaoException)
			return;
		if (ex.getCause() != null) {
			if (ex.getCause() instanceof AplicacaoException)
				return;
			if (ex.getCause().getCause() != null
					&& ex.getCause() instanceof AplicacaoException)
				return;
		}

		log.error(mensagemErro + "\nURL: " + url + queryString + "\nUser: "
				+ principalName, ex);
	}

	public void init(FilterConfig arg0) throws ServletException {
		log.info("INIT THREAD FILTER");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

	}

	public void destroy() {
		log.info("DESTROY THREAD FILTER");
	}

	protected String montaMensagemErroExcecoes(Exception ex) {
		String mensagemErro = "";
		if (ex != null) {
			mensagemErro += ex.getMessage();
			if (ex instanceof AplicacaoException && ex.getCause() != null) {
				mensagemErro += " Causa: " + ex.getCause().getMessage();
			}
		}

		return mensagemErro;
	}

	public void registerTransactionClasses(Configuration cfg) {
		// bruno.lacerda@avantiprima.com.br
		this.registerTransactionClass("hibernate.transaction.factory_class",
				cfg);
		this.registerTransactionClass(
				"hibernate.transaction.manager_lookup_class", cfg);
	}

	private void registerTransactionClass(String propertyName, Configuration cfg) {
		String transactionFactoryClassName = System.getProperty(propertyName);
		if (StringUtils.isNotBlank(transactionFactoryClassName)) {
			cfg.setProperty(propertyName, transactionFactoryClassName);
		}
	}

}
