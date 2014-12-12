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
			</br>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>

		<!-- INICIO PRIMEIRO CABECALHO
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
							<td align="left"><p style="font-family:Arial;font-size:11pt;font-weight:bold;" >Av.Rio Branco 243 - Anexo I - 9� andar - Cep: 22240-009</p></td>
						</tr>
						<tr>
							<td align="center">
								<br/>
								<br/>
								<p style="font-family:Arial;font-size:11pt;font-weight:bold;" >INTIMA��O DA DECIS�O</p>
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
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->
		<br />
		
			PROCESSO ADMINISTRATIVO N�: ${numProcesso}
			<br/>
			<b>INTIMA��O DE</b> ${f:pessoa(requestScope['matricula_pessoaSel.id']).nomePessoa}
			<c:if test="${tipoDeIntimacao == 'Afastado do servi�o'}">
				<br/>
				<b>ENDERE�O RESIDENCIAL:</b> ${endereco}
			</c:if>
		
		<p style="TEXT-INDENT: 2cm" align="justify">
			Tendo em vista o disposto nos arts. 6�, par�grafo �nico, e 7� da Resolu��o n� 68 de 27/07/2009 do 
			Conselho de Justi�a Federal (CJF), INTIMO V.Exa. para, querendo, interpor RECURSO, nos autos do 
			Processo Administrativo em ep�grafe, que versa sobre a devolu��o de valores indevidamente pagos, 
			no prazo m�ximo de 15 (quinze) dias, a contar do recebimento desta.
		</p>
		<p style="TEXT-INDENT: 2cm" align="justify">
			Esta Intima��o assinada dever� ser devolvida, com urg�ncia, a esta Unidade, que, ap�s o prazo 
			acima previsto, prosseguir� com a tramita��o do processo, independentemente de sua manifesta��o.
		</p>
		<br />
		<br />
		<p style="TEXT-INDENT: 2cm" align="justify">
			EXPEDIDO no Munic�pio do Rio de Janeiro, em	${doc.dtExtensoSemLocalidade}, pela Subsecretaria de Gest�o de Pessoas.
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

