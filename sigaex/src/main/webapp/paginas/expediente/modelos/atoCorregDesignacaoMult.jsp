<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/ato_corregedoria.jsp">
	<mod:entrevista>

		<mod:grupo titulo="Juiz a ser substitu�do">
			<mod:grupo>
				<mod:selecao titulo="Dr" var="genero"  opcoes="masc;fem" reler="n�o" />
				<mod:selecao titulo="Juiz Federal" var="titulo" opcoes="Substituto;Titular" reler="n�o"/>
				<mod:selecao titulo="na titularidade" var="estado"  opcoes="sim;n�o" reler="n�o" />
				<mod:selecao titulo="Com preju�zo" var="prej"  opcoes="sim;n�o" reler="n�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="pessoa" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="em virtude" var="motivo"  reler="n�o"/>
				<mod:selecao titulo="N� de Juizes" var="numJuizes" opcoes="1;2;3;4;5;6;7;8;9;10" reler="ajax" idAjax="numJuizAjax" />
			</mod:grupo>
		</mod:grupo>
		<hr>
	
	
		<mod:grupo titulo="Juizes a serem Designados" depende="numJuizAjax">
			<c:forEach var="i" begin="1" end="${numJuizes}">
				<mod:grupo>
					<mod:selecao titulo="Dr" var="genero${i}"  opcoes="masc;fem" reler="n�o" />
					<mod:selecao titulo="Juiz Federal" var="titulo${i}" opcoes="Titular;Substituto" reler="n�o"/>
					<mod:selecao titulo="na titularidade" var="estado${i}"  opcoes="sim;n�o" reler="n�o" />
					<mod:selecao titulo="Com preju�zo" var="prej${i}"  opcoes="sim;n�o" reler="n�o" />
				</mod:grupo>
				<mod:grupo>					
					<mod:pessoa titulo="Nome" var="pessoa${i}" />
				</mod:grupo>
				<mod:grupo>
					<mod:data titulo="De" var="dtMarcada1${i}" />
					<mod:data titulo="a" var="dtMarcada2${i}" />
				</mod:grupo>
				<hr>
			</c:forEach>
		</mod:grupo>
	</mod:entrevista>
	
	
	
	
	<mod:documento>
		<mod:valor var="texto_ato">
		<html>
		<body>
		<c:set var="pessoa_resp" value ="${f:pessoa(requestScope['pessoa_pessoaSel.id'])}" />
			<br/><br/>
			<p style="TEXT-INDENT: 2cm" align="justify">
			O Doutor ${doc.subscritor.descricao}, Corregedor-Regional da Justi�a Federal da 2� Regi�o, no uso 
			de suas atribui��es legais e nos termos do art 4� da Resolu��o n� 026 de 23 de julho 2009
			da Presid�ncia deste Tribunal, RESOLVE designar 			
			
			
			<c:forEach var="i" begin="1" end="${numJuizes}">
				
				<c:set var="desig" value ="${f:pessoa(requestScope[f:concat(f:concat('pessoa',i),'_pessoaSel.id')])}" />
				<c:choose>
					<c:when test="${requestScope[f:concat('genero',i)] == 'fem'}">a MM. Juiza Federal</c:when>
					<c:otherwise>o MM. Juiz Federal</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${requestScope[f:concat('titulo',i)] == 'Titular'}">titular</c:when>
					<c:when test="${requestScope[f:concat('titulo',i)] != 'Titular' && requestScope[f:concat('genero',i)] == 'fem'}">substituta</c:when>
					<c:when test="${requestScope[f:concat('titulo',i)] != 'Titular' && requestScope[f:concat('genero',i)] == 'masc'}">substituto</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${requestScope[f:concat('titulo',i)] != 'Titular' && requestScope[f:concat('estado',i)] == 'sim'}">na titularidade</c:when>
				</c:choose> do(a) 
				${desig.lotacao.descricao},
				<c:choose>
					<c:when test="${requestScope[f:concat('genero',i)] == 'fem'}">Dr�.</c:when>
					<c:otherwise>Dr.</c:otherwise>
				</c:choose>
				${desig.descricao}, 			
				<c:choose>
					<c:when test="${requestScope[f:concat('prej',i)] == 'sim'}">com</c:when>
					<c:otherwise>sem</c:otherwise>
				</c:choose>
				preju�zo de sua jurisdi��o, assumir a titularidade do(a) ${pessoa_resp.lotacao.descricao }, no per�odo de ${requestScope[f:concat('dtMarcada1',i)]} a ${requestScope[f:concat('dtMarcada2',i)]},
				
				

			</c:forEach>
			em virtude de ${motivo} 
			<c:choose>
				<c:when test="${genero == 'fem'}">da MM. Ju�za Federal</c:when>
				<c:otherwise>do MM. Ju�z Federal</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${titulo == 'Titular'}">titular</c:when>
				<c:when test="${titulo != 'Titular' && genero == 'fem'}">substituta</c:when>
				<c:when test="${titulo != 'Titular' && genero == 'masc'}">substituto</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${titulo != 'Titular' && estado == 'sim'}">na titularidade</c:when>
			</c:choose> do(a) 
			${pessoa_resp.lotacao.descricao }, 
			${pessoa_resp.nomePessoa}.
		</mod:valor>
		
	</mod:documento>
</mod:modelo>