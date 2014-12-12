<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
Inscri��o de 2� via de crach� -->

<mod:modelo>

	<mod:entrevista>
			
		<mod:grupo titulo="crachas">
			<mod:selecao titulo="N� de crachas a incluir"
				var="crachas" opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
			<c:forEach var="i" begin="1" end="${crachas}">
				<mod:grupo>
					<mod:texto titulo="${i}) Nome" largura="20" var="nome${i}" />
					<mod:texto titulo="${i}) Matricula" largura="20" var="matricula${i}" />
					<mod:texto titulo="${i}) Lota��o" largura="20" var="lotacao${i}" />
					<mod:data titulo="Data" var="data${i}" />
				</mod:grupo>
			</c:forEach>
		</mod:grupo>
		
		
</mod:entrevista>

	<mod:documento>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp"/>		

		<h1>Termo de compromisso de recebimento de segunda via do crach�</h1>
		<body>	
		
				
		<p style="TEXT-INDENT: 2cm" align="justify">
		Recebi nesta data o crah� de identifica��o no �mbito da <b>JUSTI�A FEDERAL DE 1� INST�NCIA - Se��o Judici�ria 
		do Estado do Rio de janeiro<b>, e me comprometo em caso de perda, roubo ou furto a comunicar, <b>incontinente<b>
		� subsecretaria de Gest�o de Pessoas, bem como, em caso de desligamento, devolve-lo �quela Subsecretaria-Se��o 
		de Avalia��o de Desempenho.
		</p>		
		<p style="TEXT-INDENT: 2cm" align="justify">
		Declaro, outrossim que, em caso de pedido de 2� via do mesmo, deverei efetuar o pagamento, diretamente na Subsecretaria
		de Planejamento, Or�amento e Finan�as, do valor para sua confec��o.
		</p>
		<h2>Observa��o:</h2>
		1- Executam-se do pagamento acima descrito os casos de roubo, furto e inutiliza��o acidental do cracha, quando n�o se caracterizar
		, neste �ltimo caso, neglig�ncia do estagi�rio.<br>
		2- Nessas situa��es, dever� ser anexada � solicita��o de segunda via uma declara��o firmada pelo requerente com 
		o relato do ocorrido.<br>
		3- Tambem se excetua o caso de mudan�a de nome do requerente, que dever� apresentar, com a solicita��o, c�pia 
		aut�nticada de documento comprobat�rio.<br> 
		<table width="100%" border="0" cellpadding="1">
		<tr><td>Matr�cula</td><td>Nome</td><td>Lota��o</td><td>Data</td><td>Assinatura</td></tr>
		</table> 
        
       <table width="100%" border="0" cellpadding="1">
       		
			<c:forEach var="i" begin="1" end="${crachas}">
			<tr>			
					<td>${i} - ${requestScope[f:concat('matricula',i)]}</td>
					<td>${requestScope[f:concat('nome',i)]}</td>
					<td>${requestScope[f:concat('lotacao',i)]}</td>
					<td>${requestScope[f:concat('data',i)]}</td>
					<td></td>
			</tr>
			</c:forEach>
			
		</table>

			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
				
			<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
			
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp"/>

			</p>
		</blockquote>
	</body>
	</html>
	</mod:documento>
</mod:modelo>
