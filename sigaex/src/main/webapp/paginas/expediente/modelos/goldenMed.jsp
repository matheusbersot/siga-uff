<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo>
			<mod:pessoa var="servidor" titulo="Servidor"/>
		</mod:grupo>
		<mod:data var="data" titulo="Elencado a partir de"/>
		<mod:grupo>	
			<mod:texto var="identificacaoServidor" titulo="Identifica��o do servidor"/>
			<mod:selecao reler="ajax" idAjax="solicitacaoAjax" opcoes="[Selecione];ades�o;exclus�o" var="solicitacao" titulo="Solicito a:"/>
		</mod:grupo>
		<mod:grupo depende="solicitacaoAjax">
		<c:choose>
			<c:when test="${solicitacao!='[Selecione]'}">
				<mod:selecao titulo="Quantidade de dependentes" idAjax="qtdDependenteAjax" var="qtdDependente" opcoes="1;2;3;4;5;6;7;8;9;10" reler="ajax"/>
					<mod:grupo titulo="Nome dos dependentes">
						<mod:grupo depende="qtdDependenteAjax">
							<c:forEach var="i" begin="1" end="${qtdDependente}">
								<mod:grupo>
									<mod:texto titulo="${i}" var="dependente${i}" largura="50"/>
								</mod:grupo>
							</c:forEach>
						</mod:grupo>
					</mod:grupo>
			</c:when>
		</c:choose>
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
	<c:set var="tl" value="8pt" />	
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
	<mod:letra tamanho="${tl}">
	<c:set var="pes" value="${f:pessoa(requestScope['servidor_pessoaSel.id'])}"/> 
	<table width="100%" border="1" cellpadding="3">
		<tr>	
			<td align="center" width="70%">
			<br>
				<h2>Golden Cross</h2> - Cobertura opcional
			<br>
			<br>
			<td align="center">				
				Golden Med						
			</td>
		</tr>
	</table>
	<table width="100%" border="1" cellpadding="3">
		<tr>
			<td><p align="justify">Identifica��o do titular:&nbsp;&nbsp;${identificacaoServidor}</p><br/>
				<p align="justify">Matricula:&nbsp;&nbsp;${requestScope['servidor_pessoaSel.sigla']}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lota��o: ${pes.lotacao.descricao}</p><br/>
			</td>			
		</tr>		
	</table>
	<table width="100%" border="1" cellpadding="3">
		<tr>
			<td align="center" width="20%"><br><b>Solicito a</b><br/><br/></td>
			<td width="20%"><c:choose><c:when test="${solicitacao=='ades�o'}">[x] ades�o<br><br>[&nbsp;&nbsp;] exclus�o</c:when><c:when test="${solicitacao=='exclus�o'}">[&nbsp;&nbsp;] ades�o<br><br>[x] exclus�o</c:when><c:otherwise>[&nbsp;&nbsp;] ades�o<br><br>[&nbsp;&nbsp;] exclus�o</c:otherwise></c:choose></td>
			<td>&nbsp;&nbsp;dos benefici�rios abaixo elencados na <b>Golden Med</b> a partir de ${data} </td>
		</tr>		
	</table>
	<table width="100%" border="1" cellpadding="3">
		<tr>
			<td>
				Titular:&nbsp;&nbsp; ${requestScope['servidor_pessoaSel.descricao']}<br><br> 
				<p>Dependentes:</p>
				<c:forEach var="i" begin="1" end="${qtdDependente}">
						<c:if test="${i==1}">&nbsp;</c:if><c:if test="${i!=1}"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
					${i} - &nbsp;${requestScope[f:concat('dependente',i)]}
				</c:forEach>				
			</td>
		</tr>
	</table>
	<table width="100%" border="1" cellpadding="3">
		<tr>
			<td>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- No Golden Med n�o h� cobran�a proporcional a per�odo(pro rata), <b>nem movimenta��o retroativa</b> sendo a ving�ncia SEMPRE EM DIA PRIMEIRO.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Agregados, Dependentes Ec�nomicos e Benefici�rios Designados descontam antecipado.<br> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Caso o titular solicite a sua exclus�o do Golden Med e deseje incluir dependentes, dever� elenca-los no campo acima.<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- N�o ser� poss�vel solicitar a inclus�o de qualquer dependente (dependentes diretos, agregados, pais dependentes econ�micos e benefici�rios designados), sem que o titular esteja cadastrado no benef�cio. 
				<br><br>
			</td>
		</tr>
	</table>
	<table width="100%" border="1" cellpadding="3">
		<tr>
			<td>
				<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tenho ci�ncia de que deverei entregar este requerimento � <b>SEBENS/SRH at� o dia 20</b>, para que o in�cio da ving�ncia(da inclus�o ou da exclus�o) seja da data acima solicitada.
				<br><br>
			</td>
		</tr>
	</table>
	<br>
	<p style="TEXT-INDENT: 2cm">${doc.dtExtenso}</p><br>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp" />
	
	<p align="center">Recebido pela SEBENS/SRH em ____/____/____ &nbsp;&nbsp; - por:_________________________ 
	
	</mod:letra>
	</mod:documento>
</mod:modelo>

