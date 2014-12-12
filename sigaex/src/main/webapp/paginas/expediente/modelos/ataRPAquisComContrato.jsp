<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- este modelo trata de
solicita��o de inscri��o para capacita��o sem onus -->

<mod:modelo>
	 <mod:entrevista>
		
			
			<mod:grupo titulo="Ata de registro de pre�os">
				<mod:texto	titulo="Quantidade de itens" largura="3" var="qtd" relertab="sim" />
							
				
		<c:forEach var="i" begin="1" end="${qtd}">
					<mod:grupo>
							<mod:texto titulo="Item" largura="20" var="item${i}" />
							
							<mod:texto titulo="descri��o" largura="20" var="descricao${i}" />
							
							<mod:texto titulo="Quantidade" largura="5" maxcaracteres="3" var="quantidade${i}" />
																					
							<mod:texto titulo="Pre�o" largura="8" maxcaracteres="6" var="preco${i}" />
							
							
					
					</mod:grupo>
					
				
			</c:forEach>
			<mod:grupo titulo="Representante">
							
				<mod:texto titulo="Nome"  var="nome" />
				
				<mod:monetario titulo="Identidade" largura="11" maxcaracteres="9" var="ident" verificaNum="sim"/>
				
				<mod:monetario titulo="CPF" largura="12" maxcaracteres="10" var="cpf" verificaNum="sim"/>		
					
			</mod:grupo>
			<mod:grupo titulo="Preg�o">
			
				<mod:monetario titulo="Numero" largura="12" maxcaracteres="10" var="pregao" verificaNum="sim"/>
			    
				
				<mod:monetario titulo="validade" largura="4" maxcaracteres="2" var="validade" verificaNum="sim"/>
				
			</mod:grupo>
			
				<mod:grupo titulo="Empresas">
				
				<mod:texto	titulo="Quantidade de empresas" largura="5" maxcaracteres="3" var="qtd_emp" relertab="sim" />
			
				<c:forEach var="i" begin="1" end="${qtd_emp}">
				
					<mod:grupo>
					
						<mod:texto titulo="Nome ${i}" var="empresa${i}"/> 
						
						<mod:texto titulo="Representante ${i}" var="repr_emp${i}"/>
						
						<mod:monetario titulo="CPF representante" largura="14" maxcaracteres="11" var="repr_cpf${i}" verificaNum="sim"/>
						
						 
					
					</mod:grupo>
				
				</c:forEach>
			
			</mod:grupo>
			
			<mod:data titulo="Data" var="data"/>
				
		</mod:grupo>				
		
	</mod:entrevista>
	
	<mod:documento>
	
	<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp"/>
	
	<h1> ATA DE REGISTRO DE PRE�OS N�_____/20_____
		PROCESSO N�____/_____/_____-EOF
	
	<p style="TEXT-INDENT: 2cm" align="justify"> A justi�a Federal de 1� Grau no Rio de Janeiro, com sede na Av. Rio Branco, 243 - Anexo
	14� andar, Centro/RJ, inscrita no C.N.P.J. sob o n� 05.424.540/0001-16, neste ato representada pelo Dr ${nome}, juiz Federal - Diretor do Foro,
	identidade n� ${ident}, CPF${cpf} doravante denominada JUSTI�A FEDERAL, resolve,
	em face das propostas no<b> Preg�o n�&nbsp ${pregao}/ ,REGISTRAR OS PRE�OS  para contrata��o<b> da(s) empresa(s) denominada(s) FORNECEDORA(S),
	conforme especificado no Anexo 1 do Edital, que passa a fazer parte desta, tendo sido o(s) referido(s) pre�o(s) oferecido(s) pela(s) empresa(s)
	 cuja(s) proposta(s) foi(ram) classificada(s) em primeiro(s) lugare(es) no certame acima numerado, como segue,em conformidade
	 com o disposto na lei N�10.520, de 17/07/2002 Decreto n� 3.555, de 08/08/2000 e n� 3931, de 19/09/2001 e, subsidiariamente, a lei n� 8.666, de 
	 21/06/93 e suas altera��es , mediante as cl�usulas e condi��es a seguir:</P>  
	
	
	<table width="100%" border="0" cellpadding="1">
	<tr>
		<td>item</td><td>Pre�o Unit�rio</td><td>Quantidade</td><td>Descri��o</td>
	</tr>
	
	
	<table width="100%" border="0" cellpadding="1">
       		
			<c:forEach var="i" begin="1" end="${qtd}">
			<tr>	
							
					<td>${requestScope[f:concat('preco',i)]}</td>
					<td>${requestScope[f:concat('quantidade',i)]}</td>
					<td>${requestScope[f:concat('descricao',i)]}</td>
					<td>${requestScope[f:concat('item',i)]}</td>
					
					
								
					
			</tr>
			</c:forEach>
						
		</table>
		
		<table width="100%" border="0" cellpadding="1">
		
			<td>A empresa vencedora:</td>
			
		</table>
		
		
		
		<H2>CL�USULA PRIMEIRA - DO OBJETIVO</H2>
		
		<p style="TEXT-INDENT: 2cm" align="justify">1.1. Contrata��o de empresa para fornecimento de produtos, conforme especifica��es constante do termo de Refer�ncia do Edital do Preg�o 
		n�${pregao}/.</p>
		    
		<h2>CL�USULA SEGUNDA - DA VALIDADE DOS PRE�OS</h2>
		
		<p style="TEXT-INDENT: 2cm" align="justify">2.1. A presente Ata de Registro de Pre�os ter� validade de ${validade} 
		meses, apartir da sua assinatura.</p> 
		
		<p style="TEXT-INDENT: 2cm" align="justify"><b>PARAGRAFO �NICO</b>: A presente Ata poder� ser prorrogada, na forma autorizada 
		pelo art. 4� Decreto n� 3.931/2001.</p>
		
		<p style="TEXT-INDENT: 2cm" align="justify">2.2. Durante o prazo de validade desta Ata de Registro de Pre�os, a Justi�a Federal n�o ser� obrigada a firmar as contrata��es que deles poder�o adivir
		, facultando-se a realiza��o de licita��o espec�fica para aquisi��o pretendida, sendo assegurado ao benefici�rio do registro prefer�ncia de fornecimento
		em igualdade de condi��es.</p>
		
		<h2>CL�USULA TERCEIRA - DA UTILIZA��O DA ATA DE REGISTRO DE PRE�OS</h2>

		 <p style="TEXT-INDENT: 2cm" align="justify">3.1. A presente Ata de Registro de Pre�os poder� ser usada por org�os usu�rios, desde que autorizadas pela JUSTI�A FEDERAL.

		 <p style="TEXT-INDENT: 2cm" align="justify">3.2. O pre�o ofertado pela(s) empresa(s) siginat�rias da presente Ata de Registro de Pre�os � o especificado em anexo, de a cordo com  a respectiva
		  classifica��o no preg�o n�${pregao}/.

		 <p style="TEXT-INDENT: 2cm" align="justify">3.3. Em cada fornecimento decorrente desta Ata, ser�o observadas, quanto ao pre�o, as cl�usulas e condi�oes constantes 
		 do Edital do Preg�o N� ${pregao}/ , que a procedeu e integra o presente instrumento de compromisso.

		 <p style="TEXT-INDENT: 2cm" align="justify">3.4. A cada fornecimento, o pre�o unit�rio a ser pago ser� o constante da proposta
		  apresentada no preg�o N� ${pregao} , pela(s) empresa(s) detentora(s) da presente Ata, as quais tamb�m a integram.</p>

		 <h2>CL�USULA QUARTA DO LOCAL E PRAZO DA ENTREGA </h2>

		 <p style="TEXT-INDENT: 2cm" align="justify">4.1. A cada fornecimento, o prazo de entrega do produto ser� acordado pela unidade requisitante 
		 ,n�o podendo, todavia, ultrapassar o prazo estipulado na especifica��o do Edital do preg�o N� ${pregao}/.</p>

		 <h2>CL�USULA QUINTA - DO PAGAMENTO</h2>

		 <p style="TEXT-INDENT: 2cm" align="justify">5.1. A cada fornecimento o pagamento ser� efetivado, por cr�dito em conta corrente, mediante ordem banc�ria, at� o 10(d�cimo) dia �til ap�s a apresenta��o da fatura 
		 ou nota fiscal discriminativa do material entregue, devidamente atestada por servidor ou comiss�o nomeada pelo org�o requisitante, conforme item 16 do Edital.</p>

		 <h2>CL�USULA SEXTA - DA AUTORIZA��O PARA AQUISI��O E EMISS�O DAS ORDENS DE FORNECIMENTO</h2>

		 <p style="TEXT-INDENT: 2cm" align="justify">6.1. As aquisi��es do objeto da presente Ata de Registro de Pre�os ser�o autorizadas, conforme a necessidade, pelo Juiz Federal Diretor do Foro da JUSTI�A FEDERAL - Se��o Judici�ria do Rio de Janeiro.</p>

		 <p style="TEXT-INDENT: 2cm" align="justify">6.2. A emiss�o das ordens de fornecimento, sua retifica��o ou cancelamento total ou parcial ser�o igualmente autorizadas pelo Juiz Federal Diretor do Foro da JUSTI�A FEDERAL - Se��o Judici�ria do Rio de Janeiro.</p>

		 <h2>CL�USULA S�TIMA - DAS DISPOSI��ES FINAIS</h2>

		 <p style="TEXT-INDENT: 2cm" align="justify">7.1. Integram esta Ata, o Edital do preg�o N�${pregao} / e seus anexos, as propostas das empresa(s): <c:forEach var="i" begin="1" end="${qtd_emp}">Empresa${i} - ${requestScope[f:concat('empresa',i)]}; </c:forEach>
		 ,classificadas em primeiro(s) lugar(es), respectivamente, no certame supra numerado.</p>

		 <h2>CL�USULA OITAVA DO FORO</h2>

		 <p style="TEXT-INDENT: 2cm" align="justify">8.1 - Pra dirimir as quest�es decorrentes da utiliza��o da presente Ata de Registro de Pre�os, fica eleito o Foro da Justi�a Federal - Se��o Judiciaria do Rio de Janeiro, 
		 sendo os casos omissos resolvido de acordo com a lei N� 10.520/2002 e decreto 3.555/2000, alterada, e demais normas aplic�veis.</p>

		 <p style="TEXT-INDENT: 2cm" align="justify">E por estarem ajustados, � lavrada a presente Ata, extra�da em 03(tr�s) vias de igual teor e forma, que depois de lida e achada conforme vai assinada pelas partes.</p>   
		 
		 <p style="TEXT-INDENT: 5cm" align="justify">Rio de Janeiro,&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp    de &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp      de &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp      .</p>
		 
		                                                                        
		                                                                        
		                                                                                     ____________________________________________________________<BR>
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp												JUSTI�A FEDERAL DE 1� GRAU NO RIO DE JANEIRO<BR>
		 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp     JUIZ FEDERAL - DIRETOR DO FORO<BR>   
		 																																															             
		<br>
		<br>          
		 EMPRESAS:<br><br>
		 
		 <c:forEach var="i" begin="1" end="${qtd_emp}">
		 
		_______________________________________________________<br>
		 ${requestScope[f:concat('empresa',i)]}<br>
		 (Representante: ${requestScope[f:concat('repr_emp',i)]},CPF: ${requestScope[f:concat('repr_cpf',i)]})<br><br>
		
		</c:forEach>
		
	</mod:documento>

</mod:modelo>
