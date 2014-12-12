<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>


<ww:if test="${(not empty mobilVO.movs)}">
    <h2>Anexos Assinados</h2> 	
	<div class="gt-content-box gt-for-table">
	    <ww:form name="frm_anexo" id="frm_anexo" cssClass="form"
		         theme="simple">
			<ww:hidden name="popup" value="true" />
			<ww:hidden name="copia" id="copia" value="false" />			
			<table class="gt-table mov">
			    <thead>
				    <tr>
							<td></td>
							<th align="center" rowspan="2">&nbsp;&nbsp;&nbsp;Data</th>
							<th colspan="2" align="center">Cadastrante</th>
							<th colspan="2" align="center">Atendente</th>
							<th rowspan="2">Descrição</th>
						</tr>
						<tr>
						    <ww:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;EXT:Extensão')}">
								<td align="center"><input type="checkbox" name="checkall"
									onclick="checkUncheckAll(this)" /></td>
							</ww:if>
							<ww:else><td></td></ww:else>	
							<th align="left">Lotação</th>
							<th align="left">Pessoa</th>
							<th align="left">Lotação</th>
							<th align="left">Pessoa</th>
						</tr>
					<thead>
     				<c:set var="i" value="${0}" />
					<c:forEach var="mov" items="${mobilVO.movs}">
						<c:if test="${(not mov.cancelada)}">
							<tr class="${mov.classe} ${mov.disabled}">
								<c:set var="dt" value="${mov.dtRegMovDDMMYY}" />
								<ww:if test="${dt == dtUlt}">
									<c:set var="dt" value="" />
								</ww:if>
								<ww:else>
									<c:set var="dtUlt" value="${dt}" />
								</ww:else>
								<ww:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;EXT:Extensão')}">
									<c:set var="x" scope="request">chk_${mov.mov.idMov}</c:set>
									<c:remove var="x_checked" scope="request" />
									<c:if test="${param[x] == 'true'}">
										<c:set var="x_checked" scope="request">checked</c:set>
									</c:if>
									<td align="center"><input type="checkbox" name="${x}"
										value="true" ${x_checked} /></td>
								</ww:if>
								<ww:else><td></td></ww:else>		
								<td align="center">${dt}</td>
								<td align="left"><siga:selecionado
										sigla="${mov.parte.lotaCadastrante.sigla}"
										descricao="${mov.parte.lotaCadastrante.descricaoAmpliada}" />
								</td>
								<td align="left"><siga:selecionado
										sigla="${mov.parte.cadastrante.nomeAbreviado}"
										descricao="${mov.parte.cadastrante.descricao} - ${mov.parte.cadastrante.sigla}" />
								</td>
								<td align="left"><siga:selecionado
										sigla="${mov.parte.lotaResp.sigla}"
										descricao="${mov.parte.lotaResp.descricaoAmpliada}" /></td>
								<td align="left"><siga:selecionado
										sigla="${mov.parte.resp.nomeAbreviado}"
										descricao="${mov.parte.resp.descricao} - ${mov.parte.resp.sigla}" />
								</td>
								<td>${mov.descricao}<c:if test='${mov.idTpMov != 2}'> ${mov.complemento}</c:if>
									<c:set var="assinadopor" value="${true}" /> <siga:links
										inline="${true}"
										separator="${not empty mov.descricao and mov.descricao != null}">
									<c:forEach var="acao" items="${mov.acoes}">
										<c:choose>
											<c:when test='${mov.idTpMov == 32}'>
												<ww:url id="url" value="${acao.nameSpace}/${acao.acao}">
													<c:forEach var="p" items="${acao.params}">
														<ww:param name="${p.key}">${p.value}</ww:param>
													</c:forEach>
												</ww:url>
											</c:when>
											<c:otherwise>
												<ww:url id="url" action="${acao.acao}"
													namespace="${acao.nameSpace}">
													<c:forEach var="p" items="${acao.params}">
														<ww:param name="${p.key}">${p.value}</ww:param>
													</c:forEach>
												</ww:url>
											</c:otherwise>
										</c:choose>
										<siga:link title="${acao.nomeNbsp}" pre="${acao.pre}"
											pos="${acao.pos}" url="${url}" test="${true}"
											popup="${acao.popup}" confirm="${acao.msgConfirmacao}"
											ajax="${acao.ajax}" idAjax="${mov.idMov}" />
										<c:if test='${assinadopor and mov.idTpMov == 2}'> ${mov.complemento}
											<c:set var="assinadopor" value="${false}" />
										</c:if>
									</c:forEach>
									<c:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;EXT:Extensão')}">
										<ww:hidden name="pdf${x}" value="${mov.mov.referencia}" />
										<ww:hidden name="url${x}" value="${mov.mov.nmPdf}" />
									</c:if>	
								</siga:links></td>
							</tr>
						</c:if>
     				</c:forEach>
			</table>	
		</ww:form>
    </div>
	<div id="dados-assinatura" style="visible: hidden">
    	<c:set var="jspServer"
		       value="${request.scheme}://${request.serverName}:${request.localPort}/${request.contextPath}/expediente/mov/assinar_mov_gravar.action" />
		<c:set var="nextURL"
			   value="${request.scheme}://${request.serverName}:${request.localPort}/${request.contextPath}/expediente/doc/atualizar_marcas.action?sigla=${mobilVO.sigla}" />
	    <c:set var="urlPath" value="/${request.contextPath}" />
	    
   		<ww:hidden id="jspserver" name="jspserver" value="${jspServer}" />
		<ww:hidden id="nexturl" name="nextUrl" value="${nextURL}" />
		<ww:hidden id="urlpath" name="urlpath" value="${urlPath}" />
		<c:set var="urlBase"
			value="${request.scheme}://${request.serverName}:${request.serverPort}" />
		<ww:hidden id="urlbase" name="urlbase" value="${urlBase}" />
	    						
	    <c:set var="botao" value="ambos" />
	    <c:set var="lote" value="true" />			
	</div>    					
	<c:if 
		test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;VBS:VBScript e CAPICOM')}">
			<div id="capicom-div">
				<a id="bot-conferir" href="#" onclick="javascript: AssinarDocumentos('true', this);" class="gt-btn-alternate-large gt-btn-left">Conferir Cópia em Lote</a> 
				<a id="bot-assinar" href="#" onclick="javascript: AssinarDocumentos('false', this);" class="gt-btn-alternate-large gt-btn-left">Assinar em Lote</a>
			</div> 
		<p id="ie-missing" style="display: none;">A assinatura digital utilizando padrão do SIGA-DOC só poderá ser realizada no Internet Explorer. No navegador atual, apenas a assinatura com <i>Applet Java</i> é permitida.</p>
		<p id="capicom-missing" style="display: none;">Não foi possível localizar o componente <i>CAPICOM.DLL</i>. Para realizar assinaturas digitais utilizando o método padrão do SIGA-DOC, será necessário instalar este componente. O <i>download</i> pode ser realizado clicando <a href="https://code.google.com/p/projeto-siga/downloads/detail?name=Capicom.zip&can=2&q=#makechanges">aqui</a>. Será necessário expandir o <i>ZIP</i> e depois executar o arquivo de instalação.</p>
				<script type="text/javascript">
					 if (window.navigator.userAgent.indexOf("MSIE ") > 0 || window.navigator.userAgent.indexOf(" rv:11.0") > 0) {
						 document.getElementById("capicom-div").style.display = "block";
						 document.getElementById("ie-missing").style.display = "none";
					} else {
						 document.getElementById("capicom-div").style.display = "none";
						 document.getElementById("ie-missing").style.display = "block";
					}
				 </script>
	</c:if>
    
	<c:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gestão Administrativa;DOC:Módulo de Documentos;ASS:Assinatura digital;EXT:Extensão')}">
	    ${f:obterExtensaoAssinador(lotaTitular.orgaoUsuario,request.scheme,request.serverName,request.localPort,urlPath,jspServer,nextURL,botao,lote)}						
	</c:if>
</ww:if>
<ww:else>
		<b>Não há anexos assinados</b>
</ww:else>			


