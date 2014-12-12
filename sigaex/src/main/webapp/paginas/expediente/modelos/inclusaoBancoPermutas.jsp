<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<c:set var="textoPrimeiroRodape" scope="request">
<span style="text-align: justify;">A desist�ncia da inclus�o no Banco de Permutas dever� ser comunicada � Subsecretaria de Gest�o de Pessoas por meio de requerimento.</span>
</c:set>--%>
<script language="javascript">
var newwin = null;
</script>
<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretoraRH" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>
		<mod:grupo titulo="DETALHES DO SERVIDOR">
			<mod:grupo><mod:texto titulo="Forma��o (informar o grau de escolaridade e o curso, conforme registrado nos assentamentos funcionais)" var="formacao" largura="60"/></mod:grupo>
			<mod:grupo><mod:data titulo="Data do Exerc�cio" var="dataExercicio" /></mod:grupo>
			<%--<mod:grupo><mod:texto titulo="Lota��o Atual" var="lotaAtual" valor="${doc.subscritor.lotacao.nomeLotacao}" largura="60"/></mod:grupo>--%>
			<mod:grupo><mod:texto titulo="Lota��o Desejada" var="lotaDesejada" largura="60"/></mod:grupo>
			<br/>
			<c:set var="conteudo11">
			O JUIZ FEDERAL - DIRETOR DO FORO E CORREGEDOR PERMANENTE DOS SERVI�OS AUXILIARES DA JUSTI�A FEDERAL - SE��O JUDICI�RIA DO RIO DE JANEIRO, no uso de suas atribui��es legais e com o objetivo de tornar o processo de lota��o e remo��o mais c�lere, RESOLVE: <br/><br/>Estabelecer os seguintes crit�rios a serem observados pelos servidores interessados em integrar o Banco de Permutas da Se��o Judici�ria do Rio de Janeiro:<br/><br/> 
			</c:set>
			<c:set var="conteudo12">
			I- a inscri��o do servidor implica a sua disponibilidade imediata para a realiza��o da permuta pretendida. Caso o servidor n�o concorde em realiz�-la � �poca em que surgir a possibilidade de atendimento, sua inscri��o no Banco ser� exclu�da, automaticamente. N�o haver� �bice para que o servidor fa�a uma nova inscri��o, posteriormente.<br/><br/>
			</c:set>
			<c:set var="conteudo13">
			II- na hip�tese de o servidor se inscrever para mais de uma unidade de lota��o, quando houver o atendimento de uma delas, automaticamente, ser� exclu�do do Banco de Permutas, sem preju�zo para que proceda a uma nova inscri��o.<br/><br/>
			</c:set>
			<c:set var="conteudo14">
			III- a movimenta��o dos servidores inscritos no Banco de Permutas dar-se� de acordo com a ordem cronol�gica dos pedidos na Subsecretaria de Recursos Humanos.<br/><br/>			
			</c:set>
			<c:set var="conteudo15">
			IV- Esta Portaria entra em vigor na data de sua publica��o.<br/><br/>
			</c:set>
			<c:set var="conteudo2">
			Art. 12. Servidores ocupantes de cargos efetivos com especialidade somente poder�o ser lotados em unidades organizacionais diretamente ligadas �s atribui��es dos cargos, exceto na hip�tese de designa��o para fun��o comissionada de chefia (FC-04 ou superior) ou para cargo em comiss�o de Dire��o ou Assessoramento.<br/>
			</c:set>			
			
			<c:set var="textoCiencia">
			<b>Estou ciente da 
			<span onmouseover="this.style.cursor='hand';" 
			onclick="javascript: if (newwin!=null) newwin.close(); newwin = window.open('teste',null,'height=450,width=550,status=no,toolbar=no,menubar=no,location=no'); newwin.document.write('${conteudo11}'); newwin.document.write('${conteudo12}'); newwin.document.write('${conteudo13}'); newwin.document.write('${conteudo14}'); newwin.document.write('${conteudo15}');"><u>Portaria n� 36/2008</u></span>, de 26/06/08, 
			do 
			<span onmouseover="this.style.cursor='hand';" onclick="javascript: if (newwin!=null) newwin.close(); newwin = window.open('teste2',null,'height=160,width=400,status=no,toolbar=no,menubar=no,location=no'); newwin.document.write('${conteudo2}');"><u>caput do art. 12 da portaria n� 50/2008</u></span>, 
			de 29/09/08 e de que a desist�ncia da inclus�o no Banco de Permutas dever� ser comunicada � Subsecretaria de Recursos Humanos por meio de requerimento.</b>
			</c:set>
			<mod:obrigatorios />
			<br/>
			<mod:caixaverif titulo="${textoCiencia}" var="ciente" obrigatorio="Sim"/>
		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<mod:valor var="texto_requerimento">
			<p style="TEXT-INDENT: 2cm" align="justify">
			${doc.subscritor.descricao}, ${doc.subscritor.cargo.nomeCargo},
			matricula ${doc.subscritor.matricula}, do Quadro de Pessoal Permanente 
			da Justi�a Federal de Primeiro Grau no Rio de Janeiro, 
			com exerc�cio a partir de ${dataExercicio}, lotado no(a) ${doc.subscritor.lotacao.descricao}, 
			com n�vel de escolaridade ${formacao}, vem requerer a Vossa Senhoria
			inclus�o no Banco de Permutas, a fim de ser lotado(a) no(a) ${lotaDesejada}.</p>
			<p style="TEXT-INDENT: 2cm" align="justify">
			Est� ciente da Portaria n� 36/2008, de 26/06/08, 
			do caput do art. 12 da Portaria n� 50/2008, de 29/08/08 e de que 
			a desist�ncia da inclus�o no Banco de Permutas dever� ser comunicada � 
			Subsecretaria de Recursos Humanos por meio de requerimento.
			</p>
		</mod:valor>
	</mod:documento>
</mod:modelo>
