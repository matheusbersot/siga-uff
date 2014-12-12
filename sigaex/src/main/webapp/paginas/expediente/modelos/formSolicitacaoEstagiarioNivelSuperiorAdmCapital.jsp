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
				Projeto/Programa do planejamento estrat�gico para o quinqu�nio de 2010-2014 no �mbito da Justi�a Federal da 2� Regi�o em que o estagi�rio atuar�.
				<span style="color:red"> Caso n�o conste do elenco de projetos estrat�gicos da SJRJ 
				(Resolu��o n� 48/2009 pres. TRF2) um projeto especificamente da/para a Subsecretaria, devem ser indicadas 
				a��es que constem da respectiva programa��o de trabalho da �rea para o ano em curso. Nesse caso, 
				tamb�m devem ser indicados os objetivos estrat�gcios relacionados a tais a��es, ou seja, aqueles cujo 
				alcance ser� facilitado/beneficiado com a realiza��o das a��es</span>
				<mod:texto titulo="" var="projeto" largura="60" />
				</mod:grupo>
				<br />
				<mod:grupo>
					<mod:texto titulo="�rea de forma��o do estagi�rio" var="area" largura="30" />
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Proposta de trabalho com justificativa em rela��o ao Programa/Projeto em que o estagi�rio atuar�" var="proposta" colunas="80" linhas="3"/> 
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Descri��o sucinta das atividades a serem realizadas pelo estagi�rio" var="atividades" colunas="80" linhas="3"/>
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Objetivos educacionais para o estagi�rio (quanto � complementa��o do ensino profissional pelo desempenho das atividades; desenvolvimento de rela��es interpessoais; etc.)" var="objetivos" colunas="80" linhas="3"/>
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Resultados previstos para o Projeto/Programa (em face do desempenho das atividades pelo estagi�rio)" var="resultados" colunas="80" linhas="3"/>
				</mod:grupo>
				<mod:grupo>
					<mod:memo titulo="Crit�rio(s) previsto(s) para avalia��o dos resultados" var="criterios" colunas="80" linhas="3"/>
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
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">SOLICITA&Ccedil;&Atilde;O DE ESTAGI&Aacute;RIO DE N&Iacute;VEL SUPERIOR PARA A &Aacute;REA DE ADMINISTRA&Ccedil;&Atilde;O <br/>- CAPITAL - 	
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
  <tr style="background-color: gray;">
    <td bordercolor="#000000">Projeto/Programa do planejamento estrat&eacute;gico para o quinqu&ecirc;nio de 2010-2014 no &acirc;mbito da Justi&ccedil;a Federal da 2&ordf; Regi&atilde;o em que o estagi&aacute;rio atuar&aacute;:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${projeto}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">&Aacute;rea de forma&ccedil;&atilde;o do estagi&aacute;rio:</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${area}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Proposta de trabalho com justificativa em rela&ccedil;&atilde;o ao Programa/Projeto em que o estagi&aacute;rio atuar&aacute;:</td>
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
    <td bordercolor="#000000">Objetivos educacionais para o estagi&aacute;rio (quanto &agrave; complementa&ccedil;&atilde;o do ensino profissional pelo desempenho das atividades; desenvolvimento de rela&ccedil;&otilde;es interpessoais; etc.):</td>
  </tr>
  <tr>
    <td bordercolor="#000000"><div align="justify"><b>${objetivos}</b></div></td>
  </tr>
  <tr style="background-color: gray">
    <td bordercolor="#000000">Resultados previstos para o Projeto/Programa (em face do desempenho das atividades pelo estagi&aacute;rio):</td>
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
