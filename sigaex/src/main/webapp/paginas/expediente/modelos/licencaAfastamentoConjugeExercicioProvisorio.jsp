<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
LICEN�A PARA AFASTAMENTO DO CONJUGUE
< ESTE DOCUMENTO SE DIVIDE EM 3 PAGINAS >
[OBS AO PROGRAMADOR: CRIAR DIGITO OU METODO P/ SALTAR PAGINA]  -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">

	<mod:documento>
		
		<mod:valor var="texto_requerimento">
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia que se digne encaminhar 
		o requerimento de <b>LICEN�A POR MOTIVO DE AFASTAMENTO DO C�NJUGE COM EXERC�CIO 
		PROVIS�RIO</b>, em anexo, ao E. Tribunal Regional Federal da 2� Regi�o.
		</p>
		</mod:valor>
		<mod:valor var="texto_requerimento2">
		
		<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegiao.jsp" />

		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia, nos termos do art. 84 da Lei n� 8.112/90, c/c altera��o dada pela Lei n� 9.527/97, regulamentado pela Resolu��o n� 498/2006, do Conselho da Justi�a Federal, <B>LICEN�A POR MOTIVO DE AFASTAMENTO DO C�NJUGE COM EXERC�CIO 
		PROVIS�RIO</B>.
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		Declara estar ciente dos termos da norma citada, especialmente no que diz respeito ao seguinte:
		<ul>
		<li>que a concess�o ser� por prazo indeterminado, enquanto perdurar o v�nculo matrimonial ou a uni�o est�vel, comprometendo-se a encaminhar ao �rg�o de origem, anualmente, declara��o que ateste o deslocamento e manuten��o da situa��o mencionada (art. 2�, par�grafo 1� c/c art. 5�, par�grafo 3�);</li>
		<li>que o per�odo de licen�a sem remunera��o n�o ser� contado para nenhum efeito, exceto para aposentadoria na hip�tese do art. 6�, suspendendo o est�gio probat�rio, a aquisi��o da estabilidade e a concess�o de progress�o ou promo��o funcional (art. 3� e par�grafo �nico);</li>
		<li>que o per�odo de exerc�cio provis�rio ser� contado para todos os efeitos legais (art. 4�, par�grafo �nico);</li>
		<li>que, na hip�tese de n�o ser concedido o exerc�cio provis�rio, ser� assegurada ao servidor licenciado, mediante requerimento, a manuten��o da vincula��o ao regime do Plano de Seguridade Social do Servidor P�blico mediante recolhimento mensal da respectiva contribui��o, no mesmo percentual devido pelos servidores em atividade, incidente sobre a remunera��o total do cargo a que faz jus no exerc�cio de suas atribui��es, computando-se, para esse efeito, inclusive, as vantagens pessoais (art. 6�).</li>		
		</ul>
		</p>
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>					
		
				
		<%--<mod:valor var="texto_requerimento3">
		<c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" />
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		<i>
		Declaro estar ciente de que o � 2� do art. 183 da Lei n.� 8.112/90, 
		acrescentado pela Lei n.� 10.667/2003, prev� que o servidor afastado ou 
		licenciado do cargo efetivo, sem direito � remunera��o, inclusive para 
		servir em organismo oficial internacional do qual o Brasil seja membro 
		efetivo ou com o qual coopere, ainda que contribua para regime de 
		previd�ncia social no exterior, ter� suspenso o seu v�nculo com o 
		regime do Plano de Seguridade Social do Servidor P�blico enquanto 
		durar o afastamento ou a licen�a, n�o lhes assistindo, neste per�odo, 
		os benef�cios do mencionado regime de previd�ncia.
		</i>
		</p> 
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		<i>
		Declaro, ainda, estar ciente de que o � 3� do referido artigo, 
		tamb�m acrescentado pela Lei n.� 10.667/2003, assegura ao servidor na 
		situa��o acima descrita, a manuten��o da vincula��o ao regime do Plano 
		de Seguridade Social do Servidor P�blico, mediante o recolhimento mensal 
		da respectiva contribui��o, no mesmo percentual devido pelos servidores em 
		atividade, incidente sobre a remunera��o total do cargo a que faz jus no 
		exerc�cio de suas atribui��es, computando-se, para esse efeito, inclusive, 
		as vantagens pessoais.
		</i>
		</p>	
					
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>--%>
	</body>
	</html>
</mod:documento>
</mod:modelo>
