<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<!-- este modelo trata de
FORMULARIO PARA INSCRICAO NO AUXILIO SAUDE-->

<mod:modelo>

	<mod:entrevista>
		</br>
		<mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Matr�cula" var="matricula" reler="sim"
					buscarFechadas="true" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Ramal" var="ramal" largura="10" />
				<mod:texto titulo="Plano de sa�de a qual est� vinculado" var="plano"
					largura="30" />
			</mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Data de vig�ncia" var="mes"
					opcoes="Janeiro;Fevereiro;Mar�o;Abril;Maio;Junho;Julho;Agosto;Setembro;Outubro;Novembro;Dezembro" />
			</mod:grupo>
			</br>
		</mod:grupo>


		<mod:selecao titulo="Total de dependentes" var="totalDePessoal"
			opcoes="1;2;3;4;5;6;7;8;9;10" reler="sim" />
		<mod:grupo titulo="Rela��o de Dependentes">


			<mod:grupo>
				<mod:selecao titulo="Todos os dependentes pertencem ao mesmo plano?"
					var="pertence" opcoes="Sim;N�o" reler="sim" />
			</mod:grupo>
			<br />
			<c:forEach var="i" begin="1" end="${totalDePessoal}">
				<mod:grupo>
					<mod:texto titulo="Nome" var="nome${i}" largura="59" />
					<mod:data titulo="Data de Nascimento" var="data_nasc${i}" />
				</mod:grupo>
				<mod:grupo>
				<mod:selecao titulo="Parentesco" var="parentesco${i}" 
					opcoes="C�njuge;Filhos menores de 21 anos;Filhos entre 21 e 24 anos;Filho maior, inv�lido;Companheiro(a);Enteado(a) - Filho de C�njuge, menor de 21 anos;Enteado(a) - Filho de C�njuge, entre 21 e 24 anos;Enteado(a) - Filho de C�njuge, maior inv�lido;Enteado(a) - Filho de Companheiro, menor de 21 anos;Enteado(a) - Filho de Companheiro, entre 21 e 24 anos;Enteado(a) - Filho de Companheiro, maior inv�lido;Menor sob guarda ou tutela" />
			</mod:grupo>
						<mod:grupo>	
					<mod:texto titulo="Estado civil" var="estado${i}" largura="19" />
				</mod:grupo>
				<mod:grupo>
					<mod:texto titulo="N� de identidade" var="identidade${i}"
						largura="15" />
					<mod:texto titulo="�rg�o expedidor" var="orgao${i}" largura="15" />
					<mod:data titulo="Data de Expedi��o" var="data_expedicao${i}" />
				</mod:grupo>
				<mod:grupo>
					<c:if test="${pertence == 'N�o'}">
						<mod:grupo>
							<mod:texto titulo="Plano de Sa�de" var="planoDep${i}"
								largura="15" />
						</mod:grupo>
					</c:if>
				</mod:grupo>
				<br />


			</c:forEach>
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

		<table width="100%" height="90px" border="1" cellpadding="2"
			cellspacing="1" bgcolor="#000000">
			<tr>
				<td bgcolor="#FFFFFF" height="30px" align="center"><b>RELA��O
				DE BENEFICI�RIOS</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="2" cellspacing="1"
			bgcolor="#000000">
			<c:forEach varStatus="indice" var="i" begin="1"
				end="${totalDePessoal}">
				<tr>
					<td width="65%" bgcolor="#FFFFFF" colspan="2" align="center"><b>Nome</b></td>
					<td width="15%" bgcolor="#FFFFFF" align="center"><b>Parentesco</b></td>
					<td width="20%" bgcolor="#FFFFFF" colspan="2" align="center"><b>Plano
					de Sa�de</b></td>

				</tr>

				<tr>
					<td width="65%" bgcolor="#FFFFFF" colspan="2" align="center">${requestScope[f:concat('nome',i)]}</td>
					<td width="15%" bgcolor="#FFFFFF" align="center">${requestScope[f:concat('parentesco',i)]}</td>

					<c:if test="${pertence == 'N�o'}">
						<td width="20%" bgcolor="#FFFFFF" colspan="2" align="center">${requestScope[f:concat('planoDep',i)]}</td>
					</c:if>
					<c:if test="${pertence == 'Sim'}">
						<td width="20%" bgcolor="#FFFFFF" colspan="2" align="center">${plano}</td>
					</c:if>
				</tr>


				<tr>
					<td width="30%" bgcolor="#FFFFFF" align="center"><b>N� de
					identidade</b></td>
					<td width="20%" bgcolor="#FFFFFF" align="center"><b>�rg�o
					expedidor</b></td>
					<td width="15%" bgcolor="#FFFFFF" align="center"><b>Data
					expedi��o</b></td>
					<td width="15%" bgcolor="#FFFFFF" align="center"><b>Data
					nascimento</b></td>
					<td width="20%" bgcolor="#FFFFFF" align="center"><b>Estado
					Civil</b></td>
				</tr>

				<tr>
					<td width="30%" bgcolor="#FFFFFF" align="center">${requestScope[f:concat('identidade',i)]}</td>
					<td width="20%" bgcolor="#FFFFFF" align="center">${requestScope[f:concat('orgao',i)]}</td>
					<td width="15%" bgcolor="#FFFFFF" align="center">${requestScope[f:concat('data_expedicao',i)]}</td>
					<td width="15%" bgcolor="#FFFFFF" align="center">${requestScope[f:concat('data_nasc',i)]}
					<c:set var="idade" value="${requestScope[f:concat('data_nasc',i)]}" scope="request" />
					<c:set var="parentesco" value="${requestScope[f:concat('parentesco',i)]}" scope="request" />
					<c:if test="${requestScope[f:idadeEmAnos(idade)] > 21 && parentesco == 'Filhos entre 21 e 24 anos'}">
					*
					</c:if>
					</td>
					<td width="20%" bgcolor="#FFFFFF" align="center">${requestScope[f:concat('estado',i)]}</td>
				</tr>
				
				<c:if test="${requestScope[f:idadeEmAnos(idade)] > 21 && parentesco == 'Filhos entre 21 e 24 anos'}">
					
				<tr>
				<td width="100%" colspan="5" bgcolor="#FFFFFF">
				* Declaro, a fim de fazer prova junto ao plano de sa�de, que ${requestScope[f:concat('nome',i)]} permanece na condi��o de solteiro(a), estudante e vive sob minha depend�ncia econ�mica.
				</td>
				</tr>
							</c:if>
			</c:forEach>
		</table>

		<p style="TEXT-INDENT: 2cm" align="justify"><br />Eu, <mod:identificacao
			pessoa="${requestScope['matricula_pessoaSel.id']}" negrito="sim"
			nivelHierarquicoMaximoDaLotacao="4" /> CPF:
		${f:pessoa(requestScope['matricula_pessoaSel.id']).cpfPessoa}, ramal
		${ramal}, vinculado ao plano de sa�de ${plano}, declaro estar ciente
		dos termos da Resolu��o n� 587, que regulamenta � assist�ncia � sa�de
		prevista no art. 230 da Lei n� 8.112, de 1990, com a reda��o dada pela
		Lei n� 11.032, de 2006, e de que o respectivo reembolso ser� realizado
		em Folha de Pagamento, conforme apresentado abaixo: <br />
		<br />
		Data de Vig�ncia: ${mes} <br />
		<br />
		&bull;O benefici�rio receber� o valor integral da mensalidade do Plano
		de Sa�de externo, quando este for igual ou inferior ao limite m�ximo
		de reembolso; <br /><br />

		&bull;Quando o valor da mensalidade cobrada exceder o limite m�ximo do
		reembolso, o benefici�rio receber� o valor deste limite; <br /><br />
		&bull;Declaro, ainda, que o(s) benefici�rio(s) acima relacionado(s)
		n�o recebe(m) aux�lio semelhante e nem participa(m) de outro programa
		de assist�ncia � sa�de, custeado pelos cofres p�blicos, ainda que em
		parte.</p>

		<b>OBSERVA��O<b />
		<p align="justify">&bull; A inscri��o de dependentes somente
		poder� ser feita se o servidor for inscrito como titular no referido
		benef�cio e somente ele poder� efetiv�-la.</p>

		<p align="justify"><b>Esclarecimentos quanto � documenta��o a
		ser encaminhada ser�o prestados ap�s a regulamenta��opelo TRF - 2�
		Regi�o.<b /></p>
		<br />
		<p align="center">${doc.dtExtenso}</p>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
	</mod:documento>
</mod:modelo>

