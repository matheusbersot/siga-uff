<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- 
     Modelo : Contrato de Material de Consumo - Entrega Parcelada
     Data da Criacao : 05/02/2007
     Ultima alteracao : 05/02/2007 
-->

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="Detalhes do Contrato" />
		<mod:grupo>
			<mod:monetario titulo="Termo de Contrato N�" var="numeroTermo"
				largura="10" maxcaracteres="8" verificaNum="sim" />
			<mod:monetario titulo="Ano" var="anoTermo" largura="6"
				maxcaracteres="4" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo>
			<mod:monetario titulo="Processo N�" var="numProcesso" largura="8"
				maxcaracteres="6" verificaNum="sim" />
			<mod:monetario titulo="Ano" var="anoProcesso" largura="6"
				maxcaracteres="4" verificaNum="sim" />
		</mod:grupo>
		<mod:grupo>
			<mod:grupo>
				<mod:monetario titulo="N�. do Preg�o" var="numeroPregao"
					largura="12" maxcaracteres="10" verificaNum="sim" />
				<mod:monetario titulo="Ano do Preg�o" var="anoPregao" largura="6"
					maxcaracteres="4" verificaNum="sim" />
				<mod:monetario titulo="N�. das Folhas do Auto"
					var="numeroFolhaAutos" largura="12" maxcaracteres="10"
					verificaNum="sim" />
			</mod:grupo>
			<mod:grupo titulo="Dados do Juiz" />
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
		<mod:grupo titulo="Dados da Empresa Fornecedora" />
		<mod:grupo>
			<mod:texto titulo="Empresa Fornecedora" var="nomeEmpresa"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Endere�o Comercial" var="enderecoEmpresa"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Bairro" var="bairroEmpresa" largura="34"
				maxcaracteres="30" />
			<mod:texto titulo="Estado" var="estadoEmpresa" largura="34"
				maxcaracteres="30" />
		</mod:grupo>
		<mod:grupo>
			<mod:monetario titulo="CGC/CNPJ" var="cgcEmpresa" largura="16"
				maxcaracteres="14" verificaNum="sim" />
			<mod:numero titulo="Telefone" var="telefoneEmpresa" largura="10"
				maxcaracteres="8" />
			<mod:numero titulo="FAX" var="faxEmpresa" largura="10"
				maxcaracteres="8" />
		</mod:grupo>
		<mod:grupo titulo="Dados do Representante" />
		<mod:grupo>
			<mod:texto titulo="Nome do Representante" var="nomeRepresentante"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:numero titulo="Documento de Identidade"
				var="identidadeRepresentante" largura="12" maxcaracteres="10" />
			<mod:texto titulo="Org�o Emissor" var="orgaoEmissorRepresentante"
				largura="12" maxcaracteres="10" />
			<mod:numero titulo="CPF" var="cpfRepresentante" largura="13"
				maxcaracteres="11" />
		</mod:grupo>
		<mod:grupo titulo="Dados do Objeto Fornecido" />
		<mod:grupo>
			<mod:texto titulo="Material a ser Fornecido"
				var="descricaoFornecimento" largura="55" maxcaracteres="50" />
		</mod:grupo>
		<mod:grupo>
			<mod:numero titulo="Prazo em dias para entrega" var="prazoDias"
				largura="6" maxcaracteres="4" extensoNum="sim" />
			<mod:oculto var="prazoDiasnumextenso" valor="${prazoDiasnumextenso}" />
			<mod:texto titulo="Se��o Solicitante" var="secaoSolicitante"
				largura="34" maxcaracteres="30" />
		</mod:grupo>
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
		<mod:grupo>
			<mod:texto titulo="Se��o Recebedora" var="secaoRecebedora"
				largura="34" maxcaracteres="30" />
		</mod:grupo>
		<mod:selecao titulo="mesmo local para entrega das Notas Fiscais"
			var="entregaNF" opcoes="SIM;N�O" reler="sim" />
		<c:if test="${entregaNF=='N�O'}">
			<mod:grupo>
				<mod:texto titulo="Endere�o para entrega da NF"
					var="enderecoEntregaNota" largura="70" maxcaracteres="60" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Bairro" var="bairroEntregaNota" largura="32"
					maxcaracteres="30" />
				<mod:texto titulo="Estado" var="estadoEntregaNota" largura="32"
					maxcaracteres="30" />
			</mod:grupo>
		</c:if>
		<mod:grupo>
			<mod:monetario titulo="Valor do Fornecimento do Objeto"
				var="vrFornecimento" largura="12" maxcaracteres="10"
				formataNum="sim" extensoNum="sim" />
			<mod:oculto var="vrFornecimentovrextenso"
				valor="${vrFornecimentovrextenso}" />
			<mod:selecao titulo="por" var="tipoFornecimento"
				opcoes="Mensal;Unidade" />
		</mod:grupo>
		<mod:grupo>
			<mod:monetario titulo="Valor Global do Contrato" var="vrGlobal"
				largura="12" maxcaracteres="10" formataNum="sim" extensoNum="sim" />
			<mod:oculto var="vrGlobalvrextenso" valor="${vrGlobalvrextenso}" />
		</mod:grupo>
		<mod:grupo titulo="Prazo de Vig�ncia e Execu��o" />
		<mod:grupo>
			<mod:data titulo="Data Final do Contrato" var="dataFinal" />
			<mod:data titulo="Prazo de Execu��o de" var="dataInicio" />
			<mod:data titulo="a" var="dataFim" />
		</mod:grupo>
		<mod:grupo titulo="Dota��o Or�ament�ria" />
		<mod:grupo>
			<mod:texto titulo="Programa de Trabalho" var="programaTrabalho"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Elemento de Despesa" var="elementoDespesa"
				largura="70" maxcaracteres="60" />
		</mod:grupo>
		<mod:grupo>
			<mod:numero titulo="Nota de Empenho" var="notaEmpenho" largura="4"
				maxcaracteres="4" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Subsecretaria respons�vel" var="nomeSubsecretaria"
				largura="52" maxcaracteres="50" />
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
                              <u><font size="2">Processo n�${numProcesso}/${anoProcesso}-EOF - Minuta de Contrato n�${numeroTermo}/${anoTermo} - (Fornecimento de ${descricaoFornecimento} )</font></u>
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
             <u><font size="2">Processo n�${numProcesso}/${anoProcesso}-EOF - Minuta de Contrato n�${numeroTermo}/${anoTermo} - (Fornecimento de ${descricaoFornecimento} )</font></u>
           </td>
         </tr>
        </table>     
		FIM CABECALHO -->

		<!--    daqui pra baixo  -->
		<font size="3"><br>
		<table width="60%" border="0" bgcolor="#FFFFFF" align="right">
			<tr>
				<td width="100%" align="left"><b>TERMO DE CONTRATO N�
				${numeroTermo}/${anoTermo}</b></td>
			</tr>
			<tr>
				<td width="100%" align="justify"><b>CONTRATO DE
				FORNECIMENTO DE ${descricaoFornecimento}, QUE ENTRE SI CELEBRAM A
				JUSTI�A FEDERAL DE 1�. GRAU NO RIO DE JANEIRO E A EMPRESA
				${nomeEmpresa}</b></td>
			</tr>
			<tr>
				<td width="100%" align="left"><b>PROCESSO N�
				${numProcesso}/${anoProcesso} -EOF</b></td>
			</tr>
		</table>
		<p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">A Justi�a Federal de
		1�. Grau no Rio de Janeiro, inscrita no CNPJ sob o n�
		05.424.540./0001-16, com sede na Av. Rio Branco, 243 - Anexo I - 14�
		andar, Centro, Rio de Janeiro/RJ, neste ato representada pelo Dr.<b>
		${nomeJuiz}</b>, Juiz Federal - Diretor do Foro, Identidade n�<b>
		${docIdentidade} - ${orgaoEmissor}</b>, CPF: <b>${cpfJuiz}</b>, doravante
		denominada CONTRATANTE, e a empresa <b>${nomeEmpresa}</b>, TEL. <b>${telefoneEmpresa}</b>
		e FAX.<b>${faxEmpresa}</b>, estabelecida na <b>${enderecoEmpresa}
		- ${bairroEmpresa} - ${estadoEmpresa}</b> inscrita no C.N.P.J. sob o n�<b>
		${cgcEmpresa}</b>, representado neste ato pelo Sr.<b>
		${nomeRepresentante}</b>, Identidade n�<b> ${identidadeRepresentante}</b>,
		CPF n�<b> ${cpfRepresentante}</b>, doravante denominada CONTRATADA,
		tendo em vista o decidido no Processo Administrativo n�<b>
		${numProcesso}/${anoProcesso}</b>-EOF, por despacho do Exm�. Sr. Juiz
		Federal - Diretor do Foro (fls <b>${numeroFolhaAutos}</b> dos autos),
		firmam o presente contrato em conformidade com o disposto na Lei n�
		10.520, de 17/07/02, Decreto n�. 3.555, de 08/08/2000 e,
		subsidiariamente, a Lei n� 8.666/93 e suas altera��es, mediante �s
		cl�usulas e condi��es a seguir:</p>
		<p align="left"><u> <strong> CL�USULA PRIMEIRA - DO
		OBJETO: </strong> </u></p>
		<p id="p1" style="TEXT-INDENT: 1.5cm" align="justify">1.1 - O
		presente contrato tem por objeto o fornecimento de <b>${descricaoFornecimento}</b>
		</p>
		<p align="left"><u> <strong> CL�USULA SEGUNDA - DAS
		OBRIGA��ES DA CONTRATADA: </strong> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">2.1 - A Contratada
		obriga-se a:<br>
		&nbsp&nbsp&nbsp 2.1.1 - proceder ao fornecimento do produto, no prazo
		m�ximo de <b>${prazoDias}( ${prazoDiasnumextenso})</b> dias �teis, a
		contar da solicita��o feita pela <b>${secaoSolicitante}</b><br>
		&nbsp&nbsp&nbsp 2.1.2 - entregar o produto na <b>${secaoRecebedora}</b>,
		situada na <b>${enderecoEntrega} - ${bairroEntrega} -
		${estadoEntrega}</b><br>
		&nbsp&nbsp&nbsp 2.1.3 - cumprir com todas as obriga��es constantes no
		Termo de Refer�ncia do Preg�o n� <b>${numeroPregao}/${anoPregao}</b>,
		que integra o presente ajuste;<br>
		&nbsp&nbsp&nbsp 2.1.4 - manter, durante toda a execu��o do contrato,
		em compatibilidade com as obriga��es assumidas, todas as condi��es de
		habilita��o e qualifica��o exigidas no Preg�o n� <b>${numeroPregao}/${anoPregao}</b>.
		</p>
		<p align="left"><u><b>CL�USULA TERCEIRA - DAS OBRIGA��ES
		DA CONTRATANTE:</b></u></p>
		<div id="p1" style="TEXT-INDENT: 1.5cm" align="justify">3.1 -
		Caber� � Contratante:<br>
		&nbsp&nbsp&nbsp 3.1.1 - permitir acesso, aos empregados da Contratada,
		�s instala��es da Contratante para o fornecimento dos materiais
		constantes do objeto.<br>
		&nbsp&nbsp&nbsp 3.1.2 - prestar as informa��es e os esclarecimentos
		que venham a ser solicitados pelos empregados da Contratada.<br>
		&nbsp&nbsp&nbsp 3.1.3 - rejeitar qualquer material entregue em
		desacordo com as Especifica��es do Preg�o n� <b>${numeroPregao}/${anoPregao}</b>.<br>
		&nbsp&nbsp&nbsp 3.1.4 - solicitar que seja substitu�do o material que
		n�o atender �s Especifica��es do Preg�o n� <b>${numeroPregao}/${anoPregao}</b>.<br>
		&nbsp&nbsp&nbsp 3.1.5 - atestar as faturas correspondentes, por
		interm�dio da Fiscaliza��o, designada pela Administra��o.<br>
		</div>
		<div align="left"><u> <b> CL�USULA QUARTA - DO PRE�O: </b> </u></div>
		<div style="TEXT-INDENT: 1.5cm" align="justify">4.1 - A
		Contratante pagar� � Contratada, pelo fornecimento objeto deste
		Contrato, o valor de R$ <b>${vrFornecimento} (
		${vrFornecimentovrextenso} )</b> por <b>${tipoFornecimento}</b>.<br>
		4.2 - O valor global estimado para a presente contrata��o � de R$ <b>${vrGlobal}
		(${vrGlobalvrextenso})</b>.</div>
		<u><b>CL�USULA QUINTA - DO PAGAMENTO: </b></u>
		<p style="TEXT-INDENT: 1.5cm" align="justify">5.1 - O pagamento �
		contratada ser� efetivado at� o 10� (d�cimo) dia �til ap�s a
		apresenta��o da Nota Fiscal/Fatura discriminativa dos materiais
		entregues, devidamente atestada por servidor/Comiss�o de servidores
		competente, salvo eventual atraso de distribui��o de recursos
		or�ament�rios e financeiros pelo Conselho de Justi�a Federal,
		decorrente de execu��o or�ament�ria.<br>
		&nbsp&nbsp&nbsp a) A Fatura/Nota Fiscal dever� ser apresentada em 02
		(duas) vias e entregue na <b>${secaoRecebedora}</b> da <b>${nomeSubsecretaria}</b>,
		situada na <c:if test="${entregaNF=='N�O'}">
			<b>${enderecoEntregaNota},${bairroEntregaNota},${estadoEntregaNota}</b>.
		</c:if> <c:if test="${entregaNF=='SIM'}">
			<b>${enderecoEntrega},${bairroEntrega},${estadoEntrega}</b>.
		</c:if> <br>
		&nbsp&nbsp&nbsp b) No per�odo acima n�o haver� atualiza��o financeira.<br>
		&nbsp&nbsp&nbsp c) Caso seja necess�ria a retifica��o da fatura por
		culpa da contratada, a flu�ncia do prazo de 10 (dez) dias �teis ser�
		suspensa, reiniciando-se a contagem a partir da reapresenta��o da
		fatura retificada.<br>
		&nbsp&nbsp&nbsp d) A Se��o Judici�ria do Rio de Janeiro reserva-se o
		direito de recusar o pagamento, se no ato da atesta��o, o material
		entregue n�o estiver em conformidade com as especifica��es
		apresentadas e aceitas que integram o presente contrato.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">&nbsp&nbsp&nbsp e) A
		Se��o Judici�ria do Rio de Janeiro poder� deduzir da import�ncia a
		pagar os valores correspondentes a multas ou indeniza��es devidas pela
		contratada nos termos do presente ajuste.<br>
		&nbsp&nbsp&nbsp f) Ser� considerada como a data do pagamento a data da
		emiss�o da Ordem Banc�ria.<br>
		5.2 - A contratada dever� comprovar, quando da apresenta��o da nota
		fiscal � Contratante, a regularidade perante a Seguridade Social e o
		Fundo de Garantia de Tempo de Servi�o, atrav�s da CND e do CRF, dentro
		das respectivas validades, sob pena de n�o pagamento dos servi�os
		prestados e de rescis�o contratual, em atendimento ao disposto no
		par�grafo 3� do art. 195 da Constitui��o Federal, no art. 2� da Lei n�
		9.012/95 e nos arts. 55, inciso VIII, e 78, inciso I, ambos da Lei n�
		8.666/93.<br>
		5.3 - Na ocasi�o da entrega da nota fiscal a contratada dever�
		comprovar a condi��o de optante pelo SIMPLES (Sistema Integrado de
		Pagamento de Impostos e Contribui��es das Microempresas e Empresas de
		pequeno Porte), mediante a apresenta��o da declara��o indicada em ato
		normativo da Secretaria da Receita Federal, e dos documentos,
		devidamente autenticados, que comprovem ser o signat�rio da referida
		declara��o representante legal da empresa.<br>
		As pessoas jur�dicas n�o optantes pelo SIMPLES e aquelas que ainda n�o
		formalizaram a op��o sofrer�o a reten��o de impostos/contribui��es por
		esta Se��o Judici�ria no momento do pagamento, conforme disposto no
		art. 64 da Lei n� 9.430, de 27/12/96, regulamentado por ato normativo
		da Secretaria da Receita Federal.</p>
		<p align="left"><u> <b> CL�USULA SEXTA - DA DOTA��O
		OR�AMENT�RIA: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">6.1 - As despesas
		decorrentes da presente contrata��o, correr�o � conta dos recursos
		espec�ficos consignados no Or�amento Geral da Uni�o, para o corrente
		exerc�cio, conforme o especificado abaixo:<br>
		&nbsp&nbsp&nbsp Programa de Trabalho: <b>${programaTrabalho}</b><br>
		&nbsp&nbsp&nbsp Elemento de Despesa: <b>${elementoDespesa}</b><br>
		&nbsp&nbsp&nbsp Nota de Empenho: <b>${notaEmpenho}</b><br>
		</p>
		<p align="left"><u> <b> CL�USULA S�TIMA - DO PRAZO DE
		VIG�NCIA E DE EXECU��O: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">7.1 - O presente
		contrato vigorar� a partir da data de sua assinatura at� <b>${dataFinal}</b>,
		sendo sua efic�cia condicionada � publica��o no Di�rio Oficial da
		Uni�o.<br>
		7.2 - O prazo de execu��o do presente Contrato ser� de <b>${dataInicio}</b>
		a <b>${dataFim}</b>.</p>
		<p align="left"><u> <b> CL�USULA OITAVA - DAS PENALIDADES:
		</b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">8.1 - O n�o
		cumprimento pela contratada de qualquer uma das obriga��es, dentro dos
		prazos estabelecidos por este contrato, sujeit�-la-� �s penalidades
		previstas nos artigos 86 a 88 da Lei n� 8.666/93.<br>
		</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">8.2 - As penalidades
		a que est� sujeita a contratada inadimplente, nos termos da Lei n�
		8.666/93, s�o as seguintes:<br>
		&nbsp&nbsp&nbsp a) Advert�ncia;<br>
		&nbsp&nbsp&nbsp b) multa;<br>
		&nbsp&nbsp&nbsp c) suspens�o tempor�ria de participar em licita��o e
		impedimento em contratar com a Administra��o por prazo n�o superior a
		02 (dois) anos.<br>
		8.3 - A recusa injustificada em assinar o Contrato, aceitar ou retirar
		o instrumento equivalente, dentro do prazo estabelecido pela
		Administra��o, sujeita o adjudicat�rio � penalidade de multa de at�
		10% (dez por cento) sobre o valor da adjudica��o, independentemente da
		multa estipulada no subitem 8.4.2.<br>
		8.4 - A inexecu��o total ou parcial do contrato poder� acarretar, a
		crit�rio da Administra��o, a aplica��o das multas, alternativamente:<br>
		&nbsp&nbsp&nbsp 8.4.1 - Multa compensat�ria de at� 30% (trinta por
		cento) sobre o valor equivalente � obriga��o inadimplida.<br>
		&nbsp&nbsp&nbsp 8.4.2 - Multa correspondente � diferen�a entre o valor
		total porventura resultante de nova contrata��o e o valor total que
		seria pago ao adjudicat�rio.<br>
		&nbsp&nbsp&nbsp 8.4.3 - Multa de 50% (cinq�enta por cento) sobre o
		valor global do contrato, no caso de inexecu��o total do mesmo.<br>
		8.5 - A atualiza��o dos valores correspondentes � multa estabelecida
		no item 8.4 far-se-� a partir do 1� (primeiro) dia, decorrido o prazo
		estabelecido no item 8.7.<br>
		8.6 - Os atrasos injustificados no cumprimento das obriga��es
		assumidas pela contratada sujeit�-la-� � multa di�ria, at� a data do
		efetivo adimplemento, de 0,3% (tr�s d�cimos por cento), calculada �
		base de juros compostos, sem preju�zo das demais penalidades previstas
		na Lei n� 8.666/93.<br>
		&nbsp&nbsp&nbsp 8.6.1 - A multa morat�ria estabelecida ficar� limitada
		� estipulada para inexecu��o parcial ou total do contrato (subitem
		8.4.1).<br>
		&nbsp&nbsp&nbsp 8.6.2 - O per�odo de atraso ser� contado em dias
		corridos.<br>
		8.7 - A multa dever� ser paga no prazo de 30 (trinta) dias, contados
		da data do recebimento da intima��o por via postal, ou da data da
		juntada aos autos do mandado de intima��o cumprido, conforme o caso.<br>
		8.8 - Caso a multa n�o seja paga no prazo estabelecido no item 8.7,
		dever� ser descontada dos pagamentos do respectivo contrato, ou,
		ainda, cobrada judicialmente, se for o caso.<br>
		8.9 - A atualiza��o dos valores correspondentes �s multas
		estabelecidas neste Contrato dar- se-� atrav�s do IPCA-E/IBGE, tendo
		em vista o disposto no art. 1� da Lei n� 8.383, de 30/12/91 ou de
		outro �ndice, posteriormente determinado em lei.<br>
		8.10 - A contagem dos prazos dispostos neste Contrato obedecer� ao
		disposto no art. 110, da Lei n� 8.666/93.<br>
		8.11 - Os procedimentos de aplica��o e recolhimento das multas foram
		regulamentados pela IN n� 24-12, do Egr�gio Tribunal Regional Federal
		da 2� Regi�o</p>
		<p align="left"><u> <b> CL�USULA NONA - DA RESCIS�O: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">9.1 - A inexecu��o
		parcial ou total do Contrato enseja a sua rescis�o, conforme disposto
		nos artigos 77 a 80 da Lei n� 8.666/93, sem preju�zo da aplica��o das
		penalidades previstas na Cl�usula Oitava.<br>
		9.2 - A rescis�o do Contrato poder� ser:<br>
		&nbsp&nbsp&nbsp 9.2.1 - determinada por ato unilateral e escrito da
		Administra��o da Se��o Judici�ria do Rio de Janeiro, nos casos
		enumerados nos inciso I a XII e XVII do art. 78 da lei mencionada.<br>
		&nbsp&nbsp&nbsp&nbsp 9.2.1.1 - Nos casos previstos nos incisos I a
		VIII e XI a XVII, a Administra��o<br>
		notificar� a Contratada, atrav�s de Of�cio, com prova de recebimento.<br>
		&nbsp&nbsp&nbsp&nbsp 9.2.1.2 - Nos casos previstos nos incisos IX e X,
		a rescis�o dar-se-� de pleno direito, independentemente de aviso ou
		interpela��o judicial ou extrajudicial.<br>
		&nbsp&nbsp&nbsp 9.2.2 - amig�vel, por acordo entre as partes, desde
		que haja conveni�ncia para a Administra��o da Se��o Judici�ria do Rio
		de Janeiro.<br>
		&nbsp&nbsp&nbsp 9.2.3 - judicial, nos termos da legisla��o vigente
		sobre a mat�ria.<br>
		9.3 - A rescis�o administrativa ou amig�vel ser� precedida de
		autoriza��o escrita e fundamentada da autoridade competente e as
		rescis�es determinadas por ato unilateral da Administra��o ser�o
		formalmente motivadas nos autos do processo, assegurado o
		contradit�rio e a ampla defesa da Contratada. 9.4 - A rescis�o ser�
		determinada na forma do art. 79 da Lei n� 8.666/93.</p>
		<p align="left"><u> <b> CL�USULA D�CIMA - DA DOCUMENTA��O
		COMPLEMENTAR: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">10.1 - Fazem parte
		integrante do presente instrumento de contrato, independente de
		transcri��o, os documentos a seguir discriminados:<br>
		&nbsp&nbsp&nbsp a) Preg�o n� <b>${numeroPregao}/${anoPregao}</b>.<br>
		&nbsp&nbsp&nbsp b) Proposta da Contratada apresentada � Contratante em
		......./......../(ano).</p>
		<font size="2" align="left"><u> <b> CL�USULA D�CIMA
		PRIMEIRA - DAS CONDI��ES DE RECEBIMENTO PROVIS�RIO E DEFINITIVO: </b> </u></font>
		<p style="TEXT-INDENT: 1.5cm" align="justify">11.1 - O recebimento
		do objeto da presente contrata��o dar-se-�:<br>
		&nbsp&nbsp&nbsp 11.1.1 - provisoriamente, no ato da entrega do
		material e da apresenta��o das Faturas/Notas Fiscais discriminativas,
		pela Se��o de Almoxarifado/SMA.<br>
		&nbsp&nbsp&nbsp 11.1.2 - definitivamente, no prazo de at� 05 (cinco)
		dias �teis contados do recebimento provis�rio, ap�s confer�ncia da
		conformidade do material.</p>
		<p align="left"><u> <b> CL�USULA D�CIMA SEGUNDA - DA
		PUBLICA��O: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">12.1 - O presente
		contrato ser� publicado no Di�rio Oficial da Uni�o, na forma de
		extrato, de acordo com o que determina o par�grafo �nico do artigo 61
		da Lei n� 8.666/93.</p>
		<p align="left"><u> <b> CL�USULA D�CIMA TERCEIRA - DA
		FISCALIZA��O: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">13.1 - Durante a
		vig�ncia do contrato, a entrega dos materiais ser� acompanhada e
		fiscalizada por servidores/Comiss�o, designados pela Administra��o.<br>
		13.2 - O representante anotar� em registro pr�prio todas as
		ocorr�ncias relacionadas com a entrega dos materiais mencionados,
		determinando o que for necess�rio � regulariza��o das faltas ou
		defeitos observados.<br>
		13.3 - As decis�es e provid�ncias que ultrapassarem a compet�ncia do
		representante ser�o solicitadas a seus superiores em tempo h�bil para
		a ado��o das medidas convenientes.<br>
		13.4 - O exerc�cio da fiscaliza��o pela Contratante n�o excluir� a
		responsabilidade da Contratada.<br>
		</p>
		<p align="left"><u> <b> CL�USULA D�CIMA QUARTA - DAS
		CONSIDERA��ES FINAIS: </b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">14.1 - O contrato
		poder� ser alterado nos termos previstos no art. 65 da Lei n�
		8.666/93, com a apresenta��o das devidas justificativas.<br>
		14.2 - Ap�s o t�rmino deste Contrato, a Contratada fornecer� Termo de
		Quita��o � Se��o de Contratos da Subsecretaria de Material e
		Patrim�nio, no prazo m�ximo de 15 (quinze) dias, em papel timbrado,
		devidamente assinado pelo representante legal, carimbado e datado.<br>
		14.3 - Na hip�tese de o Termo de Quita��o n�o ser fornecido dentro do
		prazo supracitado, ser� considerada como plena, rasa e total a
		quita��o em favor da Se��o Judici�ria do Rio de Janeiro dos d�bitos
		referentes � presente contrata��o.<br>
		</p>
		<p align="left"><u> <b> CL�USULA D�CIMA QUINTA - DO FORO:
		</b> </u></p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">15.1 - Para dirimir
		as quest�es oriundas do presente contrato, ou de sua execu��o, com
		ren�ncia expressa de qualquer outro, por mais privilegiado que seja,
		ser� competente o Foro da Justi�a Federal - Se��o Judici�ria do Rio de
		Janeiro.</p>
		<p style="TEXT-INDENT: 2.0cm" align="justify">E, assim, por
		estarem as partes justas e acordadas entre si, � lavrado o presente
		termo de contrato, extra�do em 03 (tr�s) vias de igual teor e forma,
		que depois de lido e achado conforme vai assinado pelas partes
		contratantes.</p>
		<p align="right">${doc.dtExtenso}<br>
		<br>

		________________________________________________<br>
		JUSTI�A FEDERAL DE 1� GRAU NO RIO DE JANEIRO<br>
		<br>


		________________________________________________<br>
		EMPRESA<br>
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
