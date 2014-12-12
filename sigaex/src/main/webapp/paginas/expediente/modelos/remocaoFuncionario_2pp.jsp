<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
	
		<mod:grupo titulo="DETALHES DA REMO&Ccedil;&Atilde;O">
				<mod:texto titulo="Remo��o para" var="remocao" largura="70" />
				<br/>
				<span><b>(�rg�os: CJF; TRF2R; SJES. TRF1R; TRF3R; TRF4R; TRF5R e respectivas se��es judici�rias)</b></span>
				<mod:memo colunas="60" linhas="3"  titulo="Motivo" var="motivo"/>
		</mod:grupo>
				
	</mod:entrevista>
		
	<mod:documento>
	<c:if test="${not empty remocao}">
		<c:set var="remocaoPara" value=" para o(a)  ${remocao}" />
	</c:if>
	<mod:valor var="texto_requerimento">
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia que se digne 
		encaminhar o requerimento de <b>remo��o</b>, em anexo, ao E. Tribunal Regional Federal da 2� Regi�o.
	    </p>
	  </mod:valor>  		
		<mod:valor var="texto_requerimento2">
		<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegi.jsp" />

		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia, nos termos do 
		art. 36 da Lei n.� 8.112/90, combinado com a reda��o dada pela Lei
		n.� 9.527/97, <b>remo��o</b>${remocaoPara}, pelos 
		motivos a seguir expostos:
		</p>
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		${motivo}
		</p>
		
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
		<br>
		<br>
		<p align="center">${doc.dtExtenso}</p>			
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp"/>
	</mod:valor>
	
</mod:documento>
</mod:modelo>
