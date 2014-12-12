<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="/WEB-INF/tld/func.tld" prefix="conv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo
			titulo="SOLICITA��O - Encaminhar com anteced�ncia m�nima de 22 (vinte e dois) dias �teis">
			<mod:grupo>
				<mod:selecao titulo="Solicita��o dentro do prazo" opcoes="sim;n�o"
					var="solicitacao_prazo" reler="sim" />
				<c:if test="${solicitacao_prazo=='n�o'}">
					<mod:grupo>
						<mod:memo colunas="55" linhas="2"
							titulo="Caso negativo, justifique" var="obs_prazo" />
					</mod:grupo>
				</c:if>
			</mod:grupo>
			<mod:grupo>
				<mod:grupo>
					<mod:texto titulo="A��o de capacita��o (T�tulo)" largura="40"
						var="capacit_tit" />
				</mod:grupo>
				<mod:grupo>
				</mod:grupo>
				<mod:grupo titulo="Periodo da capacita��o">
					<mod:data titulo="Data de in�cio" var="data_ini" alerta="Nao" />
					<mod:data titulo="Data de fim" var="data_fim" alerta="Nao" />
					<mod:texto titulo="Cidade" largura="30" var="cidade" />
					<mod:selecao titulo="UF" var="uf"
						opcoes="&nbsp;;AC;AL;AP;AM;BA;CE;DF;ES;GO;MA;MT;MS;MG;PA;PB;PR;PE;PI;RJ;RR;RO;RN;RS;SC;SP;SE;TO" />
				</mod:grupo>
				<mod:grupo>
					<mod:grupo
						titulo="Valor&nbsp;&nbsp; (Caso a a��o n�o tenha �nus, deixe estes campos em branco)">
						<mod:monetario titulo="Valor unit�rio" largura="12"
							maxcaracteres="10" var="valor_prospectoUnit" formataNum="sim"
							extensoNum="n�o" reler="ajax" idAjax="precounitajax" />
						<mod:monetario titulo="Valor total" largura="12"
							maxcaracteres="10" var="valor_prospectoTotal" formataNum="sim"
							extensoNum="n�o" reler="ajax" idAjax="precototalajax" />
					</mod:grupo>
				</mod:grupo>
				<mod:grupo>
					<mod:selecao titulo="Passagens" var="passagens" opcoes="sim;n�o" />
					<mod:selecao titulo="Di�rias" var="diarias" opcoes="sim;n�o" />
				</mod:grupo>
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Institui��o/Consultor" var="institucao_consultor" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Pessoa Jur�dica: CNPJ" largura="16"
					maxcaracteres="18" var="cnpj" />

				<mod:texto titulo="Pessoa f�sica: NIT ou PIS/PASEP" largura="16"
					maxcaracteres="14" var="nit_pis_pasep" />

				<mod:texto titulo="CPF:" largura="16" maxcaracteres="14" var="cpf" />
			</mod:grupo>
			<mod:grupo depende="precounitajax;precototalajax">
				<c:if
					test="${conv:monetarioParaFloat(valor_prospectoUnit) > 0 or conv:monetarioParaFloat(valor_prospectoTotal) > 0}">
					<mod:grupo titulo="Indica��o de duas propostas para compara��o"></mod:grupo>
					<c:forEach var="i" begin="1" end="2">
						<mod:grupo titulo="Institui��o/consultor ${i}">
							<mod:grupo>
								<mod:texto titulo="A��o de capacita��o / T�tulo" largura="40"
									var="capacit_tit_indic${i}" />
							</mod:grupo>
							<mod:grupo titulo="Data/Per�odo da capacita��o">
								<mod:data titulo="De" alerta="Nao" var="data_per_ini${i}" />
								<mod:data titulo="at�" alerta="Nao" var="data_per_fim${i}" />
							</mod:grupo>
							<mod:grupo>
								<mod:texto titulo="Cidade" largura="30" var="compara_cidade${i}" />
								<mod:selecao titulo="UF" var="compara_uf${i}"
									opcoes="&nbsp;;AC;AL;AP;AM;BA;CE;DF;ES;GO;MA;MT;MS;MG;PA;PB;PR;PE;PI;RJ;RR;RO;RN;RS;SC;SP;SE;TO" />
							</mod:grupo>
							<mod:grupo>
								<mod:texto titulo="Institui��o/Consultor"
									var="institucao_consultor_indic${i}" />
							</mod:grupo>
							<mod:grupo>

								<mod:monetario titulo="Valor total" largura="12"
									maxcaracteres="10" var="valor_indic${i}" formataNum="sim"
									reler="sim" extensoNum="n�o" />
							</mod:grupo>
						</mod:grupo>
					</c:forEach>
				</c:if>
			</mod:grupo>

			<mod:grupo titulo="">
				<mod:memo colunas="55" titulo="Observa��es" linhas="2" var="obs" />
			</mod:grupo>

			<mod:grupo>
				<mod:grupo>
					<mod:memo colunas="55" linhas="2"
						titulo="Justifique por que a proposta escolhida � a que melhor atende �s necessidades e a import�ncia dela para as atividades de sua unidade"
						var="importancia" />
				</mod:grupo>
			</mod:grupo>
			<br>
			<b><mod:mensagem texto="A(s) proposta(s) deve(m) ser anexada(s) ao presente formul�rio."></mod:mensagem></b>
			<br>
			<mod:caixaverif obrigatorio="Sim" titulo="Ciente" var="cienteProposta"  />
			<br>
			<br>
			<mod:grupo
				titulo="Identifique as atividades/tarefas da unidade que ser�o afetadas pela capacita��o">
				<mod:selecao titulo="Quantas atividades/tarefas deseja elencar"
					var="ativ_hoje" reler="ajax" idAjax="atividadeAjax"
					opcoes="1;2;3;4;5;6;7;8;9;10" />
				<mod:grupo depende="atividadeAjax">
					<c:if test="${ativ_hoje>999}">
						<br>
						<mod:mensagem texto="Digite um numero menor que 1000"
							vermelho="sim" />
					</c:if>
					<c:if test="${ativ_hoje<999}">

						<c:forEach var="i" begin="1" end="${ativ_hoje}">
							<mod:grupo titulo="Atividade ${i}">
								<mod:grupo>
									<mod:texto
										titulo="Atividade/tarefa que ser� afetada pelo treinamento"
										largura="40" var="ativ_tarefa${i}" />
								</mod:grupo>
								<mod:grupo>
									<mod:memo colunas="55" linhas="2"
										titulo="Como � desenvolvida atualmente" var="des${i}" />
								</mod:grupo>
								<mod:grupo>
									<mod:memo colunas="55" linhas="2"
										titulo="Como prev� que ficar� ap�s a capacita��o"
										var="ativ_pos_capacit${i}" />
								</mod:grupo>
							</mod:grupo>
						</c:forEach>
					</c:if>
				</mod:grupo>
			</mod:grupo>
			<mod:grupo titulo="Servidor(es) Indicado(s)">
				<mod:selecao titulo="Mais que 10 servidores a indicar" var="quantos"
					opcoes="n�o;sim" reler="ajax" idAjax="quantosAjax" />
				<mod:grupo depende="quantosAjax">
					<c:choose>
						<c:when test="${quantos=='sim'}">
							<mod:mensagem
								texto="A lista de servidores dever� ser anexada ao documento informando matr�cula, nome, cargo, fun��o e lota��o de cada servidor."
								vermelho="sim" />
						</c:when>
						<c:otherwise>
							<mod:selecao titulo="Quantos servidores deseja indicar"
								var="serv_indic" reler="ajax" idAjax="serv_indicAjax"
								opcoes="1;2;3;4;5;6;7;8;9;10" />
						</c:otherwise>
					</c:choose>

					<mod:grupo depende="serv_indicAjax">
						<c:if test="${serv_indic>999}">
							<br>
							<mod:mensagem texto="Digite um numero menor do que 1000"
								vermelho="sim" />
						</c:if>
						<c:if test="${serv_indic<999 and quantos == 'n�o'}">
							<c:forEach var="i" begin="1" end="${serv_indic}">
								<mod:grupo titulo="Sevidor ${i}">

									<mod:grupo>
										<mod:pessoa titulo="Nome" var="nome${i}" />
									</mod:grupo>

								</mod:grupo>
							</c:forEach>
						</c:if>
					</mod:grupo>
				</mod:grupo>
				<mod:grupo>
					<mod:memo colunas="55" linhas="2"
						titulo="Justifique o n�mero de servidores indicados"
						var="justif_n_serv" />
				</mod:grupo>
				<mod:grupo>
					<mod:memo colunas="55" linhas="2"
						titulo="Crit�rio(s) utilizado(s) para a indica��o" var="criterios" />
				</mod:grupo>
				<mod:grupo
					titulo="Cada servidor indicado est� devidamente ciente do inteiro teor da portaria n� 042-GDF, de 10.09.2002, assumindo os compromissos determinados nesse ato normativo, sobretudo no que se refere � multiplica��o do conhecimento adquirido">
					<mod:grupo>
						<mod:memo colunas="55" linhas="2"
							titulo="Indique abaixo a forma de multiplica��o que ser� utilizada"
							var="forma_multiplicacao" />
					</mod:grupo>
				</mod:grupo>


				<mod:grupo
					titulo="Responsabilizo-me pelas informa��es prestadas e pela multiplica��o do conhecimento
				   adquirido pelos indicados, assim como pelo atesto ao final da a��o de capacita��o.">
				</mod:grupo>								
			</mod:grupo>
		</mod:grupo>	
		<br>	
		<mod:mensagem
			texto="A SOLICITA��O DE
				PAGAMENTO DE DI�RIAS, SE FOR O CASO, DEVER� SER ENCAMINHADA PARA A
				SECRETARIA GERAL PELO SIGA-DOC, COM, NO M�NIMO, 7 (SETE) DIAS �TEIS
				DE ANTECED�NCIA DA DATA DE IN�CIO DO CURSO, POR MEIO DO FORMUL�RIO
				PROPOSTA DE CONCESS�O DE DI�RIAS, DISPON�VEL NA
				P�GINA DA INTRANET, MENU ORGANIZA��O/FORMUL�RIOS, SEGUINDO AS ORIENTA��ES
				ALI CONTIDAS.">
		</mod:mensagem>
	</mod:entrevista>

	<mod:documento>

		<head>
		<meta http-equiv="Content-Type"
			content="text/html; charset=ISO-8859-1">
		<title></title>
		<style type="text/css">
