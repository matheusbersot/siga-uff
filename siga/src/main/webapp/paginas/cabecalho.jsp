<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<c:set var="ambiente">
	<c:if test="${f:resource('isVersionTest') || f:resource('isBaseTest')}">
		<c:if test="${f:resource('isVersionTest')}">SISTEMA</c:if>
		<c:if
			test="${f:resource('isVersionTest') && f:resource('isBaseTest')}"> / </c:if>
		<c:if test="${f:resource('isBaseTest')}">BASE</c:if> DE TESTES
</c:if>
</c:set>

<html>
<head>
<title>SIGA - ${titulo_pagina}</title>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="content-type" CONTENT="text/html; charset=UTF-8">
${cabecalho_meta}
<c:import url="/paginas/estilos.jsp" />
<link rel="shortcut icon" href="imagens/siga.ico" />
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<siga:cabecalho titulo="${titulo_pagina}" menu="menu" barra="nao" ambiente="${ambiente}" />
<TABLE WIDTH="100%" height="100%" BORDER=0 CELLPADDING=0 CELLSPACING=0>
	<TR>
		<c:if test="${titulo_pagina == 'Página Inicial'}">
			<TR>
				<TD width="186" height="88" valign="top"><IMG
					SRC="<c:url value='/imagens/companyslogan.gif'/>" WIDTH=186
					HEIGHT=88 ALT=""></TD>
				<TD rowspan="2" valign="top" style="padding: 0">
				<TABLE width="100%" BORDER=0 CELLPADDING=0 CELLSPACING=0>
					<TR>
						<TD width="100%" height="88" valign="top"
							background="<c:url value='/imagens/middlebg.gif'/>"
							style="padding: 0">
						<table width="100%" height="100%" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td style="padding-left: 12; padding-top: 11"></td>
								<td valign="center" class="newsarticle"><c:catch>
									<c:set var="siglaOrgaoUsu"
										value="${titular.orgaoUsuario.siglaOrgaoUsu}" />
								</c:catch> <c:choose>
									<c:when test="${siglaOrgaoUsu == 'RJ'}">
										<p><strong>Missão:</strong> Assegurar o acesso à Justiça
										Federal, solucionando conflitos e garantindo direitos, por
										meio da entrega da prestação jurisdicional à sociedade como um
										todo, de forma eficaz, com celeridade e comprometimento,
										obedecendo aos princípios legais e considerando sua
										responsabilidade social.</p>
									</c:when>
									<c:when test="${siglaOrgaoUsu == 'T2'}">
										<p><strong>Srs. Usuários:</strong> lembramos que, ao serem
										recadastrados no SIGA, os expedientes recebem um novo número
										de registro, que deve ser anotado e inserido no antigo
										cadastro do expediente no SCE. Para isto deve ser utilizada a
										opção ASSOCIAÇÃO DE EXPEDIENTE SIGA x SCE no menu do SCE
										(W_Emul).</p>
									</c:when>
								</c:choose></td>
							</tr>
						</table>
						</TD>
						<TD height="168" ROWSPAN=2 valign="top"><IMG
							SRC="<c:url value='/imagens/mainpic.gif'/>" WIDTH=245 HEIGHT=168
							ALT=""></TD>
					</TR>
					<TR>
						<TD width="344" height="80" valign="top"
							style="padding-left: 12; padding-top: 7">
						<h1>Página Inicial</h1>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
			<TR>
				<TD width="114" rowspan="2" valign="top"
					style="border-right: 1px dotted; padding-left: 19"><br>
				<table width="136" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td
							style="border-top: 1px dotted #CCCCCC; padding-top: 4; padding-bottom: 14"><strong>
						<a href="http://intranet/" class="sidetable">Intranet</a></strong></td>
					</tr>
					<tr>
						<td
							style="border-top: 1px dotted #CCCCCC; padding-top: 4; padding-bottom: 14"><strong><a
							href="http://www.trf2.jus.br/" class="sidetable">Site do TRF
						2ª Região</a></strong></td>
					</tr>
					<tr>
						<td
							style="border-top: 1px dotted #CCCCCC; padding-top: 4; padding-bottom: 14"><strong><a
							href="http://trfnet.jf.trf2.jus.br/intranet/index.html"
							class="sidetable">Intranet do TRF 2ª Região</a></strong></td>
					</tr>
					<tr>
						<td
							style="border-top: 1px dotted #CCCCCC; padding-top: 4; padding-bottom: 14"><strong>
						<a href="http://www.ccjf.trf2.jus.br/default.htm"
							class="sidetable">Centro Cultural</a></strong></td>
					</tr>
					<tr>
						<td
							style="border-top: 1px dotted #CCCCCC; padding-top: 4; padding-bottom: 14"><strong>
						<a href="http://houaiss/" class="sidetable">Dicionário</a></strong></td>
					</tr>
				</table>
				<br>
				</TD>
			</TR>
		</c:if>
	<TR>
		<c:if test="${titulo_pagina == 'Página Inicial'}">
			<TD colspan="3" valign="top"
				style="padding-left: 12; padding-top: 7; padding-right: 12; padding =bottom: 7;">
		</c:if>
		<c:if test="${titulo_pagina != 'Página Inicial'}">
			<TD colspan="4" valign="top"
				style="padding-left: 12; padding-top: 7; padding-right: 12; padding =bottom: 7;">
		</c:if>
		<%--
			--%>
		<c:if test="${title=='false'}">
	</TR>
</TABLE>
</body>
</html>
</c:if>
