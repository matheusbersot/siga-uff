<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/portaria_presidencia.jsp">
	<mod:entrevista>
	        <br>
	        <mod:grupo>
			    <mod:texto titulo="<b>Processo Administrativo</b>" var="proc" largura="15"/>
			    <mod:selecao titulo="<b>Tipo</b>" var="tipproc" opcoes="ADM;PES;Outro" reler="sim" />
		    </mod:grupo>
		    <br>
 			<mod:grupo>
				<mod:pessoa titulo="<b>Nome do Servidor</b>" var="serv" />
			    <br><br>
			    <mod:selecao titulo="<b>�rea</b>" var="area"  opcoes="Administrativa;Apoio Especializado;Judici�ria" reler="sim" />
			</mod:grupo>
			<br>
			<mod:grupo>
			    <mod:selecao titulo="<b>N�vel</b>" var="niv" opcoes="NA;NI;NS" reler="sim" />
				<mod:selecao titulo="<b>Classe</b>" var="classe" opcoes="A;B;C" reler="sim" />
				<mod:selecao titulo="<b>Padr�o</b>" var="padr" opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15" reler="sim" />
				<mod:selecao titulo="<b>Quadro de Pessoal</b>" var="quadr" opcoes="Se��o Judici�ria do Estado do Rio de Janeiro;Se��o Judici�ria do Estado do Rio de Janeiro;TRF 2� Regi�o" reler="sim" />
			</mod:grupo>
			<br>
			<mod:grupo>
			    <mod:selecao titulo="Acerto Gramatical" var="acgra"  opcoes="ao;�" reler="sim" />
				<mod:texto titulo="<b>�rg�o de Destino</b>" var="dest" largura="40"/>
			</mod:grupo>
	   <br><br>
	</mod:entrevista>
	
	<mod:documento>
	<c:set var="servidor" value ="${f:pessoa(requestScope['serv_pessoaSel.id'])}" />
		<mod:valor var="texto_ptp">
			<br/>
			<p style="TEXT-INDENT: 2cm" align="justify">
			<b><c:choose><c:when test="${doc.subscritor.sexo == 'M'}">O PRESIDENTE</c:when><c:otherwise>A PRESIDENTE</c:otherwise></c:choose> 
			DO TRIBUNAL REGIONAL FEDERAL DA 2� REGI�O</b>, no uso de suas atribui��es, e considerando o que consta nos autos do Processo Administrativo 
			n� <c:choose><c:when test="${tipproc == 'Outro'}">${proc}</c:when><c:otherwise>${proc}-${tipproc}</c:otherwise></c:choose>, <b>RESOLVE</b>:<br><br>
			<b>CEDER</b> <c:choose><c:when test="${servidor.sexo == 'M'}">o servidor </c:when><c:otherwise>a servidora </c:otherwise></c:choose>  
			${servidor.nomePessoa}, ${f:maiusculasEMinusculas(servidor.cargo.nomeCargo)}, �rea ${area}, N�vel 
			<c:choose><c:when test="${niv == 'NA'}">Auxiliar</c:when></c:choose>
			<c:choose><c:when test="${niv == 'NI'}">Intermedi�rio</c:when></c:choose>
			<c:choose><c:when test="${niv == 'NS'}">Superior</c:when></c:choose>, Classe ${classe}, Padr�o ${padr},
			do Quadro de Pessoal <c:choose><c:when test="${quadr == 'TRF 2� Regi�o'}"> do </c:when><c:otherwise> da </c:otherwise></c:choose>  
			${quadr}, ${acgra} ${dest}, nos termos do art.93, inciso I, da Lei n� 8.112/90.
		</mod:valor>  	
		</mod:documento>
</mod:modelo>