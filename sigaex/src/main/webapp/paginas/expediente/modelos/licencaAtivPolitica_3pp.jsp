<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
	
		<mod:grupo titulo="QUANTO AO PER�ODO DE LICEN�A">
			<mod:data titulo="Data de Incio" var="dataInicio" />
			<mod:data titulo="Data de Fim" var="dataFim" />
			<mod:grupo>
				<mod:texto var="cargoEletivo" titulo="Cargo Eletivo" />
			</mod:grupo>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>

		<mod:valor var="texto_requerimento">
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a)
		${doc.subscritor.lotacao.descricao}, vem requerer a Vossa
		Excel�ncia, que se digne encaminhar o requerimento de <B>LICEN�A PARA
		ATIVIDADE POL�TICA</B>, no per�odo compreendido entre ${dataInicio} e
		${dataFim}, em anexo, ao E. Tribunal Regional Federal da 2� Regi�o.
		</p>
		</mod:valor>	
		<mod:valor var="texto_requerimento2">
		<c:set var="semEspacos" value="Sim" scope="request" />
		<c:import url="/paginas/expediente/modelos/inc_tit_presidTrf2aRegiao.jsp" />			
			<p style="TEXT-INDENT: 2cm; font-size: 12px" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, 
			vem requerer a Vossa Excel�ncia, nos termos da LC n.� 64/90 c/c o 
			art. 86 e �� da Lei n.� 8.112/90, com a reda��o dada pela 
			Lei n.� 9.527/97, <b>LICEN�A PARA ATIVIDADE POL�TICA</b> no per�odo 
			compreendido entre ${dataInicio} e ${dataFim}, tendo em vista a candidatura ao cargo eletivo de ${cargoEletivo}, 
			conforme c�pia autenticada da ata da conven��o partid�ria e/ou protocolo do pedido de registro na Justi�a Eleitoral.
			</p>
			<p style="TEXT-INDENT: 2cm; font-size: 12px" align="justify">
			Declara estar ciente das situa��es abaixo relacionadas:</p>
			<ul style="font-size: 12px">
			<li>
				que a licen�a ser� sem remunera��o, a partir da data em que for escolhido em conven��o partid�ria, at� o dia imediatamente anterior ao do registro da candidatura perante a Justi�a Eleitoral, e com a remunera��o do cargo efetivo a partir do protocolo do pedido de registro da candidatura na Justi�a Eleitoral at� o d�cimo dia seguinte ao da elei��o, por at� 3 (tr�s) meses. 
			</li>
			<li>
				que dever� apresentar o comprovante do registro, no prazo m�ximo de quinze dias, a contar de sua homologa��o na Justi�a Eleitoral. 
			</li>
			<li>
				que a licen�a poder� ser interrompida, a qualquer tempo, a seu pedido.
			</li>
			<li>
				que em caso de desist�ncia � candidatura, reassumir� imediatamente as atividades do cargo.
			</li>
			<li>
				que em caso de cancelamento ou indeferimento do registro, mediante decis�o transitada em julgado, reassumir� imediatamente as atividades do cargo, devolvendo as quantias recebidas desde o in�cio do afastamento. 
			</li>
			<li>
				que uma vez concedida a licen�a sem remunera��o, a concess�o da licen�a com remunera��o ser� considerada como prorroga��o da primeira, n�o havendo necessidade de retorno ao servi�o.
			</li>
			<li>
				que o per�odo de licen�a, com remunera��o, contar-se-� apenas para os efeitos de aposentadoria e disponibilidade. 
			</li>
			<li>
				que o per�odo concedido sem remunera��o, contar� apenas para aposentadoria, caso o servidor opte pela manuten��o da vincula��o ao Plano de Seguridade Social do Servidor P�blico, mediante recolhimento mensal da respectiva contribui��o, no mesmo percentual devido pelos servidores em atividade, que ter� como base de c�lculo a remunera��o contributiva do cargo efetivo a que faria jus se em exerc�cio estivesse, computando-se para esse efeito, inclusive, as vantagens pessoais, nos termos do art. 183 da Lei n� 8.112 de 1990, com as altera��es da Lei n� 10.667, de 14 de maio de 2003. 
			</li>
			<li>
				que o per�odo de afastamento, com ou sem remunera��o, suspende o est�gio probat�rio e o prazo para aquisi��o de estabilidade, bem como n�o lhe d� direito a receber o aux�lio-alimenta��o.		
			</li>
			</ul>
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
			<p align="center">${doc.dtExtenso}</p>			
			<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
			
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		
			</mod:valor>
					
			<%--<mod:valor var="texto_requerimento3">
			<c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" /> 
			
			<p style="TEXT-INDENT: 2cm" align="justify">
			<i>
			Declaro estar ciente de que o � 2� do art. 183 da Lei n.� 8.112/90, acrescentado
			pela Lei n.� 10.667/2003, prev� que o servidor afastado ou licenciado do cargo 
			efetivo, sem direito � remunera��o, inclusive para servir em organismo oficial 
			internacional do qual o Brasil seja membro efetivo ou com o qual coopere, ainda 
			que contribua para regime de previd�ncia social no exterior, ter� suspenso o seu 
			v�nculo com o regime do Plano de Seguridade Social do Servidor P�blico enquanto 
			durar o afastamento ou a licen�a, n�o lhes assistindo, neste per�odo, 
			os benef�cios do mencionado regime de previd�ncia.
			</i></p>
			<p style="TEXT-INDENT: 2cm" align="justify">
			<i> 
			Declaro, ainda, estar ciente de que o � 3� do referido artigo, tamb�m acrescentado 
			pela Lei n.� 10.667/2003, assegura ao servidor na situa��o acima descrita, a 
			manuten��o da vincula��o ao regime do Plano de Seguridade Social do Servidor 
			P�blico, mediante o recolhimento mensal da respectiva contribui��o, no mesmo 
			percentual devido pelos servidores em atividade, incidente sobre a remunera��o 
			total do cargo a que faz jus no exerc�cio de suas atribui��es, computando-se, 
			para esse efeito, inclusive, as vantagens pessoais.
			</i></p>
			<p align="center">${doc.dtExtenso}</p>
			<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
			
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
		</mod:valor>--%>
		
	</mod:documento>
</mod:modelo>