@page {
	margin-left: 1 cm;
	margin-right: 1.0 cm;
	margin-top: 0.5 cm;
	margin-bottom: 1 cm;
}
</style>
		</head>

		<table width="100%" border="0" cellspacing="0">
			<tr>
				<td width="48%">
				<table width="100%" cellpadding="1" cellspacing="0">
					<tr>
						<td width="30%"><img src="contextpath/imagens/brasao2.png"
							width="65" height="65" /></td>
						<td width="70%"><c:import
							url="/paginas/expediente/modelos/inc_cabecalhoEsquerda2.jsp" /></td>
					</tr>
				</table>
				</td>
				<td width="2%"></td>
				<td width="50%">
				<table width="100%" height="100%" cellpadding="10" cellspacing="1">
					<tr bordercolor="#FFFFFF">
						<td align="center" colspan="2" bordercolor="#FFFFFF">SOLICITA��O
						DE INSCRI��O EM A��O DE &nbsp;&nbsp;&nbsp;CAPACITA��O EXTERNA -
						COM ONUS</td>
					</tr>
					<tr>
						<td colspan="2">${doc.codigo}</td>
						<td></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>





		<table width="100%">
			<tr>
				<td colspan="2" bgcolor="#E8E8E8">SOLICITA��O - Encaminhar com anteced�ncia m�nima de 22 (vinte de dois) dias �teis</td>
			</tr>

			<tr>
				<td colspan="2">
				<p><font size="2">SOLICITA��O DENTRO DO PRAZO?&nbsp; <b>${solicitacao_prazo}</b></font></p>
				</td>
			</tr>
			<c:if test="${solicitacao_prazo=='n�o'}">
				<tr>
					<td>
					<p><font size="2">Caso negativo, justifique:<br>
					<b>${obs_prazo}</b></font></p>
					</td>
				</tr>

			</c:if>

			<tr>
				<td width="50%"><font size="2">A��O DE CAPACITA��O
				(T�TULO):&nbsp;<b> ${capacit_tit}</b></font></td>

			</tr>
		</table>

		<table width="100%">
			<tr>
				<td width="50%"><font size="2">DATA / PERIODO:&nbsp; <b>
				${data_ini} a ${data_fim}</b></font></td>
				<td width="50%"><font size="2">Cidade: <b>&nbsp;${cidade}</b>&nbsp;&nbsp;&nbsp;UF:<b>${uf}</b></font></td>
			</tr>
			<tr>
				<td colspan="2"><font size="2">VALOR UNIT�RIO:<b>&nbsp;${valor_prospectoUnit}</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VALOR
				TOTAL:&nbsp;<b>${valor_prospectoTotal}</b></font></td>
			</tr>
			<tr>
				<td><font size="2">PASSAGEM:<b>&nbsp;${passagens}</b></font></td>
				<td><font size="2">DI�RIAS:<b>&nbsp;${diarias}</b></font></td>
			</tr>
			<tr>
				<td colspan="2"><font size="2">INSTITU��O/CONSULTOR:<b>&nbsp;
				${institucao_consultor}</b></font></td>
			</tr>
			<tr>
				<td colspan="2"><font size="2">PESSOA JUR�DICA (CNPJ):<b>&nbsp;
				${cnpj}</b></font></td>
			</tr>
			<tr>
				<td><font size="2">PESSOA FISICA (NIT OU PIS/PASEP):<b>&nbsp;
				${nit_pis_pasep}</b></font></td>
				<td><font size="2">CPF:<b>&nbsp;${cpf}</b></font></td>
			</tr>
		</table>
		<br>
		<table width="100%">
			<tr>
				<td align="center" bgcolor="#E8E8E8">INDICA��O DE DUAS
				PROPOSTAS PARA COMPARA��O</td>
			</tr>
		</table>

		<table width="100%">

			<tr>
				<td width="2%"></td>
				<td width="30%"><font size="2">A��O DE CAPACITA��O
				(TITULO)</font></td>
				<td width="15%"><font size="2">DATA/PERIODO DA
				CAPACITA��O</font></td>
				<td width="20%"><font size="2">CIDADE/UF</font></td>
				<td width="23%"><font size="2">INSTITUI��O/CONSULTOR</font></td>
				<td width="10%"><font size="2">VALOR TOTAL</font></td>
			</tr>
			<c:forEach var="i" begin="1" end="2">
				<tr>
					<td><font size="2"><b>${i} </b></font></td>

					<td><font size="2"><b>
					${requestScope[f:concat('capacit_tit_indic',i)]}</b></font></td>

					<td><font size="2"><b>
					${requestScope[f:concat('data_per_ini',i)]} a
					${requestScope[f:concat('data_per_fim',i)]}</b></font></td>

					<td><font size="2"><b>
					${requestScope[f:concat('compara_cidade',i)]} /
					${requestScope[f:concat('compara_uf',i)]}</b></font></td>




					<td><font size="2"><b>
					${requestScope[f:concat('institucao_consultor_indic',i)]}</b></font></td>
					<td><font size="2"><b> ${requestScope[f:concat('valor_indic',i)]}</b></font></td>
				</tr>
			</c:forEach>
		</table>
		<table width="100%">
			<tr>
				<td>
				<p><font size="2">Observa��es:<br>
				<b>${obs}</b></font></p>
				</td>
			</tr>
			<tr>
				<td>
				<p><font size="2">Justifique por que a proposta escolhida � a que melhor atende �s necessidades e a import�ncia dela para as atividades de sua unidade:</font><br>
				<font size="2"> <b>${importancia}</b></font></p>
				</td>
			</tr>
		</table>
		<br>
		<table width="100%">
			<tr>
				<td align="center" bgcolor="#E8E8E8">Identifique as
				atividades/tarefas da unidade que ser�o afetadas pela capacita��o.</td>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<td><font size="1"> ATIVIDADE/TAREFA QUE SER� AFETADA
				PELO TREINAMENTO </font></td>
				<td valign="top"><font size="1"> COMO � DESENVOLVIDA
				ATUALMENTE? </font></td>
				<td><font size="1"> COMO VOC� PREV� QUE FICAR� AP�S A
				CAPACITA��O?</font></td>
			</tr>
		</table>
		<table width="100%">
			<c:forEach var="i" begin="1" end="${ativ_hoje}">
				<tr>
					<td><font size="2"><b>
					${requestScope[f:concat('ativ_tarefa',i)]}</b></font></td>
					<td><font size="2"><b>
					${requestScope[f:concat('des',i)]}</b></font></td>
					<td><font size="2"><b>
					${requestScope[f:concat('ativ_pos_capacit',i)]}</b></font></td>
				</tr>
			</c:forEach>
		</table>
		<br>
		<table width="100%" align="center">
			<tr>
				<td align="center" bgcolor="#E8E8E8">SERVIDORE(S) INDICADO(S)</td>
			</tr>
		</table>

		<table width="100%">
			<tr align="center">
				<td width="2%"><font size="2"> </font></td>
				<td width="29%"><font size="2"> NOME </font></td>
				<td width="28%"><font size="2"> CARGO </font></td>
				<td width="31%"><font size="2"> FUN��O </font></td>
				<td width="10%"><font size="2"> LOTA��O </font></td>
			</tr>
			<c:forEach var="i" begin="1" end="${serv_indic}">
				<tr>
					<td><font size="2"><b>${i} </b></font></td>
					<td><font size="2"><b>${requestScope[f:concat(f:concat('nome',i),'_pessoaSel.descricao')]}</b></font></td>
					<td><font size="2"><b>${f:pessoa(requestScope[f:concat(f:concat('nome',i),'_pessoaSel.id')]).cargo.descricao}</b></font></td>
					<td><font size="2"><b>${f:pessoa(requestScope[f:concat(f:concat('nome',i),'_pessoaSel.id')]).funcaoConfianca.descricao}</b></font></td>
					<td><font size="2"><b>${f:pessoa(requestScope[f:concat(f:concat('nome',i),'_pessoaSel.id')]).lotacao.sigla}</b></font></td>
				</tr>
			</c:forEach>
		</table>
		<table width="100%">
			<tr>
				<td colspan="2">
				<p><font size="2">Observa��es: (Justifique o n�mero de
				servidores indicados)</font><font size="2"><br>
				<b>${justif_n_serv}</b></font></p>
				</td>
			</tr>
			<tr>
				<td>
				<p><font size="2">Crit�rios utilizados para a indica��o:</font><font
					size="2"> <br>
				<b>${criterios}</b></font></p>
				</td>
			</tr>
			<tr>
				<td>
				<p><font size="2">Cada servidor indicado est� devidamente
				ciente do inteiro teor da portaria n� 042-GDF, de 10.09.2002,
				assumindo os compromissos determinados nesse ato normativo,
				sobretudo no que se refere � multiplica��o do conhecimento
				adquirido.</font><font size="2"> </font></p>
				</td>
			</tr>
			<tr>
				<td>
				<p><font size="2">Indique abaixo a forma de multiplica��o
				que ser� utilizada:</font><font size="2"> <br>
				<b>${forma_multiplicacao}</b> </font></p>
				</td>
			</tr>
		</table>
		<br>
		<table width="90%" cellpadding="1" cellspacing="0" align="left">
			<tr>
				<td><font size="2">Responsabilizo-me pelas informa��es
				prestadas e pela multiplica��o do conhecimento adquirido pelos
				indicados, assim como pelo atesto ao final da a��o de capacita��o.</font><br>
				<br>
				</td>
			</tr>
			<tr align="center">
				<td><b>${doc.dtExtenso}</b><br>
				<br>
				</td>
			</tr>
			<tr>
				<td align="center"><c:import
					url="/paginas/expediente/modelos/inc_assinatura.jsp" /><br>
				</td>
			</tr>
		</table>
		<br>
		<table width="90%" align="left" border="0" cellspacing="0">					
			<tr>
				<td align="justify"><font size="1">A SOLICITA��O DE
				PAGAMENTO DE DI�RIAS, SE FOR O CASO, DEVER� SER ENCAMINHADA PARA A
				SECRETARIA GERAL PELO SIGA-DOC, COM, NO M�NIMO, 7 (SETE) DIAS �TEIS
				DE ANTECED�NCIA DA DATA DE IN�CIO DO CURSO, POR MEIO DO FORMUL�RIO
				PROPOSTA DE CONCESS�O DE DI�RIAS, DISPON�VEL NA
				P�GINA DA INTRANET, MENU ORGANIZA��O/FORMUL�RIOS, SEGUINDO AS ORIENTA��ES
				ALI CONTIDAS.</font></td>
			</tr>
		</table>
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
	</mod:documento>
</mod:modelo>
