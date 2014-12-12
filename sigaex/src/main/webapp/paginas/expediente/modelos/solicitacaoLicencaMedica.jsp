<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- este modelo trata de SOLICITA��O DE LICEN�A M�DICA
    Ultima Altera��o 08/03/2007 
 -->

<mod:modelo>
    <mod:entrevista>
        <mod:grupo titulo="DETALHES DA LICEN�A">
            <mod:selecao titulo="Atestado em anexo de" var="tipoAtestado"
                opcoes="m�dico da SJRJ;m�dico externo" />
        </mod:grupo>
        <mod:grupo>
            <mod:texto titulo="Endere�o" largura="55" maxcaracteres="80"
                var="endereco" />
        </mod:grupo>
        <mod:grupo>
            <mod:texto titulo="Tel Residencial" largura="15" maxcaracteres="13"
                var="telResidencial" />
            <mod:texto titulo="Celular" largura="15" maxcaracteres="13"
                var="telCelular" />
            <mod:texto titulo="Ramal" largura="10" maxcaracteres="10"
                var="ramalLotacao" />
        </mod:grupo>
        <mod:selecao titulo="Tipo" var="tipolicenca"
            opcoes="Licen�a para Tratamento da Pr�pria Sa�de;Licen�a � Gestante;Licen�a por Motivo de Doen�a de Pessoa da Fam�lia;"
            reler="sim" />
        <c:if test="${tipolicenca eq 'Licen�a � Gestante'}">
            <mod:grupo>
                <mod:caixaverif titulo="Prorroga��o da Licen�a � Gestante" var="plg"
                    reler="ajax" idAjax="plgAjax" />
            </mod:grupo>
        </c:if>
        <mod:grupo depende="plgAjax">
            <c:if test="${plg == 'Sim'}">
                <mod:grupo>
                    <mod:mensagem
                        texto="(Declaro estar ciente de que, caso haja falecimento da crian�a, cessar�, imediatamente, o meu direito � prorroga��o da Licen�a � Gestante, conforme disposto no art.7� da Res-CJF n.30/2008)"></mod:mensagem>
                </mod:grupo>
            </c:if>
        </mod:grupo>
        <c:if
            test="${tipolicenca eq 'Licen�a por Motivo de Doen�a de Pessoa da Fam�lia'}">
            <mod:grupo>
                <mod:texto titulo="Nome do Familiar" largura="30" maxcaracteres="30"
                    var="nomeFamiliar" />
                <mod:texto titulo="Grau de Parentesco" largura="15"
                    maxcaracteres="15" var="grauParentesco" />
            </mod:grupo>
        </c:if>
        <mod:grupo titulo="Per�odo Solicitado">
            <mod:data titulo="Data Inicial" var="dataInicio" />
            <mod:texto titulo="Quant. de dias" var="quantDias" largura="3"
                maxcaracteres="3" obrigatorio="Sim" />
        </mod:grupo>
    </mod:entrevista>

    <mod:documento>
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
        <style type="text/css">
