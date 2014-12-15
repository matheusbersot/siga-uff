<%@ tag body-content="empty"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ attribute name="titulo"%>
<%@ attribute name="menu"%>
<%@ attribute name="idpagina"%>
<%@ attribute name="barra"%>
<%@ attribute name="ambiente"%>
<%@ attribute name="popup"%>
<%@ attribute name="meta"%>
<%@ attribute name="pagina_de_erro"%>
<%@ attribute name="onLoad"%>
<%@ attribute name="desabilitarbusca"%>
<%@ attribute name="desabilitarmenu"%>

<c:if test="${not empty titulo}">
	<c:set var="titulo" scope="request" value="${titulo}" />
</c:if>

<c:if test="${not empty pagina_de_erro}">
	<c:set var="pagina_de_erro" scope="request" value="${pagina_de_erro}" />
</c:if>

<c:if test="${not empty menu}">
	<c:set var="menu" scope="request">${menu}</c:set>
</c:if>

<c:if test="${not empty idpagina}">
	<c:set var="idpage" scope="request">${idpagina}</c:set>
</c:if>

<c:if test="${not empty barra}">
	<c:set var="barranav" scope="request">${barra}</c:set>
</c:if>

<c:set var="ambiente">
	<c:if test="${f:resource('isVersionTest') or f:resource('isBaseTest')}">
		<c:if test="${f:resource('isVersionTest')}">SISTEMA</c:if>
		<c:if
			test="${f:resource('isVersionTest') and f:resource('isBaseTest')}"> E </c:if>
		<c:if test="${f:resource('isBaseTest')}">BASE</c:if> DE TESTES
	</c:if>
</c:set>
<c:if test="${not empty ambiente}">
	<c:set var="env" scope="request">${ambiente}</c:set>
</c:if>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>SIGA - ${titulo_pagina}</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="content-type" CONTENT="text/html; charset=UTF-8">
${meta}

<c:set var="path" scope="request">${pageContext.request.contextPath}</c:set>

<link rel="stylesheet" href="/siga/css/ecoblue/css/reset-fonts.css"
	type="text/css" media="screen, projection">
<link rel="stylesheet" href="/siga/css/ecoblue/css/gt-styles.css"
	type="text/css" media="screen, projection">
<link rel="stylesheet" href="/siga/css/ecoblue/css/custom.css"
	type="text/css" media="screen, projection">

<!-- <link rel="StyleSheet" href="/sigalibs/siga.css" type="text/css"	title="SIGA Estilos" media="screen"> -->

<script src="/siga/sigalibs/ajax.js" language="JavaScript1.1"
	type="text/javascript"></script>
<script src="/siga/sigalibs/static_javascript.js"
	language="JavaScript1.1" type="text/javascript" charset="utf-8"></script>

<!-- <link href="${pageContext.request.contextPath}/sigalibs/menu.css"
	rel="stylesheet" type="text/css" /> -->

<link rel="shortcut icon" href="/siga/sigalibs/siga.ico" />

<script language="JavaScript"
	src="/siga/javascript/jquery/1.6/jquery-1.6.4.min.js"
	type="text/javascript"></script>
<script language="JavaScript"
	src="/siga/javascript/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="/siga/javascript/jquery-ui-1.10.3.custom/css/ui-lightness/jquery-ui-1.10.3.custom.min.css"
	type="text/css" media="screen, projection">
<link rel="stylesheet"
	href="/siga/javascript/jquery-ui-1.10.3.custom/css/ui-lightness/jquery-ui-1.10.3.custom.min.css"
	type="text/css" media="screen, projection">
<!-- <link rel="stylesheet" href="/siga/javascript/jquery-ui-1.10.3.custom/development-bundle/themes/base/jquery.ui.all.css"
	type="text/css" media="screen, projection"> -->


<%-- Desabilitado porque requer o jquery 1.7 ou maior. 	
<script language="JavaScript"
	src="/siga/javascript/autogrow.min.js" type="text/javascript"></script>
--%>
<!--[if gte IE 5.5]><script language="JavaScript" src="/siga/javascript/jquery.ienav.js" type="text/javascript"></script><![endif]-->

