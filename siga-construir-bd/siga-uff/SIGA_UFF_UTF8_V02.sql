-- Configurações para criação de documentos

-- Niguém pode criar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 2, 2, sysdate);
-- Memorando
insert into siga.ex_configuracao (id_configuracao_ex, id_forma_doc) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 2);

-- Niguém pode criar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 2, 2, sysdate);
-- Anexo
insert into siga.ex_configuracao (id_configuracao_ex, id_forma_doc) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 60);

-- Niguém pode criar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 2, 2, sysdate);
-- Certidão
insert into siga.ex_configuracao (id_configuracao_ex, id_forma_doc) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 15);


-- Niguém pode criar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 2, 2, sysdate);
-- Documento Processo Administrativo
insert into siga.ex_configuracao (id_configuracao_ex, id_mod) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 544);