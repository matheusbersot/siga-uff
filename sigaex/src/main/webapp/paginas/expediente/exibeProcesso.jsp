<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>

<%@page import="br.gov.jfrj.siga.ex.ExMovimentacao"%>
<%@page import="br.gov.jfrj.siga.ex.ExDocumento"%>
<%@page import="br.gov.jfrj.siga.ex.ExMobil"%>
<%@page import="br.gov.jfrj.siga.ex.ExArquivoNumerado"%>
<%@page import="br.gov.jfrj.siga.ex.ExArquivo"%>
<%@page import="java.util.List"%>
<siga:cabecalho titulo="Documento" popup="${param.popup}" />

<c:if test="${not docVO.digital}">
	<script type="text/javascript">
		$("html").addClass("fisico");
	</script>
</c:if>

<script type="text/javascript">
	//Input the IDs of the IFRAMES you wish to dynamically resize to match its content height:
	//Separate each ID with a comma. Examples: ["myframe1", "myframe2"] or ["myframe"] or [] for none:
	var iframeids = [ "maincntnt" ]

	//Should script hide iframe from browsers that don't support this script (non IE5+/NS6+ browsers. Recommended):
	var iframehide = "no"

	var getFFVersion = navigator.userAgent.substring(
			navigator.userAgent.indexOf("Firefox")).split("/")[1]
	var FFextraHeight = parseFloat(getFFVersion) >= 0.1 ? 3 : 0

	var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

	if (is_chrome) {
		FFextraHeight = 30;

	}

	//extra height in px to add to iframe in FireFox 1.0+ browsers
</script>
<script type="text/javascript" language="Javascript1.1">
	function pageHeight() {
		return window.innerHeight != null ? window.innerHeight
				: document.documentElement
						&& document.documentElement.clientHeight ? document.documentElement.clientHeight
						: document.body != null ? document.body.clientHeight
								: null;
	}

	function resize() {
		var ifr = document.getElementById('painel');
		var ifrp = document.getElementById('paipainel');

		ifr.height = pageHeight() - 300;

		if (ifr && !window.opera) {
			ifr.style.display = "block";
			if (ifr.contentDocument && ifr.contentDocument.body.offsetHeight) //ns6 syntax
				ifr.height = ifr.contentDocument.body.offsetHeight
						+ FFextraHeight;
			else if (ifr.Document && ifr.Document.body.scrollHeight) //ie5+ syntax
				ifr.height = ifr.Document.body.scrollHeight;
		}

		//	parent.document.getElementById('painel').height = "0";
		//	document.getElementById('painel').height = document.getElementById('painel').document.height;
		//	if(navigator.appName!='Microsoft Internet Explorer'){
		//		parent.document.getElementById('painel').height =  painel.document.height + 5;
		//	}else{
		//		parent.document.getElementById('painel').style.height = painel.document.body.scrollHeight + 5;
		//	}
	}

	function telaCheia(b) {
		var divMain = document.getElementById('main');
		var divSidebar = document.getElementById('sidebar');
		//var divDoc = document.getElementById('paipainel');

		if (b) {
			divMain.setAttribute("class", "gt-bd clearfix");
			divMain.className = "gt-bd clearfix";
			divSidebar.style.display = "none";
		} else {
			divMain.setAttribute("class", "gt-bd gt-cols-2 clearfix");
			divMain.className = "gt-bd gt-cols-2 clearfix";
			divSidebar.style.display = "block";
		}
		resize();
	}
</script>

