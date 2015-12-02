SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Homologação de estágio probatório (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1050,'Homologação de estágio probatório (Docente)','Homologação de estágio probatório (Docente)','template/freemarker', null, 6, 1050,1);
	
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
                [@texto titulo="Matrícula SIAPE" var="siape"+i largura="9" maxcaracteres="9"/]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]	
                [@texto titulo="Nome do Servidor" var="nome"+i largura="50" maxcaracteres="100"/]
            [/@grupo]
			[@grupo]
                [@data titulo="Data de Homologação" var="dtHomologacao"+i /]
            [/@grupo]
 			[@separador/]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Homologação do Estágio Probatório de Docente.
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribuições  legais, estatutárias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Homologar</strong> o Estágio Probatório dos Docentes relacionados no anexo a presente Portaria, nos termos da Lei 8.112 de 11 de Dezembro de 1990, Emenda Constitucional nº 19/98 e com base no Parecer AGU/MC nº 01/2004 publicado no D.O. de 16 de Julho de 2004, a Secretaria de Recursos Humanos do Ministério do Planejamento reconheceu como sendo de 03 anos o período de Estágio Probatório assim como o período para aquisição de estabilidade, e a Resolução CEP-UFF 219/2005 e <span style="font-style: italic;font-weight: bold;">Decisão CEP nº 731/13</span>.</p>
      <br/>
      <table width="100%" cellpadding="3" style="border: 1px solid black; border-collapse: collapse; text-align:center;">
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="4" style="border: 1px solid black;"><strong>RELAÇÃO DE PROFESSORES DA CARREIRA DE MAGISTÉRIO SUPERIOR COM DIREITO À HOMOLOGAÇÃO DE ESTÁGIO PROBATÓRIO</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:11pt;">
           <td colspan="4" style="border: 1px solid black;"><strong>ANEXO à Portaria n&ordm; ${doc.numExpediente!} , ${doc.dtD!} de ${doc.dtMMMM!} de ${doc.dtYYYY!}.</strong></td>
        </tr>
        <tr style="border: 1px solid black;font-size:10pt;">	
          <td width="10%" style="border: 1px solid black;">Ordem</td>
          <td width="15%" style="border: 1px solid black;">Mat. SIAPE</td>
          <td width="55%" style="border: 1px solid black;">Processo/Nome</td>
          <td width="20%" style="border: 1px solid black;">Homologação concedida em</td>
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


[@portaria texto=texto_portaria ementa=texto_ementa/]
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

-- ######## PORTARIA: Concessão de promoção e retribuição por titulação (Docente) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1051,'Concessão de progressão,promoção e ou retribuição por titulação (Docente)','Concessão de progressão,promoção e ou retribuição por titulação (Docente)','template/freemarker', null, 6, 1051,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1051;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1051 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concessão de Progressão, Promoção Funcional e&#47;ou Retribuição por Titulação de Docente.
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O <strong>Reitor</strong> da <strong>Universidade Federal Fluminense</strong> no uso de suas atribuições  legais, estatutárias e regimentais,</p>
  		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - Conceder Progressão, Promoção funcional e&#47;ou Retribuição por Titulação aos Docentes relacionados no anexo à presente Portaria, nos termos, da Lei nº 12.772/12, Portaria Ministerial nº 554/13, Lei nº 12.863/13, Lei n.º 11.344/06, da Resolução do CEP n.º 218/05,  Decreto Lei 94.664/87, Portaria MEC nº 475/87 e <span style="font-style: italic;font-weight: bold;">Decisão CEP nº 731/13</span>, observando-se a vigência e os efeitos financeiros decorrentes.</p>
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/