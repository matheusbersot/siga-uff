SET DEFINE OFF;

----------------TAGS PARA MODELOS FREEMARKER UFF ---------------------

DECLARE
  dest_blob BLOB;
  src_blob BLOB;
  
BEGIN

select conteudo_blob_mod into dest_blob from CORPORATIVO.CP_MODELO where id_modelo = 1 for update;

src_blob := utl_raw.cast_to_raw(convert('
[#assign localidades = "Angra dos Reis;Arraial do Cabo;Bom Jesus do Itabapoana;Cabo Frio;Campos dos Goytacazes;Itaperuna;Macaé;Miracema;Niterói;Nova Friburgo;Nova Iguaçu;Pinheiral;Quissamã;Rio das Ostras;Santo Antônio de Pádua;São João De Meriti;Volta Redonda" /]
','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

commit;
END;
/