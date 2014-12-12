<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<mod:modelo>
	<mod:entrevista>
		<mod:grupo titulo="DADOS DOS MAGISTRADOS/SERVIDORES BENEFICI�RIO">
			<mod:grupo>
				<mod:texto titulo="Quadro de pessoal" var="quadro" />
				<mod:texto titulo="Ramal" var="ramal" largura="15"/>
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="Plano de Sa�de a que est� vinculado" var ="plano"/>
			</mod:grupo>
		</mod:grupo>
		
		
		<mod:grupo titulo="DADOS DOS DEPENDENTES(S)">
			<mod:grupo>
				<mod:texto titulo="Nome" var="dep" largura="50"/>
			</mod:grupo>
			<mod:grupo>
			<mod:texto titulo="Parentesco" var="paren" largura="20"/>
				
			</mod:grupo>
			<mod:grupo>
				<mod:data titulo="data de nascimento" var="dtNasc"/>
				<mod:selecao titulo="Estado Civil" var="estado" opcoes="solteiro(a);casado(a);vi�vo(a);outros" reler="n�o" />
			</mod:grupo>
			<mod:grupo>
				<mod:texto titulo="N� Identidade" var="iden" largura="20"/>
				<mod:texto titulo="Org�o Expedidor" var ="OrgExp"/>
				<mod:data titulo="Data de Expedi��o" var="dtExp"/>
			</mod:grupo>
			<mod:grupo>
				<mod:data titulo="data" var="dt"/>
				<mod:texto titulo="rela�ao de documentos de dependencia" var="rel"/>
			</mod:grupo>
		</mod:grupo>
	</mod:entrevista>
	<mod:documento>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<style type="text/css">
			@page {
				margin-left: 1cm;
				margin-right: 0.5cm;
				margin-top: 1cm;
				margin-bottom: 2cm;
			}
			</style>
		</head>
		<body>
		<c:set var="pessoa" value ="${f:pessoa(requestScope['pessoa_pessoaSel.id'])}" />
				<!-- INICIO PRIMEIRO CABECALHO
		<table width="100%" border="0" bgcolor="#FFFFFF"><tr><td>
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPaginaTRF.jsp" />
		</td></tr>
		
		</td></tr>
			<tr bgcolor="#FFFFFF">
				<td width="100%">
					<table width="100%">
						<tr> 
							<td align="center"><p style="font-family:Arial;font-size:11pt;font-weight:bold;"><br/><br/>
						DADOS CADASTRAIS PARA O AUX&Iacute;LIO-SA&Uacute;DE<br /><br /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		FIM PRIMEIRO CABECALHO -->
		<!-- INICIO CABECALHO
		<c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerda.jsp" />
		FIM CABECALHO -->
