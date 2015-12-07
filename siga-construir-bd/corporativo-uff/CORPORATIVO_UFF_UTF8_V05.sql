--DÁ PERMISSÃO A TODOS OS USUARIOS DO SIGA DE ASSINAR DIGITALMENTE OS DOCUMENTOS

INSERT INTO CP_CONFIGURACAO(ID_CONFIGURACAO, HIS_DT_INI, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO)
VALUES(CP_CONFIGURACAO_SEQ.nextval, SYSDATE , 1,200, (select ID_SERVICO from CP_SERVICO where SIGLA_SERVICO = 'SIGA-DOC-ASS'));

INSERT INTO CP_CONFIGURACAO(ID_CONFIGURACAO, HIS_DT_INI, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO)
VALUES(CP_CONFIGURACAO_SEQ.nextval, SYSDATE , 1,200, (select ID_SERVICO from CP_SERVICO where SIGLA_SERVICO = 'SIGA-DOC-ASS-EXT'));

INSERT INTO CP_CONFIGURACAO(ID_CONFIGURACAO, HIS_DT_INI, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO)
VALUES(CP_CONFIGURACAO_SEQ.nextval, SYSDATE , 1,200, (select ID_SERVICO from CP_SERVICO where SIGLA_SERVICO = 'SIGA-DOC-ASS-VBS'));

--DÁ PERMISSÃO DE ACESSO AOS RELATÓRIOS AO USUÁRIO ADMINISTRADOR 
--SIGA-GI-REL
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 23);

--SIGA-DOC-REL
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 284);

--SIGA-DOC-REL-FORMS
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 304);

--SIGA-DOC-REL-DATAS
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 305);

--SIGA-DOC-REL-SUBORD
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 306);


--DEPOIS DESSA PERMISSÃO DE ACESSO, USE O SIGA: ACESSE O MÓDULO DE DOCUMENTOS e SERÁ GERADO PELO SISTEMA
-- NOVOS RELATÓRIOS. ENTÃO EXECUTE A SQL ABAIXO:

--SIGA-DOC-REL-MVSUB
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 320);

--SIGA-DOC-REL-CRSUB
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 321);

--SIGA-DOC-REL-MOVLOT
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 322);

--SIGA-DOC-REL-MOVCAD
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 323);

--SIGA-DOC-REL-DSPEXP
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 324);

--SIGA-DOC-REL-DOCCRD
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 325);

--SIGA-DOC-REL-CLSD
INSERT INTO CP_CONFIGURACAO (ID_CONFIGURACAO, HIS_DT_INI, ID_PESSOA, ID_SIT_CONFIGURACAO, ID_TP_CONFIGURACAO, ID_SERVICO) 
VALUES (CP_CONFIGURACAO_SEQ.NEXTVAL, SYSDATE , 1, 1,200, 326);