<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<mod:modelo>
	<mod:entrevista>
		<br/>
		<span style="color:red"> <b>PREENCHER OBRIGATORIAMENTE O CAMPO DESCRI��O COM NOME COMPLETO E ASSUNTO</b></span><br>
		<span style="color:red"> <b>ESTE DOCUMENTO DEVER� SER ENVIADO � SRH</b></span>	
		<br/><br/>
	<mod:grupo titulo="">	
		<mod:grupo>
				<mod:selecao var="ilustrissimo"
				titulo="VOCATIVO"
				opcoes="ILUSTR�SSIMA SENHORA DIRETORA;ILUSTR�SSIMO SENHOR DIRETOR"	
				reler="sim" />
		</mod:grupo>
		<br>	
	</mod:grupo>
	<mod:grupo titulo=""> 
		        <mod:texto titulo="RAMAL DO REQUERENTE" var="ramal"/></mod> <br><br>
		        <mod:selecao titulo="Acerto Gramatical da Lota��o" var="acgr"  opcoes="no;na" reler="sim" />
	</mod:grupo>
    <br/> 
				
	</mod:entrevista>

<mod:documento>	
<head>
		<style type="text/css">
@page {
	margin-left: 1cm;
	margin-right: 1cm;
	margin-top: 1cm;
	margin-bottom: 1cm;
}
      
</style>
		</head>
		<body>

		<c:if test="${empty tl}">
			<c:set var="tl" value="7pt"></c:set>
		</c:if>
			
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#ffffff"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr><br>
		   <tr bgcolor="#FFFFFF">
				<td width="100%">
					<table width="100%">
						<tr><br><br>
						<td align="center"><p style="font-family:Arial;font-weight:bold;font-size:11pt;">CERTID�O COMPROVANDO CONDI��O DE SERVIDOR</p></td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		FIM PRIMEIRO CABECALHO -->
		
        
		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" /> 
		FIM CABECALHO -->
				
				
		<c:set var="lotc" value="lotado"></c:set>
		<c:if test="${doc.subscritor.sexo == 'F'}">
			<c:set var="lotc" value="lotada"></c:set>
		</c:if>
		<c:set var="opt" value="${f:classNivPadr(doc.subscritor.padraoReferencia)}"/>
		
		<p style="text-align: center;font-weight:bold;font-size:11pt;"><center><br><br><b> ${ilustrissimo} DA SECRETARIA DE RECURSOS HUMANOS</center></b></p>
				<br><br><br><br>		
			${doc.subscritor.descricao}, matr�cula ${doc.subscritor.matricula}, ${doc.subscritor.cargo.nomeCargo}, ${opt},
			do Quadro de Pessoal do Tribunal Regional Federal da 2� Regi�o, ${lotc} ${acgr} ${doc.subscritor.lotacao.descricao}, 
			ramal ${ramal}, vem requerer a Vossa Senhoria que seja expedida <b>Certid�o</b> comprovando a sua condi��o de servidor desta Egr�gia Corte, contendo o respectivo endere�o e CNPJ desta, bem como a data de sua posse.
			<br><br>
			Esclarece, outrossim, serem estes dados necess�rios para loca��o de im�vel nesta Cidade.

			
			<br><br>
				
		Termos em que <br/>
		Espera deferimento.
		 	 
		<br/><br/>
			
		<!-- INICIO FECHO -->
		<p align="center">${doc.dtExtenso}</p>
		<!-- FIM FECHO -->
		
		<!-- import java.util.Date; Date hoje = new Date();  -->
		
		<!-- INICIO ASSINATURA -->
		<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		<!-- FIM ASSINATURA -->
		
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
		FIM RODAPE -->
		<br><br></td>
			</tr>
		</table>
		</body>
	</mod:documento>
</mod:modelo>