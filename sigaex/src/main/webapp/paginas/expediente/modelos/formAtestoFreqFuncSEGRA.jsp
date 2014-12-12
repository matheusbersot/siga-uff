<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>			
		<p><b>Quanto aos suprimentos (exceto papel):</b></p>
		<mod:grupo titulo="1. A entrega foi realizada no prazo?">		
			<mod:radio titulo="Sim." var="entrNoPrazo" valor="1" marcado="Sim"
						reler="ajax" idAjax="entrNoPrazoAjax" />	
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="entrNoPrazo" valor="2" reler="ajax"
					idAjax="entrNoPrazoAjax" />
			</mod:grupo>
			<c:set var="entrNoPrazoVal" value="${entrNoPrazo}" />
			<c:if test="${empty entrNoPrazoVal}">
				<c:set var="entrNoPrazoVal" value="${param['entrNoPrazo']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="entrNoPrazoAjax">
					<c:if test="${entrNoPrazoVal == '2'}">
						<mod:texto titulo="Ressalvas" var="ressalvaEntrNoPrazo" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />
						<mod:oculto var="entrNoPrazoNao" valor="n�o"/>								
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>		
		<mod:grupo titulo="2. As quantidades solicitadas foram entregues?">
			<mod:radio titulo="Sim." var="entrQuant"  valor="1" marcado="Sim"
						reler="ajax" idAjax="entrQuantAjax" />	
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="entrQuant" valor="2" reler="ajax"
					idAjax="entrQuantAjax" />
			</mod:grupo>
			<c:set var="entrQuantVal" value="${entrQuant}" />
			<c:if test="${empty entrQuantVal}">
				<c:set var="entrQuantVal" value="${param['entrQuant']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="entrQuantAjax">
					<c:if test="${entrQuantVal == '2'}">
						<mod:texto titulo="Ressalvas" var="ressalvaEntrQuant" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />
						<mod:oculto var="entrQuantNao" valor="n�o"/>			
					</c:if>
				</mod:grupo>
			</mod:grupo>	
		</mod:grupo>
		<mod:grupo titulo="3. Como avalia a qualidade?">
			<mod:radio titulo="Satisfat�ria." var="qualidSuprim"  valor="1" marcado="Sim"
						reler="ajax" idAjax="qualidSuprimAjax" />	
			<mod:radio titulo="Regular." var="qualidSuprim" valor="2" reler="ajax"
					   idAjax="qualidSuprimAjax" />
		    <mod:radio titulo="Insatisfat�ria." var="qualidSuprim" valor="3" reler="ajax"
						idAjax="qualidSuprimAjax" />
			<c:set var="qualidSuprimVal" value="${qualidSuprim}" />
			<c:if test="${empty qualidSuprimVal}">
				<c:set var="qualidSuprimVal" value="${param['qualidSuprim']}" />
			</c:if>		
			<mod:grupo depende="qualidSuprimAjax">
				<c:if test="${qualidSuprimVal == '2' or qualidSuprimVal == '3'}">
					<mod:texto titulo="Justificar" var="jusQualidSuprim" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />					
				</c:if>
			</mod:grupo>			
		</mod:grupo>
		<mod:grupo titulo="4. Os equipamentos est�o em boas condi��es?">
			<mod:radio titulo="Sim." var="boaCondEquip" valor="1" marcado="Sim"
						reler="ajax" idAjax="boaCondEquipAjax" />
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="boaCondEquip" valor="2" reler="ajax"
					idAjax="boaCondEquipAjax" />
			</mod:grupo>
			<c:set var="boaCondEquipVal" value="${boaCondEquip}" />
			<c:if test="${empty boaCondEquipVal}">
				<c:set var="boaCondEquipVal" value="${param['boaCondEquip']}" />
			</c:if>
			<mod:grupo largura="73">
				<mod:grupo depende="boaCondEquipAjax">  
					<ww:if test="${boaCondEquipVal == '2'}">
						<mod:oculto var="boaCondEquipNao" valor="n�o" />
						<mod:grupo largura="3">
							A substitui��o foi solicitada? 
								<mod:radio titulo="Sim." var="substitEquip" valor="1" marcado="Sim"
											reler="ajax" idAjax="substitEquipAjax" />
								<mod:radio titulo="N�o." var="substitEquip" valor="2" 
											reler="ajax" idAjax="substitEquipAjax" />
						</mod:grupo>					
						<c:set var="substitEquipVal" value="${substitEquip}" />
						<c:if test="${empty substitEquipVal}">
							<c:set var="substitEquipVal" value="${param['substitEquip']}" />
						</c:if>
						<mod:grupo largura="17">
							<mod:grupo depende="substitEquipAjax">	
								<c:if test="${substitEquipVal == '2'}">
									<br> <br> 
									<mod:texto titulo="Ressalvas" var="ressalvaSubstitEquip" largura="60"
										maxcaracteres="60" obrigatorio="Sim" />
									<mod:oculto var="substitEquipNao" valor="n�o" />	
								</c:if>									
							</mod:grupo>												
						</mod:grupo>														
					</ww:if>
					<ww:else>
						<mod:grupo largura="20"><%-- para acertar mod grupo --%></mod:grupo>
					</ww:else>
				</mod:grupo>
			</mod:grupo> 
		</mod:grupo>	
		<mod:grupo>
			<mod:numero titulo="5. Quantas manuten��es (preventivas e corretivas) foram feitas nos equipamentos?"
						 var="numManutencoes" largura="5" maxcaracteres="5"  />
		</mod:grupo>
		<mod:grupo titulo="6. Como avalia a quantidade dos equipamentos?">
			<mod:radio titulo="Satisfat�ria." var="quantEquip"  valor="1" marcado="Sim"
						reler="ajax" idAjax="quantEquipAjax" />	
			<mod:radio titulo="Regular." var="quantEquip" valor="2" reler="ajax"
					idAjax="quantEquipAjax" />
			<mod:radio titulo="Insatisfat�ria." var="quantEquip" valor="3" reler="ajax"
					idAjax="quantEquipAjax" />		
			<c:set var="quantEquipVal" value="${quantEquip}" />
			<c:if test="${empty quantEquipVal}">
				<c:set var="quantEquipVal" value="${param['quantEquip']}" />
			</c:if>
			<mod:grupo depende="quantEquipAjax">
				<c:if test="${quantEquipVal == '2' or quantEquipVal == '3' }">				
					<mod:texto titulo="Justificar" var="jusQuantEquip" largura="60"
						maxcaracteres="60" obrigatorio="Sim" />
			 	 </c:if>
			</mod:grupo>			
		</mod:grupo>	
		<mod:grupo titulo="7. O total de imagens digitalizadas ultrapassou a franquia? ">	
			<mod:radio titulo="N�o." var="totImag" valor="1" marcado="Sim"
						reler="ajax" idAjax="totImagAjax" />		
			<mod:grupo largura="7">
				<mod:radio titulo="Sim." var="totImag" valor="2" reler="ajax"
					idAjax="totImagAjax" />
			</mod:grupo>
			<c:set var="totImagVal" value="${totImag}" />
			<c:if test="${empty totImagVal}">
				<c:set var="totImagVal" value="${param['totImag']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="totImagAjax">
					<ww:if test="${totImagVal == '2'}">
						<mod:texto titulo="Ressalvas" var="ressalvaTotImag" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />						
					</ww:if>						
					<ww:else>
						<mod:oculto var="totImagNao" valor="n�o"/>	
					</ww:else>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>
		<mod:grupo titulo="8. Os valores do vale alimenta��o foram compat�veis com os dias trabalhados?">	
			<mod:radio titulo="Sim." var="valeAlim" valor="1" marcado="Sim" reler="ajax" idAjax="valeAlimAjax" />		
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="valeAlim" valor="2" reler="ajax" idAjax="valeAlimAjax" />
			</mod:grupo>
			<c:set var="valeAlimVal" value="${valeAlim}" />
			<c:if test="${empty valeAlimVal}">
				<c:set var="valeAlimVal" value="${param['valeAlim']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="valeAlimAjax">
					<c:if test="${valeAlimVal == '2'}">
						<mod:texto titulo="Ressalvas" var="ressalvaValeAlim" largura="60" maxcaracteres="60" obrigatorio="Sim" />
						<mod:oculto var="valeAlimNao" valor="n�o"/>	
					</c:if>
				</mod:grupo>
			</mod:grupo>
			<mod:radio titulo="N�o se aplica (c�pias encaminhada diretamente para a sede)." var="valeAlim" valor="3" 
						reler="ajax" idAjax="valeAlimAjax" /> 	
		</mod:grupo>
		<mod:grupo titulo="9. Os valores do vale transporte foram compat�veis com os dias trabalhados?">	
			<mod:radio titulo="Sim." var="valeTransp" valor="1" marcado="Sim"
						reler="ajax" idAjax="valeTranspAjax" />		
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="valeTransp" valor="2" reler="ajax"
					idAjax="valeTranspAjax" />
			</mod:grupo>
			<c:set var="valeTranspVal" value="${valeTransp}" />
			<c:if test="${empty valeTranspVal}">
				<c:set var="valeTranspVal" value="${param['valeTransp']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="valeTranspAjax">
					<c:if test="${valeTranspVal == '2'}">
						<mod:texto titulo="Ressalvas" var="ressalvaValeTransp" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />
						<mod:oculto var="valeTranspNao" valor="n�o"/>		
					</c:if>
				</mod:grupo>
			</mod:grupo>
			<mod:radio titulo="N�o se aplica (c�pias encaminhada diretamente para a sede)." var="valeTransp" valor="3" 
						reler="ajax" idAjax="valeTranspAjax" />		
		</mod:grupo>
		<mod:grupo titulo="10. Os uniformes est�o em boas condi��es?">
			<mod:radio titulo="Sim." var="boaCondUnif" valor="1" marcado="Sim"
						reler="ajax" idAjax="boaCondUnifAjax" />
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="boaCondUnif" valor="2" reler="ajax"
					idAjax="boaCondUnifAjax" />
			</mod:grupo>
			<c:set var="boaCondUnifVal" value="${boaCondUnif}" />
			<c:if test="${empty boaCondUnifVal}">
				<c:set var="boaCondUnifVal" value="${param['boaCondUnif']}" />
			</c:if>
			<mod:grupo largura="73">
				<mod:grupo depende="boaCondUnifAjax">  
					<ww:if test="${boaCondUnifVal == '2'}">
						<mod:oculto var="boaCondUnifNao" valor="n�o" />
						<mod:grupo largura="3">
							A substitui��o foi solicitada? 
								<mod:radio titulo="Sim." var="substitUnif" valor="1" marcado="Sim"
											reler="ajax" idAjax="substitUnifAjax" />
								<mod:radio titulo="N�o." var="substitUnif" valor="2" 
											reler="ajax" idAjax="substitUnifAjax" />
						</mod:grupo>					
							<c:set var="substitUnifVal" value="${substitUnif}" />
							<c:if test="${empty substitUnifVal}">
								<c:set var="substitUnifVal" value="${param['substitUnif']}" />
							</c:if>
						<mod:grupo largura="17">
							<mod:grupo depende="substitUnifAjax">	
								<c:if test="${substitUnifVal == '2'}">
									<br> <br>
									<mod:texto titulo="Ressalvas" var="ressalvaSubstitUnif" largura="60"
										maxcaracteres="60" obrigatorio="Sim" />
									<mod:oculto var="substitUnifNao" valor="n�o" />		
								</c:if>
							</mod:grupo>												
						</mod:grupo>												
					</ww:if>
					<ww:else>
						<mod:grupo largura="20"><%-- acertar o mod grupo --%></mod:grupo>
					</ww:else>
				</mod:grupo>
			</mod:grupo> 
		</mod:grupo>	
		<mod:grupo titulo="11. Os contracheques apresentaram diverg�ncias ou irregularidades?">	
			<mod:radio titulo="Sim." var="irregContCheq" valor="1" marcado="Sim"
						reler="ajax" idAjax="irregContCheqAjax" />		
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="irregContCheq" valor="2" reler="ajax"
					idAjax="irregContCheqAjax" />
			</mod:grupo>
			<c:set var="irregContCheqVal" value="${irregContCheq}" />
			<c:if test="${empty irregContCheqVal}">
				<c:set var="irregContCheqVal" value="${param['irregContCheq']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="irregContCheqAjax">
					<c:if test="${irregContCheqVal == '2'}">
						<mod:texto titulo="Ressalvas" var="ressalvaIrregContCheq" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />
					</c:if>
				</mod:grupo>
			</mod:grupo>
			<mod:radio titulo="N�o se aplica (c�pias encaminhada diretamente para a sede)." var="irregContCheq" valor="1" 
						reler="ajax" idAjax="irregContCheqAjax" />		
		</mod:grupo>
		<mod:grupo titulo="12. Os funcion�rios prestaram os servi�os em conformidade com a especifica��o?">		
			<mod:radio titulo="Sim." var="confEspecif" valor="1" marcado="Sim"
						reler="ajax" idAjax="confEspecifAjax" />	
			<mod:grupo largura="7">
				<mod:radio titulo="N�o." var="confEspecif" valor="2" reler="ajax"
					idAjax="confEspecifAjax" />
			</mod:grupo>
			<c:set var="confEspecifVal" value="${confEspecif}" />
			<c:if test="${empty confEspecifVal}">
				<c:set var="confEspecifVal" value="${param['confEspecif']}" />
			</c:if>
			<mod:grupo largura="93">
				<mod:grupo depende="confEspecifAjax">
					<c:if test="${confEspecifVal == '2'}">
						<mod:texto titulo="Justificar" var="jusConfEspecif" largura="60"
							maxcaracteres="60" obrigatorio="Sim" />
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>	
		<mod:grupo titulo="Frequ�ncia de Funcion�rios">
			<mod:selecao titulo="�ndice de Freq��ncia" var="frequencia" opcoes="Integral;Parcial" reler="ajax" idAjax="frequenciaAjax" />
			<mod:grupo depende="frequenciaAjax">
				<c:if test="${frequencia eq 'Parcial'}">
					<mod:selecao titulo="N� de categorias profissionais a gerenciar" var="numCatProfis" opcoes="1;2;3" 
					reler="ajax" idAjax="numCatProfisAjax" />
					<mod:grupo depende="numCatProfisAjax">
						<c:forEach var="i" begin="1" end="${numCatProfis}">
							<mod:grupo>
								<b>${i}.</b><mod:texto titulo="Categoria profissional" var="catProfis${i}" largura="10" obrigatorio="Sim" />
							</mod:grupo>
							<mod:grupo>	
								 &nbsp;&nbsp;&nbsp;<mod:texto titulo="N�mero de faltas sem reposi��o" var="numFaltas${i}" largura="3" obrigatorio="Sim"/>
							</mod:grupo>
							<mod:grupo>	
								 &nbsp;&nbsp;&nbsp;<mod:texto titulo="Quantidade de minutos em atrasos sem reposi��o" var="numAtrasos${i}" largura="3" obrigatorio="Sim"/>
							</mod:grupo>													
						</c:forEach>	
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
			<c:when test="${qualidSuprim == '1'}">
				<mod:oculto var="qualidSuprimNao" valor="satisfat�ria" />
			</c:when>
			<c:when test="${qualidSuprim == '2'}">
				<mod:oculto var="qualidSuprimNao" valor="regular" />
			</c:when>
			<c:when test="${qualidSuprim == '3'}">
				<mod:oculto var="qualidSuprimNao" valor="insatisfat�ria" />				
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${quantEquip == '1'}">
				<mod:oculto var="quantEquipNao" valor="satisfat�ria" />
			</c:when>
			<c:when test="${quantEquip == '2'}">
				<mod:oculto var="quantEquipNao" valor="regular" />
			</c:when>
			<c:when test="${quantEquip == '3'}">
				<mod:oculto var="quantEquipNao" valor="insatisfat�ria" />
			</c:when>
		</c:choose>
		
			
		<table style="float: none; clear: both"  width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
			<tr>
				<th><b>Informa��es referentes aos suprimentos (exceto papel): </b></th>
			</tr>
			<tr><td>1. A entrega ${entrNoPrazoNao} foi realizada no prazo.
				<c:if test="${entrNoPrazo == '2'}">	
					
					<br>&nbsp;&nbsp;&nbsp;&nbsp;${ressalvaEntrNoPrazo}					
				</c:if>
			</td></tr>	
			<tr><td>2. As quantidades solicitadas ${entrQuantNao} foram entregues.
				<c:if test="${entrQuant == '2'}">			
					<br>${ressalvaEntrQuant}					
				</c:if>
			</td></tr>	
			<tr><td>3. A qualidade dos suprimentos foi avalidada como ${qualidSuprimNao}.
				<c:if test="${qualidSuprim == '2' or qualidSuprim == '3'}">			
					<br>${jusQualidSuprim}					
				</c:if>
			</td></tr>	
			<tr><td>4. Os equipamentos ${boaCondEquipNao} est�o em boas condi��es. 
				<c:if test="${boaCondEquip == '2'}">			
					<br>A substitui��o ${substitEquipNao} foi solicitada. 		
					<c:if test="${substitEquip == '2'}">			
						<br>${ressalvaSubstitEquip} 					
					</c:if>			
				</c:if>
			</td></tr>	
			<tr><td>
			<ww:if test="${not empty numManutencoes}">								
				 5. N�mero de manuten��es (preventivas e corretivas) nos equipamentos: ${numManutencoes}				
			</ww:if>
			<ww:else>
				5. N�o houve manuten��es (preventivas / corretivas) nos equipamentos. 
			</ww:else>
			</td></tr>	
			<tr><td>6. A quantidade dos equipamentos foi avalidada como ${quantEquipNao}.
				<c:if test="${quantEquip == '2' or quantEquip == '3'}">			
					<br>${jusQuantEquip}					
				</c:if>
			</td></tr>	
			<tr><td>7. O total de imagens digitalizadas ${totImagNao} ultrapassou a franquia.
				<c:if test="${totImag == '2'}">	<%-- sim --%>		
					<br>${ressalvaTotImag}					
				</c:if>
			</td></tr>	
			<ww:if test="${valeAlim == '3'}">
				<tr><td>8. A compatibilidade dos valores do vale alimenta��o com os dias trabalhados n�o se aplica.
				(c�pias encaminhadas diretamente para a sede).</td></tr>
			</ww:if>
			<ww:else>
				<tr><td>8. Os valores do vale alimenta��o ${valeAlimNao} foram compat�veis com os dias trabalhados.
					<c:if test="${valeAlim == '2'}">		
						<br>${ressalvaValeAlim}					
					</c:if>
				</td></tr>
			</ww:else>	
			<ww:if test="${valeTransp == '3'}">
				<tr><td>9. A compatibilidade dos valores do vale transporte com os dias trabalhados n�o se aplica.
				(c�pias encaminhadas diretamente para a sede).</td></tr>
			</ww:if>
			<ww:else>
				<tr><td>9. Os valores do vale transporte ${valeTranspNao} foram compat�veis com os dias trabalhados.
					<c:if test="${valeTransp == '2'}">		
						<br>${ressalvaValeTransp}					
					</c:if>
				</td></tr>
			</ww:else>	
			<tr><td>10. Os uniformes ${boaCondUnifNao} est�o em boas condi��es. 
				<c:if test="${boaCondUnif == '2'}">			
					<br>A substitui��o ${substitUnifNao} foi solicitada. 		
					<c:if test="${substitUnif == '2'}">			
						&nbsp;${ressalvaSubstitUnif} 					
					</c:if>			
				</c:if>
			</td></tr>	
						
						
		</table>	
	</mod:documento>
</mod:modelo>