<div class="gt-bd" style="padding-bottom: 0px;">
	<div class="gt-content">

		<h2>
			<c:if test="${empty ocultarCodigo}">${docVO.sigla}</c:if>
		</h2>

		<c:forEach var="m" items="${docVO.mobs}" varStatus="loop">
			<ww:if test="%{((((mob.id == #attr.m.mob.id))))}">
				<h3 style="margin-bottom: 0px;">
					<ww:property
						value="%{#attr.m.getDescricaoCompletaEMarcadoresEmHtml(cadastrante,lotaTitular)}"
						escape="false" />
					<c:if test="${docVO.digital and not empty m.tamanhoDeArquivo}"> - ${m.tamanhoDeArquivo}</c:if>
				</h3>
			</ww:if>
		</c:forEach>

		<c:choose>
			<c:when test="${doc.eletronico}">
				<c:set var="exibedoc" value="header_eletronico" />
			</c:when>
			<c:otherwise>
				<c:set var="exibedoc" value="header" />
			</c:otherwise>
		</c:choose>

		<p class="gt-table-action-list">
			<siga:links inline="${true}">
				<ww:url id="url" action="exibir" namespace="/expediente/doc">
					<ww:param name="sigla" value="%{sigla}" />
				</ww:url>
				<a name="inicio" style="float: right; padding-right: 5pt;"
					class="once" href="#final"><img
					src="/siga/css/famfamfam/icons/arrow_down.png"
					style="margin-right: 5px;">Ir para o Final</a>
				<siga:link icon="application_view_list" classe="once"
					title="Visualizar&nbsp;Movimentações" url="${url}" test="${true}" />
				<siga:link icon="wrench" title="Preferência:" test="${true}" />
				<input type="radio" id="radioHTML" name="formato" value="html"
					checked="checked" onclick="exibir(htmlAtual,pdfAtual,'');">&nbsp;HTML<!-- <a
					id="htmllink"><img src="/siga/css/famfamfam/icons/zoom.png" />
				</a> -->
				</input>

				<input type="radio" id="radioPDF" name="formato" value="pdf"
					" onclick="exibir(htmlAtual,pdfAtual,'');">&nbsp;PDF - <a
					id="pdflink">abrir&nbsp;</a>
				</input>

				<input type="radio" id="radioPDFSemMarcas" name="formato"
					value="pdfsemmarcas"
					" onclick="exibir(htmlAtual,pdfAtual,'semmarcas/');">&nbsp;PDF sem marcas - <a
					id="pdfsemmarcaslink">abrir&nbsp;</a>
				</input>

				<input type="checkbox" id="TelaCheia" name="telacheia"
					value="telacheia" " onclick="javascript: telaCheia(this.checked);">&nbsp;Tela cheia</input>
			</siga:links>
		</p>

	</div>
</div>

<div id="main" class="gt-bd gt-cols-2 clearfix"
	style="padding-top: 0px; margin-top: 0px;">

	<div id="sidebar" class="gt-sidebar">
		<div class="gt-content-box gt-for-table">

			<table class="gt-table"
				style="table-layout: fixed; word-wrap: break-word">
				<COL width="55%" />
				<COL width="30%" />
				<COL width="15%" />

				<c:set var="arqsNum" value="${mob.arquivosNumerados}" />

				<tr class="${exibedoc}">
					<td align="center">Documentos do Dossiê</td>
					<td align="center">Lotação</td>
					<td align="center">Pág.</td>
				</tr>

				<c:forEach var="arqNumerado" items="${arqsNum}">
					<tr>
						<td style="padding-left: ${arqNumerado.nivel * 5 + 5}pt"><c:if
								test="${!empty arqNumerado.arquivo.resumo}">
								<!-- <ul style="font-size: 9;font-style: italic;color: gray;list-style: disc;margin: 0px;margin-left: 25px">
						   	-->
								<c:forEach var="itemResumo"
									items="${arqNumerado.arquivo.resumo}">
									<!-- <li>${itemResumo.key}:${itemResumo.value}  -->
									<c:set var="tooltipResumo"
										value="${tooltipResumo}${itemResumo.key}:${itemResumo.value}&#13" />
								</c:forEach>
								<!-- </ul>  -->
							</c:if> <a
							title="${fn:substring(tooltipResumo,0,fn:length(tooltipResumo)-4)}"
							href="javascript:exibir('${arqNumerado.referenciaHtml}','${arqNumerado.referenciaPDF}','')">${arqNumerado.nome}</a>
							<c:set var="tooltipResumo" value="" />
						</td>
						<td align="center">${arqNumerado.arquivo.lotacao.sigla}</td>
						<td align="center">${arqNumerado.paginaInicial}</td>
					</tr>
					<c:if test="${!empty arqNumerado.arquivo.resumo}">
						<c:set var="possuiResumo" value="sim" />
					</c:if>


					<c:set var="arquivo" value="${arqNumerado}" scope="request" />
					<%
				ExArquivo arq = ((ExArquivoNumerado) request.getAttribute("arquivo")).getArquivo();
			
				if (arq instanceof ExMovimentacao) {
					request.setAttribute("mov", (ExMovimentacao) arq);
					%>
					<c:if
						test="${mov.exTipoMovimentacao.id == 2 && !empty mov.descrMov}">
						<c:set var="possuiResumo" value="sim" />
					</c:if>
					<%
				}
				%>

				</c:forEach>
				<tr>
					<td style="padding-left: 5pt;"><a
						href="javascript:exibir('${arqsNum[0].referenciaHtml}&completo=1','${arqsNum[0].referenciaPDF}&completo=1','')">COMPLETO</a>
					</td>
					<td align="center" style="padding-left: 5pt;"></td>
					<td align="center" style="padding-left: 5pt;">
						${arqsNum[fn:length(arqsNum)-1].paginaFinal}</td>
				</tr>

				<c:if test="${!empty possuiResumo}">
					<tr>
						<ww:url id="url" action="exibirResumoProcesso"
							namespace="/expediente/doc">
							<ww:param name="sigla">${mob.sigla}</ww:param>
						</ww:url>
						<td colspan="3" style="padding-left: 5pt;"><a
							href="javascript:exibirNoIFrame('${url}')">RESUMO</a>
						</td>
					</tr>
				</c:if>

			</table>
		</div>
	</div>

	<div class="gt-content">
		<%--
			<table width="100%" border="0">
				<tr>
					<td valign="top" width="100%">
						<a name="inicio" href="#final">Ir para o Final&nbsp;&darr;</a>
					</td>
				</tr>
				<tr>
					<td valign="top" width="100%">
 --%>

		<div id="paipainel"
			style="margin: 0px; padding: 0px; border: 0px; clear: both;">
			<iframe style="visibility: visible; margin: 0px; padding: 0px;"
				name="painel" id="painel" src="" align="right" width="100%"
				onload="resize();" frameborder="0" scrolling="auto"></iframe>
		</div>

		<div style="margin: 0px; padding: 0px; border: 0px; clear: both;">
			<p class="gt-table-action-list">
				<a style="float: right; padding-right: 5pt; padding-top: 5pt;"
					name="final" href="#inicio"><img
					src="/siga/css/famfamfam/icons/arrow_up.png"
					style="margin-right: 5px;">Ir para o Topo</a>
			</p>
		</div>

		<%--							
					</td>
				</tr>
				<tr>
					<td valign="top" width="100%">
						<a name="final" href="#inicio">Ir para o Topo&nbsp;&uarr;</a>
					</td>
				</tr>
			</table>
 --%>
	</div>



	<%--
