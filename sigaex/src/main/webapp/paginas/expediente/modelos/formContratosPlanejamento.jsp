<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<mod:modelo>
	<mod:entrevista>
		<div id="desDiv"
			style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 50%; height: 50%; text-align: left; z-index: 1000;">
		<div
			style="width: 600px; margin: 100px auto; background-color: #fff; border: 1px solid #000; padding: 15px; text-align: center;">
		<p align=justify>Justificar a necessidade da contrata��o:
		objetivos, problema a ser resolvido, benef�cios da contrata��o,
		quantitativo estimado e par�metros t�cnicos utilizados para o total
		pretendido.</p>
		</div>
		</div>
		<div id="viaDiv"
			style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 50%; height: 50%; text-align: left; z-index: 1000;">
		<div
			style="width: 600px; margin: 100px auto; background-color: #fff; border: 1px solid #000; padding: 15px; text-align: center;">
		<p align=justify>Verificar, com outras �reas pertinentes, se h�
		viabilidade t�cnica para a aquisi��o do objeto. Ex: infra-estrutura,
		el�trica, peso, compatibilidade etc. Obs: caso a outra �rea n�o s�
		afirme a viabilidade t�cnica, mas tamb�m esteja diretamente envolvida
		na contrata��o, preencha o item 5.</p>
		</div>
		</div>
		<div id="jusDiv"
			style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 50%; height: 50%; text-align: left; z-index: 1000;">
		<div
			style="width: 600px; margin: 100px auto; background-color: #fff; border: 1px solid #000; padding: 15px; text-align: center;">
		<p align=justify>Servi�o cont�nuo � aquele essencial �
		Administra��o P�blica, habitual em raz�o da sua pr�pria destina��o,
		n�o podendo sofrer interrup��o de continuidade, sob pena de causar
		graves preju�zos ao interesse p�blico.</p>
		</div>
		</div>
		<div id="lotDiv"
			style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 50%; height: 50%; text-align: left; z-index: 1000;">
		<div
			style="width: 600px; margin: 100px auto; background-color: #fff; border: 1px solid #000; padding: 15px; text-align: center;">
		<p align=justify>Lote � qualquer remessa composta por v�rias
		unidades de um mesmo item. A regra geral estabelecida pela lei de
		licita��es � que o objeto a ser licitado deve ser divis�vel em tantas
		partes quanto poss�vel, de forma a ampliar a participa��o do maior
		n�mero de licitantes. Por�m em casos justificados, poder� ser feita
		licita��o com itens agregados em lotes. Neste momento, deve ser
		verificada e justificada a forma��o de lotes por raz�es de ordens
		t�cnica. Ap�s a cota��o, pode ser necess�ria a an�lise de forma��o de
		lotes para que a contrata��o de lotes para que a contrata��otorne-se
		que a contrata��o torna-se econocmicamente vi�vel.</p>
		</div>
		</div>
		<div id="conDiv"
			style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 50%; height: 50%; text-align: left; z-index: 1000;">
		<div
			style="width: 600px; margin: 100px auto; background-color: #fff; border: 1px solid #000; padding: 15px; text-align: center;">
		<p align=justify>Verificar, junto aos �rg�os contratantes, se
		houve alguma restri��o na licita��o (impugna��o e recursos) e o
		sucesso da execu��o do contrato. Anexar, se poss�vel, os documentos da
		contrata��o.</p>
		</div>
		</div>
		<div id="relDiv"
			style="visibility: hidden; position: absolute; left: 0px; top: 0px; width: 50%; height: 50%; text-align: left; z-index: 1000;">
		<div
			style="width: 600px; margin: 100px auto; background-color: #fff; border: 1px solid #000; padding: 15px; text-align: center;">
		<p align=justify>Deve ser revisto o processo anterior de
		contrata��o de mesmo objeto, analisando as dificuldades enfrentadas,
		discutindo-as, se for o caso, com o gerente do contrato anterior e
		outros setores envolvidos, para sanear equ�vocos no tempo refer�ncia.</p>
		</div>
		</div>

		<mod:grupo
			titulo="1. Identifica��o da(s) unidade(s)/Servidor(es) respons�vel(is):">
			<mod:grupo>
				<mod:lotacao titulo="Subsecretaria/N�cleo" var="subNucleo"
					obrigatorio="Sim" />
			</mod:grupo>				
			<mod:grupo>
				<mod:selecao var="numFiscais"
					titulo="N�mero de Fiscais T�cnicos/Suplentes" reler="ajax"
					idAjax="numFiscaisAjax" opcoes="1;2;3;4;5;6;7;8;9;10" />
			</mod:grupo>
			<mod:grupo depende="numFiscaisAjax">					
				<c:forEach var="i" begin="1" end="${numFiscais}">
					<mod:grupo>						
						${i})&nbsp;&nbsp;<mod:pessoa titulo="Fiscal T�cnico" var="fisTecnico${i}" obrigatorio="Sim" />						
					</mod:grupo>
					<mod:grupo>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<mod:pessoa titulo="Suplente" var="suplente${i}" obrigatorio="Sim" />
					</mod:grupo>
				</c:forEach>
			</mod:grupo>
			<mod:grupo>					
				<mod:memo titulo="Comiss�o de Recebimento (caso haja)"
					var="comRecebimento" colunas="80" linhas="2" />
			</mod:grupo>
		</mod:grupo>
		

		<hr>

		<mod:grupo>
			<mod:grupo titulo="2. Justificativa:">
				<table>
					<tr>
						<td><span
							onmouseover="javascript: var desDiv = document.getElementById('desDiv'); 
							desDiv.style.visibility = 'visible'; desDiv.style.left = event.clientX + document.body.scrollLeft; 
							desDiv.style.top = event.clientY + document.body.scrollTop - 100"
							onmouseout="document.getElementById('desDiv').style.visibility = 'hidden'">
						<img src="<c:url value='/imagens/interrogation.jpg'/>" width=20
							height=20 /></span></td>
					</tr>
				</table>

				<mod:memo titulo="Descri��o da necessidade/quantitativo"
					var="desNecQuantitativo" colunas="80" linhas="2" obrigatorio="Sim" />

				<table>
					<tr>
						<td><span
							onmouseover="javascript: var viaDiv = document.getElementById('viaDiv'); 
				viaDiv.style.visibility = 'visible'; viaDiv.style.left = event.clientX + document.body.scrollLeft; 
				viaDiv.style.top = event.clientY + document.body.scrollTop - 100"
							onmouseout="document.getElementById('viaDiv').style.visibility = 'hidden'">
						<img src="<c:url value='/imagens/interrogation.jpg'/>" width=20
							height=20 /></span></td>
					</tr>
				</table>

				<mod:memo titulo="Viabilidade t�cnica" var="viaTecnica" colunas="80"
					linhas="2" obrigatorio="Sim" />
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:grupo titulo="3. Identifica��o da contrata��o:">
				<mod:grupo>
					<mod:grupo largura="10">
						<mod:radio titulo="Material" var="identificacao" valor="1"
							reler="ajax" idAjax="identAjax" marcado="Sim" />
					</mod:grupo>
					<mod:grupo largura="90">
						<mod:radio titulo="Servi�o" var="identificacao" valor="2"
							reler="ajax" idAjax="identAjax" />
					</mod:grupo>
				</mod:grupo>
				<c:set var="valIdentContrat" value="${identificacao}" />
				<c:if test="${empty valIdentContrat}">
					<c:set var="valIdentContrat" value="${param['identificacao']}" />
				</c:if>
				<c:if test="${empty valIdentContrat}">
					<c:set var="valIdentContrat" value="1" />
				</c:if>
				<mod:grupo depende="identAjax">
					<c:if test="${valIdentContrat == 1}">
						<mod:grupo titulo="H� necessidade t�cnica de indica��o de marca?">
							<mod:grupo>
								<mod:radio titulo="N�o." var="indicMarca" valor="1"
									marcado="Sim" reler="ajax" idAjax="indicMarcaAjax" />
							</mod:grupo>
							<mod:grupo largura="7">
								<mod:radio titulo="Sim." var="indicMarca" valor="2" reler="ajax"
									idAjax="indicMarcaAjax" />
							</mod:grupo>
							<c:set var="valIndicMarca" value="${indicMarca}" />
							<c:if test="${empty valIndicMarca}">
								<c:set var="valIndicMarca" value="${param['indicMarca']}" />
							</c:if>
							<mod:grupo largura="93">
								<mod:grupo depende="indicMarcaAjax">
									<c:if test="${valIndicMarca == 2}">
										<mod:texto titulo="Justifique" var="jusIndicMarca"
											largura="130" maxcaracteres="190" obrigatorio="Sim" />
									</c:if>
								</mod:grupo>
							</mod:grupo>
						</mod:grupo>
					</c:if>
					<c:if test="${valIdentContrat == 2}">
						<mod:grupo titulo="Haver� aloca��o de m�o de obra?">
							<mod:grupo>
								<mod:radio titulo="N�o." var="servico" valor="1" marcado="Sim" />
							</mod:grupo>
							<mod:grupo>
								<mod:radio
									titulo="Sim. Houve estudo pr�vio sobre a possibilidade de execu��o do servi�o sem
									a presen�a permanente (jornada fixa) <br/>da m�o-de-obra nas depend�ncias da SJRJ."
									var="servico" valor="2" />
							</mod:grupo>
						</mod:grupo>
					</c:if>
				</mod:grupo>

				<mod:grupo titulo="Tipo de Entrega:">
					<mod:grupo>
						<mod:radio titulo="Presta��o �nica." var="tipEntrega" valor="1"
							reler="ajax" marcado="Sim" idAjax="tipEntregaAjax" />
					</mod:grupo>
					<mod:grupo>
						<mod:radio titulo="Presta��o parcelada." var="tipEntrega"
							valor="2" reler="ajax" idAjax="tipEntregaAjax" />
					</mod:grupo>
					<mod:grupo>
						<mod:radio titulo="Presta��o continuada. " var="tipEntrega"
							valor="3" reler="ajax" idAjax="tipEntregaAjax" />
					</mod:grupo>
					<c:set var="valTipEntrega" value="${tipEntrega}" />
					<c:if test="${empty valTipEntrega}">
						<c:set var="valTipEntrega" value="${param['tipEntrega']}" />
					</c:if>
					<mod:grupo depende="tipEntregaAjax">
						<c:if test="${valTipEntrega == 3}">
							<mod:grupo>
								<table>
									<tr>
										<td><span
											onmouseover="javascript: var jusDiv = document.getElementById('jusDiv'); 
											jusDiv.style.visibility = 'visible'; jusDiv.style.left = event.clientX + document.body.scrollLeft; 
											jusDiv.style.top = event.clientY + document.body.scrollTop - 100"
											onmouseout="document.getElementById('jusDiv').style.visibility = 'hidden'">
										<img src="<c:url value='/imagens/interrogation.jpg'/>"
											width=20 height=20 /></span></td>
										<td><mod:texto titulo="Justifique" var="jusTipEntrega"
											largura="138" maxcaracteres="190" obrigatorio="Sim" /></td>
									</tr>
								</table>
							</mod:grupo>
						</c:if>
					</mod:grupo>
				</mod:grupo>
				<mod:grupo>
					<b>A contrata��o ser� por Registro de Pre�o? (consultar <a
						href="http://intranet/documentos/grupo_97/rp_comentario_checklist_planej.pdf" target="_blank"><u>Pr�s
					e Contras do RP</u></a>):</b>
					<mod:grupo largura="100">
						<mod:radio titulo="N�o." var="contratacao" valor="1" marcado="Sim"
							reler="ajax" idAjax="contratacaoAjax" />
					</mod:grupo>
					<mod:grupo largura="7">
						<mod:radio titulo="Sim." var="contratacao" valor="2" reler="ajax"
							idAjax="contratacaoAjax" />
					</mod:grupo>
					<c:set var="valContratacao" value="${contratacao}" />
					<c:if test="${empty valContratacao}">
						<c:set var="valContratacao" value="${param['contratacao']}" />
					</c:if>
					<mod:grupo largura="93">
						<mod:grupo depende="contratacaoAjax">
							<c:if test="${valContratacao == 2}">
								<mod:texto titulo="Justifique" var="jusContratacao" largura="130"
									maxcaracteres="190" obrigatorio="Sim" />
							</c:if>
						</mod:grupo>
					</mod:grupo>
				</mod:grupo>
				<mod:grupo>
					<table>
						<tr>
							<td><span
								onmouseover="javascript: var lotDiv = document.getElementById('lotDiv'); 
						lotDiv.style.visibility = 'visible'; lotDiv.style.left = event.clientX + document.body.scrollLeft; 
						lotDiv.style.top = event.clientY + document.body.scrollTop - 100"
								onmouseout="document.getElementById('lotDiv').style.visibility = 'hidden'">
							<img src="<c:url value='/imagens/interrogation.jpg'/>" width=20
								height=20 /></span></td>
							<td><b>H� necessidade de forma��o de lote por motivos
							t�cnicos?</b></td>
						</tr>
					</table>

					<mod:grupo largura="7">
						<mod:radio titulo="Sim." var="necFormacao" valor="1" reler="ajax"
							idAjax="idFormacaoAjax" />
					</mod:grupo>
					<c:set var="valNecFormacao" value="${necFormacao}" />
					<c:if test="${empty valNecFormacao}">
						<c:set var="valNecFormacao" value="${param['necFormacao']}" />
					</c:if>
					<mod:grupo largura="93">
						<mod:grupo depende="idFormacaoAjax">
							<c:if test="${valNecFormacao == 1}">
								<mod:texto titulo="Justifique" var="jusNecFormacao" largura="130"
									maxcaracteres="500" obrigatorio="Sim" />
							</c:if>
						</mod:grupo>
					</mod:grupo>
					<mod:grupo>
						<mod:radio
							titulo="N�o. A forma��o de lotes em raz�o de valores deve ser avaliada ap�s a cota��o."
							var="necFormacao" valor="2" marcado="Sim" reler="ajax"
							idAjax="idFormacaoAjax" />
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo titulo="4. Vincula��o estrat�gica:">
			<mod:grupo>
				<b>A contrata��o est� vinculada a algum <a
					href="http://intranet/documentos/grupo_113/Acompanhamento_de_Projetos_e_Acoes_%20Bienio%202011_2012.mht" target="_blank"> <u>Projeto
				Estrat�gico Anual da SJRJ</u></a>?</b>
				<mod:grupo>
					<mod:grupo>
						<mod:radio titulo="N�o." var="vinculacao" valor="1" marcado="Sim"
							reler="ajax" idAjax="idVinculacaoAjax" />
					</mod:grupo>
					<mod:grupo largura="7">
						<mod:radio titulo="Sim." var="vinculacao" valor="2" reler="ajax"
							idAjax="idVinculacaoAjax" />
					</mod:grupo>
					<c:set var="valVinculacao" value="${vinculacao}" />
					<c:if test="${empty valVinculacao}">
						<c:set var="valVinculacao" value="${param['vinculacao']}" />
					</c:if>
					<mod:grupo largura="93">
						<mod:grupo depende="idVinculacaoAjax">
							<c:if test="${valVinculacao == 2}">
								<mod:texto titulo="Identifique-o" var="identVincProj"
									largura="80" maxcaracteres="80" obrigatorio="Sim" />
							</c:if>
						</mod:grupo>
					</mod:grupo>
				</mod:grupo>
			</mod:grupo>
			<mod:grupo>
				<b>A partir do <a
					href="http://intranet/documentos/grupo_97/mapa_estrategico.pdf" target="_blank">
				<u>Mapa Estrat�gico da Justi�a Federal</u></a> elaborado pelo CJF,
				identifique <u>um ou mais</u> objetivos estrat�gicos aos quais a
				contrata��o est� vinculada:</b>
			</mod:grupo>

			<mod:oculto var="obj1"
				valor="1. agilizar os tr�mites judiciais e administrativos;" />
			<mod:oculto var="obj2"
				valor="2. otimizar a gest�o dos custos operacionais;" />
			<mod:oculto var="obj3" valor="3. otimizar os processos de trabalho;" />
			<mod:oculto var="obj4"
				valor="4. facilitar o acesso � Justi�a Federal da 2� Regi�o;" />
			<mod:oculto var="obj5"
				valor="5. promover a efetividade no cumprimento das decis�es;" />
			<mod:oculto var="obj6" valor="6. promover a cidadania;" />
			<mod:oculto var="obj7"
				valor="7. incentivar e promover a responsabilidade ambiental;" />
			<mod:oculto var="obj8"
				valor="8. garantir o alinhamento estrat�gico e a integra��o da 
					Justi�a Federal da 2� Regi�o;" />
			<mod:oculto var="obj9"
				valor="9. fortalecer as rela��es da Justi�a Federal da 2� Regi�o
					com outros �rg�os e institui��es;" />
			<mod:oculto var="obj10"
				valor="10. fortalecer a imagem e aperfei�oar a comunica��o 
					da Justi�a Federal da 2� Regi�o;" />
			<mod:oculto var="obj11"
				valor="11. desenvolver conhecimentos, habilidades e atitudes 
					dos magistrados e servidores com foco em resultados;" />
			<mod:oculto var="obj12"
				valor="12. fortalecer o clima organizacional e o bem estar dos magistrados 
					e servidores;" />
			<mod:oculto var="obj13"
				valor="13. garantir a infraestrutura suficiente � execu��o das 
					atividades administrativas e judiciais;" />
			<mod:oculto var="obj14"
				valor="14. garantir o acesso e funcionamento de sistemas 
					essenciais de tecnologia de informa��o;" />
			<mod:oculto var="obj15"
				valor="15. assegurar recursos or�ament�rios e priorizar sua execu��o 
					na estrat�gia." />

			<table cellpadding="4" width="100%" border="0">
				<tr>
					<td><mod:caixaverif titulo="${obj1}" var="objetivo1" /></td>
					<td><mod:caixaverif titulo="${obj8}" var="objetivo8" /></td>
				</tr>
				<tr>
					<td><mod:caixaverif titulo="${obj2}" var="objetivo2" /></td>
					<td><mod:caixaverif titulo="${obj9}" var="objetivo9" /></td>
				</tr>
				<tr>
					<td><mod:caixaverif titulo="${obj3}" var="objetivo3" /></td>
					<td><mod:caixaverif titulo="${obj10}" var="objetivo10" /></td>
				</tr>
				<tr>
					<td><mod:caixaverif titulo="${obj4}" var="objetivo4" /></td>
					<td><mod:caixaverif titulo="${obj11}" var="objetivo11" /></td>
				</tr>
				<tr>
					<td><mod:caixaverif titulo="${obj5}" var="objetivo5" /></td>
					<td><mod:caixaverif titulo="${obj12}" var="objetivo12" /></td>
				</tr>
				<tr>
					<td><mod:caixaverif titulo="${obj6}" var="objetivo6" /></td>

					<td><mod:caixaverif titulo="${obj13}" var="objetivo13" /></td>
				</tr>
				<tr>
					<td><mod:caixaverif titulo="${obj7}" var="objetivo7" /></td>
					<td><mod:caixaverif titulo="${obj14}" var="objetivo14" /></td>
				</tr>
				<tr>
					<td></td>
					<td><mod:caixaverif titulo="${obj15}" var="objetivo15" /></td>
				</tr>
			</table>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:grupo
				titulo="5. Identifica��o e observa��es de unidades envolvidas na contrata��o:">
				<mod:grupo>
					<mod:selecao var="numSubsecretarias"
						titulo="N�mero de Subsecretaria(s)" reler="ajax"
						idAjax="numSubsecretariasAjax" opcoes="0;1;2;3;4;5" />
				</mod:grupo>

				<mod:grupo depende="numSubsecretariasAjax">
					<c:if test="${numSubsecretarias != 0}">
						<mod:grupo titulo="Subsecretaria:" largura="26">
						</mod:grupo>
						<mod:grupo titulo="Atua��o/Observa��es:" largura="74">
						</mod:grupo>					
						<c:forEach var="i" begin="1" end="${numSubsecretarias}">
							<mod:grupo titulo="" largura="25">
								<mod:texto titulo="" var="subsecretaria${i}" largura="30"
									maxcaracteres="30" />
							</mod:grupo>
							<mod:grupo titulo="" largura="75">
								<mod:texto titulo="" var="atuObservacao${i}" largura="110"
									maxcaracteres="140" />
							</mod:grupo>
						</c:forEach>
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo
			titulo="6. H� outras possibilidades de alcance do objetivo almejado?">
			<mod:grupo>
				<mod:radio titulo="N�o." var="posObjetivo" valor="1" marcado="Sim"
					reler="ajax" idAjax="idposObjetivoAjax" />
			</mod:grupo>
			<mod:grupo>
				<mod:radio titulo="Sim." var="posObjetivo" valor="2" reler="ajax"
					idAjax="idposObjetivoAjax" />
			</mod:grupo>
			<c:set var="valposObjetivo" value="${posObjetivo}" />
			<c:if test="${empty valposObjetivo}">
				<c:set var="valposObjetivo" value="${param['posObjetivo']}" />
			</c:if>
			<mod:grupo depende="idposObjetivoAjax">
				<c:if test="${valposObjetivo == 2}">
					<mod:memo
						titulo="(Justificar, analisando a rela��o custo x benef�cio)"
						var="jusObjetivo" colunas="79" linhas="2" obrigatorio="Sim" />
				</c:if>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:grupo titulo="7. Custos estimados:">
				<mod:grupo largura="15">
					<mod:monetario var="valEstimado" formataNum="sim"
						titulo="Valor estimado" reler="sim" />
				</mod:grupo>
				<mod:grupo largura="85">
					<mod:texto
						titulo="Fonte de Recursos (conv�nios/or�amento vigente/cr�dito a ser 
					solicitado/outros)"
						var="fonRecursos" largura="82" maxcaracteres="82" />
				</mod:grupo>

				<br />

				<b>Integra a programa��o or�ament�ria do exerc�cio?</b>
				<mod:grupo largura="100">
					<mod:radio titulo="Sim." var="intProOrcamentaria" valor="1"
						marcado="Sim" reler="ajax" idAjax="intProOrcamentariaAjax" />
				</mod:grupo>
				<mod:grupo largura="100">
					<mod:radio titulo="Sim. (com altera��o do valor original)"
						var="intProOrcamentaria" valor="2" reler="ajax"
						idAjax="intProOrcamentariaAjax" />
				</mod:grupo>
				<mod:grupo largura="100">
					<mod:radio titulo="N�o." var="intProOrcamentaria" valor="3"
						reler="ajax" idAjax="intProOrcamentariaAjax" />
				</mod:grupo>
				<c:set var="valIntProOrcamentaria" value="${intProOrcamentaria}" />
				<c:if test="${empty valIntProOrcamentaria}">
					<c:set var="valIntProOrcamentaria"
						value="${param['intProOrcamentaria']}" />
				</c:if>
				<mod:grupo depende="intProOrcamentariaAjax">
					<c:if test="${valIntProOrcamentaria == 3}">
						<b>Neste caso, h� possibilidade de compensa��o com outro item
						da programa��o autorizada (cota or�ament�ria)?</b>
						<mod:grupo largura="7">
							<mod:radio titulo="Sim." var="intProOrc" valor="1" reler="ajax"
								idAjax="intProOrcAjax" />
						</mod:grupo>

						<c:set var="valIntProOrc" value="${intProOrc}" />
						<c:if test="${empty valIntProOrc}">
							<c:set var="valIntProOrc" value="${param['intProOrc']}" />
						</c:if>
						<mod:grupo largura="93">
							<mod:grupo depende="intProOrcAjax">
								<c:if test="${valIntProOrc == 1}">
									<mod:texto titulo="Qual" var="jusIntProOrc" largura="90"
										maxcaracteres="90" obrigatorio="Sim" />
								</c:if>
							</mod:grupo>
						</mod:grupo>
						<mod:grupo>
							<mod:radio titulo="N�o." var="intProOrc" valor="2" marcado="Sim"
								reler="ajax" idAjax="intProOrcAjax" />
						</mod:grupo>
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:grupo
				titulo="8. Custos adicionais/decorrentes da contrata��o (caso a utiliza��o/consumo 
				do objeto gere outra contrata��o):">
				<mod:grupo>
					<mod:selecao var="numCusAdicionais"
						titulo="N�mero de Custo(s) Adicional(is)" reler="ajax"
						idAjax="numCusAdicionaisAjax" opcoes="0;1;2;3;4;5" />
				</mod:grupo>
				<mod:grupo depende="numCusAdicionaisAjax">
					<c:if test="${numCusAdicionais != 0}">
						<mod:grupo titulo="Contrata��o/Aquisi��o:" largura="68">
						</mod:grupo>
						<mod:grupo titulo="Valor estimado:" largura="32">
						</mod:grupo>					
						<c:forEach var="i" begin="1" end="${numCusAdicionais}">
							<mod:grupo titulo="" largura="68">
								<mod:texto titulo="" var="conAquisicao${i}" largura="83"
									maxcaracteres="83" />
							</mod:grupo>
							<mod:grupo titulo="" largura="32">
								<mod:monetario var="valEstimado${i}" formataNum="sim" titulo=""
									reler="sim" />
							</mod:grupo>
						</c:forEach>
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:grupo titulo="">
				<table>
					<tr>
						<td><span
							onmouseover="javascript: var conDiv = document.getElementById('conDiv'); 
					conDiv.style.visibility = 'visible'; conDiv.style.left = event.clientX + document.body.scrollLeft; 
					conDiv.style.top = event.clientY + document.body.scrollTop - 100"
							onmouseout="document.getElementById('conDiv').style.visibility = 'hidden'">
						<img src="<c:url value='/imagens/interrogation.jpg'/>" width=20
							height=20 /></span></td>
						<td><b>9. Contrata��es semelhantes em outros �rg�os
						(preferencialmente no Poder Judici�rio Federal):</b></td>
					</tr>
				</table>
				<mod:grupo>
					<mod:selecao var="numContratacao"
						titulo="N�mero de Contrata��o(�es)" reler="ajax"
						idAjax="numContratacaoAjax" opcoes="0;1;2;3;4;5" />
				</mod:grupo>
				<mod:grupo depende="numContratacaoAjax">
					<c:if test="${numContratacao != 0}">
						<mod:grupo titulo="�rg�o:" largura="55">
						</mod:grupo>
						<mod:grupo titulo="Valor contratado:" largura="20">
						</mod:grupo>
						<mod:grupo titulo="Exerc�cio:" largura="25">
						</mod:grupo>					
						<c:forEach var="i" begin="1" end="${numContratacao}">
							<mod:grupo titulo="" largura="55">
								<mod:texto titulo="" var="orgao${i}" largura="67"
									maxcaracteres="67" />
							</mod:grupo>
							<mod:grupo titulo="" largura="18">
								<mod:monetario var="valContratado${i}" formataNum="sim" titulo=""
									reler="sim" />
							</mod:grupo>
							<mod:grupo titulo="" largura="27">
								<mod:texto titulo="" var="exercicio${i}" largura="12"
									maxcaracteres="12" />
							</mod:grupo>
						</c:forEach>	
						<mod:grupo>	
							<b>Observa��o(�es):</b>
							<mod:memo titulo="" var="observacao" colunas="79" linhas="2" />
						</mod:grupo>					
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:grupo
				titulo="10. Fatores que podem colocar em risco* a contrata��o:">
				<mod:grupo>
					<mod:selecao var="numFator" titulo="N�mero de Fator(es)"
						reler="ajax" idAjax="numFatorAjax" opcoes="0;1;2;3;4;5" />
				</mod:grupo>
				<mod:grupo depende="numFatorAjax">
					<c:if test="${numFator != 0}">
						<table border="0" cellspacing="0" width="100%">
							<tr>
								<td width="43%" align="left"><br>
								<b>Risco:</b></td>
								<td width="43%" align="left"><br>
								<b>Resposta (a��o para evitar ou diminuir ocorr�ncia do
								risco):</b></td>
								<td width="14%" align="left"><b>U.O. respons�vel<br />
								pela resposta:</b></td>
							</tr>
						</table>
						<table border="0" cellspacing="0" width="100%">
							<c:forEach var="i" begin="1" end="${numFator}">
								<tr>
									<td width="43%" align="left"><mod:memo titulo=""
										var="risco${i}" colunas="50" linhas="2" /></td>
									<td width="43%" align="left"><mod:memo titulo=""
										var="resposta${i}" colunas="50" linhas="2" /></td>
									<td width="14%" align="left"><mod:texto titulo=""
										var="responsavel${i}" largura="15" maxcaracteres="15" /></td>
								</tr>
							</c:forEach>
						</table>
											
						*Risco � um evento incerto que, se ocorrer, impacta em pelo menos um dos objetos do projeto.
					</c:if>
				</mod:grupo>
			</mod:grupo>
		</mod:grupo>

		<hr>

		<mod:grupo>
			<table>
				<tr>
					<td><span
						onmouseover="javascript: var relDiv = document.getElementById('relDiv'); 
						relDiv.style.visibility = 'visible'; relDiv.style.left = event.clientX + document.body.scrollLeft; 
						relDiv.style.top = event.clientY + document.body.scrollTop - 100"
						onmouseout="document.getElementById('relDiv').style.visibility = 'hidden'">
						<img src="<c:url value='/imagens/interrogation.jpg'/>" width=20
						height=20 /></span></td>
					<td><b>11. Rela��o com contrata��es anteriores:</b></td>
				</tr>
			</table>
			<mod:grupo largura="60">
				<mod:texto titulo="Contrata��o anterior/Processo Administrativo"
					var="conAntProAdm" largura="74" maxcaracteres="74" />
			</mod:grupo>
			<mod:grupo largura="40">
				<mod:texto titulo="Vig�ncia - Valor atual" var="vigValAtual"
					largura="30" maxcaracteres="30" />
			</mod:grupo>
			<mod:grupo>
				<mod:memo titulo="Dificuldades encontradas" var="difEncontrada"
					colunas="80" linhas="2" />
			</mod:grupo>
		</mod:grupo>

		<hr>


		<mod:grupo>
			<mod:memo titulo="<b>12. Legisla��o espec�fica pertinente</b>"
				var="legEspPertinente" colunas="80" linhas="2" />
		</mod:grupo>

		<hr>

		<mod:grupo>
			<mod:memo titulo="<b>13. Informa��es complementares</b>"
				var="infComplementar" colunas="80" linhas="2" />
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<c:set var="tl" value="10pt" />
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


		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF">
			<tr>
				<td>
					<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
				</td>
			</tr>
		</table>
	
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda2.jsp" />
		FIM CABECALHO -->

		<br />

		<table width="100%" border="0" align="center">
			<tr>
				<td><b>CHECK LIST DE</b><br />
				<b>PLANEJAMENTO DA CONTRATA��O</b><br />
				</td>
			</tr>
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">1. Identifica��o
				da(s) unidade(s)/Servidor(es)respons�vel(is):</p>
				</td>
			</tr>
		</table>

		<table cellpadding="4" width="100%" border="1">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;"><b>Subsecretaria/N�cleo:&nbsp;&nbsp;&nbsp;</b></p>
				<p style="font-family: Arial; font-size: 10pt;">${requestScope['subNucleo_lotacaoSel.sigla']}&nbsp;-&nbsp;${requestScope['subNucleo_lotacaoSel.descricao']}</p>
				</td>
			</tr>

			<c:forEach var="i" begin="1" end="${numFiscais}">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">${i})&nbsp;<b>Fiscal T�cnico:&nbsp;&nbsp;&nbsp;</b></p>
				<p style="font-family: Arial; font-size: 8pt;">${requestScope[f:concat(f:concat('fisTecnico',i),'_pessoaSel.descricao')]}</p>	<br>			
				<p style="font-family: Arial; font-size: 10pt;"><b>&nbsp;&nbsp;&nbsp;&nbsp;Suplente:&nbsp;&nbsp;&nbsp;</b></p>			
				<p style="font-family: Arial; font-size: 8pt;">${requestScope[f:concat(f:concat('suplente',i),'_pessoaSel.descricao')]}</p>
				</td>

			</tr>
			</c:forEach>

			<c:if test="${not empty comRecebimento}">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>Comiss�o
					de Recebimento (caso haja):&nbsp;&nbsp;&nbsp;</b></p>
					<p style="font-family: Arial; font-size: 8pt;">${comRecebimento}</p>
					</td>
				</tr>
			</c:if>
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">2.
				Justificativa:</p>
				</td>
			</tr>
		</table>

		<table cellpadding="4" width="100%" border="1">
			<ww:if test="${not empty desNecQuantitativo}">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>Descri��o
					da necessidade/quantitativo:</b></p>
					</td>
				</tr>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">${desNecQuantitativo}</p>
					</td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>Descri��o
					da necessidade/quantitativo:</b></p>
					</td>
				</tr>
				<tr>
					<td align="left" width="70%">
					<p style="font-family: Arial; font-size: 8pt;">N�o h�
					necessidade/quantitativo.</p>
					</td>
				</tr>
			</ww:else>
			<ww:if test="${not empty viaTecnica}">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>Viabilidade
					t�cnica:&nbsp;&nbsp;&nbsp;</b></p>
					</td>
				</tr>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">${viaTecnica}</p>
					</td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>Viabilidade
					t�cnica:&nbsp;&nbsp;&nbsp;</b></p>
					</td>
				</tr>
				<tr>
					<td align="left" width="70%">
					<p style="font-family: Arial; font-size: 8pt;">N�o h�
					viabilidade t�cnica.</p>
					</td>
				</tr>
			</ww:else>
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">3. Identifica��o
				da contrata��o:&nbsp;</p>
				<ww:if test="${identificacao == '1'}">
					<p style="font-family: Arial; font-size: 10pt;"><b>Material</b></p>
				</ww:if> <ww:else>
					<p style="font-family: Arial; font-size: 10pt;"><b>Servi�o</b></p>
				</ww:else></td>
			</tr>
		</table>

		<c:if test="${identificacao == '1'}">
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>H�
					necessidade t�cnica de indica��o de marca?</b></p>
					</td>
				</tr>
				<ww:if test="${indicMarca == '1'}">
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
						</td>
					</tr>
				</ww:if>
				<ww:else>
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">Sim.&nbsp;${jusIndicMarca}</p>
						</td>
					</tr>
				</ww:else>
			</table>
		</c:if>
		<c:if test="${identificacao == '2'}">
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 10pt;"><b>Haver�
					aloca��o de m�o-de-obra?</b></p>
					</td>
				</tr>
				<ww:if test="${servico == '1'}">
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
						</td>
					</tr>
				</ww:if>
				<ww:else>
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">Sim,<b>houve
						estudo pr�vio sobre a possibilidade de execu��o do servi�o sem a
						presen�a permanente (jornada fixa) da m�o-de-obra nas depend�ncias
						da SJRJ.<b></p>
						</td>
					</tr>
				</ww:else>
			</table>
		</c:if>

		<table cellpadding="4" width="100%" border="1">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;"><b>Tipo de
				entrega:</b></p>
				</td>
			</tr>
			<c:choose>
				<c:when test="${tipEntrega == '1'}">
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">Presta��o
						�nica.</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${tipEntrega == '2'}">
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">Presta��o
						parcelada.</p>
						</td>
					</tr>
				</c:when>

				<c:when test="${tipEntrega == '3'}">
					<tr>
						<td>
						<p style="font-family: Arial; font-size: 8pt;">Presta��o
						continuada.&nbsp;${jusTipEntrega}</p>
						</td>
					</tr>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</table>

		<table cellpadding="4" width="100%" border="1">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;"><b>A
				contrata��o ser� por Registro de Pre�o? (Consultar Pr�s e Contras do
				RP):</b></p>
				</td>
			</tr>
			<ww:if test="${contratacao == '1'}">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
					</td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">
					Sim.&nbsp;${jusContratacao}</p>
					</td>
				</tr>
			</ww:else>
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;"><b>H�
				necessidade de forma��o de lote por motivos t�cnicos?</b></p>
				</td>
			</tr>
			<ww:if test="${necFormacao == '1'}">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">
					Sim.&nbsp;${jusNecFormacao}</p>
					</td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">N�o. A forma��o
					de lotes em raz�o de valores deve ser avaliada ap�s a cota��o.</p>
					</td>
				</tr>
			</ww:else>
		</table>
		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">4. Vincula��o
				estrat�gica:</p>
				</td>
			</tr>
		</table>

		<table cellpadding="4" width="100%" border="1">
			<tr>
				<td align="center">
				<p style="font-family: Arial; font-size: 10pt;"><b>Projeto
				Estrat�gico da SJRJ</b></p>
				</td>
				<td align="center">
				<p style="font-family: Arial; font-size: 10pt;"><b>Mapa
				Estrat�gico da Justi�a Federal</b></p>
				</td>
			</tr>
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 9pt;"><b>A
				contrata��o est� vinculada a algum Projeto Estrat�gico Anual da
				SJRJ?</b></p>
				<br>
				<ww:if test="${vinculacao == '1'}">
					<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
				</ww:if> <ww:else>
					<p style="font-family: Arial; font-size: 8pt;">Sim.&nbsp;${identVincProj}</p>
				</ww:else></td>
				<td>
				<p style="font-family: Arial; font-size: 9pt;"><b>Objetivo(s)
				estrat�gico(s) ao(s) qual(is) a contrata��o est� vinculada, a partir
				do Mapa Estrat�gico da Justi�a Federal elaborado pelo CJF:</b></p>
				<br>
				<c:forEach var="i" begin="1" end="15">
					<c:if test="${requestScope[f:concat('objetivo',i)] == 'Sim'}">
						<p style="font-family: Arial; font-size: 8pt;">${requestScope[f:concat('obj',i)]}</p>
						<br>
					</c:if>
				</c:forEach></td>
			</tr>
		</table>




		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td colspan="3">
				<p style="font-family: Arial; font-size: 10pt;">5. Identifica��o
				e observa��es de unidades envolvidas na contrata��o:</p>
				</td>
			</tr>
		</table>

		<ww:if test="${numSubsecretarias != 0}">
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="center" width="70%">
					<p style="font-family: Arial; font-size: 10pt;"><b>Subsecretaria</b></p>
					</td>
					<td align="center" width="235%">
					<p style="font-family: Arial; font-size: 10pt;"><b>Atua��o/Observa��es</b></p>
					</td>
				</tr>
			</table>

			<table cellpadding="4" width="100%" border="1">
				<c:forEach var="i" begin="1" end="${numSubsecretarias}">
					<tr>
						<td align="center" width="70%">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('subsecretaria',i)]}</p>
						</td>
						<td align="left" width="235%">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('atuObservacao',i)]}</p>
						</td>
					</tr>
				</c:forEach>
			</table>
		</ww:if>
		<ww:else>
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="left" width="70%">
					<p style="font-family: Arial; font-size: 8pt;">N�o h�
					Subsecretarias e observa��es.</p>
					</td>
				</tr>
			</table>
		</ww:else>

		<br>

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td colspan="3">
				<p style="font-family: Arial; font-size: 10pt;">6. H� outras
				possibilidades de alcance do objetivo almejado?</p>
				</td>
			</tr>
		</table>

		<table cellpadding="4" width="100%" border="1">
			<ww:if test="${posObjetivo == '1'}">
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
					</td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td>
					<p style="font-family: Arial; font-size: 8pt;">
					Sim.&nbsp;${jusObjetivo}</p>
					</td>
				</tr>
			</ww:else>
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">7. Custos
				estimados:</p>
				</td>
			</tr>
		</table>

		<table cellpadding="4" width="100%" border="1">
			<tr>
				<td align="center" width="70">
				<p style="font-family: Arial; font-size: 10pt;"><b>Valor
				estimado</b></p>
				</td>
				<td width="235">
				<p style="font-family: Arial; font-size: 10pt;"><b>Fonte de
				Recursos<br />
				(conv�nios/or�amento vigente/cr�dito a ser solicitado/outros)</b></p>
				</td>
			</tr>
			<tr>
				<td align="center" width="70">
				<p style="font-family: Arial; font-size: 8pt;">${valEstimado}</p>
				</td>
				<td width="235">
				<p style="font-family: Arial; font-size: 8pt;">${fonRecursos}</p>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<p style="font-family: Arial; font-size: 10pt;"><b>Integra a
				programa��o or�ament�ria do exerc�cio?</b></p>
				</td>
			</tr>
			<c:choose>
				<c:when test="${intProOrcamentaria == '1'}">
					<tr>
						<td colspan="2">
						<p style="font-family: Arial; font-size: 8pt;">Sim.</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${intProOrcamentaria == '2'}">
					<tr>
						<td colspan="2">
						<p style="font-family: Arial; font-size: 8pt;">Sim. (com
						altera��o do valor original).</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${intProOrcamentaria == '3'}">
					<tr>
						<td colspan="2">
						<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<p style="font-family: Arial; font-size: 10pt;"><b>Neste
						caso, h� possibilidade de compensa��o com outro item da
						programa��o autorizada (cota or�ament�ria)?</b></p>
						</td>
					</tr>
					<ww:if test="${intProOrc == '1'}">
						<tr>
							<td colspan="2">
							<p style="font-family: Arial; font-size: 8pt;">Sim.
							${jusIntProOrc}</p>
							</td>
						</tr>
					</ww:if>
					<ww:else>
						<tr>
							<td colspan="2">
							<p style="font-family: Arial; font-size: 8pt;">N�o.</p>
							</td>
						</tr>
					</ww:else>
				</c:when>
			</c:choose>
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">8. Custos
				adicionais/decorrentes da contrata��o (caso a utiliza��o/consumo do
				objeto gere outra contrata��o):</p>
				</td>
			</tr>
		</table>

		<ww:if test="${numCusAdicionais != 0}">
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="center" width="230">
					<p style="font-family: Arial; font-size: 10pt;"><b>Contrata��o/Aquisi��o</b></p>
					</td>
					<td align="center" width="70">
					<p style="font-family: Arial; font-size: 10pt;"><b>Valor
					estimado</b></p>
					</td>
				</tr>
			</table>

			<table cellpadding="4" width="100%" border="1">
				<c:forEach var="i" begin="1" end="${numCusAdicionais}">
					<tr>
						<td width="230">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('conAquisicao',i)]}</p>
						</td>
						<td align="center" width="70">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('valEstimado',i)]}</p>
						</td>
					</tr>
				</c:forEach>
			</table>
		</ww:if>
		<ww:else>
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="left" width="70%">
					<p style="font-family: Arial; font-size: 8pt;">N�o h� custos
					adicionais.</p>
					</td>
				</tr>
			</table>
		</ww:else>

		<br />


		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">9. Contrata��es
				semelhantes em outros �rg�os (preferencialmente no Poder Judici�rio
				Federal):</p>
				</td>
			</tr>
		</table>
		<ww:if test="${numContratacao != 0}">
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="center" width="170">
					<p style="font-family: Arial; font-size: 10pt;"><b>�rg�o</b></p>
					</td>
					<td align="center" width="65">
					<p style="font-family: Arial; font-size: 10pt;"><b>Valor
					contratado</b></p>
					</td>
					<td align="center" width="65">
					<p style="font-family: Arial; font-size: 10pt;"><b>Exerc�cio</b></p>
					</td>
				</tr>
			</table>
			<table cellpadding="4" width="100%" border="1">
				<c:forEach var="i" begin="1" end="${numContratacao}">
					<tr>
						<td align="left" width="170">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('orgao',i)]}</p>
						</td>
						<td align="center" width="65">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('valContratado',i)]}</p>
						</td>
						<td align="center" width="65">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('exercicio',i)]}</p>
						</td>
					</tr>
				</c:forEach>
			</table>
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td colspan="3">
					<p style="font-family: Arial; font-size: 10pt;"><b>Observa��o(�es):</b>&nbsp;</p>
					<p style="font-family: Arial; font-size: 8pt;">${observacao}</p>
					</td>
			</table>
		</ww:if>
		<ww:else>
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="left" width="70%">
					<p style="font-family: Arial; font-size: 8pt;">N�o h�
					contrata��es semelhantes.</p>
					</td>
				</tr>
			</table>
		</ww:else>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td>
				<p style="font-family: Arial; font-size: 10pt;">10. Fatores que
				podem colocar em risco a contrata��o:</p>
				</td>
			</tr>
		</table>
		<ww:if test="${numFator != 0}">
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="center" width="43%">
					<p style="font-family: Arial; font-size: 8pt;"><b>Risco*</b></p>
					</td>
					<td align="left" width="43%">
					<p style="font-family: Arial; font-size: 8pt;"><b>Resposta
					(a��o para evitar ou diminuir ocorr�ncia do risco)</b></p>
					</td>
					<td align="center" width="14%">
					<p style="font-family: Arial; font-size: 8pt;"><b>U.O.
					respons�vel<br />
					pela resposta</b></p>
					</td>
				</tr>
			</table>

			<table cellpadding="4" width="100%" border="1">
				<c:forEach var="i" begin="1" end="${numFator}">
					<tr>
						<td align="left" width="43%">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('risco',i)]}</p>
						</td>
						<td align="left" width="43%">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('resposta',i)]}</p>
						</td>
						<td align="center" width="14%">
						<p style="font-family: Arial; font-size: 8pt;">
						${requestScope[f:concat('responsavel',i)]}</p>
						</td>
					</tr>
				</c:forEach>
			</table>
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td colspan="3">
					<p style="font-family: Arial; font-size: 10pt;"><b>*</b>Risco �
					um evento que, se ocorrer, impacta em pelo menos um dos objetivos
					do projeto.</p>
					</td>
				</tr>
			</table>
		</ww:if>
		<ww:else>
			<table cellpadding="4" width="100%" border="1">
				<tr>
					<td align="left" width="70%">
					<p style="font-family: Arial; font-size: 8pt;">N�o h� fatores
					de risco.</p>
					</td>
				</tr>
			</table>
		</ww:else>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td colspan="2"><p style="font-family: Arial; font-size: 10pt;">11. Rela��o com contrata��es anteriores:</p></td>
			</tr>
		</table>
		<table cellpadding="4" width="100%" border="1">
			<ww:if test="${not empty conAntProAdm || not empty vigValAtual}">
				<tr>
					<td align="left" width="220"><p style="font-family: Arial; font-size: 10pt;"><b>Contrata��o anterior/Processo Administrativo</b></p></td>
					<td align="center" width="80"><p style="font-family: Arial; font-size: 10pt;"><b>Vig�ncia - Valor atual</b></p></td>
				</tr>
				<tr>
					<td><p style="font-family: Arial; font-size: 8pt;">${conAntProAdm}</p></td>
					<td align="center"><p style="font-family: Arial; font-size: 8pt;">${vigValAtual}</p></td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td colspan="2" align="left" width="70%"><p style="font-family: Arial; font-size: 8pt;">N�o houve contrata��es anteriores.</p></td>
				</tr>
			</ww:else>
			
			<ww:if test="${not empty difEncontrada}">
				<tr>
					<td colspan="2" align="center"><p style="font-family: Arial; font-size: 10pt;"><b>Dificuldades encontradas:</b></p></td>
				</tr>
				
				<tr>
					<td colspan="2"><p style="font-family: Arial; font-size: 8pt;">${difEncontrada}</p></td>
				</tr>
			</ww:if>
			
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td><p style="font-family: Arial; font-size: 10pt;">12. Legisla��o espec�fica pertinente:</p></td>
			</tr>
		</table>
		<table cellpadding="4" width="100%" border="1">
			<ww:if test="${not empty legEspPertinente}">
				<tr>
					<td><p style="font-family: Arial; font-size: 8pt;">${legEspPertinente}</p></td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td align="left" width="70%"><p style="font-family: Arial; font-size: 8pt;">N�o h� legisla��o pertinente.</p></td>
				</tr>
			</ww:else>			
		</table>

		<br />

		<table cellpadding="4" width="100%" border="0">
			<tr>
				<td><p style="font-family: Arial; font-size: 10pt;">13. Informa��es complementares:</p></td>
			</tr>
		</table>	
		<table cellpadding="4" width="100%" border="1">
			<ww:if test="${not empty infComplementar}">
				<tr>
					<td><p style="font-family: Arial; font-size: 8pt;">${infComplementar}</p></td>
				</tr>
			</ww:if>
			<ww:else>
				<tr>
					<td align="left" width="70%"><p style="font-family: Arial; font-size: 8pt;">N�o h� informa��es complementares.</p></td>
				</tr>
			</ww:else>			
		</table>

		<br />

		<!-- INICIO PRIMEIRO RODAPE
			<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
			FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
			<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
			FIM RODAPE -->

		</body>
		</html>
	</mod:documento>
</mod:modelo>
