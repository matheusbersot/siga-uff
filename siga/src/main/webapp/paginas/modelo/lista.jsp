<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="32kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%-- pageContext.setAttribute("sysdate", new java.util.Date()); --%>

<link rel="stylesheet" href="/siga/codemirror/lib/codemirror.css">
<script src="/siga/codemirror/lib/codemirror.js"></script>
<script src="/siga/codemirror/lib/overlay.js"></script>
<script src="/siga/codemirror/mode/xml/xml.js"></script>
<script src="/siga/codemirror/mode/javascript/javascript.js"></script>
<script src="/siga/codemirror/mode/css/css.js"></script>
<link rel="stylesheet" href="/siga/codemirror/theme/default.css">
<script src="/siga/codemirror/mode/htmlmixed/htmlmixed.js"></script>
<!--<link rel="stylesheet" href="/siga/codemirror/css/docs.css"> -->

<style type="text/css">
.CodeMirror {
	border: 1px solid #eee;
}

.activeline {
	background: #f7f7f7 !important;
}

.CodeMirror-scroll {
	height: auto;
	overflow-y: hidden;
	overflow-x: auto;
}

.cm-freemarker-cmd {
	color: navy;
	font-bold: yes;
}

.cm-freemarker-mac {
	color: darkmagenta;
	font-bold: yes;
}

.cm-freemarker-exp {
	color: saddlebrown;
	font-bold: yes;
}
</style>

<script>
function sbmt(id, action) {
	var frm = document.getElementById(id);
	frm.action=action;
	frm.submit();
	return;
}

CodeMirror.defineMode("freemarker", function(config, parserConfig) {
  var freemarkerOverlay = {
	token: function(stream, state) {
	  if (stream.match("[#") || stream.match("[/#")) {
		while ((ch = stream.next()) != null)
		  if (ch == "]") break;
		return "freemarker-cmd";
	  }
	  if (stream.match("[@") || stream.match("[/@")) {
		while ((ch = stream.next()) != null)
		  if (ch == "]") break;
		return "freemarker-mac";
	  }
	  if (stream.match("\${")) {
		while ((ch = stream.next()) != null)
		  if (ch == "}") break;
		return "freemarker-exp";
	  }
	  while (stream.next() != null && !(stream.match("[", false) || stream.match("\${", false))) {}
	  return null;
	}
  };
  return CodeMirror.overlayParser(CodeMirror.getMode(config, parserConfig.backdrop || "text/html"), freemarkerOverlay);
});
</script>

<siga:pagina titulo="Lista de Modelos">
	<div class="gt-bd clearfix">
		<div class="gt-content">
			<c:set var="i" value="${0}" />
			<c:forEach var="modelo" items="${itens}">
				<c:set var="i" value="${i+1}" />
				<h3 class="gt-form-head">
					<c:if test="${not empty modelo.cpOrgaoUsuario}">Orgão Usuário: ${modelo.cpOrgaoUsuario.descricao}</c:if>
					<c:if test="${empty modelo.cpOrgaoUsuario}">Edição de Modelos: GERAL</c:if>
				</h3>
				<div class="gt-form gt-content-box">
					<form id="editar_${i}" name="editar_${i}"
						action="/siga/modelo/editar_gravar.action" method="POST">
						<div class="gt-form-row">
							<ww:hidden name="id" value="${modelo.id}" />
							<ww:hidden name="idOrgUsu" value="${modelo.cpOrgaoUsuario.id}" />

							<textarea id="conteudo${i}" style="width: 100%;" cols="1" rows="1" name="conteudo"><c:if test="${not empty modelo.conteudoBlobString}"><ww:property value="#attr.modelo.conteudoBlobString" escape="true" default="" /></c:if></textarea>
<script>
	var editor${i} = CodeMirror.fromTextArea(document.getElementById("conteudo${i}"), {mode: "freemarker", tabMode: "indent", lineNumbers: true,
		onCursorActivity: function() {
			editor${i}.setLineClass(hlLine, null);
			hlLine = editor${i}.setLineClass(editor${i}.getCursor().line, "activeline");
		}});
	var hlLine = editor${i}.setLineClass(0, "activeline");
</script>
						</div>
						<div class="gt-form-row">
							<input name="salvar_conteudo" type="submit" id="but_gravar${i}"
								value="Salvar"
								onclick="javascript: this.form.action='/siga/modelo/editar_gravar.action'; "
								class="gt-btn-medium gt-btn-left" />
						</div>
						<!-- 				
				<td><span id="desc_ver${i}">
					<c:if test="${not empty modelo.conteudoBlobString}">
						<pre><ww:property  value="#attr.modelo.conteudoBlobString" escape="true" default=""/></pre>
					</c:if>
				</span> 
				<c:if test="${true}">
					<span id="desc_editar${i}" style="display: none"><textarea
						cols="80" rows="40" name="conteudo"><c:if test="${not empty modelo.conteudoBlobString}"><ww:property  value="#attr.modelo.conteudoBlobString" escape="true" default=""/></c:if></textarea></span>
				</c:if>
 				</td>
			</tr>
			<c:if test="${true}">
				<tr>
					<td><input name="editar_conteudo" type="button" value="Editar"
						id="but_editar${i}"
						onclick="javascript: document.getElementById('desc_ver'+${i}).style.display='none'; document.getElementById('desc_editar'+${i}).style.display=''; document.getElementById('but_editar'+${i}).style.display='none'; document.getElementById('but_gravar'+${i}).style.display=''; " />
					<input name="salvar_conteudo" type="submit" id="but_gravar${i}"
						value="Salvar" style="display: none"
						onclick="javascript: this.form.action='/siga/modelo/editar_gravar.action'; " /></td>
				</tr>
			</c:if>
-->
					</form>
				</div>
			</c:forEach>

		</div>
	</div>
</siga:pagina>
