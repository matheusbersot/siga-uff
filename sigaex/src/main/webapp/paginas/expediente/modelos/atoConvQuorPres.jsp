<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/ato_presidencia.jsp">
	<mod:entrevista>
 		<mod:grupo titulo="Juiz Federal Convocado:">
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="substituto" />
		    </mod:grupo>
		    <mod:grupo>
				<mod:selecao titulo="Com preju�zo" var="preju"  opcoes="sim;nao" reler="nao" />
			</mod:grupo>
		</mod:grupo>
		<br><br>
		<mod:grupo titulo="Desembargador Federal Substitu�do:">
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="titular" />
	    	</mod:grupo>
	    	<mod:grupo>
				<mod:selecao titulo="Motivo" var="motiv" opcoes="licen�a m�dica;f�rias regulamentares" reler="nao"/>
			</mod:grupo>   
		</mod:grupo>
		<br><br>
		<mod:grupo titulo="Per�odo de Convoca��o:">
			<mod:data titulo="De" var="dtini" />
			<mod:data titulo="a" var="dtfin" />
		</mod:grupo>
		<br><br>
	</mod:entrevista>
	
	<mod:documento>
	<c:set var="pessoa_titular" value ="${f:pessoa(requestScope['titular_pessoaSel.id'])}" />
	<c:set var="pessoa_subst" value ="${f:pessoa(requestScope['substituto_pessoaSel.id'])}" />
		
		    <mod:valor var="texto_ato">
			<br/><br/>
			<p style="TEXT-INDENT: 2cm" align="justify">
			<c:choose>
			<c:when test="${doc.subscritor.sexo == 'M'}">
						O PRESIDENTE
					</c:when>
					<c:otherwise>
					    A PRESIDENTE
					</c:otherwise></c:choose> DO TRIBUNAL REGIONAL FEDERAL DA 2� REGI�O, no uso de suas atribui��es, RESOLVE:<br><br>
			CONVOCAR 
		<c:choose>
			<c:when test="${pessoa_subst.sexo == 'M'}">
						o Excelent�ssimo Juiz Federal
					</c:when>
					<c:otherwise>
					    a Excelent�ssima Ju�za Federal
					</c:otherwise></c:choose>
		da
    	${pessoa_subst.lotacao.descricao}, 
			<c:choose>
				<c:when test="${pessoa_subst.sexo == 'M'}">Dr.</c:when>
				<c:otherwise>Dr�.</c:otherwise>
			</c:choose>	
    	${ pessoa_subst.nomePessoa}, para, 
			
			<c:choose>
				<c:when test="${preju == 'sim'}">com</c:when>
				<c:otherwise>sem</c:otherwise>
			</c:choose>
			
			prejuizo de sua jurisdi��o, compor o quorum deste Tribunal, no per�odo de ${dtini} a ${dtfin}, 
			em virtude de ${motiv} 
			<c:choose>
				<c:when test="${pessoa_titular.sexo == 'M'}">do Excelent�ssimo Desembargador Federal </c:when>
				<c:otherwise>da Excelent�ssima Desembargadora Federal </c:otherwise>
			</c:choose>	
    		${ pessoa_titular.nomePessoa} , nos termos do artigo 48, inciso I, do Regimento Interno desta Corte c/c artigo 1�, inciso I, da Resolu��o n� 51/2009, do 
			Conselho da Justi�a Federal. 
		</mod:valor>
		</mod:documento>
</mod:modelo>