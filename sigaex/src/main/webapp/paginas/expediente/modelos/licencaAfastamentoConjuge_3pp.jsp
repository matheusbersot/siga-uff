<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
LICEN�A PARA AFASTAMENTO DO CONJUGUE
< ESTE DOCUMENTO SE DIVIDE EM 3 PAGINAS >
[OBS AO PROGRAMADOR: CRIAR DIGITO OU METODO P/ SALTAR PAGINA]  -->

<mod:modelo>
	<mod:entrevista>
	
		<mod:grupo titulo="DETALHES DO SERVIDOR">
				<mod:texto titulo="Classe" var="classe"/>
				<mod:texto titulo="Padr�o" var="padrao" />
		</mod:grupo>
				 
	</mod:entrevista>
		
	<mod:documento>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head></head>
	<body>
	
		<c:import url="/paginas/expediente/modelos/inc_tit_juizfedDirForo.jsp" />
		
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		classe ${classe} e padr�o ${padrao}, 
		lotado(a) no(a)${doc.subscritor.lotacao.descricao},
	
		
		vem, respeitosamente, requerer a Vossa Excel�ncia, que se digne encaminhar 
		o requerimento de <b>LICEN�A POR MOTIVO DE AFASTAMENTO DO C�NJUGE COM EXERC�CIO 
		PROVIS�RIO</b>, em anexo, ao E. Tribunal Regional Federal da 2� Regi�o
		</p>

		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
				
		<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		
		
		
		
		
		
		

		<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegiao.jsp" />

		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		classe ${requestScope.classe} e padr�o ${requestScope.padrao}, 
		lotado(a) no(a)${doc.subscritor.lotacao.descricao},
	
		vem, respeitosamente, requerer a Vossa Excel�ncia, que se digne encaminhar 
		o requerimento de <B>LICEN�A POR MOTIVO DE AFASTAMENTO DO C�NJUGE COM EXERC�CIO 
		PROVIS�RIO</B>, em anexo, ao E. Tribunal Regional Federal da 2� Regi�o
		</p>
		
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
					
		<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
			
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		
		
		
		
		
		
		
		
		
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
					
		<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
		<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		
	</body>
	</html>
</mod:documento>
</mod:modelo>
