--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PROCESSO ADMINISTRATIVO ###############	
Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1000,'Reembolso de Passagens','Reembolso de Passagens','template/freemarker', null ,55,1000,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1000;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1000 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]
[@entrevista]
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="1cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign var_texto_pad]

<table align="center" width="50%" border="1" cellspacing="1" bgcolor="#000000">
<tr>
	<td bgcolor="#FFFFFF" align="center">
        <p><br/><b>Data de abertura</b><br/><br/></p>
	</td>
	<td bgcolor="#FFFFFF" align="center">${doc.dtDocDDMMYYYY}</td>
</tr>
</table>

<br>
<br>

<table align="center" width="85%" border="1" cellspacing="1" bgcolor="#000000">
<tr>
	<td bgcolor="#FFFFFF" align="center"><br/><b>Assunto</b><br/><br/>
        </td>
</tr>
<tr>
	<td bgcolor="#FFFFFF" align="center"><br/>Reembolso de Passagem<br/><br/>
	</td>
</tr>
</table>

[/#assign]

[@pad txCorpo=var_texto_pad /]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/