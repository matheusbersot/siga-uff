<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/libstag" prefix="libs"%>

<%@page import="br.gov.jfrj.siga.ex.ExMovimentacao"%>
<%@page import="br.gov.jfrj.siga.ex.ExMobil"%>
<siga:cabecalho titulo="Documento" popup="${param.popup}" />

<script src="/siga/javascript/viz.js" language="JavaScript1.1" type="text/javascript"></script>
<!-- <script src="http://mdaines.github.io/viz.js/viz.js"></script> -->

<c:if test="${not docVO.digital}">
	<script type="text/javascript">
		$("html").addClass("fisico");
		$("#outputTramitacao").addClass("fisico");
	</script>
</c:if>
<script type="text/javascript">
	var css = "<style>a:link {text-decoration: none}</style>";
	$(css).appendTo("head");

	function escapeAcentos(s){
		//Edson: o replace abaixo é necessário porque o viz.js não monta o gráfico corretamente se
		//houver caracteres com acento...
		return s.replace(/[ãâáàÃÁÀÂêéÊÉôõóÔÕÓúÚçÇ]/gim, function(i){
			return '&#'+i.charCodeAt(0)+';';
			});
	}
</script>

<div class="gt-bd" style="padding-bottom: 0px;" id="page">
	<div class="gt-content">

		<c:if test="${not empty param.msg}">
			<p align="center">
				<b>${param.msg}</b>
			</p>
		</c:if>

		<ww:form name="frm" action="exibir" namespace="/expediente/doc"
			theme="simple" method="POST">
			<ww:token />
		</ww:form>

		<h2>
			<c:if test="${empty ocultarCodigo}">${docVO.sigla}</c:if>
		</h2>
		<c:set var="primeiroMobil" value="${true}" />
		<c:forEach var="m" items="${docVO.mobs}" varStatus="loop">
			<ww:if
				test="%{#attr.m.mob.geral or true or (((mob.geral or (mob.id == #attr.m.mob.id)) and ((#attr.m.mob.getUltimaMovimentacaoNaoCancelada() != null))))}">
				<h3 style="margin-bottom: 0px;">
					<ww:property
						value="%{#attr.m.getDescricaoCompletaEMarcadoresEmHtml(cadastrante,lotaTitular)}"
						escape="false" />
					<c:if test="${docVO.digital and not empty m.tamanhoDeArquivo}"> - ${m.tamanhoDeArquivo}</c:if>
				</h3>

				<c:set var="ocultarCodigo" value="${true}" />

				<!-- Links para as ações de cada mobil -->
				<c:if test='${param.popup!="true"}'>
					<c:set var="acoes" value="${m.acoesOrdenadasPorNome}" />
					<%-- 			<ww:if test="%{#attr.m.mob.geral}"><c:set var="acoes" value="${docVO.acoesOrdenadasPorNome}"/></ww:if>--%>
					<siga:links>
						<c:forEach var="acao" items="${acoes}">
							<ww:url id="url" action="${acao.acao}"
								namespace="${acao.nameSpace}">
								<c:forEach var="p" items="${acao.params}">
									<ww:param name="${p.key}">${p.value}</ww:param>
								</c:forEach>
							</ww:url>
							<siga:link icon="${acao.icone}" title="${acao.nomeNbsp}"
								pre="${acao.pre}" pos="${acao.pos}" url="${url}" test="${true}"
								popup="${acao.popup}" confirm="${acao.msgConfirmacao}" classe="${acao.classe}" estilo="line-height: 160% !important"/>
						</c:forEach>
					</siga:links>
				</c:if>
				
				
				<div id="formMov" style="display: none"></div>
				<script>
						
					function meuTeste(result){
						jFormMov = $('#formMov');
						jFormMov.html("");
						jFormMov.append($(result).find("script"));
						jFormMov.append($(result).find(".gt-content-box"));
						jFormMov.show('blind', {}, 500 );
						$("input[value='Cancela']").removeAttr('onclick');
						$("input[value='Cancela']").click(function(){jFormMov.hide('blind', {}, 500 );});
						jFormMov.find("form").submit(function(e)
								{
								    var postData = $(this).serializeArray();
								    var formURL = $(this).attr("action");
								    $.ajax(
								    {
								        url : formURL,
								        type: "POST",
								        data : postData,
								        success:function(data, textStatus, jqXHR) 
								        {
									       if (data.indexOf("ompletar") > 0){
									    	   $("<div style='margin-top: 15px; color: #365b6d; font-weight: bold; font-size: 108%'>" 
											    	   + data.substring(data.indexOf('<h3>')+4, data.indexOf('</h3>')) + "</div>")
											    	   .dialog({
												    	   modal: true, 
												    	   resizable: false
														});
										   }
								        },
								        error: function(jqXHR, textStatus, errorThrown) 
								        {
								            alert(errorThrown);  
								        }
								    });
								    e.preventDefault(); //STOP default action
								    //e.unbind(); //unbind. to stop multiple form submit.
								});
					}
				</script>

	<c:set var="dtUlt" value="" />

	<!-- Verifica se haverá alguma movimentação para ser exibida -->
	<c:set var="temmov" value="${false}" />
	<c:forEach var="mov" items="${m.movs}">
		<c:if
			test="${ (mov.idTpMov != 14 and
							          not mov.cancelada)}">
			<c:set var="temmov" value="${true}" />
		</c:if>
	</c:forEach>
	
