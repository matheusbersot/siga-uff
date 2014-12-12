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
			o requerimento de <b>LICEN�A POR MOTIVO DE AFASTAMENTO DO C�NJUGE</b>, em anexo, ao E. Tribunal Regional Federal da 2� Regi�o.
			</p>				
		</mod:valor>
<!-- [Aqui tem q pular p�gina]  -->			
		<mod:valor var="texto_requerimento2">
		<!-- <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> -->
			<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegiao.jsp" />				
			<p style="TEXT-INDENT: 2cm" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Excel�ncia, nos termos do art. 84 de Lei n� 8.112/90
			regulamentado pela Resolu��o n� 5/2008 do Conselho da Justi�a Federal, <b>LICEN�A POR MOTIVO DE AFASTAMENTO DO C�NJUGE</b>.
			</p>
			<p style="TEXT-INDENT: 2cm" align="justify">
			Declaro estar ciente dos termos da norma citada, especialmente no que diz respeito ao seguinte:
			</p>
			<p style="TEXT-INDENT: 2cm" align="justify">
			- que  a concess�o ser� por prazo indeterminado, enquanto perdurar o v�nculo
			matrimonial ou a uni�o est�vel, comprometenso-se a encaminhar ao �rg�o de origem,
			anualmente, declara��o que ateste o deslocamento e mauten��o da situa��o mencionada
			(art. 68, par�grafo 1� c/c art. 71, par�grafo 3�);
			</p>
			<p style="TEXT-INDENT: 2cm" align="justify">
			- que o per�odo de licen�a sem remunera��o n�o ser� contado para nenhum efeito,
			exeto para aposentadoria na hip�tese do art. 72, suspendendo o est�gio probat�rio,
			a aquisi��o da estabilidade e a concess�o de progress�o ou promo��o funcional (art. 69
			e par�grafo �nico);
			</p>
			<p style="TEXT-INDENT: 2cm" align="justify">
			- que ser� assegurada ao servidor licenciado a manuten��o da vincula��o ao regime do
			Plano de Seguridade Social do Servidor P�blico, mediante o recolhimento mensal da
			respectiva contribui��o, no mesmo percentual devido pelos servidores em atividade,
			incidente sobre a remunera��o total do cargo a que faz jus no exerc�cio de suas
			atribui��es, computando-se, para esse efeito, inclusive, as vantagens pessoais (art.
			72).
			</p>
						
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
			<p align="center">${doc.dtExtenso}</p> 			
			<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
			
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
			
		</mod:valor>
		
</mod:documento>
</mod:modelo>
