<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- este modelo trata de
REQUERIMENTO DE INCLUSAO DE DEPENDENTE VIA PROCESSO-->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		
		<mod:grupo titulo="DETALHES DO DEPENDENTE">
			<mod:texto titulo="Dependente nome" var="dependente" />
			<mod:grupo>
				<mod:selecao titulo="Dependente na qualidade de"
					var="qualidade" opcoes="companheiro(a);enteado(a);dependente econ�mico(a);benefici�rio(a) designado(a)" reler="sim" />
			</mod:grupo>
		</mod:grupo>
		
	</mod:entrevista>

	<mod:documento>
		<mod:valor var="texto_requerimento">
		
			<p style="TEXT-INDENT: 2cm" align="justify">
			Eu, ${doc.subscritor.descricao}, matr�cula RJ${doc.subscritor.matricula}, venho por meio deste requerer a V.Exa. 
			o encaminhamento da documenta��o que segue em anexo ao Egr�gio TRF da 2� Regi�o, com a finalidade de inclus�o de ${dependente}, 
			como meu/minha dependente no Plano de Sa�de da Justi�a Federal, na qualidade de ${qualidade}.</p>
			
		</mod:valor>

		<mod:valor var="texto_requerimento2">
		
			<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegi.jsp" />
			
			<p style="TEXT-INDENT: 2cm" align="justify">
			Eu, ${doc.subscritor.descricao}, matr�cula RJ${doc.subscritor.matricula}, venho por meio deste solicitar a V.Exa., s.m.j., o deferimento do pedido de inclus�o de ${dependente}, 
			como meu/minha dependente no Plano de Sa�de da Justi�a Federal, na qualidade de ${qualidade}.</p>
		
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
