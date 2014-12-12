<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
REQUERIMENTO PARA AFASTAMENTO PARA CURSO DE FORMA��O -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>		
		<mod:grupo titulo="DETALHES SOBRE O CURSO DE FORMA��O">
		</mod:grupo>
		<mod:grupo></mod:grupo>
		<mod:texto titulo="Org�o Provedor do Cargo" var="orgao"/>
		<mod:grupo></mod:grupo>
		<mod:texto titulo="Cargo concorrido" var="cargoConcorrido"/>
		<mod:grupo></mod:grupo>
		<mod:data titulo="Data de in�cio" var="dataInicio"/>
		<mod:grupo>
		<mod:data titulo="Data de t�rmino" var="dataTermino"/>
		</mod:grupo>
		
		<mod:grupo titulo="DETALHES SOBRE VENCIMENTOS DESTA SE��O JUDICI�RIA">
		</mod:grupo>
	   <mod:grupo>
		   <mod:selecao titulo="O Funcionario <FONT COLOR=red><b>percebe</b></FONT> 
			   os vencimentos e vantagens referentes ao cargo efetivo desta Se��o 
			   Judici�ria?<br>
			   <FONT COLOR=blue><b>N�o fazendo jus ao aux�lio financeiro a ser pago 
			   por aquela Institui��o, bem como ao pagamento de <BR>aux�lio-transporte
			   e a remunera��o da fun��o comissionada ou do cargo em comiss�o que<BR>
			   eventualmente ocupe nesta Se��o Judici�ria.</FONT></b>"			
		   var="vencimentosCargo" opcoes="Percebe;N�o percebe" />
		</mod:grupo>	   
	</mod:entrevista>	
	<mod:documento>		 
		<mod:valor var="texto_requerimento"><p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		${doc.subscritor.padraoReferenciaInvertido},
		<c:if test="${not empty doc.subscritor.funcaoConfianca}">
		${doc.subscritor.funcaoConfianca.nomeFuncao},</c:if> lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, 
		 
		 
		vem requerer a Vossa Excel�ncia, nos termos do 
		� 4� do art. 20 da Lei n.� 8.112/90, introduzido pela  Lei n.� 
		9.527/97, c/c art. 14 da Lei n.� 9.624/98, e Resolu��o n.� 5/2008
		do Conselho da Justi�a Federal, <b>AFASTAMENTO PARA PARTICIPAR DE 
		CURSO DE FORMA��O</b>, correspondente � etapa do Processo Seletivo do  
		Concurso P�blico para o cargo de ${cargoConcorrido}
		a ser realizado pelo(a) ${orgao}, no per�odo de ${dataInicio} at� ${dataTermino}.
		</p>
		 
		<p style="TEXT-INDENT: 2cm" align="justify">
		Para tanto, faz a op��o de:
		</p>
		<c:if test="${vencimentosCargo == 'Percebe'}">
				<p style="TEXT-INDENT: 2cm" align="justify">	
			    <b>Perceber os vencimentos </b>e vantagens referentes 
			    ao cargo efetivo desta <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas},</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO,</c:otherwise></c:choose> <b>n�o 
			    fazendo jus </b>ao aux�lio financeiro a ser pago por 
			    aquela Institui��o, bem como ao pagamento
			    de <i>aux�lio-transporte</i> e a remunera��o da
			    <i>fun��o comissionada </i>ou do <i>cargo em comiss�o</i>
			    que eventualmente ocupe nesta <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO</c:otherwise></c:choose>.
			    </p>
		</c:if>
		<c:if test="${vencimentosCargo == 'N�o percebe'}">
			   <p style="TEXT-INDENT: 2cm" align="justify">	
			   <b>N�o Perceber os vencimentos</b> e vantagens referentes ao cargo
			   efetivo desta <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas},</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO,</c:otherwise></c:choose> <b>fazendo jus</b> ao aux�lio 
			   financeiro a ser pago por aquela Institui��o.
			   </p>
		</c:if>
		 

			<p style="TEXT-INDENT: 2cm" align="justify">
			Declara, ainda, estar ciente de que o afastamento 
			para participar de curso de forma��o ter� um <b>per�odo 
			definido</b>, que <b>coincidir� com a dura��o do supracitado 
			curso</b>, findo o qual <b>dever� retornar 
			ao exerc�cio do cargo</b> na <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO</c:otherwise></c:choose>. 
			</p> 
			
	</mod:valor>	
	
	<mod:valor var="texto_requerimento2">	
		<c:if test="${not empty doc.lotaDestinatario and f:lotacaoPorNivelMaximo(doc.lotaDestinatario,4).sigla == 'DIRFO'}">
				<h1 algin="center">Exmo(a). Sr(a). Juiz(a) Federal - Diretor(a) do(a) ${doc.lotaDestinatario.sigla}</h1>
		</c:if>
		<c:if test="${not empty doc.lotaDestinatario and f:lotacaoPorNivelMaximo(doc.lotaDestinatario,4).sigla == 'SG'}">
				<h1 algin="center">Ilmo(a). Sr(a). Diretor(a) da ${doc.lotaDestinatario.descricao}</h1>
		</c:if>
		<br><br><br><br><br><br>
		<center><c:import	url="/paginas/expediente/modelos/inc_tit_termoCompromisso.jsp" /></center>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 
		 ${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		 ${doc.subscritor.padraoReferenciaInvertido},<c:if test="${not empty doc.subscritor.funcaoConfianca}">
		 ${doc.subscritor.funcaoConfianca.nomeFuncao},</c:if>
		 lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, firma o seguinte compromisso:
		 </p>

 		 
		 <c:if test="${vencimentosCargo == 'Percebe'}">
				 <p style="TEXT-INDENT: 2cm" align="justify">
				 <b>
				 Apresentar, ao t�rmino do curso, documento emitido 
				 pelo �rg�o promotor do evento que n�o percebeu o referido aux�lio.
				 </b>
				 </p> 
		 </c:if>
		 
		<c:if test="${vencimentosCargo == 'N�o percebe'}">
				 <p style="TEXT-INDENT: 2cm" align="justify">
				 <b>
				 Apresentar comprovante de recolhimento de contribui��o
				 para a Previd�ncia Social do Servidor P�blico, objetivando
				 o c�mputo do tempo para fins de aposentadoria e disponibilidade.
				 </b>
				 </p>	 	
	 	</c:if>
	 	<p style="TEXT-INDENT: 2cm" align="justify">
	 	<b>Declara estar ciente de que tais documentos devem ser apresentados, impreterivelmente, at� o pedido de vac�ncia.</b>
	 	</p>
	 	
	 	<p style="TEXT-INDENT: 0cm" align="center">${doc.dtExtenso}</p>
	    <br/>
	 	<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		<%--<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />--%>	
	</mod:valor>
	
		</mod:documento>
	
</mod:modelo>
