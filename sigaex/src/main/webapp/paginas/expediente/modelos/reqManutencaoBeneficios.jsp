<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="SITUA��O ANTERIOR">
			<mod:grupo>
				<mod:pessoa titulo="Matr�cula Anterior" var="matriculaAnterior"
					reler="sim" buscarFechadas="true"/>
			</mod:grupo>

			<mod:grupo>
				<mod:texto titulo="Categoria funcional anterior"
					var="categoriaAnterior"
					valor="${f:pessoa(requestScope['matriculaAnterior_pessoaSel.id']).cargo.descricao}"
					largura="50" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="SITUA��O ATUAL">
			<mod:grupo>
				<mod:pessoa titulo="Matr�cula atual" var="novaMatricula" reler="sim" />
			</mod:grupo>
			<mod:texto titulo="Categoria funcional atual" var="categoriaAtual"
				valor="${f:pessoa(requestScope['novaMatricula_pessoaSel.id']).cargo.descricao}"
				largura="50" />
			<mod:data titulo="Data da posse" var="dataPosse" />
			<mod:data titulo="Data da exerc�cio" var="dataExercicio" />
		</mod:grupo>
		<mod:grupo
			titulo="Requeiro a manuten��o dos benef�cios abaixo relacionados">
			<mod:grupo>
				<mod:caixaverif titulo="Programa de Apoio � Psicologia (PAPSI)" var="papsi"
					reler="N�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:caixaverif titulo="Aux�lio Pr�-escolar" var="preEscolar"
					reler="N�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:caixaverif titulo="Aux�lio Creche" var="auxilioCreche"
					reler="N�o" />
			</mod:grupo>
			<mod:grupo titulo="Tipo de Benef�cio Sa�de:">
				<mod:radio titulo="Aux�lio Sa�de" var="saude" valor="1" />
				<mod:radio titulo="Plano de Sa�de" var="saude" valor="2" />
				<mod:radio titulo="Nenhum" var="saude" marcado="Sim" valor="3" />
			</mod:grupo>
			<mod:grupo>
				<mod:caixaverif
					titulo="Aux�lio Transporte (exceto para Analista Judici�rio/Execu��o de Mandados)"
					var="auxilioTransporte" reler="ajax" idAjax="transporteAjax" />
				<mod:grupo depende="transporteAjax">

					<c:if test="${auxilioTransporte == 'Sim'}">
						<mod:grupo>
							<mod:selecao
								titulo="Altera o percurso Resid�ncia-Trabalho-Resid�ncia"
								opcoes="N�o;Sim" var="percurso" />
						</mod:grupo>
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<c:set var="tl" value="10pt" />
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
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0"  bgcolor="#FFFFFF">
			<tr><td>
			<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
			</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/><br/>
					<table width="100%" border="0" >
						<tr>
							<td align="center"><mod:letra tamanho="${tl}"><p style="font-family:Arial;font-weight:bold" >REQUERIMENTO DE MANUTEN&Ccedil;&Atilde;O DE BENEF&Iacute;CIOS</p></mod:letra></td>
						</tr>
						<tr>
							<td><br/><br/></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->


		<mod:letra tamanho="${tl}">

			<p style="TEXT-INDENT: 2cm" align="justify"><br>
			<b>SITUA��O ANTERIOR</b><br>
			<br>
			<b>Nome:</b> ${requestScope['matriculaAnterior_pessoaSel.descricao']} <br>
			<b>Matr�cula anterior:</b>
			${requestScope['matriculaAnterior_pessoaSel.sigla']} <br>
			<b>Categoria funcional anterior:</b> ${categoriaAnterior} <br>
			<br>

			<b>SITUA��O ATUAL</b><br>
			<br>
			<b>Matr�cula Atual:</b>
			${requestScope['novaMatricula_pessoaSel.sigla']} <br>
			<b>Categoria funcional atual:</b> ${categoriaAtual} <br>
			<b>Data da posse:</b> ${dataPosse} <br>
			<b>Data da exerc�cio:</b> ${dataExercicio} <br>
			<br>
			Venho requerer a V.S&ordf;. a manuten��o do(s) benef�cio(s) abaixo
			relacionado(s): <br>
			<br>
			
			<c:if test="${papsi=='Sim'}">
			- Programa de Apoio � Psicologia (PAPSI)<br>
			</c:if>
			<c:if test="${preEscolar=='Sim'}">
			- Aux�lio Pr�-escolar<br>
			</c:if>
			<c:if test="${auxilioCreche=='Sim'}">
			- Aux�lio Creche<br>
			</c:if> <c:if test="${saude==1}">
			- Aux�lio Sa�de<br>
			</c:if> <c:if test="${saude==2}">
			- Plano de Sa�de<br>
			</c:if> <c:if test="${auxilioTransporte=='Sim'}">
			- Aux�lio Transporte <br>
			</c:if></p>

			<c:if test="${percurso eq 'Sim'}">
				<p style="TEXT-INDENT: 2cm" align="justify">Comprometo-me a
				atualizar o percurso declarado anteriormente, sob pena de perda do
				benef�cio, tendo em vista a posse em novo cargo.</p>
			</c:if>
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
			<p align="center">${doc.dtExtenso}</p>

			<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" />

			<p align="center">Matr�cula: RJ${doc.subscritor.matricula}</p>

		</mod:letra>

		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoCentralizada.jsp" />
		FIM RODAPE -->


		</body>
		</html>
	</mod:documento>
</mod:modelo>