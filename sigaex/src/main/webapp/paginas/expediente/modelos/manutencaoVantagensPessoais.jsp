<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de
MANUTEN��O VANTAGENS PESSOAIS  -->

<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="DETALHES DO FUNCION�RIO">
				<mod:texto titulo="Classe" var="classe"/>
				<mod:texto titulo="Padr�o" var="padrao" />
		</mod:grupo>
		
		<mod:grupo titulo="DETALHES DA MANUTEN��O DAS VANTAGENS PESSOAIS">
		
		    <mod:texto largura="60" titulo="Cargo" var="cargoServ"/>
		    
			<mod:grupo titulo="REALIZAR A MANUTEN��O EM:"></mod:grupo>
				<mod:caixaverif titulo="Adicional por tempo de servi�o?" var="adicionalTempoServi�o" reler="N�o"/>
			<mod:grupo></mod:grupo>		
				<mod:caixaverif titulo="Dependentes(dedu��o do IRPF)na fonte?" var="manutencaoDependentes" reler="N�o"/>
			<mod:grupo></mod:grupo>							
				<mod:caixaverif titulo="D�cimos/Quintos incorporados?" var="decimosQuintos" reler="N�o" />
			<mod:grupo></mod:grupo>							
			<mod:memo colunas="50" linhas="3" titulo="Outra a relatar" var="outros"/>
				
		</mod:grupo>
			
	</mod:entrevista>
	
	<mod:documento>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head></head>
	<body>
				
		<c:import url="/paginas/expediente/modelos/inc_tit_SraDiretoraSubsecretariaRH.jsp" />
		
		<p style="TEXT-INDENT: 2cm" align="justify">
	${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo}, 
		classe ${requestScope.classe} e padr�o ${requestScope.padrao}, 
		lotado(a) no(a)${subscritor.lotacao.descricao}, 
		vem respeitosamente requerer a Vossa Excel�ncia, em raz�o de mudan�a nesta 
		Se��o Judici�ria, a manuten��o das seguintes vantagens pessoais vinculadas 
		ao cargo de ${cargoServ}, e matr�cula ${doc.subscritor.sigla}.
		</p>
		
		
		<B>
			<c:if test="${adicionalTempoServi�o== 'Sim'}">
			    Adiconal por Tempo de Servi�o;
			    <br>	
			</c:if>
			
			<c:if test="${manutencaoDependentes== 'Sim'}">
			    Manuten��o de dependentes para fins de dedu��o no Imposto de Renda na fonte;
			    <br>		
			</c:if>
			
			<c:if test="${decimosQuintos== 'Sim'}">
			    D�cimos/Quintos incorporados; 
			    <br>
			</c:if>	
		</B>

		
		<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />
					
		<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
		
	</body>
	</html>
</mod:documento>
</mod:modelo>
