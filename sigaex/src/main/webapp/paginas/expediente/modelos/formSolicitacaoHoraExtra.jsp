<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>


<mod:modelo>
	<mod:entrevista>
		<mod:grupo>		
			<mod:selecao titulo="N�mero de servidores a serem inclu�dos"
				var="numIncluidos"
				opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20"
				reler="ajax" idAjax="numIncluidosAjax" />
			<mod:grupo depende="numIncluidosAjax">
				<c:forEach var="i" begin="1" end="${numIncluidos}">
					<mod:grupo>
						<b>Dados do ${i}� servidor que prestar� hora extra:</b>
						<mod:grupo>
							<mod:pessoa titulo="Matr�cula" var="servidor${i}" />
						</mod:grupo>
						<mod:grupo>
							<mod:selecao
								titulo="N�mero de datas a serem inclu�das para o servidor"
								var="numDatas${i}" opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15"
								reler="ajax" idAjax="numDatasAjax${i}" />
						</mod:grupo>
						<mod:grupo depende="numDatasAjax${i}">
							<c:forEach var="j" begin="1" end="${requestScope[f:concat('numDatas',i)]}">
								<mod:grupo>
									<mod:data titulo="Data" var="data${i}${j}"></mod:data> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						    		 <mod:hora titulo="Hor�rio" var="horaini${i}${j}" /> hs �s  <mod:hora var="horafim${i}${j}" titulo=""/> hs
								</mod:grupo>
							</c:forEach>
						</mod:grupo>
					</mod:grupo>
				</c:forEach>
			</mod:grupo>
		</mod:grupo>
		<mod:grupo>
			<mod:memo colunas="70" linhas="3"
				titulo="As horas-extras acima mostram-se necess�rias (MANIFESTA��O FUNDAMENTADA)"
				var="motivo" />
		</mod:grupo>
		<mod:grupo>
			<mod:selecao titulo="Horas extras trabalhadas" var="tipoHoraExtra"
				opcoes="em dias �teis;em fins de semana/feriados" />
		</mod:grupo>
		<mod:grupo>
			<mod:memo colunas="70" linhas="2" titulo="As mencionadas tarefas n�o podem ser realizadas 
			durante o expediente regulamentar, eis que <br> (MANIFESTA��O FUNDAMENTADA)"
				var="justificativa" />
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
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<table width="100%">
						<tr><br /><br /><br /></tr>
						<tr>
							<td align="right"><font style="font-family:Arial;font-size:11pt;font-weight:bold;">
							SOLICITA��O N&ordm; ${doc.codigo}</font></td>
						</tr>	
						<tr>
							<td align="right"><font style="font-family:Arial;font-size:11pt;font-weight:bold;">
							${doc.dtExtenso}</font></td>
						</tr>											
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" />
		FIM CABECALHO -->

		
		<p style="font-size: 11pt; text-indent: 3cm; font-weight: bold;">Exmo.
		Juiz Federal - Diretor do Foro,</p>
		<br />
		<p style="text-align: justify; text-indent: 3cm;">Solicito
		autoriza��o para presta��o de servi�o extraordin�rio segundo a escala
		abaixo discriminada, com vista ao pagamento do respectivo adicional,
		de acordo com os artigos 42 e seguintes da Resolu��o n� 4/2008, do
		Conselho da Justi�a Federal.</p>
		<br />

		<table width="100%" align="center" border="1" cellpadding="2"
			cellspacing="1" bgcolor="#000000">
			<tr>
				<td bgcolor="#FFFFFF" width="20%" align="center">Servidor</td>
				<td bgcolor="#FFFFFF" width="09%" align="center">Matr�cula</td>
				<td bgcolor="#FFFFFF" width="20%" align="center">Cargo
				Efetivo/Fun��o Comissionada</td>
				<td bgcolor="#FFFFFF" width="11%" align="center">Data</td>
				<td bgcolor="#FFFFFF" width="10%">Hor�rio</td>
			</tr>
		</table>
		<c:forEach var="i" begin="1" end="${numIncluidos}">
			<c:set var="servidorX"
				value="${requestScope[f:concat(f:concat('servidor',i),'_pessoaSel.id')]}" />
			<table width="100%" align="center" border="1" cellpadding="2"
				cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" width="20%" align="center">${f:maiusculasEMinusculas(f:pessoa(servidorX).nomePessoa)}</td>
					<td bgcolor="#FFFFFF" width="09%" align="center">${f:pessoa(servidorX).matricula}</td>
					<td bgcolor="#FFFFFF" width="20%" align="center">${f:maiusculasEMinusculas(f:pessoa(servidorX).cargo.nomeCargo)}&nbsp;
					${f:maiusculasEMinusculas(f:pessoa(servidorX).funcaoConfianca.nomeFuncao)}</td>
					<c:forEach var="j" begin="1"
						end="${requestScope[f:concat('numDatas',i)]}">
						<ww:if test="${j == 1}">
							<td bgcolor="#FFFFFF" width="11%" align="center">${requestScope[f:concat(f:concat('data',i),j)]}</td>
							<td bgcolor="#FFFFFF" width="10%">${requestScope[f:concat(f:concat('horario',i),j)]}</td>
						</ww:if>
						<ww:else>
							<tr>
								<td bgcolor="#FFFFFF" width="20%" align="center">${f:maiusculasEMinusculas(f:pessoa(servidorX).nomePessoa)}</td>
								<td bgcolor="#FFFFFF" width="09%" align="center">${f:pessoa(servidorX).matricula}</td>
								<td bgcolor="#FFFFFF" width="20%" align="center">${f:maiusculasEMinusculas(f:pessoa(servidorX).cargo.nomeCargo)}&nbsp;
								${f:maiusculasEMinusculas(f:pessoa(servidorX).funcaoConfianca.nomeFuncao)}
								<td bgcolor="#FFFFFF" width="11%" align="center">${requestScope[f:concat(f:concat('data',i),j)]}</td>
								<td bgcolor="#FFFFFF" width="10%">${requestScope[f:concat(f:concat('horario',i),j)]}</td>
							</tr>
						</ww:else>
					</c:forEach>

				</tr>
			</table>
		</c:forEach>
	
		<p style="text-align: justify; text-indent: 3cm;">As horas-extras
		acima mostram-se necess�rias &nbsp;${motivo}</p>
		<c:if test="${tipoHoraExtra eq 'em fins de semana/feriados'}">
			<c:set var="tampouco" value="tampouco em dias �teis," scope="request" />
		</c:if>
		<p style="text-align: justify; text-indent: 3cm;">As mencionadas
		tarefas n�o podem ser realizadas durante o expediente regulamentar,
		${tampouco} eis que &nbsp;${justificativa}</p>

		<p style="text-align: justify; text-indent: 3cm;">Na hip�tese de
		deferimento, comprometo-me a encaminhar � Subsecretaria de Gest�o de
		Pessoas a ficha individual de frequ�ncia de servi�o extraordin�rio
		preenchida, bem como atestada por mim e pela chefia imediata do(s)
		respectivo(s) servidor(es) at� o 2� dia �til do m�s subsequente ao da
		presta��o do servi�o, nos termos do artigo 49 da Resolu��o
		supramencionada.</p>

		<br />

		<p style="text-align: justify; text-indent: 3cm;">Atenciosamente,</p>


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
