<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>	
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="esconderTexto" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/memorando.jsp">
	<mod:entrevista>
		<mod:grupo>
			<mod:radio titulo="Unidade/Assistente que <b>remeter�</b> processos eletr�nicos." 
						var="escolha" 	valor="1" reler="sim"  marcado="Sim"/>
			<mod:radio titulo="Unidade/Assistente que <b>receber�</b> processos eletr�nicos." 
						var="escolha" valor="2"  reler="sim" gerarHidden="N�o"/>
		</mod:grupo>		
		<c:set var="valorEscolha" value="${escolha}" />	
		<c:if test="${empty valorEscolha}">			
			<c:set var="valorEscolha" value="${param['escolha']}" />
		</c:if>		
		
		<mod:grupo>
			<mod:numero titulo="Ordem de Servi�o" var="numODF" largura="5"/>
			<mod:numero titulo="Ano" var="anoODF" largura="4" maxcaracteres="4"/>			
		</mod:grupo>		
		<c:choose>			
			<c:when test="${empty valorEscolha or valorEscolha == '1'}">
				<mod:grupo>				
					<mod:numero titulo="Quantidade de processos a serem remetidos" var="qtdProcessos" largura="10" />
				</mod:grupo>
				<mod:oculto var="titUnid" valor="Unidade/Assistente que elaborar� os c�lculos" />										 
			</c:when>
			<c:when test="${valorEscolha == '2'}">		
				<mod:grupo>				
					<mod:numero titulo="Quantidade de processos a serem recebidos e calculados" var="qtdProcessos" largura="10" />
				</mod:grupo>
				<mod:oculto var="titUnid" valor="Unidade/Assistente que remeter� os processos" />							 
			</c:when>
		</c:choose>
		 
		<mod:grupo>			   
			<mod:selecao titulo="${titUnid}" var="unidade"
						opcoes="Se��o de Contadoria de Niter�i;
							Se��o de Contadoria de S�o Jo�o de Meriti;
							Se��o de Contadoria de Volta Redonda;
							Se��o de Contadoria de S�o Gon�alo;
							Assistente IV - Contadoria de Duque de Caxias;
							Assistente IV - Contadoria de Nova Igua�u;
							Assistente IV - Contadoria de Campos;
							Assistente IV - Contadoria de Nova Friburgo;
							Assistente IV - Contadoria de Petr�polis;
							Assistente IV - Contadoria de Resende;
							Assistente III - Contadoria de Angra dos Reis;
							Assistente III - Contadoria de Barra do Pira�;
							Assistente III - Contadoria de Itabora�;
							Assistente III - Contadoria de Itaperuna;
							Assistente III - Contadoria de Maca�;
							Assistente III - Contadoria de Mag�;
							Assistente III - Contadoria de S�o Pedro D'Aldeia;
							Assistente III - Contadoria de Teres�polis;
							Assistente III - Contadoria de Tr�s Rios;
							SECEL - Sede;
							SECLJ - Sede;
							SECPC - Sede;
							SECPJ - Sede;
							SECPV - Sede" />
		</mod:grupo>
		<mod:grupo>				
				<mod:selecao titulo="M�s" var="mes" 
 						opcoes="Janeiro;Fevereiro;Mar�o;Abril;Maio;Junho;Julho;Agosto;Setembro;Outubro;Novembro;Dezembro"/>
							
		</mod:grupo>		
	</mod:entrevista>
	<mod:documento>		
	<mod:valor var="texto_memorando">
	Ref.: Central de C�lculo Judicial - RJ-ODF-${anoODF}/${numODF}
	<br><br>		
	<c:choose>			
			<c:when test="${empty escolha or escolha == '1'}">
				<p style="align:left;TEXT-INDENT:2cm">Comunico sobre a <b>remessa</b> de processos eletr�nicos, 
				conforme informa��es abaixo: </p>
				<p style="align:left;TEXT-INDENT:2cm">a)	Unidade/Assistente destinat�ria(o): ${unidade}</p>
				<p style="align:left;TEXT-INDENT:2cm">b)	quantidade de processos: ${qtdProcessos}</p>
				<p style="align:left;TEXT-INDENT:2cm">c)	m�s de refer�ncia: ${mes}</p>
				<p style="align:left;TEXT-INDENT:2cm">A remessa dever� ser feita <b>diretamente</b> � Unidade/Assistente destinat�ria(o), 
				no prazo m�ximo de <b>5 dias a contar da data do recebimento deste memorando</b>.</p>		
																 
			</c:when>
			<c:when test="${escolha == '2'}">	
				<p style="align:left;TEXT-INDENT:2cm">Comunico sobre o <b>recebimento</b> de processos eletr�nicos 
				para a elabora��o de c�lculos, conforme informa��es abaixo: </p>
				<p style="align:left;TEXT-INDENT:2cm">a)	Unidade/Assistente que remeter� os processos: ${unidade}</p>
				<p style="align:left;TEXT-INDENT:2cm">b)	quantidade de processos: ${qtdProcessos}</p>
				<p style="align:left;TEXT-INDENT:2cm">c)	m�s de refer�ncia: ${mes}</p>
				<p style="align:left;TEXT-INDENT:2cm">A devolu��o dos processos (com os c�lculos elaborados) dever� 
				ser feita <b>diretamente ao ju�zo de origem</b>, no prazo m�ximo de <b>30 dias a contar da data do 
				recebimento dos processos</b>.</p>								 
			</c:when>
		</c:choose>	
		<br><br><br>	
	</mod:valor>		
	</mod:documento>
</mod:modelo>
