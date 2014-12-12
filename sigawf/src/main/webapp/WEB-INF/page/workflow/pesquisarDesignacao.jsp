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
		//Lota��o superior	
		case 3:
			break;
			//Superior hier�rquico	
		case 4:
			break;
			//Express�o	
		case 5:
			var tipo = "expressao";
			break;
		}

		var div = tipo + '_' + tarefa;
		document.getElementById('lotacao_' + tarefa).style.display = "none";
		document.getElementById('matricula_' + tarefa).style.display = "none";
		document.getElementById('expressao_' + tarefa).style.display = "none";

		if (document.getElementById(div) != null) {
			document.getElementById(div).style.display = "inline"
		}
	}

	<ww:url id="url" action="gerarRelatorioDesignacao" ></ww:url>
	function gerarRelatorio() {
		var frm = document.getElementById("formulario");
		frm.action = '<ww:property value="%{url}"/>';
		frm.submit();
	}

	<ww:url id="url" action="gravarDesignacao"></ww:url>
	function gravarResponsabilidade() {
		var frm = document.getElementById("formulario");
		frm.action = '<ww:property value="%{url}"/>';
		frm.submit();
	}

	<ww:url id="url" action="pesquisarDesignacao" />
	function pesquisarProcedimento() {
		var frm = document.getElementById("formulario");
		frm.action = '<ww:property value="%{url}"/>';
		frm.submit();
	}
</script>

<siga:pagina titulo="Defini��o de Responsabilidades">
	<div class="gt-bd clearfix">
		<div class="gt-content clearfix">
			<h2>Defini��o de Responsabilidades</h2>
			<h4>Sele��o de �rg�o e Procedimento</h4>
			<div class="gt-content-box gt-for-table">
				<ww:form id="formulario" action="" method="POST" cssClass="form">

					<table class="gt-form-table">
						<tr>
							<ww:select label="�rg�o" name="orgao" list="listaOrgao"
								listValue="AcronimoOrgaoUsu" listKey="AcronimoOrgaoUsu"
								multiple="false" />
							<ww:select label="Procedimento" name="procedimento"
								list="listaProcedimento" listValue="Name" listKey="Name"
								multiple="false" />
						</tr>
						<tr>
							<td colspan="2"><input type="button" value="Pesquisar"
								onclick="javascript:pesquisarProcedimento()"
								class="gt-btn-medium gt-btn-left" />
							</td>
						</tr>
					</table>
			</div>

			<br />
			<h4>Responsabilidades</h4>
			<div class="gt-content-box gt-for-table">
				<table class="gt-form-table" style="table-layout: fixed;">
					<tr class="header">
						<td width="10%">Raia</td>
						<td width="30%">Tarefa (Nome do n�)</td>
						<td width="60%">Respons�vel</td>
					</tr>

					<!-- raias -->

					<c:forEach var="r" items="${listaDesignacaoRaia}">

						<c:if test="${not empty r.id}">
							<c:set var="idRaia" value="${r.id}" />
						</c:if>

						<c:if test="${not empty r.tipoResponsavel}">
							<c:set var="tipoResponsavel" value="${r.tipoResponsavel}" />
						</c:if>

						<ww:set name="raiaProcessada"
							value="%{isRaiaProcessada('${r.raia}')}" />

						<c:if test="${not empty r.raia and not raiaProcessada}">

							<tr>
								<td>${r.raia}</td>

								<td><c:forEach var="d" items="${listaDesignacaoRaia}">
										<c:if test="${d.raia == r.raia}">
											<span style="cursor: help;" title="${d.nomeDoNo}">${d.tarefa}</span>
											<br />
										</c:if>
									</c:forEach></td>

								<td><ww:select id="tipoResponsavel_${idRaia}"
										name="tipoResponsavel_${idRaia}" list="listaTipoResponsavel"
										theme="simple" listValue="Texto" listKey="id"
										value="${tipoResponsavel}"
										onchange="javascript:solicitarInformacao('${idRaia}');" />
									<div
										style="display: ${(tipoResponsavel == 1) ? 'inline' : 'none'};"
										id="matricula_${idRaia}">
										<siga:selecao modulo="../sigaex" tipo="pessoa" tema="simple"
											propriedade="matricula_${idRaia}"
											siglaInicial="${r.ator.sigla}" idInicial="${r.ator.id}"
											descricaoInicial="${r.ator.descricao}" />
									</div>
									<div
										style="display: ${(tipoResponsavel == 2) ? 'inline' : 'none'};"
										id="lotacao_${idRaia}">
										<siga:selecao modulo="../sigaex" tipo="lotacao" tema="simple"
											propriedade="lotacao_${idRaia}"
											siglaInicial="${r.lotaAtor.sigla}"
											idInicial="${r.lotaAtor.id}"
											descricaoInicial="${r.lotaAtor.descricao}" />
									</div>
									<div
										style="display: ${(tipoResponsavel == 5) ? 'inline' : 'none'};"
										id="expressao_${idRaia}">
										<input type="text" width="200" name="expressao_${idRaia}"
											value="${r.expressao}" />
									</div>
								</td>

							</tr>

						</c:if>
						<c:set var="tipoResponsavel" value="" />
						<c:set var="idRaia" value="" />
					</c:forEach>

					<!-- tarefas -->
					<c:forEach var="dTarefa" items="${listaDesignacaoTarefa}">
						<tr>
							<td>${dTarefa.raia}</td>
							<td><span style="cursor: help;" title="${dTarefa.nomeDoNo}">${dTarefa.tarefa}</span>
							</td>

							<td><ww:select id="tipoResponsavel_${dTarefa.id}"
									name="tipoResponsavel_${dTarefa.id}"
									list="listaTipoResponsavel" theme="simple" listValue="Texto"
									listKey="id" value="${dTarefa.tipoResponsavel}"
									onchange="javascript:solicitarInformacao('${dTarefa.id}');" />
								<div
									style="display: ${(dTarefa.tipoResponsavel == 1) ? 'inline' : 'none'};"
									id="matricula_${dTarefa.id}">
									<siga:selecao modulo="../sigaex" tipo="pessoa" tema="simple"
										propriedade="matricula_${dTarefa.id}"
										siglaInicial="${dTarefa.ator.sigla}"
										idInicial="${dTarefa.ator.id}"
										descricaoInicial="${dTarefa.ator.descricao}" />
								</div>
								<div
									style="display: ${(dTarefa.tipoResponsavel == 2) ? 'inline' : 'none'};"
									id="lotacao_${dTarefa.id}">
									<siga:selecao modulo="../sigaex" tipo="lotacao" tema="simple"
										propriedade="lotacao_${dTarefa.id}"
										siglaInicial="${dTarefa.lotaAtor.sigla}"
										idInicial="${dTarefa.lotaAtor.id}"
										descricaoInicial="${dTarefa.lotaAtor.descricao}" />
								</div>
								<div
									style="display: ${(dTarefa.tipoResponsavel == 5) ? 'inline' : 'none'};"
									id="expressao_${dTarefa.id}">
									<input type="text" name="expressao_${dTarefa.id}"
										value="${dTarefa.expressao}" />
								</div></td>
						</tr>
					</c:forEach>
					<tr>
						<td align="right" width="90%"><input type="button"
							value="Gravar" onclick="javascript:gravarResponsabilidade()"
							class="gt-btn-medium gt-btn-left" /></td>
						<!-- 
				<td align="right" width="10%"><input type="button"
					value="Gerar Relat�rio" onclick="javascript:gerarRelatorio()" /></td>
				 -->
					</tr>
				</table>
				</ww:form>
			</div>
		</div>
	</div>
</siga:pagina>


