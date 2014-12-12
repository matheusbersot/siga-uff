<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/portariaCorregedoria.jsp">
	<mod:entrevista>
			<mod:grupo>
				<mod:texto titulo="N�" var="port"/>
			</mod:grupo>		
			<mod:grupo>
				<mod:texto titulo="referente ao per�odo" var="periodo"/>
			</mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Dr" var="gen"  opcoes="masc;fem" reler="n�o" />
				<mod:selecao titulo="Juiz Federal" var="juiz" opcoes="Substituto;Titular" reler="n�o"/>
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Nome" var="pessoa" />
			</mod:grupo>
						
			<mod:grupo titulo = "Periodo Marcado">
				<mod:data titulo="de" var="dtMarcada1"/>
				<mod:data titulo="a" var="dtMarcada2"/>
			</mod:grupo>
			
			<mod:grupo titulo = "Periodo Remarcado">
				<mod:data titulo="de" var="dtRemarcada1"/>
				<mod:data titulo="a" var="dtRemarcada2"/>
			</mod:grupo>
				
	


	</mod:entrevista>
	
	<mod:documento>
		<c:set var="pessoa_titular" value ="${f:pessoa(requestScope['pessoa_pessoaSel.id'])}" />

		<mod:valor var="texto_ato">
		<html>
			<body>
			<p style="TEXT-INDENT: 2cm" align="justify">
				O Doutor ${doc.subscritor.descricao}, Corregedor-Regional da Justi��o 
				Federal da <br>2� Regi�o, no uso de suas atribui��es legais RESOLVE:
				<br/><br/><br/>
				Alterar, a pedido, a portaria ${port} desta Corregedoria-Regional, no que 
				tange
				<c:choose>
					<c:when test="${gen=='fem'}">a MM.Juiza Federal da</c:when>
					<c:otherwise>o MM. Juiz Federal</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${gen=='fem' && juiz =='Substituto'}">substituta</c:when>
					<c:when test="${gen!='fem' && juiz =='Substituto'}">substituto</c:when>
					<c:otherwise>titular</c:otherwise>
				</c:choose>
				do(a) ${pessoa_titular.lotacao.descricao}, 
				<c:choose>
					<c:when test="${gen=='fem'}">Dr�.</c:when>
					<c:otherwise>Dr.</c:otherwise>
				</c:choose>
				${ pessoa_titular.nomePessoa}, para explicitar que as f�rias referentes ao ${periodo},
				anteriormente designadas para ${dtMarcada1} a ${dtMarcada2} ser�o fru�das de ${dtRemarcada1} a ${dtRemarcada2 }.
			</body>
		</html>
		</mod:valor>
		
	</mod:documento>
</mod:modelo>