<c:forEach var="item" items="${doc.form}">
	${item}<br/>
</c:forEach>
--%>


	<%--
<!--  tabela do rodapé -->
<c:choose>
	<c:when test='${param.popup!="true"}'>
		<c:import context="/siga" url="/paginas/rodape.jsp" />
	</c:when>
	<c:otherwise>
		<c:import context="/siga" url="/paginas/rodape_popup.jsp" />
	</c:otherwise>
</c:choose>
--%>

</div>
</div>
<siga:rodape />


<!-- Página Inicial -->
<script>
	var path = '/sigaex/arquivo/exibir.action?arquivo=';
	var htmlAtual = '${arqsNum[0].referenciaHtml}&completo=1';
	var pdfAtual = '${arqsNum[0].referenciaPDF}&completo=1';

	function fixlinks(refHTML, refPDF) {
		//		document.getElementById('htmllink').href = "./" + refHTML;
		document.getElementById('pdflink').href = path + refPDF;
		document.getElementById('pdfsemmarcaslink').href = path + refPDF
				+ "&semmarcas=1";
	}

	function exibir(refHTML, refPDF, semMarcas) {
		var ifr = document.getElementById('painel');
		var ifrp = document.getElementById('paipainel');

		if (ifr.addEventListener)
			ifr.removeEventListener("load", resize, false);
		else if (ifr.attachEvent)
			ifr.detachEvent("onload", resize); // Bug fix line
		if (document.getElementById('radioHTML').checked && refHTML != '') {
			ifr.src = path + refHTML;
			ifrp.style.border = "0px solid black";
			ifrp.style.borderBottom = "0px solid black";
			if (ifr.addEventListener)
				ifr.addEventListener("load", resize, false);
			else if (ifr.attachEvent)
				ifr.attachEvent("onload", resize);
		} else {
			if (document.getElementById('radioPDFSemMarcas').checked)
				ifr.src = path + refPDF + "&semmarcas=1"
			else
				ifr.src = path + refPDF;
			ifrp.style.border = "1px solid black";
			ifr.height = pageHeight() - 300;
		}

		htmlAtual = refHTML;
		pdfAtual = refPDF;

		fixlinks(refHTML, refPDF);
	}

	exibir(window.htmlAtual, window.pdfAtual);
	fixlinks(window.htmlAtual, window.pdfAtual);
	resize();

	function exibirNoIFrame(url) {
		var ifr = document.getElementById('painel');
		var ifrp = document.getElementById('paipainel');

		if (ifr.addEventListener)
			ifr.removeEventListener("load", resize, false);
		else if (ifr.attachEvent)
			ifr.detachEvent("onload", resize); // Bug fix line
		if (document.getElementById('radioHTML').checked) {
			ifrp.style.border = "0px solid black";
			ifrp.style.borderBottom = "0px solid black";
			if (ifr.addEventListener)
				ifr.addEventListener("load", resize, false);
			else if (ifr.attachEvent)
				ifr.attachEvent("onload", resize);
		} else {
			ifr.height = "0";
			ifrp.style.border = "0px solid black";
			ifr.height = pageHeight() - 150;
		}
		ifr.src = url;
	}
</script>
