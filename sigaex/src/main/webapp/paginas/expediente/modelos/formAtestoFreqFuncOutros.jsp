<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>		
		<c:if test="${secao == 'SEGRA' or secao == 'SGS'}">	
			<ww:if test="${secao == 'SEGRA'}">			
				<p><b>Quanto aos suprimentos (exceto papel):</b></p>
			</ww:if>
			<ww:else>
				<p><b>Quanto aos materiais/equipamentos de limpeza:</b></p>
			</ww:else>
			<mod:grupo titulo="A entrega foi realizada no prazo?">		
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
							<mod:memo titulo="Ressalvas" var="ressalvaEntrNoPrazo" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="entrNoPrazoNao" valor="n�o"/>								
						</c:if>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>		
			<mod:grupo titulo="As quantidades solicitadas foram entregues?">
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
							<mod:memo titulo="Ressalvas" var="ressalvaEntrQuant" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="entrQuantNao" valor="n�o"/>			
						</c:if>
					</mod:grupo>
				</mod:grupo>	
			</mod:grupo>
		</c:if>
		<c:if test="${secao == 'SIE'}">
			<p><b>Quanto aos materiais/equipamentos/ferramentas:</b></p>
			<mod:grupo titulo="Foram disponibilizados em tempo para a execu��o do servi�o?">
				<mod:radio titulo="Sim." var="tempExec" valor="1" marcado="Sim"
								reler="ajax" idAjax="tempExecAjax" />			
				<mod:grupo largura="7">
					<mod:radio titulo="N�o." var="tempExec" valor="2" reler="ajax"
						idAjax="tempExecAjax" />
				</mod:grupo>
				<c:set var="tempExecVal" value="${tempExec}" />
				<c:if test="${empty tempExecVal}">
					<c:set var="tempExecVal" value="${param['tempExec']}" />
				</c:if>
				<mod:grupo largura="93">
					<mod:grupo depende="tempExecAjax">
						<ww:if test="${tempExecVal == '2'}">
							<mod:memo titulo="Ressalvas" var="ressalvaTempExec" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="tempExecNao" valor="N�o foram"/>		
						</ww:if>
						<ww:else>
							<mod:oculto var="tempExecNao" valor="Foram"/>	
						</ww:else>					
					</mod:grupo>
				</mod:grupo>			
			</mod:grupo>
		</c:if>		
		<c:if test="${secao == 'STI' or secao == 'DSEG'}">
			<mod:oculto var="servicos" valor="dos servi�os prestados"/>	
		</c:if>
		<mod:grupo titulo="Como avalia a qualidade ${servicos}?">
			<mod:radio titulo="Satisfat�ria." var="qualidade"  valor="1" marcado="Sim"
						reler="ajax" idAjax="qualidadeAjax" />	
			<mod:radio titulo="Regular." var="qualidade" valor="2" reler="ajax"
					   idAjax="qualidadeAjax" />
		    <mod:radio titulo="Insatisfat�ria." var="qualidade" valor="3" reler="ajax"
						idAjax="qualidadeAjax" />
			<c:set var="qualidadeVal" value="${qualidade}" />
			<c:if test="${empty qualidadeVal}">
				<c:set var="qualidadeVal" value="${param['qualidade']}" />
			</c:if>		
			<mod:grupo depende="qualidadeAjax">
				<c:if test="${qualidadeVal == '2' or qualidadeVal == '3'}">
					<mod:memo titulo="Justificar" var="jusQualidade" linhas="2"
								colunas="60" obrigatorio="Sim" />	
     			</c:if>
			</mod:grupo>			
		</mod:grupo>
		<c:if test="${secao == 'STI'}">		
			<mod:grupo>
				<b><mod:texto titulo="Qual a quantidade de chamados atendidos pelo t�cnico de inform�tica?"
							 var="numChamados" largura="5" maxcaracteres="5" valor="0"/></b>
			</mod:grupo>
		</c:if>	
		<c:if test="${secao == 'SEGRA' or secao == 'SGS' or secao == 'SIE'}">	
			<c:choose>
				<c:when test="${secao == 'SEGRA'}">			
					<mod:oculto var="tipoEquip" valor="equipamentos"/>	
				</c:when>			
				<c:when test="${secao == 'SGS' or secao == 'SIE'}">
					<mod:oculto var="tipoEquip" valor="mobili�rios e eletrodom�sticos"/>	
				</c:when>
			</c:choose>
			<mod:grupo titulo="Os ${tipoEquip} est�o em boas condi��es?">
				<mod:radio titulo="Sim." var="boaCondEquip" valor="1" marcado="Sim"
							reler="ajax" idAjax="boaCondEquipAjax" />
				<mod:grupo largura="3">
					<mod:radio titulo="N�o." var="boaCondEquip" valor="2" reler="ajax"
						idAjax="boaCondEquipAjax" />
				</mod:grupo>
				<c:set var="boaCondEquipVal" value="${boaCondEquip}" />
				<c:if test="${empty boaCondEquipVal}">
					<c:set var="boaCondEquipVal" value="${param['boaCondEquip']}" />
				</c:if>
				<mod:grupo largura="97">
					<mod:grupo depende="boaCondEquipAjax">  
						<ww:if test="${boaCondEquipVal == '2'}">
							<mod:oculto var="boaCondEquipNao" valor="n�o" />
							A substitui��o foi solicitada?							
							<mod:radio titulo="Sim." var="substitEquip" valor="1" marcado="Sim"
												reler="ajax" idAjax="substitEquipAjax" />
							<mod:grupo>
							<mod:grupo largura="3">					
								<mod:radio titulo="N�o." var="substitEquip" valor="2" 
												reler="ajax" idAjax="substitEquipAjax" />
											
								<c:set var="substitEquipVal" value="${substitEquip}" />
								<c:if test="${empty substitEquipVal}">
									<c:set var="substitEquipVal" value="${param['substitEquip']}" />
								</c:if>
								<mod:grupo largura="97">
									<mod:grupo depende="substitEquipAjax">	
										<c:if test="${substitEquipVal == '2'}">										 
											<mod:memo titulo="Ressalvas" var="ressalvaSubstitEquip" linhas="2"
								             colunas="60" obrigatorio="Sim" />
											<mod:oculto var="substitEquipNao" valor="n�o" />	
										</c:if>									
									</mod:grupo>
								</mod:grupo>	
							</mod:grupo>														
							</mod:grupo>														
						</ww:if>					
					</mod:grupo>
				</mod:grupo>				 
			</mod:grupo>	
			<c:if test="${secao == 'SIE'}">
					<mod:radio titulo="N�o se aplica." var="boaCondEquip" valor="3" 
								reler="ajax" idAjax="boaCondEquipAjax" />
			</c:if>				 								
		</c:if>
		<c:if test="${secao == 'SEGRA'}">		
			<mod:grupo>
				<b><mod:texto titulo="Quantas manuten��es (preventivas e corretivas) foram feitas nos equipamentos?"
							 var="numManutencoes" largura="5" maxcaracteres="5" valor="0"/></b>
			</mod:grupo>
			<mod:grupo titulo="Como avalia a quantidade dos equipamentos?">
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
						<mod:memo titulo="Justificar" var="jusQuantEquip" linhas="2"
								colunas="60" obrigatorio="Sim" />
				 	 </c:if>
				</mod:grupo>			
			</mod:grupo>	
			<mod:grupo titulo="O total de c�pias impressas/imagens digitalizadas ultrapassou a franquia? ">	
				<mod:radio titulo="N�o." var="totImag" valor="1" marcado="Sim"
							reler="ajax" idAjax="totImagAjax" />		
				<mod:grupo largura="7">
					<mod:radio titulo="Sim." var="totImag" valor="2" reler="ajax"
						idAjax="totImagAjax" />
				</mod:grupo>
				<c:set var="totImagVal" value="${totImag}" />
				<c:if test="${empty totImagVal}">
					<c:set var="totImagVal" value="${param['totImag']}" />
					<c:if test="${empty totImagVal}">
						<c:set var="totImagVal" value="1" />
					</c:if>
				</c:if>				
				<mod:grupo largura="93">
					<mod:grupo depende="totImagAjax">
						<ww:if test="${totImagVal == '2'}">
							<mod:memo titulo="Ressalvas" var="ressalvaTotImag" linhas="2"
								colunas="60" obrigatorio="Sim" />						
						</ww:if>						
						<ww:else>
							<mod:oculto var="totImagNao" valor="n�o"/>	
						</ww:else>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>
		</c:if>
		<mod:grupo titulo="Os valores do vale alimenta��o foram compat�veis com os dias trabalhados?">	
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
						<mod:memo titulo="Ressalvas" var="ressalvaValeAlim" linhas="2" colunas="60" obrigatorio="Sim" />
						<mod:oculto var="valeAlimNao" valor="n�o"/>	
					</c:if>
				</mod:grupo>
			</mod:grupo>
			<mod:radio titulo="N�o se aplica (c�pias encaminhada diretamente para a sede)." var="valeAlim" valor="3" 
						reler="ajax" idAjax="valeAlimAjax" /> 	
		</mod:grupo>
		<mod:grupo titulo="Os valores do vale transporte foram compat�veis com os dias trabalhados?">	
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
						<mod:memo titulo="Ressalvas" var="ressalvaValeTransp" linhas="2"
								colunas="60" obrigatorio="Sim" />
						<mod:oculto var="valeTranspNao" valor="n�o"/>		
					</c:if>
				</mod:grupo>
			</mod:grupo>
			<mod:radio titulo="N�o se aplica (c�pias encaminhada diretamente para a sede)." var="valeTransp" valor="3" 
						reler="ajax" idAjax="valeTranspAjax" />		
		</mod:grupo>
		<c:if test="${secao == 'SIE'}">
			<mod:grupo titulo="Os valores para deslocamento entre subse��es foram compat�veis 
								com os dias trabalhados?">
				<mod:radio titulo="Sim." var="deslocamento" valor="1" marcado="Sim"
								reler="ajax" idAjax="deslocamentoAjax" />			
				<mod:grupo largura="7">
					<mod:radio titulo="N�o." var="deslocamento" valor="2" reler="ajax"
						idAjax="deslocamentoAjax" />
				</mod:grupo>
				<c:set var="deslocamentoVal" value="${deslocamento}" />
				<c:if test="${empty deslocamentoVal}">
					<c:set var="deslocamentoVal" value="${param['deslocamento']}" />
				</c:if>
				<mod:grupo largura="93">
					<mod:grupo depende="deslocamentoAjax">
						<ww:if test="${deslocamentoVal == '2'}">
							<mod:texto titulo="Ressalvas" var="ressalvaDeslocamento" largura="60"
								maxcaracteres="60" obrigatorio="Sim" />
							<mod:oculto var="deslocamentoNao" valor="n�o"/>		
						</ww:if>										
					</mod:grupo>
				</mod:grupo>			
			</mod:grupo>
		</c:if>	
		<mod:grupo titulo="Os uniformes est�o em boas condi��es?">
			<mod:radio titulo="Sim." var="boaCondUnif" valor="1" marcado="Sim" reler="ajax" idAjax="boaCondUnifAjax"/>
		
			<mod:grupo largura="3">
				<mod:radio titulo="N�o." var="boaCondUnif" valor="2" reler="ajax" idAjax="boaCondUnifAjax"/>
			</mod:grupo> 

			<c:set var="boaCondUnifVal" value="${boaCondUnif}"/>
			<c:if test="${empty boaCondUnifVal}">
				<c:set var="boaCondUnifVal" value="${param['boaCondUnif']}"/>
			</c:if>

			<mod:grupo largura="97">
				<mod:grupo depende="boaCondUnifAjax">
					<ww:if test="${boaCondUnifVal == '2'}">
						<mod:oculto var="boaCondUnifNao" valor="n�o"/>
						</br><b>A substitui��o foi solicitada?</b>
						<mod:radio titulo="Sim." var="substitUnif" valor="1" reler="ajax" idAjax="substitUnifAjax" marcado="Sim"/>
						<mod:grupo>
							<mod:grupo largura="3">
								<mod:radio titulo="N�o." var="substitUnif" valor="2" reler="ajax" idAjax="substitUnifAjax"/>
								<c:set var="substitUnifVal" value="${substitUnif}"/>
								<c:if test="${empty substitUnifVal}">
									<c:set var="substitUnifVal" value="${param['substitUnif']}"/>
								</c:if>
								<mod:grupo largura="97">
									<mod:grupo depende="substitUnifAjax">	
										<c:if test="${substitUnifVal == '2'}">
											<mod:memo titulo="Ressalvas" var="ressalvaSubstitUnif" linhas="2"
								             colunas="60" obrigatorio="Sim"/>
											<mod:oculto var="substitUnifNao" valor="n�o"/>		
										</c:if>
									</mod:grupo>
								</mod:grupo>
							</mod:grupo>
						</mod:grupo>
							
					</ww:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>	
		<mod:grupo titulo="Os contracheques apresentaram diverg�ncias ou irregularidades?">	
			<mod:radio titulo="N�o." var="irregContCheq" valor="1" marcado="Sim"
						reler="ajax" idAjax="irregContCheqAjax" />		
			<mod:grupo largura="7">
				<mod:radio titulo="Sim." var="irregContCheq" valor="2" reler="ajax"
					idAjax="irregContCheqAjax" />
			</mod:grupo>
			<c:set var="irregContCheqVal" value="${irregContCheq}" />
			<c:if test="${empty irregContCheqVal}">
				<c:set var="irregContCheqVal" value="${param['irregContCheq']}" />
				<c:if test="${empty irregContCheqVal}">
						<c:set var="irregContCheqVal" value="1" /> 
					</c:if>
			</c:if>			
			<mod:grupo largura="93">
				<mod:grupo depende="irregContCheqAjax">
					<ww:if test="${irregContCheqVal == '2'}">
						<mod:memo titulo="Ressalvas" var="ressalvaIrregContCheq" linhas="2"
								colunas="60" obrigatorio="Sim" />						
					</ww:if>
					<ww:else>
						<c:if test="${irregContCheqVal == '1'}">
							<mod:oculto var="irregContCheqNao" valor="n�o"/>	
						</c:if>						
					</ww:else>
					
				</mod:grupo>
			</mod:grupo>
			<mod:radio titulo="N�o se aplica (c�pias encaminhada diretamente para a sede)." var="irregContCheq" valor="3" 
						reler="ajax" idAjax="irregContCheqAjax" />
		
		</mod:grupo>
		<c:if test="${secao == 'DSEG'}">
			<mod:grupo>
				<b><mod:memo titulo="Liste abaixo quaisquer observa��es adicionais (rondas, 
							manute��es de armamentos, etc.)" 
							var="obsAdicionais" linhas="3" colunas="80" /></b>
			</mod:grupo>
		</c:if>
		<c:if test="${secao == 'SEGRA' or secao == 'SGS' or secao == 'SIE'}">
			<mod:grupo titulo="Os funcion�rios prestaram os servi�os em conformidade com a especifica��o?">		
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
							<mod:memo titulo="Justificar" var="jusConfEspecif" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="confEspecifNao" valor="n�o"/>		
						</c:if>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>	
		</c:if>
		<c:if test="${secao == 'SGS'}">
			<mod:grupo titulo="Ocorreu a visita mensal do supervisor da empresa contratada?">	
				<mod:radio titulo="N�o." var="visitaSup" valor="1" marcado="Sim"
						reler="ajax" idAjax="visitaSupAjax" />
				<mod:grupo largura="3">
					<mod:radio titulo="Sim." var="visitaSup" valor="2" reler="ajax"
						idAjax="visitaSupAjax" />
				</mod:grupo>
				<c:set var="visitaSupVal" value="${visitaSup}" />
				<c:if test="${empty visitaSupVal}">
					<c:set var="visitaSupVal" value="${param['visitaSup']}" />
				</c:if>
				<mod:grupo largura="97">
					<mod:grupo depende="visitaSupAjax">  
						<ww:if test="${visitaSupVal == '2'}">												
							<mod:grupo largura="15">
								<b>Como avalia a visita?</b>
								<mod:grupo largura ="85">
								<mod:radio titulo="Satisfat�ria" var="avalVisita" valor="1" marcado="Sim"
												reler="ajax" idAjax="avalVisitaAjax" />
								<mod:radio titulo="Regular." var="avalVisita" valor="2" 
											reler="ajax" idAjax="avalVisitaAjax" />
								<mod:radio titulo="Insatisfat�ria." var="avalVisita" valor="3" 
												reler="ajax" idAjax="avalVisitaAjax" />
								<c:set var="avalVisitaVal" value="${avalVisita}" />
								<c:if test="${empty avalVisitaVal}">
									<c:set var="avalVisitaVal" value="${param['avalVisita']}" />
								</c:if>								
								<mod:grupo depende="avalVisitaAjax">	
									<c:if test="${avalVisitaVal == '2' or avalVisitaVal == '3'}">										
										<mod:memo titulo="Justificar" var="jusAvalVisita" linhas="2"
										colunas="60" obrigatorio="Sim" />										
									</c:if>										
								</mod:grupo>						
								</mod:grupo>	
							</mod:grupo>															
						</ww:if>
						<ww:else>					
							<mod:oculto var="visitaSupNao" valor="n�o" />
						</ww:else>						
					</mod:grupo>
				</mod:grupo> 				
			</mod:grupo>					
		</c:if>
		<c:if test="${secao == 'SIE'}">
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
							<mod:memo titulo="Observa��es" var="obsComIdentif" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="comIdentifNao" valor="n�o"/>		
						</c:if>					
					</mod:grupo>
				</mod:grupo>			
			</mod:grupo>
			<mod:grupo titulo="Os equipamentos de seguran�a est�o sendo utilizados?">
				<mod:radio titulo="Sim." var="equipUtil" valor="1" marcado="Sim"
								reler="ajax" idAjax="equipUtilAjax" />			
				<mod:grupo largura="7">
					<mod:radio titulo="N�o." var="equipUtil" valor="2" reler="ajax"
						idAjax="equipUtilAjax" />
				</mod:grupo>
				<c:set var="equipUtilVal" value="${equipUtil}" />
				<c:if test="${empty equipUtilVal}">
					<c:set var="equipUtilVal" value="${param['equipUtil']}" />
				</c:if>
				<mod:grupo largura="93">
					<mod:grupo depende="equipUtilAjax">
						<ww:if test="${equipUtilVal == '2'}">
							<mod:memo titulo="Ressalvas" var="ressalvaEquipUtil" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="equipUtilNao" valor="n�o"/>		
						</ww:if>										
					</mod:grupo>
				</mod:grupo>			
			</mod:grupo>
			<mod:grupo>
				<b><mod:texto titulo="Qual a quantidade de chamados atendidos pelo eletricista?"
							 var="numChamadosEletr" largura="5" maxcaracteres="5" valor="0"/></b>
			</mod:grupo>
			<mod:grupo>
				<b><mod:texto titulo="Qual a quantidade de chamados atendidos pelo bombeiro hidr�ulico?"
							 var="numChamadosBomb" largura="5" maxcaracteres="5" valor="0"/></b>
			</mod:grupo>
			<mod:grupo titulo="As rotinas de manuten��o preventiva est�o sendo realizadas (di�rias, semanais, quinzenais, mensais, semestrais)?">		
				<mod:radio titulo="Sim." var="manutPrevent" valor="1" marcado="Sim"
							reler="ajax" idAjax="manutPreventAjax" />	
				<mod:grupo largura="7">
					<mod:radio titulo="N�o." var="manutPrevent" valor="2" reler="ajax"
						idAjax="manutPreventAjax" />
				</mod:grupo>
				<c:set var="manutPreventVal" value="${manutPrevent}" />
				<c:if test="${empty manutPrevent}">
					<c:set var="manutPreventVal" value="${param['manutPrevent']}" />
				</c:if>
				<mod:grupo largura="93">
					<mod:grupo depende="manutPreventAjax">
						<c:if test="${manutPreventVal == '2'}">
							<mod:memo titulo="Justificar" var="jusManutPrevent" linhas="2"
								colunas="60" obrigatorio="Sim" />
							<mod:oculto var="manutPreventNao" valor="n�o"/>		
						</c:if>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>	
		</c:if>
		<c:if test="${secao == 'SGS' or secao == 'SIE'}">
			<ww:if test="${secao == 'SGS'}">
				<mod:oculto var="tipoServico" valor="jardinagem"/>	
			</ww:if>
			<ww:else>
				<mod:oculto var="tipoServico" valor="limpeza de calha"/>	
			</ww:else>
			<mod:grupo titulo="Possui servi�o de ${tipoServico}?">
				<mod:radio titulo="N�o." var="possuiTipo" valor="1" marcado="Sim" reler="ajax" idAjax="possuiTipoAjax"/>		
				<mod:grupo largura="3">
					<mod:radio titulo="Sim." var="possuiTipo" valor="2" reler="ajax" idAjax="possuiTipoAjax"/>
				</mod:grupo>	
				<c:set var="possuiTipoVal" value="${possuiTipo}"/>
				<c:if test="${empty possuiTipoVal}">
					<c:set var="possuiTipoVal" value="${param['possuiTipo']}"/>
				</c:if>
				<mod:grupo largura="97">
					<mod:grupo depende="possuiTipoAjax">
						<ww:if test="${possuiTipoVal == '2'}">	
							<mod:oculto var="possuiTipoNao" valor="Possui"/>												
							<b>O cronograma foi cumprido?</b>
							<mod:radio titulo="Sim." var="cronograma" valor="1" reler="ajax" idAjax="cronogramaAjax" marcado="Sim"/>
						 	<mod:grupo>
								<mod:grupo largura="7">
									<mod:radio titulo="N�o." var="cronograma" valor="2" reler="ajax" idAjax="cronogramaAjax"/>
									<c:set var="cronogramaVal" value="${cronograma}"/>
									<c:if test="${empty cronogramaVal}">
										<c:set var="cronogramaVal" value="${param['cronograma']}"/>
									</c:if>							
									<mod:grupo largura="93">
										<mod:grupo depende="cronogramaAjax">	
											<c:if test="${cronogramaVal == '2'}">
												<mod:memo titulo="Justificar" var="jusCronograma" linhas="2"
								                 colunas="60" obrigatorio="Sim"/>
												<mod:oculto var="cronogramaNao" valor="n�o"/>		
											</c:if>
										</mod:grupo>
									</mod:grupo>
								</mod:grupo>
							</mod:grupo>
							<b>Como avalia a execu��o dos servi�os?</b>								
							<mod:radio titulo="Satisfat�ria" var="avalServico" valor="1" marcado="Sim"
											reler="ajax" idAjax="avalServicoAjax" />
							<mod:radio titulo="Regular." var="avalServico" valor="2" 
										reler="ajax" idAjax="avalServicoAjax" />
							<mod:radio titulo="Insatisfat�ria." var="avalServico" valor="3" 
											reler="ajax" idAjax="avalServicoAjax" />
							<c:set var="avalServicoVal" value="${avalServico}" />
							<c:if test="${empty avalServicoVal}">
								<c:set var="avalServicoVal" value="${param['avalServico']}" />
							</c:if>								
							<mod:grupo depende="avalServicoAjax">	
								<c:if test="${avalServicoVal == '2' or avalServicoVal == '3'}">										
									<mod:memo titulo="Justificar" var="jusAvalServico" linhas="2"
								colunas="60" obrigatorio="Sim" />										
								</c:if>										
							</mod:grupo>
							<b>Como avalia a qualidade e quantidade dos equipamentos/insumos?</b>								
							<mod:radio titulo="Satisfat�ria" var="avalEquip" valor="1" marcado="Sim"
											reler="ajax" idAjax="avalEquipAjax" />
							<mod:radio titulo="Regular." var="avalEquip" valor="2" 
										reler="ajax" idAjax="avalEquipAjax" />
							<mod:radio titulo="Insatisfat�ria." var="avalEquip" valor="3" 
											reler="ajax" idAjax="avalEquipAjax" />
							<c:set var="avalEquipVal" value="${avalEquip}" />
							<c:if test="${empty avalEquipVal}">
								<c:set var="avalEquipVal" value="${param['avalEquip']}" />
							</c:if>								
							<mod:grupo depende="avalEquipAjax">	
								<c:if test="${avalEquipVal == '2' or avalEquipVal == '3'}">										
									<mod:memo titulo="Justificar" var="jusAvalEquip" linhas="2"
								     colunas="60" obrigatorio="Sim" />										
								</c:if>										
							</mod:grupo>																											
						</ww:if>
						<ww:else>
							<mod:oculto var="possuiTipoNao" valor="N�o possui"/>
						</ww:else>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>	
		</c:if>
		<mod:grupo titulo="Frequ�ncia de Funcion�rios">
			<mod:selecao titulo="�ndice de Freq��ncia" var="freqFunc" opcoes="Integral;Parcial" reler="ajax" idAjax="freqFuncAjax" />
			<mod:grupo depende="freqFuncAjax">
				<c:if test="${freqFunc eq 'Parcial'}">
					<c:choose>
					<c:when test="${secao == 'SEGRA' or secao == 'SGS' or secao == 'SIE'}">					
						<mod:selecao titulo="N� de categorias profissionais a gerenciar" var="numCatProfis" opcoes="1;2;3" 
						reler="ajax" idAjax="numCatProfisAjax" />
						<mod:grupo depende="numCatProfisAjax">
							<c:forEach var="i" begin="1" end="${numCatProfis}">
								<mod:grupo>
									<b>${i}.</b><mod:texto titulo="Categoria profissional" var="catProfis${i}" largura="40" 
												obrigatorio="Sim" />
								</mod:grupo>
								<mod:grupo>	
									 &nbsp;&nbsp;&nbsp;<mod:texto titulo="N�mero de faltas sem reposi��o" var="numFaltas${i}" 
									 					largura="10" valor="0" />
								</mod:grupo>
								<mod:grupo>	
									 &nbsp;&nbsp;&nbsp;<mod:texto titulo="Quantidade de minutos em atrasos sem reposi��o" 
									 					var="quantMinutos${i}" largura="10" valor="0" />
								</mod:grupo>													
							</c:forEach>	
						</mod:grupo>							
					</c:when>	
					<c:when test="${secao == 'STI'}">	
						<mod:grupo>
							<mod:texto titulo="N�mero de faltas sem reposi��o" var="numFaltas" 
									 					largura="10" valor="0" />
						</mod:grupo>
						<mod:grupo>
							<mod:texto titulo="Quantidade de minutos em atrasos sem reposi��o" 
									 					var="quantMinutos" largura="10" valor="0" />
						</mod:grupo>			 					
					</c:when>			
					<c:when test="${secao == 'DSEG'}">
						<mod:grupo>
							<mod:selecao titulo="Informa��o simplificada" var="infSimpl" opcoes="Sim;N�o"
							reler="ajax" idAjax="infSimplAjax" />
						</mod:grupo>
						<mod:grupo depende="infSimplAjax">
							<ww:if test="${infSimpl == 'Sim'}">
								<mod:grupo>
									<mod:texto titulo="N�mero de faltas sem reposi��o" var="numFaltas" 
									 					largura="10" valor="0" />
								</mod:grupo>
								<mod:grupo>
									<mod:texto titulo="Quantidade de minutos em atrasos sem reposi��o" 
									 					var="quantMinutos" largura="10" valor="0" />
								</mod:grupo>			
							</ww:if>
							<ww:else>							
								<mod:radio titulo="com reposi��o" var="reposicao" valor="1" reler="ajax"
					  						idAjax="reposicaoAjax" marcado="Sim"/>
		    					<mod:radio titulo="sem reposi��o" var="reposicao" valor="2" reler="ajax"
											idAjax="reposicaoAjax" />
								<c:set var="reposicaoVal" value="${reposicao}" />
								<c:if test="${empty reposicaoVal}">
									<c:set var="reposicaoVal" value="${param['reposicao']}" />
									<c:if test="${empty reposicaoVal}">
										<c:set var="reposicaoVal" value="1" />
									</c:if>
								</c:if>		
								<mod:selecao titulo="Informe a quantidade de funcion�rios com frequ�ncia parcial" 
								var="numFuncParcial" opcoes="1;2;3;4;5;6;7;8;9;10" reler="ajax" idAjax="numFuncParcialAjax" />
								<mod:grupo depende="numFuncParcialAjax">	
									<mod:grupo depende="reposicaoAjax">								
										<c:forEach var="i" begin="1" end="${numFuncParcial}">											
											<mod:grupo>
												<b>${i}.</b><mod:data titulo="De" var="dataIni${i}"  />
															<mod:data titulo="At�" var="dataFim${i}"  />
											</mod:grupo>
											<mod:grupo>	
										 		&nbsp;&nbsp;&nbsp;<mod:texto titulo="Nome do funcion�rio faltoso" var="nomeFunc${i}" 
										 					largura="73"  />
											</mod:grupo>																									
											<ww:if test="${reposicaoVal == '1'}">
												<mod:grupo>	
											 		&nbsp;&nbsp;&nbsp;<mod:texto titulo="Nome do funcion�rio que cobriu a falta" var="nomeSubst${i}" 
											 					largura="62" />
												</mod:grupo>
												<mod:grupo>	
											 		&nbsp;&nbsp;&nbsp;<mod:texto titulo="Motivo da aus�ncia" 
											 					var="motivo${i}" largura="81" />
												</mod:grupo>
											</ww:if>
											<ww:else>
													&nbsp;&nbsp;&nbsp;<mod:texto titulo="Observa��es" var="obs${i}" 
											 					largura="70" />
											</ww:else>														
										</c:forEach>
									</mod:grupo>									
								</mod:grupo>									
							</ww:else>
						</mod:grupo> 
					</c:when>
					</c:choose>	
					<ww:if test="${secao == 'DSEG'}">
						<mod:oculto var="titMemo" valor="Informa��es adicionais"/>						
					</ww:if>
					<ww:else>	
						<mod:oculto var="titMemo" valor="Ressalvas"/>					
					</ww:else>
					<mod:grupo>
						<mod:memo titulo="${titMemo}" var="ressalvaFreq" linhas="2"
								colunas="80" />
					</mod:grupo>
				</c:if>				
			</mod:grupo>			
		</mod:grupo>	
		<mod:grupo>
			<c:if test="${secao == 'SIE'}">
				<b><mod:mensagem titulo="Observa��o" texto="comunicar diariamente ao gestor as faltas e os atrasos."> </mod:mensagem></b>
			</c:if>
			<c:if test="${secao == 'DSEG'}">
				<b><mod:mensagem titulo="Observa��o" texto="anexar a Planilha de Freq��ncia a este formul�rio no SIGA-DOC, em formato Pdf, e envi�-la tamb�m por e-mail ao gestor, em formato Excel."> </mod:mensagem></b>
			</c:if>
		</mod:grupo>	
	</mod:entrevista>
	<mod:documento>
		<c:choose>
			<c:when test="${qualidade == '1'}">
				<mod:oculto var="qualidadeNao" valor="satisfat�ria" />
			</c:when>
			<c:when test="${qualidade == '2'}">
				<mod:oculto var="qualidadeNao" valor="regular" />
			</c:when>
			<c:when test="${qualidade == '3'}">
				<mod:oculto var="qualidadeNao" valor="insatisfat�ria" />				
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
		<c:choose>
			<c:when test="${avalVisita == '1'}">
				<mod:oculto var="avalVisitaNao" valor="satisfat�ria" />
			</c:when>
			<c:when test="${avalVisita == '2'}">
				<mod:oculto var="avalVisitaNao" valor="regular" />
			</c:when>
			<c:when test="${avalVisita == '3'}">
				<mod:oculto var="avalVisitaNao" valor="insatisfat�ria" />
			</c:when>
		</c:choose>	
		<c:choose>
			<c:when test="${avalServico == '1'}">
				<mod:oculto var="avalServicoNao" valor="satisfat�ria" />
			</c:when>
			<c:when test="${avalServico == '2'}">
				<mod:oculto var="avalServicoNao" valor="regular" />
			</c:when>
			<c:when test="${avalServico == '3'}">
				<mod:oculto var="avalServicoNao" valor="insatisfat�ria" />
			</c:when>
		</c:choose>	
		<c:choose>
			<c:when test="${avalEquip == '1'}">
				<mod:oculto var="avalEquipNao" valor="satisfat�rias" />
			</c:when>
			<c:when test="${avalEquip == '2'}">
				<mod:oculto var="avalEquipNao" valor="regulares" />
			</c:when>
			<c:when test="${avalEquip == '3'}">
				<mod:oculto var="avalEquipNao" valor="insatisfat�rias" />
			</c:when>
		</c:choose>											
		<ww:if test="${freqFunc eq 'Integral'}">
			<mod:oculto var="freqFuncTipo" valor="integral" />	
		</ww:if>
		<ww:else>
			<mod:oculto var="freqFuncTipo" valor="parcial" />	
		</ww:else>
		
		<table style="float: none; clear: both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">			
			<tr><th><b>
				<c:choose>
				<c:when test="${secao == 'SEGRA'}">
					Informa��es referentes aos suprimentos (exceto papel):
				</c:when>
				<c:when test="${secao == 'SGS'}">
					Informa��es referentes aos materiais/equipamentos de limpeza:
				</c:when>
				<c:when test="${secao == 'STI' or secao == 'DSEG'}">
					Informa��es referentes aos servi�os:
				</c:when>
				<c:when test="${secao == 'SIE'}">
					Informa��es referentes aos materiais/equipamentos/ferramentas:
				</c:when>
				</c:choose>					
			</b></th></tr>
			<c:if test="${secao == 'SEGRA' or secao == 'SGS'}">		
				<tr><td>A entrega ${entrNoPrazoNao} foi realizada no prazo.
					<c:if test="${entrNoPrazo == '2'}">	
					<br>${ressalvaEntrNoPrazo} 					
					</c:if>
				</td></tr>	
				<tr><td>As quantidades solicitadas ${entrQuantNao} foram entregues.
					<c:if test="${entrQuant == '2'}">			
						<br>${ressalvaEntrQuant}					
					</c:if>
				</td></tr>	
			</c:if>
			<c:if test="${secao == 'SIE'}">		
				<tr><td>${tempExecNao} disponibilizados em tempo para a execu��o do servi�o.
					<c:if test="${tempExec == '2'}">
						<br> ${ressalvaTempExec}					
					</c:if>
				</td></tr>	
			</c:if>
			
			<tr><td>A qualidade ${servicos} foi avalidada como ${qualidadeNao}.
				<c:if test="${qualidade == '2' or qualidade == '3'}">			
					<br>${jusQualidade}					
				</c:if>
			</td></tr>	
			<c:if test="${secao == 'STI'}">
				<tr><td>
				<ww:if test="${not empty numChamados and numChamados != '0'}">								
					 N�mero de chamados atendidos pelo t�cnico de inform�tica: ${numChamados}				
				</ww:if>
				<ww:else>
					N�o houve abertura de chamados para o t�cnico de inform�tica. 
				</ww:else>
				</td></tr>	
			</c:if>	
			<c:if test="${secao == 'SEGRA' or secao == 'SGS' or secao == 'SIE'}">
				<ww:if test="${boaCondEquip == '3'}">
					<tr><td>A informa��o referente �s condi��es dos ${tipoEquip} n�o se aplica .</td></tr>
				</ww:if>
				<ww:else>
				<tr><td>Os ${tipoEquip} ${boaCondEquipNao} est�o em boas condi��es. 
					<c:if test="${boaCondEquip == '2'}">			
						<br>&nbsp; - A substitui��o ${substitEquipNao} foi solicitada. 		
						<c:if test="${substitEquip == '2'}">			
							&nbsp;&nbsp;${ressalvaSubstitEquip} 					
						</c:if>			
					</c:if>
				</td></tr>
				</ww:else>	
			</c:if>
			<c:if test="${secao == 'SEGRA'}">
				<tr><td>
				<ww:if test="${not empty numManutencoes and numManutencoes != '0'}">								
					 N�mero de manuten��es (preventivas e corretivas) nos equipamentos: ${numManutencoes}				
				</ww:if>
				<ww:else>
					N�o houve manuten��es (preventivas / corretivas) nos equipamentos. 
				</ww:else>
				</td></tr>	
				<tr><td>A quantidade dos equipamentos foi avalidada como ${quantEquipNao}.
					<c:if test="${quantEquip == '2' or quantEquip == '3'}">			
						<br>${jusQuantEquip}					
					</c:if>
				</td></tr>	
				<tr><td>O total de c�pias impressas/imagens digitalizadas ${totImagNao} ultrapassou a franquia.
					<c:if test="${totImag == '2'}">	<%-- sim --%>		
						<br>${ressalvaTotImag}					
					</c:if>
				</td></tr>	
			</c:if>
			<ww:if test="${valeAlim == '3'}">
				<tr><td>A informa��o referente � compatibilidade dos valores do vale alimenta��o com os dias trabalhados n�o se aplica.
				(c�pias encaminhadas diretamente para a sede).</td></tr>
			</ww:if>
			<ww:else>
				<tr><td>Os valores do vale alimenta��o ${valeAlimNao} foram compat�veis com os dias trabalhados.
					<c:if test="${valeAlim == '2'}">		
						<br>${ressalvaValeAlim}					
					</c:if>
				</td></tr>
			</ww:else>	
			<ww:if test="${valeTransp == '3'}">
				<tr><td>A informa��o referente � compatibilidade dos valores do vale transporte com os dias trabalhados n�o se aplica.
				(c�pias encaminhadas diretamente para a sede).</td></tr>
			</ww:if>
			<ww:else>
				<tr><td>Os valores do vale transporte ${valeTranspNao} foram compat�veis com os dias trabalhados.
					<c:if test="${valeTransp == '2'}">		
						<br>${ressalvaValeTransp}					
					</c:if>
				</td></tr>
			</ww:else>
			<c:if test="${secao == 'SIE'}">		
				<tr><td>Os valores para deslocamento entre subse��es ${deslocamentoNao} foram compat�veis com os dias trabalhados.
					<c:if test="${deslocamento == '2'}">
						${ressalvaDeslocamento}					
					</c:if>
				</td></tr>	
			</c:if>	
			<tr><td>Os uniformes ${boaCondUnifNao} est�o em boas condi��es. 
				<c:if test="${boaCondUnif == '2'}">			
					<br>&nbsp; - A substitui��o ${substitUnifNao} foi solicitada. 		
					<c:if test="${substitUnif == '2'}">			
						&nbsp;&nbsp;${ressalvaSubstitUnif} 					
					</c:if>			
				</c:if>
			</td></tr>	
            <c:if test="${irregContCheq == '2'}">
			<tr><td>Os contracheques ${irregContCheqNao} apresentaram diverg�ncias ou irregularidades.
				<c:if test="${irregContCheq == '2'}">	
				<br>${ressalvaIrregContCheq} 					
				</c:if>
			</c:if>
			</td></tr>
			
			     <c:if test="${irregContCheq == '1'}">   
               <tr> <td>Os contracheques n�o apresentaram diverg�ncias ou irregularidades.               
                </c:if>
                </td></tr>
              
               
                <c:if test="${irregContCheq == '3'}">   
                <tr><td>A informa��o referente �s diverg�ncias ou irregularidades nos 
                        contracheques n�o se aplica. (c�pias encaminhadas diretamente para a sede).                 
                </c:if>
            </td></tr>  	
			<c:if test="${secao == 'SEGRA' or secao == 'SGS' or secao == 'SIE'}">
				<tr><td>Os funcion�rios ${confEspecifNao} prestaram os servi�os em conformidade com a especifica��o.
					<c:if test="${confEspecif == '2'}">	
					<br>${jusConfEspecif} 					
					</c:if>
				</td></tr>	
			</c:if>	
			<c:if test="${secao == 'DSEG'}">
				<c:if test="${not empty obsAdicionais}">
					<tr>
						<td>${obsAdicionais}</td>
					</tr>					
				</c:if>					
			</c:if>						
			<c:if test="${secao == 'SGS'}">
				<tr><td>A visita mensal do supervisor da empresa contratada ${visitaSupNao} ocorreu.
					<c:if test="${visitaSup == '2'}">	
						<br>A visita foi avaliada como ${avalVisitaNao}. 		
						<c:if test="${avalVisita == '2' or avalVisita =='3'}">			
							&nbsp;${jusAvalVisita} 					
						</c:if>							
					</c:if>
				</td></tr>
			</c:if>					
			<c:if test="${secao == 'SIE'}">
				<tr><td>Os funcion�rios ${comIdentifNao} est�o devidamente identificados (com crach�).
					<c:if test="${comIdentif == '2'}">
						<br>${obsComIdentif}					
					</c:if>
				</td></tr>	
				<tr><td>Os equipamentos de seguran�a ${equipUtilNao} est�o sendo utilizados.
					<c:if test="${equipUtil == '2'}">
						<br>${ressalvaEquipUtil}					
					</c:if>
				</td></tr>	
				<tr><td>
					<ww:if test="${not empty numChamadosEletr and numChamadosEletr != '0'}">								
						 N�mero de chamados atendidos pelo eletricista: ${numChamadosEletr}				
					</ww:if>
					<ww:else>
						N�o houve abertura de chamados para o eletricista. 
					</ww:else>
				</td></tr>	
				<tr><td>
					<ww:if test="${not empty numChamadosBomb and numChamadosBomb != '0'}">								
						 N�mero de chamados atendidos pelo bombeiro hidr�ulico: ${numChamadosBomb}				
					</ww:if>
					<ww:else>
						N�o houve abertura de chamados para o bombeiro hidr�ulico. 
					</ww:else>
				</td></tr>	
				<tr><td>As rotinas de manuten��o preventiva ${manutPreventNao} est�o sendo realizadas (di�rias, semanais, quinzenais, mensais, semestrais).
					<c:if test="${manutPrevent == '2'}">	
						&nbsp;${jusManutPrevent} 					
					</c:if>
				</td></tr>	
			</c:if>
			<c:if test="${secao == 'SGS' or secao == 'SIE'}">
				<tr><td>${possuiTipoNao} servi�o de ${tipoServico}. 
					<c:if test="${possuiTipo == '2'}">			
						<br>&nbsp; - O cronograma ${cronogramaNao} foi cumprido. 		
						<c:if test="${cronograma == '2'}">			
							&nbsp;&nbsp;${jusCronograma} 					
						</c:if>						
						<br>&nbsp; - A execu��o dos servi�os foi avaliada como ${avalServicoNao}. 		
						<c:if test="${avalServico == '2' or avalServico =='3'}">			
							&nbsp;&nbsp;${jusAvalServico} 					
						</c:if>	
						<br>&nbsp; - A qualidade e quantidade dos equipamentos/insumos foram avaliadas como &nbsp; ${avalEquipNao}. 		
						<c:if test="${avalEquip == '2' or avalEquip =='3'}">			
							&nbsp;&nbsp;${jusAvalEquip} 					
						</c:if>	
					</c:if>
				</td></tr>		
			</c:if>			
		</table>
		<br>
			
