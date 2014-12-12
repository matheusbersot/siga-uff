<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%> 
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>		
		<mod:grupo>
			<mod:pessoa titulo="Titular do Benef�cio" var="titular" />
		</mod:grupo>
		<mod:grupo>
		<mod:selecao titulo="M�s" var="mes" 
			opcoes="Janeiro;Fevereiro;Mar�o;Abril;Maio;Junho;Julho;Agosto;Setembro;Outubro;Novembro;Dezembro"/>
		&nbsp;<b><mod:mensagem
				texto="O envio dos recibos (do titular e/ou dependentes) dever� ser feito, necessariamente,
				no mesmo formul�rio."
				vermelho="Nao"></mod:mensagem> </b>						
		</mod:grupo>	
		<mod:grupo>
			<mod:selecao titulo="Encaminhar recibo(s) de dependentes" 	var="dependentes"
			  opcoes="N�o;Sim"
			  reler="ajax" idAjax="dependentesAjax" />		
		</mod:grupo>
		<mod:grupo depende="dependentesAjax">			
			<c:if test="${dependentes == 'Sim'}">
				<b><mod:mensagem
						texto="Confira se o comprovante de pagamento cont�m os valores discriminados por dependente."
						vermelho="Nao"></mod:mensagem> </b>
				<mod:grupo>		
					<mod:selecao titulo="N�mero de dependentes"  var="numDependentes"
			  			opcoes="1;2;3;4;5;6;7;8;9;10"  reler="ajax" idAjax="numDepAjax" />
			  	</mod:grupo>	
			  	<mod:grupo depende="numDepAjax">	
			  		<c:forEach var="i" begin="1" end="${numDependentes}">
			  			<mod:grupo>
			  				<mod:texto titulo="Nome do Dependente" var="nomeDep${i}" maxcaracteres="50" largura="50"/>
			  			</mod:grupo>
			  		</c:forEach>
			  	</mod:grupo>			
			</c:if>			
		</mod:grupo>
		<b><mod:mensagem
				texto="Obs: Antes de finalizar o documento digitar o seguinte texto no campo Descri��o: 
				Aux�lio Sa�de + (m�s escolhido) + (nome e matr�cula do titular do benef�cio)"
				vermelho="Nao"></mod:mensagem> </b>	
		
	</mod:entrevista>

	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
@page {
	margin-left: 2cm;
	margin-right: 2cm;
	margin-top: 1cm;
	margin-bottom: 2cm;
}
</style>
		</head>
		<body>
		
		<table width="100%"  border="0" bgcolor="#FFFFFF">
	          <tr bgcolor="#FFFFFF">
		         <td align="left" valign="bottom" width="15%"><img src="contextpath/imagens/brasao2.png" width="65" height="65" /></td>
		         <td align="left" width="1%"></td>
		         <td width="37%">
		            <table align="left" width="100%">
			          <tr>
				          <td width="100%" align="left">
				          <p style="font-family: AvantGarde Bk BT, Arial; font-size: 11pt;">${f:resource('siga.ex.modelos.cabecalho.titulo')}</p>
				          </td>
			          </tr>
			          <c:if test="${not empty f:resource('siga.ex.modelos.cabecalho.subtitulo')}">
				          <tr>
					          <td width="100%" align="left">
					          <p style="font-family: Arial; font-size: 10pt; font-weight: bold;">${f:resource('siga.ex.modelos.cabecalho.subtitulo')}</p>
					          </td>
				          </tr>
			          </c:if>
			          <tr>
			             <td width="100%" align="left">
				         <p style="font-family: AvantGarde Bk BT, Arial; font-size: 8pt;">
				         <c:choose>
					     <c:when test="${empty mov}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when>
					     <c:otherwise>${mov.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:otherwise>
				         </c:choose></p>
				         </td>
			          </tr>
		            </table>
		         </td>		         		           
		         <td width="57%" align="center">		         		  
		         	<p align="right" style=" font: bold; font-size: 10pt">		         	
		          	<b>ENCAMINHAMENTO MENSAL DE RECIBO PARA <br> CR�DITO DO AUX�LIO-SA�DE</b></p>		          		          	 	
		         </td>         		
	          </tr>
           </table>
		

		
		&nbsp;<br/> <%-- Solu��o by Edson --%>
		<br/><br/>
		<b>Titular do Benef�cio:</b>  ${requestScope['titular_pessoaSel.descricao']}<br/>
		<b>Matr�cula:</b>  ${f:pessoa(requestScope['titular_pessoaSel.id']).matricula} <br/>
		<b>M�s de compet�ncia:</b>&nbsp;${mes} 
				
		<c:if test="${dependentes == 'Sim'}">
			<table width="80%"  border="0" cellspacing="0" align="left">				
					<c:forEach var="i" begin="1" end="${numDependentes}">
						<tr>
							<ww:if test="${i == 1}">
								<td width="17"><b>Dependentes:</b></td>
								<td width="63" align="left"> ${requestScope[f:concat('nomeDep',i)]}</td>
							</ww:if>							
							<ww:else>
								<td width="17"></td>
								<td width="63" align="left"> ${requestScope[f:concat('nomeDep',i)]}</td>
							</ww:else>	
						</tr>				
					</c:forEach>				
			</table>			
		</c:if>		
		<br/><br><br/><br>
		Encaminho, em anexo, o(s) recibo(s) de pagamento referente(s) ao plano de sa�de 
		com o objetivo de assegurar a regular percep��o do benef�cio Aux�lio-Sa�de para o Titular e/ou 
		para o(s) dependente(s).
		<br><br/><br><br/><br>
		
		
		Atenciosamente,    
		
	  
		<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" />
		



		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
		FIM RODAPE -->

		</body>
		</html>
	</mod:documento>
</mod:modelo>
