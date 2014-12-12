<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="DETALHES DO(S) DEPENDENTE(S)">
			<mod:selecao
				titulo="N� de dependentes a informar para Inclus�o do IRPF"
				var="dependentes" opcoes="1;2;3;4;5" reler="ajax"
				idAjax="dependAjax" />
			<mod:grupo depende="dependAjax">
				<c:forEach var="i" begin="1" end="${dependentes}">
					<mod:texto titulo="${i}) Nome" var="nomeDependente${i}"
						largura="60" />
					<mod:data titulo="Data de Nascimento" var="dataNasc${i}" />
					<br />
					<mod:texto
						titulo="CPF (o campo dever� ser preenchido quando o dependente for maior de idade)"
						var="cpf${i}" largura="30" />
					<br />
						<mod:selecao titulo="Grau de parentesco" var="grauParentesco${i}"
							opcoes="absolutamente incapaz do qual o contribuinte seja tutor ou curador;companheiro(a);c�njuge;enteado(a);filho(a);irm�o(a)/neto(a)/bisneto(a)(sem arrimo dos pais);menor que o contribuinte crie ou eduque;pais/av�s/bisav�s;"
							reler="ajax" idAjax="grauParentescoAjax${i}" />
					<br />
					<mod:grupo depende="grauParentescoAjax${i}">
						<c:choose>
							<c:when
								test="${(requestScope[f:concat('grauParentesco',i)] eq 'companheiro(a)') or (requestScope[f:concat('grauParentesco',i)] eq 'c�njuge')}">
							</c:when>
							<c:when
								test="${requestScope[f:concat('grauParentesco',i)] eq 'pais/av�s/bisav�s'}">
								<mod:texto
									titulo="Nome pais/av�s/bisav�s para efeito na declara��o"
									var="maepai${i}" largura="60" />
							</c:when>
							<c:otherwise>
								<mod:texto
									titulo="Nome do pai, da m�e ou do respons�vel do menor sob guarda"
									var="paimae${i}" largura="60" />
								<mod:grupo>
									<mod:caixaverif
										titulo="N�o incluiu o referido dependente junto � empresa/org�o onde trabalha"
										var="opcao1${i}" />
								</mod:grupo>
								<mod:grupo>
									<mod:caixaverif
										titulo="N�o incluiu o referido dependente por n�o exercer atividade remunerada"
										var="opcao2${i}" />
								</mod:grupo>
							</c:otherwise>
						</c:choose>
					</mod:grupo>
				</c:forEach>
			</mod:grupo>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
