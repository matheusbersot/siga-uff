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
		<mod:grupo>
			<mod:texto var="dtposse" titulo="Data da posse" largura="5"/>
		</mod:grupo>
		<mod:grupo>
			<mod:texto var="dtexercicio" titulo="Data do exerc�cio" largura="5"/>
		</mod:grupo>
		<mod:grupo>
			<mod:mensagem titulo="Deseja usufruir do benef�cio Aux�lio Alimenta��o ? " />
			<mod:selecao titulo="" var="resp1" opcoes="  ;desejo;n�o desejo" />		
		</mod:grupo>
		<mod:grupo>
			<mod:mensagem titulo="Acumula cargo ou emprego publico ? " />
			<mod:selecao titulo="" var="resp2" opcoes="  ;N�O ACUMULO CARGO OU EMPREGO P�BLICO;ACUMULO CARGO OU EMPREGO P�BLICO" />		
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
			
			<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#000000">
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
				
				<tr>
					<td bgcolor="#FFFFFF" width="60%">Data da posse: ${dtposse}</td>
					<td bgcolor="#FFFFFF" width="40%">Data do exerc�cio: ${dtexercicio}</td>			
				</tr>
				
			</table>
			<table width="100%" border="1" cellpading="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td>Ac�mulo de cargo ou emprego p�blico: ${resp2}</td>
				</tr>
			</table>
			<br>
	 		<table width="100%" border="1" bgcolor="#FFFFFF">
			  <tr>	
				  <td>  
				      <p style="margin-left: 5%"> Nos termos da resolu��o n� 323, 10/07/2003, publicada no DOU, que regulamentou a <br> concess�o do Aux�lio-alimenta��o, no �mbito do Conselho e da Justi�a Federal de primeiro e segundo <br>graus, DECLARO que <b><u>${resp1} </u></b> usufruir do benef�cio Aux�lio-alimenta��o.</p>
					  <br>                                                
				      <p style="margin-left: 5%"> Declaro ter ci�ncia que no caso de acumula��o l�cita de cargo ou emprego p�blico  farei jus � <br> percep��o de apenas um Aux�lio-alimenta��o, mediante op��o e que de acordo com o Art. 2�, �tem I, da referida <br> Resolu��o, os servidores CEDIDOS ou REQUISITADOS dever�o apresentar declara��o fornecida pelo <br> �rg�o de origem ou por aquele onde presta servi�o, de que n�o percebe aux�lio da natureza id�ntica. </p>
				      <br>
				  </td>                                                   
         																																																																					
         	   </tr>
         	</table>
         	<br>
         			
         	<table width="100%" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<td width="100%">OBSERVA��ES</td>
				</tr>
			</table>
			
			<table width="100%" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
			<tr>  <td>
					<p> Art.  9� O servidor que acumule licitamente cargos ou empregos fara jus � percep��o de apenas um aux�lio-<br>alimenta��o mediante op��o<br>
					</p>
				    </b>
					<p> Art. 10� Para habilitar-se a receber o aux�lio-alimenta��o, o servidor dever� preencher formul�rio pr�prio de <br>cadastramento e, se for o caso, apresentar:</p>
					</br>
					<p> I - em se tratando de requisitado ou cedido, declara��o de outro �rg�o informando que n�o percebe o<br> benef�cio; e </p>
					</br>
					<p> II - na hip�tese de acumula��o l�cita de cargo p�blico, declara��o do outro �rgao informando que o servidor <br> n�o percebe aux�lio de natureza id�ntica. </p>
					</br>
					<p> � 1� Na hip�tese do inciso I deste artigo, no caso de optar o servidor por receber o aux�lio alimenta��o de <br> �rg�o diverso do que paga a sua remunera��o, o valor do benef�cio ser� creditado em sua conta corrente. </p>
					</br>
					<p> � 2� A desist�ncia da percep��o do aux�lio-alimenta��o, a solicita��o de reinclus�o e qualquer altera��o na <br> situa��o de optante e n�o optante dever�o ser formalizadasjunto � �rea competente. </p>
					</br>
			        <p> Art. 11 O aux�lio-alimenta��o a ser concedido ao servidor cuja jornadas de trabalho <br> seja inferior a trinta horas <br> semanais corrsponder� a cinq�enta por cento do valor fixado para o benef�cio. </p>
			        </br>
			        <p> � 1� Ocorrendo a acumula��o de cargos a que alude o art, 9� e sendo a soma das jornadas de trabalho superior a trinta horas semanais, o servidor perceber� o aux�lio pelo seu valor integral, a ser pago pelo �rg�o <br> ou entidade de sua op��o.
			        </p>
			        <br> 				
				  </td>
			</tr>
			</table>
			<br>
			
         	<table width="100%" border="0" cellpadding="2" cellspacing="1" align="center" bgcolor="#FFFFFF">
         		<tr>
         			<td>
         			<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp"/>
         			</td>         		
				</tr>
			</table>
		    <br>
		    <br>
					<table width="100%" align="left">		
						<tr>
							<td>5 - SE��O DE BENEF�CIOS</td>
						</tr>
						<tr>
							<td>
							<br/>
								Inclu�do por:___________________________________________  em:____/____/____ 
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

