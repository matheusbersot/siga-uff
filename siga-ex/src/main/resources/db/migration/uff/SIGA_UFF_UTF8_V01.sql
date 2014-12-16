-- ALTER TABLE SIGA.EX_CLASSIFICACAO
ALTER TABLE EX_CLASSIFICACAO MODIFY (CODIFICACAO VARCHAR2(17 BYTE) );

-- REM INSERTING into SIGA.EX_CLASSIFICACAO

INSERT INTO SIGA.EX_CLASSIFICACAO(ID_CLASSIFICACAO,DESCR_CLASSIFICACAO,HIS_DT_INI,HIS_ATIVO,CODIFICACAO) VALUES(1,'ADMINISTRAÇÃO GERAL', SYSDATE ,1,'000.000');
INSERT INTO SIGA.EX_CLASSIFICACAO(ID_CLASSIFICACAO,DESCR_CLASSIFICACAO,HIS_DT_INI,HIS_ATIVO,CODIFICACAO) VALUES(2,'PESSOAL', SYSDATE ,1,'020.000');
INSERT INTO SIGA.EX_CLASSIFICACAO(ID_CLASSIFICACAO,DESCR_CLASSIFICACAO,HIS_DT_INI,HIS_ATIVO,CODIFICACAO) VALUES(3,'DIREITOS, OBRIGAÇÕES E VANTAGENS', SYSDATE ,1,'024.000');
INSERT INTO SIGA.EX_CLASSIFICACAO(ID_CLASSIFICACAO,DESCR_CLASSIFICACAO,HIS_DT_INI,HIS_ATIVO,CODIFICACAO) VALUES(4,'OUTROS DIREITOS, OBRIGAÇÕES E VANTAGENS', SYSDATE ,1,'024.900');
INSERT INTO SIGA.EX_CLASSIFICACAO(ID_CLASSIFICACAO,DESCR_CLASSIFICACAO,HIS_DT_INI,HIS_ATIVO,CODIFICACAO) VALUES(5,'AUXÍLIOS: ALIMENTAÇÃO/REFEIÇÃO,ASSISTÊNCIA PRÉ-ESCOLAR/CRECHE,FARDAMENTO/UNIFORME,MORADIA,VALE-TRANSPORTE', SYSDATE ,1,'024.920');

--REM INSERTING into SIGA.EX_VIA

-- COD_VIA é quantidade de VIAS
Insert into SIGA.EX_VIA(ID_VIA, ID_CLASSIFICACAO,ID_DESTINACAO,COD_VIA,ID_TEMPORAL_ARQ_COR, ID_TEMPORAL_ARQ_INT, ID_DESTINACAO_FINAL, HIS_ID_INI, HIS_DT_INI, HIS_ATIVO ) values(1, 5, 58, 1, 112, 96,1, 1, SYSDATE, 1);


--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PROCESSO ADMINISTRATIVO ###############	
Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1000,'Reembolso de Passagens','Reembolso de Passagens','template/freemarker', 5,55,1000,1);
	
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
