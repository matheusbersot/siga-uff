<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<!-- este modelo trata de
REQUERIMENTO PARA INSCRICAO NO PLANO DE SA�DE-->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="seben" scope="request" />
<c:set var="exibirIncDeferimento" value="n�o" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		</br>
		<mod:grupo titulo="Tipos de Inclus�o">
			<mod:radio var="tipoDeInclusao" valor="1" reler="sim" titulo="Exclusivamente de Titular"/>
			<mod:radio var="tipoDeInclusao" valor="2" reler="sim" gerarHidden='n�o' titulo="De Titular e de seus Dependentes Diretos (A inscri��o de dependentes somente poder� ser feita se o servidor for inscrito como titular no referido benef�cio e somente ele poder� efetiv�-la)"/>
			<mod:radio var="tipoDeInclusao" valor="3" reler="sim" gerarHidden='n�o' titulo="Exclusivamente de Dependentes Diretos (A inscri��o de dependentes somente poder� ser feita se o servidor for inscrito como titular no referido benef�cio e somente ele poder� efetiv�-la)"/>
			<mod:radio var="tipoDeInclusao" valor="4" reler="sim" gerarHidden='n�o' titulo="De Titular e de seus Agregados, Benefici�rios Designados, Pais Dependentes Econ�micos (A inscri��o de dependentes somente poder� ser feita se o servidor for inscrito como titular no referido benef�cio e somente ele poder� efetiv�-la)"/>
			<mod:radio var="tipoDeInclusao" valor="5" reler="sim" gerarHidden='n�o' titulo="Exclusivamente de Agregados, Benefici�rios Designados, Pais Dependentes Econ�micos (A inscri��o de dependentes somente poder� ser feita se o servidor for inscrito como titular no referido benef�cio e somente ele poder� efetiv�-la)"/>
		</mod:grupo>
		<c:set var="valorTipoDeInclusao" value="${tipoDeInclusao}" />
		<c:if test="${empty valorTipoDeInclusao}">
			<c:set var="valorTipoDeInclusao" value="${param['tipoDeInclusao']}" />
		</c:if>
		<c:if test="${valorTipoDeInclusao == 1 || valorTipoDeInclusao == 2 || valorTipoDeInclusao == 4}">
			<br/>
			<mod:grupo titulo="Dados do Titular">
				<mod:grupo>
					<mod:pessoa titulo="Matr�cula" var="matriculaTitular" reler="sim" />
				</mod:grupo>
				<mod:grupo>
					<mod:data titulo="Data do exerc�cio" var="dataExercicio" />
					<mod:data titulo="Data de nascimento" var="dataNascimentoTitular"/>
					<mod:selecao titulo="Sexo" opcoes="M;F" var="sexoTitular" />
					<mod:selecao titulo="Estado Civil" var="estadoCivilTitular" opcoes="Solteiro(a);Casado(a);Divorciado(a);Vi�va(o);Desquitado" reler="sim"/>
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="N� de identidade" var="identidade" largura="15" />
				</mod:grupo>
				<mod:grupo>
					Se estrangeiro(a):
					<mod:texto titulo="N�mero do passaporte" var="passaporte" largura="15" />
					<mod:texto titulo="N�mero da Carteira Civil" var="carteiraCivil" largura="15" />
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="�rg�o Expedidor" var="orgaoExpedidor" largura="20" />
					<mod:data titulo="Data de expedi��o" var="dataExpedicao"/>
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="CPF" var="cpf" largura="15" />
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="N�mero do banco" var="numBanco" largura="5" />
					<mod:texto titulo="Ag�ncia" var="agencia" largura="10" />
					<mod:texto titulo="Conta-corrente" var="contaCorrente" largura="10" />
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="Nome da m�e" var="nomeDaMae" largura="40" />
				</mod:grupo>
				<mod:grupo>
					<mod:selecao titulo="Data de vig�ncia da Inclus�o" var="mesVigencia"
						opcoes="Janeiro;Fevereiro;Mar�o;Abril;Maio;Junho;Julho;Agosto;Setembro;Outubro;Novembro;Dezembro" />
					<mod:texto titulo="Ano" var="anoVigencia" largura="6" maxcaracteres="4"
						reler="ajax" idAjax="anoAjax" />
					<mod:grupo depende="anoAjax">
						<c:if test="${empty anoVigencia}">
							<mod:mensagem titulo="Alerta"
								texto="o ano de Vig�ncia deve ser preenchido." vermelho="sim" />
						</c:if>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>
		</c:if>
		<c:if test="${valorTipoDeInclusao == 2 || valorTipoDeInclusao == 3}">
			<br/>
			<mod:grupo titulo="Dados Dos Dependentes Diretos">
				<mod:selecao titulo="N�mero total a incluir no Plano de Sa�de " var="totalDeDependentesDiretos"
				opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
				<c:forEach var="i" begin="1" end="${totalDeDependentesDiretos}">
					<mod:grupo>
						<mod:selecao titulo="Parentesco" var="parentesco${i}" 
							opcoes="C�njuge;Filhos Menores De 21 Anos;Filhos Entre 21 e 24 Anos;Filho Maior, Inv�lido;Companheiro(A);Enteado(A) - Filho De C�njuge, Menor De 21 Anos;Enteado(A) - Filho De C�njuge, Entre 21 e 24 Anos;Enteado(A) - Filho de c�njuge, maior inv�lido;Enteado(A) - Filho de Companheiro, menor de 21 anos;Enteado(A) - Filho de Companheiro, entre 21 e 24 anos;Enteado(A) - Filho de Companheiro, maior inv�lido;Menor Sob Guarda Ou Tutela" reler="sim"/>
					</mod:grupo>
					<mod:grupo>
						<mod:texto titulo="Nome" var="nomeDependente${i}" largura="59" />
						<mod:data titulo="Data de Nascimento" var="dataNascimentoDependente${i}"/>
					</mod:grupo>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Filhos Menores De 21 Anos'}">
						<mod:grupo>
							<mod:selecao titulo="Dependente econ�mico" var="dependenteEconomico${i}" 
								opcoes="Sim;N�o"/>
							<mod:selecao titulo="Solteiro" var="solteiro${i}" 
								opcoes="Sim;N�o"/>
							<mod:selecao titulo="Estudante" var="estudante${i}" 
								opcoes="Sim;N�o"/>
							<mod:selecao titulo="Reside em sua companhia" var="resideCompanhia${i}" 
								opcoes="Sim;N�o"/>
						</mod:grupo>					
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Filhos Entre 21 e 24 Anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>					
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Filho Maior, Inv�lido'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>					
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Companheiro(A)'}">
						<mod:selecao titulo="Estado Civil" var="estadoCivilDep${i}" opcoes="Solteiro(a);Casado(a);Divorciado(a);Vi�va(o);Desquitado" reler="sim"/>
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho De C�njuge, Menor De 21 Anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>					
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho De C�njuge, Entre 21 e 24 Anos'}">
						<mod:texto titulo="N� do Cart�o do Aux�lio-Sa�de" var="numeroCartaoAuxSau${i}" largura="59" />
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>	
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de c�njuge, maior inv�lido'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>	
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de Companheiro, menor de 21 anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>	
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de Companheiro, entre 21 e 24 anos'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>	
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Enteado(A) - Filho de Companheiro, maior inv�lido'}">
						<mod:grupo titulo="Dependente econ�mico">
							<mod:radio titulo="Sim" var="dependenteEconomico${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="dependenteEconomico${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Solteiro">
							<mod:radio titulo="Sim" var="solteiro${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="solteiro${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Estudante">
							<mod:radio titulo="Sim" var="estudante${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o" var="estudante${i}" valor="2" />
						</mod:grupo>					
						<mod:grupo titulo="Reside em sua companhia">
							<mod:radio titulo="Sim" var="resideCompanhia${i}"  marcado="Sim" valor="1" />
							<mod:radio titulo="N�o (Neste caso, n�o pode ser inclu�do no Aux�lio-Sa�de)" var="resideCompanhia${i}" valor="2" />
						</mod:grupo>	
					</c:if>
					<c:if test="${requestScope[f:concat('parentesco',i)] == 'Menor Sob Guarda Ou Tutela'}">
					</c:if>
				</c:forEach>
				</mod:grupo>
			</c:if>
			<mod:grupo>
				<mod:caixaverif titulo="Estou ciente de que devo enviar a documenta��o exigida" var="documentacaoExigida"
					reler="N�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:caixaverif titulo="Declaro que estou ciente:" var="declaracaoCiente" reler="N�o" />
				<p align="justify">- dos termos da Resolu��o n� 19/99 do TRF e do Contrato firmado entre o Plano de Sa�de e o TRF 2� Regi�o estendido � esta seccional.</p>
				<p align="justify">- de que a inclus�o solicitada somente ser� processada/efetivada mediante o envio imediato � SEBEN da documenta��o requerida. Caso a documenta��o n�o chegue at� � referida Se��o com at� 4 dias �teis de anteced�ncia em rela��o � data pretendida, dever� ser feita outra solicita��o com nova data de vig�ncia.</p>	
				<p align="justify">- de que o(s) benefici�rio(s) relacionados n�o recebe(m) aux�lio semelhante e nem participa(m) de outro programa de assist�ncia � sa�de, custeado pelos cofres p�blicos, ainda que em parte;</p>
				<c:if test="${valorTipoDeInclusao == 2 || valorTipoDeInclusao == 3}">
					<p align="justify">- de que a solicita��o de inclus�o do(a) dependente (<b>filho(a) maior inv�lido(a), 
					companheiro(a), enteado(a)-filho(a) de c�njuge maior inv�lido(a), enteado(a)-filho(a) de 
					companheiro(a) menor de 21 anos, enteado(a)-filho(a) de companheiro(a) entre 21 e 24 anos e 
					enteado(a)-filho(a) de companheiro(a) maior inv�lido(a)</b>) no Plano de Sa�de est� sujeita � 
					aprecia��o superior, somente podendo ser efetuada ap�s seu deferimento. Neste caso, a data 
					de vig�ncia pretendida poder� vir a ser alterada em virtude da data da autoriza��o. 
					Mais informa��es, entrar em contato com a SEBEN;</p>
				</c:if>
				<c:if test="${valorTipoDeInclusao == 4 || valorTipoDeInclusao == 5}">
					<p align="justify">- de que a solicita��o de inclus�o do(a) dependente (<b>benefici�rio designado e 
					dependente econ�mico</b>) no Plano de Sa�de est� sujeita � aprecia��o superior, somente 
					podendo ser efetuada ap�s seu deferimento. Neste caso, a data de vig�ncia pretendida 
					poder� vir a ser alterada em virtude da data da autoriza��o. Mais informa��es, entrar em 
					contato com a SEBEN</p>
				</c:if>
			</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<mod:valor var="texto_requerimento">
			<p style="TEXT-INDENT: 2cm" align="justify">
			${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).nomePessoa}, matr�cula n� ${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).matricula}, 
			lotado no(a) ${f:pessoa(requestScope['matriculaTitular_pessoaSel.id']).lotacao.descricao},
			vem requerer 
			<c:choose>
				<c:when test="${valorTipoDeInclusao==1}">					
					sua inclus�o
				</c:when>
				<c:when test="${valorTipoDeInclusao==2}">					
					sua inclus�o e a inclus�o dos dependentes diretos abaixo relacionados
				</c:when>
				<c:when test="${valorTipoDeInclusao==3}">
					a inclus�o dos dependentes diretos abaixo relacionados 
				</c:when>
				<c:when test="${valorTipoDeInclusao==4}">
					sua inclus�o e a inclus�o dos dependentes abaixo relacionados 
				</c:when>
				<c:when test="${valorTipoDeInclusao==5}">
					inclus�o dos dependentes abaixo relacionados 
				</c:when>
			</c:choose>
				no Plano de Sa�de, a partir de 1� de ${mesVigencia} de ${anoVigencia}.
			</p>
			<br/>
			<table width="100%">
				<tr>
					<td colspan="3" align="left"><b>1. Dados do Titular:</b></td>
				</tr>
				<tr>
					<td  colspan="2" align="left">Data do exerc�cio: ${dataExercicio}</td>
					<td  align="left">Data de Nascimento: ${dataNascimentoTitular}</td>
				</tr>
				<tr>
					<td colspan="2" align="left">Estado Civil: ${estadoCivilTitular}</td>
					<td align="left">CPF: ${cpf}</td>
				</tr>
				<tr>
					<td>N� de Identidade: ${identidade}</td>
					<td>�rg�o Expedidor: ${orgaoExpedidor}</td>
					<td>Data de Expedi��o: ${dataExpedicao}</td>
				</tr>
				<tr>
					<td colspan="2">N�mero do passaporte: ${passaporte}</td>
					<td>N�mero da Carteira Civil: ${carteiraCivil}</td>
				</tr>
				<tr>
					<td>N� do banco: ${numBanco}</td>
					<td>Ag�ncia: ${agencia}</td>
					<td>Conta-corrente: ${contaCorrente}</td>
				</tr>
				<tr>
					<td colspan="3"> Nome da m�e: ${nomeDaMae}</td>
				</tr>
			</table>
			<br/>
			<table width="50%" height="90px" border="1" cellpadding="2" cellspacing="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#FFFFFF" height="30px" align="left"><b>2. Dados dos Dependentes Diretos:</b></td>
				</tr>
				<c:forEach var="i" begin="1" end="${totalDeDependentesDiretos}">
					<tr>
						<td bgcolor="#FFFFFF" height="30px" align="left"><b>2.${i}. Nome: ${requestScope[f:concat('nomeDependente',i)]}</b></td>
					</tr>
					<tr>
						<td bgcolor="#FFFFFF" width="50%" height="30px" align="left">Data de Nascimento: ${requestScope[f:concat('dataNascimentoDependente',i)]}</td>
						<td bgcolor="#FFFFFF" width="50%" height="30px" align="left">Parentesco/Condi��o: ${requestScope[f:concat('parentesco',i)]}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFFF" height="30px" align="left">Estado Civil: ${requestScope[f:concat('estadoCivilDep',i)]}</td>
					</tr>
				</c:forEach>
			</table>
			
			<p>Declara que:</p>

			<p align="justify">- dos termos da Resolu��o n� 19/99 do TRF e do Contrato firmado entre o Plano de Sa�de e o TRF 2� Regi�o estendido � esta seccional.</p> 

			<p align="justify">- de que a inclus�o solicitada somente ser� processada/efetivada mediante o envio imediato � SEBEN da documenta��o requerida. Caso a documenta��o n�o chegue at� � referida Se��o com at� 4 dias �teis de anteced�ncia em rela��o � data pretendida, dever� ser feita outra solicita��o com nova data de vig�ncia.</p> 

			<p align="justify">- de que o(s) benefici�rio(s) relacionados n�o recebe(m) aux�lio semelhante e nem participa(m) de outro programa de assist�ncia � sa�de, custeado pelos cofres p�blicos, ainda que em parte;</p>
		</mod:valor>	
	
		<mod:valor var="texto_requerimento2">	
			firma o seguinte compromisso:
		 	<b>Declara estar ciente de que tais documentos devem ser apresentados, impreterivelmente, at� o pedido de vac�ncia.</b>
		</mod:valor>
	</mod:documento>
</mod:modelo>
