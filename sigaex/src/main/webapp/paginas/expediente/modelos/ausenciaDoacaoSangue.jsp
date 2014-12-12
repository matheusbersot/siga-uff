<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de 
AUSENCIA AO SERVI�O PARA DOA��O DE SANGUE -->
<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<c:set var="acordoSuperior" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>		
		<mod:grupo titulo="DETALHES SOBRE A DOA��O DO SANGUE">
		    <mod:data titulo="Data da Doa��o" var="dataDoacaoSangue"/>
		</mod:grupo>
	</mod:entrevista>
	
	<mod:documento>
		<mod:valor var="texto_requerimento">
			 <p style="TEXT-INDENT: 2cm" align="justify">
			   	${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria, nos termos do art. 97, I, da 
				 Lei n.� 8.112/90, <b>AUS�NCIA AO SERVI�O PARA DOA��O DE SANGUE</b>, 
				 no dia ${dataDoacaoSangue}.
			 </p>			 
			 <p style="TEXT-INDENT: 2cm" align="justify">
				 Para tanto, compromete-se a apresentar, com a maior brevidade
				 poss�vel, o comprovante de doa��o.
			 </p>	
		</mod:valor>
	</mod:documento>
</mod:modelo>
