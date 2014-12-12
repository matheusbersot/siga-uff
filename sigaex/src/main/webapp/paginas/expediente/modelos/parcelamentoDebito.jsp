<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib prefix="ww" uri="/webwork"%>

<!-- 
     Modelo : Parcelamento de Debito
     Data da Criacao : 04/01/2007
     Ultima alteracao : 20/10/2009 
-->
<c:set var="para" value="diretoraRH" scope="request" />
<c:set var="esconderTexto" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		<mod:grupo>
			<mod:monetario titulo="Valor do D�bito" largura="12"
				maxcaracteres="10" var="valorDebito" formataNum="sim"
				extensoNum="sim" reler="sim" />
			<mod:oculto var="valorDebitovrextenso" valor="${valorDebitovrextenso}" />
		</mod:grupo>
		<mod:grupo>
			<b> <mod:memo colunas="60" linhas="3" titulo="Motivo do D�bito"
				var="motivoDebito" /> </b>
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
		<mod:valor var="texto_requerimento">
		<p style="TEXT-INDENT: 2cm" align="justify"><c:import
			url="/paginas/expediente/modelos/subscritorIdentificacao.jsp" />
		vem requerer a Vossa Senhoria o parcelamento do
		d�bito no valor de R$ ${valorDebito} (${valorDebitovrextenso})
		contra�do em raz�o de ${motivoDebito}, conforme disp�e o art. 46 da
		Lei 8112/90 c/ reda��o dada pela MP 2225-45, de 04/09/01.</p>
		</mod:valor>
		
	</mod:documento>
</mod:modelo>
