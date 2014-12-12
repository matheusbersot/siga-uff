<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="">
			<br/>
				<mod:grupo>
						<mod:lotacao titulo="Unidade Organizacional" var="unidade"/>
				</mod:grupo>
				<mod:grupo>
					<mod:pessoa titulo="Matr�cula do Supervisor do est�gio" var="supervisor"/> 
				</mod:grupo>
				<br/>
				<mod:grupo>
					<mod:texto titulo="�rea de forma��o do estagi�rio" var="area" largura="30" />
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Proposta de trabalho com justificativa" var="proposta" colunas="80" linhas="3"/> 
				</mod:grupo>
				<mod:grupo>
				Descri��o sucinta das atividades a serem realizadas pelo estagi�rio.
				<span style="color:red"> A ATUA��O PREVISTA PARA O ESTAGI�RIO DE N�VEL M�DIO, 
				INDEPENDENTEMENTE DA ESPECIALIDADE, REFERE-SE MAIS DIRETAMENTE �S ATIVIDADES RELACIONADAS �S ROTINAS DE TRABALHO DO DIA A DIA. </span>
					<mod:memo titulo="" var="atividades" colunas="80" linhas="3"/>
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Objetivos educacionais para o estagi�rio (quanto � complementa��o do ensino profissional pelo desempenho das atividades; desenvolvimento de rela��es interpessoais; etc.)" var="objetivos" colunas="80" linhas="3"/>
				</mod:grupo>
				<mod:grupo>
				Resultados previstos para o Projeto/Programa.
				<span style="color:red"> EVENTUALMENTE, O ESTAGI�RIO DE N�VEL M�DIO PODER� SER SOLICITADO 
				PARA COLABORAR EM PROJETO/PROGRAMA ESTRAT�GICO. NESSE CASO, ESTE CAMPO DEVER� SER PREENCHIDO, 
				DEVENDO TAMB�M CONSTAR A INDICA��O DO RESPECTIVO PROJETO/PROGRAMA. </span>
					<mod:memo titulo="" var="resultados" colunas="80" linhas="3"/>
				</mod:grupo>
				<mod:grupo>
				Crit�rio(s) previsto(s) para avalia��o dos resultados.
					<span style="color:red"> CAMPO A SER PREENCHIDO NO CASO DE O ESTAGI�RIO DE N�VEL M�DIO SER SOLICITADO 
					PARA COLABORAR EM PROJETO/PROGRAMA ESTRAT�GICO. </span>
					<mod:memo titulo="" var="criterios" colunas="80" linhas="3"/>
				</mod:grupo>
				<br />
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
@body {
	margin-top: 6cm;
	margin-bottom: 0.5cm; 
}
@first-page-body {
	margin-top: 6cm;
	margin-bottom: 0.5cm; 
}
		</style>
		</head>
		<body>
		<!-- FOP -->
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina2.jsp" />
		</td></tr><tr><td></tr></td>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
				<br/><br/>
					<table width="100%">
						<tr>
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">SOLICITA&Ccedil;&Atilde;O DE ESTAGI&Aacute;RIO DE N&Iacute;VEL M&Eacute;DIO PARA A &Aacute;REA DE ADMINISTRA&Ccedil;&Atilde;O <br/>- CAPITAL - 	
<br /><br />N&ordm; ${doc.codigo}</p>	</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda2.jsp" />
		FIM CABECALHO -->
		<br />
		
<table width="450" border="1" cellpadding="2" cellspacing="1" align="center">
  <tr style="background-color: gray">
    <td bordercolor="#000000">Unidade Organizacional:</td>
  </tr>
  <tr >
    <td bordercolor="#000000"><div align="justify"><b>${requestScope['unidade_lotacaoSel.descricao']}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">&Aacute;rea de forma&ccedil;&atilde;o do estagi&aacute;rio:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${area}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Proposta de trabalho com justificativa:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${proposta}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Descri&ccedil;&atilde;o sucinta das atividades a serem realizadas pelo estagi&aacute;rio:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${atividades}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Objetivos educacionais para o estagi&aacute;rio:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${objetivos}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Resultados previstos para o Projeto/Programa:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${resultados}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Crit&eacute;rio(s) previsto(s) para avalia&ccedil;&atilde;o dos resultados:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${criterios}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Nome, matr&iacute;cula e cargo/fun&ccedil;&atilde;o do supervisor do est&aacute;gio:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify">Nome: <b>${f:pessoa(requestScope['supervisor_pessoaSel.id']).nomePessoa}</b> <br/>
    
        Matr&iacute;cula n&ordm;: <b>${f:pessoa(requestScope['supervisor_pessoaSel.id']).matricula}</b><br/>
 
    Cargo/Fun&ccedil;&atilde;o: <b>${f:pessoa(requestScope['supervisor_pessoaSel.id']).cargo.nomeCargo}-${f:pessoa(requestScope['supervisor_pessoaSel.id']).funcaoConfianca.nomeFuncao}</b></div></td>
  </tr>
</table>
		
<p></p>
					<p align="center">${doc.dtExtenso}</p>
					<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" />
					<br /><br />


		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental2.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita2.jsp" />
		FIM RODAPE -->

		</body>
		</html>
	</mod:documento>
</mod:modelo>
