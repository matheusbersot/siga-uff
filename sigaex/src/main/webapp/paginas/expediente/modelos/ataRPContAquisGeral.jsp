<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- este modelo trata de
solicita��o de inscri��o para capacita��o sem onus -->
<script type="text/javascript">

	function alerta(){

		var x = document.getElementById("qtd").value;

		var z = parseFloat(x);

		return alert(z);

	}

</script>


<body onunload="alerta()">

<mod:modelo>

	 <mod:entrevista>
		
			
			
			<mod:grupo titulo="Contrato de Aquisi��o em Geral">
			
									
				<mod:monetario titulo="Termo de contrato de N�" largura="12" maxcaracteres="10" var="termo" verificaNum="sim"/>
			
				<mod:texto	titulo="Fornecimento de" largura="20" var="forn" />
			
				<mod:monetario titulo="Quantidade" largura="8" maxcaracteres="6" var="quantidade" verificaNum="sim"/>
			
				<mod:monetario titulo="Ano" largura="6" maxcaracteres="4" var="ano" verificaNum="sim"/>
			
				<mod:grupo titulo="Representante">
			
						<mod:texto	titulo="Nome" largura="20" var="represent" />
							
						<mod:monetario titulo="Identidade" largura="11" maxcaracteres="9" var="ident_represent" verificaNum="sim"/>
				
						<mod:monetario titulo="CPF" largura="12" maxcaracteres="10" var="cpf_represent" verificaNum="sim"/>
						
				</mod:grupo>	
			
			
				<mod:grupo titulo="Processo Administrativo">
			
					<mod:monetario titulo="N� 1" largura="4" maxcaracteres="3" var="n1" verificaNum="sim"/>
			
					<mod:monetario titulo="N� 2" largura="4" maxcaracteres="3" var="n2" verificaNum="sim"/>
			
					<mod:monetario titulo="N� 3" largura="4" maxcaracteres="3" var="n3" verificaNum="sim"/>
			
				</mod:grupo>
							
					<mod:grupo titulo="Juiz Federal">
			
						<mod:texto	titulo="Dr" largura="20" var="jfdr"  />
							
						<mod:monetario titulo="Identidade" largura="11" maxcaracteres="9" var="ident" verificaNum="sim"/>
				
						<mod:monetario titulo="CPF" largura="12" maxcaracteres="11" var="cpf" verificaNum="sim"/>
						
					</mod:grupo>
				
					<mod:grupo titulo="Itens">				
					
						<mod:texto	titulo="Quantidade de itens" largura="9" maxcaracteres="7" var="qtd" relertab="sim"  />	
						
						
			
						<mod:grupo>
						
							<c:forEach var="i" begin="1" end="${qtd}">
								
								<mod:grupo>								
								
									<mod:texto titulo="Descri��o${i}" largura="20" maxcaracteres="18" var="desc${i}"/>							
								
									<mod:monetario titulo="Quantidade${i}" largura="6" maxcaracteres="4" var="qtd_item${i}" verificaNum="sim"/>									
								
									<mod:monetario titulo="Valor${i}" largura="6" maxcaracteres="4" var="valor${i}" verificaNum="sim"/>
								
								   
								</mod:grupo>
									  						
		  									
							</c:forEach>
													
											
						</mod:grupo>
											
					</mod:grupo>	
				
					<mod:grupo titulo="Entrega">
					
						<mod:texto	titulo="Local da entrega" largura="20" var="ent"  />
						
						<mod:texto	titulo="Rua" largura="20" var="rua" />				
						
						<mod:texto	titulo="Se��o" largura="20" var="secao"  />
						
						<mod:monetario titulo="Prazo (em dias)" largura="6" maxcaracteres="4" var="prazo" verificaNum="sim"/>					
					
										
					</mod:grupo>
					
						<mod:grupo titulo="Empresa">
					
						<mod:texto	titulo="Nome" largura="20" var="emp"  />
						
						<mod:texto	titulo="Endere�o" largura="20" var="end"  />
						
						<mod:monetario titulo="Telefone" largura="10" maxcaracteres="8" var="tel" verificaNum="sim"/>
						
						<mod:monetario titulo="Fax" largura="10" maxcaracteres="8" var="fax" verificaNum="sim"/>
						
						<mod:monetario titulo="C.N.P.J." largura="16" maxcaracteres="14" var="cnpj" verificaNum="sim"/>
						
					</mod:grupo>
					
					
								
					<mod:grupo titulo="Preg�o">
			
						<mod:monetario titulo="Numero" largura="12" maxcaracteres="10" var="pregao" verificaNum="sim"/>
						
						<mod:monetario titulo="Ano" largura="6" maxcaracteres="4" var="ano_preg" verificaNum="sim"/>
			    
					</mod:grupo>
					
					<mod:grupo titulo="Garantia contratual">
					
						<mod:monetario titulo="Valor" largura="8" maxcaracteres="6" var="garant_val" verificaNum="sim" formataNum="sim"/>
						
						<mod:monetario titulo="Tempo" largura="8" maxcaracteres="6" var="garant_mes" verificaNum="sim" />
					
					</mod:grupo>
					
										
				</mod:grupo>
					
	</mod:entrevista>
	
	
	
		
	<mod:documento>
	
	<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp"/>
	
	<p style="TEXT-INDENT: 4cm" align="left">/TERMO DE CONTRATO N�${termo}/${ano}<br>
	CONTRATO DE FORNECIMENTO DE ${forn} ,<br>
	QUE ENTRE SI FAZEM A <br>
	JUSTI�A FEDERAL DE 1� GRAU NO RIO DE JANEIRO <br>
	NO RIO DE JANEIRO E A EMPRESA ${emp}<br>
	PROCESSO N� ${n1}/${n2}/${n3} - EOF</p>
	
	<p style="TEXT-INDENT: 2cm" align="justify">A Justi�a Federal de 1� Grau no Rio de Janeiro, com sede na Av. Rio 
	Branco, 243 - Anexo I - 14� andar, Centro/RJ, inscrita no C.N.P.J. sob o n� 05.424.540/0001-16, neste ato 
	representada pelo Dr. ${jfdr}, Juiz Federal - Diretor do Foro, identidade n� ${ident},  
	CPF: ${cpf}, doravante denominada CONTRATANTE, e a empresa ${emp}, estabelecida na ${end},
	 TEL: ${tel}, FAX: ${fax} ,inscrita no C.N.P.J sob o n� ${cnpj}, representada neste ato pelo 
	 Sr.${represent} , c�dula de identidade n� ${ident_represent},  CPF: ${cpf_represent}, doravante denominada 
	 CONTRATADA, tendo em vista o decidido no Processo Administrativo n� ${n1}/${n2}/${n3} -EOF, atrav�s de 
	 despacho do Exm� Sr Juiz Federal - Diretor do Foro (fls. .......... dos autos), firmam o presente contrato, em 
	 conformidade com o disposto na Lei n� 10.520, de 17/07/2002, Decreto n� 3.555, de 08/08/2000 e, subsidiariamente, 
	 a Lei n� 8.666, de 21/06/93 e suas altera��es, mediante as cl�usulas e condi��es a seguir:</p>
	
	<h2>CL�USULA PRIMEIRA DO OBJETIVO</h2>
	
	<p style="TEXT-INDENT: 2cm" align="justify">1.1 - Constitui objeto do presente contrato o fornecimento de 
	${quantidade} (por extenso) ${forn}, conforme Termo de Refer�ncia do Preg�o n� ${pregao}/${ano}, que faz parte integrante 
	deste contrato.</p>
	OBS:<b>O objeto ser� alterado de acordo com o resultado da licita��o.</b>
	
	<h2>CL�USULA SEGUNDA - DO RECEBIMENTO E INSTALA��O(QUANDO HOUVER) DOS EQUIPAMENTOS</h2>
	
	<p style="TEXT-INDENT: 2cm" align="justify">2.1	A Contratada far� a entrega dos equipamentos na ${secao},
	 situada na Rua ${rua}, no prazo de ${prazo} dias, ap�s a assinatura do contrato.
