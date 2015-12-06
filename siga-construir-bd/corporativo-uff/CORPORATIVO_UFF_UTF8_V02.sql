-- Trigger no schema CORPORATIVO para criar uma tupla na tabela CP_IDENTIDADE com 
-- senha obtida da base IDUFF para cada tupla inserida na tabela DP_PESSOA.

SET DEFINE OFF


create or replace
TRIGGER cp_identidade_insert_trg
AFTER INSERT on dp_pessoa FOR EACH ROW
DECLARE
  var_identidade_id number(10);
  var_login varchar2(20);
  var_senha varchar2(100);
  var_data_inicio date;
  var_esta_ativo number(1);
  var_tipo_identidade_id number(5);
  var_orgao_usu_id number(5);
BEGIN

    -- obter último valor de id da tabela cp_identidade e a data corrente do sistema

    select cp_identidade_seq.nextval, current_date into var_identidade_id, var_data_inicio from dual;

    -- obter senha do iduff   
   BEGIN    
        --trocar iduff_desenv para iduff_producao quando for colocar a triguer na base de produção 
        select i.senhasha1 into var_senha from iduff_desenv.pub_identificacao i where i.ididentificacao = :new.ididentificacao_iduff;    
   EXCEPTION
       WHEN no_data_found then var_senha:='00';
   END;

    -- colocar 'FF' + CPF para gerar o login do usuario

    var_login := 'FF' || :new.cpf_pessoa;  

    -- obter orgao do usuario

    select id_orgao_usu into var_orgao_usu_id from cp_orgao_usuario where nm_orgao_usu = 'Universidade Federal Fluminense';

    -- obter situacao do usuario  (situacao = 1 = ativo)

    var_esta_ativo := 0;
    IF :new.situacao_funcional_pessoa = 1 THEN
         var_esta_ativo := 1;
    END IF;       

    -- obter tipo de identidade

    select id_tp_identidade into var_tipo_identidade_id from cp_tipo_identidade where desc_tp_identidade = 'Login e Senha';

    -- inserir dados na tabela identidade

    insert into cp_identidade(id_identidade, id_tp_identidade, id_pessoa, data_criacao_identidade, id_orgao_usu, login_identidade, senha_identidade, his_dt_ini, his_ativo, his_id_ini)
    values (var_identidade_id, var_tipo_identidade_id, :new.id_pessoa, var_data_inicio, var_orgao_usu_id , var_login, var_senha, var_data_inicio, var_esta_ativo, var_identidade_id);                

END;