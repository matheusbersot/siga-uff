<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>

<siga:pagina titulo="Movimentação">

<c:if test="${not mob.doc.eletronico}">
	<script type="text/javascript">$("html").addClass("fisico");</script>
</c:if>

<script type="text/javascript" language="Javascript1.1">
<ww:url id="url" action="reclassificar_gravar" namespace="/expediente/mov">
	<ww:param name="id">${doc.idDoc}</ww:param>
</ww:url>
function sbmt() {	
	frm.action='<ww:property value="%{url}"/>';
	frm.submit();
}
</script>

	<div class="gt-bd clearfix">
		<div class="gt-content clearfix">
		
			<h2>Reclassificação - ${mob.sigla}</h2>

			<div class="gt-content-box gt-for-table">

		<ww:form name="frm" action="reclassificar_gravar"
			namespace="/expediente/mov" theme="simple" method="POST">
			<ww:token/>
			<ww:hidden name="postback" value="1" />
			<ww:hidden name="sigla" value="%{sigla}"/>

			<table class="gt-form-table">
				<tr class="header">
					<td colspan="2">Reclassificação</td>
				</tr>
				<tr>
					<td>Data:</td>
					<td><ww:textfield name="dtMovString"
						onblur="javascript:verifica_data(this,0);" /></td>
				</tr>
				<tr>
					<td>Responsável:</td>
					<td><siga:selecao tema="simple" propriedade="subscritor" modulo="siga" />
					&nbsp;&nbsp;<ww:checkbox theme="simple" name="substituicao"
						onclick="javascript:displayTitular(this);" />Substituto</td>
				</tr>
				<c:choose>
					<c:when test="${!substituicao}">
						<tr id="tr_titular" style="display: none">
					</c:when>
					<c:otherwise>
						<tr id="tr_titular" style="">
					</c:otherwise>
				</c:choose>

				<td>Titular:</td>
					<input type="hidden" name="campos" value="titularSel.id" />
				<td colspan="3"><siga:selecao propriedade="titular"
							tema="simple" modulo="siga" /></td>
				</tr>
				<siga:selecao titulo="Nova Classificação:" propriedade="classificacao" modulo="sigaex" />
				<tr>
					<td>Motivo</td>
					<td><ww:textfield
						name="descrMov" size="50" maxLength="128" theme="simple"/>
					</td>
				</tr>

				<!-- 		</table>
		<br />
		<table class="form" width="100%">
 -->


				<%--<c:if test="${tipoResponsavel != 3}">
					<tr>
						<td>Destino final (opcional)</td>
						<td><ww:select name="tipoDestinoFinal" list="listaTipoDestinoFinal"
							onchange="javascript:sbmt();" /> <c:choose>
							<c:when test="${tipoDestinoFinal == 1}">
								<siga:selecao propriedade="lotaDestinoFinal" tema="simple" />
							</c:when>
							<c:when test="${tipoDestinoFinal == 2}">
								<siga:selecao propriedade="destinoFinal" tema="simple" />
							</c:when>
						</c:choose></td>
					</tr>
				</c:if>--%>
				<c:if test="${tipoResponsavel == 3}">
					<tr>
						<td>Observação</td>
						<td><ww:textfield size="30" name="obsOrgao" /></td>
					</tr>
				</c:if>

				<tr class="button">
					<td colspan="2"><input type="submit" value="Ok" class="gt-btn-small gt-btn-left" /> <input type="button"
						value="Cancela" onclick="javascript:history.back();" class="gt-btn-small gt-btn-left" /></td>
				</tr>
			</table>

		</ww:form>
		
	</div></div></div>
</siga:pagina>
