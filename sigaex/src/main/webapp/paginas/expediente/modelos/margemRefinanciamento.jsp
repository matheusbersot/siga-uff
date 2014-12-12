<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>	
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
DECLARA��O DE MARGEM DE REFINANCIAMENRO-COMPRA DE D�VIDA -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="sepag" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		<mod:obrigatorios></mod:obrigatorios>
		<mod:grupo titulo="">
			<mod:texto obrigatorio="Sim" titulo="Institui��o Financeira" var="instituicaoFinanceiro"/>
			<mod:texto obrigatorio="Sim" titulo="Ag�ncia" var="agencia"/>
			<mod:memo colunas="80" linhas="5" 
				titulo="Observa��es" 
				var="obs" />			
		</mod:grupo>
				
	</mod:entrevista>
	<mod:documento>		
		<mod:valor var="texto_requerimento"><p style="TEXT-INDENT: 2cm">		
		<br>${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		${doc.subscritor.padraoReferenciaInvertido}, matr�cula ${doc.subscritor.sigla}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao },  
		vem requerer a Vossa Senhoria declara��o de margem para fins de refinanciamento / compra de d�vida na seguinte Institui��o Financeira: ${instituicaoFinanceiro}, ag�ncia ${agencia}.
		</p>
		<p style="TEXT-INDENT: 2cm">${obs}</p>
		</mod:valor>
	</mod:documento>
</mod:modelo>
