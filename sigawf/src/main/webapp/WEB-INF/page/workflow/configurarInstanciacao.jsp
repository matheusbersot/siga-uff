<%@ include file="/WEB-INF/page/include.jsp"%><!--  -->

<script type="text/javascript">
	function solicitarInformacao(tarefa) {

		var objSelecionado = document.getElementById('tipoResponsavel_'
				+ tarefa);

		document.getElementById('formulario_lotacao_' + tarefa
				+ '_lotacaoSel_id').value = "";
		document.getElementById('formulario_matricula_' + tarefa
				+ '_pessoaSel_id').value = "";

		document.getElementById('formulario_lotacao_' + tarefa
				+ '_lotacaoSel_sigla').value = "";
		document.getElementById('formulario_matricula_' + tarefa
				+ '_pessoaSel_sigla').value = "";

		document.getElementById('formulario_lotacao_' + tarefa
				+ '_lotacaoSel_descricao').value = "";
		document.getElementById('formulario_matricula_' + tarefa
				+ '_pessoaSel_descricao').value = "";

		switch (objSelecionado.selectedIndex) {

		//N�o Definido
		case 0:
			break;
		//Matr�cula
		case 1:
			var tipo = "matricula";
			break;
		//Lota��o	
		case 2:
			var tipo = "lotacao";
			break;
		}

		var div = tipo + '_' + tarefa;
		document.getElementById('lotacao_' + tarefa).style.display = "none";
		document.getElementById('matricula_' + tarefa).style.display = "none";

		if (document.getElementById(div) != null) {
			document.getElementById(div).style.display = "inline"
		}
	}

	<ww:url id="url" action="gravarConfiguracao"></ww:url>
	function gravarConfiguracao() {
		var frm = document.getElementById("formulario");
		frm.action = '<ww:property value="%{url}"/>';
		frm.submit();
	}

	<ww:url id="url" action="pesquisarConfiguracao" />
	function pesquisarProcedimento() {
		var frm = document.getElementById("formulario");
		frm.action = '<ww:property value="%{url}"/>';
		frm.submit();
	}
</script>

<siga:pagina
	titulo="Configura��o de Permiss�es para Instacia��o de Procedimentos">
	<div class="gt-bd clearfix">
		<div class="gt-content clearfix">
			<h2>Configura��o de Permiss�o para Instanciar Procidimento</h2>
			<div class="gt-content-box gt-for-table">
				<ww:form id="formulario" action="" method="POST" cssClass="form">
					<ww:hidden name="procedimento" value="${procedimento}" />
					<ww:hidden name="orgao" value="${orgao}" />
					<table class="gt-form-table">
						<tr class="header">
							<td colspan="2">Dados da Configura��o</td>
						</tr>
						<tr>
							<td>�rg�o:</td>
							<td>${orgao}</td>
						</tr>
						<tr class="header">
							<ww:label name="Procedimento" label="Procedimento"
								value="${procedimento}" />
						</tr>
					</table>
					<table class="gt-form-table" style="table-layout: fixed;">
						<c:if test="${not empty listaPermissao}">
							<tr class="header">
								<td width="100%">Permiss�o para Instanciar Procidimento
									concedida para:</td>
							</tr>

							<!-- permissoes -->

							<c:forEach var="p" items="${listaPermissao}">
								<tr>
									<c:choose>
										<c:when test="${not empty p.lotacao}">
											<td><ww:select id="tipoResponsavel_${p.id}"
													name="tipoResponsavel_${p.id}" list="listaTipoResponsavel"
													theme="simple" listValue="Texto" listKey="id"
													value="${p.tipoResponsavel}"
													onchange="javascript:solicitarInformacao('${p.id}');" />
										</c:when>
										<c:when test="${not empty p.pessoa}">
											<td><ww:select id="tipoResponsavel_${p.id}"
													name="tipoResponsavel_${p.id}" list="listaTipoResponsavel"
													theme="simple" listValue="Texto" listKey="id"
													value="${p.tipoResponsavel}"
													onchange="javascript:solicitarInformacao('${p.id}');" />
										</c:when>
									</c:choose>

									<c:choose>
										<c:when test="${p.tipoResponsavel == 1}">
											<!-- MATR�CULA -->
											<div style="display: none;" id="lotacao_${p.id}">
												<siga:selecao modulo="../sigaex" tipo="lotacao"
													tema="simple" propriedade="lotacao_${p.id}"
													siglaInicial="${p.lotacao.sigla}"
													idInicial="${p.lotacao.id}"
													descricaoInicial="${p.lotacao.descricao}" />
											</div>
											<div style="display: inline;" id="matricula_${p.id}">
												<siga:selecao modulo="../sigaex" tipo="pessoa" tema="simple"
													propriedade="matricula_${p.id}"
													siglaInicial="${p.pessoa.sigla}" idInicial="${p.pessoa.id}"
													descricaoInicial="${p.pessoa.descricao}" />
											</div>
										</c:when>
										<c:when test="${p.tipoResponsavel == 2}">
											<!-- LOTA��O -->
											<div style="display: inline;" id="lotacao_${p.id}">
												<siga:selecao modulo="../sigaex" tipo="lotacao"
													tema="simple" propriedade="lotacao_${p.id}"
													siglaInicial="${p.lotacao.sigla}"
													idInicial="${p.lotacao.id}"
													descricaoInicial="${p.lotacao.descricao}" />
											</div>
											<div style="display: none;" id="matricula_${p.id}">
												<siga:selecao modulo="../sigaex" tipo="pessoa" tema="simple"
													propriedade="matricula_${p.id}"
													siglaInicial="${p.pessoa.sigla}" idInicial="${p.pessoa.id}"
													descricaoInicial="${p.pessoa.descricao}" />
											</div>
										</c:when>
									</c:choose>


									</td>

								</tr>

							</c:forEach>
						</c:if>
						<tr class="header">
							<td>Nova configura��o</td>
						</tr>

						<tr>
							<td><ww:select id="tipoResponsavel_${idNovaPermissao}"
									name="tipoResponsavel_${idNovaPermissao}"
									list="listaTipoResponsavel" theme="simple"
									onchange="javascript:solicitarInformacao('${idNovaPermissao}');" />
								<div style="display: none;" id="lotacao_${idNovaPermissao}">
									<siga:selecao modulo="../sigaex" tipo="lotacao" tema="simple"
										propriedade="lotacao_${idNovaPermissao}" />
								</div>
								<div style="display: none;" id="matricula_${idNovaPermissao}">
									<siga:selecao modulo="../sigaex" tipo="pessoa" tema="simple"
										propriedade="matricula_${idNovaPermissao}" />
								</div>
							</td>
						</tr>
						<tr>
							<td align="right" width="100%"><input type="button"
								value="Gravar" name="gravar"
								onclick="javascript:gravarConfiguracao()"
								class="gt-btn-medium gt-btn-left" /></td>
						</tr>
					</table>
				</ww:form>
			</div>
		</div>
	</div>
</siga:pagina>


