<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
REQUERIMENTO PARA AVERBA��O DE TEMPO DE SERVI�O -->

<mod:modelo>
	<mod:entrevista>
		<br/>
		<span style="color:red"> <b>PREENCHER OBRIGATORIAMENTE O CAMPO DESCRI��O COM NOME COMPLETO E ASSUNTO</b></span><br>
		<span style="color:red"> <b>ESTE DOCUMENTO DEVER� SER ENVIADO � SRH</b></span>	
		<br/><br/>
	<mod:grupo titulo=" ">	
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
			 <br/><br>
			 <mod:selecao var="contAverb"
				titulo="Quantidade de Averba��es"
				opcoes="1;2;3;4;5"
				reler="sim"  /><br/>
		<mod:grupo depende="contDependAjax">
		<br>
				<c:forEach var="i" begin="1" end="${contAverb}">
					<mod:grupo>
						<mod:texto titulo="Institui��o n� ${i}" var="inst${i}" largura="30" 
						maxcaracteres="50" obrigatorio="Sim"/>
					</mod:grupo>
                    <hr style="color: #FFFFFF;" />
				</c:forEach>
		</mod:grupo>	
	    <br/> 		
			
	<mod:grupo titulo="Certid�o(�es) anexada(s) (Resolu��o n�.260/2002/CJF)">	
		    <br>
		   <mod:grupo>
				<mod:caixaverif titulo="C�pia de Certid�o expedida por �rg�o p�blico (para Servi�o P�blico da administra��o direta, aut�rquica ou fundacional)" 
				var="copcertorg" reler="sim" />
		   	 </mod:grupo>
		     <br>
		     <mod:grupo>
				<mod:caixaverif titulo="C�pia de Certid�o expedida pelo INSS (para atividade privada/aut�noma)" 
				var="copcertinss" reler="sim" />
		     </mod:grupo>
		   <br>
		    <mod:grupo>
		        <mod:caixaverif titulo="Outros" var="outros" reler="sim" />
			    <c:if test="${ outros == 'Sim'}">
			    <mod:texto titulo="- &nbsp;Especificar" var="outrostext" largura="40" />
		    	</c:if>
		     </mod:grupo>
		    <!--  
           	<mod:grupo>
             	<mod:caixaverif titulo="Outros" var="outros" reler="sim"/>
				<mod:texto titulo="" var="descricaoutros" largura="50" /></mod>
			</mod:grupo> -->
			<br><br>
    	</mod:grupo>
		
			
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
		<c:set var="opt" value="${f:classNivPadr(doc.subscritor.padraoReferencia)}"/>	
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#ffffff"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr><br>
		   <tr bgcolor="#FFFFFF">
				<td width="100%">
					<table width="100%">
						<tr><br><br>
						<td align="center"><p style="font-family:Arial;font-weight:bold;font-size:9pt;">AVERBA��O DE TEMPO DE SERVI�O</p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->
		
       
		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" /> 
		FIM CABECALHO -->
				
				
		<c:if test="${doc.subscritor.sexo == 'M'}">
			<c:set var="lotc" value="lotado"></c:set>
		</c:if>
		<c:if test="${doc.subscritor.sexo == 'F'}">
			<c:set var="lotc" value="lotada"></c:set>
		</c:if>
		<c:set var="prest" value="prestado �s institui��es abaixo"></c:set>
		<c:set var="plur" value="Institui��es:"></c:set>
		<c:if test="${contAverb < 2}">
			<c:set var="prest" value="prestado � institui��o abaixo"></c:set>
			<c:set var="plur" value="Institui��o:"></c:set>
		</c:if>
		<c:set var="anex" value="anexo"></c:set>
		<c:set var="cert" value="Certid�o anexada"></c:set>
        <c:if test="${(copcertorg == 'Sim' and copcertinss == 'Sim') or (copcertorg == 'Sim' and outros == 'Sim') or (copcertinss == 'Sim' and outros == 'Sim')}">
          <c:set var="anex" value="anexos"></c:set>
          <c:set var="cert" value="Certid�es anexadas"></c:set>
        </c:if>
		<p style="font-family:Arial;font-weight:bold;font-size:9pt;"><center><br><br><b> ${ilustrissimo} DA SECRETARIA DE RECURSOS HUMANOS</center></b></p>
				
			${doc.subscritor.descricao}, matr�cula ${doc.subscritor.matricula}, ${doc.subscritor.cargo.nomeCargo}, ${opt}, 
			do Quadro de Pessoal do Tribunal Regional Federal da 2� Regi�o, ${lotc} ${acgr} ${doc.subscritor.lotacao.descricao}, ramal ${ramal}, vem requerer 
			<b>averba��o de tempo de servi�o</b> ${prest}, conforme ${anex}, para todos os fins de direito.
            <br><br>
			&nbsp;&nbsp;&nbsp;<b>${plur}</b>
		    <br>
			<c:forEach var="j" begin="1" end="${contAverb}">
			<c:set var="instt" value="${requestScope[(f:concat('inst',j))]}"/>
			&nbsp;&nbsp;&nbsp;${instt}<br>
			</c:forEach>
	        <br>
			&nbsp;&nbsp;&nbsp;<b>${cert} (Resolu��o n�.260/2002/CJF):</b>
			<br>
			&nbsp;&nbsp;&nbsp;
			<c:if test="${ copcertorg == 'Sim'}">
			    [X] C�pia de Certid�o expedida por �rg�o P�blico
			    <br>		
			</c:if>
			<c:if test="${ copcertorg == 'Nao'}">
			    [&nbsp;&nbsp;] C�pia de Certid�o expedida por �rg�o P�blico
			    <br>		
			</c:if>
			&nbsp;&nbsp;&nbsp;
			<c:if test="${ copcertinss == 'Sim'}">
			    [X] C�pia de Certid�o expedida pelo INSS
			    <br>		
			</c:if>
			<c:if test="${ copcertinss == 'Nao'}">
			    [&nbsp;&nbsp;] C�pia de Certid�o expedida pelo INSS
			    <br>		
			</c:if>
			&nbsp;&nbsp;&nbsp;
			<c:if test="${ outros == 'Sim'}">
			    [X] ${outrostext}
			</c:if>
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
		
		</body>
	</mod:documento>
</mod:modelo>