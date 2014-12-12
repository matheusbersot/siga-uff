<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
REQUERIMENTO PARA AVERBA��O DE TEMPO DE SERVI�O -->



<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:documento>
		<mod:valor var="texto_requerimento">	
			<p style="TEXT-INDENT: 2cm" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, 
			lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria <B>AVERBA��O DE TEMPO DE 
			SERVI�O/CONTRIBUI��O</B>, conforme certid�o em anexo.
			</p>
		</mod:valor>	
</mod:documento>
</mod:modelo>
