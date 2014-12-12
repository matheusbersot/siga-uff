<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/ato_corregedoria.jsp">
	<mod:entrevista>

		<mod:grupo titulo="Juiz Federal Designado">
			<mod:grupo>
				<mod:selecao titulo="Sexo" var="genero2"  opcoes="masc;fem" reler="n�o" />
				<mod:selecao titulo="Juiz Federal" var="sub" opcoes="Substituto;Titular" reler="n�o"/>
				<mod:selecao titulo="na titularidade" var="estado2"  opcoes="sim;n�o" reler="n�o" />
				<mod:selecao titulo="Com preju�zo" var="prej2"  opcoes="sim;n�o" reler="n�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="substituto" />
			</mod:grupo>	
		</mod:grupo>
		
		<mod:grupo titulo="Juiz Federal Substitu�do">
			<mod:grupo>
				<mod:selecao titulo="Sexo" var="genero1"  opcoes="masc;fem" reler="n�o" />
				<mod:selecao titulo="Juiz Federal" var="titulo1" opcoes="Titular;Substituto" reler="n�o"/>
				<mod:selecao titulo="na titularidade" var="estado1"  opcoes="sim;n�o" reler="n�o" />				
				<mod:selecao titulo="em virtude" var="mot1" opcoes="licen�a m�dica;f�rias" reler="n�o"/>
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="titular" />
			</mod:grupo>
		</mod:grupo>
		
		<mod:grupo titulo="Per�odo Solicitado">
			<mod:data titulo="De" var="dtMarcada1" />
			<mod:data titulo="a" var="dtMarcada2" />
		</mod:grupo>
		
	</mod:entrevista>
	
	<mod:documento>
		<c:set var="pessoa_titular" value ="${f:pessoa(requestScope['titular_pessoaSel.id'])}" />
		<c:set var="pessoa_subst" value ="${f:pessoa(requestScope['substituto_pessoaSel.id'])}" />
		
		<mod:valor var="texto_ato">
			<br/><br/>
			<p style="TEXT-INDENT: 2cm" align="justify">
			O Doutor ${doc.subscritor.descricao}, Corregedor-Regional da Justi�a Federal da 2� Regi�o, no uso 
			de suas atribui��es legais e nos termos do art 4� da Resolu��o n� 026 de 23 de julho 2009
			da Presid�ncia deste Tribunal, RESOLVE designar 
			
			<c:choose>
				<c:when test="${genero2 == 'fem'}">a MM Juiza Federal</c:when>
				<c:otherwise>o MM Juiz Federal</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${titulo2 == 'Titular'}">titular</c:when>
				<c:when test="${titulo2 != 'Titular' && genero2 == 'fem'}">substituta</c:when>
				<c:when test="${titulo2 != 'Titular' && genero2 == 'masc'}">substituto</c:when>
			</c:choose> do(a)
           
            
			${pessoa_subst.lotacao.descricao},
			<c:choose>
				<c:when test="${genero2 == 'fem'}">Dr�.</c:when>
				<c:otherwise>Dr.</c:otherwise>
			</c:choose>	
			${ pessoa_subst.nomePessoa}, para assumir, 
			
			<c:choose>
				<c:when test="${prej2 == 'sim'}">com</c:when>
				<c:otherwise>sem</c:otherwise>
			</c:choose>
			
			prejuizo de sua jurisdi��o, a titularidade do(a) 
			${pessoa_titular.lotacao.descricao} de ${dtMarcada1} a ${dtMarcada2}
			em virtude de ${ mot1}
			
			<c:choose>
				<c:when test="${genero1 == 'fem'}">da MM Juiza Federal</c:when>
				<c:otherwise>do MM Juiz Federal</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${titulo1 == 'Titular'}">titular</c:when>
				<c:when test="${titulo1 != 'Titular' && genero1 == 'fem'}">substituta</c:when>
				<c:when test="${titulo1 != 'Titular' && genero1 == 'masc'}">substituto</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${titulo1 != 'Titular' && estado1 == 'sim'}">na titularidade do(a)</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${genero1 == 'fem'}">Dr�.</c:when>
				<c:otherwise>Dr.</c:otherwise>
			</c:choose>
			${pessoa_titular.nomePessoa}.
		</mod:valor>

	</mod:documento>
</mod:modelo>