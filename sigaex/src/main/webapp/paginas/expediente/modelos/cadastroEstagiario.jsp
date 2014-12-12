<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>

<mod:modelo>
	<mod:entrevista>
	
		<mod:grupo titulo="DADOS PESSOAIS">
				<mod:texto titulo="Nome" largura="60" var="nomeEstagiario" />
				<mod:selecao titulo="Sexo" var="sexo" opcoes="Masculino;Feminino" />
			<mod:grupo>
				<mod:data titulo="Data de Nascimento" var="dataNascimento" />
				<mod:texto titulo="Naturalidade/UF" largura="40" var="naturalidade" />
			</mod:grupo>
			<mod:grupo>
				<mod:monetario titulo="N� Identidade" largura="13" maxcaracteres="9" var="docIdentidade" verificaNum="sim" />
				<mod:texto titulo="Org�o Expedidor" largura="10" var="orgExpedidor" />
				<mod:data titulo="Data de Emiss�o" var="dataEmissao" />
			</mod:grupo>
			<mod:grupo>
				<mod:monetario titulo="N� CPF" var="docCpf" largura="15" maxcaracteres="11" verificaNum="sim" />
				<mod:selecao titulo="Estado Civil" var="estadoCivil" opcoes="Solteiro(a);Casado(a);Divorciado(a);Vi�va(o);Desquitado" reler="sim"/>
				<mod:texto titulo="Tipo Sang��neo" var="tipoSanguineo" largura="5" />
				<mod:texto titulo="Fator RH" var="fatorRh" largura="5" />
			</mod:grupo>
			<mod:grupo titulo="Filia��o">
					<mod:texto titulo="Pai" var="pai" largura="60" />
				<mod:grupo>
					<mod:texto titulo="M�e" var="mae" largura="60" />
				</mod:grupo>
			</mod:grupo>
			<mod:grupo>
				<c:if test="${estadoCivil == 'Casado(a)'}">
					<mod:texto titulo="C�njuge" var="conjuge" largura="60" />
				</c:if>
			</mod:grupo>
		</mod:grupo>
		
		<mod:grupo titulo="DADOS RESID�NCIAIS">
				<mod:texto titulo="Endere�o" var="endereco" largura="60" />
			<mod:grupo>
				<mod:texto titulo="Telefone" var="tel" largura="15" maxcaracteres="11" />
				<mod:texto titulo="Celular" var="cel" largura="15" maxcaracteres="11" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Bairro" var="bairro" largura="30"/>
				<mod:texto titulo="Cidade" var="cidade" largura="30" />
				<mod:texto titulo="CEP" var="cep" largura="15" maxcaracteres="8" />
			</mod:grupo>
		</mod:grupo>
		
		<mod:grupo titulo="DADOS DO CURSO" >
			<mod:grupo>
				<mod:selecao titulo="Per�odo" var="periodo" opcoes="1;2;3;4;5;6;7;8;9;10" reler="n�o" />
				<mod:texto titulo="Ano" var="ano" largura="5" /> 
				<mod:texto titulo="Matr�cula" var="matricula" largura="20" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Institui��o de Ensino" var="instEnsino" largura="60" />
			</mod:grupo>
			<mod:grupo>
				<mod:selecao titulo="Curso" opcoes="Ci�ncias Cont�beis;Direito;N�vel M�dio" var="curso" />
				<mod:selecao titulo="Turno" opcoes="Manh�;Tarde;Noite" var="turno" />
				<mod:selecao titulo="Disponibilidade para Est�gio" opcoes="Manh�;Tarde" var="dispEstagio" />
			</mod:grupo>
		</mod:grupo>
		
		<mod:grupo titulo="DADOS DO EST�GIO">
		        <mod:lotacao titulo="Unidade de Lota��o" var="unidade" obrigatorio="Sim" /> <br>				
				<mod:texto titulo="Telefone1" var="telEstagio" largura="15" maxcaracteres="11" />
				<mod:texto titulo="Telefone2" var="telEstagio2" largura="15" maxcaracteres="11" />
			<mod:grupo>
				<mod:data titulo="Data in�cio do Est�gio" var="dataInicio" />
				<mod:data titulo="Previs�o de T�rmino" var="previsaoTermino" />				
			</mod:grupo>
			<mod:grupo>
				<mod:pessoa titulo="Supervisor" var="supervisor" />
			</mod:grupo>
		</mod:grupo>
		
	</mod:entrevista>

	<mod:documento>
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
		<style type="text/css">
		     @page {
				margin-left: 2cm;
				margin-right: 2cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
		 	 }
		</style>
		</head>
		<body>
		<p align="right">
		SIGLA:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MATR�CULA:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Avisado em_____/_____/____<br>
		</p>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td width="85%"><c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp"/></td>
				<td width="15%" align="center"><b>Fotografia</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
					<tr>
						<td align="center"><b>CADASTRO DE ESTAGI�RIO - �REA JUDICI�RIA -</b></td>
					</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="100%" colspan="2"><b>1. DADOS PESSOAIS</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="70%">Nome: <b>${nomeEstagiario}</b></td>
				<td bgcolor="#FFFFFF" width="30%">Sexo: <b>${sexo}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="30%">Data de Nascimento: <b>${dataNascimento}</b></td>
				<td bgcolor="#FFFFFF" width="70%">Naturalidade/UF: <b>${naturalidade}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="30%">N� Identidade: <b>${docIdentidade}</b></td>
				<td bgcolor="#FFFFFF" width="35%">Org�o Expedidor: <b>${orgExpedidor}</b></td>
				<td bgcolor="#FFFFFF" width="35%">Data Emiss�o: <b>${dataEmissao }</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="30%">N� CPF: <b>${docCpf}</b></td>
				<td bgcolor="#FFFFFF" width="30%">Estado Civil: <b>${estadoCivil}</b></td>
				<td bgcolor="#FFFFFF" width="23%">Tipo Sang��neo: <b>${tipoSanguineo}</b></td>
				<td bgcolor="#FFFFFF" width="17%">Fator RH: <b>${fatorRh}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" >Pai: <b>${pai}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" >M�e: <b>${mae}</b></td>
			</tr>
		</table>
		<c:if test="${estadoCivil == 'Casado(a)'}">
			<table width="100%" border="1" cellpadding="3">
				<tr>
					<td bgcolor="#FFFFFF" >C�njuge: <b>${conjuge}</b></td>
				</tr>
			</table>
		</c:if>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td width="60%">Endere�o: <b>${endereco}</b></td>
				<td width="20%">Telefone: <b>${tel}</b></td>
				<td width="20%">Celular: <b>${cel}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td width="50%">Bairro: <b>${bairro}</b></td>
				<td width="30%">Cidade: <b>${cidade}</b></td>
				<td width="20%">Cep: <b>${cep}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="100%" colspan="3"><b>2. CURSO: ${curso}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
				<tr>
					<td width="30%">Per�odo/Ano: <b>${periodo}&ordm;</b> - <b>${ano}</b></td>
					<td width="30%">Matr�cula: <b>${matricula}</b></td>
				</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td width="40%">Institui��o de Ensino: <b>${instEnsino}</b></td>
				<td width="20%">Turno: <b>${turno}</b></td>
				<td width="40%">Disponibilidade para Est�gio: <b>${dispEstagio }</b>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="100%" colspan="3"><b>3. DADOS DO EST�GIO</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
				<tr>
					<td width="50%">Unidade de Lota��o: <b>${f:lotacao(requestScope['unidade_lotacaoSel.id']).descricao}</b></td>
					<td width="25%">Telefone1: <b>${telEstagio}</b></td>
					<td width="25%">Telefone2: <b>${telEstagio2}</b></td>
				</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td width="50%">Data de In�cio do Est�gio: <b>${dataInicio}</b></td>
				<td width="50%">Previs�o de T�rmino do Est�gio: <b>${previsaoTermino}</b></td>
			</tr>
		</table>
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td width="60%">Supervisor: <b>${requestScope['supervisor_pessoaSel.descricao']}</b></td>
				<c:if test="${not empty requestScope['supervisor_pessoaSel.id']}">
					<c:set var="cargo" value="${f:cargoPessoa(requestScope['supervisor_pessoaSel.id'])}"/>
				</c:if>
				<td width="40%">Cargo/Fun��o: <b>${cargo}</b></td>
			</tr>
		</table>	
		<table width="100%" border="1" cellpadding="3">
			<tr>
				<td bgcolor="#FFFFFF" width="100%"><b>4. DOCUMENTOS NECESS�RIOS</b></td>
			</tr>
				<tr>
						<td>
								<b> - Documento de apresenta��o � Vara Federal/ao Juizado Especial Federal (Of�cio da EMARF ou Encaminhamento da DICRE);</b><br><br>
								<b> - 1 foto 3 X 4.</b>
							
						</td>
				</tr>
		</table>
		<table width="100%" border="1" cellpadding="15">
		<tr>
			<td align="center"> Afirmamos a veracidade das informa��es acima descritas.<br><br><br><br>
			
									______________________________________<br>
									(Assinatura do Estagi�rio)<br><br><br><br><br>
									
			Solicito a EMISS�O do crach� de identifica��o do(a) estagi�ri(a).<br><br><br><br>
			
			<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
			
			</td>
		</tr>
		</table>
		<font size="2">SIRH [&nbsp;] SHF [&nbsp;] Atualiza LOT [&nbsp;] CRAC [&nbsp;] CAD em_____/_____/____ </font>
		</body>	
		</html>
		<c:import
			url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
	</mod:documento>
</mod:modelo>
