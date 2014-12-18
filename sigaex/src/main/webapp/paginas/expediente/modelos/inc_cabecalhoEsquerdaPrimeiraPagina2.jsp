<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${empty f:orgaoUsuarioPresenteNoCabecalhoModelo()}">
		<c:set var="mostrarOrgaoUsuario" scope="request" value="true" />
	</c:when>
	<c:otherwise>
		<c:set var="mostrarOrgaoUsuario" scope="request"
			value="${f:orgaoUsuarioPresenteNoCabecalhoModelo()}" />
	</c:otherwise>
</c:choose>

<table width="100%" align="left" border="0" bgcolor="#FFFFFF">
	<col width="15%"></col>
	<col width="1%"></col>
	<col width="84%"></col>
	<tr bgcolor="#FFFFFF">
		<td align="left" valign="bottom"><img
			src="contextpath/imagens/brasao2.png" width="65" height="65" /></td>
		<td align="left"></td>
		<td >
		<table align="left" width="100%">
			<tr>
				<td width="100%" align="left">
				<p style="font-size: 11pt;">${f:resource('siga.ex.modelos.cabecalho.titulo')}</p>
				</td>
			</tr>
			<c:if test="${not empty f:resource('siga.ex.modelos.cabecalho.subtitulo')}">
				<tr>
					<td width="100%" align="left">
					<p style="font-size: 10pt; font-weight: bold;">${f:resource('siga.ex.modelos.cabecalho.subtitulo')}</p>
					</td>
				</tr>
			</c:if>
							<c:if test="${mostrarOrgaoUsuario}">
			
			<tr>
				<td width="100%" align="left">
				<p style="font-size: 8pt;">
				<c:choose>
					<c:when test="${empty mov}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when>
					<c:otherwise>${mov.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:otherwise>
				</c:choose></p>
				</td>
			</tr>
			</c:if>
		</table>
		</td>
	</tr>
</table>
