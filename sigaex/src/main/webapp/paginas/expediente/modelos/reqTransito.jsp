
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script language="javascript">
var newwin = null;
</script>

<c:set var="esconderTexto" value="sim" scope="request" />
<c:set var="para" value="diretorForo" scope="request" />
<mod:modelo urlBase="/paginas/expediente/modelos/requerimento_rh.jsp">
	<mod:entrevista>


		<c:set var="conteudo1">
Art. 18.  O servidor que deva ter exerc�cio em outro munic�pio em raz�o de ter sido removido, redistribu�do, requisitado, cedido ou posto em exerc�cio provis�rio ter�, no m�nimo, dez e, no m�ximo, trinta dias de prazo, contados da publica��o do ato, para a retomada do efetivo desempenho das atribui��es do cargo, inclu�do nesse prazo o tempo necess�rio para o deslocamento para a nova sede. (Reda��o dada pela Lei n� 9.527, de 10.12.97)
		</c:set>
		<c:set var="conteudo2">
� 1o  Na hip�tese de o servidor encontrar-se em licen�a ou afastado legalmente, o prazo a que se refere este artigo ser� contado a partir do t�rmino do impedimento. (Par�grafo renumerado e alterado pela Lei n� 9.527, de 10.12.97)
			
		</c:set>
		<c:set var="conteudo3">
� 2o  � facultado ao servidor declinar dos prazos estabelecidos no caput.  (Inclu�do pela Lei n� 9.527, de 10.12.97)
			
		</c:set>
		<c:set var="conteudo4">
Art. 102.  Al�m das aus�ncias ao servi�o previstas no art. 97, s�o considerados como de efetivo exerc�cio os afastamentos em virtude de:
			
		</c:set>
		<c:set var="conteudo5">
I - f�rias;
			
		</c:set>
		<c:set var="conteudo6">
II - exerc�cio de cargo em comiss�o ou equivalente, em �rg�o ou entidade dos Poderes da Uni�o, dos Estados, Munic�pios e Distrito Federal;
			
		</c:set>
		<c:set var="conteudo7">
III - exerc�cio de cargo ou fun��o de governo ou administra��o, em qualquer parte do territ�rio nacional, por nomea��o do Presidente da Rep�blica; 
			
		</c:set>
		<c:set var="conteudo8">
IV - participa��o em programa de treinamento regularmente institu�do ou em programa de p�s-gradua��o stricto sensu no Pa�s, conforme dispuser o regulamento; (Reda��o dada pela Lei n� 11.907, de 2009)
			
		</c:set>
		<c:set var="conteudo9">
V - desempenho de mandato eletivo federal, estadual, municipal ou do Distrito Federal, exceto para promo��o por merecimento;
			
		</c:set>
		<c:set var="conteudo10">
VI - j�ri e outros servi�os obrigat�rios por lei; 
			
		</c:set>
		<c:set var="conteudo11">
VII - miss�o ou estudo no exterior, quando autorizado o afastamento, conforme dispuser o regulamento; (Reda��o dada pela Lei n� 9.527, de 10.12.97)
			
		</c:set>
		<c:set var="conteudo12">
VIII - licen�a:
			
		</c:set>
		<c:set var="conteudo13">
a) � gestante, � adotante e � paternidade; 
			
		</c:set>
		<c:set var="conteudo14">
b) para tratamento da pr�pria sa�de, at� o limite de vinte e quatro meses, cumulativo ao longo do tempo de servi�o p�blico prestado � Uni�o, em cargo de provimento efetivo; (Reda��o dada pela Lei n� 9.527, de 10.12.97)
			
		</c:set>
		<c:set var="conteudo15">
c) para o desempenho de mandato classista ou participa��o de ger�ncia ou administra��o em sociedade cooperativa constitu�da por servidores para prestar servi�os a seus membros, exceto para efeito de promo��o por merecimento; (Reda��o dada pela Lei n� 11.094, de 2005)
			
		</c:set>
		<c:set var="conteudo16">
d) por motivo de acidente em servi�o ou doen�a profissional; 
			
		</c:set>
		<c:set var="conteudo17">
e) para capacita��o, conforme dispuser o regulamento; (Reda��o dada pela Lei n� 9.527, de 10.12.97)
			
		</c:set>
		<c:set var="conteudo18">
f) por convoca��o para o servi�o militar;
			
		</c:set>
		<c:set var="conteudo19">
