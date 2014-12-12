<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>

  <div class="gt-content clearfix">	
		 
		<h2 style="margin-top: 20px;">${tpConfiguracao.dscTpConfiguracao} <span style="float: right; font-size: 70%">(Situação default: </b> ${tpConfiguracao.situacaoDefault.dscSitConfiguracao})</span></h2>
		
		<div class="gt-content-box gt-for-table">
		
		<table class="gt-table" width="100%">
			<tr class="header">
				<th align="center">Nível de acesso</th>
				<th align="center">Pessoa</th>
				<th align="center">Lotação</th>
				<th align="center">Função</th>
				<th align="center">Órgão</th>
				<th align="center">Órgão Objeto</th>
				<th align="center">Cargo</th>
				<th align="center">Tipo de Movimentação</th>
				<th align="center">Via</th>
				<th align="center">Modelo</th>
				<th align="center">Classificação</th>
				<th align="center">Tipo forma de documento</th>
				<th align="center">Forma de documento</th>
				<th align="center">Tipo de Documento</th>
				<th align="center">Vínculo</th>
				<th align="center">Serviço</th>
				<th align="center">Situação</th>
				<th align="center" style="width: 70px;"></th>
			</tr>
			<c:set var="evenorodd" value="" />
			<c:set var="tamanho" value="0" />

			<c:forEach var="configuracao" items="${listConfig}">		
				<tr class="${evenorodd}">				
					<td><c:if test="${not empty configuracao.exNivelAcesso}">${configuracao.exNivelAcesso.nmNivelAcesso}(${configuracao.exNivelAcesso.grauNivelAcesso})</c:if></td>
					<td><c:if test="${not empty configuracao.dpPessoa}">
						<siga:selecionado sigla="${configuracao.dpPessoa.iniciais}"
							descricao="${configuracao.dpPessoa.descricao}" />
					</c:if></td>
					<td><c:if test="${not empty configuracao.lotacao}">
						<siga:selecionado sigla="${configuracao.lotacao.sigla}"
							descricao="${configuracao.lotacao.descricao}" />
					</c:if></td>
					<td><c:if test="${not empty configuracao.funcaoConfianca}">${configuracao.funcaoConfianca.nomeFuncao}</c:if></td>
					<td><c:if test="${not empty configuracao.orgaoUsuario}">${configuracao.orgaoUsuario.acronimoOrgaoUsu}</c:if></td>
					<td><c:if test="${not empty configuracao.orgaoObjeto}">${configuracao.orgaoObjeto.acronimoOrgaoUsu}</c:if></td>
					<td><c:if test="${not empty configuracao.cargo}">${configuracao.cargo.nomeCargo}</c:if></td>
					<td><c:if test="${not empty configuracao.exTipoMovimentacao}">${configuracao.exTipoMovimentacao.descrTipoMovimentacao}</c:if></td>
					<td><c:if test="${not empty configuracao.exVia}">${configuracao.exVia.exTipoDestinacao}(${configuracao.exVia.codVia})</c:if></td>
					<td><c:if test="${not empty configuracao.exModelo}">${configuracao.exModelo.nmMod}</c:if></td>
					<td><c:if test="${not empty configuracao.exClassificacao}">${configuracao.exClassificacao.classificacaoAtual.codificacao}</c:if></td>
					<td><c:if test="${not empty configuracao.exTipoFormaDoc}">${configuracao.exTipoFormaDoc.descTipoFormaDoc}</c:if></td>
					<td><c:if test="${not empty configuracao.exFormaDocumento}">${configuracao.exFormaDocumento.descrFormaDoc}</c:if></td>
					<td><c:if test="${not empty configuracao.exTipoDocumento}">${configuracao.exTipoDocumento.descrTipoDocumento}</c:if></td>
					<td><c:if test="${not empty configuracao.exPapel}">${configuracao.exPapel.descPapel}</c:if></td>
					<td><c:if test="${not empty configuracao.cpServico}">${configuracao.cpServico.dscServico}</c:if></td>
					<td><c:if
						test="${not empty configuracao.cpSituacaoConfiguracao}">${configuracao.cpSituacaoConfiguracao.dscSitConfiguracao}</c:if></td>
					<td>
					<c:if
						test="${not empty nmTipoRetorno}">
						<ww:url id="url" action="editar"
							namespace="/expediente/configuracao">
							<ww:param name="id">${configuracao.idConfiguracao}</ww:param>
							<ww:param name="idMod">${idMod}</ww:param>
							<ww:param name="nmTipoRetorno">${nmTipoRetorno}</ww:param>
							<ww:param name="campoFixo">${campoFixo}</ww:param>
						</ww:url> 
					</c:if>
					<c:if
						test="${empty nmTipoRetorno}">
						<ww:url id="url" action="editar"
							namespace="/expediente/configuracao">
							<ww:param name="id">${configuracao.idConfiguracao}</ww:param>
						</ww:url> 
					</c:if>
					<siga:links estilo="margin-bottom: 0; text-align: center;">					
					<siga:link icon="pencil" titleImg="Alterar" url="${url}" estilo="margin-bottom: 0; text-align: center; padding: 2px;"/>				
					
					<c:if
						test="${not empty nmTipoRetorno}">
						<ww:url id="urlExcluir" action="excluir" namespace="/expediente/configuracao">
							<ww:param name="id">${configuracao.idConfiguracao}</ww:param>
							<ww:param name="idMod">${idMod}</ww:param>
							<ww:param name="idFormaDoc">${idFormaDoc}</ww:param>
							<ww:param name="nmTipoRetorno">${nmTipoRetorno}</ww:param>
		                </ww:url>	
	                </c:if>				
					<c:if
						test="${empty nmTipoRetorno}">
						<ww:url id="urlExcluir" action="excluir" namespace="/expediente/configuracao">
							<ww:param name="id">${configuracao.idConfiguracao}</ww:param>
		                </ww:url>	
	                </c:if>				

					<siga:link icon="delete" titleImg="Excluir" url="${urlExcluir}" 
							popup="excluir" confirm="Deseja excluir configuração?" />				
					</siga:links>					
			
			     </td>	
				</tr>					
				<c:choose>
					<c:when test='${evenorodd == "even"}'>
						<c:set var="evenorodd" value="odd" />
					</c:when>
					<c:otherwise>
						<c:set var="evenorodd" value="even" />
					</c:otherwise>
				</c:choose>
				<c:set var="tamanho" value="${tamanho + 1 }" />			
			</c:forEach>
<!-- 			
			<tr class="footer">
				<td colspan="8">Total Listado: ${tamanho}</td>
			</tr>
 -->			
		</table>
		</div>
		
	</div>	

