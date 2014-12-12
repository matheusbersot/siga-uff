<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
Termo de Compromisso e Recebimento do Crach� de Identifica��o Funcional -->

<mod:modelo>

	<mod:entrevista>
			
		<mod:grupo titulo="Crach�">
			<mod:selecao titulo="N� de crach�s a incluir"
				var="crachas" opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
			<c:forEach var="i" begin="1" end="${crachas}">
				<mod:grupo>
					<mod:texto titulo="Nome" largura="40" var="nome${i}" />
					<mod:texto titulo="Matricula" largura="15" maxcaracteres="13" var="matricula${i}" />
					<mod:texto titulo="Lota��o" largura="10" var="lotacao${i}" />
					<mod:data titulo="Data" var="data${i}" />
				</mod:grupo>
			</c:forEach>
		</mod:grupo>
		
		
</mod:entrevista>

	<mod:documento>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp"/>		
		<body>
		
		<font size="2">
		<p align="center"><b> TERMO DE COMPROMISSO E RECEBIMENTO DO CRACH� DE IDENTIFICA��O FUNCIONAL </b></p>
		
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		Recebi, nesta data, o crah� de identifica��o no �mbito da <b>JUSTI�A FEDERAL DE 1� INST�NCIA - ${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</b>, e me comprometo, em caso de perda, roubo ou furto a comunicar, <b>incontinenti</b>
		� Subsecretaria de Gest�o de Pessoas, bem como, em caso de desligamento, devolv�-lo �quela Subsecretaria - Se��o 
		de Avalia��o de Desempenho.
		</p>	
			
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		Declaro, outrossim que, em caso de pedido de 2� via do mesmo, deverei efetuar o pagamento, diretamente na Subsecretaria
		de Planejamento, Or�amento e Finan�as, do valor para sua confec��o.
		</p>
		
		<b>Observa��o:</b>
		<ul type="square">
			<li>Excetuam-se do pagamento acima descrito os casos de roubo, furto e inutiliza��o acidental do cracha, quando n�o se caracterizar
		, neste �ltimo caso, neglig�ncia do estagi�rio.</li>
			<li>Nessas situa��es, dever� ser anexada � solicita��o de segunda via uma declara��o firmada pelo requerente com 
		o relato do ocorrido.</li>
			<li>Tambem se excetua o caso de mudan�a de nome do requerente, que dever� apresentar, com a solicita��o, c�pia 
		aut�nticada de documento comprobat�rio. </li> 
		</ul>
		<br>
		<p style="TEXT-INDENT: 1.5cm" align="center">
		<b> ESTAGI�RIOS �REA ADMINISTRATIVA - N�VEL M�DIO <br>
			Localidade: RIO BRANCO </b>
		</p>
		<br>
		
		<table width="100%" border="0" cellpadding="2">
		<tr><td width="17%" align="center">Matr�cula</td><td width="35%" align="center">Nome</td><td width="10%" align="center">Lota��o</td><td width="13%" align="center">Data</td><td width="25%" align="center">Assinatura</td></tr>
		</table> 
        
       <table width="100%" border="0" cellpadding="1">
       		
			<c:forEach var="i" begin="1" end="${crachas}">
			<tr>			
					<td width="17%" align="center">${requestScope[f:concat('matricula',i)]}</td>
					<td width="35%" align="center">${requestScope[f:concat('nome',i)]}</td>
					<td width="10%" align="center">${requestScope[f:concat('lotacao',i)]}</td>
					<td width="13%" align="center">${requestScope[f:concat('data',i)]}</td>
					<td></td>
			</tr>
			</c:forEach>
			
		</table>
		</font>
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp"/>
	</body>
	</html>
	</mod:documento>
</mod:modelo>
