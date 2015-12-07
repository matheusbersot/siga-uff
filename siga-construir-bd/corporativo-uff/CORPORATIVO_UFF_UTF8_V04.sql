-- EXECUTAR NA BASE DE PRODUÇÃO CORPORATIVO
GRANT SELECT ON CORPORATIVO.CP_IDENTIDADE TO "IDUFF_PRODUCAO";
GRANT SELECT ON CORPORATIVO.DP_PESSOA TO "IDUFF_PRODUCAO";
GRANT UPDATE ON CORPORATIVO.CP_IDENTIDADE TO "IDUFF_PRODUCAO";


-- TRIGGUER PARA ATUALIZAR SENHA DO IDUFF NA BASE DO SIGA

SET DEFINE OFF;

create or replace 
trigger cp_atualiza_senha_sigadoc_trg
AFTER UPDATE OF senhasha1 ON pub_identificacao FOR EACH ROW
DECLARE
  var_ididentificacao varchar2(20); 
BEGIN

    -- obter ididentificacao do  usuario

    var_ididentificacao := :old.ididentificacao;  

    -- atualizar senha nova na tabela cp_identidade do siga

    update corporativo.cp_identidade i set senha_identidade = :new.senhasha1 
    where id_pessoa in (select id_pessoa from corporativo.dp_pessoa p where p.ididentificacao_iduff = var_ididentificacao);

END;