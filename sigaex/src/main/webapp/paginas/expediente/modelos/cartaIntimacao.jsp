<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="Dados referenciais">
			<mod:grupo>
				<mod:texto titulo="Processo Administrativo n�" var="num_processo" largura="25" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Intimando" var="intimando" largura="60" />
			</mod:grupo>
			<mod:grupo>
				<mod:memo titulo="Endere�o" var="endereco_dest" linhas="4" colunas="60"/>
			</mod:grupo>
		    <mod:grupo titulo="Texto a ser inserido no corpo da intima��o">
			    <mod:grupo>
					<mod:editor titulo="" var="texto_intimacao"/>
				</mod:grupo>
			</mod:grupo>	
			<mod:grupo>
				<mod:texto titulo="Base Legal" var="baselegal" largura="40" />
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
				margin-right: 2cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
			</style>
		</head>
		<body>
			<!-- INICIO PRIMEIRO CABECALHO
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<br><br/><c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
						</td>	
					</tr>
					<tr bgcolor="#FFFFFF">
						<td cellpadding="5">
							&nbsp;
						</td>
					</tr>
				</table>
			FIM PRIMEIRO CABECALHO -->

			<!-- INICIO CABECALHO
				<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
				<br/><br/>
			FIM CABECALHO -->	
			<c:forEach var="x" begin="0" end="1"><br/></c:forEach>
			<table width="100%" border=0 bgcolor="#FFFFFF">
				<tr><td><b>JUSTI�A FEDERAL DE 1� GRAU</b></td></tr>
				<tr><td><b>SE��O JUDICI�RIA DO RIO DE JANEIRO</b></td></tr>
				<tr><td><b>AV. RIO BRANCO, N� 243 - 13� ANDAR - ANEXO I</b></td></tr>
				<tr><td><b>CENTRO - RIO DE JANEIRO - RJ</b></td></tr>
	     		<tr><td><b>CEP: 20.040-009</b></td></tr>
			</table>
			<br/>
			
			<table width="100%" border=0 bgcolor="#FFFFFF">
				<tr><td><b>Processo Administrativo n�: ${num_processo}</b><br/><br/></td></tr>
				<tr><td><b>INTIMANDO:&nbsp ${intimando}</b><br/><br/></td></tr>
			</table>	
			<table width="100%" border=0 bgcolor="#FFFFFF">
				<tr><td width="16%" valign="top"><b>ENDERE�O:&nbsp</b></td><td width="84%"><siga:fixcrlf>${endereco_dest}</siga:fixcrlf></td></tr>
			</table>
			<br/>
			<br/>
		
			
			<p align="center"><B>CARTA DE INTIMA��O - N&ordm; - ${doc.codigo} </b></p>
			<p align="justify">${texto_intimacao}</p>
			<p align="center">${doc.dtExtenso}</p><br/>
			
		<p align="left" style="TEXT-INDENT: 2cm">${doc.dtExtenso}</p><br/>
		
		<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp"/>
		
		<p align="center"><b>${baselegal}</b></p>
		
		
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->
		</body>
		</html>
		</mod:documento>
</mod:modelo>	