<div class="gt-bd gt-cols clearfix"
	style="padding-top: 0px; margin-top: 25px;padding-left: 0px;">
	<div class="gt-content">

				<!-- Somente quando o workflow está ativado -->
				<c:if test="${f:resource('isWorkflowEnabled')}">
				<!-- Se for um processo administrativo, colocar a caixa do wf geral no último volume -->
				<ww:if test="${ (primeiroMobil) and (docVO.tipoFormaDocumento == 'processo_administrativo')}">
						<div id="${docVO.sigla}" depende=";wf;" />
						<!--ajax:${doc.codigo}-${i}-->
						<!--/ajax:${doc.codigo}-${i}-->
						</div>
					<c:set var="primeiroMobil" value="${false}" />
				</ww:if>
				
				<ww:if test="%{(not #attr.m.mob.geral) or (docVO.tipoFormaDocumento != 'processo_administrativo')}">
						<div id="${m.sigla}" depende=";wf;" />
						<!--ajax:${doc.codigo}-${i}-->
						<!--/ajax:${doc.codigo}-${i}-->
						</div>
				</ww:if>
				
				</c:if>
	
		<!-- Dados do documento -->
		<div class="gt-content-box" style="padding: 10px;">
			<table style="width: 100%">
				<tr>
					<td><c:if test="${docVO.conteudoBlobHtmlString != null}">
							<tags:fixdocumenthtml>
			${docVO.conteudoBlobHtmlString}
		</tags:fixdocumenthtml>
						</c:if>
					</td>
				</tr>
			</table>
		</div>
		
	<!-- Tabela de movimentações -->
	<c:if test="${temmov}">
		<div class="gt-content-box gt-for-table" style="margin-bottom: 25px;margin-top: 10px;">
			<script type="text/javascript">
					var css = "<style>TABLE.mov TR.despacho { background-color: rgb(240, 255, 240);}";
					css += "TABLE.mov TR.juntada,TR.desentranhamento { background-color: rgb(229, 240, 255);}";
					css += "TABLE.mov TR.anotacao { background-color: rgb(255, 255, 255);}";
					css += "TABLE.mov TR.anexacao { background-color: rgb(255, 255, 215);}";
					css += "TABLE.mov TR.encerramento_volume { background-color: rgb(255, 218, 218);}</style>";
					$(css).appendTo("head");
			</script>
			<table class="gt-table mov">
				<thead>
					<tr>
						<th rowspan="2" align="center" style="padding: 5px 5px;">Data</th>
						<th rowspan="2" style="padding: 5px 5px;">Lotação</th>
						<th rowspan="2" style="padding: 5px 5px;">Evento</th>
						<th rowspan="2" style="padding: 5px 5px;">Descrição</th>
					</tr>
				</thead>
				<c:set var="evenorodd" value="odd" />
				<c:forEach var="mov" items="${m.movs}">
					<c:if
						test="${ (mov.idTpMov != 14 and
							          not mov.cancelada)}">
						<tr class="${mov.classe} ${mov.disabled}">
								<c:set var="dt" value="${mov.dtRegMovDDMMYY}" />
							<ww:if test="${dt == dtUlt}">
								<c:set var="dt" value="" />
							</ww:if>
							<ww:else>
								<c:set var="dtUlt" value="${dt}" />
							</ww:else>
							
							<c:set var="lota" value="${mov.mov.lotaCadastrante.sigla}"/>
							<ww:if test="${lota == lotaUlt}">
								<c:set var="lota" value="" />
							</ww:if>
							<ww:else>
								<c:set var="lotaUlt" value="${lota}" />
							</ww:else>

							<td align="center" style="padding: 5px 5px;">${dt}</td>
							<td style="padding: 5px 5px;">${lota}</td>
							<td style="padding: 5px 5px;">${mov.mov.exTipoMovimentacao.sigla}</td>
							<td style="padding: 5px 5px; word-break: break-all;">${mov.descricao} <c:if test='${mov.idTpMov != 2}'> ${mov.complemento} </c:if>
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
											ajax="${acao.ajax}" idAjax="${mov.idMov}" classe="${acao.classe}" />
										<c:if test='${assinadopor and mov.idTpMov == 2}'> ${mov.complemento}
									<c:set var="assinadopor" value="${false}" />
										</c:if>
									</c:forEach>
								</siga:links></td>
						</tr>
						<c:choose>
							<c:when test='${evenorodd == "even"}'>
								<c:set var="evenorodd" value="odd" />
							</c:when>
							<c:otherwise>
								<c:set var="evenorodd" value="even" />
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</c:if>		
	</div>

	<div class="gt-sidebar">
	
		<c:if test="${m.pendencias}">
		<div class="gt-sidebar-content" id="pendencias">
			<h3>Pendências</h3>
			<c:if test="${not empty m.pendenciasDeAnexacao}">
			<p style="margin-bottom: 3px;">
				<b style="color: rgb(195, 0, 0)">Anexos Pendentes:</b> 
			</p>
			<ul>
			<c:forEach var="anexoPendente" items="${m.pendenciasDeAnexacao}">
				<li>
					<ww:url id="url" action="anexar" namespace="/expediente/mov" >
						<ww:param name="sigla">${m.sigla}</ww:param>
					</ww:url>
					<ww:a href="%{url}" title="${anexoPendente.descricao}" cssStyle="text-decoration: none">
						${anexoPendente.descricao}
					</ww:a>
				</li>
			</c:forEach>
			</ul>
			</c:if>
			<c:if test="${not empty m.anexosNaoAssinados}">
			<p style="margin-bottom: 3px;">
				<b style="color: rgb(195, 0, 0)">Anexos não assinados:</b> 
			</p>
			<ul>
			<c:forEach var="naoAssinado" items="${m.anexosNaoAssinados}">
				<li>
					<ww:url id="url" action="exibir" namespace="/expediente/mov" >
						<ww:param name="id">${naoAssinado.idMov}</ww:param>
						<ww:param name="popup">true</ww:param>
					</ww:url>
					<ww:a href="javascript:popitup('%{url}')" title="${naoAssinado.descricao}" cssStyle="text-decoration: none">
						${naoAssinado.mov.nmArqMov}
					</ww:a>
				</li>
			</c:forEach>
			</ul>
			</c:if>
			<c:if test="${not empty m.despachosNaoAssinados}">
			<p style="margin-bottom: 3px;margin-top: 8px;">
				<b style="color: rgb(195, 0, 0)">Despachos não assinados:</b>
			</p>
			<ul>
			<c:forEach var="naoAssinado" items="${m.despachosNaoAssinados}">
				<li>
					<ww:url id="url" action="exibir" namespace="/expediente/mov" >
						<ww:param name="id">${naoAssinado.idMov}</ww:param>
						<ww:param name="popup">true</ww:param>
					</ww:url>
					<ww:a href="javascript:popitup('%{url}')" title="${naoAssinado.descricao}" cssStyle="text-decoration: none">
						${naoAssinado.descricao}
					</ww:a>
				</li>
			</c:forEach>
			</ul>
			</c:if>
			<c:if test="${not empty m.expedientesFilhosNaoJuntados}">
			<p style="margin-bottom: 3px; margin-top: 8px;">
				<b style="color: rgb(195, 0, 0)">Expedientes não juntados:</b> 
			</p>
			<ul>
			<c:forEach var="naoJuntado" items="${m.expedientesFilhosNaoJuntados}">
				<li>
					<ww:url id="url" action="exibir" namespace="/expediente/doc" >
						<ww:param name="sigla">${naoJuntado.sigla}</ww:param>
					</ww:url>
					<ww:a href="%{url}" title="${naoJuntado.descrDocumento}" cssStyle="text-decoration: none">
						${naoJuntado.sigla}
					</ww:a>
				</li>
			</c:forEach>
			</ul>
			</c:if>
		</div>
		</c:if>
		
		<c:if test="${not empty docVO.documentosPublicados or not empty docVO.boletim}">
		<div class="gt-sidebar-content" style="padding-top: 10px">
		<h3>Boletim Interno</h3>
		<c:if test="${not empty docVO.documentosPublicados}">
				<p class="apensados" style="margin-top: 0pt;">
					<b>Documentos Publicados: </b>
					<c:forEach var="documentoPublicado" items="${docVO.documentosPublicados}">
						<ww:url id="url" action="exibir" namespace="/expediente/doc">
							<ww:param name="sigla">${documentoPublicado.sigla}</ww:param>
						</ww:url>
						<ww:a href="%{url}" title="${documentoPublicado.sigla}">
							${documentoPublicado.sigla}
						</ww:a>&nbsp;
					</c:forEach>
				</p>
		</c:if>	
			
		<c:if test="${not empty docVO.boletim}">
				<p class="apensados" style="margin-top: 0pt;">
					<b>Publicado no Boletim: </b>
					<ww:url id="url" action="exibir" namespace="/expediente/doc">
						<ww:param name="sigla">${docVO.boletim.sigla}</ww:param>
					</ww:url>
					<ww:a href="%{url}" title="${docVO.boletim.sigla}">
						${docVO.boletim.sigla}
					</ww:a>
				</p>
		</c:if>	
		</div>
		</c:if>
	
		<c:if test="${not empty docVO.outrosMobsLabel}">
			<jsp:useBean id="now" class="java.util.Date"/>
			<div class="gt-sidebar-content">
				<h3>${docVO.outrosMobsLabel}</h3>
					<ul style="list-style-type: none; margin: 0; padding: 0;">
					<c:forEach var="entry" items="${docVO.marcasPorMobil}">
						<c:set var="outroMob" value="${entry.key}"/>
						<ww:url id="url" action="exibir" namespace="/expediente/doc">
							<ww:param name="sigla">${outroMob.sigla}</ww:param>
						</ww:url>
						<li>
						<c:choose>
							<c:when test="${outroMob.numSequencia == m.mob.numSequencia}">
								<i><b>${outroMob.terminacaoSigla}</b></i>
							</c:when>
							<c:otherwise>
								<ww:a href="%{url}" title="${outroMob.doc.descrDocumento}" cssStyle="text-decoration: none">
								${outroMob.terminacaoSigla}
								</ww:a>
							</c:otherwise>
						</c:choose>
						&nbsp;-&nbsp;
						<c:forEach var="marca" items="${entry.value}" varStatus="loop">
							${marca.cpMarcador.descrMarcador} 
							<c:if test="${marca.dtIniMarca gt now}">
								a partir de ${marca.dtIniMarcaDDMMYYYY}
							</c:if>
							<c:if test="${not empty marca.dtFimMarca}"> 
								até ${marca.dtFimMarcaDDMMYYYY}
							</c:if>
							<c:if test="${not empty marca.dpLotacaoIni}">
							[
							${marca.dpLotacaoIni.sigla}
							<c:if test="${not empty marca.dpPessoaIni}">
								&nbsp;${marca.dpPessoaIni.sigla}
							</c:if>
							]
							</c:if>
						</c:forEach>
						</li>
					</c:forEach>
					</ul>
			</div>
		</c:if>
		
		<!-- Início mapa relação entre documentos -->
		<c:if test="${docVO.dotRelacaoDocs.numNodos > 1}">
		<!-- Sidebar List -->
		<div class="gt-sidebar-content">
			<h3 style="margin-bottom: 10px">Documentos Relacionados</h3>
			<div id="outputRelacaoDocs" style="border: 0px; background-color: #e2eaee; padding: 0px">
				<c:forEach items="${docVO.dotRelacaoDocs.asMap}" var="mapa">
					<p style="margin-bottom: 3px;">
						<b>${mapa.key}:</b> 
					</p>
				<ul>
				<c:forEach var="mobRelacionado" items="${mapa.value}">
					<li>
						<ww:url id="url" action="exibir" namespace="/expediente/doc" >
							<ww:param name="sigla">${mobRelacionado.sigla}</ww:param>
						</ww:url>
						<ww:a href="%{url}" title="${mobRelacionado.doc.descrDocumento}" cssStyle="text-decoration: none">
							${mobRelacionado.sigla}
						</ww:a>	
					</li>
				</c:forEach>
				</ul>
				</c:forEach>
			</div>
		</div>
	
		<script>
			$(document).ready(function () {
			    $(window).resize(function() {
				   updateContainerRelacaoDocs();
			    }); 

				$("#svgRelacaoDocs").dialog({
		    		autoOpen: false,
		    		height: $(window).height()*0.9,
			    	width: $(window).width()*0.9,
		    		modal: true,
				    resizable: false
		  		});
				$("#output2RelacaoDocs").mousedown(function(e){
					if (e.button == 0 && zoomRelacaoDocs < 3)
						zoomRelacaoDocs +=0.2;
					else if (e.button == 2 && zoomRelacaoDocs > 0.5)
						zoomRelacaoDocs -= 0.2;
					updateContainerRelacaoDocs();
				});
			});

			function bigmapRelacaoDocs() {
				$('#svgRelacaoDocs').dialog('open');
				if ($('#naoCarregouBigRelacaoDocs')[0] != undefined){
					var input = 'digraph "" { graph[tooltip="Documentos Relacionados"]; edge[penwidth=2]; ${docVO.dotRelacaoDocs} }';
					input = escapeAcentos(input);
					var result = Viz(input, "svg", "dot");
			  		document.getElementById("output2RelacaoDocs").innerHTML = result;
				}
			  	updateContainerRelacaoDocs();
			} 

			var hexDigits = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
			function rgb2hex(rgb) {
				 rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
				 return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
			}			
			function hex(x) {
	  			return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
	 		}
			
			function smallmapRelacaoDocs() {
				$("#outputRelacaoDocs").css("background-color", $("html").css("background-color"));
				var bgcolor = rgb2hex($("#outputRelacaoDocs").css("background-color"));
				var input = 'digraph "" { graph[ratio="0.4" tooltip="Documentos Relacionados" color="'+ bgcolor +'" bgcolor="'+bgcolor+'" URL="javascript: bigmapRelacaoDocs();"]; node[fillcolor=white fontsize=20 style=filled]; edge[penwidth=2]; ${docVO.dotRelacaoDocs} }';
				input = escapeAcentos(input);
				var result = Viz(input, "svg", "dot");
			  	document.getElementById("outputRelacaoDocs").innerHTML = result;
				updateContainerRelacaoDocs();
			}
	
			var zoomRelacaoDocs = 1;
			function updateContainerRelacaoDocs() {
			    var smallwidth = $('#outputRelacaoDocs').width(); 
		    	var smallsvg = $('#outputRelacaoDocs :first-child').first(); 
		    	var smallviewbox = smallsvg.attr('viewBox');
			      
		    	if(typeof smallviewbox != 'undefined') {
				    var a = smallviewbox.split(' ');  
		
			    	// set attrs and 'resume' force 
			    	smallsvg.attr('width', smallwidth);
			    	smallsvg.attr('height', smallwidth * a[3] / a[2]);
		    	}
			    
		    	var bigsvg = $('#output2RelacaoDocs :first-child').first(); 
		    	var bigviewbox = bigsvg.attr('viewBox');
			      
		    	if(typeof bigviewbox != 'undefined') {
				    var a = bigviewbox.split(' ');  
		
			    	// set attrs and 'resume' force 
			    	bigsvg.attr('width', a[2] * zoomRelacaoDocs);
			    	bigsvg.attr('height', a[3] * zoomRelacaoDocs);
		    	}
			}
			smallmapRelacaoDocs();
    	</script>
    	</c:if>
    	<!-- Fim mapa relação entre documentos -->
	
	
		<c:if test="${docVO.dotTramitacao.numNodos > 1}">
		<!-- Início mapa tramitação -->
	
		<!-- Sidebar List -->
		<div class="gt-sidebar-content" id="tramitacao">
			<h3 style="margin-bottom: 10px">Tramitação</h3>
			<div style="display: none" id="inputTramitacao">
			</div>
			<a href="javascript:void(0)" href="javascript:void(0)" style="text-decoration: none">
			<div id="outputTramitacao" style="border: 0px; background-color: #e2eaee; padding: 0px;">
			</div>
			</a>
		</div>
	
		<script>
		$(document).ready(function () {
		    $(window).resize(function() {
			    updateContainerTramitacao();
		    });
		    	 
			$("#svgTramitacao").dialog({
		    	autoOpen: false,
		    	height: $(window).height()*0.9,
		    	width: $(window).width()*0.9,
		    	modal: true,
			    resizable: false
		  	});
			$("#output2Tramitacao").mousedown(function(e){
				if (e.button == 0 && zoomTramitacao < 3)
					zoomTramitacao += 0.2;
				else if (e.button == 2 && zoomTramitacao > 0.5)
					zoomTramitacao -= 0.2;
				updateContainerTramitacao();
			});
			if (!document.getElementById("outputTramitacao").hasChildNodes()){
				$("#tramitacao").hide();
			}
		});
		
		function bigmapTramitacao() {
			$('#svgTramitacao').dialog('open');
			if ($('#naoCarregouBigTramitacao')[0] != undefined){
				var input = 'digraph ""{ graph[tooltip="Tramitação"] ${docVO.dotTramitacao} }';
				input = escapeAcentos(input);
				var result = Viz(input, "svg", "dot");
		  		document.getElementById("output2Tramitacao").innerHTML = result;
			}
		  	updateContainerTramitacao();
		} 

		var hexDigits = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
		function rgb2hex(rgb) {
			 rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
			 return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
		}			
		function hex(x) {
  			return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
 		}
	 	function ratioTramitacao(){
	 		var x = ${docVO.dotTramitacao.numNodos};
	 		if (x <= 2)
		 		return '0.4';
	 		else if (x ==3)
		 		return '0.5';
	 		else if (x ==4)
		 		return '0.6';
	 		else return '0.7';
	 	}
		
		function smallmapTramitacao() {
			$("#outputTramitacao").css("background-color", $("html").css("background-color"));
			var bgcolor = rgb2hex($("#outputTramitacao").css("background-color"));
			var input = 'digraph "" { graph[tooltip="Tramitação" ratio="' + ratioTramitacao() + '"  color="'+ bgcolor +'" bgcolor="'+bgcolor+'" URL="javascript: bigmapTramitacao();"]; node[fillcolor=white fontsize=50 style=filled ]; edge[fontsize=30]; ${docVO.dotTramitacao} }';
			input = escapeAcentos(input);
			var result = Viz(input, "svg", "dot");
		  	document.getElementById("outputTramitacao").innerHTML = result;
			updateContainerTramitacao();
		}

		var zoomTramitacao = 1;
		function updateContainerTramitacao() {
		    var smallwidth = $('#outputTramitacao').width(); 
	    	var smallsvg = $('#outputTramitacao :first-child').first(); 
	    	var smallviewbox = smallsvg.attr('viewBox');
		      
	    	if(typeof smallviewbox != 'undefined') {
			    var a = smallviewbox.split(' ');  
	
		    	// set attrs and 'resume' force 
		    	smallsvg.attr('width', smallwidth);
		    	smallsvg.attr('height', smallwidth * a[3] / a[2]);
	    	}
		    
	    	var bigsvg = $('#output2Tramitacao :first-child').first(); 
	    	var bigviewbox = bigsvg.attr('viewBox');
		      
	    	if(typeof bigviewbox != 'undefined') {
			    var a = bigviewbox.split(' ');  
	
		    	// set attrs and 'resume' force 
		    	bigsvg.attr('width', a[2] * zoomTramitacao);
		    	bigsvg.attr('height', zoomTramitacao * a[3]);
	    	};
		}
		smallmapTramitacao();
    	</script>
    	
    	<!-- Fim mapa tramitação -->
    	</c:if>
	
		<div class="gt-sidebar-content">
			<h3>Documento ${docVO.doc.exTipoDocumento.descricao}</h3>
			<p>
				<b>Suporte:</b> ${docVO.fisicoOuEletronico}
			</p>
			<p>
				<b>Data:</b> ${docVO.dtDocDDMMYY}
			</p>
			<p>
				<b>De:</b> ${docVO.subscritorString}
			</p>
			<p>
				<b>Para:</b> ${docVO.destinatarioString}
			</p>
			<p>
				<b>Cadastrante:</b> ${docVO.cadastranteString} ${docVO.lotaCadastranteString}
			</p>
			<p>
				<b>Tipo:</b> ${docVO.forma}
			</p>
			<p>
				<b>Modelo:</b> ${docVO.modelo}
			</p>
			<p>
				<b>Descrição:</b> ${docVO.descrDocumento}
			</p>
			<p>
				<b>Classificação:</b> ${docVO.classificacaoDescricaoCompleta}
			</p>

			<c:if test="${not empty docVO.dadosComplementares}">
		    	${docVO.dadosComplementares}
			</c:if>
			
			<c:if test="${not empty docVO.cossignatarios}">
			<div class="gt-sidebar-content" style="padding-top: 10px">
			<h3>Cossignatários</h3>
			<ul>
			<c:forEach var="cossig" items="${docVO.cossignatarios}">
				<li>
					${cossig.key.subscritor.nomePessoa}
					<c:if test="${cossig.value}">&nbsp;
					<a href="/sigaex/expediente/mov/excluir.action?id=${cossig.key.idMov}" >Excluir</a></c:if>
				</li>
			</c:forEach>
			</ul>
			</div>
			</c:if>
			
			<c:if test="${not empty docVO.doc.perfis}">
			<div class="gt-sidebar-content" style="padding-top: 10px">
			<h3>Perfis</h3>
			<c:forEach var="perfil" items="${docVO.doc.perfis}">
				<p style="margin-bottom: 3px;">
					<b>${perfil.key.descPapel}:</b> 
				</p>
				<ul>
				<c:forEach var="pessoaOuLota" items="${perfil.value}">
					<li>
						<c:catch var="exception">${pessoaOuLota.nomePessoa}</c:catch>
						<c:if test="${not empty exception}">${pessoaOuLota.nomeLotacao}</c:if>
					</li>
				</c:forEach>
				</ul>
			</c:forEach>
			</div>
			</c:if> 
			
			<div class="gt-sidebar-content" style="padding-top: 10px">
			<h3>Nível de Acesso</h3>
			<p>
				<b>${docVO.nmNivelAcesso}</b> 
				<c:if test="${not empty docVO.listaDeAcessos}">
					<ww:if test="%{#attr.docVO.listaDeAcessos.size() eq 1}">
						<c:forEach var="acesso" items="${docVO.listaDeAcessos}" varStatus="loop">
							<ww:if test="${acesso eq 'PUBLICO'}">
								(Público)
							</ww:if>
							<ww:else>
								(${acesso.sigla})
							</ww:else>
						</c:forEach>
					</ww:if>
					<ww:else>
						<ul>	
						<c:forEach var="acesso" items="${docVO.listaDeAcessos}" varStatus="loop">
							<li>${acesso.sigla}</li>
						</c:forEach>
						</ul>
					</ww:else>
				</c:if>
			</p>	
	</div>

	<div class="gt-sidebar-content" id="gc"></div>

		<!-- / sidebar -->
	</div>

