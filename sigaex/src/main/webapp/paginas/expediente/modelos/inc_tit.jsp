<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- ESSE MODELO DEFINE O TITULO DE INICIO DOS DOCUMENTOS -->

<c:choose>		
			<c:when	test="${(not empty doc.lotaDestinatario and doc.lotaDestinatario.orgaoUsuario.acronimoOrgaoUsu == 'CJF')}">
				<c:choose>
					<c:when test="${not empty texto_destinatario}">
						<h1 align="center">${texto_destinatario}</h1>
					</c:when>
					<c:when test="${para eq 'sepag'}">
						<h1>Ilma. Sra. Secret�ria de Recursos Humanos</h1>
					</c:when>
					<c:when
						test="${para eq 'diretorForo' || (not empty doc.lotaDestinatario and f:lotacaoPorNivelMaximo(doc.lotaDestinatario,4).sigla == 'DIRFO')}">
						<h1 align="center">Exmo. Sr. Ministro Presidente do Conselho da Justi�a Federal</h1>
					</c:when>
					<c:when test="${para eq 'diretoraRH'}">
						<h1 align="center">Ilma. Sra. Secret�ria de Recursos Humanos</h1>
					</c:when>
					<c:when test="${para eq 'diretoraGeral'}">
						<h1 align="center">Ilma. Sra. Secret�ria Geral</h1>
					</c:when>
					<c:when test="${para eq 'diretor'}">
						<h1 align="center">Ilmo(a). Sr(a). Secret�rio(a)</h1>
					</c:when>
					<c:when test="${para eq 'sinap'}">
						<h1 align="center">Ilma. Sra. Secret�ria de Recursos Humanos</h1>
					</c:when>
					<c:when test="${para eq 'presidenteTRF'}">
						<h3 align="center">Exmo. Sr. Ministro Presidente do Conselho da Justi�a Federal</H3>
					</c:when>
					<c:when test="${not empty doc.lotaDestinatario}">
						<h1>SENHOR(A) SUPERVISOR(A) DA ${doc.lotaDestinatario.nomeMaiusculas}</h1>
					</c:when>
					<%--<c:otherwise>
						<h1 align="center">Ilmo(a). Sr(a). Diretor(a) da
						${doc.lotaDestinatario.descricao}</h1>
					</c:otherwise>--%>
				</c:choose>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${not empty texto_destinatario}">
						<h1 align="center">${texto_destinatario}</h1>
					</c:when>
					<c:when test="${para eq 'sepag'}">
						<h1>SENHOR(A) SUPERVISOR(A) DA SE��O DE FOLHA DE PAGAMENTO</h1>
					</c:when>
					<c:when
						test="${para eq 'diretorForo' || (not empty doc.lotaDestinatario and f:lotacaoPorNivelMaximo(doc.lotaDestinatario,4).sigla == 'DIRFO')}">
						<h1 align="center">Exmo. Sr. Juiz Federal - Diretor do Foro</h1>
					</c:when>
					<c:when test="${para eq 'diretoraRH'}">
						<h1 align="center">Ilma. Sra. Diretora da Subsecretaria de
						Gest�o de Pessoas</h1>
					</c:when>
					<c:when test="${para eq 'diretoraGeral'}">
						<h1 align="center">Ilma. Sra. Diretora da Secretaria Geral</h1>
					</c:when>
					<c:when test="${para eq 'diretor'}">
						<h1 align="center">Ilmo(a). Sr(a). Diretor(a) de Secretaria/Subsecretaria</h1>
					</c:when>
					<c:when test="${para eq 'sinap'}">
						<h1 align="center">Ilma. Sra. Supervisora da Se��o de Inativos e Pensionistas</h1>
					</c:when>
					<c:when test="${para eq 'presidenteTRF'}">
						<h3 align="center">EXCELENT�SSIMO SENHOR PRESIDENTE DO TRIBUNAL REGIONAL FEDERAL DA 2� REGI�O</H3>
					</c:when>
					<c:when test="${not empty doc.lotaDestinatario}">
						<h1>SENHOR(A) SUPERVISOR(A) DA ${doc.lotaDestinatario.nomeMaiusculas}</h1>
					</c:when>
					<%--<c:otherwise>
						<h1 align="center">Ilmo(a). Sr(a). Diretor(a) da
						${doc.lotaDestinatario.descricao}</h1>
					</c:otherwise>--%>
				</c:choose>
			</c:otherwise>
		</c:choose>


	<c:import url="/paginas/expediente/modelos/inc_tit_espacos.jsp" />