<script language="JavaScript" type="text/javascript">
	$(document).ready(function() {
		$('.links li code').hide();
		$('.links li p').click(function() {
			$(this).next().slideToggle('fast');
		});
		$('.once').click(function(e) {
			if (this.beenSubmitted)
				e.preventDefault();
			else
				this.beenSubmitted = true;
		});
		//$('.autogrow').css('overflow', 'hidden').autogrow();
	});
</script>
<c:if test="${not empty titular}">
	${f:getComplementoHead(cadastrante.orgaoUsuario)}
</c:if>
</head>

<body onload="${onLoad}">
	<c:if test="${popup!='true'}">

		<!-- cabe�alho MEC -->
		<div>
			<table
				style="background-image: url(/siga/imagens/egov0.png); background-repeat: no-repeat; width: 100%;"
				id="egov">
				<tbody>
					<tr style="height: 28px">
						<td style="padding: 0; margin: 0"><a
							href="http://portal.mec.gov.br"> <img
								src="/siga/imagens/barra-egovMINC.png"
								alt="Minist&eacute;rio da Educa&ccedil;&atilde;o" border="0">
						</a></td>
					</tr>
					<tr style="height: 24px; vertical-align: top;">
						<td><a href="http://www.uff.br"> <img
								src="/siga/imagens/barra-egovUFF.png" alt="UFF" border="0">
						</a></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="gt-hd clearfix">
			<!-- leaf watermark -->
			<div class="gt-leaf-watermark clearfix">
				<!-- head top -->
				<div class="gt-hd-top clearfix">
					<div class="gt-fixed-wrap clearfix">
						<!-- utility box -->
						<c:if test="${not empty cadastrante}">
							<div class="gt-util-box">
								<div class="gt-util-box-inner"
									style="padding-top: 10px; font-size: 100%;">
									<p style="text-align: right;">
										Ol�, <strong><c:catch>
												<c:out default="Convidado"
													value="${f:maiusculasEMinusculas(cadastrante.nomePessoa)}" />
												<c:choose>
													<c:when test="${not empty cadastrante.lotacao}">
						 - ${cadastrante.lotacao.sigla}</c:when>
												</c:choose>
											</c:catch> </strong> <span class="gt-util-separator">|</span> <a
											href="/siga/logoff.action">sair</a>
									</p>
									<p style="text-align: right; padding-top: 10px;">
										<c:catch>
											<c:choose>
												<c:when
													test="${not empty titular && titular.idPessoa!=cadastrante.idPessoa}">Substituindo: <strong>${f:maiusculasEMinusculas(titular.nomePessoa)}</strong>
													<span class="gt-util-separator">|</span>
													<a href="/siga/substituicao/finalizar.action">finalizar</a>
												</c:when>
												<c:when
													test="${not empty lotaTitular && lotaTitular.idLotacao!=cadastrante.lotacao.idLotacao}">Substituindo: <strong>${f:maiusculasEMinusculas(lotaTitular.nomeLotacao)}</strong>
													<span class="gt-util-separator">|</span>
													<a href="/siga/substituicao/finalizar.action">finalizar</a>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
										</c:catch>
									</p>
								</div>
							</div>
						</c:if>
						<!-- / utility box -->
						<!-- logo -->
						<div class="gt-logo" style="padding: 0;">
							<img style="margin-top: 3px; margin-bottom: -5px;"
								src="/siga/imagens/logo.png">
						</div>

						<c:choose>
							<c:when test="${empty cadastrante}">
								<div class="gt-logo"
									style="padding: 0; position: relative; left: 70%">
									<img
										style="margin-top: 3px; margin-bottom: -5px; height: 55px;"
										src="/siga/imagens/pdi.png">
								</div>
								<div class="gt-version"
									style="position: relative; right: 8%; top: -20px; width: 500px; display: inline-block;">
									Sistema Integrado de Gest&atilde;o Administrativa</div>
								<div class="gt-version"
									style="position: relative; left: 28%; top: -5px; width: 100; display: inline-block;">
									Plano de Desenvolvimento Institucional</div>
							</c:when>
							<c:when test="${not empty cadastrante}">
								<div class="gt-version">Sistema Integrado de Gest&atilde;o
									Administrativa</div>
							</c:when>
						</c:choose>
						<!-- / logo -->
					</div>
				</div>
				<!-- /head top -->
				<!-- navbar -->
				<c:if test="${desabilitarmenu != 'sim'}">
					<div class="gt-navbar clearfix">
						<div class="gt-fixed-wrap clearfix">
							<!-- navigation -->
							<div class="gt-nav">
								<ul id="navmenu-h">
									<c:import url="/sigalibs/menuprincipal.jsp" />
								</ul>
							</div>
							<!-- / navigation -->
							<!-- search -->
							<c:if test="${desabilitarbusca != 'sim'}">
								<div class="gt-search">
									<div class="gt-search-inner" onclick="">
										<siga:selecao propriedade="buscar" tipo="generico"
											tema="simple" ocultardescricao="sim" buscar="nao"
											siglaInicial="Buscar" modulo="siga" />
										<script type="text/javascript">
											var lis = document
													.getElementsByTagName('li');

											for (var i = 0, li; li = lis[i]; i++) {
												var link = li
														.getElementsByTagName('a')[0];

												if (link) {
													link.onfocus = function() {
														var ul = this.parentNode
																.getElementsByTagName('ul')[0];
														if (ul) {
															ul.style.display = 'block';
														}
													}
													var ul = link.parentNode
															.getElementsByTagName('ul')[0];
													if (ul) {
														var ullinks = ul
																.getElementsByTagName('a');
														var ullinksqty = ullinks.length;
														var lastItem = ullinks[ullinksqty - 1];
														if (lastItem) {
															lastItem.onblur = function() {
																this.parentNode.parentNode.style.display = 'none';
																if (this.id == "relclassificados") {
																	var rel = document
																			.getElementById("relatorios");
																	rel.style.display = 'none';
																}
															}
															lastItem.parentNode.onblur = function() {
																this.parentNode.style.display = '';
															}
														}
													}
												}
											}

											var fld = document
													.getElementById("buscar_genericoSel_sigla");
											fld.setAttribute("class",
													"gt-search-text");
											fld.className = "gt-search-text";
											fld.onfocus = function() {
												if (this.value == 'Buscar') {
													this.value = '';
												}
											};
											fld.onblur = function() {
												if (this.value == '') {
													this.value = 'Buscar';
													return;
												}
												if (this.value != 'Buscar')
													ajax_buscar_generico();
											};
											fld.onkeypress = function(event) {
												var fid = document
														.getElementById("buscar_genericoSel_id");

												event = (event) ? event
														: window.event
												var keyCode = (event.which) ? event.which
														: event.keyCode;
												if (keyCode == 13) {
													if (fid.value == null
															|| fid.value == "") {
														fld.onblur();
													} else {
														window.alert("1");
														window.location.href = '${request.scheme}://${request.serverName}:${request.serverPort}/sigaex/expediente/doc/exibir.action?sigla='
																+ fld.value;
													}
													return false;
												} else {
													fid.value = '';
													return true;
												}
											};

											self.resposta_ajax_buscar_generico = function(
													response, d1, d2, d3) {
												var sigla = document
														.getElementsByName('buscar_genericoSel.sigla')[0].value;
												var data = response.split(';');
												if (data[0] == '1') {
													retorna_buscar_generico(
															data[1], data[2],
															data[3]);
													if (data[1] != null
															&& data[1] != "") {
														window.location.href = data[3];
													}
													return

													

																										

													

												}
												retorna_buscar_generico('', '',
														'');

												return;

											}
										</script>
									</div>
							</c:if>
						</div>
					</div>
				</c:if>
			</div>
			<!-- /navbar -->
		</div>
		<!-- /leaf watermark -->
		</div>

		<div id="quadroAviso"
			style="position: absolute; font-weight: bold; padding: 4px; color: white; visibility: hidden">-</div>

	</c:if>

	<div id="carregando"
		style="position: absolute; top: 0px; right: 0px; background-color: red; font-weight: bold; padding: 4px; color: white; display: none">Carregando...</div>