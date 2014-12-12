<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>

		<mod:texto titulo="N�mero do processo ao qual o parecer se refere"
			var="numProc" largura="30" reler="ajax" idAjax="numProcAjax" />
		<mod:grupo depende="numProcAjax">
			<c:if test="${empty numProc}">
				<mod:mensagem titulo="Alerta"
					texto="o processo ao qual o parecer se refere deve ser preenchido."
					vermelho="Sim" />
			</c:if>
		</mod:grupo>
		<mod:texto titulo="Folhas" var="folhas" largura="6" reler="ajax"
			idAjax="folhasAjax" maxcaracteres="10" />
		<mod:grupo depende="folhasAjax">
			<c:if test="${empty folhas}">
				<mod:mensagem titulo="Alerta"
					texto="o campo acima deve ser preenchido com a sele��o de p�ginas."
					vermelho="Sim" />
			</c:if>
		</mod:grupo>
		<mod:mensagem
			texto=""
			titulo="Observa��es:" vermelho="Sim"></mod:mensagem><br />
		<mod:mensagem
			texto="1) N�o preencha o campo 'Destinat�rio';"
			titulo="" vermelho="N�o"></mod:mensagem><br />
		<mod:mensagem
			texto="2) Antes de finalizar o documento, dever� ser inclu�do o cossignat�rio."
			titulo="" vermelho="N�o"></mod:mensagem>

	</mod:entrevista>
	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
@page {
	margin-left: 3cm;
	margin-right: 2cm;
	margin-top: 1cm;
	margin-bottom: 1cm;
}
</style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<table width="100%">
						<tr><br /><br /><br /></tr>
						<tr>
							<td align="left"><font style="font-family:Arial;font-size:11pt;font-weight:bold;">
							Processo N&ordm; ${numProc}</font></td>
						</tr>
						
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->
		<br />
		
		<p style="font-size: 11pt; text-indent: 3cm; font-weight: bold;">
		Exmo. Juiz Federal - Diretor do Foro:</p>
		
		
		<p style="text-align: justify; text-indent: 3cm;">
		Trata o presente processo da concess�o e/ou altera��o de
		<b>Adicional de Qualifica��o</b> (AQ), institu�do pela Lei n&ordm;
		11.416/2006, em seu art. 14, abaixo transcrito, destinado aos
		servidores das carreiras dos Quadros de Pessoal do Poder Judici�rio da
		Uni�o, em raz�o dos conhecimentos adicionais adquiridos em a��es de
		treinamento.</p>
		
		<p style="text-align: justify; margin-left: 5cm; text-indent: 3cm;"><b>
		Art. 14. � institu�do o Adicional de Qualifica��o - AQ destinado aos
		servidores das Carreiras dos Quadros de Pessoal do Poder Judici�rio,
		em raz�o dos conhecimentos adicionais adquiridos em <u>a��es de
		treinamento</u>, t�tulos, diplomas ou certificados de cursos de
		p�s-gradua��o, em sentido amplo ou estrito, em �reas de interesse dos
		�rg�os do Poder Judici�rio a serem estabelecidas em regulamento.</b> (grifos nossos)</p>
		
		<p style="text-align: justify; text-indent: 3cm;">
		O AQ foi regulamentado pela Portaria Conjunta n&ordm; 01, de 07/03/2007, em seu
		Anexo I, da Presidente do STF e do CNJ e dos Presidentes dos Tribunais
		Superiores, do CJF, do Conselho Superior da Justi�a do Trabalho e do
		TJ-DF, publicada no D.O.U. de 09/03/2007 (retificada pela Portaria
		n&ordm; 022, de 17/04/2007, do CJF, publicada no D.O.U.II de
		19/04/2007), e pela Resolu��o n� 126, de 22/11/2010, do CJF, publicada 
		no D.O.U. de 24/11/2010, al�m das orienta��es operacionais produzidas no 
		Encontro de Dirigentes de Recursos Humanos do Conselho da Justi�a Federal e dos
		Tribunais Regionais Federais, realizado no per�odo de 26 a 28/03/2007.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">
		A norma regulamentadora estabeleceu no art. 5&ordm; as �reas de interesse do
		Poder Judici�rio Federal a seguir destacadas: servi�os de
		processamento de feitos; execu��o de mandados; an�lise e pesquisa de
		legisla��o, doutrina e jurisprud�ncia nos v�rios ramos do Direito;
		estudo e pesquisa do sistema judici�rio brasileiro; organiza��o e
		funcionamento dos of�cios judiciais e as inova��es tecnol�gicas
		introduzidas; elabora��o de pareceres jur�dicos; reda��o; gest�o
		estrat�gica, de pessoas, de processos, e da informa��o; material e
		patrim�nio; licita��es e contratos; or�amento e finan�as; controle
		interno; seguran�a; transporte; tecnologia da informa��o; comunica��o;
		sa�de; engenharia; arquitetura, al�m dos vinculados a especialidades
		peculiares a cada �rg�o do Poder Judici�rio da Uni�o, bem como aquelas
		que venham a surgir no interesse do servi�o.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">
		Para a concess�o do AQ decorrente de a��es de treinamento, custeadas ou n�o pela 
		Administra��o, devem ser observadas as �reas de interesse especificadas 
		acima juntamente com as atribui��es do cargo efetivo, ou com as atribui��es 
		do cargo em comiss�o/fun��o comissionada que, porventura, estejam sendo exercidas pelo servidor, ou, 
		ainda, com as atividades desenvolvidas pelo servidor em sua unidade de 
		lota��o, conforme disposto no art. 17 da Resolu��o n&ordm; 126.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">Destaca-se que,
		no que se refere �s a��es de treinamento custeadas por esta Se��o 
		Judici�ria, os registros s�o averbados automaticamente pelo N�cleo de Capacita��o e Desenvolvimento - NCDE.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">No que tange �s a��es 
		de treinamento n�o custeadas pela Administra��o, deve ser observado 
		o artigo 21 da Resolu��o n� 126.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">Norteando-se
		pelas normas legais anteriormente mencionadas, ap�s a an�lise de todos
		os certificados e declara��es enviadas, bem como dos registros
		constantes no NCDE, sugiro a <b>concess�o e/ou
		altera��o</b> do Adicional de Qualifica��o decorrente de A��es de
		Treinamento, conforme especificado no <b>Anexo I</b> (fls. ${folhas }), 
		nos percentuais indicados para cada servidor, observando-se os respectivos
		efeitos financeiros, pois preencheram todos os requisitos e condi��es para 
		a sua implementa��o.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">� o Parecer.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">� Superior
		Considera��o.</p>

		<p style="text-align: justify; text-indent: 3cm;">RJ,
		${doc.dtDocDDMMYY}.</p>

		<c:import url="/paginas/expediente/modelos/inc_assinaturaSemCosig.jsp?formatarOrgao=sim" />
		
		<p style="text-align: justify; text-indent: 3cm;">Ratifico o
		parecer. � DIRFO.</p>
		
		<p style="text-align: justify; text-indent: 3cm;">RJ,
		${doc.dtDocDDMMYY}.</p>
		
		<c:import url="/paginas/expediente/modelos/inc_assinaturaSemSubsc.jsp?formatarOrgao=sim" />
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->
		</body>
		</html>
	</mod:documento>
</mod:modelo>
