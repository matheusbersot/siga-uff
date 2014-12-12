<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Forma de tratamento do destinat�rio" var="forTratamento" largura="25" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Cargo do destinat�rio" var="carDestinatario"
					largura="60" />
			</mod:grupo>
			<mod:grupo titulo="Texto a ser inserido no corpo da carta">
				<mod:grupo>
					<mod:editor titulo="" var="texto_carta" />
				</mod:grupo>
			</mod:grupo>

		</mod:grupo>
		
		<mod:selecao titulo="Tamanho da letra" var="tamanhoLetra" opcoes="Normal;Pequeno;Grande"/>
	</mod:entrevista>

	<mod:documento>
		<c:if test="${tamanhoLetra=='Normal'}"><c:set var="tl" value="11pt"/></c:if>
		<c:if test="${tamanhoLetra=='Pequeno'}"><c:set var="tl" value="9pt"/></c:if>
		<c:if test="${tamanhoLetra=='Grande'}"><c:set var="tl" value="13pt"/></c:if>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			@page {
				margin-left: 3cm;
				margin-right: 3cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
		</style>
		</head>
		<body>
	<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/>
					<table width="100%" border="2" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" width="100%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">RELAT�RIO ${doc.codigo}</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->
		
		<br> <br>
		<table width="100%" border="2" cellpadding="0" cellspacing="0">
			<tr>
		    	<td align="center" width="100%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">LAUDO M�DICO</p></td>
			</tr>
		</table>
		<mod:letra tamanho="${tl}">
		
		<div style="font-family:Arial;font-size:10pt;">
			<p>&nbsp;</p>
			<p style="TEXT-INDENT: 2cm">${forTratamento}</p>
			<p style="TEXT-INDENT: 2cm">${carDestinatario},</p>
			<span style="font-size:${tl};">
			${texto_carta}
			</span>	
		</div>
		
		<br>
		<p align="center">${doc.dtExtenso}</p>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		</mod:letra>
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
		FIM RODAPE -->
	
		</body>
		</html>
	</mod:documento>
</mod:modelo>

