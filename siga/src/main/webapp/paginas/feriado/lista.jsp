<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>


<siga:pagina titulo="Lista Feriados">
	<!-- main content -->
	
	<script type="text/javascript">
	function validar() {
		var descricao = $('#dscFeriado').val();		
		if (descricao==null || descricao=="") {			
			alert("Preencha a descricao do feriado");
			document.getElementById('dscFeriado').focus();		
		}else 
			frm.submit();					
	}
	</script>
	
	<div class="gt-bd clearfix">
		<div class="gt-content clearfix">
				
			<h2>Cadastro de Feriados</h2>
				<div class="gt-content-box gt-for-table" style="width: 80% !important;">
					<form name="frm" action="editar_gravar.action">
						<ww:hidden name="id" /> 
						<input type="hidden" name="postback" value="1" />
						<table class="gt-form-table">
							<tr>
								<td width="4%" align="right">Feriado:</td>
								<td><ww:textfield  name="dscFeriado" id="dscFeriado" maxlength="60" size="60" theme="simple" /></td>
							</tr>
							<tr>	
								<td colspan="2"><input type="button" value="Salvar" onclick="javascript: validar();"
										class="gt-btn-medium gt-btn-left" />	
									<input  type="button" value="Excluir" onclick="javascript:if (confirm('Deseja excluir o feriado?')) location.href='/siga/feriado/excluir.action?id=${id}';"
									       class="gt-btn-medium gt-btn-left" />											
									<input  type="button" value="Voltar" onclick="javascript:location.href='/siga';"
									       class="gt-btn-medium gt-btn-left" />	
								</td>
							</tr>							
						</table>
					</form>
				</div>
				
				
			<h2 class="gt-table-head">Feriados cadastrados</h2>
			<div class="gt-content-box gt-for-table" style="width: 80% !important;">
				<table border="0" class="gt-table">
					<thead>
						<tr>							
							<th align="left" width="30%">Descrição</th>	
							<th align="right" width="20%">Incluir ocorrência</th>
							<th align="right" width="15%">Data Inicio</th>
							<th align="right" width="15%">Data Fim</th>														
							<th colspan="2" align="right" width="20%">Opções de ocorrência</th>					
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="feriado" items="${itens}">
							<tr>							
								<ww:url id="url" action="listar" namespace="/feriado">
									<ww:param name="id">${feriado.id}</ww:param>
								</ww:url>	
								<ww:url id="urlI" action="editar_ocorrencia" namespace="/feriado">
									<ww:param name="id">${feriado.id}</ww:param>	
								</ww:url>														
								<td align="left" rowspan="${feriado.quantidadeOcorrencias+1}"><ww:a href="%{url}">${feriado.dscFeriado}</ww:a></td>
								<td align="center" rowspan="${feriado.quantidadeOcorrencias+1}"><siga:link title="Incluir" url="${urlI}" /></td>									
								<ww:if test="${(not empty feriado.cpOcorrenciaFeriadoSet)}">
									<c:forEach var="ocorrencia" items="${feriado.cpOcorrenciaFeriadoSet}">	
									<tr>											
										<td align="left">${ocorrencia.dtRegIniDDMMYY}</td>
										<td align="left">${ocorrencia.dtRegFimDDMMYY}</td>
										<td align="left"><ww:url id="url" action="editar_ocorrencia" namespace="/feriado">
															<ww:param name="idOcorrencia">${ocorrencia.idOcorrencia}</ww:param>
															<ww:param name="id">${feriado.id}</ww:param>
														</ww:url>
													<siga:link title="Alterar" url="${url}" />					
										</td>
										<td align="center" width="10%">									
	 			 							<a href="javascript:if (confirm('Deseja excluir a ocorrência do feriado?')) location.href='/siga/feriado/excluir_ocorrencia.action?idOcorrencia=${ocorrencia.idOcorrencia}';">
												<img style="display: inline;"
												src="/siga/css/famfamfam/icons/cancel_gray.png" title="Excluir feriado"							
												onmouseover="this.src='/siga/css/famfamfam/icons/cancel.png';" 
												onmouseout="this.src='/siga/css/famfamfam/icons/cancel_gray.png';"/>
											</a>															
										</td>
									</tr>																	
									</c:forEach>										
								</ww:if>
								<ww:else>										
									<td></td><td></td>
				<%--					<td align="left"><ww:url id="url" action="editar_ocorrencia" namespace="/feriado">
													<ww:param name="id">${feriado.id}</ww:param>
												</ww:url>
											<siga:link title="Incluir" url="${url}" />	
											 --%>				
										</td><td></td><td></td>										
								</ww:else>														 							
							</tr>
						</c:forEach>
					</tbody>
				</table>				
			</div>				
		</div>	
	</div>		
</siga:pagina>