<%--		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />  --%>
		
		
		
		<table style="float: none; clear: both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
			<tr>
				<th><b>Informa��es referentes � frequ�ncia de funcion�rios: </b></th>
			</tr>			
			<tr>
				<td>Informo que o(s) funcion�rio(s) tiveram frequ�ncia ${freqFuncTipo} durante o per�odo.</td>
			</tr>	
		</table>						
		<c:if test="${freqFunc eq 'Parcial'}">	
			<table style="float: none; clear: both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
				<c:choose>
				<c:when test="${secao == 'SEGRA' or secao == 'SGS' or secao == 'SIE'}">			
					<c:forEach var="i" begin="1" end="${numCatProfis}">
						<tr><td width="5%">${i}.</td>
							<td width="95%">Categoria profissional: ${requestScope[f:concat('catProfis',i)]}</td>  																
						</tr>
						<tr><td width="5%"></td>
							<td width="95%"> 		
								<ww:if test="${not empty requestScope[f:concat('numFaltas',i)] and requestScope[f:concat('numFaltas',i)] != '0'}">					
									N�mero de faltas sem reposi��o: ${requestScope[f:concat('numFaltas',i)]} 			
								</ww:if>
								<ww:else>
									N�o houve faltas sem reposi��o. 
								</ww:else>	
						</td></tr>
						<tr><td width="5%"></td>	
							<td width="95%"> 		
								<ww:if test="${not empty requestScope[f:concat('quantMinutos',i)] and requestScope[f:concat('quantMinutos',i)] != '0'}">					
									Quantidade de minutos em atrasos sem reposi��o: ${requestScope[f:concat('quantMinutos',i)]}	
								</ww:if>
								<ww:else>
									N�o houve minutos em atrasos sem reposi��o.
								</ww:else>	
						</td></tr>						
					</c:forEach>
				</c:when>				
				<c:when test="${(secao == 'STI') or (secao == 'DSEG' and infSimpl == 'Sim')}">
					<tr><td>	
						<ww:if test="${not empty numFaltas and numFaltas != '0'}">					
								N�mero de faltas sem reposi��o: ${numFaltas} 			
						</ww:if>
						<ww:else>
								N�o houve faltas sem reposi��o. 
						</ww:else>
					</td></tr>				
					<tr><td>	
						<ww:if test="${not empty numFaltas and numFaltas != '0'}">					
								Quantidade de minutos em atrasos sem reposi��o: ${quantMinutos} 			
						</ww:if>
						<ww:else>
								N�o houve minutos em atrasos sem reposi��o.
						</ww:else>
					</td></tr>				
				</c:when>	
				<c:when test="${secao == 'DSEG' and infSimpl == 'N�o'}">
					<c:forEach var="i" begin="1" end="${numFuncParcial}">
						<tr><td width="5%">${i}.</td>
							<td width="95%">Nome do funcion�rio faltoso: ${requestScope[f:concat('nomeFunc',i)]}</td>  																
						</tr>
						<ww:if test="${reposicao == '1'}">						
							<tr><td width="5%"></td>
								<td width="95%">Nome do funcion�rio que cobriu a falta: ${requestScope[f:concat('nomeSubst',i)]}</td></tr>
							<tr><td width="5%"></td>
								<td width="95%">Motivo da aus�ncia: ${requestScope[f:concat('motivo',i)]}</td></tr>
						</ww:if>
						<ww:else>
							<tr><td width="5%"></td>
								<td width="95%">Observa��es: ${requestScope[f:concat('obs',i)]}</td></tr>
						</ww:else>									
					</c:forEach>					
				</c:when>					
				</c:choose>
				<c:if test="${not empty ressalvaFreq}">
					<tr>
						<td colspan="2">${titMemo}: ${ressalvaFreq} </td>
					</tr>
				</c:if>					
			</table>							
		</c:if>		

					
					
							
			
			
			
		
	</mod:documento>
</mod:modelo>
