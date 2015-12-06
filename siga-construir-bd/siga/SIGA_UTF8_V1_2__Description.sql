SET DEFINE OFF;

ALTER SESSION SET CURRENT_SCHEMA=siga;

--------------------------------------------------------
--  DDL for Trigger EX_CLASSIFICACAO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_CLASSIFICACAO_INSERT_TRG" BEFORE INSERT 
ON siga.EX_CLASSIFICACAO 
FOR EACH ROW 
begin
if :new.ID_CLASSIFICACAO is null then
select EX_CLASSIFICACAO_SEQ.nextval into :new.ID_CLASSIFICACAO from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_CLASSIFICACAO_INSERT_TRG" ENABLE;

--------------------------------------------------------
--  DDL for Trigger EX_COMPETENCIA_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_COMPETENCIA_INSERT_TRG" BEFORE INSERT
ON SIGA.EX_Competencia
FOR EACH ROW
begin
if :new.ID_Competencia is null then
select EX_Competencia_SEQ.nextval into :new.ID_Competencia from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_COMPETENCIA_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_DOCUMENTO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_DOCUMENTO_INSERT_TRG" BEFORE INSERT ON "EX_DOCUMENTO" FOR EACH ROW 
begin
if :new.ID_DOC is null then
select EX_DOCUMENTO_SEQ.nextval into :new.ID_DOC from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_DOCUMENTO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_ESTADO_DOC_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_ESTADO_DOC_INSERT_TRG" before insert
on EX_ESTADO_DOC
for each row
begin
if :new.ID_ESTADO_DOC is null then
select EX_ESTADO_DOC_SEQ.nextval into :new.ID_ESTADO_DOC from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_ESTADO_DOC_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_FORMA_DOCUMENTO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_FORMA_DOCUMENTO_INSERT_TRG" before insert
on EX_FORMA_DOCUMENTO
for each row
begin
if :new.id_forMa_doc is null then
select EX_FORMA_DOCUMENTO_SEQ.nextval into :new.id_forMa_doc from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_FORMA_DOCUMENTO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_MODELO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_MODELO_INSERT_TRG" before insert
on EX_modelo
for each row
begin
if :new.ID_MOD is null then
select EX_modelo_SEQ.nextval into :new.ID_MOD from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_MODELO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_MOVIMENTACAO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_MOVIMENTACAO_INSERT_TRG" before insert
on EX_MOVIMENTACAO
for each row
begin
if :new.ID_MOV is null then
select EX_MOVIMENTACAO_SEQ.nextval into :new.ID_MOV from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_MOVIMENTACAO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_PREENCHIMENTO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_PREENCHIMENTO_INSERT_TRG" BEFORE INSERT
ON SIGA.EX_PREENCHIMENTO
FOR EACH ROW
begin
if :new.ID_PREENCHIMENTO is null then
select EX_PREENCHIMENTO_SEQ.nextval into :new.ID_PREENCHIMENTO from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_PREENCHIMENTO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_TEMPORALIDADE_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_TEMPORALIDADE_INSERT_TRG" before insert
on EX_TEMPORALIDADE
for each row
begin
if :new.ID_TEMPORALIDADE is null then
select EX_TEMPORALIDADE_SEQ.nextval into :new.ID_TEMPORALIDADE from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_TEMPORALIDADE_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_TIPO_DESPACHO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_TIPO_DESPACHO_INSERT_TRG" before insert
on EX_TIPO_DESPACHO
for each row
begin
if :new.ID_TP_DESPACHO is null then
select EX_TIPO_DESPACHO_SEQ.nextval into :new.ID_TP_DESPACHO from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_TIPO_DESPACHO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_TIPO_DESTINACAO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_TIPO_DESTINACAO_INSERT_TRG" before insert
on EX_TIPO_DESTINACAO
for each row
begin
if :new.ID_TP_DESTINACAO is null then
select EX_TIPO_DESTINACAO_SEQ.nextval into :new.ID_TP_DESTINACAO from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_TIPO_DESTINACAO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_TIPO_DOCUMENTO_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_TIPO_DOCUMENTO_INSERT_TRG" before insert
on EX_TIPO_DOCUMENTO
for each row
begin
if :new.ID_TP_DOC is null then
select EX_TIPO_DOCUMENTO_SEQ.nextval into :new.ID_TP_DOC from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_TIPO_DOCUMENTO_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_TP_MOV_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_TP_MOV_INSERT_TRG" before insert
on EX_TIPO_MOVIMENTACAO
for each row
begin
if :new.ID_TP_MOV is null then
select EX_TIPO_MOVIMENTACAO_SEQ.nextval into :new.ID_TP_MOV from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_TP_MOV_INSERT_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EX_VIA_INSERT_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SIGA"."EX_VIA_INSERT_TRG" before insert
on EX_VIA
for each row
begin
if :new.ID_VIA is null then
select EX_VIA_SEQ.nextval into :new.ID_VIA from dual;
end if;
end;
/
ALTER TRIGGER "SIGA"."EX_VIA_INSERT_TRG" ENABLE;

