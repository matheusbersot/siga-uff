<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb" trimDirectiveWhitespaces="true"
	import="java.io.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>

<siga:pagina titulo="Documento">
	<c:if test="${not doc.eletronico}">
		<script type="text/javascript">
			$("html").addClass("fisico");
		</script>
	</c:if>

	<div class="gt-bd" style="padding-bottom: 0px;">
		<div class="gt-content">

			<h2>Confirme os dados do documento abaixo:</h2>

			<div class="gt-content-box" style="padding: 10px;">

				<table class="message" width="100%">
					<tr class="header">
						<td width="50%"><b>Documento
								${doc.exTipoDocumento.descricao}:</b> ${doc.codigo}</td>
						<td><b>Data:</b> ${doc.dtDocDDMMYY}</td>
					</tr>
					<tr class="header">
						<td><b>De:</b> ${doc.subscritorString}</td>
						<td><b>Classificação:</b>
							${doc.exClassificacao.descricaoCompleta}</td>
					</tr>
					<tr class="header">
						<td><b>Para:</b> ${doc.destinatarioString}</td>
						<td><b>Descrição:</b> ${doc.descrDocumento}</td>
					</tr>
					<c:if test="${doc.conteudo != ''}">
						<tr>
							<td colspan="2">
								<div id="conteudo" style="padding-top: 10px;">
									<tags:fixdocumenthtml>${doc.conteudoBlobHtmlStringComReferencias}</tags:fixdocumenthtml>
								</div>
							</td>
						</tr>
					</c:if>
				</table>

			</div>

			<c:set var="acao" value="assinar_gravar" />
			<div class="gt-form-row gt-width-100" style="padding-top: 10px;">
				<div id="dados-assinatura" style="visible: hidden">
					<ww:hidden id="pdfchk_0" name="pdfchk_${doc.idDoc}"
						value="${sigla}" />
					<ww:hidden id="urlchk_0" name="urlchk_${doc.idDoc}"
						value="/arquivo/exibir.action?arquivo=${doc.codigoCompacto}.pdf" />

					<c:set var="jspServer"
						value="${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/expediente/mov/assinar_gravar.action" />
					<c:set var="nextURL"
						value="${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/expediente/doc/exibir.action?sigla=${sigla}" />
					<c:set var="urlPath" value="${request.contextPath}" />

					<ww:hidden id="jspserver" name="jspserver" value="${jspServer}" />
					<ww:hidden id="nexturl" name="nextUrl" value="${nextURL}" />
					<ww:hidden id="urlpath" name="urlpath" value="${urlPath}" />
					<c:set var="urlBase"
						value="${request.scheme}://${request.serverName}:${request.serverPort}" />
					<ww:hidden id="urlbase" name="urlbase" value="${urlBase}" />

					<c:set var="botao" value="" />
					<c:set var="lote" value="false" />
				</div>

				<c:if
					test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;VBS:VBScript e CAPICOM')}">

					<c:if test="${f:requisicaoVeioDoLinuxEFirefox(request)}">
						<c:import url="/paginas/expediente/inc_assina_js_firefox.jsp" />
						<div id="applet-div" style="display: block;">
							<applet id="assinador" width="400" height="40" align="top"
								code="br.jus.tjrr.siga.assinador.SignerApplet"
								archive="../../appletAssinador/siga-assinador.jar">
								<param name="isCopyBtn1" value="false" />
								<param name="labelBtn1" value="Assinar Documento" />
								<param name="backgroundColor_R" value="226" />
								<param name="backgroundColor_G" value="234" />
								<param name="backgroundColor_B" value="238" />
								<param name="permissions" value="all-permissions" />
							</applet>
						</div>
					</c:if>

					<c:import url="/paginas/expediente/inc_assina_js.jsp" />
					<div id="capicom-div" style="display: none;">
						<a id="bot-assinar" href="#"
							onclick="javascript: AssinarDocumentos('false', this);"
							class="gt-btn-alternate-large gt-btn-left">Assinar Documento</a>
					</div>


					<p id="ie-firefox-missing" style="display: none;">A assinatura
						digital só poderá ser realizada no Windows através do navegador
						Internet Explorer e no Linux através do navegador Mozilla Firefox.
					</p>


					<p id="capicom-missing" style="display: none;">
						Não foi possível localizar o componente <i>CAPICOM.DLL</i>. Para
						realizar assinaturas digitais utilizando o método padrão do
						SIGA-DOC, será necessário instalar este componente. O <i>download</i>
						pode ser realizado clicando <a
							href="https://code.google.com/p/projeto-siga/downloads/detail?name=Capicom.zip&can=2&q=#makechanges">aqui</a>.
						Será necessário expandir o <i>ZIP</i> e depois executar o arquivo
						de instalação.
					</p>

					<script type="text/javascript">
						if (window.navigator.userAgent.indexOf("MSIE ") > 0	|| window.navigator.userAgent.indexOf(" rv:11.0") > 0) {
							TestarAssinaturaDigital();
							document.getElementById("capicom-div").style.display = "block";
						} else if (window.navigator.userAgent.indexOf("Firefox") == -1 || window.navigator.platform.indexOf("Linux") == -1){
							document.getElementById("ie-firefox-missing").style.display = "block";
						}
					</script>

				</c:if>

				<c:if
					test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;EXT:Extensão')}">
					${f:obterExtensaoAssinador(lotaTitular.orgaoUsuario,request.scheme,request.serverName,request.serverPort,urlPath,jspServer,nextURL,botao,lote)}	
				</c:if>
			</div>
		</div>
	</div>
</siga:pagina>