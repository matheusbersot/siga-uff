SET DEFINE OFF;

--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Progressão por Capacitação Profissional ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1004,'Progressão por Capacitação Profissional','Progressão por Capacitação Profissional','template/freemarker', null, 6, 1004,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1004;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1004 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		<p style="text-align: justify;">Concessão de Progressão por Capacitação Profissional a servidores técnico-administrativos.</p>
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong> no uso de suas atribuições e tendo em vista o parecer emitido pela Divisão de Capacitação e Qualificação, da Coordenação de Pessoal Técnico-Administrativo, resolve:</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Conceder a PROGRESSÃO POR CAPACITAÇÃO PROFISSIONAL, nos termos do § 1° do artigo 10 da Lei n° 11.091, de 12 de janeiro de 2005, regulamentado pelo Decreto n° 5824, de 29 de junho de 2006, pela Portaria MEC n° 09, de 29 de junho de 2006, e pela Norma de Serviço de n° 580, de 10 de outubro de 2006, retificada pela norma de Serviço de nº 586, de 14 de dezembro de 2006, aos servidores relacionados no Anexo à presente Portaria, mantendo-se os níveis de classificação e observando-se a respectiva vigência, referente ao exercício financeiro do ano em curso. </p>
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

-- ######## PORTARIA: Progressão por Mérito Profissional ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1005,'Progressão por Mérito Profissional','Progressão por Mérito Profissional','template/freemarker', null, 6, 1005,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1005;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1005 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		<p style="text-align: justify;">Concessão de Progressão por Mérito Profissional a servidores técnico-administrativos.</p>
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições legais, estatutárias e regimentais,</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Considerando o disposto no § 2º do artigo 10 da Lei nº 11.091, de 12 de janeiro de 2005, alterado pelo artigo 15 da Lei 11.784, de 22 de setembro de 2008, assim como o que estabelece o inciso V do § 1º do art. 8º, do Decreto 5825, de 29 de junho de 2006 e a IS/PROGEPE nº 001 de 05/08/2013 em seu art. 10 §2º;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">RESOLVE:</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Conceder Progressão por Mérito Profissional aos servidores técnico-administrativos</strong> relacionados nos anexos à presente portaria, observando-se as respectivas vigências e efeitos financeiros.</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta Portaria entra em vigor na data de sua publicação.</p>
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/