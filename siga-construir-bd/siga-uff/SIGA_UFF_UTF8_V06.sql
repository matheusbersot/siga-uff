--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1001,'Portaria Genérica','Portaria Genérica','template/freemarker', null, 6, 1001,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1001;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1001 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
	[@memo var="texto_ementa" titulo="Ementa" colunas="63" linhas="3" desativado="${desabilitadoEdicao}"/]
	[/@grupo] 
    [@grupo titulo="Texto a ser inserido no corpo da portaria"]
	[@grupo]
	[@editor titulo="" var="texto_portaria" desativado="${desabilitadoEdicao}" /]
	[/@grupo]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento]
[@portaria texto=texto_portaria!"" ementa=texto_ementa!/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/