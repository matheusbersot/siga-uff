<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>	
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
ABONO DE PERMANENCIA -->

<c:set var="esconderTexto" value="sim" scope="request" />
<>
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
	
		<mod:grupo titulo="DETALHES DO FUNCION�RIO">
			<mod:texto titulo="Ramal" var="ramal"/>
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>		
		<mod:valor var="texto_requerimento"><p style="TEXT-INDENT: 2cm" align="justify">		
		<br>${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		${doc.subscritor.padraoReferenciaInvertido}, matr�cula ${doc.subscritor.sigla}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao }, ramal ${ramal}, 
		vem requerer a Vossa Excel�ncia o <b>ABONO DE PERMAN�NCIA</b>, equivalente 
		ao valor da contribui��o previdenci�ria, em face do disposto na 
		Emenda Constitucional n.� 41, de 19 de dezembro de 2003.
		</p>
		
		</mod:valor>
	</mod:documento>
	
</mod:modelo>
