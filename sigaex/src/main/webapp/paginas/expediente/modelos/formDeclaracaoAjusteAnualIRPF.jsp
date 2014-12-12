<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<mod:modelo>
	<mod:entrevista>

		<mod:grupo titulo="">
			<mod:selecao titulo="Declara��o de ajuste anual de IRPF referente �" var="periodo"
				opcoes="2012/2013;2013/2014;2014/2015" />
		</mod:grupo>
		
		<mod:grupo titulo="Caso n�o tenha declarado bens � Receita Federal, favor marcar uma das op��es abaixo:">	
			<mod:radio titulo="N�o se aplica." var="tipoFormulario" valor="1" reler="sim" />
			<mod:radio titulo="Declaro n�o possuir bens." var="tipoFormulario" valor="2" reler="sim" marcado="N�o" />
			<mod:radio titulo="Declaro que possuo os seguintes bens:" var="tipoFormulario" reler="sim" valor="3" gerarHidden="N�o"/>
		</mod:grupo>
		
		<c:set var="valorTipoDeForm" value="${tipoFormulario}" />
		<c:if test="${empty valorTipoDeForm}">
			<c:set var="valorTipoDeForm" value="${param['tipoFormulario']}" />
		</c:if>
		
		
		<c:choose>
		<c:when test="${empty valorTipoDeForm or valorTipoDeForm == 1 or valorTipoDeForm == 2}"> <div style="display: none;"></c:when>
			<c:otherwise></div>			
			</c:otherwise>
		</c:choose>
		
		<mod:memo colunas="80" linhas="6" titulo="Declara��o de bens e direitos" var="bens" />
		</div>
				
		<mod:grupo titulo="">
		<br /><b>A Declara��o de IRPF e o Recibo de Entrega � Receita Federal dever�o ser encaminhados, 
		DIGITALMENTE, em formato PDF, pelo SIGA-DOC, por meio do campo 'anexar arquivo': <br />
		a) no caso de n�o possuir token, digitalizar a c�pia da Declara��o e a do respectivo 
		Recibo (assinado e datado);<br />
		b) no caso de possuir certifica��o (token ou smartcard), anex�-los ap�s gerar imagem PDF
		 por meio do programa da Receita Federal (n�o � necess�rio &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;imprimi-los). � obrigat�ria a assinatura digital dos arquivos.</b>
		</mod:grupo>
		
	</mod:entrevista>
	<mod:documento>
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
		<table width="100%" border="0" bgcolor="#FFFFFF">
			<tr>
				<td>
					<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
				</td>
			</tr>
		</table>
	
		FIM PRIMEIRO CABECALHO -->
		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda2.jsp" />
		FIM CABECALHO -->

			<br />
			<p style="font-family:Arial;font-size:10pt;">Sr.(a) Supervisor(a) da Se��o de Cadastro</p>
			<br />
			<p style="text-align: justify; line-height: 150%; font-family: Arial; font-size: 10pt;">${doc.subscritor.descricao}, matr�cula n� RJ${doc.subscritor.matricula},
				 ${doc.subscritor.cargo.nomeCargo}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, encaminha, 
				 em anexo, o arquivo digital da Declara��o de Ajuste Anual do IRPF, referente � 
				 <c:out value="${periodo}"/>, e o respectivo Recibo de Entrega � Receita Federal.
			</p>
			<c:if test="${not empty tipoFormulario and tipoFormulario != 1}">
				<p style="font-family:Arial;font-size:10pt;">Declara, ainda, que 
					<c:choose>
						<c:when test="${tipoFormulario == 2}">n�o possui bens.</c:when>
						<c:otherwise>possui os seguintes bens: <p style="text-align: justify; line-height: 150%; font-family: Arial; font-size: 10pt;"><siga:fixcrlf><c:out value="${bens}"/></siga:fixcrlf></p></c:otherwise>
					</c:choose>
				</p>
			</c:if>
			<br /><br />
			<p style="font-family: Arial; font-size: 10pt; text-align: center;">${doc.dtExtenso}</p>
			<br />

	<p> </p> <p> </p>
			
			
					<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" />
					

		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental2.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita2.jsp" />
		FIM RODAPE -->

		</body>
		</html>
	</mod:documento>
</mod:modelo>
