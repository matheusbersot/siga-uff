<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 
     Modelo : Substituicao SRH
     Data da Criacao : 24/01/2007
     Ultima alteracao : 13/03/2007 
-->

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="DETALHES DA SUBSTITUI��O" />
		<mod:selecao
			titulo="Informe o n�mero de Funcion�rios que constar�o na Substitui��o"
			var="numeroFuncionarios" opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
		<c:forEach var="m" begin="1" end="${numeroFuncionarios}">
			<mod:grupo titulo="Dados do Funcion�rio Substituto ${m}">
				<mod:texto titulo="Nome" var="nomeServidor${m}" largura="62"
					maxcaracteres="60" />
				<mod:texto titulo="Matr�cula" var="matriculaServidor${m}"
					largura="12" maxcaracteres="10" />
			</mod:grupo>
			<mod:grupo titulo="Dados do Funcion�rio Titular">
				<mod:texto titulo="Titular do Cargo/Fun��o"
					var="titularCargoServidor${m}" largura="65" maxcaracteres="60" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Lota��o" var="lotacaoServidor${m}" largura="45"
					maxcaracteres="43" />
				<mod:texto titulo="Cargo" var="cargoServidor${m}" largura="45"
					maxcaracteres="43" />
			</mod:grupo>
			<mod:grupo>
				<mod:data titulo="Data In�cio substitui��o" var="dataInicio${m}" />
				<mod:data titulo="data Fim" var="dataFim${m}" />
			</mod:grupo>
			<mod:grupo>
				<mod:memo titulo="Documento de Indica��o"
					var="documentoIndicacao${m}" linhas="4" colunas="60" />
			</mod:grupo>
		</c:forEach>
		<mod:grupo>
			<mod:memo titulo="Texto a ser inserido no corpo da Designa��o"
				var="texto_oficio" linhas="4" colunas="60" />
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br />
					<table width="100%">
						<tr>
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight: bold;">PORTARIA N&ordm; ${doc.codigo} DE ${doc.dtD} de ${doc.dtMMMM} de ${doc.dtYYYY}</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<p>&nbsp;</p>
		<!-- INICIO ABERTURA --><p style="TEXT-INDENT: 1.5cm" align="justify">A DIRETORA DA
		SUBSECRETARIA DE GEST�O DE PESSOAS DA JUSTI�A FEDERAL - SE��O
		JUDICI�RIA DO RIO DE JANEIRO, usando a compet�ncia que lhe foi
		delegada pela Portaria n� 011 - GDF, de 26 de mar�o de 2003,
		${texto_oficio}, RESOLVE:<br><!-- FIM ABERTURA -->
		<br>
		<br>
		DESIGNAR o(a) servidor(a) abaixo relacionados para substitu�rem seus<br>
		respectivos titulares, em virtude de f�rias regulamentares:<br>
		<table width="100%" border="0" cellpadding="1">
			<tr>
				<td></td>
				<td width="40%" align="center">Funcion�rio</td>
				<td width="60%" align="center">Dados Cadastrados</td>
			</tr>
		</table>
		<table width="100%" border="0" cellpadding="1">
			<c:forEach var="m" begin="1" end="${numeroFuncionarios}">
				<tr>
					<td width="40%">${m}� - Nome</td>
					<td width="60%">${requestScope[f:concat('nomeServidor',m)]}</td>
				</tr>
				<tr>
					<td width="40%">Matricula</td>
					<td width="60%">${requestScope[f:concat('matriculaServidor',m)]}</td>
				</tr>
				<tr>
					<td width="40%">Titular</td>
					<td width="60%">${requestScope[f:concat('titularCargoServidor',m)]}</td>
				</tr>
				<tr>
					<td width="40%">Lota��o</td>
					<td width="60%">${requestScope[f:concat('lotacaoServidor',m)]}</td>
				</tr>
				<tr>
					<td width="40%">Cargo</td>
					<td width="60%">${requestScope[f:concat('cargoServidor',m)]}</td>
				</tr>
				<tr>
					<td width="40%">Per�odo</td>
					<td width="60%">${requestScope[f:concat('dataInicio',m)]} at�
					${requestScope[f:concat('dataFim',m)]}</td>
				</tr>
				<tr>
					<td width="40%">Documento de Indica��o</td>
					<td width="60%">${requestScope[f:concat('documentoIndicacao',m)]}</td>
				</tr>
			</c:forEach>
		</table>
		</table>
		</font>
		<br>
		<br>
		<br>
		<p align="center">CUMPRA-SE. REGISTRE-SE. PUBLIQUE-SE.</p>
		<br>
		<br>

		<p align="center">REGINA HELENA MOREIRA FARIA<br>
		Diretora da Subsecretaria de Gest�o de Pessoas</p>
		<br>
		<br>
		<br>
		</p>
		</body>
		</html>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
	</mod:documento>
</mod:modelo>

