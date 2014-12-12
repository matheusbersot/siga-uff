<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- Modelo de solicita��o de inscri��o para capacita��o sem onus -->

<mod:modelo>
	<mod:entrevista>
		 <mod:grupo titulo="Todos os campos s�o de preenchimento obrigat�rio">
			<mod:texto titulo="A��o de capacita��o" largura="40" var="acao" />
			<mod:texto titulo="Institui��o/Consultor" largura="40" var="ic" />
			<mod:grupo titulo="Per�odo Solicitado">
				<mod:data titulo="De" var="dataInicio" />
				<mod:data titulo="a" var="dataFim" />
				<mod:texto titulo="Cidade/Uf" largura="40" var="cidade" />
			</mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Prospecto anexo" var="prospecto"
					opcoes="sim;n�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:memo colunas="55" linhas="2"
					titulo="Qual a import�ncia que a a��o de capacita��o ter� para o 
					desenvolvimento das atividades da unidade organizacional?
					(Defina de forma que os objetivos atingidos possam ser mensurados ou observados)"
					var="imp" />
			</mod:grupo>
			<mod:grupo
				titulo="IDENTIFIQUE AS ATIVIDADES/TAREFAS DA UNIDADE QUE SER�O AFETADAS PELA CAPACITA��O">
				<mod:selecao titulo="Quantidade de tarefas" var="qtd_tar"
					opcoes="1;2;3;4;5;6;7;8;9;10" reler="ajax" idAjax="qtd_tarefaAjax" />
				<mod:grupo depende="qtd_tarefaAjax">
				<c:forEach var="i" begin="1" end="${qtd_tar}">
					<mod:grupo titulo="Atividade ${i}">
						<mod:grupo>
							<mod:texto largura="30"
								titulo="Atividade/tarefa que sera afetada pelo treinamento"
								var="atividadeTarefa${i}" />
						</mod:grupo>
						<mod:grupo>
							<mod:memo  colunas="25" linhas="3" titulo="Como � desenvolvida atualmente"
								var="des${i}" />
						</mod:grupo>
						<mod:grupo>
							<mod:memo colunas="25" linhas="3"
								titulo="Como voce prev� que ficar� ap�s a capacita��o"
								var="capact${i}" />
						</mod:grupo>
					</mod:grupo>
				</c:forEach>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

	<mod:grupo titulo="Servidor(es)">
	

		<mod:mensagem
			texto="SERVIDOR(ES) INDICADO(S), CADA SERVIDOR INDICADO EST� DEVIDAMENTE CIENTE DO INTEIRO TEOR DA PORTARIA N� 042-GDF,DE 10.9.2002, ASSUMINDO OS COMPROMISSOS DETERMINADOS NESSE ATO NORMATIVO,
	       	 		SOBRE TUDO NO QUE SE REFERE � MULTIPLICA��O DO CONHECIMENTO ADQUIRIDO."/>
		
		
			 <mod:selecao titulo="Mais que 10 servidores a indicar" var="quantos"
				opcoes="n�o;sim" reler="ajax" idAjax="quantosAjax"/>
			<mod:grupo depende="quantosAjax">
					<c:choose>
						<c:when test="${quantos=='sim'}">
							<mod:mensagem texto="A lista de servidores dever� ser anexada ao documento" vermelho="sim"/>
						</c:when> 
						<c:otherwise>
							<mod:selecao titulo="Quantos servidores deseja indicar" 
								var="serv_indic" reler="ajax" idAjax="serv_indicAjax" opcoes="1;2;3;4;5;6;7;8;9;10" />
						</c:otherwise>
					</c:choose>
		
				<mod:grupo depende="serv_indicAjax"> 	
					<c:forEach var="i" begin="1" end="${serv_indic}">
						<mod:grupo titulo="Servidor ${i}">			
								<mod:pessoa titulo="Nome" var="nome${i}" />						
						</mod:grupo>
					</c:forEach>
				</mod:grupo>
		</mod:grupo>
	</mod:grupo>
	
	
	<mod:grupo>				
		<mod:memo colunas="25" linhas="2" titulo="Crit�rio(s) Utilizado(s) para indica��o" var="criterios" />
	</mod:grupo>
		<mod:grupo>
			<mod:memo colunas="25" linhas="2"
				titulo="Observa��o (justifique o numero de servidores indicados)"
				var="obs_serv" />

	</mod:grupo>
	<mod:grupo>
			<mod:data titulo="Data" var="data" />
	</mod:grupo>	
		<!-- 
		<mod:grupo titulo="SE��O DE TREINAMENTO-SETRE">
			<mod:selecao
				titulo="Conte�do program�tico (aprovado pela area competente)"
				var="aprovado" opcoes="sim;n�o" />
		</mod:grupo>
		<mod:grupo>
			<mod:selecao
				titulo="Solicita��o constante do levantamento de necessidades de treinamento"
				var="solicit" opcoes="sim;n�o" />
		</mod:grupo>
		<mod:grupo>
			<mod:selecao titulo="Reserva de vagas(s)" var="reserv"
				opcoes="sim;n�o" />
		</mod:grupo>
		<mod:grupo>
			<mod:texto titulo="Contato(Nome, telefone, E-mail)" largura="40"
				var="contato" />
		</mod:grupo>
		<mod:grupo>
			<mod:memo colunas="25" linhas="2" titulo="Observa��o" var="obs" />

		</mod:grupo>
		
	-->	
	</mod:entrevista>
	<mod:documento>



		<c:import
			url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />

		<table>
			<tr>
				<td>SOLICITA��O DE INSCRI��O EM A��O DE CAPACITA��O EXTERNA-SEM
				ONUS</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>N�/Ano:</td>
				<td>2001-04-SRH</td>
			</tr>
		</table>

		<br />
		<br />

		<table width="100%">
			<tr>
				<td colspan="2"><font size="2">A��o de Capacita��o: <b>${acao}</b></font>
				</td>
			</tr>
			<tr>
				<td colspan="2"><font size="2">Institui��o/Consultor: <b>${ic}</b></font>
				</td>
			</tr>
			<tr>
				<td width="70%"><font size="2">Per�odo Solicitado:<br>
				De: <b>${dataInicio}</b> a: <b>${dataFim}</b></font></td>
				<td width="30%"><font size="2">Cidade/UF: <b>${cidade}</b></font>
				</td>
			</tr>
			<tr>
				<td colspan="2"><font size="2">Prospecto: <b>${prospecto}</b></font>
				</td>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<td>
				<p><font size="2">Import�ncia que a a��o de capacita��o
				ter� para o desenvolvimento das atividades da unidade
				organizacional:&nbsp; <b>${imp}</b></font></p>
				</td>
			</tr>
		</table>
		<br>
		<table width="100%">
			<tr>
				<td>ATIVIDADES/TAREFAS DA UNIDADE QUE SER�O AFETADAS PELA
				CAPACITA��O</td>
			</tr>
		</table>
		<table width="100%">
			<tr>

				<td>Atividade/tarefa que ser� afetada pelo treinamento:</td>
				<td>Como ser� desenvolvida atualmente?</td>
				<td>Como voc� prev� que ficar� ap�s a capacita��o?
				</td>
			</tr>
		</table>

		<table width="100%">

			<c:forEach var="i" begin="1" end="${qtd_tar}">
				<tr>


					<td><font size="2"><b>${requestScope[f:concat('atividadeTarefa',i)]}</b></font></td>
					<td><font size="2"><b>${requestScope[f:concat('des',i)]}</b></font></td>
					<td><font size="2"><b>${requestScope[f:concat('capact',i)]}</b></font></td>
					

				</tr>

			</c:forEach>

		</table>
		<br>
		<table width="100%">
			<tr>
				<td><font size="3">SERVIDOR(ES) INDICADO(S)</font></td>
			</tr>
			<tr>
				<td><font size="3">Cada servidor indicado est�
				devidamente ciente do inteiro teor da portaria N� 042-GDF,DE
				10.9.2002, assumindo os compromissos determinados nesse ato
				normativo, sobre tudo no que se refere � multiplica��o do
				conhecimento adquirido.</font></td>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<td><font size="2">Nome</font></td>
				<td><font size="2">Fun��o</font></td>
			</tr>
		</table>

		<table width="100%">
			<c:forEach var="i" begin="1" end="${serv_indic}">
			
			
				<tr>					
					<td><font size="2"><b>${requestScope[f:concat(f:concat('nome',i),'_pessoaSel.descricao')]}</b></font></td>
					<td><font size="2"><b> <c:set var="cargo" value="${f:pessoa(requestScope[f:concat(f:concat('nome',i),'_pessoaSel.id')]).funcaoConfianca.descricao}"/>${cargo}</b></font></td>
				</tr>
			</c:forEach>
		</table>
		
		<table width="100%">
			<tr>
				<td colspan="2"><font size="2">Observa��o(justifica��o
				do numero de servidores indicados):<br>
				<b>${obs_serv}</b></font> </td>
			</tr>
			<tr>
				<td colspan="2"><font size="2">Crit�rios utilizados para as indica��es<br>
				<b>${criterios}</b></font> </td>
			</tr>
			<tr>
				<td width="30%"><font size="2">Data: <b>${data}</b></font></td>
				<td width="70%"><font size="2">Responsabilizo-me pelas
				informa��es prestadas e pela participa��o dos indicados, assim como
				pelo cumprimento do estabelecido na portaria N.042/02-GDF</font>
				
				<p align="center">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				_________________________________________<br>
				</p>
				<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Assinatura e carimbo do diretor.</font> <br>
				</td>
			</tr>
		</table>
		<br>
		<!--  
		<table width="100%">
			<tr>
				<td>SE��O DE TREINAMENTO - SETRE</td>
			</tr>
			<tr>
				<td><font size="2">Solicita��o constante do levantamento
				de necessidades de treinamento: <b>${solicit}</b></font></td>
			</tr>
			<tr>
				<td><font size="2">Reserva de vagas: <b>${reserv}</b></font></td>
			</tr>
			<tr>
				<td><font size="2">Contato: <b>${contato}</b></font></td>
			</tr>
			<tr>
				<td><font size="2">Conte�do program�tico(aprovado): <b>${aprovado}</b></font>
				</td>
			</tr>
			<tr>
				<td><font size="2">Observa��o: <b>${obs}</b></font></td>
			</tr>
		</table>
		-->
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />		
	</mod:documento>
</mod:modelo>
