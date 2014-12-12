<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/solicitacao.jsp">

	<mod:entrevista>
		<mod:grupo>
			<mod:pessoa titulo="Substituto" var="substituto" />
		</mod:grupo>
		<mod:grupo>
			<mod:pessoa titulo="Titular" var="titular" />
		</mod:grupo>
		<mod:grupo titulo="Per�odo Solicitado">
			<mod:data titulo="De" var="dataInicio" />
			<mod:data titulo="a" var="dataFim" />
		</mod:grupo>
		<mod:grupo>
			<mod:selecao reler="sim" titulo="Por motivo de" var="motivo" opcoes="[SELECIONE];AUS�NCIA EM RAZ�O DE FALECIMENTO DE FAMILIAR;AUS�NCIA AO SERVI�O POR MOTIVO DE CASAMENTO;AFASTAMENTO AUTORIZADO PARA DOA��O DE SANGUE;COMPENSA��O DOS DIAS TRABALHADOS NO RECESSO JUDICI�RIO;COMPENSA��O DOS DIAS TRABALHADOS NAS ELEI��ES;LICEN�A PR�MIO;F�RIAS REGULAMENTARES;LICEN�A PARA TRATAMENTO DA PR�PRIA SA�DE;LICEN�A GESTANTE;LICEN�A PARA CAPACITA��O;LICEN�A POR MOTIVO DE DOEN�A EM PESSOA DA FAMILIA;LICEN�A PATERNIDADE;LICEN�A ADOTANTE;PARTICIPA��O EM A��ES DE CAPACITA��O;TITULAR SUBSTITUI OUTRO;OUTROS"/>
		</mod:grupo>
		<c:if test="${motivo == 'OUTROS'}">
			<mod:texto var="outrosMotivos" titulo="Por motivo de" largura="60"/>
		</c:if>
	</mod:entrevista>
	<mod:documento>						
	
		<mod:valor var="texto_solicitacao"><p style="TEXT-INDENT: 2cm" align="justify">Solicito as provid�ncias necess�rias para que o(a) servidor(a) <mod:identificacao pessoa="${requestScope['substituto_pessoaSel.id']}" nivelHierarquicoMaximoDaLotacao="4"/>
			<b>substitua</b>
			o(a) servidor(a) 
			 <mod:identificacao pessoa="${requestScope['titular_pessoaSel.id']}" funcao="sim" negrito="sim" nivelHierarquicoMaximoDaLotacao="4"/>
			<c:choose>
				<c:when test="${(dataInicio == dataFim) or (empty dataFim)}">
					no dia <b>${dataInicio}</b>,
				</c:when>
					<c:otherwise>
					no per�odo de <b>${dataInicio}</b> a <b>${dataFim}</b>,
					</c:otherwise>
			</c:choose>
			por motivo de <c:choose><c:when test="${motivo != 'OUTROS'}"><b>${motivo}</b></c:when><c:otherwise><b>${outrosMotivos}</b></c:otherwise></c:choose>.
			</p>
		</mod:valor>
	</mod:documento>
</mod:modelo>

