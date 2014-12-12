<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<!-- este modelo trata de
REQUERIMENTO PARA INSCRICAO NO AUXILIO SAUDE-->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="seben" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		</br>
		<mod:selecao titulo="Tipos de Inclus�o" var="tipoDeInclusao"
			opcoes="Exclusivamente de Titular;De Titular e de seus Dependentes Diretos;Exclusivamente de Dependentes Diretos"
			reler="sim" />
		<c:if
			test="${tipoDeInclusao == 'De Titular e de seus Dependentes Diretos' || tipoDeInclusao == 'Exclusivamente de Dependentes Diretos'}">
			<span><b>(A inscri��o de dependentes somente poder� ser
			feita se o servidor for inscrito como titular no referido benef�cio e
			somente ele poder� efetiv�-la)</b></span>
		</c:if>
		<%--<mod:grupo titulo="Tipos de Inclus�o">
			<mod:radio var="tipoDeInclusao" valor="1" reler="sim" marcado="sim" titulo="Exclusivamente de Titular"/>
			<mod:radio var="tipoDeInclusao" valor="2" reler="sim" titulo="De Titular e de seus Dependentes Diretos (A inscri��o de dependentes somente poder� ser feita se o servidor for inscrito como titular no referido benef�cio e somente ele poder� efetiv�-la)"/>
			<mod:radio var="tipoDeInclusao" valor="3" reler="sim" titulo="Exclusivamente de Dependentes Diretos (A inscri��o de dependentes somente poder� ser feita se o servidor for inscrito como titular no referido benef�cio e somente ele poder� efetiv�-la)"/>
		</mod:grupo>--%>
		<c:if
			test="${tipoDeInclusao == 'Exclusivamente de Titular' || tipoDeInclusao == 'De Titular e de seus Dependentes Diretos'}">
			<br />
			<mod:grupo titulo="Dados do Titular">
				<mod:grupo>
					<mod:pessoa titulo="Matr�cula" var="matriculaTitular" reler="sim" />
				</mod:grupo>
				<mod:grupo>
					<mod:data titulo="Data do exerc�cio" var="dataExercicio" />
					<mod:data titulo="Data de nascimento" var="dataNascimentoTitular" />
					<mod:selecao titulo="Sexo" opcoes="M;F" var="sexoTitular" />
					<mod:selecao titulo="Estado Civil" var="estadoCivilTitular"
						opcoes="Solteiro(a);Casado(a);Divorciado(a);Vi�va(o);Desquitado"
						reler="sim" />
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="Plano de sa�de a qual est� vinculado"
						var="plano" largura="30" />
					<mod:selecao
						titulo="Todos os dependentes pertencem ao mesmo plano?"
						var="pertence" opcoes="Sim;N�o" reler="sim" />
				</mod:grupo>
				<mod:grupo>
					<mod:selecao titulo="Data de vig�ncia" var="mesVigencia"
						opcoes="Janeiro;Fevereiro;Mar�o;Abril;Maio;Junho;Julho;Agosto;Setembro;Outubro;Novembro;Dezembro" />
					<mod:texto titulo="Ano" var="anoVigencia" largura="6"
						maxcaracteres="4" reler="ajax" idAjax="anoAjax" />
					<mod:grupo depende="anoAjax">
						<c:if test="${empty anoVigencia}">
							<mod:mensagem titulo="Alerta"
								texto="o ano de Vig�ncia deve ser preenchido." vermelho="sim" />
						</c:if>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>
		</c:if>
		<c:if
			test="${tipoDeInclusao == 'De Titular e de seus Dependentes Diretos' || tipoDeInclusao == 'Exclusivamente de Dependentes Diretos'}">
			<br />
			<mod:grupo titulo="Dados Dos Dependentes Diretos">
				<mod:selecao titulo="N�mero total a incluir no Aux�lilo-Sa�de"
					var="totalDeDependentes" opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
				<c:forEach var="i" begin="1" end="${totalDeDependentes}">
					<mod:grupo>
						<mod:selecao titulo="Parentesco" var="parentesco${i}"
							opcoes="C�njuge;Filhos Menores De 21 Anos;Filhos Entre 21 e 24 Anos;Filho Maior, Inv�lido;Companheiro(A);Enteado(A) - Filho De C�njuge, Menor De 21 Anos;Enteado(A) - Filho De C�njuge, Entre 21 e 24 Anos;Enteado(A) - Filho de c�njuge, maior inv�lido;Enteado(A) - Filho de Companheiro, menor de 21 anos;Enteado(A) - Filho de Companheiro, entre 21 e 24 anos;Enteado(A) - Filho de Companheiro, maior inv�lido;Menor Sob Guarda Ou Tutela"
							reler="sim" />
					</mod:grupo>
					<mod:grupo>
						<mod:texto titulo="Nome" var="nomeDependente${i}" largura="59" />
						<mod:selecao titulo="Sexo" opcoes="M;F" var="sexoDependente${i}" />
						<mod:data titulo="Data de Nascimento"
							var="dataNascimentoDependente${i}" />
					</mod:grupo>
					<mod:grupo>
						<c:if test="${pertence == 'N�o'}">
							<mod:grupo>
								<mod:texto titulo="Plano de Sa�de" var="planoDep${i}"
									largura="30" />
							</mod:grupo>
						</c:if>
					</mod:grupo>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Filhos Menores De 21 Anos'}">
						<mod:grupo>
							<mod:selecao titulo="Dependente econ�mico"
								var="dependenteEconomico${i}" opcoes="Sim;N�o" />
							<mod:selecao titulo="Solteiro" var="solteiro${i}"
								opcoes="Sim;N�o" />
							<mod:selecao titulo="Estudante" var="estudante${i}"
								opcoes="Sim;N�o" />
							<mod:selecao titulo="Reside em sua companhia"
								var="resideCompanhia${i}" opcoes="Sim;N�o" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Filhos Entre 21 e 24 Anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Filho Maior, Inv�lido'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio titulo="N�o" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Companheiro(A)'}">
						<mod:selecao titulo="Estado Civil" var="estadoCivilDep${i}"
							opcoes="Solteiro(a);Casado(a);Divorciado(a);Vi�va(o);Desquitado"
							reler="sim" />
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho De C�njuge, Menor De 21 Anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho De C�njuge, Entre 21 e 24 Anos'}">
						<mod:texto titulo="N� do Cart�o do Aux�lio-Sa�de"
							var="numeroCartaoAuxSau${i}" largura="59" />
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de c�njuge, maior inv�lido'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de Companheiro, menor de 21 anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de Companheiro, entre 21 e 24 anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de Companheiro, maior inv�lido'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"
								marcado="Sim" valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="solteiro${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}" marcado="Sim"
								valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}" marcado="Sim"
								valor="1" />
							<mod:radio
								titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)"
								var="resideCompanhia${i}" valor="2" />
						</mod:grupo>
					</c:if>
					<c:if
						test="${requestScope[f:concat('parentesco',i)] == 'Menor Sob Guarda Ou Tutela'}">
					</c:if>
				</c:forEach>
			</mod:grupo>
		</c:if>
		<mod:grupo>
			<mod:caixaverif
				titulo="Estou ciente de que devo enviar a documenta��o exigida"
				var="documentacaoExigida" reler="N�o" />
			<a
				href="${pageContext.request.contextPath}/arquivos_estaticos/TabelaDocumentacaoAuxilioSaude.htm"
				target="_blank"> <b> &nbsp; &rarr; Visualizar Documenta��o
			Exigida </b></a>
		</mod:grupo>
		<mod:grupo>
			<mod:caixaverif titulo="Declaro que estou ciente:"
				var="declaracaoCiente" reler="N�o" />
			<p>- dos termos da Resolu��o n� 02/2008 do CJF e do despacho
			exarado pelo Exmo. Presidente do TRF em janeiro de 2009 e divulgado
			por correio eletr�nico institucional em 04/03/2009.</p>
			<p>- de que a inclus�o solicitada somente ser�
			processada/efetivada mediante o envio imediato � SEBEN da
			documenta��o requerida. Caso a documenta��o n�o chegue at� � referida
			Se��o at� o �ltimo dia do m�s pretendido, dever� ser feita outra
			solicita��o com nova data de vig�ncia.</p>
			<p>- de que o(s) benefici�rio(s) relacionado(s) n�o recebe(m)
			aux�lio semelhante e nem participa(m) de outro programa de
			assist�ncia � sa�de, custeado pelos cofres p�blicos, ainda que em
			parte;</p>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>


		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0"  bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
				<br/><br/>
					<table width="100%" border="0" >
						<tr>
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;" >INSCRI&Ccedil;&Atilde;O NO AUX&Iacute;LIO SA&Uacute;DE </p></td>
						</tr>
				<tr><td></td>
				</tr>
				<tr><td></td>
				</tr>
				<tr><td></td>
				</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->

				<br />
	

		<p style="TEXT-INDENT: 2cm" align="justify">
		${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).nomePessoa},
		matr�cula n�
		${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).matricula},
		lotado no(a)
		${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).lotacao.descricao},
		vem requerer <c:choose>
			<c:when test="${tipoDeInclusao == 'Exclusivamente de Titular'}">					
					sua inclus�o no Aux�lio-Sa�de, a partir de m�s de ano.
				</c:when>
			<c:when
				test="${tipoDeInclusao == 'De Titular e de seus Dependentes Diretos'}">					
					sua inclus�o e a inclus�o dos dependentes diretos abaixo relacionados:
				</c:when>
			<c:otherwise>
					a inclus�o dos dependentes diretos abaixo relacionados: 
				</c:otherwise>
		</c:choose> no Aux�lio-Sa�de, a partir de ${mesVigencia} de ${anoVigencia}.</p>
		<br />
				<br />

		<c:if
			test="${tipoDeInclusao == 'De Titular e de seus Dependentes Diretos' || tipoDeInclusao == 'Exclusivamente de Titular'}">
			<table width="100%" height="90px" border="1" cellpadding="2"
				cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" height="30px" colspan="2" align="left"><b>1.
					Dados do Titular</b></td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" width="50%" height="30px" align="left"><b>Data
					do exerc�cio:</b> ${dataExercicio}</td>
					<td bgcolor="#FFFFFF" width="50%" height="30px" align="left"><b>Data
					de Nascimento:</b> ${dataNascimentoTitular}</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" height="30px" align="left"><b>Estado
					Civil:</b> ${estadoCivilTitular}</td>
					<td width="20%" bgcolor="#FFFFFF" colspan="2" align="left"><b>Plano:</b>
					${plano}</td>
				</tr>
			</table>
			<br />
		</c:if>


		<c:if
			test="${tipoDeInclusao == 'De Titular e de seus Dependentes Diretos' || tipoDeInclusao == 'Exclusivamente de Dependentes Diretos' }">
			<table width="100%" height="90px" border="1" cellpadding="2"
				cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" height="30px" align="left" colspan="2"><b>2.
					Dados dos Dependentes Diretos</b></td>
				</tr>
				<c:forEach var="i" begin="1" end="${totalDeDependentes}">
					<tr>
						<td bgcolor="#FFFFFF" height="30px" colspan="2" align="left"
							style="background-color: #D3D3D3"><b>2.${i}. Nome:
						${requestScope[f:concat('nomeDependente',i)]}</b></td>
					</tr>
					<tr>
						<td bgcolor="#FFFFFF" width="50%" height="30px" align="left"><b>Data
						de Nascimento:</b>
						${requestScope[f:concat('dataNascimentoDependente',i)]}</td>
						<td bgcolor="#FFFFFF" width="50%" height="30px" align="left"><b>Parentesco/Condi��o:</b>
						${requestScope[f:concat('parentesco',i)]}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFFF" height="30px" align="left"><b>Estado
						Civil:</b> ${requestScope[f:concat('estadoCivilDep',i)]}</td>
						<c:if test="${pertence == 'N�o'}">
							<td width="20%" bgcolor="#FFFFFF" colspan="2" align="left"><b>Plano:</b>
							${requestScope[f:concat('planoDep',i)]}</td>
						</c:if>
						<c:if test="${pertence == 'Sim'}">
							<td width="20%" bgcolor="#FFFFFF" colspan="2" align="left"><b>Plano:</b>
							${plano}</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</c:if>

		<c:if test="${declaracaoCiente == 'Sim'}">
			<p>Declara que:</p>

			<p align="justify">- dos termos da Resolu��o n� 02/2008 do CJF e
			do despacho exarado pelo Exmo. Presidente do TRF em janeiro de 2009 e
			divulgado por correio eletr�nico institucional em 04/03/2009.</p>

			<p align="justify">- de que a inclus�o solicitada somente ser�
			processada/efetivada mediante o envio imediato � SEBEN da
			documenta��o requerida. Caso a documenta��o n�o chegue at� � referida
			Se��o at� o �ltimo dia do m�s pretendido, dever� ser feita outra
			solicita��o com nova data de vig�ncia.</p>

			<p align="justify">- de que o(s) benefici�rio(s) relacionado(s)
			n�o recebe(m) aux�lio semelhante e nem participa(m) de outro programa
			de assist�ncia � sa�de, custeado pelos cofres p�blicos, ainda que em
			parte;</p>
		</c:if>

		<c:if test="${documentacaoExigida == 'Sim'}">
			<p align="justify">firma o seguinte compromisso: <b>Declara
			estar ciente de que tais documentos devem ser apresentados,
			impreterivelmente, at� o pedido de vac�ncia.</b></p>
		</c:if>

		<c:forEach var="i" begin="1" end="${totalDeDependentes}">
			<c:if
				test="${tipoDeInclusao == 'De Titular e de seus Dependentes Diretos' || tipoDeInclusao == 'Exclusivamente de Dependentes Diretos' }">

				<c:if
					test="${requestScope[f:concat('parentesco',i)] != 'C�njuge' && requestScope[f:concat('parentesco',i)] != 'Filhos Menores De 21 Anos'}">

					<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />

					<p style="font-family: Arial; font-size: 11pt; font-weight: bold;"
						align="center">DECLARA&Ccedil;&Atilde;O</p>
				<br />
					<p align="justify" style="TEXT-INDENT: 2cm">
					${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).nomePessoa},
					matr�cula n�
					${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).matricula},
					lotado no(a)
					${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).lotacao.descricao},
					declara, sob as penas da lei, a fim de fazer prova perante o
					Aux�lio-Sa�de da SJRJ, que
					${requestScope[f:concat('nomeDependente',i)]} permanece na condi��o
					de solteiro(a), estudante, reside em sua companhia e que vive sob
					sua depend�ncia econ�mica.</p>
				<br />
				<br />
					<p align="center">${doc.dtExtenso}</p>
					<c:import
						url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
					<p align="center">
					RJ${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).matricula}
					</p>

				</c:if>
			</c:if>
		</c:forEach>


	</mod:documento>
</mod:modelo>

