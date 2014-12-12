<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="128kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>

<%@ taglib prefix="ww" uri="/webwork"%>

<script type="text/javascript" language="Javascript1.1">

function sbmt() {
	frmRelExpedientes.action='<ww:property value="%{url}"/>';
	frmRelExpedientes.submit();	
}
</script>
<c:set var="titulo_pagina" scope="request">Relat�rio de Movimenta��o</c:set>
<ww:hidden name="secaoUsuario"
	value="${lotaTitular.orgaoUsuario.descricaoMaiusculas}" />
<tr>
<tr>
	<td>Lota��o</td>
	<td><siga:selecao propriedade="lotacaoDestinatario" tema="simple"
		reler="sim" modulo="siga"/></td>
</tr>

<input type="hidden" name="lotacao" value="${lotacaoDestinatarioSel.id}" />
<input type="hidden" name="siglalotacao"
	value="${lotacaoDestinatarioSel.sigla}" />
<tr>
	<td>Data Inicial</td>
	<td><ww:textfield name="dataInicial"
		onblur="javascript:verifica_data(this, true);comparaData(dataInicial,dataFinal);"
		theme="simple" size="12" maxlength="10" /></td>
</tr>
<tr>
	<td>Data Final</td>
	<td><ww:textfield name="dataFinal"
		onblur="javascript:verifica_data(this,true);comparaData(dataInicial,dataFinal);"
		theme="simple" size="12" maxlength="10" /></td>
</tr>

<input type="hidden" name="lotacaoTitular"
	value="${lotaTitular.siglaLotacao}" />
<input type="hidden" name="orgaoUsuario"
	value="${lotaTitular.orgaoUsuario.idOrgaoUsu}" />
<input type="hidden" name="idTit"
	value="${titular.id}" />


