<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="siga"%>


<mod:modelo>

	<mod:entrevista>
		</br>
		<mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Tipo de Intima��o" var="tipoDeIntimacao" 
					opcoes="No ambiente de trabalho;Afastado do servi�o" reler='sim'/>
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Processo Administrativo N�" var="numProcesso" largura="20" />
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Matr�cula do Servidor/Juiz Federal" var="matricula" reler="sim"
					buscarFechadas="true" />
			</mod:grupo>
			<mod:grupo>
				<c:if test="${tipoDeIntimacao == 'Afastado do servi�o'}">
					<mod:texto titulo="Endere�o Residencial" var="endereco" largura="50" />
				</c:if>
			</mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Endere�o da SGP" var="enderecoSGP" 
					opcoes="AV. Rio Branco, 243, anexo I, 9� andar;Av. Rio Branco, 243, anexo I, 10� andar;Av. Venezuela 134, bl. A - 5� andar"/>
			</mod:grupo>
			</br>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>

		
		<table width="100%" border="0"  bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
				<br/><br/>
					<table width="100%" border="0" >
						<tr>
							<td align="left"><p style="font-family:Arial;font-size:11pt;font-weight:bold;" >SUBSECRETARIA DE GEST�O DE PESSOAS (SGP)</p></td>
						</tr>
						<tr>
							<td align="left"><p style="font-family:Arial;font-size:11pt;font-weight:bold;" >${enderecoSGP}</p></td>
						</tr>
						<tr>
							<td align="center">
								<br/>
								<br/>
								<p style="font-family:Arial;font-size:11pt;font-weight:bold;" >INTIMA��O DA INSTRU��O</p>
							</td>
						</tr>
				<tr><td></td>
				</tr>
				<tr><td></td>
				</tr>
				<tr><td></td>
				</tr>
					</table>
				</td>
			</tr>
		</table>
	
		<br />
		
			PROCESSO ADMINISTRATIVO N�: ${numProcesso}
			<br/>
			<b>INTIMA��O DE</b> ${f:pessoa(requestScope['matricula_pessoaSel.id']).nomePessoa}
			<c:if test="${tipoDeIntimacao == 'Afastado do servi�o'}">
				<br/>
				<b>ENDERE�O RESIDENCIAL:</b> ${endereco}
			</c:if>
		
		<p style="TEXT-INDENT: 2cm" align="justify">
			Tendo em vista o disposto no art. 4� da Resolu��o n� 68 de 27/07/2009 do Conselho da Justi�a 
			Federal (CJF), INTIMO V.Sa. para, querendo, encaminhar a esta Unidade, no prazo m�ximo de 10 
			(dez) dias, a contar do recebimento desta, DEFESA nos autos do Processo Administrativo em ep�grafe, 
			que versa sobre a devolu��o de valores indevidamente pagos.
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
			Esta Intima��o assinada dever� ser devolvida, com urg�ncia, a esta Unidade, que, ap�s o prazo acima 
			previsto, prosseguir� com a tramita��o do processo, independentemente de sua manifesta��o.
		</p>
		<br />
		<br />
		<p style="TEXT-INDENT: 2cm" align="justify">
			Rio de Janeiro, ${doc.dtExtensoSemLocalidade}
		</p>
		<br />
		<c:import
			url="/paginas/expediente/modelos/inc_assinatura.jsp?formatarOrgao=sim" />
		<br/>
		<p style="font-family: Arial; font-size: 11pt; font-weight: bold;"
		align="center">
			${f:pessoa(requestScope['matricula_pessoaSel.id']).nomePessoa} - ${f:pessoa(requestScope['matricula_pessoaSel.id']).matricula}
		</p>
		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->
	</mod:documento>
</mod:modelo>

