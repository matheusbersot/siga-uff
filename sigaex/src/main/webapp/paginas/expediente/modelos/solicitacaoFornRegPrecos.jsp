<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>

<mod:modelo>
	<mod:entrevista>
	</mod:entrevista>
	<mod:documento>
		
		<html>
		<head>
		<style type="text/css" media="print">
			@page {
			    size:landscape;
				margin-left: 1cm;
				margin-right: 1cm;
				margin-top: 1cm;
				margin-bottom: 1cm;	}		
		</style>
		</head>
		<body>
		
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina2.jsp" />
		</td></tr>
			
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda2.jsp" />
		FIM CABECALHO -->
		<br/>
		<br/>
		<table width="100%" border="0"  bgcolor="#FFFFFF">
			<tr><td width="50%" bgcolor="#FFFFFF"><b>PREG�O:</b></td></tr>
			<tr><td bgcolor="#FFFFFF"><b>PROCESSO:</b></td></tr>
			<tr><td bgcolor="#FFFFFF"><b>GER�NCIA:</b></td></tr>
			<tr><td bgcolor="#FFFFFF"><b>VIG�NCIA DA ATA:</b></td></tr>
		</table>
		<br/>
		<p style="font-size:10" align="center"><b>SOLICITA��O DE FORNECIMENTO REGISTRO DE PRE�OS</b></p>
		<br/>
		<table width="100%" border="1" bordercolor="#000000"  bgcolor="#000000" >
			<tr align="center" >
				<td rowspan="2" bgcolor="#FFFFFF">Item</td>
				<td rowspan="2" bgcolor="#FFFFFF">Especifica��o Objeto</td>
				<td rowspan="2" bgcolor="#FFFFFF">Fornecedor</td>
				<td rowspan="2" bgcolor="#FFFFFF">CND<br/>Validade e localiza��o</td>
				<td rowspan="2" bgcolor="#FFFFFF">CRF<br/>Validade e localiza��o</td>
				<td rowspan="2" bgcolor="#FFFFFF">CCN<br/>Validade e localiza��o</td>
				<td colspan="4" bgcolor="#FFFFFF">Quantidade<br/></td>
				<td rowspan="2" bgcolor="#FFFFFF">Itens com<br/>aditamento contratual<br/>(25%)</td>
			</tr>	
			<tr>
				<td bgcolor="#FFFFFF">Licitada</td>
				<td bgcolor="#FFFFFF">Empenhada</td>
				<td bgcolor="#FFFFFF">Remanescente</td>
				<td bgcolor="#FFFFFF">Pedido</td>	
			</tr>
			<c:forEach var="x" begin="0" end="6">
				<tr>
					<c:forEach var="x" begin="0" end="10" >
						<td bgcolor="#FFFFFF">&nbsp</td>
					</c:forEach>	
				</tr>    
			</c:forEach>	
			
		</table>
		<br/><br/><br/>
	<%--<table width="90%" border="0" bordercolor="#000000" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" align="right">
		   <tr><td align="left">Rio de Janeiro,<br/><br/></td></tr>
		   <tr><td align="left">� subsecretaria de Administra��o, solicitando emiss�o de Nota de Empenho para aquisi��o do(s) item(ns) acima relacionado(s).</td></tr>  
		</table> --%>
		<p align="left" style="text-indent: 2cm;">${doc.dtExtenso}</p>
		
		<p style="text-indent: 2cm;">� subsecretaria de Administra��o, solicitando emiss�o de Nota de Empenho para aquisi��o do(s) item(ns) acima relacionado(s).</p>
		
		<br/><br/><br/><br/><br/><br/>
		<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" />
		
		
		
	
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental2.jsp" />
		FIM PRIMEIRO RODAPE -->
		<!-- INICIO RODAPE
		<br/>
		FIM RODAPE -->
		</body>
		</html>
	</mod:documento>
</mod:modelo>
