<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo largura="15">
			<mod:selecao titulo="Se��o" var="secao"
				opcoes="CAMS;SIE;SGS;STI;DSEG" reler="sim" />	 
				<!-- retirado opcao SEGRA, mas as referencias n�o foram retiradas. (06/2012) -->		
		</mod:grupo>
		<mod:oculto var="idOrgaoUsu" valor="${doc.cadastrante.orgaoUsuario.idOrgaoUsu}" />
		<mod:oculto var="unidGestora" valor="${f:buscarLotacaoPorSigla(secao,idOrgaoUsu)}" />	
		<mod:grupo largura="85">								
			<b>${unidGestora}</b>	
		</mod:grupo>	
	
		<c:if test="${secao == 'SIE'}">
			<mod:grupo>
				<mod:pessoa titulo="Gestor" var="gestor" obrigatorio="Sim" reler="sim"/>
			</mod:grupo>
			<c:if test="${not empty requestScope['gestor_pessoaSel.id']}">
 				<c:set var="cargoGestor"
						value="${f:cargoPessoa(requestScope['gestor_pessoaSel.id'])}" />
				<mod:grupo>				
					Cargo/Especialidade: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${cargoGestor}
				</mod:grupo>		
				
			</c:if>		
		</c:if>
		<br>
 	
		<mod:grupo titulo="ATESTO DE SERVI�OS">			
			<mod:grupo largura="30">
				<mod:texto titulo="N� Processo" var="numProcesso" largura="25" obrigatorio="Sim" />
			</mod:grupo>
			<mod:grupo largura="70">
				<c:if test="${secao == 'CAMS' or secao == 'SEGRA'}">
					<mod:selecao titulo="M�s de refer�ncia" var="mes" opcoes="Janeiro;Fevereiro;Mar�o;Abril;Maio;
										Junho;Julho;Agosto;Setembro;Outubro;Novembro;Dezembro" />	
				</c:if>										
			</mod:grupo>				
			<mod:grupo>
				<mod:texto titulo="Nome da Empresa" var="descContrato" largura="72" obrigatorio="Sim" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Descri��o do objeto" var="objeto" largura="70" obrigatorio="Sim" />
			</mod:grupo>
			<ww:if test="${secao != 'SIE'}">
				<mod:grupo>
					<mod:pessoa titulo="Fiscal T�cnico" var="fiscalTec" obrigatorio="Sim"/>
				</mod:grupo>
				<mod:grupo>
					<mod:pessoa titulo="Suplente" var="fiscalSup"  obrigatorio="Sim"/>
				</mod:grupo>
			</ww:if>
			<ww:else>
				<mod:grupo>
					<mod:selecao titulo="Quantidade de fiscais" var="numFiscais" opcoes="1;2;3;4;5;6;7;8;9;10" 
											reler="ajax" idAjax="numFiscaisAjax" />
				</mod:grupo>	
				<mod:grupo depende="numFiscaisAjax">
					<c:forEach var="i" begin="1" end="${numFiscais}">
						<mod:grupo>
							<b>${i}.</b><mod:texto titulo="Fiscal T�cnico" var="tipoFiscal${i}" largura="20" obrigatorio="Sim" />
							<mod:pessoa titulo="" var="fiscalTec${i}" obrigatorio="Sim"/>
						</mod:grupo>
						<mod:grupo>
							&nbsp;&nbsp;&nbsp;<mod:pessoa titulo="Suplente" var="fiscalSup${i}"  obrigatorio="Sim"/>
						</mod:grupo>
					</c:forEach>	
				</mod:grupo>			
			</ww:else>
							
			<c:if test="${secao == 'SIE' or secao == 'SGS' or secao == 'STI' or secao == 'DSEG'}">
				<hr color="#FFFFFF" />
				<mod:grupo>
					<mod:numero titulo="N�mero da Nota Fiscal" var="nota" />
					<mod:monetario titulo="Valor" var="valNota" formataNum="sim" extensoNum="sim"/>  
				</mod:grupo>
				<mod:grupo>
					<mod:data titulo="Per�odo de refer�ncia" var="dataIni" obrigatorio="Sim"/> a <mod:data var="dataFim" titulo="" obrigatorio="Sim"/>
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Ressalvas" var="ressalvaNota" linhas="2" colunas="80" />
				</mod:grupo>
			</c:if>
			<hr color="#FFFFFF" />
			<mod:grupo titulo="O atesto est� sendo encaminhado no prazo (entre o �ltimo dia �til do m�s de compet�ncia e o segundo dia �til do m�s subsequente)?">
				<mod:radio titulo="Sim." var="noPrazo" valor="1" marcado="Sim"
							reler="ajax" idAjax="noPrazoAjax" />
				<mod:grupo largura="7">
					<mod:radio titulo="N�o." var="noPrazo" valor="2" reler="ajax"
							idAjax="noPrazoAjax" />
				</mod:grupo>
				<c:set var="noPrazoVal" value="${noPrazo}" />
				<c:if test="${empty noPrazoVal}">
					<c:set var="noPrazoVal" value="${param['noPrazo']}" />
				</c:if>
				<mod:grupo largura="93">
					<mod:grupo depende="noPrazoAjax">
						<c:if test="${noPrazoVal == 2}">
							<mod:memo titulo="Justificar" var="jusNoPrazo" linhas="3" colunas="70" obrigatorio="Sim" />
							<mod:oculto var="noPrazoNao" valor="n�o"/>	
						</c:if>
					</mod:grupo>						
				</mod:grupo>					
			</mod:grupo>	
			<hr color="#FFFFFF" />
	<%--	<span> AQUI AQUI ${secao}</span>  --%>				
			<ww:if test="${secao == 'CAMS'}">
				<c:import url="/paginas/expediente/modelos/formAtestoFreqFuncCAMS.jsp" /> 				
			</ww:if>
			<ww:else>
				<c:import url="/paginas/expediente/modelos/formAtestoFreqFuncOutros.jsp" /> 	
			</ww:else>	
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
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
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="left" width="40%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">${doc.codigo}</p></td>
							<td align="right" width="60%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">${doc.dtExtenso}</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->
		
		<br>
		<h3 align="center"> CONTRATOS: ATESTO DE SERVI�OS COM FREQU�NCIA DE FUNCION�RIOS </h3><br><br>

		<table style="float: none; clear: both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">
			<tr>
				<td colspan="2">					
					Unidade Gestora: <b>${unidGestora}</b>		
				</td>
			</tr>
			<tr>
				<td width="50%">N� Processo: <b>${numProcesso}</b></td>
				<ww:if test="${secao == 'CAMS' or secao == 'SEGRA'}">
					<td width="50%" align="right">M�s de Refer�ncia: <b>${mes}</b></td>
				</ww:if>
				<ww:else><td width="50%"> </td></ww:else>				
			</tr>
			<tr><td colspan="2">Nome da Empresa: <b>${descContrato}</b></td></tr>
			<tr><td colspan="2">Descri��o do Objeto: <b>${objeto}</b></td></tr>
		</table>
		<br>
		<table style="float: none; clear: both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">	
			<ww:if test="${secao != 'SIE'}">
				<c:if test="${not empty requestScope['fiscalTec_pessoaSel.id']}">
					<tr>
						<td width="75%">Fiscal T�cnico: ${f:maiusculasEMinusculas(requestScope['fiscalTec_pessoaSel.descricao'])}</td>
						<td width="25%" align="right">matr�cula: ${f:pessoa(requestScope['fiscalTec_pessoaSel.id']).matricula}</td>			
					</tr>
					<tr>
						<td width="75%">Suplente: ${f:maiusculasEMinusculas(requestScope['fiscalSup_pessoaSel.descricao'])}</td>
						<td width="25%" align="right">matr�cula: ${f:pessoa(requestScope['fiscalSup_pessoaSel.id']).matricula}</td>			
					</tr>
				</c:if>	
			</ww:if>
			<ww:else>
				<c:if test="${numFiscais > 0}">
					<c:forEach var="i" begin="1" end="${numFiscais}">
					    <c:set var="tec"
							value="${f:pessoa(requestScope[f:concat(f:concat('fiscalTec',i),'_pessoaSel.id')])}" />
						<c:set var="sup"
							value="${f:pessoa(requestScope[f:concat(f:concat('fiscalSup',i),'_pessoaSel.id')])}" />
						<tr>
							<td width="5%">${i}.</td>
							<td width="70%">Fiscal T�cnico ${requestScope[f:concat('tipoFiscal',i)]}: ${f:maiusculasEMinusculas(tec.descricao)}</td>
							<td width="25%" align="right">matr�cula: ${tec.matricula}</td>			
						</tr>
						<tr>
							<td width="5%"></td>
							<td width="70%">Suplente: ${f:maiusculasEMinusculas(sup.descricao)}</td>
							<td width="25%" align="right">matr�cula: ${sup.matricula}</td>			
						</tr>
					</c:forEach>
				</c:if>	
			</ww:else>	
		</table>
		<br>
		<table style="float: none; clear: both" width="100%" border="0" align="left" cellspacing="0" cellpadding="5">				
			<c:if test="${secao == 'SIE' or secao == 'SGS' or secao == 'STI' or secao == 'DSEG'}">
				<tr>
					<ww:if test="${not empty nota}">					
						<td>Nota Fiscal: ${nota}</td>
						<td>Per�odo: ${dataIni} a ${dataFim}</td>
					</ww:if>						
					<ww:else>
						<td colspan="2">Per�odo: ${dataIni} a ${dataFim}</td>
					</ww:else>	
				</tr>			
				<c:if test="${not empty nota}">
					<tr>						
						<td colspan="2">Valor: ${valNota}&nbsp;
								(${requestScope[f:concat('valNota','vrextenso')]})</td>						
					</tr>
				</c:if>
				<c:if test="${not empty ressalvaNota}">
					<tr><td colspan="2">${ressalvaNota}</td></tr>
				</c:if>
			</c:if>
			<tr>
				<td colspan="2">
				    O atesto ${noPrazoNao} est� sendo encaminhado no prazo (entre o �ltimo dia �til do m�s de compet�ncia e o segundo dia �til do m�s subsequente)
					<ww:if test="${noPrazo == '2'}">
						${jusNoPrazo}
					</ww:if>
					<ww:else>.</ww:else>	
				</td>
			</tr>			
		</table>
		<br>
		
		<ww:if test="${secao == 'CAMS'}">
				<c:import url="/paginas/expediente/modelos/formAtestoFreqFuncCAMS.jsp" /> 				
			</ww:if>
			<ww:else>
				<c:import url="/paginas/expediente/modelos/formAtestoFreqFuncOutros.jsp" /> 	
			</ww:else>	
		
		<br><br><br> 

		<p align="left"> Atenciosamente,  </p>
		 <br>
		 
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp" />

		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />

		</body>
		</html>
	</mod:documento>
</mod:modelo>
