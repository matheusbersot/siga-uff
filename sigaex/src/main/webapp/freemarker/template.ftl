<META HTTP-EQUIV='Pragma' CONTENT='no-cache'">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
[@entrevista]
[@selecao var="catFuncionario" titulo="Categoria do Funcion�rio"
    reler=true opcoes="Servidor; Terceiro"/]



[@grupo]
[@texto titulo="Ano Posse/Contrata��o" var="ano" largura="4" maxcaracteres="4" obrigatorio="Sim" reler="ajax" idAjax="anoAjax" relertab="sim"/]
[/@grupo]
[@grupo depende="anoAjax"]
  [#if (ano!"") == ""]
   [@mensagem titulo="Alerta" texto="Ano deve ser preenchido." 
    vermelho=true/]
  [/#if]
[/@grupo]


[@lotacao titulo="Lota��o" var="lotacao" reler=true idAjax="lotacaoAjax"/]

[@br/]

[@data var="dataformat" titulo="Data de Formatura:" obrigatorio=true/]

[@br/]

[@memo var="informacoes" titulo="Dados sobre a Forma��o" colunas="63" linhas="3" /]

[@checkbox var="fazertrein" titulo="Deseja fazer treinamento?" default="Sim"/]

[@br/]

[@grupo titulo="Turno de Prefer�ncia"]
[@radio titulo="Manh�" var="radio_resp" valor="1" default="Manh�" /]
[@radio titulo="Tarde" var="radio_resp" valor="0" /]
[/@grupo]
[@br/]
[/@entrevista]