<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
				<mod:grupo>
					<mod:lotacao titulo="Unidade Gestora" var="lotacao"/>
				</mod:grupo>
				<mod:texto titulo="N� Processo" var="numProcesso" largura="10" />
				<mod:selecao titulo="N� de Contratos a informar" var="numContratos" opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20" reler="ajax" idAjax="numContratoAjax" />
			<hr>
			<mod:grupo depende="numContratoAjax">
				<c:forEach var="i" begin="1" end="${numContratos}">
						<mod:texto titulo="N� do Contrato" var="numCont${i}" largura="10" />
					<mod:grupo>
						<mod:texto titulo="Nome da Empresa" var="nomeEmpresa${i}" largura="55" />
					</mod:grupo>
					<mod:grupo>
						<mod:texto titulo="Descri��o Contrato" var="descContrato${i}" largura="50" />
					</mod:grupo>				
					<mod:grupo>
						<mod:texto titulo="Per�odo de refer�ncia" var="mes${i}" largura="50"/>
					</mod:grupo>
					<mod:grupo>
						<mod:selecao titulo="Informo que os servi�os foram prestados" var="fatura${i}" opcoes="conforme discriminados nos termos do contrato em refer�ncia;com as seguintes ressalvas;com qualidade e efici�ncia" reler="sim"/>
							<mod:grupo>
								<c:if test="${requestScope[f:concat('fatura',i)] == 'com as seguintes ressalvas'}">
								<mod:grupo titulo="Descri��o das ressalvas">
									<mod:grupo>
										<mod:editor titulo="" var="descRessalvas${i}" />
									</mod:grupo>
								</mod:grupo>
								</c:if>
							</mod:grupo>
					</mod:grupo>
					
				<mod:selecao titulo="�ndice de Freq��ncia" var="frequencia" opcoes="Integral;Parcial;N�o se aplica" reler="ajax" idAjax="frequenciaAjax" />
				<mod:grupo depende="frequenciaAjax">
				<c:if test="${frequencia eq 'Parcial'}">
					<mod:selecao titulo="Informa��o Simplificada" opcoes="Sim;N�o" var="infoSimplif" reler="ajax" idAjax="infoSimplifAjax" /> 
						<mod:grupo depende="infoSimplifAjax">
							<c:choose>
								<c:when test="${infoSimplif eq 'Sim'}">
									<mod:grupo>
										<mod:numero titulo="N� de faltas sem reposi��o" var="numFaltas" largura="10" />
									</mod:grupo>
									<mod:grupo>
										<mod:numero titulo="Quantidade de minutos em atrasos sem reposi��o" var="quantMinutos" largura="10" />
									</mod:grupo>	
								</c:when>
								<c:otherwise>
									<mod:grupo>
										<mod:selecao titulo="Informe a quantidade de funcion�rio(s) com freq��ncia parcial" var="faltas" opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30" reler="ajax" idAjax="faltasAjax"/>
									</mod:grupo>
									<mod:grupo depende="faltasAjax">
										<c:forEach var="i" begin="1" end="${faltas}">
											<mod:grupo>
												<mod:texto titulo="Nome" var="nomeFuncionario${i}" largura="50" />
												<mod:selecao titulo="Selecione uma op��o" var="reposicao${i}" opcoes="[Nenhum];Com reposi��o;Sem reposi��o" reler="ajaxReposicao${i}" />
											</mod:grupo>
											<mod:grupo>
												<mod:selecao titulo="Tipo(s) Diferente(s) de Aus�ncia(s)" var="ausencia${i}" opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20" reler="ajax" idAjax="ajaxAusencia${i}" />
											</mod:grupo>
											<mod:grupo depende="ajaxAusencia${i}">
												<c:forEach var="j" begin="1" end="${requestScope[f:concat('ausencia',i)]}">
													<mod:grupo>
														<mod:data titulo=" ${j}) De" var="de${j}${i}" />
														<mod:data titulo="At�" var="ate${j}${i}" />
														<mod:texto titulo="Motivo" var="motivo${j}${i}" largura="50" />
													</mod:grupo>
												</c:forEach>
											</mod:grupo>
										</c:forEach>
									</mod:grupo>
								</c:otherwise>
							</c:choose>
						</mod:grupo>
					</c:if>
				</mod:grupo>
					
					
					<mod:grupo>
						<mod:memo titulo="Informa��es adicionais" var="infor${i}" linhas="5" colunas="60" />
					</mod:grupo>
					<hr>
				</c:forEach>
			</mod:grupo>
		<mod:grupo>
			<mod:selecao titulo="Tamanho da letra" var="tamanhoLetra" opcoes="Normal;Pequeno;Grande"/>
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
		<c:if test="${tamanhoLetra=='Normal'}"><c:set var="tl" value="11pt"/></c:if>
		<c:if test="${tamanhoLetra=='Pequeno'}"><c:set var="tl" value="9pt"/></c:if>
		<c:if test="${tamanhoLetra=='Grande'}"><c:set var="tl" value="13pt"/></c:if>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			@page {
				margin-left: 3cm;
				margin-right: 3cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
		</style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="left" width="40%"><p style="font-family:Arial;font-size:11pt;font-weight:bold;">${doc.codigo}</p></td>
							<td align="right" width="60%"><mod:letra tamanho="${tl}"><p>${doc.dtExtenso}</p></mod:letra></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->
		
		<mod:letra tamanho="${tl}">

		<mod:letra tamanho="${tl}"><p align="center"> CONTRATOS: RELAT�RIO - FORMUL�RIO INFORMA��O SOBRE PRESTA��O DE SERVI�OS </p></mod:letra><br><br>
		
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Unidade Gestora: <b>${requestScope['lotacao_lotacaoSel.descricao']}</b>
		 </p>			
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 N� Processo: <b>${numProcesso}</b>
		 </p>
		 <hr>
		 <c:forEach var="i" begin="1" end="${numContratos}">
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 N� do Contrato: <b>${requestScope[f:concat('numCont',i)]}</b>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Nome da Empresa: <b>${requestScope[f:concat('nomeEmpresa',i)]}</b>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Descri��o Contrato: <b>${requestScope[f:concat('descContrato',i)]}</b>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Per�odo de Ref. <b>${requestScope[f:concat('mes',i)]}</b>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Informo que os servi�os foram prestados
		 <c:if test="${requestScope[f:concat('fatura',i)] == 'conforme discriminados nos termos do contrato em refer�ncia'}">
		 	conforme discriminados nos termos do contrato em refer�ncia
		 </c:if>
		 <c:if test="${requestScope[f:concat('fatura',i)] == 'com as seguintes ressalvas'}">
			com as seguintes ressalvas: 
		 <span style="font-size:${tl};">
		 <b>${requestScope[f:concat('descRessalvas',i)]}</b>
		 </span>
		 </c:if>
		 <c:if test="${requestScope[f:concat('fatura',i)] == 'com qualidade e efici�ncia'}">
		 	com qualidade e efici�ncia.
		 </c:if>
		 
		 <c:if test="${infoSimplif eq 'Sim'}">
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 N� de faltas sem reposi��o: <b>${numFaltas}</b>
		 </p>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Quantidade de minutos em atrasos sem reposi��o: <b>${quantMinutos}</b>
		 </p>
		 </c:if>

		 <c:if test="${frequencia =='Integral'}">
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Informo que o(s) funcion�rio(s) tiveram freq��ncia integral durante o m�s.
		 </p>
		 </c:if>
		
		 <c:if test="${(frequencia =='Parcial') and (faltas >= 1)}">
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Informo que o(s) funcion�rio(s) abaixo tiveram freq��ncia parcial, conforme discriminado abaixo, tendo os demais freq��ncia integral:
		 </p>
		 <br>
		 
		 <table width="100%" border="1" cellpadding="2" cellspacing="1"
			bgcolor="#000000">
			<tr>
				<td bgcolor="#FFFFFF" width="40%" align="center"><b>Nome</b></td>
				<td bgcolor="#FFFFFF" width="40%" align="center"><b>Data/Motivo</b></td>
				<td bgcolor="#FFFFFF" width="20%" align="center"><b>Observa��o</b></td>
			</tr>
			<c:forEach var="i" begin="1" end="${faltas}">
				<tr>
					<td bgcolor="#FFFFFF" width="40%" align="center">${requestScope[f:concat('nomeFuncionario',i)]}</td>
					<td bgcolor="#FFFFFF" width="40%">
						<c:forEach var="y" begin="1" end="${requestScope[f:concat('ausencia',i)]}">
							De ${requestScope[f:concat(f:concat('de',y),i)]} a ${requestScope[f:concat(f:concat('ate',y),i)]} -
							${requestScope[f:concat(f:concat('motivo',y),i)]}<br>
		 				</c:forEach>
		 			</td>
		 			<td bgcolor="#FFFFFF" width="20%">
	 					${requestScope[f:concat('reposicao',i)]}
					</td>
		 		</tr>
		 	</c:forEach>
		 </table>
		 </c:if> 
		 
		 
		 <c:if test="${not empty requestScope[f:concat('infor',i)]}">
	 		 <p style="TEXT-INDENT: 2cm" align="justify">
			 	Informa��es adicionais: ${requestScope[f:concat('infor',i)]}
			 </p>
		 </c:if>
		 <hr>
		 </c:forEach>
		 <p style="TEXT-INDENT: 2cm" align="justify">
		 Atenciosamente,
		 </p>
		 <br>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp" />
		</mod:letra>
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />

		</body>
		</html>
	</mod:documento>
</mod:modelo>
