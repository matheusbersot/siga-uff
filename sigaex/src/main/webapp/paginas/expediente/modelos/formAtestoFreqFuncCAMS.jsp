<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>			
		<p><b>Quanto ao profissional e aos servi�os prestados:</b></p>
		<mod:grupo titulo="Os funcion�rios est�o devidamente identificados (com crach�)? ">
			<mod:radio titulo="Sim." var="comIdentif" valor="1" marcado="Sim"
							reler="ajax" idAjax="comIdentifAjax" />
		
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="comIdentif" valor="2" reler="ajax"
					idAjax="comIdentifAjax" />
			</mod:grupo>
			<c:set var="comIdentifVal" value="${comIdentif}" />
			<c:if test="${empty comIdentifVal}">
				<c:set var="comIdentifVal" value="${param['comIdentif']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="comIdentifAjax">
					<c:if test="${comIdentifVal == '2'}">
						<mod:memo titulo="Observa��es" var="obsComIdentif" linhas="3"
							colunas="60" obrigatorio="Sim" />
						<mod:oculto var="comIdentifNao" valor="n�o"/>		
					</c:if>					
				</mod:grupo>
			</mod:grupo>			
		</mod:grupo>
		<mod:grupo titulo="O profissional costuma atrasar o in�cio das aulas?">	
			<mod:radio titulo="N�o." var="atraso" valor="1" marcado="Sim"
						reler="ajax" idAjax="atrasoAjax" />	
			<mod:grupo largura="7">
				<mod:radio titulo="Sim." var="atraso" valor="2" reler="ajax"
					idAjax="atrasoAjax" />
			</mod:grupo>
			<c:set var="atrasoVal" value="${atraso}" />
			<c:if test="${empty atrasoVal}">
				<c:set var="atrasoVal" value="${param['atraso']}" />
			</c:if>
			<mod:grupo largura="73">
				<mod:grupo depende="atrasoAjax">
					<ww:if test="${atrasoVal == '2'}">
						<mod:grupo largura="3">
							Com que frequ�ncia?
						</mod:grupo>
						<mod:grupo largura="18">						
								<mod:radio titulo="Sempre." var="frequencia" valor="1" marcado="Sim"/>							
								<mod:radio titulo="Em cerca de 50% das aulas." var="frequencia" valor="2"/>								
								<mod:radio titulo="Em menos de 50% das aulas." var="frequencia" valor="3"/>																				
						</mod:grupo>						
					</ww:if>						
					<ww:else>
						<mod:grupo largura="20">
							<%-- acertar o mod grupo --%>							
						</mod:grupo>
						<mod:oculto var="atrasoNao" valor="n�o"/>		
					</ww:else>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo> 
		<mod:grupo titulo="O profissional respeita o tempo de dura��o das aulas (15 minutos)?">
			<mod:radio titulo="Sim." var="duracao" valor="1" marcado="Sim" reler="ajax" idAjax="duracaoAjax" />
			<mod:radio titulo="N�o." var="duracao" valor="2" reler="ajax" idAjax="duracaoAjax" />			
			<mod:radio titulo="�s vezes." var="duracao" valor="3" reler="ajax" idAjax="duracaoAjax" />				
			<c:set var="duracaoVal" value="${duracao}" />				
			<c:if test="${empty duracaoVal}">
				<c:set var="duracaoVal" value="${param['duracao']}" />	
			</c:if>			
			<mod:grupo depende="duracaoAjax"> 
				<c:if test="${duracaoVal == '2' or duracaoVal == '3' }"> 
					<mod:memo titulo="Observa��es" var="obsDuracao" linhas="2"
						colunas="60" obrigatorio="Sim" />					
					<ww:if test="${duracaoVal == '2'}" >
						<mod:oculto var="duracaoNao" valor="n�o" />	
					</ww:if>
					<ww:else>
						<mod:oculto var="duracaoNao" valor=", �s vezes," />	
					</ww:else>
				</c:if>				
			</mod:grupo>  
			
		</mod:grupo>
		<mod:grupo titulo="O profissional deu esclarecimentos sobre os objetivos de cada exerc�cio durante as aulas?  ">			
			<mod:radio titulo="Sim." var="esclarecimento" valor="1" marcado="Sim" />		
			<mod:radio titulo="N�o." var="esclarecimento" valor="2" />				
			<mod:radio titulo="�s vezes, quando perguntado." var="esclarecimento" valor="3" />				
		</mod:grupo>
		<mod:grupo titulo="O profissional costuma dar orienta��o quanto ao carregamento de pesos e �s posturas adotadas 
					no ambiente de trabalho?" >		
			<mod:radio titulo="Sim." var="orientacao" valor="1" marcado="Sim" />		
			<mod:radio titulo="N�o." var="orientacao" valor="2" />			
			<mod:radio titulo="Eventualmente." var="orientacao" valor="3" />	
			<mod:radio titulo="S� quando perguntado." var="orientacao" valor="4" />			
		</mod:grupo>	
		<hr color="#FFFFFF" />		
		<p><b>Quanto aos materiais/equipamentos utilizados:</b></p>
		<mod:grupo titulo="O profissional utiliza m�sica para acompanhar as aulas?">			
			<mod:radio titulo="Sempre." var="musica" valor="1" marcado="Sim" />		
			<mod:radio titulo="Frequentemente." var="musica" valor="2" />		
			<mod:radio titulo="Quase nunca." var="musica" valor="3" />		
			<mod:radio titulo="Nunca." var="musica" valor="4" />
		</mod:grupo>		
		<mod:grupo titulo="O profissional utiliza materiais acess�rios como bolas, el�sticos, mini-bast�es, 
					dentre outros, na realiza��o dos exerc�cios?">			
			<mod:radio titulo="Sempre." var="acessorios" valor="1" marcado="Sim" />		
			<mod:radio titulo="Frequentemente." var="acessorios" valor="2" />			
			<mod:radio titulo="Quase nunca." var="acessorios" valor="3" />		
			<mod:radio titulo="Nunca." var="acessorios" valor="4" />		
		</mod:grupo>	
		<mod:grupo>
			<mod:memo
				titulo="Relate outras ocorr�ncias que considere relevante para a fiscaliza��o
						dos servi�os prestados" var="ocorrencias" linhas="2" colunas="80" />
		</mod:grupo>		
		<mod:grupo titulo="FREQU�NCIA DE FUNCION�RIOS">
			<mod:selecao titulo="�ndice de Freq��ncia" var="freqFunc" opcoes="Integral;Parcial" reler="ajax" idAjax="freqFuncAjax" />			
			<mod:grupo depende="freqFuncAjax">
				<c:if test="${freqFunc eq 'Parcial'}">
					<mod:grupo titulo="A empresa avisa, em tempo, quando h� aus�ncias ou substitui��es de profissionais
			 			ou reposi��o de aulas?" >					
						<mod:radio titulo="Sempre." var="aviso" valor="1" marcado="Sim" />				
						<mod:radio titulo="Frequentemente." var="aviso" valor="2" />				
						<mod:radio titulo="Quase nunca." var="aviso" valor="3" />	
						<mod:radio titulo="Nunca." var="aviso" valor="4" />				
					</mod:grupo>					
					<mod:grupo>
						<mod:numero titulo="N� de faltas sem reposi��o" var="numFaltas"
							largura="10" />
					</mod:grupo>
					<mod:grupo>
						<mod:numero
							titulo="Quantidade de minutos em atrasos sem reposi��o"
							var="quantMinutos" largura="10" />
					</mod:grupo>
					<mod:grupo>
						<mod:memo titulo="Ressalvas" var="ressalvaFreq" linhas="2"
							colunas="80" />
					</mod:grupo>
				</c:if>
			</mod:grupo>
		</mod:grupo>	
	</mod:entrevista>
	<mod:documento>	
		<c:choose>
			<c:when test="${frequencia == '1'}">
				<mod:oculto var="freqAtraso" valor="sempre"/>		
			</c:when>
			<c:when test="${frequencia == '2'}">
				<mod:oculto var="freqAtraso" valor="em cerca de 50% das aulas"/>		
			</c:when>
			<c:when test="${frequencia == '3'}">
				<mod:oculto var="freqAtraso" valor="em menos de 50% das aulas"/>		
			</c:when>						
		</c:choose>										
		<c:choose>
				<c:when test="${esclarecimento == '2'}">
					<mod:oculto var="esclarecimentoNao" valor="n�o" />	
				</c:when>
				<c:when test="${esclarecimento == '3'}">
					<mod:oculto var="esclarecimentoNao" valor=", �s vezes quando perguntado," />	
				</c:when>
		</c:choose>			
		<c:choose>
			<c:when test="${orientacao == '2'}">					
				<mod:oculto var="orientacaoNao" valor="n�o" />	
			</c:when>
			<c:when test="${orientacao == '3'}">					
				<mod:oculto var="orientacaoNao" valor="eventualmente" />	
			</c:when>
			<c:when test="${orientacao == '4'}">				
				<mod:oculto var="orientacaoNao" valor=", s� quando perguntado," />	
			</c:when>
		</c:choose>		
		<c:choose>
			<c:when test="${musica == '1'}">					
				<mod:oculto var="musicaNao" valor="sempre" />	
			</c:when>
			<c:when test="${musica == '2'}">					
				<mod:oculto var="musicaNao" valor="frequentemente" />	
			</c:when>
			<c:when test="${musica == '3'}">					
				<mod:oculto var="musicaNao" valor="quase nunca" />	
			</c:when>
			<c:when test="${musica == '4'}">				
				<mod:oculto var="musicaNao" valor="nunca" />	
			</c:when>
		</c:choose>	
		<c:choose>
			<c:when test="${acessorios == '1'}">					
				<mod:oculto var="acessoriosNao" valor="sempre" />	
			</c:when>
			<c:when test="${acessorios == '2'}">					
				<mod:oculto var="acessoriosNao" valor="frequentemente" />	
			</c:when>
			<c:when test="${acessorios == '3'}">					
				<mod:oculto var="acessoriosNao" valor="quase nunca" />	
			</c:when>
			<c:when test="${acessorios == '4'}">				
				<mod:oculto var="acessoriosNao" valor="nunca" />	
			</c:when>
		</c:choose>	
		<c:choose>
			<c:when test="${aviso == '1'}">					
				<mod:oculto var="avisoNao" valor="sempre" />	
			</c:when>
			<c:when test="${aviso == '2'}">					
				<mod:oculto var="avisoNao" valor="frequentemente" />	
			</c:when>
			<c:when test="${aviso == '3'}">					
				<mod:oculto var="avisoNao" valor="quase nunca" />	
			</c:when>
			<c:when test="${aviso == '4'}">				
				<mod:oculto var="avisoNao" valor="nunca" />	
			</c:when>
		</c:choose>	
		<ww:if test="${freqFunc eq 'Integral'}">
			<mod:oculto var="freqFuncTipo" valor="integral" />	
		</ww:if>
		<ww:else>
			<mod:oculto var="freqFuncTipo" valor="parcial" />	
		</ww:else>
						
		<table style="float:none; clear:both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
			<tr>
				<th><b>Informa��es referentes ao profissional e aos servi�os prestados: </b></th>
			</tr>
			<tr><td>Os funcion�rios ${comIdentifNao} est�o devidamente identificados (com crach�).
				<c:if test="${comIdentif == '2'}">
					<br> obs: ${obsComIdentif}					
				</c:if>
			</td></tr>	
			<tr><td>O profissional ${atrasoNao} costuma atrasar o in�cio das aulas ${freqAtraso}.</td></tr>
			<tr><td>O profissional ${duracaoNao} respeita o tempo de dura��o das aulas (15 minutos).
				<c:if test="${duracao == '2' or duracao == '3' }">
					<br> obs: ${obsDuracao}.
				</c:if>
			</td></tr>
			<tr><td>O profissional ${esclarecimentoNao} deu esclarecimentos sobre os objetivos de cada exerc�cio durante as aulas.</td></tr>
			<tr><td>O profissional ${orientacaoNao} costuma dar orienta��o quanto ao carregamento de pesos e �s posturas adotadas no ambiente de trabalho.</td></tr>			
		</table>
		<br>
		<table style="float:none; clear:both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
			<tr>
				<th><b>Informa��es referentes aos materiais/equipamentos utilizados: </b></th>
			</tr>
			<tr><td>O profissional ${musicaNao} utiliza m�sica para acompanhar as aulas.</td></tr>
			<tr><td>O profissional ${acessoriosNao} utiliza materiais acess�rios como bolas, el�sticos, mini-bast�es, 
					dentre outros, na realiza��o dos exerc�cios.</td></tr>
		</table>						
		<c:if test="${not empty ocorrencias}">
			<span>Ocorr�ncias relevantes para a fiscaliza��o dos servi�os prestados: ${ocorrencias}</span>
		</c:if>	
		
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		
		<table style="float:none; clear:both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
			<tr>
				<th><b>Informa��es referentes � frequ�ncia de funcion�rios: </b></th>
			</tr>			
			<tr>
				<td>Informo que o(s) funcion�rio(s) tiveram frequ�ncia ${freqFuncTipo} durante o per�odo.</td>
			</tr>
			<c:if test="${freqFunc eq 'Parcial'}">		
				<tr>
					<td>A empresa ${avisoNao} avisa, em tempo, quando h� aus�ncias ou substitui��es de 
						profissionais ou reposi��o de aulas.</td>
				</tr>
				<tr>
					<ww:if test="${not empty numFaltas and numFaltas != '0'}">					
						<td>N�mero de faltas sem reposi��o: ${numFaltas} </td>					
					</ww:if>
					<ww:else>
						<td>N�o houve faltas sem reposi��o.</td>
					</ww:else>
				</tr>
				<tr>
					<ww:if test="${not empty quantMinutos and quantMinutos != '0'}">					
						<td>Quantidade de minutos em atrasos sem reposi��o: ${quantMinutos} </td>					
					</ww:if>
					<ww:else>
						<td>N�o houve minutos em atrasos sem reposi��o.</td>
					</ww:else>
				</tr>
				<c:if test="${not empty ressalvaFreq}">
					<tr>
						<td>Ressalvas: ${ressalvaFreq} </td>
					</tr>
				</c:if>
			</c:if>
		</table>	
		</body>
		</html>
	</mod:documento>
</mod:modelo>
