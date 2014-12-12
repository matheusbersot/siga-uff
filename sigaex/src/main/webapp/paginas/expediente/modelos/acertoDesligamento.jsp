<%@ taglib uri="http://localhost/modelostag" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
		<mod:grupo>
			
			<mod:grupo>
				<mod:pessoa var="servidor" titulo="Servidor"/>
			</mod:grupo>
			<mod:grupo>
				<mod:texto var="numProcesso" titulo="Numero do Processo"/>
				
			</mod:grupo>
			<mod:grupo>
				<mod:texto var="numAto" titulo="Numero ATO TRF"/>		 
				<mod:data var="dataAto" titulo=" Data do Ato"/>	
				<mod:data var="dataPublicacao" titulo=" Data da publica��o"/>		
			</mod:grupo>			
		</mod:grupo>
		<mod:grupo titulo="Desligamento">
			<mod:data var="dataDesligamento" titulo="Data"/>
		
		
			<mod:texto var="tipoDesligamento" titulo="Tipo" largura="50"/>
		</mod:grupo>
		<mod:grupo>	
		<mod:caixaverif var="acertoMes" titulo="Acerto do mes de desligamento" reler="ajax" idAjax="acertoMesAjax"/>
			<mod:grupo depende="acertoMesAjax">
			<c:choose>
				<c:when test="${acertoMes == 'Sim'}">					
					<mod:grupo>
						<mod:selecao var="debitoCreditoDesligamento" titulo="D�bito/Cr�dito" opcoes="D�bito;Cr�dito"/>					
					</mod:grupo>					
						<mod:monetario var="totalDesligamento" formataNum="sim" extensoNum="sim" titulo="Valor do resultado" reler="sim"/>
				</c:when>
				<c:otherwise>
		
				</c:otherwise>
			</c:choose>
			</mod:grupo>
		</mod:grupo>
		
		<mod:grupo>	
		<mod:caixaverif var="natalina" titulo="Gratifica��o natalina" reler="ajax" idAjax="natalinaAjax"/>
		<mod:grupo depende="natalinaAjax">
			<c:choose>
				<c:when test="${natalina == 'Sim'}">
					<mod:grupo>
						<mod:selecao var="debitoCreditoNatalina" titulo="D�bito/Cr�dito" opcoes="D�bito;Cr�dito"/>					
					</mod:grupo>					
					<mod:monetario var="totalNatalina" formataNum="sim" extensoNum="sim" titulo="Valor do resultado"/>
					
				</c:when>
				<c:otherwise>
		
				</c:otherwise>
			</c:choose>
		</mod:grupo>	
		</mod:grupo>			
		<mod:grupo>	
		<mod:caixaverif var="ferias" titulo="Indeniza��o de f�rias" reler="ajax" idAjax="feriasAjax"/>
		<mod:grupo depende="feriasAjax">				
			<c:choose>
				<c:when test="${ferias == 'Sim'}">
					<mod:grupo>
						<mod:selecao var="debitoCreditoFerias" titulo="D�bito/Cr�dito" opcoes="D�bito;Cr�dito"/>					
					</mod:grupo>					
					<mod:monetario var="totalFerias" formataNum="sim" extensoNum="sim" titulo="Valor do resultado"/>
				</c:when>
				<c:otherwise>
		
				</c:otherwise>
			</c:choose>
		</mod:grupo>	
		</mod:grupo>
		<mod:grupo>
		<mod:caixaverif var="beneficios" titulo="Lan�amento de benef�cios" reler="ajax" idAjax="beneficiosAjax"/>
		<mod:grupo depende="beneficiosAjax">				
			<c:choose>
				<c:when test="${beneficios == 'Sim'}">
					<mod:grupo>
						<mod:selecao var="debitoCreditoBeneficios" titulo="D�bito/Cr�dito" opcoes="D�bito;Cr�dito"/>					
					</mod:grupo>
					<mod:monetario var="totalBeneficios" formataNum="sim" extensoNum="sim" titulo="Valor do resultado"/>
				</c:when>
				<c:otherwise>
		
				</c:otherwise>
			</c:choose>
		</mod:grupo>
		</mod:grupo>
		<mod:caixaverif var="outros" titulo="Outros Lan�amentos" reler="ajax" idAjax="outrosAjax"/>
			<mod:grupo depende="outrosAjax">
			<c:choose>
				<c:when test="${outros == 'Sim'}">
				<mod:selecao var="qtdOutros" titulo="Quantidade" opcoes="1;2;3;4;5;6;7;8;9;10" reler="ajax" idAjax="qtdOutrosAjax"/>
					<mod:grupo depende="qtdOutrosAjax">
					<c:forEach var="i" begin="1" end="${qtdOutros}">
						<mod:grupo>
							<mod:mensagem titulo="${i})"/>
						</mod:grupo>
						<mod:grupo>	
							<mod:texto var="lancamento${i}" titulo="Lan�amento"/>
						</mod:grupo>
						<mod:grupo>
							<mod:selecao var="debitoCreditoLancamento${i}" titulo="D�bito/Cr�dito" opcoes="D�bito;Cr�dito"/>					
						</mod:grupo>
						<mod:grupo>
							<mod:monetario var="valorLancamento${i}" formataNum="sim" extensoNum="sim" titulo="Valor do resultado"/>
						</mod:grupo>
					</c:forEach>
					</mod:grupo>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>			
			</mod:grupo>
				
	</mod:entrevista>
	<mod:documento>
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
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
		<body>
		<p align="center"><b>Numero do processo administrativo:</b> ${numProcesso} <br/><b>Numero ATO TRF:</b> ${numAto} <b>de</b> ${dataAto}, publicada em ${dataPublicacao}</p>
		<br>
		<br>
		<p align="center"><b>Se��o de folha de pagamento</b><br/>D�bito cr�dito</p>
		<c:set var="total" value="${0}"/>
			
			<c:choose>
				<c:when test="${debitoCreditoDesligamento == 'D�bito'}">
					<c:set var="total" value="${total - f:monetarioParaFloat(totalDesligamento)}"/>
				</c:when>
				<c:otherwise>
					<c:set var="total" value="${total + f:monetarioParaFloat(totalDesligamento)}"/>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${debitoCreditoNatalina == 'D�bito'}">
					<c:set var="total" value="${total - f:monetarioParaFloat(totalNatalina)}"/>
				</c:when>
				<c:otherwise>
					<c:set var="total" value="${total + f:monetarioParaFloat(totalNatalina)}"/>
				</c:otherwise>
			</c:choose>		 
			
			<c:choose>
				<c:when test="${debitoCreditoFerias == 'D�bito'}">
					<c:set var="total" value="${total - f:monetarioParaFloat(totalFerias)}"/>
				</c:when>
				<c:otherwise>
					<c:set var="total" value="${total + f:monetarioParaFloat(totalFerias)}"/>
				</c:otherwise>
			</c:choose>		 
			
			<c:choose>
				<c:when test="${debitoCreditoBeneficios == 'D�bito'}">
					<c:set var="total" value="${total - f:monetarioParaFloat(totalBeneficios)}"/>
				</c:when>
				<c:otherwise>
					<c:set var="total" value="${total + f:monetarioParaFloat(totalBeneficios)}"/>
				</c:otherwise>
			</c:choose>		 
			
			<c:forEach var="i" begin="1" end="${qtdOutros}">
				<c:set var="debitoCreditoLancamento" value="${requestScope[f:concat('debitoCreditoLancamento',i)]}"/>
				<c:set var="valorLancamento" value="${requestScope[f:concat('valorLancamento',i)]}"/>
				<c:choose>
				<c:when test="${debitoCreditoLancamento == 'D�bito'}">
					<c:set var="total" value="${total - f:monetarioParaFloat(valorLancamento)}"/>
				</c:when>
				<c:otherwise>
					<c:set var="total" value="${total + f:monetarioParaFloat(valorLancamento)}"/>
				</c:otherwise>
			</c:choose>		
			</c:forEach>
			
		
		<table width="100%" border="0">	
		<c:if test="${not empty requestScope['servidor_pessoaSel.descricao']}">
			<tr>
				<td width="30%">
					Servidor 			
				</td>
				<td width="70%" colspan="2">
					${requestScope['servidor_pessoaSel.descricao']},<br/>
					Matricula: ${requestScope['servidor_pessoaSel.sigla']}
				</td>
			</tr>
		</c:if>	
		
		<c:if test="${not empty dataDesligamento}">
			<tr>
				<td>
					${tipoDesligamento}
				</td>
				<td colspan="2">
					${dataDesligamento}
				</td>
			</tr>
		</c:if>
		</table>
		<br>
		<br>
		<table width="100%">
			<td>
				<b>Lancamentos</b>
			</td>
			<td>
				<b>Cr�dito</b>
			<td>
				<b>D�bito</b>
			</td>
		</table>
		<table width="100%">
		<c:if test="${not empty totalDesligamento or not empty tipoDesligamento}">
			<tr>
				<td>
					Acerto do m�s
				</td>
				<td>
					<c:if test="${debitoCreditoDesligamento=='Cr�dito'}">
						R$ ${totalDesligamento}
					</c:if>  
				</td>
				<td>
					<c:if test="${debitoCreditoDesligamento=='D�bito'}">
						R$ ${totalDesligamento}
					</c:if>
				</td>
			</tr>
		</c:if>
		
		
		<c:if test="${not empty totalNatalina}">
			<tr>
				<td>
					Acerto de gratifica��o natalina
				</td>
				<td>
					<c:if test="${debitoCreditoNatalina=='Cr�dito'}">
						R$ ${totalNatalina}
					</c:if>     
				</td>
				<td>
					<c:if test="${debitoCreditoNatalina=='D�bito'}">
						R$ ${totalNatalina}
					</c:if>
				</td>
			</tr>
		</c:if>	
		<c:if test="${not empty totalFerias}">
			<tr>
				<td>
					Indeniza��o de f�rias
				</td>
				<td>
					<c:if test="${debitoCreditoFerias=='Cr�dito'}">
						R$ ${totalFerias}
					</c:if>   
				</td>
				<td>
					<c:if test="${debitoCreditoFerias=='D�bito'}">
						R$ ${totalFerias}
					</c:if>
				</td>
			</tr>
		</c:if>
			
		<c:if test="${not empty totalBeneficios}">
			<tr>
				<td>
					Lan�amento de benef�cios
				</td>
				<td>
					<c:if test="${debitoCreditoBeneficios=='Cr�dito'}">
						R$ ${totalBeneficios}
					</c:if>   
				</td>
				<td>
					<c:if test="${debitoCreditoBeneficios=='D�bito'}">
						R$ ${totalBeneficios}
					</c:if>
				</td>
			</tr>
		</c:if>	
		<c:forEach var="i" begin="1" end="${qtdOutros}">
			<tr>
				<td>
					${requestScope[f:concat('lancamento',i)]}
				</td>
				<td>
					<c:if test="${requestScope[f:concat('debitoCreditoLancamento',i)]=='Cr�dito'}">
						R$ ${requestScope[f:concat('valorLancamento',i)]}
					</c:if>					
				</td>
				<td>
					<c:if test="${requestScope[f:concat('debitoCreditoLancamento',i)]=='D�bito'}">
						R$ ${requestScope[f:concat('valorLancamento',i)]}
					</c:if>					
				</td>				
			</tr>	
			</c:forEach>
			
		</table>		
		<br>		
		<p align="center">Resultado Geral  
					<c:choose>
					<c:when test="${total > 0}">
						<b>Cr�dito de</b> <c:set var="tot" value="${f:floatParaMonetario(total)}"/>
						<c:set var="totExtenso" value="${f:reaisPorExtenso(f:floatParaMonetario(total))}"/>	
						${tot} (${totExtenso}).
					</c:when>
					<c:otherwise>
						<b>D�bito de</b> <c:set var="tot" value="${f:floatParaMonetario(total)}"/>
						<c:set var="totExtenso" value="${f:reaisPorExtenso(f:floatParaMonetario(total))}"/>	
						${tot} (${totExtenso}).
					</c:otherwise>
				
					</c:choose></p>
					
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
	</body>
	</html>
	</mod:documento>
</mod:modelo>
