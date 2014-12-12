<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- este modelo trata de
FORMULARIO DE inclusao de USU�RIO-->

<mod:modelo>
	<mod:entrevista>


		<mod:grupo>
			<mod:selecao titulo="Incluir Usu�rio" opcoes="Magistrado;Servidor"
				var="tipoUsuario" reler="sim" /><br />
			<mod:texto titulo="E-mail Institucional (alias)" var="email" largura="20"
				maxcaracteres="30" obrigatorio="Sim" />@jfrj.jus.br	
		</mod:grupo>

		<mod:grupo titulo="Endere�o funcional do usu�rio">
			<mod:mensagem titulo=""
				texto="(Incluindo Rua, Avenida, Pra�a, n�mero do pr�dio, bloco, andar e sala, se pertinente)"
				vermelho="" /><br /><br />
			<mod:texto titulo="Logradouro" var="logradouro" largura="40"
				obrigatorio="Sim" maxcaracteres="100" /><br />
			<mod:texto titulo="Bairro" var="bairro" largura="20"
				obrigatorio="Sim" maxcaracteres="50" />
			<mod:texto titulo="CEP" var="cep" largura="10" obrigatorio="Sim"
				maxcaracteres="10" />
			<br />
		</mod:grupo>
		<mod:grupo titulo="Telefone funcional">
			<mod:texto titulo="C�digo de �rea" var="codArea" largura="2"
				maxcaracteres="2" obrigatorio="Sim" />
			<mod:texto titulo="N�mero" var="telefone" largura="10"
				maxcaracteres="10" obrigatorio="Sim" />
		</mod:grupo>

		<c:if test="${tipoUsuario == 'Magistrado'}">
			<mod:grupo>
				<mod:mensagem
					texto="Para indica��o de novo usu�rio, no caso de remo��o do
					magistrado para outra Se��o Judici�ria ou Tribunal, dever� ser
					preenchido e encaminhado � SEJUD o respectivo formul�rio de
					exclus�o. Caso o magistrado j� tenha sido removido, o formul�rio de
					solicita��o de exclus�o poder� ser encaminhado pelo Diretor de
					Secretaria."
					titulo="Observa��o" vermelho="N�o" />
			</mod:grupo>
		</c:if>
		<c:if test="${tipoUsuario == 'Servidor'}">
			<mod:grupo>
				<mod:pessoa titulo="Nome do Juiz autorizador" var="juiz" />
			</mod:grupo>

			<mod:grupo titulo="Observa��es:">
				<ol style="list-style-type: decimal; font-weight: bold;">
					<li>No caso de remo��o do servidor, para indica��o de novo
					usu�rio, dever� ser preenchido e encaminhado � SEJUD o respectivo
					formul�rio de exclus�o;</li>
					<li>Antes de finalizar o documento, dever� ser inclu�do o nome
					do magistrado como cossignat�rio.</li>
				</ol>
			</mod:grupo>

		</c:if>



	</mod:entrevista>

	<mod:documento>
		<c:set var="tl" value="8pt" />
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
@page {
	margin-left: 3cm;
	margin-right: 2cm;
	margin-top: 1cm;
	margin-bottom: 2cm;
}
</style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<table width="100%">
						<tr>
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">FORMUL&Aacute;RIO DE INCLUS&Atilde;O DE USU&Aacute;RIO <br />RENAJUD WEB</p></td>
						</tr>
						<tr>
							<td align="right">
								<p><b>Formul�rio N&ordm; ${doc.codigo}</b></p><br/>
							</td>
						</tr>
						
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" />
		FIM CABECALHO -->

		<br />
		<mod:letra tamanho="${tl}">



			<table bgcolor="#000000" border="1" cellpadding="5" width="900" align="center">
				<tr>
					<td bgcolor="#FFFFFF" colspan="3" align="left"><b> 1.1 - SOLICITA��O DE
					CADASTRAMENTO DE <c:if test="${tipoUsuario == 'Magistrado'}">MAGISTRADO</c:if>
					<c:if test="${tipoUsuario == 'Servidor'}">SERVIDOR</c:if> </b></td>
				</tr>

				<tr>
					<td bgcolor="#FFFFFF" colspan="3" align="left"><b>1.1 - IDENTIFICA��O DO
					USU�RIO </b></td>
				</tr>

				<tr>
					<td bgcolor="#FFFFFF" colspan="3" align="left"><b>NOME COMPLETO</b><br />
					${doc.subscritor.descricao}</td>
				</tr>

				<tr>
					<td bgcolor="#FFFFFF" align="left" width="450"><b>MATR&Iacute;CULA</b><br />
					${doc.subscritor.sigla}</td>
					<td bgcolor="#FFFFFF" align="left" width="450" colspan="2"><b>CPF</b><br />
					${f:formatarCPF(doc.subscritor.cpfPessoa)}</td>
				</tr>

				<tr>
					<td bgcolor="#FFFFFF" align="left"><b>LOTA&Ccedil;&Atilde;O</b><br />
					${doc.subscritor.lotacao.descricao}</td>
					<td bgcolor="#FFFFFF" align="left" colspan="2"><b>E-MAIL INSTITUCIONAL</b><br />
					${email}@jfrj.jus.br</td>
				</tr>

				<tr>
					<td bgcolor="#FFFFFF" colspan="3" align="left"><b> 1.2 - ENDERE�O FUNCIONAL
					DO USU�RIO</b></td>
				</tr>

				<tr>
					<td bgcolor="#FFFFFF" align="left" colspan="3"><b>LOGRADOURO (INCLUINDO RUA,
					AVENIDA, PRA�A, N�MERO DO PR�DIO, BLOCO, ANDAR E SALA, SE
					PERTINENTE)</b><br />
					${logradouro}</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" align="left"><b>BAIRRO</b><br />
					${bairro}</td>
					<td bgcolor="#FFFFFF" align="left"><b>CEP</b><br />
					${cep}</td>
					<td bgcolor="#FFFFFF" align="left"><b>TELEFONE FUNCIONAL</b><br />
					(${codArea}) ${telefone}</td>
				</tr>

			</table>

			<table bgcolor="#000000" border="1" cellpadding="5" width="900" align="center">

				<tr align="justify">
					<td bgcolor="#FFFFFF" colspan="2"><b>TERMO DE RESPONSABILIDADE</b> <br />
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Declaro estar ciente das atribui��es referentes � seguran�a do
					sistema RENAJUD, contidas no conv�nio celebrado entre a Uni�o, por
					interm�dio dos Minist�rios das Cidades e da Justi�a, e o Conselho
					Nacional de Justi�a (CNJ), e do respectivo regulamento,<b>
					comprometendo-me a:</b> <br />
					<br />
					a) manter sigilo sobre os dados a que vier a ter acesso ou
					conhecimento em raz�o do referido conv�nio, estando ciente do que
					preceitua o Decreto n� 4.553, de 27 de dezembro de 2002
					(salvaguarda de dados, informa��es, documentos e materiais
					sigilosos); <br />
					<br />


					b) utilizar os dados a que tiver acesso exclusivamente dentro das
					atribui��es de minha responsabilidade; <br />
					<br />

					c) n�o revelar, fora do �mbito profissional, fato ou informa��o de
					qualquer natureza de que tenha conhecimento por for�a de minhas
					atribui��es, salvo em decorr�ncia de decis�o competente na esfera
					legal ou judicial ou de autoridade superior; <br />
					<br />
					d) manter absoluta cautela quando da exibi��o de dados em tela ou
					impressora ou, ainda, na grava��o em meios eletr�nicos, a fim de
					que deles n�o venham tomar ci�ncia pessoas n�o autorizadas; <br />
					<br />
					e) n�o me ausentar da esta��o de trabalho sem encerrar a sess�o de
					uso do sistema, a fim de garantir que pessoas n�o autorizadas
					utilizem indevidamente as informa��es; <br />
					<br />
					f) acompanhar a impress�o e recolher as listagens cuja emiss�o eu
					tenha solicitado; <br />
					<br />
					g) responder em todas as inst�ncias pelas consequ�ncias decorrentes
					das a��es ou omiss�es de minha parte, as quais possam p�r em risco
					ou comprometer a exclusividade de conhecimento de minha senha ou
					das transa��es em que esteja habilitado. <br />
					<br />
					Declaro ter conhecimento de que estou sujeito �s penalidades
					previstas em lei pela n�o-observ�ncia do contido neste Termo de
					Responsabilidade.</td>
				</tr>


				<tr>
					<td bgcolor="#FFFFFF" width="400" align="left"><b>LOCAL/DATA</b><br />
					${doc.dtExtenso}</td>
					<td bgcolor="#FFFFFF" align="center" width="500"><br />
					<br />
					__________________________________________ <br />
					Assinatura do Solicitante</td>
				</tr>
			</table>

			<c:if test="${tipoUsuario == 'Servidor'}">
				<br />
				<br />
				<table bgcolor="#000000" border="1" cellpadding="2" width="900" align="center">
					<tr>
						<td bgcolor="#FFFFFF" colspan="2" align="left"><b>2- AUTORIZA��O PARA
						CADASTRAMENTO</b></td>
					</tr>
					<tr>
						<td bgcolor="#FFFFFF" width="400" align="left"><b>NOME DO JUIZ AUTORIZADOR</b><br />
						${f:pessoa(requestScope['juiz_pessoaSel.id']).nomePessoa}</td>
						<td bgcolor="#FFFFFF" width="500" align="center"><br />
						<br />
						______________________ <br>
						Assinatura do Juiz Autorizador</td>
					</tr>
				</table>


				<table bgcolor="#000000" border="1" cellpadding="2" width="900" align="center">
					<tr>
						<td bgcolor="#FFFFFF" colspan="2" align="left"><b>3- CADASTRAMENTO - CAMPO
						RESTRITO � SEJUD</b></td>
					</tr>

					<tr>
						<td bgcolor="#FFFFFF" width="400" colspan="2" align="left"><b>NOME DO
						CADASTRADOR</b><br />
						<br />
						</td>
					</tr>

					<tr>
						<td bgcolor="#FFFFFF" width="400" align="left"><b>DATA DO CADASTRAMENTO</b><br />
						<br />
						</td>
						<td bgcolor="#FFFFFF" width="500" align="center"><br />
						<br />
						______________________ <br>
						Assinatura do Cadastrador</td>
					</tr>
				</table>


			</c:if>


			<c:if test="${tipoUsuario == 'Magistrado'}">
				<br />
				<br />



				<table bgcolor="#000000" border="1" cellpadding="2" width="900" align="center">
					<tr>
						<td bgcolor="#FFFFFF" colspan="2" align="left"><b>2- CADASTRAMENTO - CAMPO
						RESTRITO � SEJUD</b></td>
					</tr>

					<tr>
						<td bgcolor="#FFFFFF" width="400" colspan="2" align="left"><b>NOME DO
						CADASTRADOR</b><br />
						<br />
						</td>
					</tr>

					<tr>
						<td bgcolor="#FFFFFF" width="400" align="left"><b>DATA DO CADASTRAMENTO</b><br />
						<br />
						</td>
						<td bgcolor="#FFFFFF" width="500" align="center"><br />
						<br />
						______________________ <br>
						Assinatura do Cadastrador</td>
					</tr>
				</table>
			</c:if>
		</mod:letra>
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