@page {
	margin-left: 3cm;
	margin-right: 2cm;
	margin-top: 1cm;
	margin-bottom: 2cm;
}
</style>
		</head>
		<body>

		<h1 align="center">Ilma. Sra. Diretora da Subsecretaria de Gest�o
		de Pessoas</h1>

		<p style="TEXT-INDENT: 2cm" align="justify"><c:import
			url="/paginas/expediente/modelos/subscritorIdentificacao.jsp" /> vem
		requerer a Vossa Senhoria a <b>inclus�o</b> de seu(s) dependente(s), a
		seguir relacionado(s), para fim de dedu��o do Imposto de Renda na
		fonte:</p>
		<br>

		<table width="100%" border="1" cellpadding="2" cellspacing="1"
			bgcolor="#000000">
			<tr>
				<td bgcolor="#FFFFFF" width="40%">DEPENDENTE</td>
				<td bgcolor="#FFFFFF" width="20%">DATA DE NASCIMENTO</td>
				<td bgcolor="#FFFFFF" width="20%">PARENTESCO</td>
				<td bgcolor="#FFFFFF" width="20%">CPF</td>
			</tr>
			<c:forEach var="i" begin="1" end="${dependentes}">
				<tr>
					<td bgcolor="#FFFFFF" width="40%">${requestScope[f:concat('nomeDependente',i)]}</td>
					<td bgcolor="#FFFFFF" width="20%">${requestScope[f:concat('dataNasc',i)]}</td>
					<td bgcolor="#FFFFFF" width="40%">${requestScope[f:concat('grauParentesco',i)]}</td>
					<td bgcolor="#FFFFFF" width="40%"><c:if
						test="${empty requestScope[f:concat('cpf',i)]}">N�o informado</c:if>${requestScope[f:concat('cpf',i)]}</td>
				</tr>
			</c:forEach>
		</table>
		<br>

		<p style="TEXT-INDENT: 2cm" align="justify">Declara, ainda, estar
		ciente de que:
		<ul type="square">
			<li>O � 8� do art. 38 da Instru��o Normativa n.� 15/2001, da
			Secretaria da Receita Federal, prev� que "os rendimentos tribut�veis
			recebidos pelos dependentes devem ser somados aos rendimentos do
			contribuinte para efeito de tribula��o na declara��o"</li>
			<li>O art. 35, III, da Lei n&ordm; 9.250/95, prev� que os filhos
			e enteados poder�o ser considerados dependentes, <b>independentemente
			da idade</b>, quando incapacitados f�sica ou mentalmente para o trabalho.
			O mesmo artigo, em seu &sect; 1&ordm;, prev� que os filhos, enteados
			e menores pobres que o contribuinte eduque e do qual detenha a guarda
			judicial poder�o ser considerados dependentes quando maiores <b>at�
			24 anos de idade</b>, se ainda estiverem cursando estabelecimento de
			ensino superior ou escola t�cnica de segundo grau.
			<li>O art. 35, � 3�, da Lei n� 9.250/95 prev� que, "no caso de
			filhos de pais separados, poder�o ser considerados dependentes os que
			ficarem sob a guarda do contribuinte, em cumprimento de decis�o
			judicial ou acordo homologado judicialmente."</li>
		</ul>
		</p>

		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />

		<c:import
			url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />

		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />

		<c:forEach var="i" begin="1" end="${dependentes}">
			<c:choose>
				<c:when
					test="${(requestScope[f:concat('grauParentesco',i)] eq 'companheiro(a)') or (requestScope[f:concat('grauParentesco',i)] eq 'c�njuge')}"></c:when>
				<c:when
					test="${requestScope[f:concat('grauParentesco',i)] eq 'pais/av�s/bisav�s'}">
					<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
					<c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" />
					<p style="TEXT-INDENT: 2cm" align="justify">Declaro, para os
					devidos fins, que meu(minha) pai(m�e) <b>${requestScope[f:concat('maepai',i)]}</b> n�o aufere
					rendimentos, de quaisquer esp�cies, superiores ao limite
					estabelecido pela legisla��o do Imposto de Renda, ou seja, R$
					1.787,77 (mil, setecentos e oitenta e sete reais e setenta e sete centavos) mensais.</p>

					<p style="TEXT-INDENT: 2cm" align="justify">Outrossim, declaro
					estar ciente de que a legisla��o do Imposto de Renda - Lei n&ordm;
					9250/95 <u>veda</u>, em seu art. 35, &sect; 4&ordm;, a dedu��o
					concomitante do montante referente a um mesmo dependente, na
					determina��o da base de c�lculo do imposto, por mais de um
					contribuinte.</p>

					<p style="TEXT-INDENT: 2cm" align="justify">Comprometo-me a
					informar qualquer altera��o na situa��o acima descrita.</p>

					<c:import
						url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
					<c:import
						url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />

				</c:when>

				<c:otherwise>
					<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
					<c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" />
					<p style="TEXT-INDENT: 2cm" align="justify">Declaro, sob as
					penas da lei, junto � <c:choose>
						<c:when test="${not empty doc.subscritor.descricao}">${doc.lotaTitular.orgaoUsuario.descricaoMaiusculas}</c:when>
						<c:otherwise>SE��O JUDICI�RIA DO RIO DE JANEIRO</c:otherwise>
					</c:choose>, com a finalidade de inclus�o do(s) dependente(s) <b>${requestScope[f:concat('nomeDependente',i)]}</b>
					para dedu��o no c�lculo do Imposto de Renda retido na fonte, que <b>${requestScope[f:concat('paimae',i)]}</b>:
					</p>
					<br>
					<br>
					<p style="TEXT-INDENT: 2cm" align="justify">
					<ul type="square">
						<c:if test="${requestScope[f:concat('opcao1',i)] eq 'Sim'}">
							<li>N�o inclui o referido dependente junto � empresa/�rg�o
							onde trabalha.</li>
						</c:if>
						<c:if test="${requestScope[f:concat('opcao2',i)] eq 'Sim'}">
							<li>N�o inclui o referido dependente por n�o exercer
							atividade remunerada.</li>
						</c:if>
					</ul>
					</p>

					<p style="TEXT-INDENT: 2cm" align="justify">Comprometo-me a
					informar qualquer altera��o na situa��o acima descrita.</p>

					<c:import
						url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />

					<p style="TEXT-INDENT: 2cm" align="center"><br>
					<br>
					<br>
					<br>
					________________________________________________________________</br>
					Assinatura do(a) pai/m�e/respons�vel do menor sob guarda (firma
					reconhecida)</p>

					<c:import
						url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />

				</c:otherwise>
			</c:choose>
		</c:forEach>
		</body>
		</html>
	</mod:documento>
</mod:modelo>
