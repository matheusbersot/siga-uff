SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Homologa��o de est�gio probat�rio (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1050,'Homologa��o de est�gio probat�rio (Docente)','Homologa��o de est�gio probat�rio (Docente)','template/freemarker', null, 6, 1050,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1050;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1050 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
    [#assign valores = 1..100 /]
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i largura="9" maxcaracteres="9" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data de Homologa��o" var="dtHomologacao"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Homologa��o do Est�gio Probat�rio de Docente.
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribui��es  legais, estatut�rias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - <strong>Homologar</strong> o Est�gio Probat�rio dos Docentes relacionados no anexo a presente Portaria, nos termos da Lei 8.112 de 11 de Dezembro de 1990, Emenda Constitucional n� 19/98 e com base no Parecer AGU/MC n� 01/2004 publicado no D.O. de 16 de Julho de 2004, a Secretaria de Recursos Humanos do Minist�rio do Planejamento reconheceu como sendo de 03 anos o per�odo de Est�gio Probat�rio assim como o per�odo para aquisi��o de estabilidade, e a Resolu��o CEP-UFF 219/2005 e <span style="font-style: italic;font-weight: bold;">Decis�o CEP n� 731/13</span>.</p>
[/#assign]

[#assign tabela_anexo]
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="4" style="border: 1px solid black;"><strong>RELA��O DE PROFESSORES DA CARREIRA DE MAGIST�RIO SUPERIOR COM DIREITO � HOMOLOGA��O DE EST�GIO PROBAT�RIO</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="4" style="border: 1px solid black;">
 			   [#if doc.exMobilPai??]
	               <strong>ANEXO � Portaria n&ordm; ${doc.exMobilPai.exDocumento.numExpediente!} , ${doc.exMobilPai.exDocumento.dtD!} de ${doc.exMobilPai.exDocumento.dtMMMM!} de ${doc.exMobilPai.exDocumento.dtYYYY!}.</strong>
			   [#else]
	               <strong>ANEXO � Portaria n&ordm;  ,  de  de .</strong>
 		       [/#if]
           </td>
        </tr>
        <tr style="border: 1px solid black;font-size:10pt;">	
          <td width="10%" style="border: 1px solid black;">Ordem</td>
          <td width="15%" style="border: 1px solid black;">Mat. SIAPE</td>
          <td width="55%" style="border: 1px solid black;">Processo/Nome</td>
          <td width="20%" style="border: 1px solid black;">Homologa��o concedida em</td>
        </tr> 
        [#list 1..(qtdServidores)?number as i]				
      <tr style="border: 1px solid black;font-size:10pt;">	
        <td style="border: 1px solid black;">${i}</td>
        <td style="border: 1px solid black;">${.vars[''siape''+i]!}</td>
        <td style="border: 1px solid black;">23069.${.vars[''sequencial''+i]!}/${.vars[''ano''+i]!}-${.vars[''digito''+i]!}<br/>${.vars[''nome''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''dtHomologacao''+i]!}</td>
      </tr>			
      [/#list]
  </table>  
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa texto_anexo=tabela_anexo/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Concess�o a progress�o (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1051,'Concess�o a progress�o (Docente)','Concess�o a progress�o (Docente)','template/freemarker', null, 6, 1051,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1051;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1051 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
[#assign valores = 1..100 /]
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i largura="9" maxcaracteres="9" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Interst�cio:" var="intersticio"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Classe" var="classe"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Denomina��o" var="denominacao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="N�vel" var="nivel"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data dos efeitos Financeiros:" var="dt_efeitos"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]		
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concess�o a progress�o a Docente.
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribui��es  legais, estatut�rias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - Conceder Progress�o, Promo��o funcional e/ou Retribui��o por Titula��o aos Docentes relacionados no anexo � presente Portaria, nos termos, da Lei n� 12.772/12, Portaria Ministerial n� 554/13, Lei n� 12.863/13, Lei n.� 11.344/06, da Resolu��o do CEP n.� 218/05,  Decreto Lei 94.664/87, Portaria MEC n� 475/87 e <span style="font-style: italic;font-weight: bold;">Decis�o CEP n� 731/13</span>, observando-se a vig�ncia e os efeitos financeiros decorrentes.</p>
[/#assign]

[#assign tabela_anexo]
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;"><strong>RELA��O DE PROFESSORES DA CARREIRA DE MAGIST�RIO SUPERIOR COM DIREITO A PROGRESS�O, LEI 12.772/12 E PORTARIA MEC 554/13</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;">
 			   [#if doc.exMobilPai??]
	               <strong>ANEXO � Portaria n� ${doc.exMobilPai.exDocumento.numExpediente!} , ${doc.exMobilPai.exDocumento.dtD!} de ${doc.exMobilPai.exDocumento.dtMMMM!} de ${doc.exMobilPai.exDocumento.dtYYYY!}.</strong>
			   [#else]
	               <strong>ANEXO � Portaria n�  ,  de  de .</strong>
 		       [/#if]
           </td>
        </tr>
       <tr style="border: 1px solid black;font-size:10pt;">	
          <td style="border: 1px solid black;">Ordem</td>
          <td style="border: 1px solid black;">Mat. SIAPE</td>
          <td style="border: 1px solid black;">Processo/Nome</td>
          <td style="border: 1px solid black;">Interst�cio</td>
          <td style="border: 1px solid black;" colspan="3">
            <table width="100%" cellpadding="3" style="text-align:center;">
               <tr style="border: 1px solid black;font-size:10pt;text-align:center;"">
                  <td colspan="3" style="border-bottom: 1px solid black;">Situa��o Nova (Lei 12.772/12) e Portaria MEC 554/13)</td>
               </tr>
               <tr style="border: 1px solid black;font-size:10pt;">
                  <td width="25%">Classe</td>
                  <td width="45%">Denomina��o</td>
                  <td width="20%">N�vel</td>
               </tr>
            </table>
          </td>
         <td style="border: 1px solid black;">Efeitos Financeiros</td>
        </tr> 

      [#list 1..(qtdServidores)?number as i]				
      <tr style="border: 1px solid black;font-size:10pt;">	
        <td width="10%" style="border: 1px solid black;">${i}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''siape''+i]!}</td>
        <td width="11%" style="border: 1px solid black;">23069.${.vars[''sequencial''+i]!}/${.vars[''ano''+i]!}-${.vars[''digito''+i]!}<br/>${.vars[''nome''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''intersticio''+i]!}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''classe''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''denominacao''+i]!}</td>
        <td width="8%" style="border: 1px solid black;">${.vars[''nivel''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''dt_efeitos''+i]!}</td>
      </tr>			
      [/#list]
  </table>  
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa texto_anexo=tabela_anexo/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Concess�o de promo��o por m�rito (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1052,'Concess�o de promo��o por m�rito (Docente)','Concess�o de promo��o por m�rito (Docente)','template/freemarker', null, 6, 1052,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1052;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1052 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
[#assign valores = 1..100 /]
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i largura="9" maxcaracteres="9" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Interst�cio:" var="intersticio"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Classe" var="classe"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Denomina��o" var="denominacao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="N�vel" var="nivel"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data dos efeitos Financeiros:" var="dt_efeitos"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]		
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concess�o de promo��o a Docente por m�rito
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribui��es  legais, estatut�rias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - Conceder Progress�o, Promo��o funcional e/ou Retribui��o por Titula��o aos Docentes relacionados no anexo � presente Portaria, nos termos, da Lei n� 12.772/12, Portaria Ministerial n� 554/13, Lei n� 12.863/13, Lei n.� 11.344/06, da Resolu��o do CEP n.� 218/05,  Decreto Lei 94.664/87, Portaria MEC n� 475/87 e <span style="font-style: italic;font-weight: bold;">Decis�o CEP n� 731/13</span>, observando-se a vig�ncia e os efeitos financeiros decorrentes.</p>
[/#assign]

[#assign tabela_anexo]
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;"><strong>RELA��O DE PROFESSORES DA CARREIRA DE MAGIST�RIO SUPERIOR COM DIREITO A PROMO��O ( POR MERITO ),  LEI 12.772/12 E PORTARIA MEC 554/13</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;">
 			   [#if doc.exMobilPai??]
	               <strong>ANEXO � Portaria n� ${doc.exMobilPai.exDocumento.numExpediente!} , ${doc.exMobilPai.exDocumento.dtD!} de ${doc.exMobilPai.exDocumento.dtMMMM!} de ${doc.exMobilPai.exDocumento.dtYYYY!}.</strong>
			   [#else]
	               <strong>ANEXO � Portaria n�  ,  de  de .</strong>
 		       [/#if]
           </td>
        </tr>
       <tr style="border: 1px solid black;font-size:10pt;">	
          <td style="border: 1px solid black;">Ordem</td>
          <td style="border: 1px solid black;">Mat. SIAPE</td>
          <td style="border: 1px solid black;">Processo/Nome</td>
          <td style="border: 1px solid black;">Interst�cio</td>
          <td style="border: 1px solid black;" colspan="3">
            <table width="100%" cellpadding="3" style="text-align:center;">
               <tr style="border: 1px solid black;font-size:10pt;text-align:center;"">
                  <td colspan="3" style="border-bottom: 1px solid black;">Situa��o Nova (Lei 12.772/12) e Portaria MEC 554/13)</td>
               </tr>
               <tr style="border: 1px solid black;font-size:10pt;">
                  <td width="25%">Classe</td>
                  <td width="45%">Denomina��o</td>
                  <td width="20%">N�vel</td>
               </tr>
            </table>
          </td>
         <td style="border: 1px solid black;">Efeitos Financeiros</td>
        </tr> 

      [#list 1..(qtdServidores)?number as i]				
      <tr style="border: 1px solid black;font-size:10pt;">	
        <td width="10%" style="border: 1px solid black;">${i}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''siape''+i]!}</td>
        <td width="11%" style="border: 1px solid black;">23069.${.vars[''sequencial''+i]!}/${.vars[''ano''+i]!}-${.vars[''digito''+i]!}<br/>${.vars[''nome''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''intersticio''+i]!}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''classe''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''denominacao''+i]!}</td>
        <td width="8%" style="border: 1px solid black;">${.vars[''nivel''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''dt_efeitos''+i]!}</td>
      </tr>			
      [/#list]
  </table>  
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa texto_anexo=tabela_anexo/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## Concess�o de promo��o e retribui��o por titula��o (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1053,'Concess�o de promo��o e retribui��o por titula��o (Docente)','Concess�o de promo��o e retribui��o por titula��o (Docente)','template/freemarker', null, 6, 1053,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1053;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1053 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
[#assign valores = 1..100 /]
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i largura="9" maxcaracteres="9" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                 [@texto titulo="Retribui��o por Titula��o" var="retribuicao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Classe" var="classe"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Denomina��o" var="denominacao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="N�vel" var="nivel"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data dos efeitos Financeiros:" var="dt_efeitos"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]		
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concess�o de promo��o e retribui��o por titula��o a Docente
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribui��es  legais, estatut�rias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - Conceder Progress�o, Promo��o funcional e/ou Retribui��o por Titula��o aos Docentes relacionados no anexo � presente Portaria, nos termos, da Lei n� 12.772/12, Portaria Ministerial n� 554/13, Lei n� 12.863/13, Lei n.� 11.344/06, da Resolu��o do CEP n.� 218/05,  Decreto Lei 94.664/87, Portaria MEC n� 475/87 e <span style="font-style: italic;font-weight: bold;">Decis�o CEP n� 731/13</span>, observando-se a vig�ncia e os efeitos financeiros decorrentes.</p>
[/#assign]

[#assign tabela_anexo]
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;"><strong>RELA��O DE PROFESSORES DA CARREIRA DE MAGIST�RIO SUPERIOR COM DIREITO A PROMO��O E RETRIBUI��O POR TITULA��O -  ( LEI 12.772/12 E PORTARIA  MEC 554/13 )</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;">
 			   [#if doc.exMobilPai??]
	               <strong>ANEXO � Portaria n� ${doc.exMobilPai.exDocumento.numExpediente!} , ${doc.exMobilPai.exDocumento.dtD!} de ${doc.exMobilPai.exDocumento.dtMMMM!} de ${doc.exMobilPai.exDocumento.dtYYYY!}.</strong>
			   [#else]
	               <strong>ANEXO � Portaria n�  ,  de  de .</strong>
 		       [/#if]
           </td>
        </tr>
       <tr style="border: 1px solid black;font-size:10pt;">	
          <td style="border: 1px solid black;">Ordem</td>
          <td style="border: 1px solid black;">Mat. SIAPE</td>
          <td style="border: 1px solid black;">Processo/Nome</td>
          <td style="border: 1px solid black;">Retribui��o por Titula��o</td>
          <td style="border: 1px solid black;" colspan="3">
            <table width="100%" cellpadding="3" style="text-align:center;">
               <tr style="border: 1px solid black;font-size:10pt;text-align:center;"">
                  <td colspan="3" style="border-bottom: 1px solid black;">Situa��o Nova (Lei 12.772/12) e Portaria MEC 554/13)</td>
               </tr>
               <tr style="border: 1px solid black;font-size:10pt;">
                  <td width="25%">Classe</td>
                  <td width="45%">Denomina��o</td>
                  <td width="20%">N�vel</td>
               </tr>
            </table>
          </td>
         <td style="border: 1px solid black;">Efeitos Financeiros</td>
        </tr> 

      [#list 1..(qtdServidores)?number as i]				
      <tr style="border: 1px solid black;font-size:10pt;">	
        <td width="10%" style="border: 1px solid black;">${i}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''siape''+i]!}</td>
        <td width="11%" style="border: 1px solid black;">23069.${.vars[''sequencial''+i]!}/${.vars[''ano''+i]!}-${.vars[''digito''+i]!}<br/>${.vars[''nome''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''retribuicao''+i]!}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''classe''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''denominacao''+i]!}</td>
        <td width="8%" style="border: 1px solid black;">${.vars[''nivel''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''dt_efeitos''+i]!}</td>
      </tr>			
      [/#list]
  </table>  
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa texto_anexo=tabela_anexo/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## Concess�o de retribui��o por titula��o (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1054,'Concess�o de retribui��o por titula��o (Docente)','Concess�o de retribui��o por titula��o (Docente)','template/freemarker', null, 6, 1054,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1054;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1054 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
[#assign valores = 1..100 /]
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i largura="9" maxcaracteres="9" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                 [@texto titulo="Retribui��o por Titula��o" var="retribuicao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Classe" var="classe"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Denomina��o" var="denominacao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="N�vel" var="nivel"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data dos efeitos Financeiros:" var="dt_efeitos"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]		
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concess�o de retribui��o por titula��o a Docente
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribui��es  legais, estatut�rias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - Conceder Progress�o, Promo��o funcional e/ou Retribui��o por Titula��o aos Docentes relacionados no anexo � presente Portaria, nos termos, da Lei n� 12.772/12, Portaria Ministerial n� 554/13, Lei n� 12.863/13, Lei n.� 11.344/06, da Resolu��o do CEP n.� 218/05,  Decreto Lei 94.664/87, Portaria MEC n� 475/87 e <span style="font-style: italic;font-weight: bold;">Decis�o CEP n� 731/13</span>, observando-se a vig�ncia e os efeitos financeiros decorrentes.</p>
[/#assign]

[#assign tabela_anexo]
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;"><strong>RELA��O DE PROFESSORES DA CARREIRA DE MAGIST�RIO SUPERIOR COM DIREITO A RETRIBUI��O POR TITULA��O -  ( LEI 12.772/12 E PORTARIA  MEC 554/13 )</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="8" style="border: 1px solid black;">
 			   [#if doc.exMobilPai??]
	               <strong>ANEXO � Portaria n� ${doc.exMobilPai.exDocumento.numExpediente!} , ${doc.exMobilPai.exDocumento.dtD!} de ${doc.exMobilPai.exDocumento.dtMMMM!} de ${doc.exMobilPai.exDocumento.dtYYYY!}.</strong>
			   [#else]
	               <strong>ANEXO � Portaria n�  ,  de  de .</strong>
 		       [/#if]
           </td>
        </tr>
       <tr style="border: 1px solid black;font-size:10pt;">	
          <td style="border: 1px solid black;">Ordem</td>
          <td style="border: 1px solid black;">Mat. SIAPE</td>
          <td style="border: 1px solid black;">Processo/Nome</td>
          <td style="border: 1px solid black;">Retribui��o por Titula��o</td>
          <td style="border: 1px solid black;" colspan="3">
            <table width="100%" cellpadding="3" style="text-align:center;">
               <tr style="border: 1px solid black;font-size:10pt;text-align:center;"">
                  <td colspan="3" style="border-bottom: 1px solid black;">Situa��o Nova (Lei 12.772/12) e Portaria MEC 554/13)</td>
               </tr>
               <tr style="border: 1px solid black;font-size:10pt;">
                  <td width="25%">Classe</td>
                  <td width="45%">Denomina��o</td>
                  <td width="20%">N�vel</td>
               </tr>
            </table>
          </td>
         <td style="border: 1px solid black;">Efeitos Financeiros</td>
        </tr> 

      [#list 1..(qtdServidores)?number as i]				
      <tr style="border: 1px solid black;font-size:10pt;">	
        <td width="10%" style="border: 1px solid black;">${i}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''siape''+i]!}</td>
        <td width="11%" style="border: 1px solid black;">23069.${.vars[''sequencial''+i]!}/${.vars[''ano''+i]!}-${.vars[''digito''+i]!}<br/>${.vars[''nome''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''retribuicao''+i]!}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''classe''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''denominacao''+i]!}</td>
        <td width="8%" style="border: 1px solid black;">${.vars[''nivel''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''dt_efeitos''+i]!}</td>
      </tr>			
      [/#list]
  </table>  
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa texto_anexo=tabela_anexo/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## Concess�o de promo��o (Professor titular) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1055,'Concess�o de promo��o (Professor titular)','Concess�o de promo��o (Professor titular)','template/freemarker', null, 6, 1055,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1055;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1055 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
[#assign valores = 1..100 /]
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i largura="9" maxcaracteres="9" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                 [@texto titulo="Retribui��o por Titula��o" var="retribuicao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Classe" var="classe"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]	
                [@texto titulo="Denomina��o" var="denominacao"+i largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data dos efeitos Financeiros:" var="dt_efeitos"+i obrigatorio=true desativado="${desabilitadoEdicao}"/]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]		
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concess�o de Promo��o para a classe de Professor Titular.
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribui��es  legais, estatut�rias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - Conceder Progress�o, Promo��o funcional e/ou Retribui��o por Titula��o aos Docentes relacionados no anexo � presente Portaria, nos termos, da Lei n� 12.772/12, Portaria Ministerial n� 554/13, Lei n� 12.863/13, Lei n.� 11.344/06, da Resolu��o do CEP n.� 218/05,  Decreto Lei 94.664/87, Portaria MEC n� 475/87 e <span style="font-style: italic;font-weight: bold;">Decis�o CEP n� 731/13</span>, observando-se a vig�ncia e os efeitos financeiros decorrentes.</p>
[/#assign]

[#assign tabela_anexo]
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="7" style="border: 1px solid black;"><strong>RELA��O DE PROFESSORES DA CARREIRA DE MAGIST�RIO SUPERIOR COM DIREITO A PROMO��O PARA A CLASSE DE TITULAR, ( LEI 12.772/12 E PORTARIA  MEC 554/13 )</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="7" style="border: 1px solid black;">
 			   [#if doc.exMobilPai??]
	               <strong>ANEXO � Portaria n� ${doc.exMobilPai.exDocumento.numExpediente!} , ${doc.exMobilPai.exDocumento.dtD!} de ${doc.exMobilPai.exDocumento.dtMMMM!} de ${doc.exMobilPai.exDocumento.dtYYYY!}.</strong>
			   [#else]
	               <strong>ANEXO � Portaria n�  ,  de  de .</strong>
 		       [/#if]
           </td>
        </tr>
       <tr style="border: 1px solid black;font-size:10pt;">	
          <td style="border: 1px solid black;">Ordem</td>
          <td style="border: 1px solid black;">Mat. SIAPE</td>
          <td style="border: 1px solid black;">Processo/Nome</td>
          <td style="border: 1px solid black;">Retribui��o por Titula��o</td>
          <td style="border: 1px solid black;" colspan="2">
            <table width="100%" cellpadding="3" style="text-align:center;">
               <tr style="border: 1px solid black;font-size:10pt;text-align:center;"">
                  <td colspan="2" style="border-bottom: 1px solid black;">Situa��o Nova (Lei 12.772/12) e Portaria MEC 554/13)</td>
               </tr>
               <tr style="border: 1px solid black;font-size:10pt;">
                  <td width="35%">Classe</td>
                  <td width="65%">Denomina��o</td>
               </tr>
            </table>
          </td>
         <td style="border: 1px solid black;">Efeitos Financeiros</td>
        </tr> 

      [#list 1..(qtdServidores)?number as i]				
      <tr style="border: 1px solid black;font-size:10pt;">	
        <td width="10%" style="border: 1px solid black;">${i}</td>
        <td width="10%" style="border: 1px solid black;">${.vars[''siape''+i]!}</td>
        <td width="11%" style="border: 1px solid black;">23069.${.vars[''sequencial''+i]!}/${.vars[''ano''+i]!}-${.vars[''digito''+i]!}<br/>${.vars[''nome''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''retribuicao''+i]!}</td>
        <td width="11%" style="border: 1px solid black;">${.vars[''classe''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''denominacao''+i]!}</td>
        <td style="border: 1px solid black;">${.vars[''dt_efeitos''+i]!}</td>
      </tr>			
      [/#list]
  </table>  
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa texto_anexo=tabela_anexo/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/