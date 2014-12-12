<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
	<mod:grupo titulo="1 - Dados do benefici�rio">
			<mod:pessoa var="nome" titulo="Nome"/>
		<mod:grupo>
			<mod:lotacao var="lotacao" titulo="Lota��o"/>
		</mod:grupo>
		<mod:grupo>
			<mod:texto var="ramal" titulo="Ramal" largura="5"/>
		</mod:grupo>
	</mod:grupo>
	<mod:grupo titulo="2 - Dados do profissional referenciado">
			<mod:texto var="nomemed" titulo="Nome" largura="50"/> 
			<mod:selecao titulo="Tipo de esp�cialidade" var="psi" opcoes="Psiquiatra;Psicoterapeuta" />
		<mod:grupo>
			<mod:texto var="crmcrp" titulo="CRM / CRP" largura="10"/>
			<mod:texto var="cpf" titulo="CPF" largura="15"/>
		</mod:grupo>
		
		<mod:grupo>
			<mod:texto var="endereco" titulo="Endere�o" largura="50"/>
		</mod:grupo>
		<mod:grupo>
			<mod:texto var="telefone" titulo="Telefone" largura="13"/>
		</mod:grupo>
	</mod:grupo>
	
	</mod:entrevista>
	<mod:documento>	
		<c:set var="tl" value="6pt" />		
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			@page {
				margin-left: 3cm;
				margin-right: 3cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
		</style>
		</head>
	<body>
	<mod:letra tamanho="${tl}">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" width="100%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">INCLUS�O NO PROGRAMA DE APOIO � PSIQUIATRIA E PSICOLOGIA (PAPSI)</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>       
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%">
					1- DADOS DO BENEFICI�RIO</td>
				</tr>
			</table>
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="60%">Nome: ${requestScope['nome_pessoaSel.descricao']}</td> 
					<td bgcolor="#FFFFFF" width="40%">Matr�cula: ${requestScope['nome_pessoaSel.sigla']}</td>
				</tr>
			</table>
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%">Cargo: ${f:cargoPessoa(requestScope['nome_pessoaSel.id']) }</td>
				</tr>
			</table>
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="60%">Lota��o: ${requestScope['lotacao_lotacaoSel.descricao']}</td>
					<td bgcolor="#FFFFFF" width="40%">Ramal: ${ramal }</td>
				</tr>
			</table>
	 		<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%">2 - DECLARA��O DO SERVIDOR<br></td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" width="100%" align="justify"><br><font size='0.1'>a) Declaro estar ciente dos</font> termos da IN--23-09, de 19/10/2004, que disp�e sobre o programa de Apoio � Psiquiatria e Psicologia, oferecido pelo Tribunal Regional Federal da 2� Regi�o e Se��es Judici�rias Jurisdicionadas, a fim de possibilitar um tratamento adequado �s necessidades dos servidores<br><br>
																	   b) Declaro ter ci�ncia de que o reembolso ser� parcial, podendo ser acumulado com reembolso do Plano de Sa�de Externo, e que o valor reembolsado ser� fixado pela presid�ncia do Tribunal, equivalente , no m�ximo a 50% (cinq�nta por cento) do respectivo valor de consulta/sess�o, sempre condicionada a exist�ncia de dota��o or�ament�ria  para o Tribunal e Se��es Judici�rias.<br><br>
					                                                   c) Declaro ter ci�ncia, para fins de ressarcimento, que deverei obter do profissional referenciado o recibo mensal de pagamento das consultas, emitido em nome do servidor, no qual dever� constar: <b><u>Nome completo do profissional, seu n�mero de CPF, n�mero de inscri��o no CRM ou CRP(conforme o caso), numero de sess�es realizadas no m�s, (com as respectivas datas em que foram realizadas) e valor total do recibo</u></b>.<br><br>
					                                                   d) Tenho ci�ncia que deverei apresentar a c�pia do recibo na Se��o de Benef�cios, at� o 5� dia do m�s subseq�ente ao da realiza��o das consultas/sess�es, mediante apresenta��o do original para fins de confer�ncia pelo Setor.<br><br>
					                                                   e) Tenho ci�cia que, em caso de f�rias, licen�as ou afastamentos autorizados, terei o prazo de at� 30 dias, ap�s o retorno, para a entrega do recibo e que na hip�tese de entrega do recibo fora do prazo estabelecido, deverei submeter o pedido � Administra��o, mediante justificativa por escrito e manifesta��o do Servi�o M�dico ou Psicol�gico.<br><br>
					                                                   f) Declaro ter ci�ncia de que a dura��o do benef�cio ser� estipulada em dois anos; findo os quais o Servi�o M�dico/Psicol�gico  podera prorrog�-lo, no m�ximo, mais 2 (dois) anos.<br><br>
					                                                   g) Declaro, ainda, ter ci�ncia de que ao n�o apresentar os recibos na SEBEN/SRH, no per�odo de 2 meses, e n�o tenha interrompido o meu tratamento, apresentarei uma justificativa por escrito, para a CAMS/SRH, esclarecendo os motivos, pois a partir do terceiro m�s consecutivo serei, automaticamente, exclu�do do Programa por desist�ncia.<br><br>
					                                                   h) Declaro ter ci�ncia de que terei o prazo de 15 dias, a partir da data do encaminhamento, para realizar minha primeira consulta psiqui�trica/sess�o de psicoterapia.<br>                                                 
         																																																																				
         			</td>
         			</tr>
         			</table>
         			<table width="100%" border="0" cellpadding="2" cellspacing="1" align="center">
         			<tr>
         			<td>
         			<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp"/>
         			</td>         		
				</tr>
			</table>
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%">3 - DADOS DO PROFISSIONAL REFERENCIADO</td>
				</tr>
			</table>
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="50%">Nome: ${nomemed}</td>
					<td bgcolor="#FFFFFF" width="50%"><c:if test="${psi eq 'Psiquiatra'}">PSIQUIATRA</c:if>
					<c:if test="${psi eq 'Psicoterapeuta'}">PSICOTERAPEUTA</c:if></td>			
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" width="50%">CRM / CRP: ${crmcrp}</td>
					<td bgcolor="#FFFFFF" width="50%">CPF: ${cpf}</td>			
				</tr>
				</table>
				<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%">Endere�o: ${endereco}</td>			
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" width="100%">Telefone: ${telefone}</td>			
				</tr>
			</table>
			<table width="100%" bordercolor="#FFFFFF" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%">4 - SETOR DE PSICOLOGIA/PSIQUIATRIA</td>
				</tr>
			</table>
			<table width="100%" border="1" cellpadding="8" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="100%"  align="justify">O servidor _________________________________________________ est� autorizado a fazer inscri��o no benef�cio PAPSI.</td>
				</tr>
			</table>
			
			<table width="100%" bordercolor="#FFFFFF" cellpadding="2" cellspacing="1">	
				<tr>
					<td align="right">
					${doc.dtExtenso}<br><br>
					______________________________________<br>
									(Assinatura Psiquiatra/Psic�logo)<br><br>
					<table width="40%" align="left">		
						<tr>
							<td>5 - SE��O DE BENEF�CIOS</td>
						</tr>
						<tr>
							<td>
							<br/>
								Inclu�do por:__________em:____/____/____ 
							</td>												
						</tr>
					</table>
					</td>
				</tr>			
			</table>
			
						
				
				
				<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />				
	</mod:letra>
	</body>
	</html>
	</mod:documento>
</mod:modelo>

