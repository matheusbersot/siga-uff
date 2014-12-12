<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
VAC�NCIA -->

<script language="javascript">
var newwin = null;
</script>

<c:set var="textoRodape"
	value="Documentos imprescind�veis para instru��o do processo administrativo, consoante Resolu��o n.� 148, de 26/05/95, do Conselho da Justi�a Federal e Ordem de Servi�o n� 04, de 03/10/2001, da Dire��o do Foro."
	scope="request" />
<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>

		<mod:grupo titulo="DETALHES DA VAC�NCIA">
			<mod:texto titulo="Cargo a ser ocupado" var="cargoASerOcupado" />
			<mod:texto titulo="�rg�o" var="orgao" />
		</mod:grupo>
		<mod:grupo>
			<mod:data titulo="Data da Posse" var="dataDaPosse" />
		</mod:grupo>
		<%--<mod:selecao var="numDependentes" titulo="Numero de dependentes"
			opcoes="1;2;3;4;5;6;7;8;9" />--%>
		<mod:grupo titulo="CONTATOS">
			<mod:texto titulo="Endere�o" var="endereco" largura="70" />
			<mod:texto titulo="Cep" largura="13" var="cep" />
		</mod:grupo>

		<mod:grupo>
			<mod:texto titulo="Telefone (1)" var="tel1" />
			<mod:texto titulo="Telefone (2)" var="tel2" />
		</mod:grupo>

		<mod:grupo titulo="DOCUMENTOS ANEXOS AO REQUERIMENTO">
			<mod:caixaverif
				titulo="Declara��o de bens atualizada at� a data da vac�ncia, com os respectivos valores;"
				var="declaraBensAnex" reler="N�o" />
		</mod:grupo>

		<mod:grupo>
			<mod:caixaverif titulo="Declara��o de Devolu��o do Token;"
				var="declaraDevolvToken" reler="N�o" />
		</mod:grupo>

		<mod:grupo>
			<mod:caixaverif
				titulo="C�pias da declara��o de Imposto de renda e recibo de entrega ou declara��o de isen��o;"
				var="IrpfCopiaAnex" reler="N�o" />
		</mod:grupo>
		<mod:grupo>
			<mod:caixaverif titulo="C�pia do CPF;" var="cpfAnex" reler="N�o" />
		</mod:grupo>
		<mod:grupo>
			<mod:radio titulo="Termo de posse no novo cargo"
				var="termoPosseComprom" valor="posse" reler="sim" />
		</mod:grupo>
		<mod:grupo>
			<mod:radio titulo="Termo de compromisso"
				var="termoPosseComprom" valor="compromisso" reler="sim" />
		</mod:grupo>

		<c:if test="${(param['termoPosseComprom'] eq 'compromisso') || (requestScope['termoPosseComprom'] eq 'compromisso')}">
			<mod:obrigatorios />
			<br/>
			<mod:grupo>
				<mod:caixaverif titulo="Comprometo-me a entregar o termo de posse no prazo de 02 (dois) dia �teis, contados da data da posse no novo cargo p�blico inacumul�vel, para fins de instru��o do processo administrativo de vac�ncia"
					var="comprometoMe" reler="N�o" obrigatorio="Sim" />
			</mod:grupo>	
		</c:if>
		
		<c:set var="labelOutrosDocs">Outros documentos fora da lista. <b>Separar por v�rgula</b></c:set>
		<mod:texto titulo="${labelOutrosDocs}" var="outroDoc" largura="50"/>
		<%--<mod:grupo>
			<mod:memo colunas="80" linhas="1"
				titulo="Outros documentos fora da lista. Separar por v�rgula." var="outroDoc" />
		</mod:grupo>--%>

		<mod:grupo titulo="ITENS QUE EST�O SENDO DEVOLVIDOS">
			<mod:grupo>
				<mod:caixaverif
					titulo="Crach� Funcional e Carteira Funcional � SECAD;"
					var="crachaDev" reler="N�o" />
			</mod:grupo>

			<mod:grupo>
				<mod:caixaverif
					titulo="Carteiras do Plano de Sa�de do Titular e do(s) dependente(s) � SEBEN;"
					var="carteiraSaudeDev" reler="N�o" />
			</mod:grupo>

			<mod:grupo>
				<mod:caixaverif
					titulo="Documento emitido pelo �rg�o promotor do curso de forma��o de que n�o percebeu o aux�lio financeiro;"
					var="documentoCurso" reler="N�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:caixaverif
					titulo="Comprovante de recolhimento de contribui��o para a Previd�ncia Social, do servidor p�blico, durante o curso de forma��o � CLCP;"
					var="comprovanteContribuicao" reler="N�o" />

			</mod:grupo>
			<mod:grupo>
				<mod:caixaverif
					titulo="Comprovante de Frequ�ncia durante o curso de forma��o � CLCP."
					var="comprovanteFrequencia" reler="N�o" />

			</mod:grupo>
			<c:set var="labelOutrosDocs">Outros itens fora da lista. <b>Separar por v�rgula</b></c:set>
		<mod:texto titulo="${labelOutrosDocs}" var="outroItem" largura="50"/>
		</mod:grupo>
		<br/>
		<mod:grupo><mod:mensagem titulo="Aten��o"
				texto="preencha o destinat�rio com Seleg e, ap�s finalizar, transfira para a Seleg." vermelho="Sim" /></mod:grupo>
		<br/>
		<c:set var="conteudo1">
			Acarreta perda de v�nculo com a Administra��o P�blica, com pagamento de indeniza��o de f�rias. 
		</c:set>
		<c:set var="conteudo2">
			Acarreta manuten��o do v�nculo com a Administra��o P�blica, o que possibilita averba��o de tempo para f�rias (n�o havendo pagamento de indeniza��o de f�rias) e manuten��o de determinadas vantagens pessoais.
		</c:set>
		<c:set var="textoCiencia">
			<b>Estou ciente das diferentes consequ�ncias entre a  
			<span onmouseover="this.style.cursor='hand';" 
			onclick="javascript: if (newwin!=null) newwin.close(); newwin = window.open('teste',null,'height=50,width=400,status=no,toolbar=no,menubar=no,location=no'); newwin.document.write('${conteudo1}');">
				<u> exonera��o a pedido</u></span> 
			e a 
			<span onmouseover="this.style.cursor='hand';" onclick="javascript: if (newwin!=null) newwin.close; newwin.close(); newwin = window.open('teste2',null,'height=125,width=400,status=no,toolbar=no,menubar=no,location=no'); newwin.document.write('${conteudo2}');"><u>
			vac�ncia por posse em outro cargo inacumul�vel</u></span> </b>
		</c:set>
		<mod:obrigatorios />
			<br/>
		<mod:caixaverif titulo="${textoCiencia}" var="ciente" obrigatorio="Sim"/>
	</mod:entrevista>

	<mod:documento>

		<mod:valor var="texto_requerimento">
			<p style="TEXT-INDENT: 2cm" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo},
			${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao} vem requerer a Vossa Excel�ncia
			que se digne encaminhar o requerimento de vac�ncia por posse em outro
			cargo inacumul�vel, em anexo, ao E.
			Tribunal Regional Federal da 2� Regi�o.</p>

			<p style="TEXT-INDENT: 2cm" align="justify">Informa, ainda, o
			endere�o atualizado para fins de correspond�ncia:</p>
	
		${endereco}.
		<br>
		${cep}.
		<br>
			<br>

			<c:if test="${not empty tel1 && not empty tel2}">
				Telefones para contato:
		</c:if>
			<c:if test="${not empty tel1 && empty tel2}">
				Telefone para contato:
		</c:if>
			<br>
			<c:if test="${not empty tel1}">
				<br>
			 	Telefone (1): ${tel1}
			</c:if>
			<c:if test="${not empty tel2}">
				<br>
			 	Telefone (2): ${tel2}
			</c:if>
			<br>
			<br>
		</mod:valor>
		<mod:valor var="texto_requerimento2">
			<%--<c:set var="semEspacos" value="Sim" scope="request" />--%>
			<c:import
				url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegi.jsp" />
			<p style="TEXT-INDENT: 2cm" align="justify">
			<p style="TEXT-INDENT: 1.5cm; font-size: 12px" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo},
			${doc.subscritor.padraoReferencia}, matr�cula
			${doc.subscritor.matricula}, lotado(a) no(a)
			${doc.subscritor.lotacao.descricao}, vem requerer a
			Vossa Excel�ncia <b>vac�ncia</b> do cargo p�blico que ora ocupa, com
			base no art. 33, VIII, da Lei 8.112/90, a partir do dia
			${dataDaPosse}, em raz�o de posse no cargo de ${cargoASerOcupado} do Quadro de
			Pessoal do(a) ${orgao}.
			<p />
			<p style="TEXT-INDENT: 1.5cm; font-size: 12px" align="justify">Est� ciente das diferentes conseq��ncias entre exonera��o a pedido e vac�ncia por posse
			em outro cargo inacumul�vel.<p />
			<p style="TEXT-INDENT: 1.5cm; font-size: 12px" align="justify"><b><i>Em
			anexo, encontram-se o(s) seguinte(s) documento(s):</b></i></p>
			<ul style="font-size: 12px">
				<c:if test="${declaraDevolvToken=='Sim'}">
					<li>Declara��o de Devolu��o do Token;</li>
				</c:if>
				
				<c:if test="${declaraBensAnex=='Sim'}">
					<li>Declara��o de bens atualizada at� a data da vac�ncia,
					com os respectivos valores;</li>
				</c:if>
				<c:if test="${IrpfCopiaAnex=='Sim'}">
					<li>C�pias da declara��o de Imposto de renda e recibo de
					entrega ou declara��o de isen��o;</li>
				</c:if>
				<c:if test="${cpfAnex=='Sim'}">
					<li>C�pia do CPF;</li>
				</c:if>
				<c:if test="${termoPosseComprom == 'posse'}">
					<li>Termo de posse no novo cargo;</li>
				</c:if>
				
				<c:if test="${termoPosseComprom == 'compromisso'}">
					<li>Termo de compromisso;</li>
				</c:if>

				<c:if test="${not empty outroDoc}">
					<li>${outroDoc}.</li>
				</c:if>
			</ul>
			<p style="TEXT-INDENT: 1.5cm; font-size: 12px" align="justify"><b><i>Declara,
			ainda, ter devolvido �s respectivas Se��es:</b></i></p>
			<ul style="font-size: 12px">
				<c:if test="${crachaDev=='Sim'}">
					<li>Crach� Funcional e Carteira Funcional � SECAD;</li>
				</c:if>
				<c:if test="${carteiraSaudeDev=='Sim'}">
					<li>Carteira(s) do Plano de Sa�de do Titular e
					do(s) dependente(s) � SEBEN;</li>
				</c:if>
				<c:if test="${documentoCurso=='Sim'}">
					<li>Documento emitido pelo �rg�o promotor do curso de forma��o
					de que n�o percebeu o aux�lio financeiro � CLCP;</li>
				</c:if>
				<c:if test="${comprovanteContribuicao=='Sim'}">
					<li>Comprovante de recolhimento de contribui��o para a Previd�ncia Social, do servidor p�blico, durante o curso de forma��o � CLCP;</li>
				</c:if>
				<c:if test="${comprovanteFrequencia=='Sim'}">
					<li>Comprovante de Frequ�ncia durante o curso de forma��o �
					CLCP;</li>
				</c:if>
				<c:if test="${ not empty outroItem }">
					<li>${outroItem}.</li>
				</c:if>
			</ul>

			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
			<br/>
			<p align="center">${doc.dtExtenso}</p>
			<c:import
				url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />

			<c:import
				url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>
	</mod:documento>
</mod:modelo>
