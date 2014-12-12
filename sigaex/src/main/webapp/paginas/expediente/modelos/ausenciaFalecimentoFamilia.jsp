<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
REQUERIMENTO PARA AUS�NCIA AO SERVI�O EM RAZ�O DE FALECIMENTO EM FAMILIA 
A SABER: falecimento do c�njuge, companheiro, pais, madrasta ou padrasto, 
filhos, enteados, menor sob guarda ou tutela e irm�os. -->

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>

		<mod:grupo titulo="DETALHES DO FALECIDO">
			<mod:texto titulo="Nome do Parente Falecido" largura="60" var="nomeParenteFalecido"/>
		</mod:grupo>
		
		<mod:grupo>	
			<mod:selecao titulo="Grau de parentesco" var="grauParentesco"
				opcoes="Pai;M�e;Padrasto;Madrasta;irm�o;irm�;Filho;Filha;
				Enteado;Enteada;C�njugue;Companheiro;Companheira;Menor sob Guarda ou Tutela" />
		</mod:grupo>
	</mod:entrevista>
	
	<mod:documento>		
		<mod:valor var="texto_requerimento">
			<p style="TEXT-INDENT: 2cm" align="justify">
				${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria <b>AUS�NCIA AO SERVI�O EM RAZ�O DO FALECIMENTO </b>
				de ${nomeParenteFalecido}, ${grauParentesco}, com base na al�nea 
				 b, inciso III, art. 97 da Lei 8.112/90.
			</p>
		</mod:valor>	
</mod:documento>
</mod:modelo>
