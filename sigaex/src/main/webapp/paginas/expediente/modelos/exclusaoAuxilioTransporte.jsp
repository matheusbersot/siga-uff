<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<mod:modelo>
	<mod:entrevista>
			<mod:data titulo="Data de Exerc�cio" var="dataExercicio" />		
		    <mod:data titulo="Data da Vig�ncia da Exclus�o" var="dataVigenciaExclusao"/>
		    <mod:texto titulo="Ramal" var="ramal" maxcaracteres="5" largura="5" />
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
		
		<h1 algin="center">Ilmo(a). Sr(a). Supervisor(a) da Se��o de Benef�cios</h1>
		
			 <p style="TEXT-INDENT: 2cm" align="justify">
			 <br><br>
			 	<table width="100%" border="1" cellpadding="3">
					<tr>
						<td bgcolor="#FFFFFF" width="100%" align="center"><b>DADOS DO BENEFICI�RIO</b></td>
					</tr>
				</table>
			   	<table width="100%" border="1" cellpadding="3">
					<tr>
						<td bgcolor="#FFFFFF" width="50%">Nome: <b>${doc.subscritor.descricao}</b></td>
						<td bgcolor="#FFFFFF" width="30%">Matr�cula: <b>${doc.subscritor.sigla}</b></td>
					</tr>
				</table>
				<table width="100%" border="1" cellpadding="3">
					<tr>
						<td bgcolor="#FFFFFF" width="30%">Data de Exerc�cio: <b>${dataExercicio}</b></td>
						<td bgcolor="#FFFFFF" width="60%">Lota��o: <b>${doc.subscritor.lotacao.descricao}</b></td>
						<td bgcolor="#FFFFFF" width="10%">Ramal: <b>${ramal}</b></td>
					</tr>
				</table>
				<table width="100%" border="1" cellpadding="3">
					<tr>
						<td bgcolor="#FFFFFF" width="50%">Cargo: <b>${doc.subscritor.cargo.nomeCargo}</b></td>
						<td bgcolor="#FFFFFF" width="50%">Classe/Padr�o: <b>${doc.subscritor.padraoReferenciaInvertido}</b></td>
					</tr>
				</table>
							 
			 <p style="TEXT-INDENT: 2cm" align="justify">
				 REQUEIRO A MINHA EXCLUS�O DO BENEF�CIO A PARTIR DE <b>${dataVigenciaExclusao}</b>.
			 </p>	
			 <p style="TEXT-INDENT: 2cm" align="justify">
				 Declaro ter conhecimento de que o benef�cio de Aux�lio-Transporte � pago antecipadamente, estando portanto
				 <b>ciente de que deverei devolver qualquer valor que porventura j� tenha recebido referente a per�odo porterior
				 � vig�ncia da exclus�o.
			 </p>
			 <br>
			 
			<c:import url="/paginas/expediente/modelos/inc_deferimento.jsp" />

			<c:import url="/paginas/expediente/modelos/inc_localDataAssinatura.jsp" />
			
			<c:import url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
			
			<br><br><br>
			 
			 <table width="100%" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<td width="60"valign="top">PARA USO DA SE��O DE BENEF�CIOS<br>Recebido por:_______ em: __/__/__<br>Cadastrado por:______ em:__/__/__<br>Obs: _____________________________________________________<br>_________________________________________________________<br><br></td>
				</tr>
			</table>
		
			</body>
		</html>
	</mod:documento>
</mod:modelo>
