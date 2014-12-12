<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>


<siga:pagina titulo="Administra��o">

	<table border="1" width="600" bordercolorlight="#FFFFFF"
		bordercolor="#FFFFFF" bordercolordark="#FFFFFF" cellspacing="0"
		bgcolor="#ECF1FF" cellpadding="2">
		<tr>
			<td width="521" valign="top" bgcolor="#C0C0C0"><font size="2"
				face="Arial"><b>Menu de Rotinas de Administra��o</b></font></td>

		</tr>

		<tr>
			<td width="521" valign="top" bgcolor="#FFFF99"><ww:a
				href="/autenticador/usuario.jf?acao=aListar&exibir=troca">
				<font size="2" face="Arial"> Trocar senha </font>
			</ww:a></td>
		</tr>

		<tr>
			<td width="521" valign="top" bgcolor="#FFFF99"><ww:url id="url"
				action="substituir" namespace="/substituicao" /> <ww:a
				href="%{url}">
				<font size="2" face="Arial"> Entrar como substituto</font>
			</ww:a></td>
		</tr>

		<c:if
			test="${(not empty lotaTitular && lotaTitular.idLotacao!=cadastrante.lotacao.idLotacao) ||(not empty titular && titular.idPessoa!=cadastrante.idPessoa)}">
			<tr>
				<td width="521" valign="top" bgcolor="#FFFF99"><ww:url id="url"
					action="finalizar" namespace="/substituicao" /> <ww:a
					href="%{url}">
					<font size="2" face="Arial"> Finalizar substitui��o de <c:choose>
						<c:when test="${not empty titular && titular.idPessoa!=cadastrante.idPessoa}">${titular.nomePessoa}</c:when>
						<c:otherwise>${lotaTitular.sigla}</c:otherwise>
					</c:choose></font>
				</ww:a></td>
			</tr>
		</c:if>

		<tr>
			<td width="521" valign="top" bgcolor="#FFFF99"><ww:url id="url"
				action="listar" namespace="/substituicao" /> <ww:a href="%{url}">
				<font size="2" face="Arial"> Gerenciar poss�veis substitutos
				</font>
			</ww:a></td>
		</tr>

		<tr>
			<td width="521" valign="top" bgcolor="#FFFF99"><ww:url id="url"
				action="listar" namespace="/despacho/tipodespacho" /> <ww:a
				href="%{url}">
				<font size="2" face="Arial"> Cadastro dos tipos de despacho </font>
			</ww:a></td>
		</tr>


		<!--  
	<tr>
		<td width="521" valign="top" bgcolor="#FFFF99"><font size="2"
			face="Arial"> Cadastro de empresas </font></td>
	</tr>

	<tr>
		<td width="521" valign="top" bgcolor="#FFFF99"><font size="2"
			face="Arial"> Cadastro de Se��es atendentes</font></td>

	</tr>


	<tr>
		<td width="521" valign="top" bgcolor="#FFFF99"><font size="2"
			face="Arial"> Cadastro de tercerizados</font></td>

	</tr>


	<tr>
		<td width="521" valign="top" bgcolor="#FFFF99"><font size="2"
			face="Arial"> Cadastro de assuntos e especifica��es </font></td>
	</tr>
	<tr>
		<td width="521" valign="top" bgcolor="#FFFF99"><font size="2"
			face="Arial"> Cadastro de endere�os e telefones </font></td>
	</tr>
-->
		<tr>
			<td width="521" valign="top" bgcolor="#FFFF99"><font size="2"
				face="Arial"> Estat�sticas </font></td>
		</tr>
	</table>

</siga:pagina>



