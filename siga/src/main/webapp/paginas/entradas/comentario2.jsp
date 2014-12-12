<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<p align="left" /><font size='3'><b>Bem-vindo ao SIGA.</b></font></p>
<p><font size='3' align="justify">Veja abaixo as �ltimas
novidades.</font></p>

<table>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/info.jpg" /></td>
			<td style="padding-top: 7; padding-bottom: 7">
			<font size='2' align="justify"> <b>Dedicada aos Subscritores</b><br>
		H� uma nova informa��o na tabela de contagem de expedientes da p�gina
		inicial. A linha "Como Subscritor" d� acesso a todos os documentos que
		necessitam ser assinados por quem est� operando o sistema.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
		<img src="/sigaex/imagens/search.jpg" /></td>
		<td style="padding-top: 7; padding-bottom: 7">
		<font size='2'
			align="justify"> <b>Incrementada a Busca Por Classifica��o</b><br>
		Agora todas as colunas da <a
			href="http://intranet/conteudos/gestao_documental/gestao_documental.asp"
			style="color: blue">Tabela de Temporalidade</a> s�o mostradas na
		busca por classifica��o do SIGA-EX.</font></td>
	</tr>
	
	<tr>
		<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
		<img src="/sigaex/imagens/page_search.jpg" /></td>
		<td style="padding-top: 7; padding-bottom: 7">
		<font size='2'
			align="justify"> <b>Pesquisa de Expedientes por
		Cadastrante</b><br>
		Foi adicionado o campo "Cadastrante" � tela de busca por expedientes.
		Assim, pode-se listar os documentos feitos por uma pessoa ou lota��o.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
		<img src="/sigaex/imagens/applications.jpg" /></td>
		<td style="padding-top: 7; padding-bottom: 7">
		<font size='2'
			align="justify"> <b>Rela��o de Paternidade Entre
		Documentos</b><br>
		Est� dispon�vel a op��o "Criar Documento Filho", �til principalmente
		para facilitar a gera��o de resposta a um expediente. Quando assinado,
		um documento filho � automaticamente juntado ao pai. � possivel
		tamb�m, na cria��o de um expediente, definir qual o seu documento pai.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
		<img src="/sigaex/imagens/info.jpg" /></td>
		<td style="padding-top: 7; padding-bottom: 7">
		<font size='2' align="justify"> <b>Novos Links na P�gina Inicial</b><br>
		A �rea lateral esquerda da p�gina principal foi reformulada, e est�o
		dispon�veis links para a tabela de temporalidade, para a apostila do
		SIGA-EX, entre outros.</font></td>
	</tr>

	<c:if test="${param['completo'] eq 'true'}">
		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/application_lock.jpg" /></td>
			<td style="padding-top: 7; padding-bottom: 7"><font size='2'
				align="justify"> <b>Expedientes Mais Protegidos</b><br>
			Os documentos s� se tornam vis�veis �s lota��es n�o atendentes depois
			de assinados.</font></td>
		</tr>
		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/application_edit.jpg" /></td>
			<td style="padding-top: 7; padding-bottom: 7"><font size='2'
				align="justify"> <b>Assinar � Necess�rio</b><br>
			Para transferir um documento, agora � preciso antes assin�-lo, a n�o
			ser que a lota��o � qual se envia expresse, por chamado, aceitar
			documentos n�o assinados.</font></td>
		</tr>
		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/application.jpg" /></td>
			<td style="padding-top: 7; padding-bottom: 7"><font size='2'
				align="justify"> <b>Documentos Digitais</b><br>
			Cerca de um quinto dos documentos criados hoje s�o totalmente
			digitais, e o n�mero tende a aumentar. Leia o <a
				href="roteiro_eletronicos.pdf" style="color: blue">roteiro para
			assinatura digital</a>.</font></td>
		</tr>
		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/page_search.jpg" /></td>
			<td style="padding-top: 7; padding-bottom: 7"><font size='2'
				align="justify"> <b>Pesquisa Textual Mais Completa</b><br>
			Agora a busca textual abrange tamb�m os despachos, os anexos e as
			anota��es.</font></td>
		</tr>

		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/page_search.jpg" /></td>
			<td
				style="padding-top: 7; padding-bottom: 7"><font
				size='2' align="justify"> <b>Pesquisa Textual</b><br>
			Experimente o novo sistema de busca textual de documentos do SIGA-EX:
			no menu principal, clique em "Expedientes" e depois "Pesquisar por
			texto".</font></td>
		</tr>

		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/bulleted_list_002.jpg" height="45" width="45"/></td>
			<td
				style="padding-top: 7; padding-bottom: 7"><font
				size='2' align="justify"> <b>Menus</b><br>
			Agora o SIGA possui um sistema de menus hier�rquicos, permitindo
			assim uma navega��o mais f�cil e �gil.</font></td>
		</tr>


		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/info.jpg" /></td>
			<td
				style="padding-top: 7; padding-bottom: 7"><font
				size='2' align="justify"> <b>Altera��o na Nomeclatura dos
			Tipos de Documentos</b><br>
			Os tipos de documento "Interno" e "Interno Antigo" passam a se chamar
			respectivamente: "Interno Produzido" e "Interno Importado".</font></td>
		</tr>
		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/format-justify-left.jpg" height="45" width="43"/></td>
			<td
				style="padding-top: 7; padding-bottom: 7"><font
				size='2' align="justify"><b>Formul�rios Eletr�nicos</b> <br>
			Os formul�rios de Substitui��o, Designa��o e Dispensa, Remo��o e
			Permuta j� podem ser utilizados eletronicamente.</font></td>
		</tr>
		<tr>
			<td style="padding-top: 7; padding-bottom: 7" width="8%" align="center">
			<img src="/sigaex/imagens/format-justify-left.jpg" height="45" width="43"/></td>
			<td
				style="padding-top: 7; padding-bottom: 7"><font
				size='2' align="justify"><b>Novos Formul�rios</b> <br>
			Foram criados novos formul�rios de: <u>Boletim de Frequ�ncia</u>,
			Parcelamento de D�bito, Termo de Compromisso e Recebimento do Crach�
			de Identifica��o Funcional e Declara��o de Bens.</font></td>
		</tr>

	</c:if>
	</font>
</table>
