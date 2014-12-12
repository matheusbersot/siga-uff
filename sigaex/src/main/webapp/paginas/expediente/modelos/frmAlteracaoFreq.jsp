<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="Comunica��es de Altera��es de Frequ�ncia">
			<mod:selecao titulo="M�s de refer�ncia" var="mes"
				opcoes="Jan;Fev;Mar;Abr;Maio;Jun;Jul;Ago;Set;Out;Nov;Dez" />
			<c:if test="${mes=='Jan'}">
				<c:set var="numMes" value="01" />
			</c:if>
			<c:if test="${mes=='Fev'}">
				<c:set var="numMes" value="02" />
			</c:if>
			<c:if test="${mes=='Mar'}">
				<c:set var="numMes" value="03" />
			</c:if>
			<c:if test="${mes=='Abr'}">
				<c:set var="numMes" value="04" />
			</c:if>
			<c:if test="${mes=='Maio'}">
				<c:set var="numMes" value="05" />
			</c:if>
			<c:if test="${mes=='Jun'}">
				<c:set var="numMes" value="06" />
			</c:if>
			<c:if test="${mes=='Jul'}">
				<c:set var="numMes" value="07" />
			</c:if>
			<c:if test="${mes=='Ago'}">
				<c:set var="numMes" value="08" />
			</c:if>
			<c:if test="${mes=='Set'}">
				<c:set var="numMes" value="09" />
			</c:if>
			<c:if test="${mes=='Out'}">
				<c:set var="numMes" value="10" />
			</c:if>
			<c:if test="${mes=='Nov'}">
				<c:set var="numMes" value="11" />
			</c:if>
			<c:if test="${mes=='Dez'}">
				<c:set var="numMes" value="12" />
			</c:if>
			<mod:texto titulo="Ano" var="ano" largura="6" maxcaracteres="4"
				reler="ajax" idAjax="anoAjax" />
			<mod:grupo depende="anoAjax">
				<c:if test="${empty ano}">
					<mod:mensagem titulo="Alerta"
						texto="o ano deve ser preenchido." vermelho="Sim" />
				</c:if>
			</mod:grupo>
			<mod:grupo>
				<mod:lotacao titulo="Lota��o" var="lotacao" reler="sim" />
			</mod:grupo>

			<input type="hidden" id="atualizandoCaixaVerif"
				name="atualizandoCaixaVerif" />
			<mod:caixaverif var="subLotacoes" reler="sim" marcado="Sim"
				titulo="Incluir Sublota��es"
				onclique="javascript:document.getElementById('atualizandoCaixaVerif').value=1;" />
			<c:if test="${requestScope['subLotacoes'] eq 'Sim'}">
				<c:set var="testarSubLotacoes" value="true" />
			</c:if>
			<c:if test="${requestScope['subLotacoes'] != 'Sim'}">
				<c:set var="testarSubLotacoes" value="false" />
			</c:if>

		</mod:grupo>
		<mod:grupo>
			<b> <mod:mensagem titulo="Aten��o"
				texto="Preencha o destinat�rio com SECAD e, ap�s finalizar, transfira para a SECAD." />
			</b>
		</mod:grupo>
		<mod:grupo>
			<b> <mod:mensagem titulo=""
				texto="Anota��es feitas ap�s a transfer�ncia do formul�rio para a SECAD, n�o ser�o consideradas." vermelho="Sim" />
			</b>
		</mod:grupo>
		
		<%-- O bloco abaixo carrega do BD as pessoas de um lota��o, apenas quando a lota��o muda --%>
		<mod:ler var="siglaLotacaoAnterior" />
		<c:choose>
			<c:when
				test="${(requestScope['lotacao_lotacaoSel.sigla'] != siglaLotacaoAnterior) or (param['atualizandoCaixaVerif']) == 1}">
				<c:set var="pessoas"
					value="${f:pessoasPorLotacao(param['lotacao_lotacaoSel.id'], testarSubLotacoes)}" />
				<c:set var="i" value="${0}" />
				<c:forEach var="pes" items="${pessoas}">
					<c:set var="i" value="${i+1}" />
					<mod:oculto var="sigla${i}" valor="${pes.sigla}" />
					<mod:oculto var="nome${i}" valor="${pes.descricao}" />
				</c:forEach>
				<mod:oculto var="contadorDePessoas" valor="${i}" />
				<mod:oculto var="siglaLotacaoAnterior"
					valor="${requestScope['lotacao_lotacaoSel.sigla']}" />
			</c:when>
			<c:otherwise>
				<mod:oculto var="contadorDePessoas" />
				<mod:oculto var="siglaLotacaoAnterior"
					valor="${siglaLotacaoAnterior}" />
				<c:forEach var="i" begin="1" end="${contadorDePessoas}">
					<mod:oculto var="sigla${i}" />
					<mod:oculto var="nome${i}" />
				</c:forEach>
			</c:otherwise>
		</c:choose>

		<c:forEach var="i" begin="1" end="${contadorDePessoas}">
			<c:set var="pes_descricao"
				value="${requestScope[f:concat('nome',i)]}" />
			<c:set var="pes_sigla" value="${requestScope[f:concat('sigla',i)]}" />

			<mod:grupo largura="30">${pes_descricao}</mod:grupo>
			<mod:grupo largura="70">
				<mod:grupo>
					<mod:selecao titulo="Frequ�ncia" var="freq${pes_sigla}"
						opcoes="Sem lan�amentos;Com lan�amentos" reler="ajax"
						idAjax="ajax${pes_sigla}" />
				</mod:grupo>
				<mod:grupo depende="ajax${pes_sigla}">
					<c:if
						test="${(requestScope[f:concat('freq',pes_sigla)] == 'Com lan�amentos')}">
						<mod:selecao titulo="Aus�ncia(s)" var="faltas${pes_sigla}"
							opcoes="1;2;3;4;5" reler="ajax" idAjax="ajax${pes_sigla}" />
						<c:forEach var="i" begin="1"
							end="${requestScope[f:concat('faltas',pes_sigla)]}">
							<mod:grupo>
								<mod:selecao
									titulo="Motivo (As tabelas da Base Legal encontram-se na p�gina da SECAD na Intranet)"
									var="motivo${i}${pes_sigla}"
									opcoes="[Selecione o tipo de Aus�ncia];Afastamento em Virtude de Participa��o em Programa de Treinamento;Afastamento para Participar de Atividade Instrut�ria;Afastamento por j�ri e outros servi�os obrigat�rios por lei;Atraso/Sa�da Antecipada;Aus�ncia/Falta Justificada com Compensa��o;Aus�ncia/Falta Justificada sem Compensa��o;Aus�ncia por motivo de greve com compensa��o;Aus�ncia por motivo de greve sem compensa��o;Compensa��o de Trabalho no Recesso;Compensa��o Decorrente de Trabalho nas Elei��es;Falta Injustificada;Recesso;Trabalho Prestado nas Elei��es;Viagem a Servi�o;Horas extras (trabalhadas sem remunera��o)"
									reler="ajax" idAjax="ajax${pes_sigla}" />
							</mod:grupo>
							<c:choose>
								<c:when
									test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == '[Selecione o tipo de Aus�ncia]'}">
								</c:when>
								<c:when
									test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Compensa��o de Trabalho no Recesso'}">
									<mod:texto titulo="Datas" var="datas${i}${pes_sigla}"
										largura="60" />
								</c:when>
								<c:when
									test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Atraso/Sa�da Antecipada'}">
									<mod:data titulo="Data" var="data${i}${pes_sigla}" reler="ajax"
										idAjax="dataAjax${i}${pes_sigla}" />
									<mod:hora titulo="Tempo de Atraso/Sa�da Antecipada" var="atraso${i}${pes_sigla}" />hs

										<%-- reler="ajax" idAjax="atrasoAjax${i}${pes_sigla}"--%> 
									
									<%-- <mod:hora titulo="das" var="horaIni${i}${pes_sigla}"
										reler="ajax" idAjax="horaIniAjax${i}${pes_sigla}" />
									<mod:hora titulo="�s" var="horaFim${i}${pes_sigla}"
										reler="ajax" idAjax="horaFimAjax${i}${pes_sigla}" /> --%>
										
								</c:when>

								<c:when
									test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Horas extras (trabalhadas sem remunera��o)'}">
									<mod:selecao titulo="N� de dias com horas extras" var="numDiasHoras${pes_sigla}" opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20" reler="ajax" idAjax="ajax${pes_sigla}" />
									<c:forEach var="i" begin="1"
										end="${requestScope[f:concat('numDiasHoras',pes_sigla)]}">	
										<mod:grupo>
											<mod:data titulo="Data" var="dataHoraExtra${i}${pes_sigla}" reler="ajax"
												idAjax="dataAjax${i}${pes_sigla}" />
											<mod:texto titulo="Quantidade de Horas" var="quantHoras${i}${pes_sigla}" largura="2" />
											<mod:selecao titulo="Feriado ou Domingo ?"
												var="feriadoOuDomingo${i}${pes_sigla}" 	opcoes="N�o;Sim" />
										</mod:grupo>
									</c:forEach>
									<mod:mensagem titulo="Obs"  texto="M�ximo de duas horas em dias �teis e de dez em s�bados, domingos e feriados." vermelho="Sim" />
								</c:when>


								<c:otherwise>
									<mod:grupo>
										<mod:data titulo="De" var="de${i}${pes_sigla}" reler="ajax"
											idAjax="deAjax${i}${pes_sigla}" />
									</mod:grupo>
									<mod:grupo depende="deAjax${i}${pes_sigla}">
										<c:if
											test="${not empty requestScope[f:concat(f:concat('de',i),pes_sigla)] and not empty ano}">
											<c:choose>
												<c:when
													test="${f:mesModData(requestScope[f:concat(f:concat('de',i),pes_sigla)])!= f:concat(f:concat(numMes,'/'),ano)}">
													<mod:grupo>
														<mod:mensagem titulo="Alerta"
															texto="A data inicial informada deve ser igual ao m�s ou ano referido"
															vermelho="Sim" />
													</mod:grupo>
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
										</c:if>
									</mod:grupo>
									<mod:data titulo="At�" var="ate${i}${pes_sigla}" reler="ajax"
										idAjax="ateAjax${i}${pes_sigla}" />
									<mod:grupo depende="ateAjax${i}${pes_sigla}">
										<c:if
											test="${not empty requestScope[f:concat(f:concat('ate',i),pes_sigla)] and not empty ano}">
											<c:choose>
												<c:when
													test="${f:mesModData(requestScope[f:concat(f:concat('ate',i),pes_sigla)])!= f:concat(f:concat(numMes,'/'),ano)}">
													<mod:grupo>
														<mod:mensagem titulo="Alerta"
															texto="A data final informada deve ser igual ao m�s ou ano referido"
															vermelho="Sim" />
													</mod:grupo>
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
										</c:if>
									</mod:grupo>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</c:forEach>
		<c:if test="${not empty requestScope['lotacao_lotacaoSel.sigla']}">
			<mod:grupo>
				<mod:mensagem titulo="Total de pessoas por Lota��o :" />
				<b>${contadorDePessoas}</b>
			</mod:grupo>
		</c:if>
		<c:if
			test="${(not empty requestScope['lotacao_lotacaoSel.descricao'])}">
			<mod:grupo>
				<mod:selecao titulo="Informa��es Adicionais ?"
					var="informacoesAdicionais" opcoes="N�o;Sim" reler="ajax"
					idAjax="infoAdicionais" />
				<mod:grupo depende="infoAdicionais">
					<c:if test="${informacoesAdicionais eq 'Sim'}">
						<mod:memo colunas="60" linhas="3" titulo="Informa��es"
							var="informacoes" />
					</c:if>
				</mod:grupo>
			</mod:grupo>

			<mod:grupo>
				<mod:selecao titulo="Houve servidores incluidos na lota��o no m�s ?"
					var="servIncluidos" opcoes="N�o;Sim" reler="ajax" idAjax="servIncl" />
			</mod:grupo>
			<mod:grupo depende="servIncl">
				<c:if test="${servIncluidos eq 'Sim'}">
					<mod:grupo>
						<mod:selecao titulo="N� de Servidor(es) Incluido(s) :"
							var="numServIncluidos"
							opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30"
							reler="ajax" idAjax="numServIncl" />
					</mod:grupo>
					<mod:grupo depende="numServIncl">
						<c:forEach var="i" begin="1" end="${numServIncluidos}">
							<mod:grupo>
								<mod:texto titulo="${i}) Nome :" var="nomeServIncluido${i}"
									largura="55" />
								<mod:texto titulo="Matr&iacute;cula :" var="matServIncluido${i}"
									largura="15" />
								<mod:data titulo="A partir de" var="dataIncluso${i }" />
								<mod:grupo>
									<mod:caixaverif titulo="Houve aus�ncia deste servidor ?"
										var="periodoAusencia${i}" reler="ajax"
										idAjax="pedAusencia${i}" />
									<mod:grupo depende="pedAusencia${i}">
										<c:if
											test="${requestScope[f:concat('periodoAusencia',i)] == 'Sim'}">
											<mod:grupo>
												<mod:texto titulo="Aus�ncia :" var="ausencia${i}"
													largura="40" />
												<mod:data titulo="De" var="dataInicio${i}" />
												<mod:data titulo="a" var="dataFim${i}" />
											</mod:grupo>
										</c:if>
									</mod:grupo>
								</mod:grupo>
							</mod:grupo>
						</c:forEach>
					</mod:grupo>
				</c:if>
			</mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Houve servidores exclu�dos da lota��o no m�s ?"
					var="servExcluidos" opcoes="N�o;Sim" reler="ajax" idAjax="servExcl" />
			</mod:grupo>
			<mod:grupo depende="servExcl">
				<c:if test="${servExcluidos == 'Sim'}">
					<mod:grupo>
						<mod:selecao titulo="N� de Servidor(es) Exclu�do(s) :"
							var="numServExcluidos"
							opcoes="1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30"
							reler="ajax" idAjax="numServExcl" />
					</mod:grupo>
					<mod:grupo depende="numServExcl">
						<c:forEach var="j" begin="1" end="${numServExcluidos}">
							<mod:grupo>
								<mod:texto titulo="${j}) Nome :" var="nomeServExcluido${j}"
									largura="55" />
								<mod:texto titulo="Matr&iacute;cula :" var="matServExcluido${j}"
									largura="15" />
								<mod:data titulo="A partir de" var="dataExcluido${j}" />
								<mod:grupo>
									<mod:caixaverif
										titulo="Houve aus�ncia deste servidor at� a data em quest�o ?"
										var="periodoAusenciaExcluido${j}" reler="ajax"
										idAjax="pedAusExcl${j}" />
									<mod:grupo depende="pedAusExcl${j}">
										<c:if
											test="${requestScope[f:concat('periodoAusenciaExcluido',j)] == 'Sim'}">
											<mod:grupo>
												<mod:texto titulo="Aus�ncia :" var="ausenciaExcluido${j}"
													largura="40" />
												<mod:data titulo="De" var="dataInicioExclusao${j}" />
												<mod:data titulo="a" var="dataFimExclusao${j}" />
											</mod:grupo>
										</c:if>
									</mod:grupo>
								</mod:grupo>
							</mod:grupo>
						</c:forEach>
					</mod:grupo>
				</c:if>
			</mod:grupo>
		</c:if>
	</mod:entrevista>
	<mod:documento>
		<c:set var="contadorDePessoasComLancamento" value="0" />
		<c:forEach var="i" begin="1" end="${contadorDePessoas}">
			<c:set var="pes_sigla" value="${requestScope[f:concat('sigla',i)]}" />
			<c:if
				test="${(requestScope[f:concat('freq',pes_sigla)] == 'Com lan�amentos')}">
				<c:set var="contadorDePessoasComLancamento"
					value="${contadorDePessoasComLancamento + 1}" />
			</c:if>
		</c:forEach>


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
		<c:set var="tl" value="9pt" />
		<c:set var="t2" value="7pt" />
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<p style="text-align: center;"><br />
		<b>Comunica��es de Altera��es de Frequ�ncia</b><br />
		<br />
		</p>

		<table width="100%" border="0" cellpadding="2" cellspacing="1"
			bgcolor="#ffffff">
			<tr>
				<td width="30%">Unidade Organizacional:</td>
				<td width="70%">${f:lotacao(requestScope['lotacao_lotacaoSel.id']).descricao}</td>
			</tr>
			<tr>
				<td>M�s/Ano:</td>
				<td>${mes}/${ano}</td>
			</tr>
			<tr>
				<td>Data da emiss�o:</td>
				<td>${doc.dtDocDDMMYY}</td>
			</tr>
		</table>
		<br />

		<mod:letra tamanho="${t2}">
			<c:choose>
				<c:when
					test="${not empty contadorDePessoasComLancamento and contadorDePessoasComLancamento ne 0}">
					<table width="100%" border="1" cellpadding="2" cellspacing="1"
						bgcolor="#000000">
						<tr>
							<td bgcolor="#FFFFFF" width="15%" align="center"><b>Matr�cula</b></td>
							<td bgcolor="#FFFFFF" width="35%" align="center"><b>Nome</b></td>
							<td bgcolor="#FFFFFF" width="15%" align="center"><b>Frequ�ncia</b></td>
							<td bgcolor="#FFFFFF" width="35%" align="center"><b>Per�odo/Motivo</b></td>
						</tr>

						<c:forEach var="i" begin="1" end="${contadorDePessoas}">
							<c:set var="pes_descricao"
								value="${requestScope[f:concat('nome',i)]}" />
							<c:set var="pes_sigla"
								value="${requestScope[f:concat('sigla',i)]}" />
							<c:if
								test="${(requestScope[f:concat('freq',pes_sigla)] == 'Com lan�amentos')}">
								<tr>
									<td bgcolor="#FFFFFF" width="15%" align="center">${pes_sigla}</td>
									<td bgcolor="#FFFFFF" width="35%" align="center">${pes_descricao}</td>
									<td bgcolor="#FFFFFF" width="15%" align="center">${requestScope[f:concat('freq',pes_sigla)]}</td>
									<td bgcolor="#FFFFFF" width="35%" align="center"><c:forEach
										var="i" begin="1"
										end="${requestScope[f:concat('faltas',pes_sigla)]}">
										<c:choose>
											<c:when
												test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == '[Selecione o tipo de Aus�ncia]'}"> N�o foi selecionado um tipo de aus�ncia </c:when>
											<c:when
												test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Compensa��o de Trabalho no Recesso'}"> ${requestScope[f:concat(f:concat('datas',i),pes_sigla)]} - ${requestScope[f:concat(f:concat('motivo',i),pes_sigla)]}
											<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Compensa��o de Trabalho no Recesso'}">
												 	(PORTARIA DIRFO)	
											</c:if>
											</c:when>
											<c:when
												test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Atraso/Sa�da Antecipada'}"> ${requestScope[f:concat(f:concat('data',i),pes_sigla)]} - ${requestScope[f:concat(f:concat('atraso',i),pes_sigla)]} hs - ${requestScope[f:concat(f:concat('motivo',i),pes_sigla)]}
											<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Atraso/Sa�da Antecipada'}">
												 	(art.44, INCISO II LEI 8112/90)	
											</c:if>
											</c:when>
											
											
											
											<c:when
												test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Horas extras (trabalhadas sem remunera��o)'}">
												N� de dias com horas extras: ${requestScope[f:concat('numDiasHoras',pes_sigla)]}<br/>
												<c:forEach var="i" begin="1"
													end="${requestScope[f:concat('numDiasHoras',pes_sigla)]}">	
													Data: ${requestScope[f:concat(f:concat('dataHoraExtra',i),pes_sigla)]}
													Quantidade de Horas: ${requestScope[f:concat(f:concat('quantHoras',i),pes_sigla)]}
													Feriado ou Domingo ? ${requestScope[f:concat(f:concat('feriadoOuDomingo',i),pes_sigla)]}<br/>
												</c:forEach>
											</c:when>
											
											
											
											<c:otherwise>
													De ${requestScope[f:concat(f:concat('de',i),pes_sigla)]}
													a ${requestScope[f:concat(f:concat('ate',i),pes_sigla)]}
													- ${requestScope[f:concat(f:concat('motivo',i),pes_sigla)]}
											
										<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Falta Injustificada'}">
													(art.44, INCISO I LEI 8112/90)
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Afastamento por J�ri e Outros Serv. Obrigat. por Lei'}">
													(art.102, INCISO VI, LEI 8112/90)
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Afastamento em Virtude de Particip. em Programa de Treinamento'}">
													(art.102, INCISO IV LEI 8112/90)
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Trabalho Prestado nas Elei��es'}">
												 	(art.120, &sect;2� LEI 4737/65 C/C art.98 LEI 9504/97)	
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Compensa��o Decorrente de Trabalho nas Elei��es'}">
												 	(arts.218 e 221/CPP e 412, &sect;2� /CPC)	
											</c:if>

												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Recesso'}">
												 	(PORTARIA DIRFO)	
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Afastamento para Participar de Atividade Instrut�ria'}">
													(art.76-A, LEI 8112/90 C/C art.8� DECRETO 6114/07)	 		
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Aus�ncia/Falta Justificada com Compensa��o'}">
													(art. 44, II da Lei 8112/90)
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Aus�ncia/Falta Justificada sem Compensa��o'}">
													(art. 44, II da Lei 8112/90)
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Aus�ncia por motivo de greve com compensa��o'}">
													(art. 2�, II da Res. 419/2005 do CJF)
											</c:if>
												<c:if
													test="${requestScope[f:concat(f:concat('motivo',i),pes_sigla)] == 'Aus�ncia por motivo de greve sem compensa��o'}">
													(art. 2�, I da Res. 419/2005 do CJF)
											</c:if>
											</c:otherwise>
										</c:choose>
										<br>
									</c:forEach></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
					<h3 align="center">Sem ocorr�ncia dos lan�amentos dispon�veis no
					formul�rio.</h3>
				</c:otherwise>
			</c:choose>

			<c:if test="${servIncluidos eq 'Sim'}">
				<table width="100%" border="1" cellpadding="2" cellspacing="1"
					bgcolor="#000000">
					<tr>
						<td colspan="2" bgcolor="#FFFFFF" align="center"><b>SERVIDOR(ES)
						INCLU�DO(S) DA LOTA��O</b></td>
					</tr>
				</table>
				<table width="100%" border="1" cellpadding="2" cellspacing="1"
					bgcolor="#000000">
					<tr>
						<td bgcolor="#FFFFFF" width="50%" align="center"><b>Nome</b></td>
						<td bgcolor="#FFFFFF" width="25%" align="center"><b>Matr&iacute;cula</b></td>
						<td bgcolor="#FFFFFF" width="25%" align="center"><b>Per�odo/Motivo</b></td>
					</tr>
					<c:forEach var="i" begin="1" end="${numServIncluidos}">
						<tr>
							<td bgcolor="#FFFFFF" width="50%" align="center">${requestScope[f:concat('nomeServIncluido',i)]}
							</td>
							<td bgcolor="#FFFFFF" width="25%" align="center">${requestScope[f:concat('matServIncluido',i)]}
							</td>
							<td bgcolor="#FFFFFF" width="25%" align="center"><c:choose>
								<c:when
									test="${(not empty requestScope[f:concat('dataIncluso',i)])}">
								a partir de ${requestScope[f:concat('dataIncluso',i)]} 
							</c:when>
								<c:otherwise></c:otherwise>
							</c:choose> <c:if
								test="${requestScope[f:concat('periodoAusencia',i)] eq 'Sim'}">: obteve <b>${requestScope[f:concat('ausencia',i)]}</b>
								<c:choose>
									<c:when
										test="${(empty requestScope[f:concat('dataInicio',i)]) and (empty requestScope[f:concat('dataFim',i)])}">
									</c:when>
									<c:when
										test="${requestScope[f:concat('dataInicio',i)] == requestScope[f:concat('dataFim',i)] || empty requestScope[f:concat('dataFim',i)]}">
											no dia <b>${requestScope[f:concat('dataInicio',i)]}</b>.
									</c:when>
									<c:otherwise>
									no per�odo de <b>${requestScope[f:concat('dataInicio',i)]}</b> a <b>${requestScope[f:concat('dataFim',i)]}</b>.
								</c:otherwise>
								</c:choose>
							</c:if></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${servExcluidos eq 'Sim'}">
				<table width="100%" border="1" cellpadding="2" cellspacing="1"
					bgcolor="#000000">
					<tr>
						<td colspan="2" bgcolor="#FFFFFF" align="center"><b>SERVIDOR(ES)
						EXCLU�DO(S) DA LOTA��O</b></td>
					</tr>
				</table>
				<table width="100%" border="1" cellpadding="2" cellspacing="1"
					bgcolor="#000000">
					<tr>
						<td bgcolor="#FFFFFF" width="50%" align="center"><b>Nome</b></td>
						<td bgcolor="#FFFFFF" width="25%" align="center"><b>Matr&iacute;cula</b></td>
						<td bgcolor="#FFFFFF" width="25%" align="center"><b>Per�odo/Motivo</b></td>
					</tr>
					<c:forEach var="j" begin="1" end="${numServExcluidos}">
						<tr>
							<td bgcolor="#FFFFFF" width="50%" align="center">${requestScope[f:concat('nomeServExcluido',j)]}
							</td>
							<td bgcolor="#FFFFFF" width="25%" align="center">${requestScope[f:concat('matServExcluido',j)]}
							</td>
							<td bgcolor="#FFFFFF" width="25%" align="center"><c:choose>
								<c:when
									test="${(not empty requestScope[f:concat('dataExcluido',j)])}">
								a partir de ${requestScope[f:concat('dataExcluido',j)]} 
							</c:when>
								<c:otherwise></c:otherwise>
							</c:choose> <c:if
								test="${requestScope[f:concat('periodoAusenciaExcluido',j)] eq 'Sim'}">: obteve <b>${requestScope[f:concat('ausenciaExcluido',j)]}</b>
								<c:choose>
									<c:when
										test="${(empty requestScope[f:concat('dataInicioExclusao',j)]) and (empty requestScope[f:concat('dataFimExclusao',j)])}">
									</c:when>
									<c:when
										test="${requestScope[f:concat('dataInicioExclusao',j)] == requestScope[f:concat('dataFimExclusao',j)] || empty requestScope[f:concat('dataFimExclusao',j)]}">
											no dia <b>${requestScope[f:concat('dataInicio',j)]}</b>.
									</c:when>
									<c:otherwise>
									no per�odo de <b>${requestScope[f:concat('dataInicioExclusao',j)]}</b> a <b>${requestScope[f:concat('dataFimExclusao',j)]}</b>.
								</c:otherwise>
								</c:choose>
							</c:if></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${informacoesAdicionais eq 'Sim'}">
				<table width="100%" border="1" cellpadding="2" cellspacing="1"
					bgcolor="#000000">
					<tr>
						<td colspan="2" bgcolor="#FFFFFF" align="center"><b>INFORMA��ES
						ADICIONAIS</b></td>
					</tr>
					<tr>
						<td bgcolor="#FFFFFF" width="100%">${informacoes}</td>
					</tr>
				</table>
			</c:if>
		</mod:letra>
		<br />
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />

		</body>

		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</html>
	</mod:documento>
</mod:modelo>
