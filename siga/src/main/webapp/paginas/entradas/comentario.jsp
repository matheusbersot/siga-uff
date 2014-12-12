<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h2 class="gt-table-head">
	<b>Bem-vindo ao SIGA.</b>
</h2>

<h3 class="gt-table-head">Veja abaixo as �ltimas novidades:</h3>

<h4>Novos M�dulos</h4>
<p>O SIGA agora est� integrado com os m�dulos do Siga SGP. 
Foram integrados: Cadastro, Benef�cios, AQ e Lota��es (fase final de testes). 
Podem ser acessados pelo menu, na seguinte op��o: M�dulos / Pessoas. 
Os m�dulos estar�o dispon�veis de acordo com as permiss�es dos usu�rios logados. Em breve, mais novidades.</p>
	
<h4>Novo Design</h4>
<p>O SIGA apresenta, agora, um design muito mais simples e moderno.
	Al�m das mudan�as est�ticas, tamb�m foram simplificadas algumas p�ginas
	e opera��es, o que beneficia principalmente as pessoas que utilizam
	muito o sistema.</p>

<h4>Modelos Padronizados</h4>
<p>Est� sendo realizada uma padroniza��o dos modelos de expedientes
	usados pelo CJF e pelos TRF's da 2� e 3� Regi�o. Alguns modelos, como o
	de of�cio, j� est�o com um novo layout no Siga-Doc.</p>

<h4>Novo Editor de Textos</h4>
<p>
	Siga-Doc possui um novo editor de textos, com mais recursos e menos
	problemas de formata��o. Inicialmente, ele est� dispon�vel apenas em
	alguns modelos. Gradualmente, o antigo editor ser� substitu�do. <a
		href="AjudaEditorTextosSigaDoc.pdf"><b>Veja instru��es</b> </a> sobre
	o uso do editor.
</p>

<h4>Busca Textual Integrada</h4>
<p>A busca de documentos por conte�do agora pode ser feita na
	pr�pria tela de pesquisa por filtros, por meio do campo Conte�do.</p>

