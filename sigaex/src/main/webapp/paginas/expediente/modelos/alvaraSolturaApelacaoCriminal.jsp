<%@ page language="java" contentType="text/html; charset=ISO-8859-1" buffer = "64kb"%> 
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<mod:modelo>
	<mod:entrevista>
		<c:if test="${empty esconderDest}">
			<mod:grupo>

				<mod:grupo>
						<mod:texto titulo="Vocativo" var="vocativo" largura="45" />
				</mod:grupo>
		
				<mod:grupo>
						<mod:texto titulo="Cargo" var="nomeCargo" largura="45" />
				</mod:grupo>
				<mod:grupo>
						<mod:texto titulo="�rg�o" var="nomeOrgao" largura="45" />
				</mod:grupo>				
					
	<mod:grupo>
			<mod:grupo titulo="DETALHES DO ALVAR&Aacute;
			 DE SOLTURA">
			 
			<mod:grupo>
				<mod:texto titulo="Apela&ccedil;&atilde;o Criminal" var="apelacao_criminal"/>
				
			</mod:grupo>			
			<mod:grupo>
			

			<mod:selecao var="quantidadeProcessos"
				titulo="Quantidade de processos"
				opcoes="1;2"
				reler="sim" idAjax="quantDependAjax" />
		<mod:grupo depende="quantDependAjax">
			<c:forEach var="i" begin="1" end="${quantidadeProcessos}">
				<mod:grupo>
					<mod:texto titulo="Processo Origem ${i}" var="numProcesso${i}"/>	
				</mod:grupo>	
				<mod:grupo>
					<mod:texto titulo="Nome do �rg�o"  var="orig_processo${i}" largura="40"/>
				</mod:grupo>

			</c:forEach>
		</mod:grupo>


			<!--	<mod:processo titulo="Processo Origem 1"  id="numProcesso${1}" var="numProcesso"/>
			</mod:grupo>
			<mod:grupo>

				<mod:texto titulo="Nome do �rg�o"  var="orig_processo" largura="40"/>
			</mod:grupo>
			<mod:grupo>

				<mod:processo titulo="Processo Origem 2"  id="numProcesso2${2}" var="numProcesso2"/>
			</mod:grupo>
			<mod:grupo>

				<mod:texto titulo="Nome do �rg�o"  var="orig_processo2" largura="40"/>
			</mod:grupo>						
			<mod:grupo> -->
				<mod:texto titulo="Apelante" var="apelante" largura="40"/>				
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Apelado" var="apelado" largura="50"/>
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Benefici�rio" var="nm_beneficiario" largura="40"/>
			</mod:grupo>
						
			<mod:grupo>

				<mod:memo titulo="Texto Complementar" var="texto" colunas="60" linhas="10"/>
			</mod:grupo>

				<c:set var="texto_final"
						value="Determino que o presente alvar� de soltura seja cumprido pelo Sr. Oficial de Justi�a, na forma e sob as penas da lei, na sede da Superintend�ncia da Pol�cia Federal no Estado do Rio de Janeiro" />
	
					<c:if test="${not empty texto_final}">
						<mod:grupo>
							<mod:mensagem titulo="Texto de Conclus�o"
								texto="${texto_final}" />
						</mod:grupo>
					</c:if>				
			<c:if test="${not empty texto_final}">
					<mod:grupo>
						<mod:caixaverif titulo="Alterar Texto de Conclus�o"
							var="alterarTexto" reler="sim" />
					</mod:grupo>
				</c:if>
	
				<c:choose>
					<c:when test="${alterarTexto == 'Sim' or empty texto_final}">
						<mod:grupo>
							<mod:memo titulo="Texto de Conclus�o" var="texto_f" colunas="60" linhas="7" />
						</mod:grupo>
					</c:when>
					<c:otherwise>
						<mod:oculto var="texto_f" valor="${texto_final}" />
					</c:otherwise>
				</c:choose>				
			</mod:grupo>			
		</mod:grupo>

		

			
			<mod:grupo titulo="DETALHES DO DIGITADOR">
				<mod:grupo>
					<mod:pessoa titulo="Digitador" var="digitador"/>
				
				</mod:grupo>		
			
			</mod:grupo>									
			<mod:grupo titulo="DETALHES DO CONFERENTE">
				<mod:grupo>
					<mod:pessoa titulo="Conferente" var="conferente"/>
				
				</mod:grupo>	
				<mod:grupo>
					<mod:texto titulo="Cargo" var="cargo" largura="40" />
				
				</mod:grupo>								
				<mod:grupo>
					<mod:texto titulo="Turma" var="turma" largura="40"/>
				
				</mod:grupo>				
			</mod:grupo>

									
		<br><mod:selecao titulo="Tamanho da letra" var="tamanhoLetra" opcoes="Normal;Pequeno;Grande"/>
		</mod:grupo>
		
		</c:if>
	</mod:entrevista>
	<mod:documento>
		<c:set var="conferente" value ="${f:pessoa(requestScope['conferente_pessoaSel.id'])}" />
		<c:set var="digitador" value ="${f:pessoa(requestScope['digitador_pessoaSel.id'])}" />
		<c:if test="${tamanhoLetra=='Normal'}"><c:set var="tl" value="11pt"/></c:if>
		<c:if test="${tamanhoLetra=='Pequeno'}"><c:set var="tl" value="9pt"/></c:if>
		<c:if test="${tamanhoLetra=='Grande'}"><c:set var="tl" value="13pt"/></c:if>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
			@page {
				margin-left: 3cm;
				margin-right: 3cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
		</style>
		</head>
		<body>
		<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;"><u>ALVAR� DE SOLTURA</u> </p></td>
						</tr>
						<tr>	
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;"><br><u>N&ordm; ${doc.codigo}</u></p></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->
		
		<mod:letra tamanho="${tl}">
		
		<p>&nbsp;</p>
		<!-- INICIO-MIOLO -->

	
		<c:if test="${quantidadeProcessos mod 2 == 0}">
			
		<p align="justify"><!-- INICIO FECHO -->${vocativo} <b>${doc.subscritor.descricao}</b>, ${nomeCargo} ${nomeOrgao}, nos autos da <b><i>APELA��O CRIMINAL</i> N&ordm; ${apelacao_criminal} (Proc. Orig. n&ordm; ${numProcesso1} - ${orig_processo1} e ${numProcesso2} - ${orig_processo2})</b>, em que figuram, como APELANTE <b>${apelante }</b>, e, como APELADO <b>${apelado }</b> <!-- FIM FECHO --><br />
		<br/>
		</p>
		<p align="right"><b><u>MANDA</u></b>
					
				<br><div align="justify" >Ao SUPERINTENDENTE DA POL�CIA FEDERAL, ou quem suas vezes fizer, ao lhe ser este apresentado, indo por mim assinado, que ponha em liberdade, se "por al" n�o estiver preso, <font size="3"><b>${nm_beneficiario }</b></font>, ${texto}, nos autos da <i>APELA��O CRIMINAL</i> N&ordm; <b>${apela��o_criminal} (Proc. Orig. n&ordm; ${numProcesso1} - ${orig_processo1} e ${numProcesso2} - ${orig_processo2} ), <u>ficando ressalvado que esta decis�o de soltura do preso � somente referente a este feito.</u></b>
				<br><b><u>${texto_f}.</u></b></br></div></p>
						
		</c:if>

		<c:if test="${quantidadeProcessos mod 2 == 1}">
		<p align="justify"><!-- INICIO FECHO -->${vocativo} <b>${doc.subscritor.descricao}</b>, ${nomeCargo} ${nomeOrgao}, nos autos da <b>APELA��O CRIMINAL N&ordm; ${apelacao_criminal} (Proc. Orig. n&ordm; ${numProcesso1} - ${orig_processo1})</b>, em que figuram, como APELANTE <b>${apelante }</b>, e, como APELADO <b>${apelado }</b> <!-- FIM FECHO --><br />
		<br />
		</p>
		<p align="right"><b><u>MANDA</u></b>
					
				<br><div align="justify" >Ao SUPERINTENDENTE DA POL�CIA FEDERAL, ou quem suas vezes fizer, ao lhe ser este apresentado, indo por mim assinado, que ponha em liberdade, se "por al" n�o estiver preso, <font size="3"><b>${nm_beneficiario }</b></font>, ${texto}, nos autos da <i>APELA��O CRIMINAL</i> N&ordm; <b>${apelacao_criminal} (Proc. Orig. n&ordm; ${numProcesso1} - ${orig_processo1}), <u>ficando ressalvado que esta decis�o de soltura do preso � somente referente a este feito.
				<br><b><u>${texto_f}.</u></b></br></div></p>
						
		</c:if>
		
		<p align="justify"><b>CUMPRA-SE NA FORMA E SOB AS PENAS DA LEI</b>. ${doc.dtExtenso} Eu, ${digitador.nomePessoa} - ${digitador.cargo.nomeCargo}, o digitei. Eu, ${conferente.nomePessoa}, ${cargo} da ${turma}, o conferi.
		<!-- FIM-MIOLO -->
		<!-- INICIO ASSINATURA -->
		<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" /><!-- FIM ASSINATURA -->
		</mod:letra>
		
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->
		
		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoCentralizada.jsp" />
		FIM RODAPE -->
		
		</body>
		</html>
	</mod:documento>
</mod:modelo>

