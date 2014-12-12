<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
	
		<%--<mod:grupo titulo="DETALHES DO FUNCION�RIO">
				<mod:texto titulo="Classe" var="classe"/>
				<mod:texto titulo="Padr�o" var="padrao" />
		</mod:grupo>--%>
		
		<mod:grupo titulo="DETALHES DA REDISTRIBUI��O">
				<FONT COLOR="BLUE"><B>
				<mod:memo colunas="60" linhas="4"  titulo="Motivo" var="motivo"/>
				</FONT></B>
		</mod:grupo>
				
	</mod:entrevista>
		
	<mod:documento>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head></head>
	<body>
		
		<c:import url="/paginas/expediente/modelos/inc_tit_juizfedDirForo.jsp" />
		
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		classe ${doc.subscritor.padraoReferenciaInvertido}, 
		lotado(a) no(a) ${doc.subscritor.lotacao.descricao},
	    vem requerer a Vossa Excel�ncia, que se digne encaminhar 
	    o requerimento de <b>REDISTRIBUI��O</b>, em anexo, ao E. Tribunal Regional 
	    Federal da 2� Regi�o.
	    </p>
	    
	    
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
				
		<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
	
		<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegi.jsp" />


		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		classe ${doc.subscritor.padraoReferenciaInvertido}, 
		lotado(a) no(a) ${doc.subscritor.lotacao.descricao},
		vem requerer a Vossa Excel�ncia, nos termos do art. 37 da Lei n.� 8.112/90, 
		c/c a reda��o dada pela Lei n.� 9.527/97, <B>REDISTRIBUI��O</B>, 
		pelos motivos expostos a seguir:
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		<i>${motivo}</i>
		</p>
		
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
					
		<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
			

	</body>
	</html>
</mod:documento>
</mod:modelo>
