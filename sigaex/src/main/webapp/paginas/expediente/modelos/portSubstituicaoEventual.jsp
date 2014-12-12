<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />

<mod:modelo urlBase="/paginas/expediente/modelos/portaria.jsp">
	<mod:entrevista>
		<mod:grupo>
			<mod:texto titulo="N� da solicita��o" var="solicitacao" largura="35" />
			<mod:texto titulo="N� Portaria Revogada" var="portrevogada"
				largura="20" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Nome do respons�vel" var="responsavel"
				largura="40" />
		</mod:grupo>
		<mod:grupo>
			<mod:pessoa titulo="Servidor" var="servidor" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Observa��es sobre o servidor" var="servidorObs" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Cargo/Fun��o Comissionada" var="cargofc" />
		</mod:grupo>
		<mod:grupo titulo="Per�odo Solicitado">
			<mod:data titulo="De" var="dataInicio" />
			<mod:data titulo="a" var="dataFim" />
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<mod:valor var="texto_portaria">
			<!-- INICIO ABERTURA --><p style="TEXT-INDENT: 2cm" align="justify"><b>O JUIZ FEDERAL
			- DIRETOR DO FORO E CORREGEDOR PERMANENTE DOS SERVI�OS AUXILIARES DA
			JUSTI�A FEDERAL DE 1&ordm; GRAU - <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO</c:otherwise></c:choose></b>, no uso de suas atribui��es legais,</p>

			<p style="TEXT-INDENT: 2cm" align="justify">Considerando o
			disposto no artigo 38 da Lei 8112/90, com reda��o dada pela Lei
			9527/97;</p>

			<p style="TEXT-INDENT: 2cm" align="justify">Considerando os
			termos do Provimento n&ordm; 40/94 do TRF 2&ordf; Regi�o, bem como da
			Resolu��o n&ordm; 307/2003 - CJF, publicada em 10/03/2003;</p>


			<p style="TEXT-INDENT: 2cm" align="justify">Considerando a
			indica��o formulada no(a) ${solicitacao},
			do(a) ${responsavel},</p>

			<p style="TEXT-INDENT: 2cm" align="justify"><b>RESOLVE:</b></p><!-- FIM ABERTURA -->

			<!-- INICIO CORPO --><p style="TEXT-INDENT: 2cm" align="justify"><b>DESIGNAR</b> o(a)
			servidor(a) <mod:identificacao
				pessoa="${requestScope['servidor_pessoaSel.id']}"
				nivelHierarquicoMaximoDaLotacao="4" obs="${servidorObs}" negrito="sim" /> para
			atuar como substituto(a) eventual do ${cargofc} em seus
			afastamentos, impedimentos legais ou regulamentares e na vac�ncia do
			cargo em comiss�o/fun��o comissionada<c:choose><c:when test="${(empty dataInicio) and (empty dataFim)}">.</c:when><c:when test="${dataInicio == dataFim || empty dataFim}">, a partir de ${dataInicio}.</c:when><c:otherwise>, no per�odo de ${dataInicio} a ${dataFim}.</c:otherwise></c:choose>
			</p>
			<c:if test="${not empty portrevogada}">
				<p style="TEXT-INDENT: 2cm" align="justify">Fica revogada a
				Portaria n&ordm; ${portrevogada}</p><!-- FIM CORPO -->
			</c:if>
		</mod:valor>
	</mod:documento>
</mod:modelo>

