<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- 
Este modelo trata do Contrato de 
Obras e Servi�os Eventuais.
 -->
<mod:modelo>
	<mod:entrevista>

		<mod:grupo titulo="Detalhe do Contrato">
			<mod:texto titulo="N� do Termo de Contrato" largura="15"
				maxcaracteres="10" var="termoContrato" />
			<mod:texto titulo="Ano" largura="5" var="anoContrato" />
			<mod:grupo>
				<mod:texto titulo="Servi�os de Engenharia para" largura="40"
					var="objetivo" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="N� Processo" largura="6" var="n1" />
				<mod:texto largura="6" var="n2" />
				<mod:texto largura="6" var="n3" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Dados do Juiz">
			<mod:texto titulo="Juiz(a) Federal (Diretor(a) do Foro)" largura="60"
				maxcaracteres="40" var="nomeJuiz" />
			<mod:grupo>
				<mod:texto titulo="Documento Identidade" largura="12"
					maxcaracteres="9" var="identJuiz" />
				<mod:texto titulo="Org�o Emissor" largura="5" var="orgEmissorJuiz" />
				<mod:texto titulo="CPF" largura="15" maxcaracteres="11"
					var="cpfJuiz" />
				<mod:texto titulo="N� Folhas do auto" largura="4" var="folhas" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Dados da Empresa Contratada">
			<mod:texto titulo="Nome da Empresa" largura="60" maxcaracteres="40"
				var="nomeEmpresa" />
			<mod:grupo>
				<mod:texto titulo="Endere�o" largura="70" maxcaracteres="50"
					var="endEmpresa" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="CGC/CNPJ" largura="15" maxcaracteres="13"
					var="cnpj" />
				<mod:texto titulo="Telefone" largura="13" maxcaracteres="12"
					var="tel" />
				<mod:texto titulo="Fax" largura="13" maxcaracteres="12" var="fax" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Nome do Representante SR(a)" largura="60"
					maxcaracteres="40" var="nomeRepresentante" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Documento Identidade" largura="12"
					maxcaracteres="9" var="identRepresentante" />
				<mod:texto titulo="Org�o Emissor" largura="5"
					var="orgEmissorRepresentante" />
				<mod:texto titulo="CPF" largura="15" maxcaracteres="11"
					var="cpfRepresentante" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Dados do Objeto">
			<mod:texto titulo="Nome do Objeto" largura="60" maxcaracteres="40"
				var="objeto" />
			<mod:grupo>
				<mod:texto titulo="N� do Edital" largura="5" var="numEdital" />
				<mod:texto titulo="Ano" largura="5" var="anoEdital" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Edital" largura="60" maxcaracteres="40"
					var="edital" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Dados do Contratante">
			<mod:texto titulo="Nome da Se��o da �rea de Infra-estrutura"
				largura="30" var="secao" />
			<mod:texto titulo="Sigla" largura="5" var="sigla" />
		</mod:grupo>

		<mod:grupo titulo="Pre�o e Forma de Pagamento">
			<mod:grupo>
				<mod:monetario titulo="Valor Global do Contrato R$" largura="12"
					maxcaracteres="10" var="valorContrato" formataNum="sim"
					extensoNum="sim" reler="sim" />
				<mod:oculto var="valorContratovrextenso"
					valor="${valorContratovrextenso}" />
			</mod:grupo>

			<mod:grupo>
				<mod:selecao titulo="Deseja parcelar o pagamento" var="parcelas"
					opcoes="N�o;Sim" reler="sim" />
			</mod:grupo>
			<c:if test="${parcelas == 'Sim'}">
				<mod:grupo>
					<mod:numero titulo="Informe o n� de parcelas" largura="3"
						var="nparcelas" extensoNum="sim" />
					<mod:oculto var="nparcelasnumextenso" valor="${nnumextenso}" />
				</mod:grupo>
				<mod:grupo>
					<mod:numero titulo="Informe o dia da primeira parcela" largura="3" var="dia" extensoNum="sim" />
					<mod:oculto var="dianumextenso" valor="${dianumextenso}" />
				</mod:grupo>
				<!-- 
					<c:forEach var="i" begin="1" end="${n}">
				<mod:grupo>
					<mod:texto titulo="${i}� - Parcela" largura="10" var="medicao${i}" />
					<mod:data titulo="dia" var="diaMedicao${i}" />
				</mod:grupo>
			</c:forEach>
			-->
			</c:if>
		</mod:grupo>

		<mod:grupo titulo="Dota��o Or�ament�ria">
			<mod:texto titulo="Programa de Trabalho" largura="40"
				var="progTrabalho" />
			<mod:grupo>
				<mod:texto titulo="Elemento de Despesa" largura="40"
					var="elemDespesa" />
			</mod:grupo>
			<mod:grupo>
				<mod:numero titulo="Nota de Empenho" largura="5" var="notaEmpenho"
					extensoNum="sim" />
				<mod:oculto var="notaEmpenhonumextenso"
					valor="${notaEmpenhonumextenso}" />
			</mod:grupo>
		</mod:grupo>

		<mod:grupo titulo="Prazo de Vig�ncia e de Execu��o">
			<mod:numero titulo="Prazo para execu��o dos servi�os" largura="10"
				var="prazExecucao" extensoNum="sim" />
			<mod:oculto var="prazExecucaonumextenso"
				valor="${prazExecucaonumextenso }" />
			<mod:grupo>
				<mod:numero titulo="Prazo de vig�ncia do contrato" largura="10"
					var="prazVigencia" extensoNum="sim" />
				<mod:oculto var="prazVigencianumextenso"
					valor="${prazVigencianumextenso}" />
			</mod:grupo>
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

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } -
		Contrato n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1</font></u>

		</head>
		<body>
		<font size="2">
		<p align="center"><b>TERMO DE CONTRATO N.�&nbsp;
		${termoContrato }/(${anoContrato }) </b></p>

		<p align="right"><b>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CONTRATO
		DE PRESTA��O DE SERVI�OS DE<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ENGENHARIA
		PARA ${objetivo }, QUE ENTRE<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SI
		FAZEM A JUSTI�A FEDERAL DE 1� GRAU NO RIO DE<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JANEIRO
		E A EMPRESA ${nomeEmpresa }</b></p>

		<p align="center"><b>PROCESSO N� &nbsp; ${n1 }/${n2 }/${n3 } -
		EOF</b></p>
		
		<p style="TEXT-INDENT: 1.5cm" align="justify">A justi�a Federal de
		1&deg; Grau no Rio de Janeiro, com sede na Av.Rio Branco, 243 - Anexo
		I - 14&deg; andar, Centro/RJ, inscrita no C.N.P.J. sob o n&deg;
		05.424.540./0001-16, neste ato representada pelo Dr. <b>${nomeJuiz
		}</b>, Juiz Federal - Diretor do Foro, Identidade n&deg; <b>${identJuiz
		}</b> - <b>${orgEmissorJuiz }</b>, CPF: <b>${cpfJuiz }</b> doravante
		denominada CONTRATANTE, e a empresa <b>${nomeEmpresa }</b>,
		estabelecida na <b>${endEmpresa }</b>, inscrita no C.N.P.J sob o n� <b>${cnpj
		}</b>, TEL: <b>${tel }</b>, FAX: <b>${fax }<b>, representada neste
		ato pelo Sr.(a) <b>${nomeRepresentante }<b>, Identidade n� <b>${identRepresentante}</b>
		- <b>${orgEmissorRepresentante }</b>, CPF: <b>${cpfRepresentante }</b>,
		doravante denominada CONTRATADA, tendo em vista o decidido no Processo
		Administrativo n� <b>${n1 }</b>/<b>${n2 }</b>/<b>${n3 }</b> - EOF, por
		despacho do Exm� Sr. <b>${nomeJuiz }</b> Juiz Federal - Diretor do
		Foro, �s Fls. <b>${folhas }</b> dos autos, firmam o presente contrato,
		nos termos e sujeitas as partes �s normas da Lei n� 8.666/93 e �s
		cl�usulas contratuais a seguir:</p>


		<p align="left"><u><strong>CL&Aacute;USULA PRIMEIRA -
		DO OBJETO:</strong></u></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">1.1 - Constitui
		objeto do presente contrato a execu��o dos servi�os de engenharia, no
		regime de empreitada por pre�o global R$ <b>${valorContrato}</b>, para
		(<b>${objeto }</b>), conforme especifica��es constantes nos anexos do
		edital do (<b>${edital }</b>) n� <b>${numEdital }</b>/ <b>${anoEdital
		}</b>, que fazem parte integrante deste contrato.</p>

		<p align="left"><u><strong>CL&Aacute;USULA SEGUNDA -
		DAS OBRIGA��ES DA CONTRATADA:</strong></u></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.1 - S�o obriga��es
		da contratada:</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.1 - executar os servi�os
		discriminados nas Especifica��es do (<b>${edital }</b>) n� <b>${numEdital
		}</b>/<b>${anoEdital }</b>, que integra o presente ajuste;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.2 - fornecer aos seus
		empregados crach�s com fotografias, uniformes completos, vale-refei��o
		no valor acordado no diss�dio coletivo da categoria, seguro-sa�de,
		seguro de acidentes pessoais e vales-transporte (em conformidade com a
		Lei 7418/85 e Decreto 95.247/87), bem como os equipamentos de prote��o
		individual, adequados � execu��o de todos os servi�os.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.3 - manter em situa��o
		empregat�cia regular e legal os empregados que prestarem servi�os em
		todas as depend�ncias da Contratante, obedecendo as normas do
		Minist�rio do Trabalho, reservando-se a Contratante o direito de
		exigir a sua comprova��o sempre que julgar necess�rio.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 1� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.4 - obedecer
		rigorosamente �s normas vigentes de seguran�a e medicina do trabalho,
		para todos os tipos de atividade, sendo respons�vel por quaisquer
		danos f�sicos ou pessoais decorrentes de acidentes que venham a
		provocar.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.5 - cumprir com todas as
		obriga��es constantes nas Especifica��es do (<b>${edital }</b>) n� <b>${numEdital
		}</b>/<b>${anoEdital }</b>, que integra o presente ajuste;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.6 - manter, durante toda
		a execu��o do contrato, em compatibilidade com as obriga��es
		assumidas, todas as condi��es de habilita��o e qualifica��o exigidas
		no (<b>${edital }</b>) n� <b>${numEdital }</b>/<b>${anoEdital }</b>.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.7 - A Contratada �
		respons�vel por:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.7.1
		- responder pelos danos causados diretamente � SJRJ ou a terceiros,
		decorrentes de sua culpa ou dolo, quando da execu��o dos servi�os, n�o
		excluindo ou reduzindo essa responsabilidade a fiscaliza��o ou o
		acompanhamento pela Contratante.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.1.7.2
		- arcar com despesas decorrentes de qualquer infra��o, seja qual for,
		desde que praticadas por seus funcion�rios durante a execu��o dos
		servi�os, ainda que no recinto da Contratante.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">2.2 - � Contratada
		caber�, ainda:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) assumir todos os encargos
		previdenci�rios e obriga��es sociais previstos na legisla��o social e
		trabalhista em vigor, obrigando-se a sald�-los na �poca pr�pria, vez
		que os seus empregados n�o manter�o nenhum v�nculo empregat�cio com a
		Contratante;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) responsabilizar-se por
		todas as provid�ncias e obriga��es estabelecidas na legisla��o
		espec�fica de acidentes do trabalho, quando, em ocorr�ncia da esp�cie,
		forem v�timas os seus t�cnicos no desempenho dos servi�os ou em
		conex�o com eles, ainda que acontecido em depend�ncia da Contratante;
		</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c) assumir todos os encargos
		de eventual demanda trabalhista, civil ou penal, relacionada aos
		servi�os, originariamente ou vinculada por preven��o, conex�o ou
		conting�ncia;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d) assumir, ainda, todos os
		encargos fiscais e comerciais resultantes deste Contrato.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 2� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">2.3 - A
		inadimpl�ncia da Contratada, com refer�ncia aos encargos estabelecidos
		no subitem 2.2, n�o transfere � Contratante a responsabilidade por seu
		pagamento, nem poder� onerar o objeto deste Contrato, raz�o pela qual
		a Contratada renuncia expressamente a qualquer v�nculo de
		solidariedade, ativa ou passiva, com a Se��o Judici�ria do Rio de
		Janeiro.</p>

		<p><b><u>CL&Aacute;USULA TERCEIRA - DAS OBRIGA��ES DA
		CONTRATANTE:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">3.1 - Caber� �
		Contratante:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1.1 - prestar as
		informa��es e os esclarecimentos que venham a ser solicitados pela
		Contratada;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1.2 - assegurar-se da boa
		presta��o dos servi�os, verificando sempre o seu bom desempenho;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1.3 - fiscalizar o
		cumprimento das obriga��es assumidas pela Contratada, inclusive quanto
		� continuidade da presta��o dos servi�os que, ressalvados os casos de
		for�a maior, justificados e aceitos pela Contratante, n�o deva ser
		interrompida;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1.4 - emitir, por
		interm�dio da (${secao }), da �rea de Infra-estrutura - INF, pareceres
		sobre os atos relativos � execu��o do contrato, em especial, quanto ao
		acompanhamento e fiscaliza��o da presta��o dos servi�os, � exig�ncia
		de condi��es estabelecidas nesta Especifica��o e � proposta de
		aplica��o de san��es;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1.5 - tornar dispon�vel as
		instala��es e os equipamentos necess�rios � presta��o dos servi�os,
		quando for o caso;</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.1.6 - acompanhar e
		fiscalizar o andamento dos servi�os, por interm�dio da <b>${secao
		}</b> - (<b>${sigla }</b>), da �rea de Infra-estrutura - INF.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 3� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA QUARTA - DO PRE�O:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">4.1 - O valor global
		deste contrato � de R$ <b>${valorContrato }</b> <b>${valorContratovrextenso
		}</b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">4.2 - Nos pre�os
		oferecidos pela contratada j� est�o inclu�das todas as despesas com
		encargos tribut�rios, sociais, trabalhistas e quaisquer outras que se
		fizerem necess�rias ao cumprimento das obriga��es decorrentes deste
		contrato, bem como os demais �nus determinados nos Anexos do Edital do
		(<b>${edital }</b>) n� <b>${numEdital }</b>/ <b>${anoEdital }</b>,
		que faz parte integrante deste Contrato.</p>

		<p><b><u>CL&Aacute;USULA QUINTA - DO PAGAMENTO:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.1 - O pagamento
		ser� efetuado com base em <b>${nparcelas}</b> (<b>${nparcelasnumextenso
		}</b>) medi��es mensais, as quais contemplar�o, apenas, servi�os
		conclu�dos e aprovados pela Fiscaliza��o, n�o sendo efetuados
		pagamentos parciais por entrega de materiais.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.1.1 - A primeira medi��o
		ser� realizada ap�s <b>${dia }</b> (<b>${dianumextenso}</b>) dias da assinatura do Contrato, estando
		o pagamento da �ltima medi��o sujeito ao disposto no item
		(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
		das Especifica��es, que constituem o Anexo I do (<b>${edital }</b>) n� <b>${numEdital
		}</b>/ <b>${anoEdital }</b>, mediante cr�dito em conta corrente da
		contratada, por meio de ordem banc�ria, at� o 10� (d�cimo) dia �til da
		apresenta��o da nota fiscal, devidamente atestada pela �rea de
		Infra-Estrutura, salvo eventual atraso de distribui��o de recursos
		financeiros efetuados pelo Conselho da Justi�a Federal.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.2 - Ser�
		considerada como data do pagamento a data da emiss�o da Ordem
		Banc�ria.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.2.1 - No per�odo acima n�o
		haver� atualiza��o financeira.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.2.1.1
		- Nos casos de eventuais atrasos de pagamento, desde que a Contratada
		n�o tenha concorrido de alguma forma para tanto, fica convencionado
		que o �ndice de compensa��o financeira devida pela Contratante, entre
		a data acima referida e a correspondente ao efetivo adimplemento da
		parcela, ter� a aplica��o da seguinte f�rmula:</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 4� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EM = I x N x VP</p>

		<br>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Onde:</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EM = Encargos Morat�rios</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N = N�mero de dias entre a
		data prevista para o pagamento e a do efetivo pagamento.</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VP = Valor da parcela a ser
		paga</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TX = Percentual da taxa
		anual = 6%</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I = �ndice de compensa��o
		financeira = 0,0001644, assim apurado:</p>
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I =
		(TX)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I =
		(6/100)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I = 0,0001644 <br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;365&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;365
		</p>


		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		5.2.1.1.1 - A compensa��o financeira prevista nesta Condi��o ser�
		inclu�da na nota fiscal/fatura seguinte ao da ocorr�ncia.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.3 - Caso seja
		necess�ria a retifica��o da fatura por culpa da Contratada, a flu�ncia
		do prazo de 10 (dez) dias �teis ser� suspensa, reiniciando-se a
		contagem a partir da reapresenta��o da fatura retificada.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.4 - A Se��o
		Judici�ria do Rio de Janeiro reserva-se o direito de n�o efetuar o
		pagamento se, no ato da atesta��o, os materiais fornecidos/servi�os
		executados n�o estiverem em conformidade com as Especifica��es
		apresentadas e aceitas, nos termos do (<b>${edital }</b>) n� <b>${numEdital
		}</b>/ <b>${anoEdital }</b>, que integra o presente ajuste.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.5 - A Se��o
		Judici�ria do Rio de Janeiro poder� deduzir da import�ncia a pagar os
		valores correspondentes a multas ou indeniza��es devidas pela
		licitante vencedora nos termos do (<b>${edital }</b>) n� <b>${numEdital
		}</b>/ <b>${anoEdital }</b>, que faz parte integrante do presente
		Contrato.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 5� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">5.6 - As notas fiscais dever�o ser
		apresentada em 02 (duas) vias e entregues na <b>${secao }</b> /
		Infra-Estrutura, situada na Av. Rio Branco, 243 - Anexo I - 8� andar -
		Centro - Rio de Janeiro/RJ.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.7 - A contratada dever� comprovar,
		quando da apresenta��o da nota fiscal � Contratante, a regularidade
		perante a Seguridade Social e o Fundo de Garantia de Tempo de Servi�o,
		atrav�s da CND e do CRF, dentro das respectivas validades, sob pena de
		n�o pagamento dos servi�os prestados e de rescis�o contratual, em
		atendimento ao disposto no par�grafo 3� do art. 195 da Constitui��o
		Federal, no art. 2� da Lei n� 9.012/95 e nos art. 55, inciso VIII, e
		78, inciso I, ambos da Lei n� 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.8 - Para fins de cumprimento do
		disposto no art. 31 da Lei n� 8.212/91, com a reda��o dada pela Lei n�
		9.711, de 20/11/98, e regulamentado por ato normativo do MPS/SRP, ser�
		retido, a cada pagamento, o percentual de 11% (onze por cento) do
		valor dos servi�os contidos na Nota Fiscal apresentada pela
		Contratada.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">5.9 - As pessoas jur�dicas n�o
		optantes pelo SIMPLES e aquelas que ainda n�o formalizaram a op��o
		sofrer�o a reten��o de impostos/contribui��es por esta Se��o
		Judici�ria no momento do pagamento, conforme disposto no art. 64 da
		Lei n� 9.430, de 27/12/96, regulamentado por ato normativo da
		Secretaria da Receita Federal e ISS, conforme normatiza��o da
		Secretaria Municipal de Fazenda do local da presta��o de servi�os.</p>

		<p><b><u>CL&Aacute;USULA SEXTA - DAS PENALIDADES:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.1 - O n�o
		cumprimento pela contratada de qualquer uma das obriga��es, dentro dos
		prazos estabelecidos por este contrato, sujeit�-la-� �s penalidades
		previstas nos artigos 86 a 88 da Lei n� 8.666/93;</p>


		<p style="TEXT-INDENT: 1.5cm" align="justify">6.2 - As penalidades
		a que est� sujeita a contratada inadimplente, nos termos da Lei no
		8.666/93, s�o as seguintes:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) advert�ncia;</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) multa;</p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c) suspens�o tempor�ria de
		participar em licita��o e impedimento em contratar com a Administra��o
		por prazo n�o superior a 02 (dois) anos.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 6� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">6.3 - A recusa
		injustificada em assinar o Contrato, aceitar ou retirar o instrumento
		equivalente, dentro do prazo estabelecido pela Administra��o, sujeita
		o adjudicat�rio � penalidade de multa de at� 10% (dez por cento) sobre
		o valor da adjudica��o, independentemente da multa estipulada no
		subitem 6.4.2.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.4 - A inexecu��o
		total ou parcial do contrato poder� acarretar, a crit�rio da
		Administra��o, a aplica��o das multas, alternativamente:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.4.1 - Multa compensat�ria
		de at� 30% (trinta por cento) sobre o valor equivalente � obriga��o
		inadimplida.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.4.2 - Multa correspondente
		� diferen�a entre o valor total porventura resultante de nova
		contrata��o e o valor total que seria pago ao adjudicat�rio.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.4.3 - Multa de 50%
		(cinq�enta por cento) sobre o valor global do contrato, no caso de
		inexecu��o total do mesmo.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.5 - A atualiza��o
		dos valores correspondentes � multa estabelecida no item 6.4 far-se-�
		a partir do 1�(primeiro) dia, decorrido o prazo estabelecido no item
		6.7.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.6 - Os atrasos
		injustificados no cumprimento das obriga��es assumidas pela contratada
		sujeit�-la-� � multa di�ria, at� a data do efetivo adimplemento, de
		0,3% (tr�s d�cimos por cento), calculada � base de juros compostos,
		sem preju�zo das demais penalidades previstas na Lei n� 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.6.1 - A multa morat�ria
		estabelecida ficar� limitada � estipulada para inexecu��o parcial ou
		total do contrato (subitem 6.4.1).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.6.2 - O per�odo de atraso
		ser� contato em dias corridos.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.7 - A multa dever�
		ser paga no prazo de 30 (trinta) dias, contados da data do recebimento
		da intima��o por via postal, ou da data da juntada aos autos do
		mandado de intima��o cumprido, conforme o caso.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 7� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">6.8 - Caso a multa
		n�o seja paga no prazo estabelecido no item 6.7, dever� ser descontada
		dos pagamentos ou da garantia do respectivo contrato, ou, ainda,
		cobrada judicialmente, se for o caso.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.8.1 - Se a multa for
		superior ao valor da garantia prestada, al�m da perda desta,
		responder� o contratado pela diferen�a faltante.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.9 - A atualiza��o
		dos valores correspondentes �s multas estabelecidas neste Contrato
		dar-se-� atrav�s do IPCA-E/IBGE, tendo em vista o disposto no art. 1�
		da Lei n� 8.383, de 30/12/91 ou de outro �ndice, posteriormente
		determinado em lei.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.10 - A contagem
		dos prazos dispostos neste Contrato obedecer� ao disposto no art. 110,
		da Lei n� 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">6.11 - Os
		procedimentos de aplica��o e recolhimento das multas foram
		regulamentadas pela pela IN 24-12, do Egr�gio Tribunal Regional
		Federal da 2� Regi�o.</p>

		<p><b><u>CL&Aacute;USULA S�TIMA - DA GARANTIA CONTRATUAL:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">7.1 - A contratada
		presta, neste ato, garantia contratual nos termos do art. 56,
		par�grafo 1�, da Lei 8.666/93, no valor de R$, equivalente a 5% (cinco
		por cento) do valor global deste contrato.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">7.2 - A garantia
		acima mencionada somente poder� ser levantada ap�s o t�rmino deste
		contrato e emiss�o do Termo de Recebimento Definitivo dos Servi�os.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">7.3 - A garantia
		acima mencionada responder�, ainda, pelas multas que porventura venham
		a ser aplicadas � Contratada, em virtude de inadimplemento.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 8� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9</font></u>

		<font size="2">
		<p><b><u>CL&Aacute;USULA OITAVA - DA DOTA��O OR�AMENT�RIA:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">8.1 - As despesas
		decorrentes da Contrata��o dos servi�os, objeto deste contrato,
		correr�o � conta dos recursos consignados � Se��o Judici�ria do Rio de
		Janeiro, para o corrente exerc�cio, conforme o especificado abaixo:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Programa de Trabalho: <b>${progTrabalho
		}</b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Elemento de Despesa: <b>${elemDespesa
		}</b></p>

		<p style="TEXT-INDENT: 1.5cm">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nota de Empenho: <b>${notaEmpenho
		}</b></p>

		<p><b><u>CL&Aacute;USULA NONA - DO PRAZO DE VIG�NCIA E DE
		EXECU��O:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">9.1 - O prazo para
		execu��o dos servi�os objeto deste Contrato � de <b>${prazExecucao
		}</b> (<b>${prazExecucaonumextenso}</b>) dias corridos, a contar da data
		da assinatura do mesmo, conforme item
		(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)
		do Anexo I do (<b>${edital }</b>) n� <b>${numEdital }</b>/<b>${anoEdital
		}</b> (Especifica��o).</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">9.2 - O prazo de
		vig�ncia do contrato ser� de <b>${prazVigencia }</b> (<b>${prazVigencianumextenso
		}</b>) dias, a contar da assinatura do contrato.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA - DA RESCIS�O:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">10.1 - A inexecu��o
		parcial ou total do Contrato enseja a sua rescis�o, conforme disposto
		nos artigos 77 a 80 da Lei n� 8.666/93, sem preju�zo da aplica��o das
		penalidades previstas na Cl�usula Sexta.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">10.2 - A resci��o do
		Contrato poder� ser:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10.2.1 - determinada por ato
		unilateral e escrito da Administra��o da Se��o Judici�ria do Rio de
		Janeiro, nos casos enumerados nos inciso I a XII e XVII do art. 78 da
		lei mencionada.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		10.2.1.1 - Nos casos previstos nos incisos I a VIII e XI a XVII, a
		Administra��o notificar� a Contratada, atrav�s de Of�cio, com prova de
		recebimento.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		10.2.1.2 - Nos casos previstos nos incisos IX e X, a rescis�o dar-se-�
		de pleno direito, independentemente de aviso ou interpela��o judicial
		ou extrajudicial.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 9� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10.2.2 - amig�vel, por
		acordo entre as partes, desde que haja conveni�ncia para a
		Administra��o da Se��o Judici�ria do Rio de Janeiro.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10.2.3 - judicial, nos
		termos da legisla��o vigente sobre a mat�ria.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">10.3 - A rescis�o
		administrativa ou amig�vel ser� precedida de autoriza��o escrita e
		fundamentada da autoridade competente e as rescis�es determinadas por
		ato unilateral da Administra��o ser�o formalmente motivadas nos autos
		do processo, assegurado o contradit�rio e a ampla defesa da
		Contratada.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">10.4 - A rescis�o
		ser� determinada na forma do art. 79 da Lei n� 8.666/93.</p>

		<p><b><u>CL�USULA D�CIMA PRIMEIRA - DO PRAZO DE GARANTIA E
		MANUTEN��O DA OBRA:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">11.1 - O prazo de
		garantia de materiais e servi�os componentes da reforma executada pela
		Contratada, ser� de 05 (cinco) anos, a contar do Recebimento
		Definitivo, respeitado o que disp�e o C�digo Civil Brasileiro, bem
		como as demais normas legais e a jurisprud�ncia aplic�veis.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA SEGUNDA - DOS RECURSOS
		ADMINISTRATIVOS:</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">12.1 - Aplica-se o
		disposto no art. 109 da lei n� 8.666/93.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA TERCEIRA - DA DOCUMENTA��O
		COMPLEMENTAR: </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">13.1 - Os servi�os
		contratados obedecer�o ao estipulado neste instrumento, bem como as
		obriga��es assumidas nos documentos a seguir indicados, os quais ficam
		fazendo parte integrante e complementar deste contrato,
		independentemente de transcri��o, no que n�o contrariem as
		estipula��es aqui firmadas:</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) (<b>${edital }</b>) n� <b>${numEdital
		}</b>/ <b>${anoEdital }</b> e seus ANEXOS.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) Proposta datada de
		______/_______/_______, exibida pela Contratada, contendo prazo,
		pre�o, discrimina��o e especifica��o dos servi�os a serem executados.
		</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 10� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11</font></u>

		<font size="2">
		<p><b><u>CL�USULA D�CIMA QUARTA - DAS CONDI��ES DE
		RECEBIMENTO PROVIS�RIO E DEFINITIVO: </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">14.1 - Os servi�os
		ser�o recebidos, provisoriamente, pelo respons�vel por seu
		acompanhamento e fiscaliza��o, mediante termo circunstanciado,
		assinado pelas partes, em at� 15 (quinze) dias da comunica��o escrita
		da Contratada, notificando o t�rmino e aprova��o dos servi�os,
		realizados pela Fiscaliza��o da Contratante, consoante disposto no
		art. 73, I da Lei n� 8.666/93.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">14.2 - Os servi�os
		ser�o recebidos definitivamente, por servidor ou Comiss�o designada
		pela Administra��o, mediante Termo de Recebimento Definitivo, assinado
		pelas partes, lavrado at� 90 (noventa) dias contados do recebimento
		provis�rio, desde que tenham sido atendidas todas as solicita��es da
		Fiscaliza��o, referentes a defeitos ou imperfei��es registrados no
		Termo de Recebimento Provis�rio ou que venham a ser verificados, ap�s
		a lavratura do Termo, em qualquer elemento constante dos servi�os
		executados.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14.2.1 - Havendo rejei��o do
		servi�o por parte do servidor ou Comiss�o de Recebimento da
		Contratante, na hip�tese de estarem em desacordo com as especifica��es
		e condi��es com que foram licitados, a Contratante estipular� prazo
		para a Contratada repar�-los, sem �nus para a Contratante, ficando
		suspensa a concess�o do recebimento definitivo, at� que todas as
		pend�ncias apontadas sejam solucionadas.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">14.3 - Os
		recebimentos provis�rio e definitivo n�o excluem a responsabilidade da
		Contratada, conforme disposto no par�grafo 2� do art. 73 da Lei n�
		8.666/93.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA QUINTA - DA FISCALIZA��O:
		</u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">15.1 - A execu��o
		dos servi�os ser� acompanhada e fiscalizada pelo representante da
		Contratante, expressamente designado pela Administra��o.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">15.2 - O
		representante anotar� em registro pr�prio todas as ocorr�ncias
		relacionadas com a execu��o dos servi�os mencionados, determinando o
		que for necess�rio � regulariza��o das faltas ou defeitos observados.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">15.3 - As decis�es e
		provid�ncias que ultrapassarem a compet�ncia do representante ser�o
		solicitadas a seus superiores em tempo h�bil para a ado��o das medidas
		convenientes.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">15.4 - O exerc�cio
		da fiscaliza��o pela Contratante n�o excluir� a responsabilidade da
		Contratada.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA SEXTA - DAS CONSIDERA��ES
		FINAIS: </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">16.1 - O contrato
		poder� ser aditado nos termos previstos no art. 65 da Lei n� 8.666/93,
		com a apresenta��o das devidas justificativas.</p>
		</font>
		<c:import
			url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<!-- Fim da 11� p�gina -->

		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<u><font size="2">Processo n� ${n1}/${n2 }/${n3 } - Contrato
		n� ${termoContrato }/(${anoContrato }) - ${nomeEmpresa
		}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12</font></u>

		<font size="2">
		<p style="TEXT-INDENT: 1.5cm" align="justify">16.2 - Ap�s o
		t�rmino deste Contrato, a Contratada fornecer� Termo de Quita��o �
		Se��o de Contratos da Subsecretaria de Material e Patrim�nio, no prazo
		m�ximo de 15 (quinze) dias, em papel timbrado, devidamente assinado
		pelo representante legal, carimbado e datado.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">16.3 - Na hip�tese
		de o Termo de Quita��o n�o ser fornecido dentro do prazo supracitado,
		ser� considerada como plena, rasa e total a quita��o em favor da Se��o
		Judici�ria do Rio de Janeiro dos d�bitos referentes � presente
		contrata��o.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA S�TIMA - DA PUBLICA��O: </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">17.1 - O presente
		contrato ser� publicado no Di�rio Oficial da Uni�o, na forma de
		extrato, de acordo com o que determina o par�grafo �nico do artigo 61
		da Lei n� 8.666/93.</p>

		<p><b><u>CL&Aacute;USULA D�CIMA OITAVA - DO FORO: </u></b></p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">18.1 - Para dirimir
		as quest�es oriundas do presente contrato, fica eleito o Foro da
		Justi�a Federal - Se��o Judici�ria do Rio de Janeiro.</p>

		<p style="TEXT-INDENT: 1.5cm" align="justify">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E por estarem ajustados, �
		lavrado o presente termo de contrato, extra�do em 03 (tr�s) vias de
		igual teor e forma, que depois de lido e achado conforme vai assinado
		pelas partes contratantes.</p>
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
							EMPRESA
		<br>
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


