<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="esconderTexto" value="sim" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/solicitacao.jsp">
	<mod:entrevista>
		<mod:grupo titulo="DADOS DO ESTAGI�RIO">
			<mod:grupo>
				<mod:texto titulo="Nome" var="nomeEstagiario" largura="60" />
				<mod:data titulo="A partir de" var="data" />
			</mod:grupo>
			<mod:grupo>
				<mod:lotacao titulo="Lota��o" var="lotacaoEstagiario" />
			</mod:grupo>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>

	<mod:valor var="texto_solicitacao">	<p style="TEXT-INDENT: 2cm" align="justify">Solicito a <b>EMISS�O</b> do crach� de identifica��o
		do estagi�rio <b>${nomeEstagiario}</b>, lotado neste(a) <b>${requestScope['lotacaoEstagiario_lotacaoSel.descricao']}</b>
		a partir de <b>${data}</b>, e para tanto anexa ao presente a seguinte documenta��o:
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
		<ul>
				<li>01 foto 3 X 4;</li>
				<li>Formul�rio de cadastramento devidamente preenchido e assinado;</li>
				<li>Documento da EMARF(of�cio) ou da DICRE/SRH(encaminhamento)
				que apresenta o estagi�rio.</li>
		</ul>
		</p>
		
	</mod:valor>	

	</mod:documento>

</mod:modelo>
