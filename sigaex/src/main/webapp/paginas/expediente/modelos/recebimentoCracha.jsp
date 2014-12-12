<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
Termo de Compromisso e Recebimento do Crach�  
Ultima atualiza��o 14/03/2007
 -->

<mod:modelo>
<mod:entrevista>
		<mod:grupo titulo="CRACH�">
			<mod:selecao titulo="N� de crach�s a incluir"
				var="crachas" opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
			<c:forEach var="i" begin="1" end="${crachas}">
				<mod:grupo>
					<mod:texto titulo="Nome" largura="40" var="nome${i}" />
					<mod:texto titulo="Matricula" largura="15" maxcaracteres="10" var="matricula${i}" />
					<mod:data titulo="Data" var="data${i}" />
						<mod:grupo>
							<mod:lotacao titulo="Lota��o" var="lotacao${i}" />
						</mod:grupo>
				</mod:grupo>
			</c:forEach>
		</mod:grupo>	
	</mod:entrevista>

	<mod:documento>
		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
			
		<body>


		<p align="center"><b> TERMO DE COMPROMISSO E RECEBIMENTO DO
		CRACH� DE IDENTIFICA��O FUNCIONAL </b></p>
		
		<p style="TEXT-INDENT: 2cm" align="justify">Recebi, nesta data,
		o crah� de identifica��o no �mbito da <b>JUSTI�A FEDERAL DE 1�
		INST�NCIA - Se��o Judici�ria do Estado do Rio de janeiro</b>, e me
		comprometo, em caso de perda, roubo ou furto a comunicar, <b>incontinenti</b>,
		� Subsecretaria de Gest�o de Pessoas, bem como, em caso de
		desligamento, devolv�-lo �quela Subsecretaria &nbsp; - &nbsp; Se��o de
		Avalia��o de Desempenho.</p>

		<p style="TEXT-INDENT: 2cm" align="justify">Declaro, outrossim
		que, em caso de pedido de 2� via do mesmo, deverei efetuar o
		pagamento, diretamente na Subsecretaria de Planejamento, Or�amento e
		Finan�as, do valor para sua confec��o.</p>

		<b>Observa��o:</b>
		<ul type="square">
			<li>Excetuam-se do pagamento acima descrito os casos de roubo,
			furto e inutiliza��o acidental do cracha, quando n�o se caracterizar
			, neste �ltimo caso, neglig�ncia do estagi�rio.</li>
			<li>Nessas situa��es, dever� ser anexada � solicita��o de
			segunda via uma declara��o firmada pelo requerente com o relato do
			ocorrido.</li>
			<li>Tambem se excetua o caso de mudan�a de nome do requerente,
			que dever� apresentar, com a solicita��o, c�pia aut�nticada de
			documento comprobat�rio.</li>
		</ul>
		<br>
		<br>

		<table width="100%" border="1" cellpadding="2" cellspacing="1"
			bgcolor="#000000">
		<tr><td  bgcolor="#FFFFFF" width="15%" align="center">Matr�cula</td><td bgcolor="#FFFFFF" width="35%" align="center">Nome</td><td bgcolor="#FFFFFF" width="10%" align="center">Lota��o</td><td bgcolor="#FFFFFF" width="15%" align="center">Data</td><td bgcolor="#FFFFFF" width="25%" align="center">Assinatura</td></tr>
       		
			<c:forEach var="i" begin="1" end="${crachas}">
			<tr>			
					<td bgcolor="#FFFFFF" width="15%" align="center">${requestScope[f:concat('matricula',i)]}</td>
					<td bgcolor="#FFFFFF" width="35%" align="center">${requestScope[f:concat('nome',i)]}</td>
					<td bgcolor="#FFFFFF" width="10%" align="center">${requestScope[f:concat(f:concat('lotacao',i),'_lotacaoSel.sigla')]}</td>
					<td bgcolor="#FFFFFF" width="15%" align="center">${requestScope[f:concat('data',i)]}</td>
					<td bgcolor="#FFFFFF" width="25%"></td>
			</tr>
			</c:forEach>
			
		</table>
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</body>
		</html>
	</mod:documento>
</mod:modelo>
