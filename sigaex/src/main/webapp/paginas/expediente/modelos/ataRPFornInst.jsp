<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>

		<mod:grupo titulo="Detalhe do Contrato">
			<mod:texto titulo="Informe o n� da Ata de Registro de Pre�os"
				largura="12" maxcaracteres="10" var="ataregpreco" />
			<mod:texto titulo="Ano" largura="5" maxcaracteres="4" var="ano" />
			<mod:grupo>
				<mod:texto titulo="N� Processo" largura="10" maxcaracteres="6"
					var="n1" />
				<mod:texto largura="10" maxcaracteres="6" var="n2" />
				<mod:texto largura="10" maxcaracteres="6" var="n3" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Dados do Juiz">
			<mod:texto titulo="Juiz Federal - (Diretor do Foro)" largura="60"
				maxcaracteres="40" var="nomeDoutor" />
			<mod:grupo>
				<mod:texto titulo="Documento Identidade" largura="12"
					maxcaracteres="9" var="identidade" />
				<mod:texto titulo="CPF" largura="15" maxcaracteres="11" var="cpf" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Detalhe do Objeto">
			<mod:texto titulo="Informe o n�mero do <b>PREG�O</b>" largura="10"
				maxcaracteres="8" var="pregao" />
			<mod:grupo>
				<mod:texto titulo="Material a ser fornecido" largura="30"
					var="forninst" />
			</mod:grupo>
			<mod:grupo>
				<mod:numero titulo="Prazo de Entrega no m�ximo" largura="6"
					maxcaracteres="5" var="prazo" extensoNum="sim" />
				<mod:oculto var="prazonumextenso" valor="${prazonumextenso}" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Pre�o e Pagamento">
			<mod:texto titulo="Informe a quantidade de itens" largura="3" var="n"
				reler="sim" />
			<c:forEach var="i" begin="1" end="${n}">
				<mod:grupo>
					<mod:texto titulo="Item" largura="3" var="item${i}" />
					<mod:texto titulo="Especifica��o" largura="45"
						var="especificacao${i}" />
					<mod:texto titulo="Quantidade" largura="3" var="quantidade${i }" />
					<mod:monetario titulo="Pre�o Unit�rio" largura="12"
						maxcaracteres="10" var="preco${i}" formataNum="sim"
						extensoNum="sim" reler="sim" />
				</mod:grupo>
			</c:forEach>
			<!-- <mod:texto titulo="Empresa Vencedora" largura="30" var="empvencedora"/> -->
		</mod:grupo>

		<mod:grupo titulo="Dados da Subsecretaria">
			<mod:texto titulo="Nome" largura="60" maxcaracteres="40"
				var="subsecretaria" />
			<mod:grupo>
				<mod:texto titulo="Endere�o" largura="60" maxcaracteres="40"
					var="endereco" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo>
			<mod:texto titulo="Cidade" largura="40" maxcaracteres="30"
				var="bairro" />
			<mod:texto titulo="Bairro" largura="40" maxcaracteres="30"
				var="cidade" />
			<mod:texto titulo="Cep" largura="15" maxcaracteres="9" var="cep" />
		</mod:grupo>

		<mod:grupo titulo="Vig�ncia">
			<mod:numero titulo=" Periodo de Vig�ncia em meses" largura="5"
				maxcaracteres="3" var="vigencia" extensoNum="sim" />
			<mod:oculto var="vigencianumextenso" valor="${vigencianumextenso}" />
		</mod:grupo>

		<mod:grupo titulo="Dota��o Or�ament�ria">
			<mod:texto titulo="Programa de Trabalho" largura="60"
				maxcaracteres="40" var="progtrabalho" />
		</mod:grupo>

		<mod:grupo>
			<mod:texto titulo="Elemento de Despesa" largura="60"
				maxcaracteres="40" var="elemdespesa" />
		</mod:grupo>


	</mod:entrevista>

	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 1</font></u>
		</head>
		<body>

		<font size="2">
		<p align="center"><b>ATA DE REGISTRO DE PRE�OS N.�&nbsp;
		${ataregpreco }/${ano }</b></p>
		<p align="center"><b>PROCESSO N.�&nbsp; ${n1 }/${n2 }/${n3 } -
		EOF</b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">A justi�a Federal de
		1&deg; Grau no Rio de Janeiro, com sede na Av.Rio Branco, 243 - Anexo
		I - 14&deg; andar, Centro/RJ, inscrita no C.N.P.J. sob o n&deg;
		05.424.540./0001-16, neste ato representadas pelo Dr. <b>${nomeDoutor
		}</b>, Juiz Federal - Diretor do Foro, Identidade n&deg; <b>${identidade
		}</b>, CPF: <b>${cpf}</b> doravante denominada JUSTI�A FEDERAL, resolve,
		em face das propostas apresentadas no <b>Preg�o:${pregao }/(${ano
		})</b>, <b>REGISTRAR O PRE�O</b> da empresa classificada em primeiro lugar
		para o objeto da licita��o e igualmente daquelas que manifestaram
		interesse em se registrar tamb�m pelo menor pre�o, doravante
		denominadas FORNECEDORAS, em conformidade com o disposto na Lei n&deg;
		10.520, de 17/07/2002, Decreto n&deg; 3.555, de 08/08/2000 e n&deg;
		3.931, de 19/07/2001 e, subsidiariamente, a Lei n&deg; 8.666, de
		21/06/1993 e suas altera��es, mediante as cl�usulas e condi��es a
		seguir:</p>

		<p><b><u>CL&Aacute;USULA PRIMEIRA - DO OBJETO</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">1.1. A presente ata
		tem por objeto o <b>Registro de Pre�os</b> para o fornecimento e
		instala��o de <b>${forninst}</b>, conforme
		especifica&ccedil;&otilde;es constantes do Termo de Refer&ecirc;ncia
		do Edital do <b>Preg&atilde;o n&ordm; ${pregao }/(${ano })</b>, que
		integram a presente Ata, e Pre�os Registrados e Empresa(s)
		Forncedora(s).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">1.2. A
		aquisi&ccedil;&atilde;o dos materiais objeto da presente Ata
		ser&aacute; de acordo com as necessidades e conveni&ecirc;ncias da
		Justi&ccedil;a Federal.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">1.3. Qualquer
		&oacute;rg&atilde;o ou entidade integrante da
		Administra&ccedil;&atilde;o P&uacute;blica Federal poder&aacute;
		utilizar a Ata de Registro de Pre&ccedil;os durante a sua
		vig&ecirc;ncia, desde que manifeste interesse e mediante pr&eacute;via
		consulta &agrave; Justi&ccedil;a Federal do Rio de Janeiro.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">1.4. Caber&aacute;
		ao fornecedor benefici&aacute;rio da Ata de Registro de Pre&ccedil;os,
		observadas as condi&ccedil;&otilde;es nela estabelecidas, optar pela
		aceita&ccedil;&atilde;o ou n&atilde;o do fornecimento,
		independentemente dos quantitativos registrados em Ata, desde que este
		fornecimento n&atilde;o prejudique as obriga&ccedil;&otilde;es
		anteriormente assumidas.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">1.5. As
		aquisi&ccedil;&otilde;es adicionais de que trata o subitem 1.3
		n&atilde;o poder&atilde;o exceder, por &oacute;rg&atilde;o ou
		entidade, a 100% (cem por cento) dos quantitativos registrados na Ata
		de Registro de Pre�os.</p>
		<br>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 1� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 2</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA SEGUNDA - DO PRAZO DE ENTREGA E
		EXECU&Ccedil;&Atilde;O DOS SERVI&Ccedil;OS</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.1. O <b>prazo</b>
		pra entrega dos materiais e execu&ccedil;&atilde;o dos servi&ccedil;os
		objeto do presente Registro de Pre&ccedil;os, expressamente
		solicitado, ser&aacute; de, no m&aacute;ximo, <b>${prazo }</b> (<b>${prazonumextenso}</b>)
		horas, contados a partir da Solicita&ccedil;&atilde;o de Fornecimento(<b>Anexo
		VI</b>), respeitado o estabelecido nas especifica&ccedil;&otilde;es
		constantes do <b>Anexo I</b> - Termo de Refer&ecirc;ncia do
		Preg&atilde;o n&deg; <b>${pregao }</b>/(<b>${ano }</b>).</p>

		<b> OBS: O prazo de entrega dos materiais e execu&ccedil;&atilde;o
		dos servi&ccedil;os ser&aacute; preenchido nos termos da proposta da
		licitante vencedora, observado o prazo m&aacute;ximo estipulado na
		Especifica&ccedil;&atilde;o.</b>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.2. A
		justi&ccedil;a Federal far&aacute; as aquisi&ccedil;&otilde;es
		mediante a emiss&atilde;o da "Solicita&ccedil;&atilde;o de
		Fornecimento" (<b>Anexo VI</b>), quando ent&atilde;o ser&aacute;
		expedida Nota de Empenho correspondente a tal
		solicita&ccedil;&atilde;o.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.3. Ser&aacute;
		considerada como confirma&ccedil;&atilde;o de recebimento o recibo
		dado no Of&iacute;cio expedido, o relat&oacute;rio emitido pelo
		aparelho de fax, a mensagem de e-mail enviada e a certid&atilde;o,
		dada pelo servidor respons&aacute;vel, de haver entregue o
		Of&iacute;cio ou do mesmo haver sido recusado.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.4. Os materias
		dever&atilde;o ser entregues e os servi&ccedil;os executados no local
		estabelecido pela JUSTI&Ccedil;A FEDERAL, conforme
		especifica&ccedil;&otilde;es constantes do <b> Anexo I </b> - Termo de
		Refer&ecirc;ncia do Preg&atilde;o n&deg; <b>${pregao}</b>/( <b>${ano}</b>).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.5. O recebimento
		do objeto da presente Ata de Registro de Pre&ccedil;os
		dar-se-&aacute;:</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.5.1 - provisoriamente, no
		ato da entrega do material fornecido e instalado e/ou os
		servi&ccedil;os executados.</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.5.2 - definitivamente, no
		prazo de at&eacute; 05 (cinco) dias &uacute;teis contatos do
		recebimento provis&oacute;rio, ap&oacute;s confer&ecirc;ncia da
		conformidade do material fornecido e instalado e/ou os servi&ccedil;os
		executados.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 2� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 3</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA TERCEIRA - DO PRE&Ccedil;O E
		PAGAMENTO</u></b></p>
		<br>
		<br>

		<table width="100%" border="0" cellpadding="1">
			<tr>
				<td width="7%" align="center">ITEM</td>
				<td width="53%" align="center">ESPECIFICA��O</td>
				<td width="20%" align="center">QUANTIDADE</td>
				<td width="20%" align="center">PRE�O UNIT�RIO</td>
			</tr>
		</table>

		<table width="100%" border="0" cellpadding="1">

			<c:forEach var="i" begin="1" end="${n}">
				<tr>
					<td width="7%" align="center">${requestScope[f:concat('item',i)]}</td>
					<td width="53%">${requestScope[f:concat('especificacao',i)]}</td>
					<td width="20%" align="center">${requestScope[f:concat('quantidade',i)]}</td>
					<td width="20%" align="center">${requestScope[f:concat('preco',i)]}</td>
				</tr>
			</c:forEach>
		</table>
		<table width="100%" border="0" cellpadding="3">
			<tr>
				<td><b>EMPRESA VENCEDORA:</b></td>
			</tr>
		</table>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.1. A JUSTI�A
		FEDERAL pagar� �(s) FORNECEDORA(S) o valor unit�rio registrado no
		item, multiplicado pela quantidade solicitada, que constar� da
		Solicita��o de Fornecimento(<b>Anexo VI</b>)e da Nota de Empenho, e
		ainda do Termo de Contrato, quando for o caso.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.2. Inclu�dos no
		pre�o unit�rio est�o todos os impostos, taxas e encargos sociais,
		obriga��es trabalhistas, previdenci�rias, fiscais e comerciais, assim
		como despesas com transportes, as quais correr�o por conta das
		FORNECEDORA(S).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.3. Os pre�os
		registrados dever�o sempre ser adequados ao valor de mercado, sob pena
		de n�o haver a aquisi��o.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.4. As Notas de
		Empenho, quando for o caso, ser�o emitidas � medida que forem sendo
		solicitados os materiais.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.5. As Notas
		Fiscais/Faturas dever�o ser entregues diretamente ao titular da
		Subsecretaria de <b>${subsecretaria }</b>, situada na <b>${endereco}</b>,
		<b>${bairro }</b>, <b>${cidade }</b> - Cep: <b>${cep }</b>, para serem
		devidamente atestadas.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.6. O pagamento �
		Fornecedora ser� efetivado, por cr�dito em conta corrente, mediante
		ordem banc�ria, at� o 10� dia �til ap�s a apresenta��o da fatura ou
		nota fiscal discriminativa do material entregue/servi�os prestados,
		devidamente atestada por servidor ou Comiss�o nomeada pela
		Administra��o, salvo eventual atraso de distribui��o de recursos
		financeiros efetuados pelo Conselho da Justi�a Federal, decorrente de
		execu��o or�ament�ria.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 3� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 4</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.6.1 - No per�odo acima
		n�o haver� atualiza��o financeira.</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.6.2 - A fatura/nota
		fiscal dever� ser apresentada em 02 (duas) vias.</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.6.3 - Ser� considerada
		como data do pagamento a data da emiss�o da Ordem Banc�ria.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.7. Caso seja
		necess�ria a retifica��o da fatura por culpa da(s) Fornecedora(s), a
		flu�ncia do prazo de 10 (dez) dias �teis ser� suspensa, reiniciando-se
		a contagem a partir da reapresenta��o da fatura retificada.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.8. A Justi�a
		Federal reserva-se o direito de n�o efetuar o pagamento se, no ato da
		atesta��o, o material/servi�o n�o estiver em perfeitas condi��es ou de
		acordo com as especifica��es apresentadas e aceitas pela Justi�a
		Federal.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.9 - A Se��o
		Judici�ria do Rio de Janeiro poder� deduzir da import�ncia a pagar os
		valores correspondentes a multas ou indeniza��es devidas pela
		fornecedora nos termos do presente ajuste.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.10 -
		A(s)Fornecedora(s) dever�(�o) comprovar, quando da apresenta��o da
		nota fiscal � Justi�a Federal, a regularidade perante a Seguridade
		Social e ao Fundo de Garantia de Tempo de Servi�o, atrav�s da
		apresenta��o da CND e do CRF, dentro das respectivas validade, sob
		pena de n�o pagamento do material fornecido/servi�o executado e de
		rescis�o contratual, em atendimento ao disposto no � 3�. do art. l95
		da Constitui��o Federal, no art. 2� da Lei 9.012/95, e nos arts.
		55,inciso VIII e 78,inciso I, ambos da Lei 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.11 - Na ocasi�o da
		entrega da nota fiscal a(s) Fornecedora(s) dever�(�o) comprovar a
		condi��o de optante pelo SIMPLES (Sistema Integrado de Pagamento de
		Impostos e Contribui��es das Microempresas e Empresas de pequeno
		Porte), mediante a apresenta��o da declara��o indicada em ato
		normativo da Secretaria da Receita Federal, e dos documentos,
		devidamente autenticados, que comprovem ser o signat�rio da referida
		declara��o representante legal da empresa.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">As pessoas jur�dicas
		n�o optantes pelo SIMPLES e aquelas que ainda n�o formalizaram a op��o
		sofrer�o a reten��o de impostos/contribui��es por esta Se��o
		Judici�ria no momento do pagamento, conforme disposto no art. 64 da
		Lei n� 9.430, de 27/12/96, regulamentado por ato normativo da
		Secretaria da Receita Federal.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 4� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 5</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA QUARTA - DA VIG�NCIA</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">4.1 - A presente Ata
		de Registro de Pre�os ter� vig�ncia de <b>${vigencia }</b>&nbsp; (<b>${vigencianumextenso}</b>)
		meses, contada a partir da data da assinatura da mesma.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">&nbsp;&nbsp;&nbsp;<b>PAR�GRAFO
		�NICO:</b>A presente Ata poder� ser prorrogada, na forma autorizada pelo
		art. 4� do Decreto n� 3.931/2001.</p>

		<p><b><u>CL&Aacute;USULA QUINTA - DA DOTA��O OR�AMENT�RIA</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.1 - As despesas
		decorrentes do fornecimento e execu��o dos servi�os, objeto deste
		Registro de Pre�os, correr�o � conta dos recursos consignados � Se��o
		Judici�ria do Rio de Janeiro, para o corrente exerc�cio, conforme o
		especificado a seguir:</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Programa de Trabalho: <b>${progtrabalho
		}</b>.<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Elemento de Despesa: <b>${elemdespesa
		}</b>.<br>
		</p>

		<p><b><u>CL&Aacute;USULA SEXTA - DAS OBRIGA��ES DA(S)
		FORNECEDORA(S):</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.1 - S�o obriga��es
		da(s) Fornecedora(s):</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.1.1 - entregar os
		materiais e executar os servi�os, objeto deste Registro de Pre�os, de
		acordo com as especifica��es constantes do <b> Anexo I </b> - Termo de
		Refer�ncia do Preg�o n� <b>${pregao }</b>/(<b>${ano }</b>), em
		conson�ncia com a proposta respectiva, bem como a cumprir com o prazo
		de entrega e quantidades constantes da Solicita��o de Fornecimento(<b>
		Anexo VI</b>).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.1.2 - manter, durante todo
		o per�odo de vig�ncia da Ata de Registro de Pre�os, em compatibilidade
		com as obriga��es assumidas, todas as condi��es de habilita��o e
		qualifica��o exigidas no Preg�o n� <b>${pregao }</b>/(<b>${ano }</b>).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.1.3 - fornecer aos seus
		funcion�rios crach�s de identifica��o, sem os quais n�o ser�
		autorizada a entrada nas depend�ncias da Contratante.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 5� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 6</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">6.2 - A(s)
		Fornecedora(s) �(s�o) respons�vel(eis) por:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.2.1 - qualquer acidente
		que venha a ocorrer com seus empregados e por danos que estes
		provoquem � Justi�a Federal ou a terceiros, n�o excluindo essa
		responsabilidade a fiscaliza��o ou o acompanhamento pela Justi�a
		Federal;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.2.2 - todos os encargos
		previdenci�rios e obriga��es sociais previstos na legisla��o social
		trabalhista em vigor relativos a seus funcion�rios, vez que os mesmos
		n�o manter�o nenhum v�nculo empregat�cio com a Se��o Judici�ria do Rio
		de Janeiro;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.2.3 - todas as
		provid�ncias e obriga��es estabelecidas na legisla��o espec�fica de
		acidentes de trabalho, quando, em ocorr�ncia da esp�cie, forem v�timas
		os seus funcion�rios quando da realiza��o da entrega dos
		materiais/presta��o dos servi�os, ou em conex�o com eles;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.2.4 - todos os encargos
		fiscais e comerciais decorrentes do presente Registro de Pre�os;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.3 - A
		inadimpl�ncia da(s) Fornecedora(s), com refer�ncia aos encargos
		sociais, comerciais e fiscais, n�o transfere a responsabilidade por
		seu pagamento � Administra��o da Se��o Judici�ria do Rio de Janeiro,
		raz�o pela qual a(s) Fornecedora(s) renuncia(m) expressamente a
		qualquer v�nculo de solidariedade, ativa ou passiva, com a SJRJ.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.4 - A(s)
		Fornecedora(s) dever�(�o) cumprir, ainda, com as demais obriga��es
		constantes da especifica��o elaborada pela Subsecretaria de <b>${subsecretaria
		}</b>, que integra o presente Registro de Pre�os.</p>

		<p><b><u>CL&Aacute;USULA S�TIMA - DO CANCELAMENTO DO
		REGISTRO</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">7.1 - O fornecedor
		ter� seu registro cancelado quando:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I - descumprir as condi��es
		da Ata de Registro de Pre�os;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;II - n�o retirar a
		respectiva nota de empenho ou instrumento equivalente, no prazo
		estabelecido pela Administra��o, sem justificativa aceit�vel;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;III - n�o aceitar reduzir o
		seu pre�o registrado, na hip�tese de este se tornar superior �queles
		praticados no mercado;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IV - tiver presentes raz�es
		de interesse p�blico.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 6� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 7</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">&nbsp;&nbsp;&nbsp;&nbsp;<b>PAR�GRAFO
		1�</b> - O cancelamento de registro, nas hip�teses previstas, assegurados
		o contradit�rio e a ampla defesa, ser� formalizado por despacho da
		autoridade competente do �rg�o gerenciador.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">&nbsp;&nbsp;&nbsp;&nbsp;<b>PAR�GRAFO
		2�</b> - A(s) fornecedora(s) poder�(�o) solicitar o cancelamento do seu
		registro de pre�o na ocorr�ncia de fato superveniente que venha
		comprometer a perfeita execu��o contratual, decorrentes de caso
		fortuito ou de for�a maior devidamente comprovados</p>

		<p><b><u>CL&Aacute;USULA OITAVA - DAS PENALIDADES</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.1 - O n�o
		cumprimento pela(s) Fornecedora(s) de qualquer uma das obriga��es,
		dentro das especifica��es e/ou condi��es predeterminadas nesta Ata de
		Registro de Pre�os, sujeit�-la-� �s penalidades previstas nos artigos
		86 a 88 da Lei n� 8.666/93;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.2 - As penalidades
		a que est� sujeita a(s) Fornecedora(s) inadimplente(s), nos termos da
		Lei no 8.666/93, s�o as seguintes:</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a)advert�ncia;</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b)multa;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c)suspens�o tempor�ria de
		participar em licita��o e impedimento em contratar com a Administra��o
		por prazo n�o superior a 02 (dois) anos;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.3 - A recusa
		injustificada em assinar a Ata de Registro de Pre�os, aceitar ou
		retirar o instrumento equivalente, dentro do prazo estabelecido pela
		Administra��o, sujeita o adjudicat�rio � penalidade de multa de at�
		10% (dez por cento) sobre o valor da adjudica��o, independentemente da
		multa estipulada no subitem 8.4.2.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.4 - A inexecu��o
		total ou parcial do Registro de Pre�os poder� acarretar, a crit�rio da
		Administra��o, a aplica��o das multas, alternativamente:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.4.1 - Multa compensat�ria
		de at� 30% (trinta por cento) sobre o valor equivalente � obriga��o
		inadimplida.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.4.2 - Multa correspondente
		� diferen�a entre o valor total porventura resultante de nova
		contrata��o e o valor total que seria pago ao adjudicat�rio.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.4.3 - Multa de 50%
		(cinq�enta por cento) sobre o valor global do Registro de Pre�os, no
		caso de inexecu��o total do mesmo.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 7� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 8</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">8.5 - A atualiza��o
		dos valores correspondentes � multa estabelecida no item 8.4 far-se-�
		a partir do 1� (primeiro) dia, decorrido o prazo estabelecido no item
		8.7.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.6 - Os atrasos
		injustificados no cumprimento das obriga��es assumidas pela
		fornecedora sujeit�-la-� � multa di�ria, at� a data do efetivo
		adimplemento, de 0,3% (tr�s d�cimos por cento), calculada � base de
		juros compostos, sem preju�zo das demais penalidades previstas na Lei
		n� 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.6.1 - A multa morat�ria
		estabelecida ficar� limitada � estipulada para inexecu��o parcial ou
		total do Registro de Pre�os (subitem8.4.1)</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.6.2 - O per�odo de atraso
		ser� contado em dias corridos.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.7 - A multa dever�
		ser paga no prazo de 30 (trinta) dias, contados da data do recebimento
		da intima��o por via postal, ou data da juntada aos autos do mandado
		de intima��o cumprido, conforme o caso.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.8 - Caso a multa
		n�o seja paga no prazo estabelecido no item 8.7, dever� ser descontada
		dos pagamentos do respectivo Registro de Pre�os, ou, ainda, cobrada
		judicialmente, se for o caso.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.9 - A atualiza��o
		dos valores correspondentes �s multas estabelecidas neste Registro de
		Pre�os dar-se-� atrav�s do IPCA-E/IBGE, tendo em vista o disposto no
		art. 1� da Lei n� 8.383, de 30/12/91 ou de outro �ndice,
		posteriormente determinado em lei.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.10 - A contagem
		dos prazos dispostos neste Registro de Pre�os obedecer� ao disposto no
		art. 110, da Lei n� 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.11 - Os
		procedimentos de aplica��o e recolhimento das multas foram
		regulamentadas pela IN 24-12, do Egr�gio Tribunal Regional Federal da
		2� Regi�o.</p>

		<p><b><u>CL&Aacute;USULA NONA - DA DOCUMENTA��O
		COMPLEMENTAR</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">9.1 - Fazem parte
		integrante do presente Registro de Pre�os, independentemente de
		transcri��o, os seguintes documentos:</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) Preg�o n� <b>${pregao
		}</b>/(<b>${ano }</b>) e seus anexos.<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) Proposta da(s)
		Fornecedora(s) apresentada � Justi�a Federal em ${ano }.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA - DA PUBLICA��O</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">10.1 - O presente
		Registro de Pre�os ser� publicado no Di�rio Oficial da Uni�o, na forma
		de extrato, de acordo com o que determina do par�grafo �nico do artigo
		61 da Lei n� 8.666/93;</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 8� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 9</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA D�CIMA PRIMEIRA - DA FISCALIZA��O</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">11.1 - A entrega dos
		materiais e a execu��o dos servi�os ser�o acompanhadas e fiscalizadas
		por servidor/Comiss�o designados pela Administra��o.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">11.2 - O
		representante anotar� em registro pr�prio todas as ocorr�ncias
		relacionadas com a entrega dos materiais e execu��o dos servi�os
		mencionados, determinando o que for necess�rio � regulariza��o das
		faltas ou defeitos observados.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">11.3 - As decis�es e
		provid�ncias que ultrapassarem a compet�ncia do representante ser�o
		solicitadas a seus superiores em tempo h�bil para a ado��o das medidas
		convenientes.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">11.4 - O exerc�cio
		da fiscaliza��o pela Justi�a Federal n�o excluir� a responsabilidade
		da(s) Fornecedora(s).</p>

		<p><b><u>CL&Aacute;USULA D�CIMA SEGUNDA - DOS RECURSOS
		ADMINISTRATIVOS</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">12.1 - Aplica-se o
		disposto no art. 109 da lei 8.666/93.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA TERCEIRA - DAS
		CONSIDERA��ES FINAIS </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">13.1 - O Registro de
		Pre�os poder� ser aditado nos termos previstos no art. 65 da Lei n�
		8.666/93, com a apresenta��o das devidas justificativas.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">13.2 - A(s)
		Fornecedora(s) dever�(�o) manter durante toda a validade do Registro
		de Pre�os, em compatibilidade com as obriga��es por ela assumidas,
		todas as condi��es de habilita��o e qualifica��o exigidas na
		licita��o.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">13.3. N�o constitui
		obriga��o da JUSTI�A FEDERAL a aquisi��o de qualquer quantidade dos
		itens objeto da presente Ata.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 9� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="1">Processo n� ${n1}/${n2 }/${n3 } - EOF -
		Ata de Registro de Pre�os n� ${ataregpreco}/ ${ano} - Fornec. e
		Instala��o de ${forninst } &nbsp;&nbsp; 10</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA D�CIMA QUARTA - DO FORO </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">14.1 - Para dirimir
		as quest�es oriundas da presente Ata de Registro de Pre�os, fica
		eleito o Foro da Justi�a Federal - Se��o Judici�ria do Rio de Janeiro.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E por estarem ajustados, �
		lavrada a presente Ata, extra�da em 03 (tr�s) vias de igual teor e
		forma, que depois de lida e achada conforme vai assinada pelas partes.
		</p>
		</font>

		<br>
		<br>
		<font size="2">
		<p align="right"><b>${doc.dtExtenso}</b><br>
		<br>
		<br>
		<br>
		<br>

		________________________________________________<br>
		JUSTI�A FEDERAL DE 1� GRAU NO RIO DE JANEIRO<br>
		<br>
		<br>
		<br>
		<br>
		<br>

		________________________________________________<br>
		FORNECEDORA(S) <br>
		<br>
		<br>
		<br>
		</p>
		</font>

		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		</body>
		</html>

	</mod:documento>
</mod:modelo>
