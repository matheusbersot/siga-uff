-- INSERIR CAMPO IDIDENTIFICACAO_IDUFF
ALTER TABLE DP_PESSOA ADD (IDIDENTIFICACAO_IDUFF NUMBER(19));

-- AUMENTAR TAMANHO DO BAIRRO
ALTER TABLE DP_PESSOA MODIFY (BAIRRO_PESSOA VARCHAR2(70 BYTE) );

-- PERMISSAO PARA USUARIO CORPORATIVO VER TABELA DO IDUFF_PRODUCAO
-- ESSE COMANDO DEVE SER EXECUTADO NO BANCO IDUFF_PRODUCAO
GRANT SELECT ON IDUFF_PRODUCAO.PUB_IDENTIFICACAO TO "CORPORATIVO";


