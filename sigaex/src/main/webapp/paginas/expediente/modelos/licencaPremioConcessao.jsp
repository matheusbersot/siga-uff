<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
LICEN�A PR�MIO CONCESS�O -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:documento>		
	<mod:valor var="texto_requerimento">	
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria a <b> CONCESS�O DE LICEN�A PR�MIO</b>
		por assiduidade, referente(s) ao(s) q�inq��nio(s) a que faz 
		jus, de acordo com o art. 87 da Lei n.� 8.112/90, em sua 
		reda��o original.</p>
	</mod:valor>			
		
</mod:documento>
</mod:modelo>
