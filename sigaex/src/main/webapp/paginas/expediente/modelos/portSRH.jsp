<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo urlBase="/paginas/expediente/modelos/portaria.jsp?tipo=SRH" >
	<mod:entrevista>
		<c:if test="${empty texto_portaria}">
		<c:set var="texto_portariaSRH" scope="request">
			<!-- INICIO ABERTURA --><p style="TEXT-INDENT: 2cm" align="justify"><b>A DIRETORA DA SUBSECRETARIA DE GEST�O DE PESSOAS
			DA JUSTI�A FEDERAL DE 1&ordf; INST�NCIA - SE��O JUDICI�RIA DO RIO
			DE JANEIRO</b>, usando a compet�ncia que lhe foi delegada pela Portaria n&ordm; 011 - GDF, de 26 de mar�o de 2003,
			</p>

			<p style="TEXT-INDENT: 2cm" align="justify"><b>RESOLVE:</b></p><!-- FIM ABERTURA -->
			
			<!-- INICIO CORPO --><p style="TEXT-INDENT: 2cm" align="justify">&nbsp;</p><!-- FIM CORPO -->
		</c:set>
		</c:if>
	</mod:entrevista>
</mod:modelo>

