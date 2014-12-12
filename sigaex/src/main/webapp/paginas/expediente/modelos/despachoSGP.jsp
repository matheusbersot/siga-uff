
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>
	
	
		<mod:grupo>
		<mod:selecao titulo="Se��o" var="secao"
				opcoes="SELEG;SGP;SECAD;SASGP" reler="ajax" idAjax="secaoAjax" />
		</mod:grupo>
		<mod:grupo depende="secaoAjax">
			<ww:if test="${secao != 'SECAD' and secao != 'SASGP'}">
				<mod:selecao titulo="Assunto" var="assunto"
					opcoes="Aus�ncia ao servi�o;Licen�a-paternidade" reler="ajax"
					idAjax="assuntoAjax" />
				<mod:grupo depende="assuntoAjax">
					<c:choose>
						<c:when test="${assunto == 'Aus�ncia ao servi�o'}">
							<mod:selecao titulo="Raz�o" var="razao"
								opcoes="Casamento;Doa��o de Sangue;Falecimento em fam�lia"
								reler="ajax" idAjax="razaoAjax" />
							<mod:grupo depende="razaoAjax">
								<c:if test="${razao == 'Casamento'}">
									<mod:grupo>
										<mod:radio titulo="Sem concomit�ncia com outro afastamento"
											var="concomitancia" valor="1" reler="ajax"
											idAjax="concomitanciaAjax" marcado="Sim" />
										<mod:radio titulo="Concomit�ncia com f�rias"
											var="concomitancia" valor="2" reler="ajax"
											idAjax="concomitanciaAjax" />
										<mod:radio titulo="Indeferimento" var="concomitancia"
											valor="3" reler="ajax" idAjax="concomitanciaAjax" />
									</mod:grupo>
									<c:set var="valConcomitancia" value="${concomitancia}" />
									<c:if test="${empty valConcomitancia}">
										<c:set var="valConcomitancia"
											value="${param['concomitancia']}" />
									</c:if>
									<c:if test="${empty valConcomitancia}">
										<c:set var="valConcomitancia" value="1" />
									</c:if>
									<mod:grupo depende="concomitanciaAjax">
										<c:choose>
											<c:when test="${valConcomitancia == '1' or valConcomitancia == '2'}">
												<%-- Aus�ncia ao servi�o em raz�o de casamento(sem concomit�ncia com outro afastamento ou concomit�ncia com ferias --%>
												<c:if test="${secao == 'SELEG' or secao == 'SGP'}">													
													<mod:data titulo="Per�odo de Aus�ncia" var="dataIni" /> a <mod:data
														var="dataFim" titulo="" />
													<c:if test="${valConcomitancia == '2' and secao == 'SELEG'}">
														<mod:data titulo="Per�odo de F�rias" var="dataFeriasIni" /> a <mod:data
															var="dataFeriasFim" titulo="" />
													</c:if>
												</c:if> 												
											</c:when>
											<c:when test="${valConcomitancia == '3'}"> <%-- Indeferimento --%>
												<c:if test="${secao == 'SELEG' or secao == 'SGP'}">
													<mod:grupo titulo="Causa">
														<mod:grupo largura="30">
															<mod:radio titulo="a aus�ncia de previs�o legal"
																var="causaIndef" valor="1" marcado="Sim" />
														</mod:grupo>
														<mod:grupo largura="70">
															<mod:radio titulo="a irregularidade da documenta��o"
																var="causaIndef" valor="2" />
														</mod:grupo>
													</mod:grupo>
												</c:if>												
												<c:if test="${secao == 'SECAD'}">
													N�O DEFINIDO ??????
												</c:if>
											</c:when>
										</c:choose>
									</mod:grupo>
								</c:if>
								<c:if test="${razao == 'Doa��o de Sangue'}">
									<mod:grupo>
										<c:if test="${secao == 'SELEG' or secao == 'SGP'}">
											<mod:data titulo="Data de doa��o" var="dataDoacao" />
										</c:if>										
									</mod:grupo>
								</c:if>
								<c:if test="${razao == 'Falecimento em fam�lia'}">
									<mod:grupo>
										<mod:grupo largura="50">
											<mod:radio titulo="Sem concomit�ncia com outro afastamento"
												var="concomitancia" valor="1" reler="ajax"
												idAjax="concomitanciaAjax" marcado="Sim" />
											<mod:radio
												titulo="Concomit�ncia com licen�a para tratar da pr�pria sa�de"
												var="concomitancia" valor="2" reler="ajax"
												idAjax="concomitanciaAjax" />
											<mod:radio
												titulo="Concomit�ncia com licen�a por motivo de doen�a em pessoa da fam�lia"
												var="concomitancia" valor="3" reler="ajax"
												idAjax="concomitanciaAjax" />
											<mod:radio titulo="Indeferimento" var="concomitancia"
												valor="4" reler="ajax" idAjax="concomitanciaAjax" />
										</mod:grupo>
										<c:set var="valConcomitancia" value="${concomitancia}" />
										<c:if test="${empty valConcomitancia}">
											<c:set var="valConcomitancia"
												value="${param['concomitancia']}" />
										</c:if>
										<c:if test="${empty valConcomitancia}">
											<c:set var="valConcomitancia" value="1" />
										</c:if>
										<mod:grupo largura="50">
											<mod:grupo depende="concomitanciaAjax">
												<ww:if test="${valConcomitancia != '4'}">
													<mod:data titulo="Per�odo de Aus�ncia" var="dataIni" /> a <mod:data
																		var="dataFim" titulo="" />	
													<c:if test="${secao == 'SELEG'}">					
														<c:if test="${valConcomitancia == '2' or valConcomitancia == '3'}">					
															<mod:data titulo="Per�odo de Licen�a" var="dataLicencaIni" /> a <mod:data
																			var="dataLicencaFim" titulo="" />	
														</c:if>
														<mod:radio
															titulo="Sem exclus�o do parente falecido como dependente do I.R."
															var="exclusaoIR" valor="1" marcado="Sim" reler="ajax" idAjax="exclusaoIRajax" />
														<mod:radio
															titulo="Com exclus�o do parente falecido como dependente do I.R."
															var="exclusaoIR" valor="2" reler="ajax" idAjax="exclusaoIRajax"/>
														<c:set var="valExclusaoIR" value="${exclusaoIR}" />
														<c:if test="${empty valExclusaoIR}">
															<c:set var="valExclusaoIR" value="${param['exclusaoIR']}" />
														</c:if>
														<c:if test="${empty valExclusaoIR}">
														
															<c:set var="valExclusaoIR" value="1" />
														</c:if>	
														<mod:grupo depende="exclusaoIRajax">
															<c:if test="${valExclusaoIR == '2'}"> <%-- com exclus�o do parente falecido do IR --%>
																<mod:texto titulo="N�mero do Processo Administrativo" var="numPA" largura="10"/>
															</c:if>
														</mod:grupo>
													</c:if>
												</ww:if>
												<ww:else> <%-- ${valConcomitancia == '4' --%>
													<c:if test="${secao == 'SELEG' or secao == 'SGP'}">
														<mod:grupo titulo="Causa">
															<mod:grupo largura="30">
																<mod:radio titulo="a aus�ncia de previs�o legal"
																	var="causaIndef" valor="1" marcado="Sim" />
															</mod:grupo>
															<mod:grupo largura="70">
																<mod:radio titulo="a irregularidade da documenta��o"
																	var="causaIndef" valor="2" />
															</mod:grupo>
														</mod:grupo>
													</c:if>												
												</ww:else>
											</mod:grupo>
										</mod:grupo>
									</mod:grupo>
								</c:if>
							</mod:grupo>						  
						</c:when>
						<c:when test="${assunto == 'Licen�a-paternidade'}">
							<mod:grupo>
								<mod:radio titulo="Sem concomit�ncia com outro afastamento"
									var="concomitancia" valor="1" reler="ajax"
									idAjax="concomitanciaAjax" marcado="Sim" />									
								<mod:radio titulo="Indeferimento" var="concomitancia"
									valor="2" reler="ajax" idAjax="concomitanciaAjax" />
							</mod:grupo>
							<c:set var="valConcomitancia" value="${concomitancia}" />
							<c:if test="${empty valConcomitancia}">
								<c:set var="valConcomitancia" value="${param['concomitancia']}" />
							</c:if>
							<c:if test="${empty valConcomitancia}">
								<c:set var="valConcomitancia" value="1" />
							</c:if>
							<mod:grupo depende="concomitanciaAjax">
								<ww:if test="${valConcomitancia == '1'}">
									<c:if test="${secao == 'SELEG' or secao == 'SGP'}">													
										<mod:data titulo="Per�odo de Aus�ncia" var="dataIni" /> a <mod:data	var="dataFim" titulo="" />
									</c:if>	
								</ww:if>
								<ww:else> <%-- ${valConcomitancia == '2'}  Indeferimento --%>
									<c:if test="${secao == 'SELEG' or secao == 'SGP'}">
								<mod:grupo titulo="Causa">
											<mod:grupo largura="30">
												<mod:radio titulo="a aus�ncia de previs�o legal"
													var="causaIndef" valor="1" marcado="Sim" />
											</mod:grupo>
											<mod:grupo largura="70">
												<mod:radio titulo="a irregularidade da documenta��o"
													var="causaIndef" valor="2" />
											</mod:grupo>
										</mod:grupo>
									</c:if>												
									<c:if test="${secao == 'SECAD'}">
										N�O DEFINIDO ??????
									</c:if>
								</ww:else>
							</mod:grupo>	
						</c:when>  
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</mod:grupo>
			</ww:if>
			<ww:else>
				<%-- secao == 'SECAD'  ou == 'SASGP'--%>
				<mod:grupo>
					<c:choose>
						<c:when test="${secao == 'SECAD'}">
							<mod:data titulo="Data de Publica��o" var="dataPubl" />
						</c:when>
						<c:when test="${secao == 'SASGP'}">
							<mod:data titulo="Data de Ci�ncia do Servidor " var="dataCiencia" />
						</c:when>
					</c:choose>					
				</mod:grupo>
			</ww:else>
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
		<c:if test="${tamanhoLetra=='Normal'}">
			<c:set var="tl" value="11pt" />
		</c:if>
		<c:if test="${tamanhoLetra=='Pequeno'}">
			<c:set var="tl" value="9pt" />
		</c:if>
		<c:if test="${tamanhoLetra=='Grande'}">
			<c:set var="tl" value="13pt" />
		</c:if>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			@page {
				margin-left: 3cm;
				margin-right: 2cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
		</style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br />
					<table width="100%">
						<tr>
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight: bold;">DESPACHO N&ordm; ${doc.codigo}</p></td>
						</tr>
						<tr>
							<td align="left"><p style="font-family:Arial;font-size:11pt;font-weight: bold;"><br />REF. ${tipoDeDocumento} N&ordm; ${numero}, ${data} - ${orgao}.</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" />
		FIM CABECALHO -->
		<mod:letra tamanho="${tl}">


			<ww:if test="${secao != 'SECAD' && secao != 'SASGP'}">
				<c:choose>
					<c:when test="${assunto == 'Aus�ncia ao servi�o'}">
						<c:choose>
							<c:when test="${razao == 'Casamento'}">
								<c:choose>
									<c:when test="${concomitancia == '1' or concomitancia == '2'}">
										<%-- Aus�ncia ao servi�o em raz�o de casamento --%>
										<c:choose>
											<c:when test="${secao == 'SELEG'}">											
												<ww:if test="${concomitancia == '1'}">
													<%-- concomit�ncia com f�rias --%>
													<mod:oculto var="textoDespacho"
														valor="Sugiro o deferimento da aus�ncia ao servi�o no per�odo de ${dataIni} a
																		${dataFim}, tendo em vista a regularidade da documenta��o." />

												</ww:if>
												<ww:else>
													<%--${concomitancia == '2' sem concomit�ncia com outro afastamento--%>
													<mod:oculto var="textoDespacho"
														valor="N�o obstante a regularidade da documenta��o, sugiro o deferimento
															da aus�ncia ao servi�o no per�odo de ${dataIni} a ${dataIni}, tendo
															em vista que o(a) servidor(a) esteve em frui��o de f�rias de 
															${dataFeriasIni}a ${dataFeriasFim},n�o havendo previs�o legal para 
															que o per�odo de aus�ncia seja postergado." />
												</ww:else>
											</c:when> 											
											<c:when test="${secao == 'SGP'}"> <%-- o mesmo texto para concomit�ncia = 1 ou = 2 --%> 
												<mod:oculto var="textoDespacho"
														valor="Defiro a aus�ncia no per�odo de ${dataIni} a {dataIni}, nos termos 
														do art. 97, III, �a�, da Lei n� 8.112/90.
														
														� SECAD para as provid�ncias cab�veis. " />
											</c:when>											
										</c:choose>
									</c:when>
									<c:when test="${concomitancia == '3'}"> <%-- Indeferimento --%>
										<c:choose>
											<c:when test="${secao == 'SELEG'}">
												<mod:oculto var="textoDespacho"
														valor="Sugiro o indeferimento da aus�ncia ao servi�o tendo em vista
														${causaIndef}. "/> 
										
											</c:when>
											<c:when test="${secao == 'SGP'}">
												<mod:oculto var="textoDespacho"
														valor="Indefiro tendo em vista ${causaIndef}. 

														� SASGP para cientificar o(a) servidor(a). Ap�s, � SECAD para as provid�ncias cab�veis. "/> 									
											</c:when>
											<c:when test="${secao == 'SECAD'}">
												<%-- Verificar ???? --%>
										
											</c:when>
										</c:choose>
									</c:when>
								</c:choose>	
							</c:when>
							<c:when test="${razao == 'Doa��o de Sangue'}">
								<c:choose>
									<c:when test="${secao == 'SELEG'}">
										<mod:oculto var="textoDespacho"
													valor="Sugiro o deferimento da aus�ncia ao servi�o no dia ${dataDoacao}, tendo em vista a 
													comprova��o da doa��o de sangue, bem como a anu�ncia do superior hier�rquico."/> 
									</c:when>
									<c:when test="${secao == 'SGP'}">
										<mod:oculto var="textoDespacho"
													valor="Defiro a aus�ncia no dia ${dataDoacao}, nos termos do art. 97, I, da Lei n� 8.112/90.

													� SECAD para as provid�ncias cab�veis. "/> 
									</c:when>
								</c:choose>
							</c:when>
							<c:when test="${razao == 'Falecimento em fam�lia'}">
								<ww:if test="${concomitancia != '4'}">
									<c:if test="${concomitancia == '1'}">
										<c:choose>  <%-- PAREI AQUI --%>										
											<c:when test="${secao == 'SELEG'}">	
												<mod:oculto var="textoDespacho"
													valor="Sugiro o deferimento da aus�ncia ao servi�o no per�odo de ___/___/___ a ___/___/___, 
													tendo em vista a regularidade da documenta��o. O(A) falecido(a) n�o era dependente no Imposto 
													de Renda na fonte."/> 
											</c:when>
										</c:choose>
										
									</c:if>
									<c:if test="${secao == 'SELEG'}">					
										<c:if test="${valConcomitancia == '2' or valConcomitancia == '3'}">					
											<mod:data titulo="Per�odo de Licen�a" var="dataLicencaIni" /> a <mod:data
															var="dataLicencaFim" titulo="" />	
										</c:if>
										<mod:radio
											titulo="Sem exclus�o do parente falecido como dependente do I.R."
											var="exclusaoIR" valor="1" marcado="Sim" reler="ajax" idAjax="exclusaoIRajax" />
										<mod:radio
											titulo="Com exclus�o do parente falecido como dependente do I.R."
											var="exclusaoIR" valor="2" reler="ajax" idAjax="exclusaoIRajax"/>
										<c:set var="valExclusaoIR" value="${exclusaoIR}" />
										<c:if test="${empty valExclusaoIR}">
											<c:set var="valExclusaoIR" value="${param['exclusaoIR']}" />
										</c:if>
										<c:if test="${empty valExclusaoIR}">
										
											<c:set var="valExclusaoIR" value="1" />
										</c:if>	
										<mod:grupo depende="exclusaoIRajax">
											<c:if test="${valExclusaoIR == '2'}"> <%-- com exclus�o do parente falecido do IR --%>
													<mod:texto titulo="N�mero do Processo Administrativo" var="numPA" largura="10" />
										</c:if> 
										</mod:grupo>
									</c:if> 
								 
								</ww:if>
							</c:when>
								
						</c:choose>
					</c:when>					
				</c:choose>
			</ww:if>
			<ww:else>
				<%-- secao == 'SECAD'  ou == 'SASGP'--%>
				<c:choose>
					<c:when test="${secao == 'SECAD'}">
						<mod:oculto var="textoDespacho" 
									valor="Publicado no Boletim Interno de ${dataPubl}.

									Providenciados os devidos registros. " />
					</c:when>
					<c:when test="${secao == 'SASGP'}">
						<mod:oculto var="textoDespacho" valor="(a) cientificado(a) em ${dataCiencia}."/> 
					</c:when>
				</c:choose>
				
			</ww:else>


				

				
				
				
				
			



			<span style="font-size: ${tl};">${texto}</span>
			<center>${doc.dtExtenso}</center>
			<p>&nbsp;</p>
			<c:import
				url="/paginas/expediente/modelos/inc_assinatura.jsp?textoFinal=${portDelegacao}" />

			<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->

			<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
		FIM RODAPE -->
		</mod:letra>
		</body>
		</html>
	</mod:documento>
</mod:modelo>

