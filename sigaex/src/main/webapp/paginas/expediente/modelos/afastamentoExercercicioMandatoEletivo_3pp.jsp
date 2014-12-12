<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- este modelo trata de 
AFASTAMENTO PARA EXERC�CIO DE MANDATO ELETIVO -->


<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
<mod:documento>
		
		<mod:valor var="texto_requerimento">
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}
		
		vem requerer a Vossa Excel�ncia que se digne encaminhar
		o requerimento de <b>AFASTAMENTO PARA EXERC�CIO DE MANDATO ELETIVO</b>, 
		em anexo, ao E. Tribunal Regional Federal da 2� Regi�o.
		</p>
		
		</mod:valor>
		<mod:valor var="texto_requerimento2">
			<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegiao.jsp" />
	
			<p style="TEXT-INDENT: 2cm" align="justify">
			<br/>${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
			${doc.subscritor.padraoReferenciaInvertido},		 
			lotado(a) no(a) ${doc.subscritor.lotacao.descricao},
	
			vem requerer a Vossa Excel�ncia, nos termos do art. 94 da Lei 
			n.� 8.112/90, <B>AFASTAMENTO PARA EXERC�CIO DE MANDATO ELETIVO</B>.
			</p>
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
			<br/>
			<br/>
			<p align="center">${f:replace(doc.dtExtenso,'.','')}</p>
			<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
			<c:import
				url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
			<%--<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />--%>
				
		</mod:valor>	
		

		<mod:valor var="texto_requerimento3">
			<c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" />
			<p style="TEXT-INDENT: 2cm" align="justify">
			
			Declaro estar ciente de que o � 2� do art. 183 da Lei n.� 8.112/90, 
			acrescentado pela Lei n.� 10.667/2003, prev� que <i>o servidor afastado ou 
			licenciado do cargo efetivo, sem direito � remunera��o, inclusive para 
			servir em organismo oficial internacional do qual o Brasil seja membro 
			efetivo ou com o qual coopere, ainda que contribua para regime de previd�ncia 
			social no exterior, ter� suspenso o seu v�nculo com o regime do Plano de 
			Seguridade Social do Servidor P�blico enquanto durar o afastamento ou a 
			licen�a, n�o lhe assistindo, neste per�odo, os benef�cios do mencionado 
			regime de previd�ncia.
			</i></p>
	
	
			<p style="TEXT-INDENT: 2cm" align="justify">	
			Declaro, ainda, estar ciente de que o � 3� do referido artigo, 
			tamb�m acrescentado pela Lei n.� 10.667/2003, <i>assegura ao servidor, na situa��o 
			acima descrita, a manuten��o da vincula��o ao regime do Plano de Seguridade 
			Social do Servidor P�blico, mediante o recolhimento mensal da respectiva 
			contribui��o, no mesmo percentual devido pelos servidores em atividade, 
			incidente sobre a remunera��o total do cargo a que faz jus no exerc�cio de 
			suas atribui��es, computando-se, para esse efeito, inclusive, as vantagens pessoais.
			</i></p>
			<br/>
			<br/>
			<p align="center">${doc.dtExtenso}</p>
			<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>
	</mod:documento>
</mod:modelo>
