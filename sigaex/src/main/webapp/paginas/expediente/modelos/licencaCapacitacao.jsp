<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista> 
	<mod:grupo titulo="Per�odo de Licen�a para Capacita��o">
			<mod:data titulo="De" var="dataInicio" />
			<mod:data titulo="a" var="dataFim" />
		</mod:grupo>
		    
			<mod:selecao titulo="Participa��o em:" var="cursos" opcoes="Curso de Capacita��o;Pesquisa e Levantamento de Dados" reler="ajax" idAjax="cursosAjax" />
				<mod:grupo depende="cursosAjax">
					<c:if test="${cursos eq 'Pesquisa e Levantamento de Dados'}">
						<mod:texto titulo="Tema do curso:" var="temaCurso" largura="60" />
					</c:if>
				</mod:grupo>
		
	</mod:entrevista>
	
	<mod:documento>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			@page {
				margin-left: 3cm;
				margin-right: 2cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
		</style>
		</head>
		<body>
		<c:import url="/paginas/expediente/modelos/inc_tit_juizfedDirForo.jsp" />
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, vem requerer a Vossa Senhoria, nos termos do art.87, da Lei n&ordm; 8.112/90, com a
		reda��o da Lei n&ordm; 9.527/97, c/c Resolu��o n&ordm; 5/2008, do Conselho da Justi�a Federal, e Resolu��o n&ordm; 22/2008, do TRF da 2� Regi�o, <b>LICEN�A PARA CAPACITA��O</b> a que faz jus, para frui��o 
		<c:choose>
				<c:when test="${(dataInicio == dataFim) or (empty dataFim)}">
					no dia <b>${dataInicio}</b>,
				</c:when>
					<c:otherwise>
					no per�odo de <b>${dataInicio}</b> a <b>${dataFim}</b>,
					</c:otherwise>
			</c:choose>
		
		destinada � 
			<c:choose>
				<c:when test="${cursos eq 'Curso de Capacita��o'}">
					participa��o em Curso de Capacita��o.
				</c:when>
				<c:otherwise>
					pesquisa e levantamento de dados necess�rios � elabora��o de trabalho para conclus�o de curso de p�s-gradua��o, cujo tema �: ${temaCurso}.				
				</c:otherwise>
			</c:choose>
		</p>
		
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
		<br/>
		<br/>
		<p align="center">${doc.dtExtenso}</p>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?apenasCargo=sim" />
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
			
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<c:import url="/paginas/expediente/modelos/inc_tit_termoCompromisso.jsp" />
		<p style="TEXT-INDENT: 2cm" align="justify">
		${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao}, firma o compromisso de apresentar relat�rio semanal das atividades desenvolvidas, 
		devidamente endossado pelo orientador ou coordenador do respectivo curso, nos termos do art. 2�, da Resolu��o n� 22/2008, do TRF da 2� Regi�o, tendo em vista tratar-se de licen�a para capacita��o com a finalidade de conclus�o de curso de especializa��o, mestrado ou doutorado. 
		</p>
		<br/>
		<br/>
		<p align="center">${doc.dtExtenso}</p>
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?apenasCargo=sim" />
		
		<c:import url="/paginas/expediente/modelos/inc_quebra_pagina.jsp" />
		<br/>
        <br/>
        <c:import url="/paginas/expediente/modelos/inc_tit_declaracao.jsp" />
		<p style="TEXT-INDENT: 2cm" align="justify">
        
        ${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, ${doc.subscritor.padraoReferenciaInvertido}, lotado(a) no(a) ${doc.subscritor.lotacao.descricao},declara, nos termos do � 7� do art. 23 da Resolu��o n� 5/2008, do CJF, estar ciente de que:</br>
        <br/>
        1 -  Ao final da atividade dever� apresentar � Subsecretaria de Gest�o de Pessoas, no prazo m�ximo de 30 dias, os seguintes documentos comprobat�rios, conforme natureza da a��o de capacita��o: comprovante de frequ�ncia, participa��o e aproveitamento no evento objeto da licen�a, nas hip�teses de participa��o em evento com carga hor�ria m�nima de 12 horas; comprovante de entrega de monografia, disserta��o, tese ou trabalho de conclus�o de curso de gradua��o ou p�s-gradua��o, bem como a entrega de c�pia do trabalho final de curso, preferencialmente por meio eletr�nico, � unidade de recursos humanos do �rg�o; comprovante de participa��o em atividade de orienta��o para elabora��o de monografia, disserta��o, tese ou trabalho de conclus�o de curso de gradua��o ou p�s-gradua��o; declara��o de aprova��o ou certificado de conclus�o do curso; declara��o de participa��o em processo seletivo para ingresso em curso de p�s-gradua��o stricto sensu ou de obten��o de certifica��o de compet�ncias profissionais.<br>
        <br/>
        <br/>
        2 -  Na hip�tese de n�o participa��o integral no evento objeto da licen�a, dever� requerer, mediante justificativa pertinente, a interrup��o da licen�a, com o retorno imediato ao trabalho. <br>
        <br/>
        <br/>
       3 -  A aus�ncia de comprova��o de que trata o item 1 ou o n�o acatamento da justificativa de que trata o item 2 ensejar� a cassa��o da licen�a com efeito retroativo, sendo computados como faltas ao servi�o e descontados em folha de pagamento os dias referentes � licen�a cassada, garantidos o contradit�rio e a ampla defesa. Nos termos da legisla��o vigente, ser� instraurada sindic�ncia para apura��o de infra��o disciplinar.<br>
      </p>
        <br/>
        <br/>
        <c:import
            url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
		</body>
		</html>
	</mod:documento>
</mod:modelo>
