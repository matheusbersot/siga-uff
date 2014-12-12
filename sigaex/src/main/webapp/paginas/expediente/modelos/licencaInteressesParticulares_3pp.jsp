<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
LICEN�A PARA TRATAR DE INTERESSSES PARTICULARES -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
	
			<mod:memo colunas="60" linhas="3" titulo="MOTIVO DA LICEN�A" var="motivo" />
			
	</mod:entrevista>

	<mod:documento>

		<mod:valor var="texto_requerimento">
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a)
		${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia que se digne encaminhar
		o requerimento de <b>LICEN�A PARA TRATAR DE INTERESSES PARTICULARES</b>, 
		em anexo, ao E. Tribunal Regional Federal da 2� Regi�o.
		</p>
		</mod:valor>
		
		<mod:valor var="texto_requerimento2">
		<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegiao.jsp" />		
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a)
		${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia, nos termos do artigo 91 da Lei n.� 8.112/90, 
		com a reda��o dada pela Lei n.� 9.527/97, alterado pela Medida Provis�ria 
		n.� 2.225-45, em vigor por for�a do art. 2� da Emenda Constitucional 
		n.� 32/2001, regulamentado pela Resolu��o n.� 5/2008 do Conselho da 
		Justi�a Federal, <b>LICEN�A PARA TRATAR DE INTERESSES PARTICULARES</b>
		, pelos motivos expostos a seguir:
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		${motivo}
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		Est� ciente de que, nos termos do art. 79, b e c, da 
		Resolu��o n.� 5/2008 do Conselho da Justi�a Federal, 
		<b>continuar� na titularidade do cargo</b>, permanecendo sujeito �s proibi��es 
		e aos deveres contidos na Lei n� 8.112/90, assim como ter� <b>suspensa</b> 
		a contagem do per�odo aquisitivo para fins de f�rias, retomando-se a 
		contagem <b>na data do retorno da licen�a</b>.
		</p>
		
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
		<br/>
		<br/>
		<p align="center">${doc.dtExtenso}</p>			
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		
		
		</mod:valor>
		
		
		
		
		
		
		<mod:valor var="texto_requerimento3">
		
		<c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" />
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		<i>
		Declaro estar ciente de que o � 2� do art. 183 da Lei n.� 8.112/90, 
		acrescentado pela Lei n.� 10.667/2003, prev� que o servidor afastado ou 
		licenciado do cargo efetivo, sem direito � remunera��o, inclusive para 
		servir em organismo oficial internacional do qual o Brasil seja membro 
		efetivo ou com o qual coopere, ainda que contribua para regime de previd�ncia 
		social no exterior, ter� suspenso o seu v�nculo com o regime do Plano de 
		Seguridade Social do Servidor P�blico enquanto durar o afastamento ou a 
		licen�a, n�o lhe assistindo, neste per�odo, os benef�cios do mencionado 
		regime de previd�ncia.
		</i>
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		<i>
		Declaro, ainda, estar ciente de que o � 3� do referido artigo, tamb�m 
		acrescentado pela Lei n.� 10.667/2003, assegura ao servidor, na situa��o 
		acima descrita, a manuten��o da vincula��o ao regime do Plano de Seguridade 
		Social do Servidor P�blico, mediante o recolhimento mensal da respectiva 
		contribui��o, no mesmo percentual devido pelos servidores em atividade, 
		incidente sobre a remunera��o total do cargo a que faz jus no exerc�cio de 
		suas atribui��es, computando-se, para esse efeito, inclusive, as vantagens 
		pessoais.
		</i>
		</p>
		<p align="center">${doc.dtExtenso}</p>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>
	</mod:documento>
</mod:modelo>