<c:if test="${param['completo'] eq 'true'}">

	<h4>Assinador da Certisign</h4>
	<p>
		Agora a assinatura digital pode ser feita por meio de um recurso
		desenvolvido pela Certisign. Basta clicar em <b>Assinar com
			assinador da Certisign</b>, na tela de assinatura. A tecnologia
		facilitar�, principalmente, o uso do Siga-Doc com certificado digital
		em outros �rg�os.
	</p>


	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Quadro de Solicita��es</b><br> Assim
				como o m�dulo Documentos, o novo m�dulo Servi�os tamb�m exibe um
				resumo na p�gina inicial, dentro do <i>Quadro de Solicita��es</i>.</font>
		</td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>PCTT - nova vers�o</b><br> Est�
				dispon�vel para uso no sistema a nova tabela de classifica��o. O
				formato do c�digo da classifica��o mudou para NN.NN.NN.NN. A maioria
				das classifica��es possui apenas uma via.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Mudan�a na exibi��o do status</b><br>
				Na tela de visualiza��o de documentos, o estado em que uma via se
				encontra agora � exibido mais acima, ao lado do n�mero da via. <a
				style="font-weight: bold" href="exibeEstado.htm" target="new">Veja
					a diferen�a na imagem</a>.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Consulta a documentos</b><br> Agora �
				poss�vel consultar documentos atrav�s do estado, incluindo <i>Transferido</i>
				e <i>Como Subscritor</i>. Basta selecionar a situa��o desejada na
				lista e, ao lado, a pessoa ou lota��o a quem o estado se refere. <a
				style="font-weight: bold" href="novaListaJsp.JPG" target="new">Veja
					a imagem</a>.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Notifica��o de documentos a receber</b><br>
				� poss�vel, por meio de chamado, especificar para quais endere�os de
				e-mail o sistema dever� enviar notifica��o de transfer�ncia de
				documento eletr�nico para uma determinada lota��o.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Documentos Eletr�nicos</b><br> Agora
				todos os expedientes podem ser gerados e movimentados de forma
				totalmente digital, n�o necessitando ser impressos. Para gerar um
				documento eletr�nico, marque a op��o 'Digital', na parte superior da
				tela de edi��o do expediente.</font></td>
	</tr>


	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Pesquisa por Documentos Sigilosos</b><br>
				A busca textual abrange os documentos com n�vel de acesso restrito.
				Para inclu�-los na pesquisa, marque a op��o localizada abaixo do
				campo de busca.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Visualizar Dossi�</b><br> O recurso
				Visualizar Dossi� permite navegar mais facilmente pelos despachos,
				documentos filhos e anexos de um expediente, bem como visualizar ou
				imprimir seus conte�dos como um �nico documento.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Mudan�as na nomenclatura</b><br>
				Seguem os nomes antigos e seus equivalentes ap�s a altera��o na
				nomenclatura:
				<ul>
					<li>Em andamento: Aguardando Andamento</li>
					<li>Em Tr�nsito: Transferido</li>
					<li>Arquivado Corrente: Arquivo Corrente</li>
					<li>Cancelar Movimenta��o: Desfazer + <i>Nome da A��o</i></li>
				</ul> </font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Caixa "Ir para o documento"</b><br> O
				campo de busca por c�digo de expediente agora est� dispon�vel tamb�m
				nas p�ginas de listagem e de exibi��o de documentos.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Despacho Longo Diferente</b><br> Ao
				fazer um despacho longo, o usu�rio v� a tela para edi��o do despacho
				como documento filho, um expediente � parte. Quando este �
				finalizado e assinado, ocorre uma juntada autom�tica ao pai.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Substitui��o Mais F�cil</b><br> Para
				mudar de perfil, basta passar o mouse sobre o seu nome, no rodap�, e
				selecionar a pessoa ou lota��o desejada.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Salvamento Autom�tico</b><br> Os
				documentos s�o agora salvos automaticamente, a cada dois minutos.
				Foi inclu�do tamb�m o bot�o 'Salvar' na barra de ferramentas do
				editor de textos.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Consulta Por Intervalo de Datas</b><br>
				A busca por documentos pode agora ser feita n�o s� por uma data
				fixa, mas tambem por intervalo de datas.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Arquivamento em Lote</b><br> Est�
				dispon�vel o recurso que permite fazer o arquivamento corrente
				simult�neo de v�rios expedientes.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Dedicada aos Subscritores</b><br> H�
				uma nova informa��o na tabela de contagem de expedientes da p�gina
				inicial. A linha "Como Subscritor" d� acesso a todos os documentos
				que necessitam ser assinados por quem est� operando o sistema.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Incrementada a Busca Por Classifica��o</b><br>
				Agora todas as colunas da <a
				href="http://intranet/conteudos/gestao_documental/gestao_documental.asp"
				style="color: blue">Tabela de Temporalidade</a> s�o mostradas na
				busca por classifica��o do SIGA-EX.</font></td>
	</tr>

	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Pesquisa de Expedientes por
					Cadastrante</b><br> Foi adicionado o campo "Cadastrante" � tela de
				busca por expedientes. Assim, pode-se listar os documentos feitos
				por uma pessoa ou lota��o.</font></td>
	</tr>



	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Rela��o de Paternidade Entre
					Documentos</b><br> Est� dispon�vel a op��o "Criar Documento
				Filho", �til principalmente para facilitar a gera��o de resposta a
				um expediente. Quando assinado, um documento filho � automaticamente
				juntado ao pai. � possivel tamb�m, na cria��o de um expediente,
				definir qual o seu documento pai.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Novos Links na P�gina Inicial</b><br>
				A �rea lateral esquerda da p�gina principal foi reformulada, e est�o
				dispon�veis links para a tabela de temporalidade, para a apostila do
				SIGA-EX, entre outros.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Expedientes Mais Protegidos</b><br>
				Os documentos s� se tornam vis�veis �s lota��es n�o atendentes
				depois de assinados.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Assinar � Necess�rio</b><br> Para
				transferir um documento, agora � preciso antes assin�-lo, a n�o ser
				que a lota��o � qual se envia expresse, por chamado, aceitar
				documentos n�o assinados.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Documentos Digitais</b><br> Cerca de
				um quinto dos documentos criados hoje s�o totalmente digitais, e o
				n�mero tende a aumentar. Leia o <a href="roteiro_eletronicos.pdf"
				style="color: blue">roteiro para assinatura digital</a>.</font></td>
	</tr>
	<tr>
		<td style="padding-top: 7; padding-bottom: 7"><font size='2'
			align="justify"> <b>Pesquisa Textual Mais Completa</b><br>
				Agora a busca textual abrange tamb�m os despachos, os anexos e as
				anota��es.</font></td>
	</tr>

	<tr>
		<td
			style="border-top: 1px dotted #CCCCCC; padding-top: 7; padding-bottom: 7"><font
			size='2' align="justify"> <b>Pesquisa Textual</b><br>
				Experimente o novo sistema de busca textual de documentos do
				SIGA-EX: no menu principal, clique em "Expedientes" e depois
				"Pesquisar por texto".</font></td>
	</tr>

	<tr>
		<td
			style="border-top: 1px dotted #CCCCCC; padding-top: 7; padding-bottom: 7"><font
			size='2' align="justify"> <b>Menus</b><br> Agora o SIGA
				possui um sistema de menus hier�rquicos, permitindo assim uma
				navega��o mais f�cil e �gil.</font></td>
	</tr>


	<tr>
		<td
			style="border-top: 1px dotted #CCCCCC; padding-top: 7; padding-bottom: 7"><font
			size='2' align="justify"> <b>Altera��o na Nomeclatura dos
					Tipos de Documentos</b><br> Os tipos de documento "Interno" e
				"Interno Antigo" passam a se chamar respectivamente: "Interno
				Produzido" e "Interno Importado".</font></td>
	</tr>
	<tr>
		<td
			style="border-top: 1px dotted #CCCCCC; padding-top: 7; padding-bottom: 7"><font
			size='2' align="justify"><b>Formul�rios Eletr�nicos</b> <br>
				Os formul�rios de Substitui��o, Designa��o e Dispensa, Remo��o e
				Permuta j� podem ser utilizados eletronicamente.</font></td>
	</tr>
	<tr>
		<td
			style="border-top: 1px dotted #CCCCCC; padding-top: 7; padding-bottom: 7"><font
			size='2' align="justify"><b>Novos Formul�rios</b> <br>
				Foram criados novos formul�rios de: <u>Boletim de Frequ�ncia</u>,
				Parcelamento de D�bito, Termo de Compromisso e Recebimento do Crach�
				de Identifica��o Funcional e Declara��o de Bens.</font></td>
	</tr>

</c:if>
</font>
</table>
