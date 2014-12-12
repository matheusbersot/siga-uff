<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- 
     Modelo : Ata de Registro de Preco Sem Contrato
     Data da Criacao : 16/01/2007
     Ultima alteracao : 17/01/2007 
-->

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="Detalhes do Contrato" />
		<mod:grupo>
			<mod:monetario titulo="N� da Ata de Registro de Pre�os"
				var="numeroAta" largura="10" maxcaracteres="8" verificaNum="sim" />
			<mod:monetario titulo="Ano" var="anoAta" largura="6"
				maxcaracteres="4" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo>
			<mod:monetario titulo="Processo N�" var="numProcesso" largura="8"
				maxcaracteres="6" verificaNum="sim" />
			<mod:monetario titulo="Ano" var="anoProcesso" largura="6"
				maxcaracteres="4" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo titulo="Dados do Juiz" />
		<mod:grupo>
			<mod:texto titulo="Juiz Federal - Diretor do Foro" var="nomeJuiz"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:monetario titulo="Documento de Identidade" var="docIdentidade"
				largura="12" maxcaracteres="10" verificaNum="sim" />
			<mod:texto titulo="Org�o Emissor" var="orgaoEmissor" largura="12"
				maxcaracteres="10" />
			<mod:monetario titulo="CPF" var="cpfJuiz" largura="13"
				maxcaracteres="11" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo titulo="Dados do Preg�o"/>		
		<mod:grupo>
			<mod:monetario titulo="N�mero do Preg�o" var="numeroPregao"
				largura="12" maxcaracteres="10" verificaNum="sim" />
			<mod:monetario titulo="Ano do Preg�o" var="anoPregao" largura="6"
				maxcaracteres="4" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo titulo="Dados da Empresa Fornecedora" />		
		<mod:grupo>
			<mod:texto titulo="Empresa Vencedora" var="nomeEmpresa" largura="70"
				maxcaracteres="60" />
			<mod:monetario titulo="CGC/CNPJ" var="cgcEmpresa" largura="16"
				maxcaracteres="14" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo titulo="Dados do Objeto Fornecido" />		
		<mod:grupo>
			<mod:texto titulo="Descri��o do Fornecimento"
				var="descricaoFornecimento" largura="55" maxcaracteres="50" />
		</mod:grupo>
		<mod:selecao titulo="N�mero de Itens do Registro de Pre�o"
			var="numItens" opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
		<c:forEach var="i" begin="1" end="${numItens}">
			<mod:grupo>
				<mod:texto titulo="Item a ser fornecido" var="material${i}"
					largura="32" maxcaracteres="30" />
				<mod:monetario titulo="Quantidade" var="quantidadeItem${i}"
					largura="12" maxcaracteres="10" verificaNum="sim" />
				<mod:monetario titulo="Pre�o Unit�rio Registrado"
					var="precoItem${i}" largura="12" maxcaracteres="10"
					formataNum="sim" />
			</mod:grupo>
		</c:forEach>
		<mod:grupo>
			<mod:numero titulo="Prazo em dias para entrega" var="prazoDias"
				largura="6" maxcaracteres="4" extensoNum="sim" />
			<mod:oculto var="prazoDiasnumextenso" valor="${prazoDiasnumextenso}" />
		</mod:grupo>
		<mod:grupo titulo="Local para Entrega"/>		
		<mod:grupo>
			<mod:texto titulo="Endere�o para entrega" var="enderecoEntrega"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Bairro" var="bairroEntrega" largura="34"
				maxcaracteres="30" />
			<mod:texto titulo="Estado" var="estadoEntrega" largura="34"
				maxcaracteres="30" />
		</mod:grupo>
		<mod:selecao titulo="mesmo local para entrega das Notas Fiscais"
			var="entregaNF" opcoes="SIM;N�O" reler="sim" />
		<c:if test="${entregaNF=='N�O'}">
			<mod:grupo>
				<mod:texto titulo="Endere�o para entrega da NF" var="enderecoNota"
					largura="70" maxcaracteres="60" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Bairro" var="bairroNota" largura="32"
					maxcaracteres="30" />
				<mod:texto titulo="Estado" var="estadoNota" largura="32"
					maxcaracteres="30" />
			</mod:grupo>
		</c:if>
		<mod:grupo>
			<mod:numero titulo="Vig�ncia da Ata de Registro de Pre�os (em meses)"
				var="prazoMeses" largura="5" maxcaracteres="3" extensoNum="sim" />
			<mod:oculto var="prazoMesesnumextenso"
				valor="${prazoMesesnumextenso}" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Programa de Trabalho" var="programaTrabalho"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Elemento de Despesa" var="elementoDespesa"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto
				titulo="Nome da Subsecretaria respons�vel pela especifica��o"
				var="nomeSubsecretaria" largura="70" maxcaracteres="60" />
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			     @page {
					margin-left: 2cm;
					margin-right: 2cm;
					margin-top: 1cm;
					margin-bottom: 2cm;
			 	 }
		    </style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
			<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp"/>
		</td></tr>
			<tr> 
				<td width="100%">
					<table width="100%">				
						<tr>
						   <td>
                              <u><font size="2">Processo n�${numProcesso}/${anoProcesso}-EOF -Ata de RP n�${numeroAta}/${anoAta} - Fornecimento de ${descricaoFornecimento} </font></u>                              
						   </td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF">
		 <tr>
		   <td>
		     <c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" />
		   </td>
		 <tr>
		   <td>    
             <u><font size="2">Processo n�${numProcesso}/${anoProcesso}-EOF -Ata de RP n�${numeroAta}/${anoAta} - Fornecimento de ${descricaoFornecimento}</font></u>
           </td>
         </tr>
        </table>     
		FIM CABECALHO -->
		<!--    daqui pra baixo  -->
		<font size="3">
		<p align="center"><b> ATA DE REGISTRO DE PRE�OS N.�
		${numeroAta}/${anoAta}<br>
		PROCESSO N� ${numProcesso}/${anoProcesso} -EOF </b></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">A Justi�a Federal de
		1� Grau no Rio de Janeiro, com sede na Av. Rio Branco, 243 - Anexo I -
		14� andar, Centro/RJ, inscrita no C.N.P.J. sob o n�
		05.424.540/0001-16, neste ato representada pelo Dr.<b>${nomeJuiz}</b>,
		Juiz Federal - Diretor do Foro, Identidade n� <b>${docIdentidade}-${orgaoEmissor}</b>,
		CPF:<b>${cpfJuiz}</b>, doravante denominada JUSTI�A FEDERAL, resolve,
		em face das propostas apresentadas no <b>Preg�o n.�
		${numeroPregao}/${anoPregao}, REGISTRAR O PRE�O</b> da empresa
		classificada em primeiro lugar para o objeto da licita��o e igualmente
		daquelas que manifestaram interesse em se registrar tamb�m pelo menor
		pre�o, doravante denominadas FORNECEDORAS, em conformidade com o
		disposto na Lei n� 10.520, de 17/07/2002, Decreto n� 3.555, de
		08/08/2000 e n� 3.931, de 19/072001 e, subsidiariamente, a Lei n�
		8.666, de 21/06/93 e suas altera��es, mediante as cl�usulas e
		condi��es a seguir:<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"><u><strong>CL�USULA
		PRIMEIRA - DO OBJETO</strong></u><br>
		<br>
		1.1 - A presente ata tem por objeto o <b>Registro de Pre�os</b> para o
		fornecimento de ${descricaoFornecimento}, conforme especifica��es
		constantes do Termo de Refer�ncia do Edital do <b>Preg�o n.�
		${numeroPregao}/${anoPregao}</b>, que integram a presente Ata, e Pre�o(s)
		Registrado(s) e Empresa(s) Fornecedora(s).<br>
		1.2 - A aquisi��o dos materiais objeto da presente Ata ser� de acordo
		com as necessidades e conveni�ncias da Justi�a Federal.<br>
		1.3- Qualquer �rg�o ou entidade da Administra��o P�blica Federal
		poder� utilizar a Ata de Registro de de Pre�os durante a sua vig�ncia,
		desde que manifeste interesse e mediante pr�via consulta � Justi�a
		Federal do Rio de Janeiro.<br>
		1.4- Caber� ao fornecedor benefici�rio da Ata de Registro de Pre�os,
		observadas as condi��es nela estabelecidas, optar pela aceita��o ou
		n�o do fornecimento, independentemente dos quantitativos registrados
		em Ata, desde que este fornecimento n�o prejudique as obriga��es
		anteriormente assumidas.<br>
		1.5- As aquisi��es adicionais de que trata o subitem 1.3 n�o poder�o
		exceder, por �rg�o ou entidade, a 100% (cem por cento) dos
		quantitativos registrados em Ata de Registro de Pre�os.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"><u><strong>CL�USULA
		SEGUNDA - DO PRAZO DE ENTREGA</strong></u><br>
		<br>
		2.1. O prazo para entrega dos materiais, objeto do presente Registro
		de Pre�os, expressamente solicitado, ser� de, no maximo, <b>${prazoDias}
		( ${prazoDiasnumextenso})</b> dias, contados a partir do recebimento da
		"Solicita��o de Fornecimento" <b>(Anexo VI)</b>, respeitando o
		estabelecido nas Especifica��es constantes do <b>Anexo I</b> - Termo
		de Refer�ncia do <b>Preg�o n.� ${numeroPregao}/${anoPregao}</b><br>
		<b>OBS:<i>O prazo de entrega dos materiais ser� preenchido nos
		termos da proposta da licitante vencedora, observado o prazo m�ximo
		estipulado na Especifica��o.</i></b><br>
		2.2 - A Justi�a Federal far� as aquisi��es mediante a emiss�o da
		"Solicita��o de Fornecimento" <b>(Anexo VI)</b>, quando ent�o ser�
		expedida Nota de Empenho correspondente a tal solicita��o.<br>
		&nbsp&nbsp 2.2.1 - A(s) Fornecedora(s) receber�(�o), atrav�s de
		of�cio, com ou sem AR, ou via fax, ou ainda por e-mail, a Solicita��o
		de Fornecimento acompanhada da Nota de Empenho.<br>
		2.3 - Ser� considerada como confirma��o de recebimento o recibo dado
		no Of�cio expedido, o relat�rio emitido pelo aparelho de fax, a
		mensagem de e-mail enviada e a certid�o, dada pelo servidor
		respons�vel, de haver entregue o Of�cio ou do mesmo haver sido
		recusado.<br>
		2.4 - Os materiais dever�o ser entregues na <b>${enderecoEntrega}</b>
		- Bairro:<b>${bairroEntrega}</b> - Estado:<b> ${estadoEntrega}</b>,
		conforme estabelecido nas Especifica��es constantes do <b>Anexo I</b>
		- Termo de Refer�ncia do <b>Preg�o n� ${numeroPregao}/${anoPregao}</b><br>
		</p>
		</font>
		<p style="TEXT-INDENT: 1.5cm" align="justify"><u><b>CL�USULA
		TERCEIRA - DO PRE�O E PAGAMENTO</b></u><br>
		<br>
		<font size="1">
		<table width="100%" border="0" cellpadding="1">
			<tr>
				<td></td>
				<td width="10%" align="center">ITEM</td>
				<td width="30%" align="center">ESPECIFICA��O</td>
				<td width="20%" align="center">QUANTIDADE</td>
				<td width="40%" align="center">PRE�O UNIT�RIO REGISTRADO</td>
			</tr>
			<table width="100%" border="0" cellpadding="1">
				<c:forEach var="m" begin="1" end="${numItens}">
					<tr>
						<td>${m}</td>
						<td>${requestScope[f:concat('material',m)]}</td>
						<td>${requestScope[f:concat('quantidadeItem',m)]}</td>
						<td>${requestScope[f:concat('precoItem',m)]}</td>
						<td></td>
					</tr>
				</c:forEach>
			</table>
			<table width="100%" cellpading="3">
				<tr>
					<td><font size="1"> EMPRESA VENCEDORA : ${nomeEmpresa}
					</font></td>
				</tr>
			</table>
		</table>
		</font><font size="3">
		<p style="TEXT-INDENT: 1.5cm" align="justify">3.1. A JUSTI�A
		FEDERAL pagar� �(s) FORNECEDORA(S) o valor unit�rio registrado no
		item, multiplicado pela quantidade solicitada, que constar� da
		Solicita��o de Fornecimento <b>(Anexo VI)</b> e da Nota de Empenho, e
		ainda do Termo de Contrato, quando for o caso.<br>
		3.2. Inclu�dos no pre�o unit�rio est�o todos os impostos, taxas e
		encargos sociais, obriga��es trabalhistas, previdenci�rias, fiscais e
		comerciais, assim como despesas com transportes, as quais correr�o por
		conta das FORNECEDORA(S).<br>
		<c:if test="${numItens > 6}"></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"></c:if> 3.3. Os pre�os
		registrados dever�o sempre ser adequados ao valor de mercado, sob pena
		de n�o haver a aquisi��o.<br>
		3.4. As Notas de Empenho, quando for o caso, ser�o emitidas � medida
		que forem sendo solicitados os materiais.<br>
		3.5 - As Notas Fiscais/Faturas dever�o ser entregues na Rua <c:if
			test="${entregaNF=='N�O'}">
			<b>${enderecoNota}</b>
		</c:if> <c:if test="${entregaNF=='SIM'}">
			<b>${enderecoEntrega}</b>
		</c:if> conforme Especifica��es constantes do <b>Anexo I</b> - Termo de
		Refer�ncia do <b>Preg�o n� ${numeroPregao}/${anoPregao}</b> <c:if
			test="${numItens < 6}"></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"></c:if> 3.6 - O pagamento �
		Fornecedora ser� efetivado, por cr�dito em conta corrente, mediante
		ordem banc�ria, at� o 10� dia �til ap�s a apresenta��o da fatura ou
		nota fiscal discriminativa do material entregue, devidamente atestada
		por servidor ou Comiss�o nomeada pela Administra��o, salvo eventual
		atraso de distribui��o de recursos financeiros efetuados pelo Conselho
		da Justi�a Federal, decorrente de execu��o or�ament�ria.<br>
		&nbsp&nbsp&nbsp 3.6.1 - No per�odo acima n�o haver� atualiza��o
		financeira.<br>
		&nbsp&nbsp&nbsp 3.6.2 - A fatura/nota fiscal dever� ser apresentada em
		02 (duas) vias.<br>
		&nbsp&nbsp&nbsp 3.6.3 - Ser� considerada como data do pagamento a data
		da emiss�o da Ordem Banc�ria.<br>
		3.7 - Caso seja necess�ria a retifica��o da fatura por culpa da(s)
		Fornecedora(s), a flu�ncia do prazo de 10 (dez) dias �teis ser�
		suspensa, reiniciando-se a contagem a partir da reapresenta��o da
		fatura retificada.<br>
		3.8 - A Justi�a Federal reserva-se o direito de n�o efetuar o
		pagamento se, no ato da atesta��o, o material n�o estiver em perfeitas
		condi��es ou de acordo com as especifica��es apresentadas e aceitas
		pela Justi�a Federal.<br>
		3.9 - A Se��o Judici�ria do Rio de Janeiro poder� deduzir da
		import�ncia a pagar os valores correspondentes a multas ou
		indeniza��es devidas pela Contratada nos termos do presente ajuste.<br>
		3.10 - A(s) Fornecedora(s) dever�(�o) comprovar, quando da
		apresenta��o da nota fiscal � Justi�a Federal, a regularidade perante
		a Seguridade Social e ao Fundo de Garantia de Tempo de Servi�o,
		atrav�s da apresenta��o da CND e do CRF, dentro das respectivas
		validade, sob pena de n�o pagamento do material fornecido e de
		rescis�o contratual, em atendimento ao disposto no � 3�. do art. l95
		da Constitui��o Federal, no art. 2� da Lei 9.012/95, e nos arts. 55,
		inciso VIII e 78, inciso I, ambos da Lei 8.666/93.<br>
		3.11 - Na ocasi�o da entrega da nota fiscal a(s) Fornecedora(s)
		dever�(�o) comprovar a condi��o de optante pelo SIMPLES (Sistema
		Integrado de Pagamento de Impostos e Contribui��es das Microempresas e
		Empresas de pequeno Porte), mediante a apresenta��o da declara��o
		indicada em ato normativo da Secretaria da Receita Federal, e dos
		documentos, devidamente autenticados, que comprovem ser o signat�rio
		da referida declara��o representante legal da empresa.<br>
		&nbsp&nbsp&nbsp As pessoas jur�dicas n�o optantes pelo SIMPLES e
		aquelas que ainda n�o formalizaram a op��o sofrer�o a reten��o de
		impostos/contribui��es por esta Se��o Judici�ria no momento do
		pagamento, conforme disposto no art. 64 da Lei n� 9.430, de 27/12/96,
		regulamentado por ato normativo da Secretaria da Receita Federal.<br>
		</p>
		<p align="left"><u><b>CL�USULA QUARTA - DO RECEBIMENTO DO
		MATERIAL </b></u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">4.1 - O recebimento
		do objeto da presente Ata de Registro de Pre�os dar-se-�:<br>
		</p>
		<c:if test="${numItens < 6}"></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"></c:if> &nbsp&nbsp&nbsp
		4.1.1 - provisoriamente, no ato da entrega do material e da
		apresenta��o das Faturas/Notas Fiscais discriminativas, pela Se��o de
		Almoxarifado/SMA.<br>
		4.1.2 - definitivamente, no prazo de at� 05 (cinco) dias �teis
		contados do recebimento provis�rio, ap�s confer�ncia da conformidade
		do material.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"><u><b>
		CL�USULA QUINTA - DA VIG�NCIA </b></u><br>
		<br>
		5.1 - A presente Ata de Registro de Pre�os ter� vig�ncia de
		${prazoMeses} (${prazoMesesnumextenso}) meses, contada a partir da
		data da assinatura da mesma.<br>
		<font size="2"><b>PAR�GRAFO �NICO:</b></font>A presente Ata poder� ser
		prorrogada, na forma autorizada pelo art. 4� do Decreto n� 3.931/2001.<br>
		</p>
		<p align="left"><u> <b> CL�USULA SEXTA - DOTA��O
		OR�AMENT�RIA </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">6.1 - As despesas
		decorrentes do fornecimento do objeto deste Registro de Pre�os,
		correr�o � conta dos recursos consignados � Se��o Judici�ria do Rio de
		Janeiro, para o corrente exerc�cio, conforme o especificado a seguir:<br>
		&nbsp&nbsp&nbsp Programa de Trabalho: <b>${programaTrabalho}</b><br>
		&nbsp&nbsp&nbsp Elemento de Despesa:<b> ${elementoDespesa}</b></p>
		<p align="left"><u><b>CL�USULA S�TIMA - DAS OBRIGA��ES
		DA(S) FORNECEDORA(S):</b></u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">7.1 - S�o obriga��es
		da(s) Fornecedora(s): &nbsp&nbsp&nbsp 7.1.1 - entregar os materiais,
		objeto deste Registro de Pre�os, de acordo com as especifica��es
		constantes do <b>Anexo I</b>- Termo de Refer�ncia do <b>Preg�o n�
		${numeroPregao}/${anoPregao}</b>, em conson�ncia com a proposta
		respectiva, bem como a cumprir com o prazo de entrega e quantidades
		constantes da Solicita��o de Fornecimento<b>(Anexo VI)</b>.<br>
		&nbsp&nbsp&nbsp 7.1.2 - manter, durante todo o per�odo de vig�ncia da
		Ata de Registro de Pre�os, em compatibilidade com as obriga��es
		assumidas, todas as condi��es de habilita��o e qualifica��o exigidas
		no <b>Preg�o n� ${numeroPregao}/${anoPregao}</b>.<br>
		&nbsp&nbsp&nbsp 7.1.3 - fornecer aos seus funcion�rios crach�s de
		identifica��o, sem os quais n�o ser� autorizada a entrada nas
		depend�ncias da Contratante.<br>
		7.2 - A(s) Fornecedora(s) �(s�o) respons�vel(eis) por:<br>
		&nbsp&nbsp&nbsp 7.2.1 - qualquer acidente que venha a ocorrer com seus
		empregados e por danos que estes provoquem � Justi�a Federal ou a
		terceiros, n�o excluindo essa responsabilidade a fiscaliza��o ou o
		acompanhamento pela Justi�a Federal; <br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">&nbsp&nbsp&nbsp
		7.2.2 - todos os encargos previdenci�rios e obriga��es sociais
		previstos na legisla��o social trabalhista em vigor relativos a seus
		funcion�rios, vez que os mesmos n�o manter�o nenhum v�nculo
		empregat�cio com a Se��o Judici�ria do Rio de Janeiro;<br>
		&nbsp&nbsp&nbsp 7.2.3 - todas as provid�ncias e obriga��es
		estabelecidas na legisla��o espec�fica de acidentes de trabalho,
		quando, em ocorr�ncia da esp�cie, forem v�timas os seus funcion�rios
		quando da realiza��o da entrega dos materiais, ou em conex�o com eles;<br>
		&nbsp&nbsp&nbsp 7.2.4 - todos os encargos fiscais e comerciais
		decorrentes do presente Registro de Pre�os;<br>
		7.3 - A inadimpl�ncia da(s) Fornecedora(s), com refer�ncia aos
		encargos sociais, comerciais e fiscais, n�o transfere a
		responsabilidade por seu pagamento � Administra��o da Se��o Judici�ria
		do Rio de Janeiro, raz�o pela qual a(s) Fornecedora(s) renuncia(m)
		expressamente a qualquer v�nculo de solidariedade, ativa ou passiva,
		com a SJRJ.<br>
		7.4 - A(s) Fornecedora(s) dever�(�o) cumprir, ainda, com as demais
		obriga��es constantes da especifica��o elaborada pela Subsecretaria de
		${nomeSubsecretaria} que integra o presente Registro de Pre�os.<br>
		</p>
		<p align="left"><u> <b> CL�USULA OITAVA - DO CANCELAMENTO
		DO REGISTRO </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">8.1 - O fornecedor
		ter� seu registro cancelado quando:<br>
		&nbsp&nbsp&nbsp I - descumprir as condi��es da Ata de Registro de
		Pre�os;<br>
		&nbsp&nbsp&nbsp II - n�o retirar a respectiva nota de empenho ou
		instrumento equivalente, no prazo estabelecido pela Administra��o, sem
		justificativa aceit�vel;<br>
		&nbsp&nbsp&nbsp III - n�o aceitar reduzir o seu pre�o registrado, na
		hip�tese de este se tornar superior �queles praticados no mercado;<br>
		&nbsp&nbsp&nbsp IV - tiver presentes raz�es de interesse p�blico.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify"><b>PAR�GRAFO 1�
		-</b> O cancelamento de registro, nas hip�teses previstas, assegurados o
		contradit�rio e a ampla defesa, ser� formalizado por despacho da
		autoridade competente do �rg�o gerenciador.<br>
		<b>PAR�GRAFO 2� -</b> A(s) fornecedora(s) poder�(�o) solicitar o
		cancelamento do seu registro de pre�o na ocorr�ncia de fato
		superveniente que venha comprometer a perfeita execu��o contratual,
		decorrentes de caso fortuito ou de for�a maior devidamente
		comprovados.<br>
		</p>
		<p align="left"><u> <b> CL�USULA NONA - DAS PENALIDADES </b> </u>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">9.1 - O n�o
		cumprimento pela(s) Fornecedora(s) de qualquer uma das obriga��es,
		dentro das especifica��es e/ou condi��es predeterminadas nesta Ata de
		Registro de Pre�os, sujeit�-la-� �s penalidades previstas nos artigos
		86 a 88 da Lei n� 8.666/93;<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">9.2 - As penalidades
		a que est� sujeita a(s) Fornecedora(s) inadimplente(s), nos termos da
		Lei no 8.666/93, s�o as seguintes:<br>
		&nbsp&nbsp&nbsp a)Advert�ncia;<br>
		&nbsp&nbsp&nbsp b)multa;<br>
		&nbsp&nbsp&nbsp c)suspens�o tempor�ria de participar em licita��o e
		impedimento em contratar com a<br>
		Administra��o por prazo n�o superior a 02 (dois) anos;<br>
		9.3 - A recusa injustificada em assinar a Ata de Registro de Pre�os,
		aceitar ou retirar o instrumento equivalente, dentro do prazo
		estabelecido pela Administra��o, sujeita o adjudicat�rio � penalidade
		de multa de at� 10% (dez por cento) sobre o valor da adjudica��o,
		independentemente da multa estipulada no subitem 9.4.2.<br>
		9.4 - A inexecu��o total ou parcial do Registro de Pre�os poder�
		acarretar, a crit�rio da Administra��o, a aplica��o das multas,
		alternativamente:<br>
		</p>
		<p style="TEXT-INDENT: 2.0cm" align="justify">9.4.1 - Multa
		compensat�ria de at� 30% (trinta por cento) sobre o valor equivalente
		� obriga��o inadimplida.<br>
		9.4.2 - Multa correspondente � diferen�a entre o valor total
		porventura resultante de nova contrata��o e o valor total que seria
		pago ao adjudicat�rio.<br>
		9.4.3 - Multa de 50% (cinq�enta por cento) sobre o valor global do
		Registro de Pre�os, no caso de inexecu��o total do mesmo.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">9.5 - A atualiza��o
		dos valores correspondentes � multa estabelecida no item 9.4 far-se-�
		a partir do 1� (primeiro) dia, decorrido o prazo estabelecido no item
		9.7.<br>
		9.6 - Os atrasos injustificados no cumprimento das obriga��es
		assumidas pela fornecedora sujeit�-la-� � multa di�ria, at� a data do
		efetivo adimplemento, de 0,3% (tr�s d�cimos por cento), calculada �
		base de juros compostos, sem preju�zo das demais penalidades previstas
		na Lei n� 8.666/93.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">9.7 - A multa dever�
		ser paga no prazo de 30 (trinta) dias, contados da data do recebimento
		da intima��o por via postal, ou da data da juntada aos autos do
		mandado de intima��o cumprido, conforme o caso.<br>
		9.8 - Caso a multa n�o seja paga no prazo estabelecido no item 9.7,
		dever� ser descontada dos pagamentos do respectivo Registro de Pre�os,
		ou, ainda, cobrada judicialmente, se for o caso.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">9.9 - A atualiza��o
		dos valores correspondentes �s multas estabelecidas neste Registro de
		Pre�os dar-se-� atrav�s do IPCA-E/IBGE, tendo em vista o disposto no
		art. 1� da Lei n� 8.383, de 30/12/91 ou de outro �ndice,
		posteriormente determinado em lei.<br>
		9.10 - A contagem dos prazos dispostos neste Registro de Pre�os
		obedecer� ao disposto no art. 110, da Lei n� 8.666/93.<br>
		9.11 - Os procedimentos de aplica��o e recolhimento das multas foram
		regulamentadas pela IN 24-12, do Egr�gio Tribunal Regional Federal da
		2� Regi�o.<br>
		</p>
		<p align="left"><u><b>CL�USULA D�CIMA - DA DOCUMENTA��O
		COMPLEMENTAR: </b></u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">10.1 - Fazem parte
		integrante do presente Registro de Pre�os, independentemente de
		transcri��o, os seguintes documentos:<br>
		<p style="TEXT-INDENT: 2.0cm" align="justify">a) <b>Preg�o n�
		${numeroPregao}/${anoPregao}</b> e seus anexos.<br>
		b) Proposta da(s) Fornecedora(s) apresentada � Justi�a Federal em
		......./....../20......</p>
		<p align="left"><u><b>CL�USULA D�CIMA PRIMEIRA - DA
		PUBLICA��O</b></u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">11.1 - O presente
		Registro de Pre�os ser� publicado no Di�rio Oficial da Uni�o, na forma
		de extrato, de acordo com o que determina do par�grafo �nico do artigo
		61 da Lei n� 8.666/93;<br>
		</p>
		<p align="left"><u><b>CL�USULA D�CIMA SEGUNDA - DA
		FISCALIZA��O </b></u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">12.1 - A entrega dos
		materiais ser� acompanhada e fiscalizada por servidores/Comiss�o
		designados pela Administra��o.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">12.2 - O
		representante anotar� em registro pr�prio todas as ocorr�ncias
		relacionadas com a entrega dos materiais, determinando o que for
		necess�rio � regulariza��o das faltas ou defeitos observados.<br>
		12.3 - As decis�es e provid�ncias que ultrapassarem a compet�ncia do
		representante ser�o solicitadas a seus superiores em tempo h�bil para
		a ado��o das medidas convenientes.<br>
		12.4 - O exerc�cio da fiscaliza��o pela Justi�a Federal n�o excluir� a
		responsabilidade da(s) Fornecedora(s).<br>
		</p>
		<p align="left"><u><b>CL�USULA D�CIMA TERCEIRA - DOS
		RECURSOS ADMINISTRATIVOS </b></u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">13.1 - Aplica-se o
		disposto no art. 109 da lei 8.666/93.<br>
		</p>
		<p align="left"><u> <b> CL�USULA D�CIMA QUARTA - DAS
		CONSIDERA��ES FINAIS: </b></u>
		</font>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">14.1 - O Registro de
		Pre�os poder� ser aditado nos termos previstos no art. 65 da Lei n�
		8.666/93, com a apresenta��o das devidas justificativas.<br>
		14.2 - A(s) Fornecedora(s) dever�(�o) manter durante toda a validade
		do Registro de Pre�os, em compatibilidade com as obriga��es por ela
		assumidas, todas as condi��es de habilita��o e qualifica��o exigidas
		na licita��o.<br>
		14.3. N�o constitui obriga��o da JUSTI�A FEDERAL a aquisi��o de
		qualquer quantidade dos itens objeto da presente Ata.<br>
		</p>
		<u><b>CL�USULA D�CIMA QUINTA - DO FORO </b></u>
		<p style="TEXT-INDENT: 1.5cm" align="justify">15.1 - Para dirimir
		as quest�es oriundas da presente Ata de Registro de Pre�os, fica
		eleito o Foro da Justi�a Federal - Se��o Judici�ria do Rio de Janeiro.<br>
		</p>
		<p style="TEXT-INDENT: 2.0cm" align="justify">E por estarem
		ajustados, � lavrada a presente Ata, extra�da em 03 (tr�s) vias de
		igual teor e forma, que depois de lida e achada conforme vai assinada
		pelas partes.<br>
		<br>
		</p>
		<p align="right">${doc.dtExtenso}<br>
		<br>

		________________________________________________<br>
		JUSTI�A FEDERAL DE 1� GRAU NO RIO DE JANEIRO<br>
		<br>


		________________________________________________<br>
		FORNECEDORA(S)<br>
		<br>
		</p>
		</font>
		<!-- INICIO PRIMEIRO RODAPE
       		  <c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
	  	    FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		       <c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
	    	FIM RODAPE -->
		</body>
		</html>
	</mod:documento>
</mod:modelo>