<br/>
		<table border="1" cellpadding="5" width="96%"style="font-size:9" >
			<tr>
    			<th colspan="2" align="left" style="font-size:12"><b>1-DADOS DO MAGISTRADOS/SERVIDOR BENEFICI�RIO(TITULAR)</b></th>
  			</tr>
  			<tr >
  				<td>
  				Nome: ${doc.subscritor.descricao}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; matricula:${doc.subscritor.matricula}<br/>
				Cargo: ${doc.subscritor.cargo.descricao} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quadro de pessoal:${quadro}<br/>
				Lota��o: ${doc.subscritor.lotacao.descricao}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ramal:${ramal}<br/>
				Plano de Sa&uacute;de a que est&aacute; vinculado: ${plano}
				
  				</td>
  			</tr>
  		</table>
  		<br/>
		<table border="1" cellpadding="5" width="96%"style="font-size:9" >
	  		<tr>
  				<td colspan="2" align="left" style="font-size:12"><b>2-DADOS DOS DEPENDENTE(S)</b></td>
  			</tr>
  			<tr>
  				<td>
  					Nome: ${dep}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Parentesco: ${paren} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  					Estado Civil: ${estado} <br/>
  					Data de nascimento: ${dtNasc} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  					N� Identidade:${ iden} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  					&Oacute;rg&atilde;o Expedidor: ${OrgExp} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  					Data de expedi&ccedil;&atilde;o: ${dtExp }<br/>
  				</td>
  			</tr>
		</table>
		
		<br/>
		
		<table border="1" cellpadding="5" width="96%"style="font-size:9">
			<tr>
				<th colspan="2" align="left" style="font-size:12"><b>3-DECLARA&Ccedil;&Atilde;O </b></th>
			</tr>
			<tr >
				<td >
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Declaro estar ciente dos termos do capitulo IV da resolu�ao n� 2 de 2008 do Conselho da Justi�a
					Federal, que regulamenta a assistencia � saude prevista no art. 2320 da lei n� 8.112, de 1990, 
					com a reda��o dada pela lei 11.032, de 2006, e de que  o repesctivo auxilio sera pago mediante
					reembolso.<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Declaro, ainda que os beneficios acima relacionados n�o recebem  auxilio semelhante, nem participar de outro 
					progrmaa de assisaitencia saude, custeado pelos cofres publicos, ainda que eme partes.<br/>
					<b>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Declaro, por fim, estar ciente de que a documento��o sobre a operadora/contrato do contrato do plano de saude
					sera apresentada apos a regulamenta��o da mat�ria pelo TRF - 2� Regi�o.
					</b> 
				</td>
			</tr>
		</table>
		<br>
		<table border="1" cellpadding="5" width="96%"style="font-size:9">
			<tr>
				<th colspan="2" align="left" style="font-size:12"><b>4- ANEXOS </b></th>
			</tr>
			<tr >
				<td >
					Em anexo seguem os documentos que comprovam a situa��o de dependencia: ${rel}<br/>
				</td>
			</tr>
			<tr align="right">
				<td>Rio de Janeiro: ${dt}, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:import url="/paginas/expediente/modelos/inc_assinatura.jsp" /></td>
			</tr>
		</table>
		
		<br/>
		<table border="1" cellpadding="5" width="96%"style="font-size:9">
			<tr>
				<th colspan="2" align="left" style="font-size:12"><b>5- OBSERVA��ES </b></th>
			</tr>
			<tr >
				<td >
					Res. 02/2008/CJF:<br/> 
					"Art. 42. S� far� jus ao ressarcimento o
					benefici�rio que n�o receber aux�lio semelhante e nem participar de outro 
					programa de assist�ncia � sa�de de servidor, custeado pelos cofres p�blicos, 
					ainda que em parte.<br/>
					Art. 43. S�o benefici�rios do aux�lio:<br/>
					I - na qualidade de titulares: <br/>
 					a)     magistrados e servidores ativos e inativos, inclu�dos os cedidos e ocupantes apenas de cargo comissionado no Conselho e �rg�os da Justi�a Federal de primeiro e segundo graus;
					b)     pensionistas estatut�rios.<br/>
					II - na qualidade de dependente do titular:<br/>
					a)     o c�njuge, o companheiro ou companheira de uni�o est�vel;<br/>
					b)     a pessoa desquitada, separada judicialmente ou divorciada, que perceba pens�o aliment�cia;<br/>
					c)     os filhos e enteados, solteiros, at� 21 (vinte e um) anos de idade ou, se inv�lidos, enquanto durar a invalidez;<br/>
					d)     os filhos e enteados, entre 21 (vinte e um) e 24 (vinte e quatro) anos de idade, dependentes econ�micos do magistrado ou servidor e estudantes de curso regular reconhecido pelo Minist�rio da  Educa��o;<br/>
					e)     o menor sob guarda ou tutela concedida por decis�o judicial.<br/>
					Art. 45. S�o documentos indispens�veis para inscri��o:
					I - c�pia autenticada do contrato celebrado entre o benefici�rio titular e a operadora de planos de sa�de ou o original seguido de c�pia, a ser conferida pelo servidor respons�vel;<br/>
					II - comprovante de que a operadora de planos de sa�de contratada pelo servidor est� regular e autorizada pela Ag�ncia Nacional de Sa�de (ANS);
					III - declara��o para fins de cumprimento do art. 42 desta Resolu��o;
					IV - documentos oficiais que comprovem a situa��o de  depend�ncia, (...)"
				</td>
			</tr>
		</table>

		<!-- INICIO PRIMEIRO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeClassificacaoDocumental.jsp" />
		FIM PRIMEIRO RODAPE -->

		<!-- INICIO RODAPE
		<c:import url="/paginas/expediente/modelos/inc_rodapeNumeracaoADireita.jsp" />
		FIM RODAPE -->

		</body>
		</html>
	</mod:documento>

</mod:modelo>