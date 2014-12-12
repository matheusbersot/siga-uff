<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
Termo de Compromisso e Recebimento segunda via de Crach�
Ultima atualiza��o 13/03/2007
  -->
      
<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="SEGUNDA VIA DE CRACH�">
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
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp"/>	
			
		<body>
		
		<p align="center"><b> TERMO DE COMPROMISSO E RECEBIMENTO DE SEGUNDA VIA DO CRACH�   </b></p>
	
		<p style="TEXT-INDENT: 2cm" align="justify">
		Recebi, nesta data, o crah� de identifica��o no �mbito da <b>JUSTI�A FEDERAL DE 1� INST�NCIA - <c:choose><c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when><c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO</c:otherwise></c:choose></b>, e me comprometo, em caso de perda, roubo ou furto a comunicar, <b>incontinenti</b>
		� Subsecretaria de Gest�o de Pessoas, bem como, em caso de desligamento, devolv�-lo �quela Subsecretaria - Se��o 
		de Avalia��o de Desempenho.
		</p>	
			
		<p style="TEXT-INDENT: 2cm" align="justify">
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
		<p style="TEXT-INDENT: 2cm" align="center">
		<b> ESTAGI�RIOS �REA ADMINISTRATIVA - N�VEL M�DIO <br>
			Localidade: RIO BRANCO </b>
		</p>
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
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp"/>
	</body>
	</html>
	</mod:documento>
</mod:modelo>
