SET DEFINE OFF;

ALTER SESSION SET CURRENT_SCHEMA=siga;

DECLARE
dest_blob_ex_mod BLOB;
src_blob_ex_mod BLOB;

BEGIN

update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 26;
select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 26 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[@entrevista]
[@grupo titulo="Texto a ser inserido no corpo do memorando"]
[@grupo]
[@editor titulo="" var="texto_memorando" /]
[/@grupo]
[/@grupo]
[@grupo]
[@selecao titulo="Tamanho da letra" var="tamanhoLetra" opcoes="Normal;Pequeno;Grande" /]
[/@grupo]
[@grupo]
[@selecao titulo="Fecho" var="fecho" opcoes="Atenciosamente;Cordialmente;Respeitosamente" /]
[/@grupo]
[/@entrevista]

[@documento]
[@memorando texto=texto_memorando! fecho=(fecho!)+"," tamanhoLetra=tamanhoLetra! /]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 665;
select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 665 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[@documento margemDireita="3cm"]
[#assign tl="11pt"/]
[@estiloBrasaoCentralizado tipo="DESPACHO" tamanhoLetra=tl formatarOrgao=true numeracaoCentralizada=false dataAntesDaAssinatura =true]
<div style="font-family: Arial; font-size: ${tl};">
Referência: ${doc.codigo} de ${doc.dtD} de ${doc.dtMMMM} de ${doc.dtYYYY}[#if doc.lotaTitular??] - ${(doc.lotaTitular.descricao)!}[/#if].<br/>
Assunto: ${(doc.exClassificacao.descrClassificacao)!}
</div>

<div style="font-family: Arial; font-size: ${tl};">
[#if mov.lotaResp?? && (mov.lotaResp.idLotacaoIni != mov.lotaCadastrante.idLotacaoIni)]
<p style="TEXT-INDENT: 0cm">
<span style="font-size: ${tl}">À ${(mov.lotaResp.descricao)!},</span>
</p>
[/#if]
[#if despachoTexto??]
<p style="TEXT-INDENT: 2cm"><span style="font-size: ${tl}">${despachoTexto}</span></p>
[/#if]
${despachoHtml!}
</div>
[/@estiloBrasaoCentralizado]
[/@documento]

','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;