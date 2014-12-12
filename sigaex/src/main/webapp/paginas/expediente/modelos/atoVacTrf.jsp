<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/ato_presidencia.jsp">
	<mod:entrevista>
 			<mod:grupo>
				<mod:pessoa titulo="<b>Nome do Servidor</b>" var="titular" />
			</mod:grupo>
			<br>
			<mod:grupo>
				<mod:selecao titulo="<b>Classe</b>" var="classe"  opcoes=" ;A;B;C" reler="sim" />
				<mod:selecao titulo="<b>N�vel</b>" var="nivel"  opcoes=" ;NA;NI;NS" reler="sim" />
				<mod:selecao titulo="<b>Padr�o</b>" var="padr"  opcoes=" ;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15" reler="sim" />
	    	</mod:grupo>
	   <br><br>
		
		<mod:grupo>
			<mod:data titulo="<b>Data de In�cio da Vac�ncia</b>" var="dtvac" />
		</mod:grupo>
		<br><br>
		<mod:grupo>
			    <mod:texto titulo="<b>Processo Administrativo</b>" var="proc" largura="40"/>
			    <mod:selecao titulo="<b>Tipo</b>" var="tipproc" opcoes="ADM;PES;Outro" reler="sim" />
		    </mod:grupo>
		<br><br>
	</mod:entrevista>
	
	<mod:documento>
	<c:set var="tit" value ="${f:pessoa(requestScope['titular_pessoaSel.id'])}" />
	<c:set var="opt" value="1"/>
	<c:if test="${(classe == ' ') and not empty tit.padraoReferencia}">
	   <c:set var="opt" value="${f:classNivPadr(tit.padraoReferencia)}"/>
	</c:if>
	
		<mod:valor var="texto_ato">
			<br/>
			<p style="TEXT-INDENT: 2cm" align="justify">
			<c:choose><c:when test="${doc.subscritor.sexo == 'M'}">O PRESIDENTE</c:when><c:otherwise>A PRESIDENTE</c:otherwise></c:choose> 
			DO TRIBUNAL REGIONAL FEDERAL DA 2� REGI�O, no uso de suas atribui��es, e considerando o que consta nos autos do Processo Administrativo 
			n� <c:choose><c:when test="${tipproc == 'Outro'}">${proc}</c:when><c:otherwise>${proc}-${tipproc}</c:otherwise></c:choose>, RESOLVE:<br><br>
			DECLARAR VAGO,  
			a partir de ${dtvac} o cargo de ${f:maiusculasEMinusculas(tit.cargo.nomeCargo)}, 
			<c:choose><c:when test="${opt != '1'}">${opt}</c:when><c:otherwise>Classe "${classe}", Nivel "${nivel}", Padr�o "${padr}"</c:otherwise></c:choose>,
			  do Quadro de Pessoal deste Tribunal,
			ocupado <c:choose><c:when test="${tit.sexo == 'M'}">pelo servidor </c:when><c:otherwise>pela servidora </c:otherwise></c:choose>
		${tit.nomePessoa}, em virtude de posse em outro cargo p�blico federal inacumul�vel, com base no artigo 33, inciso VIII, da Lei n� 
		8.112/90 c/c a Resolu��o n� 03/2008, do Conselho da Justi�a Federal.
	    
		</mod:valor>  	
		</mod:documento>
</mod:modelo>