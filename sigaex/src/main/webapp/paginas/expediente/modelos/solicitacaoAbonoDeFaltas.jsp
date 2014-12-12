<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de SOLICITA��O DE ABONO DE FALTAS
	POR MOTIVO DE DOEN�A sem vinculo com ADM P�blica - Ultima Altera��o 09/04/2008 
 -->

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="DETALHES DA LICEN�A">
			<mod:selecao titulo="Atestado em anexo de" var="tipoAtestado"
				opcoes="m�dico da SJRJ;m�dico externo" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Endere�o" largura="85" maxcaracteres="80"
				var="endereco" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Tel Residencial" largura="15" maxcaracteres="13"
				var="telResidencial" />
			<mod:texto titulo="Celular" largura="15" maxcaracteres="13"
				var="telCelular" />
			<mod:texto titulo="Ramal" largura="10" maxcaracteres="10"
				var="ramalLotacao" />
		</mod:grupo>
		<mod:grupo titulo="Per�odo Solicitado">
			<mod:data titulo="De" var="dataInicio${i}" />
			<mod:data titulo="a" var="dataFim${i}" />
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
@page {
	margin-left: 2cm;
	margin-right: 3cm;
	margin-top: 1cm;
	margin-bottom: 1cm;
}
</style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		</td></tr><tr><td></tr></td>
		</table>
	
		FIM PRIMEIRO CABECALHO -->

		<table width="100%" border="0" cellpadding="2" cellspacing="0"
			bgcolor="#ffffff">
			<tr>
				<td>
				<p style="font-size: 12pt; text-align: left; font-weight: bold"><b>SOLICITA��O
				DE ABONO DE FALTAS</b></p>
				</td>
			</tr>
			<tr>
				<td>
				<p style="font-size: 12pt; text-align: left"><b>POR MOTIVO
				DE DOEN�A</b></p>
				</td>
			</tr>
			<tr>
				<td>
				<p style="font-size: 9pt; text-align: left"></p>
				</td>
			</tr>
			<tr>
				<td>
				<p style="font-size: 9pt; text-align: left"><b>SERVIDOR
				OCUPANTE EXCLUSIVAMENTE DE CARGO EM</b></p>
				</td>
			</tr>
			<tr>
				<td>
				<p style="font-size: 9pt; text-align: left"><b>COMISS�O /
				SEM V�NCULO COM A ADMINISTRA��O P�BLICA</b></p>
				</td>
			</tr>
			<tr>
				<td>
				<p style="font-size: 11pt; text-align: left"><b> Atestado em
				anexo:&nbsp;&nbsp;&nbsp;&nbsp; <c:choose>
					<c:when test="${tipoAtestado eq 'm�dico da SJRJ'}">
				[x] de m�dico da SJRJ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;] de m�dico externo
			</c:when>
					<c:otherwise>
				[&nbsp;&nbsp;] de m�dico da SJRJ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[x] de m�dico externo
			</c:otherwise>
				</c:choose></p>
				</td>
			</tr>
		</table>
		<br />
		<table width="100%" border="1" cellpadding="3"
			style="border: 1px solid black">
			<tr><td colspan="2" style="background-color: #C0C0C0"><b>SERVIDOR</b></td></tr>
			<tr>
				<td width="70%">Nome: <b>${doc.subscritor.descricao}</b></td>
				<td width="30%">Matr�cula: <b>${doc.subscritor.matricula}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3"
			style="border: 1px solid black">
			<tr>
				<td width="30%">Lota��o: <b>${doc.subscritor.lotacao.descricao}</b></td>
				<td width="70%">Cargo: <b>${doc.subscritor.cargo.nomeCargo}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3"
			style="border: 1px solid black">
			<tr>
				<td>Endere�o: <b>${endereco}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3"
			style="border: 1px solid black">
			<tr>
				<td>Tel Residencial: <b>${telResidencial}</b></td>
				<td>Tel Celular: <b>${telCelular}</b></td>
				<td>Ramal da Lota��o: <b>${ramalLotacao}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3"
			style="border: 1px solid black">
			<tr>
				<td width="40%" align="center">Per�odo Solicitado: a <b>${dataInicio}</b>
				De <b>${dataFim}</b></td>
			</tr>
		</table>
		<table width="100%" border="1">
			<tr>
				<td width="50%" valign="top">Local e Data:<br />
				${doc.dtExtenso}<br />
				<br />
				<br />
				<br />
				</td>
				<td width="50%" valign="top">Assinatura do(a) Servidor(a)<br />
				<br />
				<br />
				<br />
				</td>
			</tr>
		</table>
		<table width="100%" cellpadding="3" border="1">
			<tr>
				<td style="background-color: #C0C0C0"><b> OBSERVA��ES </b></td>
			</tr>
			<tr>
				<td>
				<p align="justify" style="font-size: 8pt; line-height: 90%;">Dever�
				ser anexado ao presente formul�rio atestado m�dico dentro de
				envelope lacrado, com identifica��o de "confidencial", e encaminhado
				� SESAU/SRH ou �s SEAPOs no prazo de 3 (tr�s) dias �teis apartir do
				1� dia do afastamento.</p><br /><br />
				<p align="justify" style="font-size: 8pt; line-height: 90%;">Somente
				ser�o aceitos formul�rios com assinatura do servidor e de seu
				superior hier�rquico, com carimbo de identifica��o.
				</p><br /><br />
				<p align="justify" style="font-size: 8pt; line-height: 90%;"><b>O
				atestado firmado por m�dico externo</b>, de forma leg�vel, sem rasuras e
				em receitu�rio adequado, dever� conter: nome completo do servidor;
				diagn�stico definitivo ou prov�vel, codificado (CID-10) ou por
				extenso; per�odo de afastamento recomendado e nome completo do
				m�dico; assinatura, carimbo e n� de registro do CRM.
				</p><br /><br />
				<p align="justify" style="font-size: 8pt; line-height: 90%;">Caso
				sejam concedidos ao servidor <b>licen�as ou afastamentos durante
				o per�odo de f�rias</b>, estas ser�o suspensas e o per�odo remanescente
				ser� remarcado pela SRH, indicando-se no 1� dia imediatamente
				posterior ao termino da licen�a ou afastamento.
				</p><br /><br />
				<p align="justify" style="font-size: 8pt; line-height: 90%;">As
				faltas por motivo de doen�a poder�o ser abonadas pela SJRJ at� o
				prazo de 15 dias (ininterruptos). Ultrapassado esse prazo, o
				servidor ser� encaminhado � per�cia m�dica da Previd�ncia Social
				(Base legal: arts. 59 e 60, �� 3� e 4� da Lei n� 8.213/91).
				</p><br /><br />
				<p align="justify" style="font-size: 8pt; line-height: 90%;">Se
				o servidor retornar a atividade no 16� dia e, dentro de 60 dias
				desse retorno, precisar se afastar de novo, em virtude da mesma
				doen�a, n�o caber� abono de faltas, mas, sim, aux�lio doen�a. (Base
				legal: art. 75 �� 4� e 5� Decreto 3048/99).
				</p><br /><br />
				<p align="justify" style="font-size: 8pt; line-height: 90%;">Se
				retornar antes de completar o prazo m�ximo para o abono de faltas
				(15 dias) e, dentro de 60 dias desse retorno, precisar se afastar de
				novo, em virtude da mesma doen�a, caber� o abono das faltas
				restantes at� o per�odo m�ximo de 15 dias. A partir do dia seguinte
				que completar esse per�odo (15 dias), somente caber� aux�lio-doen�a.
				(Base legal: art. 75 �� 4� e 5� Decreto 3048/99).
				</p>
				</td>
			</tr>
			<tr>
				<td style="background-color: #C0C0C0"><b>CHEFIA</b></td>
			</tr>
		</table>
		<table width="100%" border="1">
			<tr>
				<td valign="top">
				<p align="left" style="font-size: 8pt;"><b>Observa��es da
				chefia para a per�cia m�dica</b><br />
				(preenchimento obrigat�rio, mesmo que seja com "nada a declarar").<br />
				<br />
				OBS:<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				</p>
				</td>
				<td align="center" valign="top">
				<p style="font-size: 8pt;">�ltimo dia de trabalho do servidor:<br />
				<br />
				<br />
				_______/_______/_______<br />
				Carimbo e assinatura da chefia<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				</p>
				</td>
			</tr>
		</table>
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
	</mod:documento>
</mod:modelo>
