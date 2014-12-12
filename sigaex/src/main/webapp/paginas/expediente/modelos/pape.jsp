<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="Dependentes">
			<mod:selecao titulo="Dependentes a incluir" var="dependentes"
				opcoes="1;2;3;4;5" reler="sim" />
			<c:forEach var="i" begin="1" end="${dependentes}">
				<mod:grupo>
					<mod:texto titulo="${i}) Nome" largura="40" var="nome${i}" />
					<mod:selecao titulo="Parentesco" var="grauparentesco${i}"
						opcoes="Filha;Filho;Enteada;Enteado" />
					<mod:data titulo="Nascimento" var="dataNasc${i}" />
				</mod:grupo>
			</c:forEach>
		</mod:grupo>
		<mod:selecao
			titulo="Tamanho da letra"
			var="tamanhoLetra" opcoes="Normal;Pequeno;Grande"/>
	</mod:entrevista>
	<mod:documento>
		<c:if test="${tamanhoLetra=='Normal'}"><c:set var="tl" value="7pt"/></c:if>
		<c:if test="${tamanhoLetra=='Pequeno'}"><c:set var="tl" value="6pt"/></c:if>
		<c:if test="${tamanhoLetra=='Grande'}"><c:set var="tl" value="8pt"/></c:if>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head></head>
		<body style="font-family: arial">
		<mod:letra tamanho="${tl}">
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		
		<h3>INSCRI��O NO PLANO DE ASSIST�NCIA PR�-ESCOLAR (PAPE)</h3>

		<h4><p><b>1 - DADOS DO MAGISTRADO/SERVIDOR BENEFICI�RIO</b><p/></h4>
		<c:import url="/paginas/expediente/modelos/subscritor.jsp" />
		
		<h4><p><b>2 - DEPENDENTES</b><p/></h4>
		<table width="100%" border="1" cellpadding="2" cellspacing="1"
			bgcolor="#000000">
			<tr>
				<td bgcolor="#FFFFFF" width="50%"><p>NOME</p></td>
				<td bgcolor="#FFFFFF" width="25%"><p>GRAU DE PARENTESCO</p></td>
				<td bgcolor="#FFFFFF" width="25%"><p>DATA DE NASCIMENTO</p></td>
			</tr>
			<c:forEach var="i" begin="1" end="${dependentes}">
				<tr>
					<td bgcolor="#FFFFFF"><p>${requestScope[f:concat('nome',i)]}</p></td>
					<td bgcolor="#FFFFFF"><p>${requestScope[f:concat('grauparentesco',i)]}</p></td>
					<td bgcolor="#FFFFFF"><p>${requestScope[f:concat('dataNasc',i)]}</p></td>
				</tr>
			</c:forEach>
		</table>

		<h4><p><b>3 - DECLARA��O</b></p></h4>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Declaro estar ciente dos termos da Resolu��o CJF n&ordm; 588, de 29/11/2007, que disp�e sobre o Aux�lio Pr�-Escolar, e de que o respectivo reembolso ser� realizado em 
		Folha de Pagamento, conforme apresentado abaixo:</p>
		<p style="MARGIN-LEFT: 2cm">
			- O aux�lio pr�-escolar ser� devido a partir do m�s em que for feita a inscri��o do dependente, n�o sendo pagos valores relativos a meses anteriores;<br/>
			- O aux�lio pr�-escolar ser� pago a cada crian�a na faixa et�ria compreendida desde o nascimento at� o m�s de completar 6 anos de idade inclusive; ou quando ingressar no ensino fundamental;<br/>
			- O benefici�rio � respons�vel por comunicar a administra��o qualquer situa��o que cause perda do benef�cio, pelas hip�teses do art. 14 da referida Resolu��o;<br/>
			- Declaro, ainda, que o menor(es) acima relacionado(s) n�o est�(�o) cadastrado(s) como dependente(s), deste benef�cio, ou programa similar em outro �rg�o ou entidade da Administra��o P�blica direta ou indireta.
		</p>
		<p>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Declaro, ainda, que preencho os requisitos previstos pelo art. 5&deg; da Resolu��o n&ordm; 588, de 29/11/2007.
		</p>
		<p align="center">${doc.dtExtenso}</p>
		<p align="center">
		Assinatura:_______________________________________________________________
		</p>

		<h4><p><b>DOCUMENTA��O NECESS�RIA</b></h4><br/>
		
		<table width="100%" border="1" cellpadding="2" cellspacing="1"
			bgcolor="#000000">
			<tr>
				<td bgcolor="#FFFFFF" width="25%"><p>DEPENDENTES</p></td>
				<td bgcolor="#FFFFFF" width="75%"><p>DOCUMENTA��O</p></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF" width="25%"><p align="center">Filho</p></td>
				<td bgcolor="#FFFFFF" width="75%"><p>- C�pia da certid�o de nascimento;<br>
				- Laudo m�dico (no caso de dependente portador de necessidade especial com mais de 6 anos).</p></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF" width="25%"><p align="center">Enteado</p></td>
				<td bgcolor="#FFFFFF" width="75%"><p>- C�pia da certid�o de nascimento;<br>
				- C�pia da certid�o de casamento do benefici�rio ou escritura declarat�ria, quando companheiro(a);<br>
				- Declara��o subscrita pelo servidor de que o menor est� sob sua responsabilidade e � seu dependente econ�mico.</p></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF" width="25%"><p align="center">Menor sob guarda ou tutelado</p></td>
				<td bgcolor="#FFFFFF" width="75%"><p>- C�pia da certid�o de nascimento;<br>
				- Termo de Guarda ou Tutela;<br>
				- Comprova��o da condi��o de menor sob guarda/responsabilidade do benefici�rio, mediante autoriza��o judicial.</p></td>
			</tr>
		</table>
		<p style="font-family: arial; MARGIN-LEFT: 1cm">Tratando-se de dependentes excepcionais ser� considerada, como limite para o atendimento,
				 a idade mental correspondente a 6 (seis) anos de idade, comprovada mediante laudo m�dico, homologado pela �rea competente
				 do �rg�o.</p>
		<p style="font-family: arial; MARGIN-LEFT: 1cm">Servidores requisitados ou cedidos ou que exer�am mais de um cargo, devem apresentar declara��o fornecida
		 pelo outro �rg�o de que n�o usufruem benef�cio semelhante, informando o valor da remunera��o percebida naquele �rg�o.</p>
		
		</mod:letra>
		</body>
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp"/>
		</html>
	</mod:documento>
</mod:modelo>