IX - deslocamento para a nova sede de que trata o art. 18;
			
		</c:set>
		<c:set var="conteudo20">
X - participa��o em competi��o desportiva nacional ou convoca��o para integrar representa��o desportiva nacional, no Pa�s ou no exterior, conforme disposto em lei espec�fica;
			
		</c:set>
		<c:set var="conteudo21">
XI - afastamento para servir em organismo internacional de que o Brasil participe ou com o qual coopere. (Inclu�do pela Lei n� 9.527, de 10.12.97)
			
		</c:set>
		<c:set var="conteudo22">
Art. 44. Considera-se per�odo de tr�nsito, para os fins desta Resolu��o, o prazo concedido ao servidor que deva ter exerc�cio funcional em outra localidade por motivo de remo��o, redistribui��o, cess�o ou exerc�cio provis�rio, desde que implique mudan�a de resid�ncia.
			
		</c:set>
		<c:set var="conteudo23">
Par�grafo �nico. O afastamento de que trata este artigo � considerado como de efetivo exerc�cio, fazendo jus o servidor durante esse per�odo � remunera��o do cargo efetivo.
			
		</c:set>
		<c:set var="conteudo24">
Art. 45. O per�odo de tr�nsito ser� de, no m�nimo, dez e, no m�ximo, trinta dias, contados da publica��o do ato de remo��o, redistribui��o, cess�o ou exerc�cio provis�rio.
			
		</c:set>
		<c:set var="conteudo25">
&sect; 1&ordm; No caso de retorno do servidor, o prazo de que trata este artigo ser� contado:
			
		</c:set>
		<c:set var="conteudo26">
I - na hip�tese de cess�o, da publica��o do ato de exonera��o do cargo em comiss�o ou de dispensa da fun��o comissionada ocupado no �rg�o cession�rio;
			
		</c:set>
		<c:set var="conteudo27">
II - na hip�tese de exerc�cio provis�rio, da publica��o do ato que determinar o retorno.
			
		</c:set>
		<c:set var="conteudo28">
&sect; 2&ordm; Na hip�tese de o servidor encontrar-se em licen�a ou afastado legalmente, o per�odo de tr�nsito ser� contado a partir do t�rmino do impedimento.
			
		</c:set>
		<c:set var="conteudo29">
&sect; 3&ordm; As licen�as e afastamentos legais ocorridos durante o tr�nsito n�o suspendem o seu transcurso, podendo ser concedidos pelo tempo que sobejar.
			
		</c:set>
		<c:set var="conteudo30">
&sect; 4&ordm; Ao servidor � facultado desistir, total ou parcialmente, do per�odo de tr�nsito.
			
		</c:set>
		<c:set var="conteudo31">
Art. 46. A concess�o do per�odo de tr�nsito caber� ao �rg�o competente para emiss�o do ato de cess�o, remo��o, exerc�cio provis�rio e redistribui��o.
			
		</c:set>
		<c:set var="conteudo32">
&sect; 1&ordm; Caber� ao �rg�o de origem o pagamento da remunera��o do seu cargo efetivo durante o per�odo de tr�nsito.
			
		</c:set>
		<c:set var="conteudo33">
&sect; 2&ordm; O per�odo de tr�nsito dever� ser concedido juntamente com o ato de movimenta��o, mediante requerimento do servidor.
			
		</c:set>

		<mod:grupo>
			<mod:texto titulo="Lota��o de origem" var="lotOrigem" largura="50"
				obrigatorio="Sim" />
			<br />
			<mod:texto titulo="Lota��o de destino" var="lotDestino" largura="50"
				obrigatorio="Sim" />
			<br />
			<mod:texto titulo="E-mail" var="email" largura="50" obrigatorio="Sim" />
			<br />
			<mod:texto titulo="N�mero total dos dias de tr�nsito pretendidos"
				var="dias" largura="5" obrigatorio="Sim" />
			<br />
			<mod:texto titulo="Per�odo do tr�nsito" var="periodo" largura="30"
				obrigatorio="Sim" />
			<br />
			<c:set var="textoCiencia">
