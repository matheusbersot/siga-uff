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
 			<mod:grupo titulo="Desembargador Federal Licenciado:">
			   <mod:grupo>
				  <mod:pessoa titulo="Nome" var="deslic" />
		       </mod:grupo>
		       <br>
		    </mod:grupo>
		    <mod:grupo titulo="Per�odo Concedido de Licen�a">
		        <mod:texto titulo="N�mero de Dias" var="nume" largura="5"/>
				<mod:texto titulo="N�mero de Dias por Extenso" var="diasext" largura="25"/>
		        <mod:data titulo="Data de In�cio de Afastamento" var="dtin" />
			</mod:grupo>
		    <br>
	   <br><br>
		
	</mod:entrevista>
	
	<mod:documento>
	<c:set var="federal" value ="${f:pessoa(requestScope['deslic_pessoaSel.id'])}" />
	    <mod:valor var="texto_ptp">
			<br/><br/>
			<c:set var="licen" value="� Excelent�ssima Desembargadora Federal" />
		    <c:if test="${federal.sexo == 'M'}">
		        <c:set var="licen" value="ao Excelent�ssimo Desembargador Federal" />
		    </c:if>
			<p style="TEXT-INDENT: 2cm" align="justify">
			<b><c:choose><c:when test="${doc.subscritor.sexo == 'M'}">O PRESIDENTE</c:when><c:otherwise>A PRESIDENTE</c:otherwise></c:choose> 
			DO TRIBUNAL REGIONAL FEDERAL DA 2� REGI�O</b>, no uso de suas atribui��es, e considerando o que consta nos autos do Processo Administrativo 
			n� <c:choose><c:when test="${tipproc == 'Outro'}">${proc}</c:when><c:otherwise>${proc}-${tipproc}</c:otherwise></c:choose>, <b>RESOLVE</b>:<br><br>
			<b>CONCEDER</b> <c:choose><c:when test="${nume == '1'}">um dia </c:when><c:otherwise>${nume} (${diasext}) dias </c:otherwise></c:choose> 
			de licen�a para tratamento de sa�de ${licen} <b>${federal.nomePessoa}</b>,<c:choose><c:when test="${nume == '1'}"> em ${dtin}</c:when><c:otherwise> no 
			per�odo de ${dtin} a ${f:calculaData(nume,requestScope['dtin'])}</c:otherwise></c:choose>, nos termos
			do art. 9, inciso I, da Lei Complementar n� 35, de 14/03/1979, que disp�e sobre a Lei Org�nica da Magistratura Nacional.
			
		</mod:valor>  	
		</mod:documento>
</mod:modelo>