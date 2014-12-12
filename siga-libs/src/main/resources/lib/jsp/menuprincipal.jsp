<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>

<li><a id="menu_siga" class="" href="#">SIGA</a>
	<ul>
		<li><a href="/siga/principal.action">P�gina Inicial</a>
		</li>
		<c:if test="${empty pagina_de_erro}">
			<li><a href="#">M�dulos</a>
				<ul>
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;DOC:M�dulo de Documentos')}">
						<li><a
							href="/sigaex/expediente/doc/listar.action?primeiraVez=sim">Documentos</a>
						</li>
					</c:if>

					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF:M�dulo de Workflow')}">
						<li><a href="/sigawf/resumo.action">Workflow</a>
						</li>
					</c:if>

					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;SR')}">
						<li><a href="/sigasr/">Servi�os</a>
						</li>
					</c:if>

					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GC:M�dulo de Gest�o de Conhecimento')}">
						<li><a href="/sigagc/app/estatisticaGeral">Gest�o de Conhecimento</a>
						</li>
					</c:if>
					

					<!-- <li><a href="/sigatr/">Treinamento</a>
					</li> -->
					<!-- <li><a href="/SigaServicos/">Servi�os</a>
					</li> -->
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;AQ: M�dulo de Adicional de Qualifica��o') or 
						f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;BNF: M�dulo de Benef�cios') or 
						f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;CAD: M�dulo de Cadastro') or 
						f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;CST: M�dulo de Consultas') or 
						f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;LOT: M�dulo de Lota��o') or 
						f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;TRN: M�dulo de Treinamento')}">
						<li><a href="#">Pessoas</a>
							<ul>
								<c:if
									test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;AQ: M�dulo de Adicional de Qualifica��o')}">
									<li><a href="${f:getURLSistema('siga.sgp.aq')}">AQ</a></li>
								</c:if>
								<c:if
									test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;BNF: M�dulo de Benef�cios')}">
									<li><a href="${f:getURLSistema('siga.sgp.bnf')}">Benef�cios</a>
									</li>
								</c:if>
								<c:if
									test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;CAD: M�dulo de Cadastro')}">
									<li><a href="${f:getURLSistema('siga.sgp.cad')}">Cadastro</a>
									</li>
								</c:if>
								<c:if
									test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;CST: M�dulo de Consultas')}">
									<li><a href="${f:getURLSistema('siga.sgp.cst')}">Consultas</a>
									</li>
								</c:if>
								<c:if
									test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;LOT: M�dulo de Lota��o')}">
									<li><a href="${f:getURLSistema('siga.sgp.lot')}">Lota��o</a>
									</li>
								</c:if>
								<c:if
									test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;TRN: M�dulo de Treinamento')}">
									<li><a href="${f:getURLSistema('siga.sgp.trn')}">Treinamento</a>
									</li>
								</c:if>
							</ul>
						</li>
					</c:if>
					
					<c:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;PP:Agendamento de per�cias do INSS')}">
					<li><a href="#">Agendas</a>
						<ul>
							<c:if
								test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;PP')}">
								<li><a href="/sigapp/">Per�cias M�dicas</a>
								</li>
							</c:if>
						</ul>
					</li>
					</c:if>
						
					<c:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;TP:M�dulo de Transportes')}">
                    	<li><a href="/sigatp/">Transportes</a>
                    </li>
                </c:if>
					
				</ul>
			</li>
			<li><a href="#">Administra��o</a>
				<ul>
					<li><ww:a href="/siga/trocar_senha.action">Trocar senha</ww:a>
					</li>
					<%--
					<li><a href="/siga/substituicao/substituir.action">Entrar
							como substituto</a>
					</li>
					<c:if
						test="${(not empty lotaTitular && lotaTitular.idLotacao!=cadastrante.lotacao.idLotacao) ||(not empty titular && titular.idPessoa!=cadastrante.idPessoa)}">
						<li><ww:a href="/siga/substituicao/finalizar.action">Finalizar substitui��o de 
					<c:choose>
									<c:when
										test="${not empty titular && titular.idPessoa!=cadastrante.idPessoa}">${titular.nomePessoa}</c:when>
									<c:otherwise>${lotaTitular.sigla}</c:otherwise>
								</c:choose>
							</ww:a>
						</li>
					</c:if>
					 --%>
					<ww:if
						test="${(cadastrante.idPessoa != titular.idPessoa) || (cadastrante.lotacao.idLotacao != lotaTitular.idLotacao)}">
						<%-- � uma substitui��o --%>
						<c:if
							test="${f:podeCadastrarQqSubstituicaoPorConfiguracao(cadastrante, cadastrante.lotacao)}">
							<li><ww:a
									href="${serverAndPort}/siga/substituicao/listar.action">Gerenciar poss�veis substitutos</ww:a>
							</li>
						</c:if>
					</ww:if>
					<ww:else>
						<li><ww:a
								href="${serverAndPort}/siga/substituicao/listar.action">Gerenciar poss�veis substitutos</ww:a>
						</li>
					</ww:else>
				</ul>
			</li>


			<c:if
				test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gest�o Administrativa;GI:M�dulo de Gest�o de Identidade')}">
				<li><a href="#">Gest�o de Identidade</a>
					<ul>
						<c:if
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;ID:Gerenciar identidades')}">
							<li><ww:a href="/siga/gi/identidade/listar.action">Identidade</ww:a>
							</li>
						</c:if>
						<c:if
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;PERMISSAO:Gerenciar permiss�es')}">
							<li><ww:a href="/siga/gi/acesso/listar.action">Configurar Permiss�es</ww:a>
							</li>
						</c:if>
						<c:if
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;PERFIL:Gerenciar perfis de acesso')}">
							<li><ww:a href="/siga/gi/perfil/listar.action">Perfil de Acesso</ww:a>
							</li>
						</c:if>
						<c:if
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;PERFILJEE:Gerenciar perfis do JEE')}">
							<li><ww:a href="/siga/gi/perfiljee/listar.action">Perfil de Acesso do JEE</ww:a>
							</li>
						</c:if>
						<c:if 						
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;GDISTR:Gerenciar grupos de distribui��o')
							       || (f:podeGerirAlgumGrupo(titular,lotaTitular,2) && f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;GDISTR;DELEG:Gerenciar grupos de distribui��o delegados'))}"> 	
	 						<li><ww:a
									href="${serverAndPort}/siga/gi/email/listar.action">Grupo de Distribui��o</ww:a>
							</li>
						</c:if>
						<c:if
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;SELFSERVICE:Gerenciar servi�os da pr�pria lota��o')}">
							<li><ww:a href="/siga/gi/servico/acesso.action">Acesso a Servi�os</ww:a>
							</li>
						</c:if>
						<c:if
							test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;REL:Gerar relat�rios')}">
							<li><a href="#">Relat�rios</a>
								<ul>
									<li><ww:a
											href="/siga/gi/relatorio/selecionar_acesso_servico.action">Acesso aos Servi�os</ww:a>
									</li>
									<li><ww:a
											href="/siga/gi/relatorio/selecionar_permissao_usuario.action">Permiss�es de Usu�rio</ww:a>
									</li>
									<li><ww:a
											href="/siga/gi/relatorio/selecionar_alteracao_direitos.action">Altera��o de Direitos</ww:a>
									</li>
									<li><ww:a
											href="/siga/gi/relatorio/selecionar_historico_usuario.action">Hist�rico de Usu�rio</ww:a>
									</li>
								</ul></li>
						</c:if>
					</ul></li>
			</c:if>
		</c:if>

		<c:if
			test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA:Sistema Integrado de Gest�o Administrativa;FE:Ferramentas')}">
			<li><a href="#">Ferramentas</a>
				<ul>
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;FE;MODVER:Visualizar modelos')}">
						<li><ww:a href="/siga/modelo/listar.action">Cadastro de Formas</ww:a>
						</li>
					</c:if>				
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;FE;MODVER:Visualizar modelos')}">
						<li><ww:a href="/siga/modelo/listar.action">Cadastro de modelos</ww:a>
						</li>
					</c:if>
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;FE;CAD_ORGAO:Cadastrar Org�os')}">
						<li><ww:a href="/siga/orgao/listar.action">Cadastro de Org�os Externos</ww:a>
						</li>
					</c:if>
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;FE;WF_ADMIN:Administrar SIGAWF')}">
						<li><ww:a href="/sigawf/administrar.action">Administrar SIGA WF</ww:a>
						</li>
					</c:if>
					<c:if
						test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;FE;CAD_FERIADO:Cadastrar Feriados')}">
						<li><ww:a href="/siga/feriado/listar.action">Cadastro de Feriados</ww:a></li>
					</c:if>	
				</ul></li>
		</c:if>

		<%--	<li><a target="_blank"
			href="/wiki/Wiki.jsp?page=${f:removeAcento(titulo)}">Ajuda</a></li>
 --%>
		<li><a href="#">Substituir</a>
			<ul class="navmenu-large">
				<c:forEach var="substituicao" items="${meusTitulares}">
					<li><a
						style="border-left: 0px; float: right; padding-left: 0.5em; padding-right: 0.5em;"
						href="javascript:if (confirm('Deseja excluir substitui��o?')) location.href='/siga/substituicao/excluir.action?id=${substituicao.idSubstituicao}&porMenu=true';">
							<img style="display: inline;"
							src="/siga/css/famfamfam/icons/cancel_gray.png" title="Excluir"
							onmouseover="this.src='/siga/css/famfamfam/icons/cancel.png';"
							onmouseout="this.src='/siga/css/famfamfam/icons/cancel_gray.png';">
					</a> <a
						href="/siga/substituicao/substituir_gravar.action?idTitular=${substituicao.titular.idPessoa}&idLotaTitular=${substituicao.lotaTitular.idLotacao}">
							<c:choose>
								<c:when test="${not empty substituicao.titular}">
						${f:maiusculasEMinusculas(substituicao.titular.nomePessoa)}
					</c:when>
								<c:otherwise>
						${f:maiusculasEMinusculas(substituicao.lotaTitular.nomeLotacao)}
					</c:otherwise>
							</c:choose> </a>
					</li>
				</c:forEach>

			</ul>
		</li>


		<li><ww:a href="/siga/logoff.action">Logoff</ww:a>
		</li>

	</ul>
</li>
<!-- insert menu -->
<c:import url="/paginas/menus/menu.jsp"></c:import>

