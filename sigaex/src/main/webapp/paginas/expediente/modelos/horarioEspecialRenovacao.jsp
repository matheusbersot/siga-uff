<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
CONCESS�O DE HORARIO ESPECIAL AO SERVIDOR PUBLICO ESTUDANTE 
- RENOVA��O -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		
		<font color="blue"><b>
		<mod:grupo titulo="DETALHES DO HOR�RIO"></mod:grupo>
		</font></b>	
		<mod:selecao titulo="Quais altera��es far�?"
				var="opcaoHorario" opcoes="manuten��o do hor�rio anterior
				;altera��o do hor�rio anterior para" reler="sim" />
			
				
		<c:if test="${opcaoHorario == 'altera��o do hor�rio anterior para'}">
					<mod:memo colunas="65" linhas="2" 
					titulo="DETALHES DA PROPOSTA DE HORARIO" var="ComentarAlteracaoHorario"/>
        </c:if>
        					        
        
	</mod:entrevista>	
	<mod:documento>
	<mod:valor var="texto_requerimento">
				
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, 
		 lotado(a) no(a)${doc.subscritor.lotacao.descricao},
	
		vem requerer a Vossa Senhoria, <B> RENOVA��O DO HOR�RIO ESPECIAL AO SERVIDOR 
		ESTUDANTE</B>, apresentando, para tanto, declara��o de freq��ncia regular no 
		per�odo anterior, expedida pela Institui��o de Ensino, em atendimento ao 
		disposto nos art. 8�, I, e 9� da Resolu��o n.� 5/2008, do Conselho 
		da Justi�a Federal.
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		Outrossim, conforme documenta��o comprobat�ria de matr�cula atual e do 
		hor�rio das respectivas aulas, encaminhada atrav�s do titular da Unidade, 
		solicita a 
		<c:choose>
	    <c:when test="${opcaoHorario == 'altera��o do hor�rio anterior para'}">	
			${opcaoHorario} ${ComentarAlteracaoHorario}.
        </c:when>
        <c:otherwise>
        	${opcaoHorario}.
        </c:otherwise>
        </c:choose>
        </p><br>
        </mod:valor>
        <mod:valor var="texto_requerimento4">
			<p align="center">
			De acordo.
			</p>   
			<p align="center">
			____________________________________________________________
			</p>
			<p align="center">
			Assinatura e Matr�cula do Superior Hier�rquico
			</p>
		</mod:valor>	

	
</mod:documento>
</mod:modelo>