</div>
	


	</ww:if>
	</c:forEach>



	<!-- Visualização dos principais dados do documento em questão -->

	<!-- Links para as ações de gerais do documento -->
	<%--

 --%>
</div>
</div>

<script type="text/javascript">
	var css = "<style>.ui-widget-header {border: 1px solid #365b6d;background: #365b6d;}</style>";
	$(css).appendTo("head");
</script>

<div class="gt-bd clearfix" id="svgRelacaoDocs" style="display: none; overflow-y: scroll;">
		<div class="gt-content clearfix">
			<div id="desc_editar_relacaoDocs">
				<div style="padding-bottom: 15px;" id="output2RelacaoDocs" oncontextmenu="return false;">
					<h4 id="naoCarregouBigRelacaoDocs">Carregando...</h4>
				</div>
			</div>
		</div>
		<p style="font-weight: bold">Clique sobre a imagem com o botão esquerdo para ampliar ou com o direito para reduzir.</p>
		<a href="javascript:void(0)" onclick="javascript: $('#svgRelacaoDocs').dialog('close');"
			class="gt-btn-large gt-btn-left">Voltar</a>

	</div>
	
<div class="gt-bd clearfix" id="svgTramitacao" style="display: none; overflow-y: scroll;">
		<div class="gt-content clearfix">
			<div id="desc_editar_tramitacao">
				<div style="padding-bottom: 15px;" id="output2Tramitacao" oncontextmenu="return false;">
					<h4 id="naoCarregouBigTramitacao">Carregando...</h4>
				</div>
			</div>
		</div>
		<p style="font-weight: bold">Clique sobre a imagem com o botão esquerdo para ampliar ou com o direito para reduzir.</p>
		<a href="javascript:void(0)" onclick="javascript: $('#svgTramitacao').dialog('close');"
			class="gt-btn-large gt-btn-left">Voltar</a>

	</div>


<!-- Somente quando o workflow está ativado -->

<c:if test="${f:resource('isWorkflowEnabled')}">
	<script type="text/javascript">ReplaceInnerHTMLFromAjaxResponse("/sigawf/doc.action?sigla=${doc.codigo}&ts=${currentTimeMillis}",null,"wf");</script>
</c:if>
<c:if
	test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GC')}">
	<c:url var="url" value="/../sigagc/app/knowledge">
		<c:param name="tags">@documento</c:param>
		<c:forEach var="tag" items="${docVO.tags}">
			<c:param name="tags">${tag}</c:param>
		</c:forEach>
		<c:param name="estilo">sidebar</c:param>
		<c:param name="ts">${currentTimeMillis}</c:param>
	</c:url>
	<script type="text/javascript">
		SetInnerHTMLFromAjaxResponse("${url}",document.getElementById('gc'));
	</script>
</c:if>

<siga:rodape />
