-------------------------------------------
--	SCRIPT:CONFIGURACAO
-------------------------------------------

--Alterações referentes a Configuração:
--   Corporativo (conforme hbm.xml) usava DT_INI_VIG_CONFIGURACAO 
--   e DT_FIM_VIG_CONFIGURACAO para guardar as informações do 
--   histórico. Após a alteração, as colunas usadas serão
--   HIS_DT_INI e HIS_DT_FIM, conforme o padrão. HIS_DT_INI
--   aproveitará a já existente e não utilizada DT_INI_REG.
--   E HIS_DT_FIM será criada. Após isso, os dados já existentes
--   nas DT_FIM_VIG_CONFIGURACAO e DT_INI_VIG_CONFIGURACAO serão
--   carregados nas novas colunas correspondentes. 

alter table CORPORATIVO.cp_configuracao rename column dt_ini_reg to his_dt_ini;
alter table CORPORATIVO.cp_configuracao add HIS_DT_FIM timestamp(6);
alter table CORPORATIVO.cp_configuracao add HIS_ID_INI NUMBER(19,0);
update CORPORATIVO.cp_configuracao set HIS_DT_INI = DT_INI_VIG_CONFIGURACAO;
update CORPORATIVO.cp_configuracao set HIS_DT_FIM = DT_FIM_VIG_CONFIGURACAO;
update CORPORATIVO.cp_configuracao set DT_INI_VIG_CONFIGURACAO = null;
update CORPORATIVO.cp_configuracao set DT_FIM_VIG_CONFIGURACAO = null;

/*CP_LOCALIDADE*/
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (1,'Angra dos Reis',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (2,'Arraial do Cabo',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (3,'Bom Jesus do Itabapoana',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (4,'Cabo Frio',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (5,'Campos dos Goytacazes',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (6,'Itaperuna',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (7,'Macaé',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (8,'Miracema',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (9,'Niterói',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (10,'Nova Friburgo',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (11,'Nova Iguaçu',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (12,'Pinheiral',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (13,'Quissamã',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (14,'Rio das Ostras',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (15,'Santo Antônio de Pádua',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (16,'São João De Meriti',19);
Insert into CORPORATIVO.CP_LOCALIDADE (ID_LOCALIDADE,NM_LOCALIDADE,ID_UF) values (17,'Volta Redonda',19);


-- - - - - - - - - - - - - - - - - - - - - - 
-- - - CP_COMPLEXO - - - - - - - - - - - - - 
-- - - - - - - - - - - - - - - - - - - - - - 

	CREATE TABLE CORPORATIVO.CP_COMPLEXO (
         ID_COMPLEXO INT,
         NOME_COMPLEXO VARCHAR(100),
         ID_LOCALIDADE,
         FOREIGN KEY (ID_LOCALIDADE) REFERENCES CORPORATIVO.CP_LOCALIDADE(ID_LOCALIDADE)
       );
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (1,'Angra dos Reis',1);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (2,'Arraial do Cabo',2);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (3,'Bom Jesus do Itabapoana',3);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (4,'Cabo Frio',4);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (5,'Campos dos Goytacazes',5);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (6,'Itaperuna',6);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (7,'Macaé',7);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (8,'Miracema',8);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (9,'Niterói',9);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (10,'Nova Friburgo',10);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (11,'Nova Iguaçu',11);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (12,'Pinheiral',12);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (13,'Quissamã',13);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (14,'Rio das Ostras',14);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (15,'Santo Antônio de Pádua',15);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (16,'São João De Meriti',16);
	insert into corporativo.cp_complexo (id_complexo, nome_complexo, id_localidade) values (17,'Volta Redonda',17);

	

