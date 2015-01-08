-- Configurações para exibição de botões

-- Niguém pode movimentar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 1, 2, sysdate);
-- Agendamento de Publicação no DJE
insert into siga.ex_configuracao (id_configuracao_ex, id_tp_mov) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 32);

-- Niguém pode movimentar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 1, 2, sysdate);
-- Solicitação de Publicação no Boletim
insert into siga.ex_configuracao (id_configuracao_ex, id_tp_mov) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 36);

-- Niguém pode movimentar:
insert into corporativo.cp_configuracao (id_configuracao, id_tp_configuracao, id_sit_configuracao, his_dt_ini) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.nextval, 1, 2, sysdate);
-- Solicitação de Publicação no DJE
insert into siga.ex_configuracao (id_configuracao_ex, id_tp_mov) values (CORPORATIVO.CP_CONFIGURACAO_SEQ.currval, 38);

-- Default para Tipo Configuracao  = Pode criar documento filho
UPDATE "CORPORATIVO"."CP_TIPO_CONFIGURACAO" SET ID_SIT_CONFIGURACAO = '2' WHERE ID_TP_CONFIGURACAO = 24; 