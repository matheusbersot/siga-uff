<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="32kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<ww:url id="url" action="editar" />
<script type="text/javascript" language="Javascript1.1">
	function sbmt(offset) {
		if (offset == null) {
			offset = 0;
		}
		frm.elements['p.offset'].value = offset;
		frm.submit();
	}
	function editar(p_strId) {
		var t_strUrl = '${url}';
		if (p_strId) {
			if (t_strUrl.indexOf('?') == -1) {
				window.location.href = t_strUrl + '?' + 'idCpGrupo=' + p_strId;
			} else {
				window.location.href = t_strUrl + '&' + 'idCpGrupo=' + p_strId;
			}
		} else {
			window.location.href = t_strUrl;
		}
	}
</script>

<%-- pageContext.setAttribute("sysdate", new java.util.Date()); --%>
<siga:pagina titulo="Busca de ${cpTipoGrupo.dscTpGrupo}">
	<div class="gt-bd clearfix">
		<div class="gt-content clearfix">
			<h2>Cadastro de ${cpTipoGrupo.dscTpGrupo}</h2>
			<div class="gt-content-box">
				<table class="gt-table" width="100%">
					<theader>
					<th align="left">Sigla</th>
					<th align="left">Descrição</th>
					<th align="left">Sigla Grupo Pai</th>
					</theader>
					<c:set var="evenorodd" value="" />
					<c:set var="tamanho" value="0" />
					<siga:paginador maxItens="1000" maxIndices="10"
						totalItens="${tamanho}" itens="${itens}" var="grupoItem">
						<tr class="${evenorodd}">
							<td align="left"><a
								href='javascript:editar(${grupoItem.idGrupo })'>${grupoItem.siglaGrupo
									}</a></td>
							<td align="left"><a
								href='javascript:editar(${grupoItem.idGrupo })'>${grupoItem.dscGrupo
									}</a></td>
							<td align="left"><a
								href='javascript:editar(${grupoItem.idGrupo })'>${grupoItem.cpGrupoPai.siglaGrupo
									}</a></td>
						</tr>
					</siga:paginador>
				</table>
			</div>
			<br /> 
			<c:if test="${cpTipoGrupo.idTpGrupo != 2 or (cpTipoGrupo.idTpGrupo == 2 and f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;GDISTR;INC:Incluir'))}">
						<input type="button" value="Incluir"
				onclick="javascript:editar()" class="gt-btn-medium">
			</c:if>
		</div>
	</div>
</siga:pagina>