<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="32kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<siga:pagina titulo="Cadastro de configura��o">


<ww:url id="url" action="editar" namespace="/configuracao">
</ww:url>

<script type="text/javascript" language="Javascript1.1">

<ww:url id="urlForma" action="carregar_lista_formas" namespace="/expediente/doc">
</ww:url>
function alteraTipoDaForma(){
	ReplaceInnerHTMLFromAjaxResponse('<ww:property value="%{urlForma}"/>'+'?tipoForma='+document.getElementById('tipoForma').value+'&idFormaDoc='+'${idFormaDoc}', null, document.getElementById('comboFormaDiv'))
}

<ww:url id="urlModelo" action="carregar_lista_modelos" namespace="/expediente/doc">
</ww:url>
function alteraForma(){
	ReplaceInnerHTMLFromAjaxResponse('<ww:property value="%{urlModelo}"/>'+'?forma='+document.getElementById('forma').value+'&idMod='+'${idMod}', null, document.getElementById('comboModeloDiv'))
}

function sbmt() {
	editar_gravar.action='<ww:property value="%{url}"/>';
	editar_gravar.submit();
}

</script>



<body onload="aviso()">

<div class="gt-bd clearfix">
	<div class="gt-content clearfix">		


		<form action="editar_gravar.action">
		<input type="hidden" name="postback" value="1" />
		<input type="hidden" name="nmTipoRetorno" value="${nmTipoRetorno}" /> <ww:hidden
			name="id" /> <c:set var="dataFim" value="" />
		<h1>Cadastro de configura��o <c:if
			test="${not empty configuracao}">
			para ${configuracao.cpTipoConfiguracao.dscTpConfiguracao}
		</c:if></h1>
		<div class="gt-content-box gt-for-table">
		<table class="gt-form-table" width="100%">
			<tr class="header">
				<td colspan="2">Dados da configura��o</td>
			</tr>
			<tr>
				<td><b>Tipo de Configura��o</b></td>
				<td>
					<c:choose>
						<c:when test="${campoFixo && not empty config.cpTipoConfiguracao}">
							<ww:hidden name="idTpConfiguracao" />
							${config.cpTipoConfiguracao.dscTpConfiguracao}
						</c:when>
						<c:otherwise>
							<ww:select name="idTpConfiguracao"
							   list="listaTiposConfiguracao" listKey="idTpConfiguracao"
							   listValue="dscTpConfiguracao" theme="simple"
							   headerValue="[Indefinido]" headerKey="0" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td><b>Situa��o</b></td>
				<td><ww:select name="idSituacao" list="listaSituacao"
					listKey="idSitConfiguracao" listValue="dscSitConfiguracao"
					theme="simple" headerValue="[Indefinido]" headerKey="0" /></td>
			</tr>
			<tr>
				<td>N�vel de acesso</td>
				<td><ww:select name="idNivelAcesso" list="listaNivelAcesso"
					theme="simple" listKey="idNivelAcesso" listValue="nmNivelAcesso"
					headerValue="[Indefinido]" headerKey="0" /></td>
			</tr>
			<tr>
				<td>Pessoa</td>
				<td><siga:selecao propriedade="pessoa" tema="simple" modulo="siga"/></td>
			</tr>
			<tr>
				<td>Lota��o</td>
				<td><siga:selecao propriedade="lotacao" tema="simple" modulo="siga"/></td>
			</tr>
			<tr>
				<td>Cargo</td>
				<td><siga:selecao propriedade="cargo" tema="simple" modulo="siga"/></td>
			</tr>			
			<tr>
				<td>Fun��o de Confian�a</td>
				<td><siga:selecao propriedade="funcao" tema="simple" modulo="siga"/></td>
			</tr>
			<tr>
				<td>�rg�o</td>
				<td><ww:select name="idOrgaoUsu" list="orgaosUsu"
					listKey="idOrgaoUsu" listValue="nmOrgaoUsu" theme="simple"
					headerValue="[Indefinido]" headerKey="0" /></td>
			</tr>
			<%--<tr>
				<td>Cargo</td>
				<td><siga:selecao propriedade="cargo" tema="simple" /></td>
			</tr>--%>
			<tr>
				<td>Tipo de Movimenta��o</td>
				<td>
					<c:choose>
						<c:when test="${campoFixo && not empty config.exTipoMovimentacao}">
							<ww:hidden name="idTpMov" />
							${config.exTipoMovimentacao.descrTipoMovimentacao}
						</c:when>
						<c:otherwise>
							<ww:select name="idTpMov" list="listaTiposMovimentacao"
								listKey="idTpMov" listValue="descrTipoMovimentacao" theme="simple"
								headerValue="[Indefinido]" headerKey="0" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<%--<tr>
				<td>Via</td>
				<td><ww:select name="idVia" list="listaVias" listKey="idVia"
					listValue="destinacao" theme="simple" headerValue="[Indefinido]"
					headerKey="0" /></td>
			</tr> --%>
			<tr>
				<td>Tipo:</td>
				<td>
					<c:choose>
						<c:when test="${campoFixo && not empty config.exModelo}">
							${config.exModelo.exFormaDocumento.exTipoFormaDoc.descTipoFormaDoc} - ${config.exModelo.exFormaDocumento.descrFormaDoc}
						</c:when>
						<c:when test="${campoFixo && not empty config.exFormaDocumento}">
							${config.exFormaDocumento.exTipoFormaDoc.descTipoFormaDoc} - ${config.exFormaDocumento.descrFormaDoc}
						</c:when>
						<c:otherwise>
							<ww:select name="idTpFormaDoc" list="tiposFormaDoc"
					                       listKey="idTipoFormaDoc" listValue="descTipoFormaDoc"
							      		   theme="simple" headerKey="0" headerValue="[Indefinido]"
										   onchange="javascript:alteraTipoDaForma();" id="tipoForma" />&nbsp;&nbsp;&nbsp;
									       <div style="display: inline" id="comboFormaDiv">
										   		<script type="text/javascript">alteraTipoDaForma();</script>
										   </div>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<!-- Esse timeout no modelo est� estranho. Est� sendo necess�rio porque primeiro
      		 precisa ser executado o request ajax referente � FormaDocumento, da qual a lista 
		     de modelos depende. Talvez seria bom tornar s�ncronos esses dois requests ajax -->
			<tr>
				<td>Modelo:</td>
				<td>
					<c:choose>
						<c:when test="${campoFixo && not empty config.exModelo}">
							<ww:hidden name="idMod" />
							${config.exModelo.descMod}
						</c:when>
						<c:when test="${campoFixo && not empty config.exFormaDocumento}">
							<ww:hidden name="idFormaDoc" />
						</c:when>
						<c:otherwise>
							<div style="display: inline" id="comboModeloDiv">
								<script type="text/javascript">setTimeout("alteraForma()",500);</script>
							</div>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>		
			<tr>
				<td>Classifica��o</td>
				<td><siga:selecao propriedade="classificacao" tema="simple" modulo="sigaex"/></td>
			</tr>			
			<tr>
				<td>Origem</td>
				<td><ww:select name="idTpDoc" list="listaTiposDocumento"
					listKey="idTpDoc" listValue="descrTipoDocumento" theme="simple"
					headerValue="[Indefinido]" headerKey="0" /></td>
			</tr>
			<tr>
				<td>�rg�o Objeto</td>
				<td><ww:select name="idOrgaoObjeto" list="orgaosUsu"
					listKey="idOrgaoUsu" listValue="nmOrgaoUsu" theme="simple"
					headerValue="[Indefinido]" headerKey="0" /></td>
			</tr>
			<tr>
			</tr>
			<tr class="button">
				<td><input type="submit" value="Ok" class="gt-btn-large gt-btn-left" /> <input type="button"
					value="Cancela" onclick="javascript:history.back();" class="gt-btn-medium gt-btn-left" /></td>
				<td></td>
			</tr>
		</table>
		</div>
<br />
</div></div>
</body>

</siga:pagina>