OBS: O prazo de entrega ser� preenchido nos termos da proposta da licitante vencedora, observado o prazo m�ximo 
estipulado na Especifica��o.
	<p style="TEXT-INDENT: 2cm" align="justify">2.2 - O equipamento ser� recebido provisoriamente para inspe��o
	, visando a comprovar o atendimento �s especifica��es t�cnicas, no ato da entrega.</p>
	<p style="TEXT-INDENT: 2cm" align="justify">2.3 - No caso de sinais externos de avaria, o equipamento dever�
	ser imediatamente substitu�do pela Contratada.</p>
	<p style="TEXT-INDENT: 2cm" align="justify">2.4 - O objeto do presente contrato ser� recebido definitivamente, por servidor ou Comiss�o nomeada pela 
	Administra��o, no prazo de at� 15 (quinze) dias �teis, contados a partir do recebimento provis�rio, ap�s 
	verificada e comprovada a conformidade do material com as especifica��es exigidas no Edital do Preg�o</p>
	<p style="TEXT-IDENT: 2cm" aligen="justify">2.4.1 - A nota fiscal encaminha a pela contratad ser� atestada na mesma
	 data da expedi��o do termo de Recebimento Definitivo</p>
	 <h2>CL�USULA TERCEIRA - DAS OBRIGA��ES DA CONTRATADA:</h2>
	<p style="TEXT-INDENT: 2cm" align="justify">3.1 - A empresa contratada � respons�vel por:</p>
	<p style="TEXT-INDENT: 3cm" align="justify">a) qualquer acidente que venha a ocorrer com seus empregados e por danos que estes provoquem � Justi�a Federal ou a 