@page {
    margin-left: 2cm;
    margin-right: 2cm;
    margin-bottom: 1.75cm;
}
</style>
        </head>
        <body>
    <!-- INICIO PRIMEIRO CABECALHO
        <table width="100%" border="0" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <c:import url="/paginas/expediente/modelos/inc_cabecalhoEsquerdaPrimeiraPagina.jsp" />
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
    
        FIM PRIMEIRO CABECALHO -->

    <p style="font-size: 15pt;"><b>SOLICITA��O DE LICEN�A M�DICA</b></p>
        Atestado em anexo:&nbsp;&nbsp;&nbsp;&nbsp;
        <c:choose>
            <c:when test="${tipoAtestado eq 'm�dico da SJRJ'}">
                [x] de m�dico da SJRJ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;] de m�dico externo
            </c:when>
            <c:when test="${tipoAtestado eq 'm�dico externo'}">
                [&nbsp;&nbsp;] de m�dico da SJRJ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[x] de m�dico externo
            </c:when>
            <c:otherwise>
                [&nbsp;&nbsp;] de m�dico da SJRJ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;] de m�dico externo
            </c:otherwise>
        </c:choose>
        <table width="100%" border="1" cellpadding="3" cellspacing="1">
            <tr>
                <td bgcolor="#C0C0C0" colspan="2"><b>SERVIDOR</b></td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="3" cellspacing="1">
            <tr>
                <td width="70%" bgcolor="#FFFFFF">Nome: <b>${doc.subscritor.descricao}</b></td>
                <td width="30%" bgcolor="#FFFFFF">Matr�cula: <b>${doc.subscritor.sigla}</b></td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="3">
            <tr>
                <td width="30%">Lota��o: <b>${doc.subscritor.lotacao.descricao}</b></td>
                <td width="70%">Cargo: <b>${doc.subscritor.cargo.nomeCargo}</b></td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="3">
            <tr>
                <td>Endere�o: <b>${endereco}</b></td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="3">
            <tr>
                <td>Tel Residencial: <b>${telResidencial}</b></td>
                <td>Tel Celular: <b>${telCelular}</b></td>
                <td>Ramal da Lota��o: <b>${ramalLotacao}</b></td>
            </tr>
        </table>
        <table width="100%" border="1" cellpadding="3">
            <tr>
                <td width="60%">Tipo de Licen�a:<br />
                <c:choose>
                    <c:when
                        test="${tipolicenca eq 'Licen�a para Tratamento da Pr�pria Sa�de'}">
                    <p style="font-size: 9pt;">LTS - Licen�a para Tratamento da Pr�pria Sa�de<br /> </p>
                    </c:when>
                    <c:when
                        test="${tipolicenca eq 'Licen�a � Gestante' && plg eq 'Nao'}">
                   <p style="font-size: 9pt;"> LG - Licen�a � Gestante<br /></p>
                    </c:when>
                    <c:when
                        test="${tipolicenca eq 'Licen�a � Gestante' && plg eq 'Sim'}">
                   <p style="font-size: 9pt;"> LG - Licen�a � Gestante<br />
                    PLG - Prorroga��o da Licen�a � Gestante (Declaro estar ciente de que, 
                    caso haja falecimento da crian�a, cessar�, imediatamente, o meu direito � prorroga��o 
                    da Licen�a � Gestante, conforme disposto no art.7� da Res-CJF n.30/2008)</p>
                    </c:when>
                    <c:when
                        test="${tipolicenca eq 'Licen�a por Motivo de Doen�a de Pessoa da Fam�lia'}">
                   <p style="font-size: 9pt;"> LTPF - Licen�a por Motivo de Doen�a de Pessoa da Fam�lia<br /></p>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose></td>
                <td width="40%" align="center">Per�odo Solicitado:<br /><br />
                De: <b>${dataInicio}</b> at� <c:if test="${not empty quantDias}">
                    <b>${f:calculaData(requestScope['quantDias'],requestScope['dataInicio'])}</b>
                </c:if></td>
            </tr>
        </table>
        <c:if
            test="${tipolicenca eq 'Licen�a por Motivo de Doen�a de Pessoa da Fam�lia'}">
            <table width="100%" border="1" cellpadding="3">
                <tr>
                    <td width="60%">Nome do Familiar: <b>${nomeFamiliar}</b></td>
                    <td width="40%">Grau de Parentesco: <b>${grauParentesco}</b></td>
                </tr>
            </table>
        </c:if>
        <table width="100%" border="1">
            <tr>
                <td width="50%" valign="top">Local e Data:<br />
                ${doc.dtExtenso}<br />
                <br />
                </td>
                <td width="50%" valign="top">Assinatura do(a) Servidor(a)<br />
                <br />
                </td>
            </tr>
        </table>
        <table width="100%" border="1" width="100%">
            <tr>
                <td bgcolor="#C0C0C0"><b> OBSERVA��ES </b></td>
            </tr>
            <tr>
                <td>
                <p align="justify" style="font-size: 8pt;">- Dever� ser anexado
                ao presente formul�rio atestado m�dico dentro de envelope lacrado,
                com identifica��o de "confidencial", e encaminhado � SESAU/SRH ou �s
                SEAPOs no prazo de 3 (tr�s) dias �teis apartir do 1� dia do
                afastamento.<br />
                </p>
                <p align="justify" style="font-size: 8pt;">- Somente ser�o
                aceitos formul�rios com assinatura do servidor e de seu superior
                hier�rquico, com carimbo de identifica��o.<br />
                </p>
                <p align="justify" style="font-size: 8pt;"><b> - O atestado
                firmado por m�dico externo</b>, de forma leg�vel, sem rasuras e em
                receitu�rio adequado, dever� conter: nome completo do servidor;
                diagn�stico definitivo ou prov�vel, codificado (CID-10) ou por
                extenso; per�odo de afastamento recomendado e nome completo do
                m�dico; assinatura, carimbo e n� de registro do CRM.<br />
                </p>
                <p align="justify" style="font-size: 8pt;">Caso sejam concedidos
                ao servidor <b>licen�as ou afastamentos durante o periodo de
                f�rias</b>, estas ser�o suspensas e o per�odo remanescente ser�
                remarcado pela SRH, iniciando-se no 1� dia imediatamente posterior
                ao t�rmino da licen�a ou afastamento.<br />
                </p>
                </td>
            </tr>
            <tr>
                <td bgcolor="#C0C0C0"><b> CHEFIA </b></td>
            </tr>
        </table>
        <table width="100%" border="1" width="100%">
            <tr>
                <td valign="top">
                <p align="center" style="font-size: 8pt;"><b>Observa��es da
                chefia para a per�cia m�dica</b><br />
                (preenchimento obrigat�rio, mesmo que seja com "nada a declarar").<br />
                OBS:<br />
                </p>
                <p align="center" style="font-size: 8pt;">- Em caso de
                solicita��o de Licen�a por Motivo de Doen�a em Pessoa da Fam�lia -
                LTPF, h� possibilidade do servidor compensar os dias n�o
                trabalhados?(conforme �2� do art. 2� da Resolu��o n�447/2005 - CJF)</p>
                <p style="font-size: 10pt;"> [&nbsp;&nbsp;]sim [&nbsp;&nbsp;]n�o</p><br />
                </td>
                <td valign="top">
                <p align="center" style="font-size: 8pt;">�ltimo dia de trabalho
                do servidor: <br />
                <br />
                _______/_______/_______<br />
                Carimbo e assinatura da chefia<br />
                <br />
                </p>
                </td>
            </tr>
        </table>
        <c:import
            url="/paginas/expediente/modelos/inc_classificacaoDocumental.jsp" />
        </body>
        </html>
    </mod:documento>
</mod:modelo>
