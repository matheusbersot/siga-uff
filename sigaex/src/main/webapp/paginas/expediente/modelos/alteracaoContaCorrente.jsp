<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
REQUERIMENTO PARA ALTERA��O DE CONTA CORRENTE  -->


<c:set var="esconderTexto" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">	
	<mod:entrevista>
	<mod:grupo titulo="DETALHES DO CREDITOS DO VENCIMENTOS EM BANCO">		
		<mod:texto largura="44" titulo="Nome do Banco a Creditar" var="banco" />
	</mod:grupo>
	<mod:grupo>	
		<mod:texto titulo="N� da Ag�ncia" var="agencia"/> (com d�gito verificador)
	</mod:grupo>
	<mod:grupo>	
		<mod:texto titulo="Nome da Ag�ncia" var="nomeAgencia"/>
	</mod:grupo>
	<mod:grupo>
		<mod:texto titulo="N� da C/C" var="contacorrente" /> (com d�gito verificador)
	</mod:grupo>
	
	</mod:entrevista>	
	
	<mod:documento>
		<mod:valor var="texto_requerimento">		
			<p style="TEXT-INDENT: 2cm">
			Eu, ${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
				${doc.subscritor.padraoReferenciaInvertido},
				lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem respeitosamente, requerer a Vossa Senhoria, que meus vencimentos sejam creditados
			no Banco ${banco}, da Agencia n� ${agencia} , nome da Ag�ncia: ${nomeAgencia}
			e c/c n� ${contacorrente}</b>.
			</p>	
		</mod:valor>
	
		</body>
		</html>
	
	</mod:documento>
</mod:modelo>