terceiros, n�o excluindo essa responsabilidade a fiscaliza��o ou o acompanhamento pela Contratante;</p>
		<p style="TEXT-INDENT: 3cm" align="justify">b) todos os encargos previdenci�rios e obriga��es sociais previstos na 
	legisla��o social trabalhista em vigor relativos a seus funcion�rios, vez que os mesmos n�o manter�o nenhum v�nculo 
	empregat�cio com a Se��o Judici�ria do Rio de Janeiro;</p>
	<p style="TEXT-INDENT: 3cm" align="justify">c) todas as provid�ncias e obriga��es estabelecidas na legisla��o 
	espec�fica de acidentes de trabalho, quando, em ocorr�ncia da esp�cie, forem v�timas os seus funcion�rios quando da 
	realiza��o dos servi�os contratados, ou em conex�o com eles;</p>
	<p style="TEXT-INDENT: 3cm" align="justify">d) todos os encargos de eventual demanda trabalhista, civil ou penal, 
	relacionados � presta��o dos servi�os, 
	originalmente ou vinculada por preven��o, conex�o ou contin�ncia;</p>
	<p style="TEXT-INDENT: 3cm" align="justify">e) todos os encargos fiscais e comerciais decorrentes do presente 
	contrato;</p>
	<p style="TEXT-INDENT: 3cm" align="justify">f) todas as despesas referentes  ao suporte de servi�os, durante  o prazo 
	de garantia, bem como pelo transporte de t�cnicos e equipamentos necess�rios ao cumprimento do presente contrato, sem
	�nus para a contratante.</p>
	<p style="TEXT-INDENT: 3cm" align="justify">e) todos os encargos fiscais e comerciais decorrentes do presente 
	contrato;</p>
	<p style="TEXT-INDENT: 3cm" align="justify">f) todas as despesas referentes  ao suporte de servi�os, durante  o prazo 
	de garantia, bem como pelo transporte de t�cnicos e equipamentos necess�rios ao cumprimento do presente contrato, sem 
	�nus para a contratante.</p>
	<p style="TEXT-INDENT: 2cm" align="justify">3.2 - A inadipl�ncia da contratada, com refer�ncia aos encargos sociais,
	comerciais e fiscais, n�o transfere a responsabilidade por seu pagamento � Administra��o da Se��o Judici�ria do Rio de
	Janeiro, raz�o pela qual a contratada renuncia expressamente a qualquer v�nculo de solidariedade, ativa ou passiva, com
	a SJRJ.</p>
	<p style="TEXT-INDENT: 2cm" align="justify">3.3 - A contratada dever� cumprir, ainda com as demis obriga��es constantes 
	da especifica��o elaborada pela Subsecretaria de Inform�tica, que integra o presente contrato.</p>
	<h2>CL�USULA QUARTA - DAS OBRIGA��ES DA CONTRATANTE:</h2>
	<p style="TEXT-INDENT: 2cm" align="justify">4.1 - Caber� � Contratante:
	 <p style="TEXT-INDENT: 3cm" align="justify">4.1.1 - permitir acesso, aos empregados da Contratada, �s instala��es da 
	 Contratante para a entrega/execu��o dos servi�os constantes do objeto.</p>
	 
	<p style="TEXT-INDENT: 3cm" align="justify">4.1.2 - prestar as informa��es e os esclarecimentos que venham a ser 
	solicitados pelos empregados da Contratada.</p>
	<p style="TEXT-INDENT: 3cm" align="justify">4.1.3 - rejeitar qualquer material/servi�o executado em desacordo 
	com as Especifica��es do Preg�o n� ${pregao}/${ano}.</p>
	<p style="TEXT-INDENT: 3cm" align="justify">4.1.4 - solicitar que seja substitu�do o material que n�o atender
	 �s Especifica��es do Preg�o n� ${pregao}/${ano}</p>
	<p style="TEXT-INDENT: 3cm" align="justify">4.1.5 - atestar as faturas correspondentes, por interm�dio da 
	Fiscaliza��o, designada pela Administra��o.</p>
	<h2>CL�USULA QUINTA - DO PRE�O E DO PAGAMENTO:</h2>
	<p style="TEXT-INDENT: 2cm" align="justify">5.1 - A Contratante pagar� � Contratada pelo fornecimento objeto deste Contrato, o valor total de 
	R$ ${valor} , inclusos todos os impostos e taxas vigentes, conforme tabela a seguir:</p>
	
        
       
       
       <table width="100%" border="0" cellpadding="1">       		
		
		  <c:forEach var="i" begin="1" end="${qtd}">
		
		 	<tr>								
		
			  <td>${requestScope[f:concat('desc',i)]}</td>
		
			  <td>${requestScope[f:concat('qtd_item',i)]}</td>
		
			  <td>${requestScope[f:concat('valor',i)]}</td>	
			 	
			</tr>
		
		  </c:forEach>					
        
        </table>
        
        		
		<p style="TEXT-INDENT:2cm" align="justify">5.2 - As Notas Fiscais/Faturas dever�o ser entregues 
		na Rua ${rua}, para serem devidamente atestadas.</p>
		
		<p style="TEXT-INDENT:2cm" align="justify">5.3 - O pagamento � Contratada ser� efetivado, por cr�dito em conta corrente, mediante ordem banc�ria, 
		at� o 10� dia �til ap�s a apresenta��o da fatura ou nota fiscal discriminativa do material entregue, 
		devidamente atestada por servidor ou Comiss�o nomeada pela Administra��o, salvo eventual atraso de distribui��o
		 de recursos financeiros efetuados pelo Conselho da Justi�a Federal, decorrente de execu��o or�ament�ria.</p>
		 
		 <p style="TEXT-INDENT:3cm" align="justify">5.3.1 - No per�odo acima n�o haver� atualiza��o financeira.</p>
		 
		 <p style="TEXT-INDENT:3cm" align="justify">5.3.2 - A fatura/nota fiscal dever� ser apresentada em 02 (duas) vias.</p>
		 
		 <p style="TEXT-INDENT:3cm" align="justify">5.3.3 - Ser� considerada como data do pagamento a data da emiss�o
		  da Ordem Banc�ria.</p>
		 <p style="TEXT-INDENT:2cm" align="justify">5.4 - Caso seja necessaria a retifica��o da fatura por culpa da 
		 contratada a flu�ncia do prazo de 10(dez) dias �teis ser� suspensa, reiniciando-se a contagem a partir da
		 reapresenta��o da fatura retificada</p>
		 
		 <p style="TEXT-INDENT:2cm" align="justify">5.5 - A Contratante reserva-se o direito de n�o efetuar o pagamento se, no ato da atesta��o, o material n�o
		  estiver em perfeitas condi��es ou de acordo com as especifica��es apresentadas e aceitas pela Contratada.
		  
		 <p style="TEXT-INDENT:2cm" align="justify">5.6 - A Se��o Judici�ria do rio de janeiro poder� deduzir da import�ncia a pagar os valores correspondentes a 
		 multas ou indeniza��es devidas pela contratada nos termos da presente ajuste.</p>
		 
		 <p style="TEXT-INDENT:2cm" align="justify">5.7 - A Contratada dever� confirmar, quando da apresenta��o da nota
		  fiscal � Contratante, a regularidade perante a Seguridade Social e ao Fundo de Garantia de Tempo de Servi�o,
		   atrav�s da apresenta��o da CND e do CRF, dentro das respectivas validades, sob pena de n�o pagamento do
		    material fornecido e de rescis�o contratual, em atendimento ao disposto no � 3�. do art. l95 da 
		    Constitui��o Federal, no art. 2� da Lei 9.012/95, e nos art. 55, inciso VIII e 78, inciso I, ambos da 
		    Lei 8.666/93.</p>
		    
		  <p style="TEXT-INDENT:2cm" align="justify">5.8 - Na ocasi�o da entrega da nota fiscal, a contratada dever�
		   comprovar a condi��o de optante pelo SIMPLES (Sistema Integrado de Pagamento de Impostos e Contribui��es das
		    Microempresas e Empresas de pequeno Porte), mediante a apresenta��o da declara��o indicada em ato 
		    normativo da Secretaria da Receita Federal e dos documentos, devidamente autenticados, que comprovem ser o
		     signat�rio da referida declara��o representante legal da empresa.</p>
		     
		  <p style="TEXT-INDENT:2cm" align="justify">As pessoas jur�dicas n�o optantes pelo SIMPLES e aquelas que ainda
		   n�o formalizaram a op��o sofrer�o a reten��o de impostos/contribui��es por esta Se��o Judici�ria no momento
		    do pagamento, conforme disposto no art. 64 da Lei n� 9.430, de 27/12/96, regulamentado por ato normativo
		     da Secretaria da Receita Federal.</p>
		
		   <h2>CL�USULA SEXTA - DA GARANTIA CONTRATUAL:</h2>
		   
		   <p style="TEXT-INDENT:2cm" align="justify">6.1 - A contratada presta, neste ato, garantia contratual, nos termos do art. 56, par�grafo 1� , da Lei 8.666/93, no valor de 
		   R$ ${garant_val}, equivalente a 5% (cinco por cento) do valor global deste contrato.</p>
		   
		   <h2>CL�USULA S�TIMA - DA DOTA��O OR�AMENT�RIA:</h2>
		   
		   <p style="TEXT-INDENT:2cm" align="justify">7.1 - As despesas decorrentes do objeto deste contrato, correr�o
		    � conta dos recursos consignados � Se��o Judici�ria do Rio de Janeiro, para o corrente exerc�cio, conforme
		     o especificado abaixo:</p>
		     
		   <p style="TEXT-INDENT:4cm" align="justify">	Programa de Trabalho:</p> 
	       <p style="TEXT-INDENT:4cm" align="justify">  Elemento de Despesa:</p>
           <p style="TEXT-INDENT:4cm" align="justify">	Nota de Empenho:</p>
           
           <h2>CL�USULA OITAVA - DO PRAZO DE GARANTIA E DA ASSIST�NCIA T�CNICA:</h2>
           
           <p style="TEXT-INDENT:2cm" align="justify">8.1 - O prazo de garantia dos equipamentos � de ${garant_mes}
            meses, contados do recebimento definitivo dos mesmos.</p>
            
            <p style="TEXT-INDENT:2cm" align="justify"><b>* O prazo de garantia ser� o constante na proposta da licitante 
            vencedora, respeitado o prazo m�nimo constante no Termo de Refer�ncia, que integra o presente Contrato.<b></p>
           
           <p style="TEXT-INDENT:2cm" align="justify">8.2 - A Contratada dever� dar atendimento total durante o per�odo
            de garantia dirigindo-se ao local onde o equipamento estiver instalado na Se��o Judici�ria do Rio de 
            Janeiro, conforme constante no Termo de Refer�ncia do Preg�o n�${pregao}/ ${ano_preg}, que integra o presente 
            contrato.</p>
            <p style="TEXT-INDENT:2cm" align="justify">8.2.1 - O prazo de garantia ser� contado a partir de entrega e
            recebimento definitivo de equipamento, durante o qual, caso apresente algum defeito dever� ser substituido 
             por outro novo de mesma caracter�stia ou superior </p>
             
             <h2>CL�USULA NONA - DAS PENALIDADES:</h2>
             
             <p style="TEXT-INDENT:2cm" align="justify">9.1 - O n�o cumprimento pela contratada de qualquer uma das 
             obriga��es, dentro dos prazos estabelecidos por este contrato, sujeit�-la-� �s penalidades previstas nos 
             artigos 86 a 88 da Lei n� 8.666/93;</p>
             
             <p style="TEXT-INDENT:2cm" align="justify">9.2 - As penalidades a que est� sujeita a contratada 
             inadimplente, nos termos da Lei no 8.666/93, s�o as seguintes:</p>
             
             <p style="TEXT-INDENT:3cm" align="justify">a) Advert�ncia;
             <p style="TEXT-INDENT:3cm" align="justify">b) Multa;
             <p style="TEXT-INDENT:3cm" align="justify">c) Suspen��o tempor�ria de participar emlicita��o e 
             impedimento em contratar com a Administra��o por prazo n�o superior a 2(dois) anos.
             
             <p style="TEXT-INDENT:2cm" align="justify">9.3 - A recusa injustificada em assinar o Contrato, aceitar ou
              retirar o instrumento equivalente, dentro do prazo estabelecido pela Administra��o, sujeita o 
              adjudicat�rio � penalidade de multa de at� 10% (dez por cento) sobre o valor da adjudica��o, 
              independentemente da multa estipulada no subitem 9.4.2.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.4 - A inexecu��o total ou parcial do contrato poder� 
              acarretar, a crit�rio da Administra��o, a aplica��o das multas, alternativamente:</p>
              <p style="TEXT-INDENT:3cm" align="justify">9.4.1 - Multa compensat�ria de at� 30% (trinta por cento)
               sobre o valor equivalente � obriga��o inadimplida.</p>
              <p style="TEXT-INDENT:3cm" align="justify">9.4.2 - Multa correspondente � diferen�a entre o valor total porventura resultante de nova 
              contrata��o e o valor total que seria pago ao adjudicat�rio.</p>
              <p style="TEXT-INDENT:3cm" align="justify">9.4.3 - Multa de 50% (cinq�enta por cento) sobre o valor 
              global do contrato, no caso de inexecu��o total do mesmo.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.5 - A atualiza��o dos valores correspondentes � multa estabelecida no item 9.4  far-se-� a partir do 1� (primeiro) 
              dia, decorrido o prazo estabelecido no item 9.7.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.6 - Os atrasos injustificados no cumprimento das obriga��es 
              assumidas pela contratada sujeita-la � multa di�ria, at� a data do efetivo adimplemento, de 0,3% 
              (tr�s d�cimos por centavo calculada a bese de juros compostos sem preju�zodas demais penalidades 
              previstas na Lei n� 8.666/93</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.6.1 - A multa morat�ria estabelecida ficar� limitada � 
              estipulada para inexecu��o parcial ou total do contrato (subitem 9.4.1).</p>
              <p style="TEXT-INDENT:3cm" align="justify">9.6.2 - O periodo de atraso ser� contado em dias corridos.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.7 - A multa dever� ser paga no prazo de 30 (trinta) dias, 
              
              contados da data do recebimento da intima��o por via postal, ou da data da juntada aos autos do mandato
              de intima��o cumprido, conforme o caso.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.8 - Caso a multa n�o seja paga no prazo estabelecido no item 9.7, dever� ser descontada dos 
              pagamentos (ou da garantia) do respectivo contrato, ou, ainda, cobrada judicialmente, se for o caso.</p>
              <p style="TEXT-INDENT:3cm" align="justify">9.8.1 - Se a multa for superior ao valor da garantia prestada, al�m da perda desta, responder� o 
              contratado pela diferen�a faltante. (este subitem s� entra se houver cl�usula de garantia).</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.9 - A atualiza��o dos valores correspondentes �s multas 
              estabelecidas neste Contrato dar-se-� atrav�s do IPCA-E/IBGE, tendo em vista o disposto no art. 1� da 
              Lei n� 8.383, de 30/12/91 ou de outro �ndice, posteriormente determinado em lei.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.10 - A contagem dos prazos dispostos neste Contrato
              obedecer� ao disposto no art. 110, da Lei n� 8.666/93.</p>
              <p style="TEXT-INDENT:2cm" align="justify">9.11 - Os procedimentos de aplica��o e recolhimento das 
              multas foram regulamentadas pela IN n� 24-12, do Egr�gio Tribunal Regional Federal da 2� Regi�o.</p>
             <h2>CL�USULA D�CIMA - DA RESCIS�O:</h2>
             <p style="TEXT-INDENT:2cm" align="justify">10.1 - A inexecu��o parcial ou total do Contrato enseja a
             sua rescis�o, conforme disposto nos artigos 77 a 80 da Lei n� 8.666/93, sem preju�zo da aplica��o das 
             penalidades previstas na Cl�usula Nona.</p>
             <p style="TEXT-INDENT:2cm" align="justify">10.2 - A rescis�o do Contrato poder� ser:</p>
             <p style="TEXT-INDENT:3cm" align="justify">10.2.1 - determinada por ato unilateral e escrito da 
             Administra��o da Se��o Judici�ria do Rio de Janeiro, nos casos enumerados nos inciso I a XII e XVII 
             do art. 78 da lei mencionada.</p>
             <p style="TEXT-INDENT:4cm" align="justify">10.2.1.1 - Nos casos previstos nos incisos I a VIII e XI a
             XVII, a Administra��o notificar� a Contratada, atrav�s de Of�cio, com prova de recebimento.</p>
             <p style="TEXT-INDENT:4cm" align="justify">10.2.1.2 - Nos casos previstos nos incisos IX e X, a rescis�o dar-se-� de pleno direito, 
             independentemente de aviso ou interpela��o judicial ou extrajudicial.</p>
             <p style="TEXT-INDENT:3cm" align="justify">10.2.2 - amig�vel, por acordo entre as partes, desde que 
              haja conveni�ncia para a Administra��o da Se��o Judici�ria do Rio de Janeiro.</p>
             <p style="TEXT-INDENT:3cm" align="justify">10.2.3 - judicial, nos termos da legisla��o vigente sobre a
              mat�ria.</p>
             <p style="TEXT-INDENT:2cm" align="justify">10.4 - A rescis�o ser� determinada na forma do art. 79 da Lei n� 8.666/93.</p>
             <h2>CL�USULA D�CIMA PRIMEIRA - DA DOCUMENTA��O COMPLEMENTAR:</h2> 
             <p style="TEXT-INDENT:2cm" align="justify">11.1 - Fazem parte integrante do presente contrato, independentemente de 
             transcri��o, os  seguintes documentos:</p>
             <p style="TEXT-INDENT:3cm" align="justify">a) Preg�o n� ${pregao}/ ${ano_preg} e seus anexos.</p>
             <p style="TEXT-INDENT:3cm" align="justify">b) Proposta da Contratada apresentada � Contratante em (data).</p>
             <h2>CL�USULA D�CIMA SEGUNDA - DA PUBLICA��O:</h2>
             	
             <p style="TEXT-INDENT:2cm" align="justify">12.1 - O presente contrato ser� publicado no Di�rio Oficial
              da Uni�o, na forma de extrato, de acordo com o que determina do par�grafo �nico do artigo 61 da Lei n�
              8.666/93.
             <h2>CL�USULA D�CIMA TERCEIRA - DA FISCALIZA��O:</h2>
             <p style="TEXT-INDENT:2cm" align="justify">13.1 - A execu��o dos servi�os ser� acompanhada e fiscalizada por servidores/comiss�o, designados pela 
            	Administra��o.</p>
            <p style="TEXT-INDENT:2cm" align="justify">13.2 - O representante anotar� em registro pr�prio todas as ocorr�ncias relacionadas com a execu��o 
            dos servi�os mencionados, determinando o que for necess�rio � regulariza��o das faltas ou defeitos 
            observados.</p>
            <p style="TEXT-INDENT:2cm" align="justify">13.3 - As decis�es e provid�ncias que ultrapassarem a 
            compet�ncia do representante ser�o solicitadas a seus superiores em tempo h�bil para a ado��o das medidas
             convenientes.</p>
            <p style="TEXT-INDENT:2cm" align="justify">13.4 - O exerc�cio da fiscaliza��o pela contratante n�o excluir�
            a responsabilidade da contratada.</p>
            <h2>CL�USULA D�CIMA QUARTA - DOS RECURSOS ADMINISTRATIVOS</h2>
            <p style="TEXT-INDENT:2cm" align="justify">14.1 - Aplica-se o disposto no art. 109 da lei 8.666/93.</p>
            <H2>CL�USULA D�CIMA QUINTA - DAS CONSIDERA��ES FINAIS:</H2>
            
            <p style="TEXT-INDENT:2cm" align="justify">15.1 - O contrato poder� ser aditado nos termos previstos no 
            art. 65 da Lei n� 8.666/93, com a apresenta��o das devidas justificativas</p>
            <p style="TEXT-INDENT:2cm" align="justify">15.2 - A Contratada dever� manter durante toda a execu��o do 
            contrato, em compatibilidade com as obriga��es por ela assumidas, todas as condi��es de habilita��o e 
            qualifica��o exigidas na licita��o</p>
            <h2>CL�USULA D�CIMA SEXTA - DO FORO:</h2>
            <p style="TEXT-INDENT:2cm" align="justify">16.1 - Para dirimir as quest�es oriundas do presente contrato, 
            fica eleito o Foro da Justi�a Federal - Se��o Judici�ria do Rio de Janeiro.</p>
            <p style="TEXT-INDENT:2cm" align="justify">E por estarem ajustados, � lavrado o presente termo de contrato, 
            extra�do em 03 (tr�s) vias de igual teor e forma, que depois de lido e achado conforme vai assinado pelas 
            partes contratantes.</p>
            
            <p style="TEXT-INDENT:5cm" align="justify">Rio de janeiro,&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            &nbsp&nbsp de &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp de &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            &nbsp .<br><br>
            
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ____________________________________________
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp JUSTI�A FEDERAL DE 1� GRAU NO RIO DE JANEIRO<br><br>             
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ____________________________________________
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp EMPRESA
                      
	</mod:documento>

</mod:modelo>
</body>
