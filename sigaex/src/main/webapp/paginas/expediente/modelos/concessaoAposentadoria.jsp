<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>	
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
ABONO DE PERMANENCIA -->


<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<c:set var="apenasNome" value="Sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	
	<mod:oculto var="tipo1" valor="com base no art. 3�, � 2�, e art. 7� da Emenda Constitucional n� 41,  publicada em 31/12/2003, combinado com o art. 8�, incisos I e II, � 1�, inciso I, al�neas a e b, e inciso II, da Emenda Constitucional n� 20/98" />
	<mod:oculto var="tipo2" valor="com base no art. 40, � 1�, inciso III, al�nea b,  com a reda��o dada pela Emenda Constitucional n� 41/2003" />
	<mod:oculto var="tipo3" valor="a 100% (cem por cento) da m�dia contributiva, com base no art. 40, � 1�, inciso III, al�nea a, com a reda��o dada pela Emenda Constitucional n� 41/2003" />
	<mod:oculto var="tipo4" valor="ao valor da m�dia contributiva, aplicando-se o fator redutor para cada ano antecipado em rela��o � idade, com base no art. 2� da Emenda Constitucional n� 41/2003" />
	<mod:oculto var="tipo5" valor="com base no art. 3�, � 2�, e art. 7� da Emenda Constitucional n� 41,  publicada  em 31/12/2003, combinado com o art. 40, inciso III, al�nea a, da Constitui��o Federal, com a reda��o original" />
	<mod:oculto var="tipo6" valor="com base no art. 3�, � 2�, e art. 7� da Emenda Constitucional n� 41,  publicada em 31/12/2003, combinado com o art. 40, � 1�, inciso III, al�nea a, com a reda��o dada pela Emenda Constitucional n� 20/98"  />
	<mod:oculto var="tipo7" valor="com base no art. 3�, � 2�, e art. 7� da Emenda Constitucional n� 41, publicada em 31/12/2003, combinado com o art. 40, � 1�, inciso III, al�nea b, da Constitui��o Federal,  com a reda��o dada pela Emenda Constitucional n� 20/98" />
 	<mod:oculto var="tipo8" valor="com base no art. 3�, � 2�, e art. 7� da Emenda Constitucional n� 41, publicada  em 31/12/2003, combinado com  o art. 8�, incisos I, II e III, al�neas a e b, da Emenda Constitucional n� 20/98" />
	<mod:oculto var="tipo9" valor="com base no art. 6� da Emenda Constitucional n� 41/2003" />
	<mod:oculto var="tipo10" valor="com base no art. 3� da Emenda Constitucional n� 47/2005" />
	
	<mod:entrevista>
	
		<mod:grupo titulo="DETALHES DO FUNCION�RIO">
			<mod:texto titulo="Ramal" var="ramal"/>
		</mod:grupo>
		<mod:grupo titulo="CONTATOS">
			<mod:texto titulo="Logradouro" var="logradouro" largura="45" />
			<mod:texto titulo="Cep" largura="13" var="cep" />
		</mod:grupo>	
		<mod:grupo>
			<mod:texto titulo="Bairro" var="bairro" largura="30" />
			<mod:texto titulo="Cidade" largura="30" var="cidade" />
			<mod:texto titulo="Estado" largura="2" var="estado" />
		</mod:grupo>
		<mod:grupo>
		<mod:texto titulo="Telefone" largura="13" var="telefone" />
		<mod:texto titulo="Email" largura="40" var="email" />
		</mod:grupo>
		<mod:grupo titulo="OP��O DE APOSENTADORIA CONFORME A BASE LEGAL">
		<b>Aposentadoria volunt�ria com proventos proporcionais</b>
		<br/>
		<table width="60%">
		<tr>
		<td STYLE="text-align: justify">
		<mod:radio titulo="${tipo1}" var="tipoProventos" valor="1"/>
		<mod:radio titulo="${tipo2}" var="tipoProventos" valor="2"/>
		<mod:radio titulo="${tipo7}" var="tipoProventos" valor="7"/>
		</td>
		</tr>
		</table>
		<b>Aposentadoria volunt�ria com proventos correspondentes</b>
		<br/>
		<table width="60%">
		<tr>
		<td STYLE="text-align: justify">
		<mod:radio titulo="${tipo3}" var="tipoProventos" valor="3"/>
		<mod:radio titulo="${tipo4}" var="tipoProventos" valor="4"/>
		</td>
		</tr>
		</table>
		<b>Aposentadoria volunt�ria com proventos integrais</b>
		<br/>	
		<table width="60%">
		<tr>
		<td STYLE="text-align: justify">
		<mod:radio titulo="${tipo5}" var="tipoProventos" valor="5"/>
		<mod:radio titulo="${tipo6}" var="tipoProventos" valor="6"/>
		<mod:radio titulo="${tipo8}" var="tipoProventos" valor="8"/>
		<mod:radio titulo="${tipo9}" var="tipoProventos" valor="9"/>
		<mod:radio titulo="${tipo10}" var="tipoProventos" valor="10"/>
		</td>
		</tr>
		</table>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>		
	
		<mod:valor var="texto_requerimento"><p style="TEXT-INDENT: 2cm" align="justify">		
		<br />${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, 
		do Quadro de Pessoal Permanente da Justi�a Federal de Primeiro Grau no Rio de Janeiro, 
		lotado(a) no(a) ${doc.subscritor.lotacao.descricao }, 
		ramal ${ramal}, residente na ${logradouro}, ${bairro}, ${cidade}/${estado}, CEP ${cep}, telefone n� ${telefone}, email ${email},
		vem requerer a Vossa Senhoria que se digne remeter seu requerimento de concess�o de aposentadoria ao Egr�gio 
		Tribunal Regional Federal da 2� Regi�o.
		</p>
		
		</mod:valor>
		<mod:valor var="texto_requerimento2">
			<%--<c:set var="semEspacos" value="Sim" scope="request" />--%>
			<h3 align="center">EXCELENT�SSIMO SENHOR PRESIDENTE DO TRIBUNAL REGIONAL FEDERAL DA 2� REGI�O</H3>
			
			<p style="TEXT-INDENT: 2cm" align="justify">
			
			<c:if test="${tipoProventos < 3 || tipoProventos == 7}">
		<br>${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido},
		do Quadro de Pessoal Permanente da Justi�a Federal de Primeiro Grau no Rio de Janeiro,
		lotado(a) no(a) ${doc.subscritor.lotacao.descricao }, 
		ramal ${ramal}, residente na ${logradouro}, ${bairro}, ${cidade}/${estado}, CEP ${cep}, telefone n� ${telefone}, email ${email},
		vem requerer a Vossa Excel�ncia a concess�o de aposentadoria volunt�ria com proventos proporcionais, ${requestScope[f:concat('tipo',tipoProventos)]}.
		    </c:if>
		
			<c:if test="${tipoProventos == 3 || tipoProventos == 4}">
		<br>${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido},
		do Quadro de Pessoal Permanente da Justi�a Federal de Primeiro Grau no Rio de Janeiro,
		lotado(a) no(a) ${doc.subscritor.lotacao.descricao }, 
		ramal ${ramal}, residente na ${logradouro}, ${bairro}, ${cidade}/${estado}, CEP ${cep}, telefone n� ${telefone}, email ${email},
		vem requerer a Vossa Excel�ncia a concess�o de aposentadoria volunt�ria com proventos correspondentes, ${requestScope[f:concat('tipo',tipoProventos)]}.
		    </c:if>
		
			<c:if test="${tipoProventos == 5 || tipoProventos == 6 || tipoProventos == 8 || tipoProventos == 9 || tipoProventos == 10}">	
		<br>${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido},
		do Quadro de Pessoal Permanente da Justi�a Federal de Primeiro Grau no Rio de Janeiro,
		lotado(a) no(a) ${doc.subscritor.lotacao.descricao }, 
		ramal ${ramal}, residente na ${logradouro}, ${bairro}, ${cidade}/${estado}, CEP ${cep}, telefone n� ${telefone}, email ${email},
		vem requerer a Vossa Excel�ncia a concess�o de aposentadoria volunt�ria com proventos integrais, ${requestScope[f:concat('tipo',tipoProventos)]}.
		    </c:if>
		    	
		</p>
		<p style="TEXT-INDENT: 2cm">
		</p>
		</p>
		
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
		<br/>
		<br/>
		<p align="center">${doc.dtExtenso}</p>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?apenasCargo=sim" />
		</mod:valor>
		
	</mod:documento>
	
</mod:modelo>
