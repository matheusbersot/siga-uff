<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
CONCESS�O DE HORARIO ESPECIAL AO SERVIDOR PUBLICO ESTUDANTE 
- PEDIDO -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
			<mod:memo colunas="60" linhas="3" titulo="PROPOSTA" var="detalhesProposta" />
	</mod:entrevista>
	<mod:documento>
		<%--<mod:valor var="texto_requerimento">	
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria <B>HOR�RIO ESPECIAL AO SERVIDOR ESTUDANTE</B>, conforme o art. 98 e � 1� da Lei n.� 8.112/90, com a reda��o dada pela 
		Lei n.� 9.527/97 e Resolu��o n.� 5/2008 do Conselho da Justi�a 
		Federal, em face da incompatibilidade entre o hor�rio escolar e o da SJRJ, de 
		acordo com a proposta abaixo:
		</p>
		${detalhesProposta}
		</mod:valor>--%>
		<mod:valor var="texto_requerimento2">
			<c:import url="/paginas/expediente/modelos/inc_tit_SraDiretoraSubsecretariaRH.jsp" />
			<p style="TEXT-INDENT: 2cm" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria <B>HOR�RIO ESPECIAL AO SERVIDOR ESTUDANTE</B>, conforme o art. 98 e � 1� da Lei n.� 8.112/90, com a reda��o dada pela 
			Lei n.� 9.527/97 e Resolu��o n.� 5/2008 do Conselho da Justi�a 
			Federal, face � incompatibilidade entre o hor�rio escolar e o da SJRJ, de 
			acordo com a proposta abaixo:
			</p>
			${detalhesProposta}
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
			<p align="center">${doc.dtExtenso}</p>
			<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?apenasCargo=sim" />
			<c:import url="/paginas/expediente/modelos/inc_cienteAssSupHierarquico.jsp" />
				<p><font size='1'> 		 
				<b>Anexar:</b>
				<ul>
				<li><i>
					Documenta��o comprobat�ria de matr�cula no estabelecimento de 
					ensino e do hor�rio das respectivas aulas, encaminhada atrav�s 
					do titular da unidade.
				</i></li>
				<li><i>
					Declara��o do servidor, comprometendo-se a apresentar, at� o 30� (trig�simo) dia ap�s o in�cio de cada semestre, ou ano letivo, conforme o caso, documento comprobat�rio de freq��ncia regular no per�odo anterior, bem como solicitar o cancelamento do hor�rio especial, quando cessarem os motivos 
					que ensejaram a sua concess�o, sob pena de cancelamento, 
					atendendo ao disposto nos <b>art. 8�, I e 9� da Resolu��o 
					n.� 5/2008</b> - CJF.
				</i></li>
				</ul>
			</font>
			</p>
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>	
</mod:documento>
</mod:modelo>