Estou ciente:
			<b><br />
				- dos termos da Lei n� 8.112/90 <span
					onmouseover="this.style.cursor='hand';"
					onclick="javascript: if (newwin!=null) newwin.close(); newwin = window.open('',null,'height=450,width=550,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes'); newwin.document.write('${conteudo1}<br /><br />'); newwin.document.write('${conteudo2}<br /><br />');newwin.document.write('${conteudo3}<br /><br />');newwin.document.write('${conteudo4}<br /><br />');newwin.document.write('${conteudo5}<br /><br />');newwin.document.write('${conteudo6}<br /><br />');newwin.document.write('${conteudo7}<br /><br />');newwin.document.write('${conteudo8}<br /><br />');newwin.document.write('${conteudo9}<br /><br />');newwin.document.write('${conteudo10}<br /><br />');newwin.document.write('${conteudo11}<br /><br />');newwin.document.write('${conteudo12}<br /><br />');newwin.document.write('${conteudo13}<br /><br />');newwin.document.write('${conteudo14}<br /><br />');newwin.document.write('${conteudo15}<br /><br />');newwin.document.write('${conteudo16}<br /><br />');newwin.document.write('${conteudo17}<br /><br />');newwin.document.write('${conteudo18}<br /><br />');newwin.document.write('${conteudo19}<br /><br />');newwin.document.write('${conteudo20}<br /><br />');newwin.document.write('${conteudo21}<br /><br />');"><u>artigos
				18 e 102</u></span> c/c os <span onmouseover="this.style.cursor='hand';"
					onclick="javascript: if (newwin!=null) newwin.close(); newwin = window.open('teste',null,'height=450,width=550,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes'); newwin.document.write('${conteudo22}<br /><br />');newwin.document.write('${conteudo23}<br /><br />');newwin.document.write('${conteudo24}<br /><br />');newwin.document.write('${conteudo25}<br /><br />');newwin.document.write('${conteudo26}<br /><br />');newwin.document.write('${conteudo27}<br /><br />');newwin.document.write('${conteudo28}<br /><br />');newwin.document.write('${conteudo29}<br /><br />');newwin.document.write('${conteudo30}<br /><br />');newwin.document.write('${conteudo31}<br /><br />');newwin.document.write('${conteudo32}<br /><br />');newwin.document.write('${conteudo33}<br /><br />');"><u>artigos
				44, 45 e 46</u></span> da Resolu��o n� 03, de 10/3/2008 do Conselho da Justi�a
				Federal. <br />
				- de que a concess�o de tr�nsito implica mudan�a de resid�ncia e,
				assim, compromete-se a atualizar o endere�o na Se��o de Cadastro
				(SECAD), at� o t�rmino do tr�nsito. </b>
			</c:set>
			<br />
			<mod:caixaverif titulo="${textoCiencia}" var="ciente"
				obrigatorio="Sim" marcado="Sim" />
			<br />
			<mod:obrigatorios />

		</mod:grupo>
	</mod:entrevista>

	<mod:documento>
		<c:set var="tl" value="10pt" />
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
		<table width="100%" border="0"  bgcolor="#FFFFFF">
			<tr><td>
			<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizadoPrimeiraPagina.jsp" />
			</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<br/><br/>
					<table width="100%" border="0" >
						<tr>
							<td align="center"><mod:letra tamanho="${tl}"><p style="font-family:Arial;font-weight:bold" >REQUERIMENTO DE TR&Acirc;NSITO</p></mod:letra></td>
						</tr>
						<tr>
							<td><br/><br/></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->

		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoCentralizado.jsp" />
		FIM CABECALHO -->


		<mod:valor var="texto_requerimento">

			<p style="TEXT-INDENT: 2cm" align="justify">
			${doc.subscritor.descricao}, matr�cula n� ${doc.subscritor.sigla},
			${doc.subscritor.cargo.nomeCargo}, lotado(a) no(a)
			${f:removeAcentoMaiusculas(lotOrigem)}, e-mail: ${email}, vem
			requerer a Vossa Excel�ncia concess�o de ${dias} dias de tr�nsito, no
			per�odo de ${periodo}, tendo em vista remo��o para
			${f:removeAcentoMaiusculas(lotDestino)}, nos termos da Lei N�
			8.112/90 c/c artigos 44, 45 e 46 da Resolu��o N� 03/2008-CJF. <br />
			<br />
			Declara estar ciente de que a concess�o de tr�nsito implica mudan�a de
			resid�ncia e, assim, compromete-se a atualizar o endere�o na Se��o de
			Cadastro (SECAD), at� o t�rmino do tr�nsito.</p>
		</mod:valor>




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