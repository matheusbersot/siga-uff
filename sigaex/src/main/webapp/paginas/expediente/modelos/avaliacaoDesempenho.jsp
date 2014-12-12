<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
				<mod:texto titulo="Artigo 1:" var="art1" largura="3"/>
				<mod:texto titulo="Artigo 2:" var="art2" largura="3"/>
			<mod:grupo>
				<mod:texto titulo="N� Resolu��o:" var="numResolucao" largura="10" />
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="nome" />
			</mod:grupo>
					<mod:caixaverif titulo="Nome n�o relacionado acima?" var="nomeConstatado" reler="ajax" idAjax="nomeConstatadoAjax"/>
				<mod:grupo depende="nomeConstatadoAjax">
					<c:if test="${nomeConstatado == 'Sim'}">
						<mod:texto titulo="Nome do Cedido:" var="nomeCedido" largura="60" />
					<mod:grupo>
						<mod:texto titulo="Cargo:" var="cargo" largura="60" />
					</mod:grupo>
					<mod:grupo>
						<mod:texto titulo="Lota��o:" var="lotacao" largura="60" />
					</mod:grupo>
					</c:if>
				</mod:grupo>
			<mod:grupo titulo="Per�odo em Exerc�cio">
				<mod:data titulo="De" var="dataInicio" />
				<mod:data titulo="a" var="dataFim" />
			</mod:grupo>
	</mod:entrevista>
	<mod:documento>
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
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" width="100%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">HOMOLOGA��O DE AVALIA��O DE DESEMPENHO EM EST�GIO PROBAT�RIO</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->
		<br><br>
		
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 <c:choose>
		 	<c:when test="${nomeConstatado == 'Sim'}">
		 	NOME: <b>${nomeCedido}</b>
		 	</c:when>
		 	<c:otherwise>
		 	NOME: <b>${requestScope['nome_pessoaSel.descricao']}</b>
		 	</c:otherwise>
		 </c:choose>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 <c:choose>
		 	<c:when test="${nomeConstatado == 'Sim'}">
		 	CARGO: <b>${cargo}</b>
		 	</c:when>
		 	<c:otherwise>
			CARGO: <b>${f:pessoa(requestScope['nome_pessoaSel.id']).cargo.descricao}</b>
		 	</c:otherwise>
		 </c:choose>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
			EXERC�CIO: <b>${dataInicio }</b>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 <c:choose>   
		 	<c:when test="${nomeConstatado == 'Sim'}">
		 	LOTA��O: <b>${lotacao}</b>
		 	</c:when>
		 	<c:otherwise>
			LOTA��O: <b>${f:pessoa(requestScope['nome_pessoaSel.id']).lotacao.descricao}</b>
		 	</c:otherwise>
		 </c:choose> 
		 </p>
		 <br>
		 
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Tendo em vista o disposto no(s) artigo(s) <c:choose><c:when test="${(art1 == art2) or (empty art2)}"> ${art1}</c:when><c:otherwise> ${art1} e ${art2}</c:otherwise></c:choose> da Resolu��o n&ordm; ${numResolucao } do Conselho da Justi�a Federal, no parecer
		 conclusivo da Comiss�o de Avalia��o de Desempenho e na Resolu��o n&ordm; 444 de 09-06-2005 do Conselho da Justi�a Federal, <b>homologo</b>
		 o resultado das Avalia��es de Desempenho em Est�gio Probat�rio do(a) servidor(a) <c:choose><c:when test="${nomeConstatado == 'Sim'}"><b>${nomeCedido}</b></c:when><c:otherwise><b>${requestScope['nome_pessoaSel.descricao']}</b></c:otherwise></c:choose>, confirmando-o(a) no cargo de
		 <c:choose><c:when test="${nomeConstatado == 'Sim'}"><b>${cargo}</b></c:when><c:otherwise><b>${f:pessoa(requestScope['nome_pessoaSel.id']).cargo.descricao}</b></c:otherwise></c:choose>, em virtude de preencher os requisitos estabelecidos pelo art. 20 da Lei n&ordm; 8.112/90 durante o <c:choose><c:when test="${(dataInicio == dataFim) or (empty dataFim)}">dia ${dataInicio}.</c:when><c:otherwise>per�odo compreendido entre ${dataInicio} e ${dataFim}.</c:otherwise></c:choose>
		</p>
		
		 <br>
		<p>&nbsp;</p>
		
		<p align="center">${doc.dtExtenso}</p>
		
		<p>&nbsp;</p>
		
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp" />
	
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />

		</body>
		</html>
	</mod:documento>
</mod:modelo>
