<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
LICEN�A PR�MIO FRUI��O -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		<mod:grupo titulo="DETALHES DO PER�ODO">
				<mod:selecao titulo="M�s/Meses a ser(em) usufru�do(s), na licen�a"
				var="mesFruicao" opcoes="1;2;3" reler="nao" />		
				<mod:data titulo="Data de Inicio da Frui��o" var="dataInicioFruicao" />
		</mod:grupo>
		
	</mod:entrevista>
	
	<mod:documento>
		<mod:valor var="texto_requerimento">	
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria a <b>FRUI��O DE 
		
		<c:if test="${mesFruicao =='1'}">	
			   1 (UM) M�S
		</c:if>
		
		<c:if test="${mesFruicao =='2'}">	
			   2 (DOIS) MESES
		</c:if>

		<c:if test="${mesFruicao =='3'}">	
			   3 (TR�S) MESES
		</c:if>
								
		DA LICEN�A-PR�MIO</b> por assiduidade a que faz jus, de acordo com o 
		art. 87 da Lei n.� 8.112/90, em sua reda��o original, 
		a partir de ${dataInicioFruicao}.
		<p>
		<p style="TEXT-INDENT: 2cm" align="justify">
			Declara, ainda, estar ciente de que o art. 86� da Resolu��o n.� 5/2008 
			do Conselho da Justi�a Federal prev� que <I>durante o per�odo de 
			licen�a ser� devida ao servidor <B>apenas a remunera��o do cargo efetivo</B>, 
			ainda que investido em fun��o gratificada ou em cargo comissionado</I>.
		</mod:valor>
		<mod:valor var="texto_requerimento4">
		<p style="TEXT-INDENT: 2cm" align="left">
		<b>De acordo.</b>
		</p>
		<p style="TEXT-INDENT: 2cm">               
        <b>_______________________________________________</b>
        </p>
        <p style="TEXT-INDENT: 3cm" align="left">
		<b>Local e Data</b>
		</p>
		</br>
		</br>
		<p style="TEXT-INDENT: 2cm" align="left">
		<b>____________________________________________________________</b>
		</p>
		<p style="TEXT-INDENT: 2cm" align="left">
		<b>Assinatura e Matr�cula do Superior Hier�rquico</b>
		</p>
		</mod:valor>	
	
</mod:documento>
</mod:modelo>
