SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Chefe e Sub-Chefe de Departamento - Chapa Única e Lista Tríplice ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1010,'Designação de Chefe e Sub-Chefe de Departamento - Chapa Única e Lista Tríplice','Designação de Chefe e Sub-Chefe de Departamento - Chapa Única e Lista Tríplice','template/freemarker', null, 6, 1010,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1010;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1010 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="funcao" titulo="Função" opcoes="Chefe;Sub-Chefe" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="chapa" titulo="Chapa Única" default="Sim" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@checkbox var="lista_triplice" titulo="Lista Tríplice" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_gratificada" titulo="Função Gratificada" default="Sim" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]

[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que dispõem os parágrafos 1º e 2º do artigo 14, e o artigo 17 do Estatuto;</p>  
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> as prescrições contidas nos Artigos 33 e 37 do Regimento Geral da Universidade;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais - RGCE, aprovado pela Resolução nº 104, de 03 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado final da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha do Chefe e Subchefe do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}; e </p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong> [#if (lista_triplice!"") == "Sim"],dentre os eleitos através da lista tríplice,[/#if] <strong>${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para exercer, com mandato de 2 (dois) anos, a função de ${funcao!} do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}.</p> 
		[#if (funcao_gratificada!"") == "Sim"]
				<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação corresponde a função gratificada – código <strong>FG-1</strong>, a partir de sua publicação no Diário Oficial da União.</p> 
		[#else]
				<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação não corresponde a função gratificada.</p> 
		[/#if]
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Chefe de departamento para complemento de mandato ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1011,'Designação de Chefe de departamento para complemento de mandato','Designação de Chefe de departamento para complemento de mandato','template/freemarker', null, 6, 1011,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1011;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1011 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="num_portaria_inicial" titulo="Portaria Inicial"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_inicial" titulo="Data da Portaria Inicial:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_publicacao_dou" titulo="Data de Publicação em Diário Oficial da Portaria Inicial:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]

[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>  <strong>${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para exercer a função de <strong>Chefe</strong> do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}, complementando assim o mandato de 02 (dois) anos, iniciado pela Portaria nº. ${num_portaria_inicial}, de ${dt_portaria_inicial} e publicada no Diário Oficial da União de ${dt_publicacao_dou}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação corresponde a função gratificada – código <strong>FG-1</strong>, a partir de sua publicação no Diário Oficial da União.</p> 
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Chefe de departamento Pro Tempore###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1012,'Designação de Chefe de departamento Pro Tempore','Designação de Chefe de departamento Pro Tempore','template/freemarker', null, 6, 1012,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1012;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1012 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="qualidade" titulo="Qualidade" opcoes= "--;Decano;Decana" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta no processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>  <strong>${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para
		[#if (qualidade!"") == "--"]
		,  na qualidade de <strong>${qualidade!}</strong>,
		[/#if]
 		exercer <strong><i>pro tempore </i></strong>a função de <strong>Chefe</strong> do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação corresponde a função gratificada – código <strong>FG-1</strong>, a partir de sua publicação no Diário Oficial da União.</p> 
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Coordenador Decano ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1013,'Designação de Coordenador Decano','Designação de Coordenador Decano','template/freemarker', null, 6, 1013,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1013;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1013 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="funcao" titulo="Funcão" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="qualidade" titulo="Qualidade" opcoes= "Decano;Decana" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta no processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>  <strong>${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para exercer na qualidade de <strong>${qualidade!}</strong>, a função de <strong>${funcao!}</strong> do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º -  Esta designação corresponde a Função Comissionada de Coordenação de Curso – código FCC, a partir de sua publicação no Diário Oficial da União.</p> 
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Coordenador e Vice-Coordenador da Pós-Graduação ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1014,'Designação de Coordenador e Vice-Coordenador da Pós-Graduação','Designação de Coordenador e Vice-Coordenador da Pós-Graduação','template/freemarker', null, 6, 1014,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1014;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1014 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="tipo_especializacao" titulo="Tipo de Especialização"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso_especializacao" titulo="Curso de Especialização"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="nomen_coordenador" titulo="" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
		[@texto var="coordenador" titulo="Nome do Coordenador"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape_coordenador" titulo="Siape do Coordenador"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="nomem_vice_coordenador" titulo="" opcoes= "Vice-Coordenador;Vice-Coordenadora" desativado="${desabilitadoEdicao}"/]
		[@texto var="vice_coordenador" titulo="Nome do Vice-Coordenador"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape_vice_coordenador" titulo="Siape do Vice-Coordenador"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="efeitos_retroativos" titulo="Efeitos Retroativos" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta no processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>
		[#if (efeitos_retroativos!"") == "Sim"]
		, com efeitos retroativos a ${dt_efeitos_retroativos!},
		[/#if]
  		<strong>${coordenador!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape_coordenador!} e <strong>${vice_coordenador!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape_vice_coordenador!} pertencente ao Quadro Permanente da Universidade, para exercerem, por 4 (quatro) anos, as funções de ${nomem_coordenador!} e ${nomem_vice_coordenador!}, respectivamente, do  Curso de Pós-Graduação, nível Especialização, ${tipo_especializacao!} em ${curso_especialização!}, ${preposicao!} ${unidade!}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação não corresponde a Função Comissionada de Coordenação de Curso .</p> 
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Coordenador e Vice-Coordenador da Graduação ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1015,'Designação de Coordenador e Vice-Coordenador da Graduação','Designação de Coordenador e Vice-Coordenador da Graduação','template/freemarker', null, 6, 1015,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1015;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1015 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="funcao" titulo="Função" opcoes= "Coordenador;Coordenadora;Vice-Coordenador;Vice-Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_designacao" titulo="Data da designação" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_comissionada" titulo="Função Comissionada" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong>, o que dispõem os parágrafos 2º e 3º do artigo 38 do Estatuto;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> as prescrições contidas no Artigo 42 e 43 e seus parágrafos 2º e 3º do Regimento Geral da Universidade;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais – RGCE, aprovado pela Resolução nº 104 de 3 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha de Coordenador e Vice-Coordenador do ${curso!}, ${preposicao!} ${unidade!}; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong>, finalmente, o que mais consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar, a partir de ${dt_designacao}, ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} do Quadro Permanente da Universidade, para exercer, com mandato de 4 (quatro) anos, a função de ${funcao!} do ${curso!} , ${preposicao!} ${unidade!}.</p> 
		[#if (funcao_comissionada!"") == "Sim"]
			Art. 2º – Esta designação corresponde a Função Comissionada de Coordenação de Curso - código FCC.
		[#else]
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação não corresponde a Função Comissionada de Coordenação de Curso .</p> 		
		[/#if]
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Coordenador da Graduação para Complemento de Mandato ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1016,'Designação de Coordenador da Graduação para Complemento de Mandato','Designação de Coordenador da Graduação para Complemento de Mandato','template/freemarker', null, 6, 1016,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1016;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1016 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="funcao" titulo="Função" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="num_portaria_inicial" titulo="Portaria Inicial"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_inicial" titulo="Data da Portaria Inicial:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_publicacao_dou" titulo="Data de Publicação em Diário Oficial da Portaria Inicial:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} do Quadro Permanente da Universidade, para exercer a função de ${funcao!} do ${curso!} , ${preposicao!} ${unidade!}, complementando, assim, o mandato de 04 (quatro) anos iniciado pela Portaria nº ${num_portaria_inicial!} de ${dt_portaria_inicial!} e publicada no Diário Oficial da União de ${dt_publicacao_dou}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação corresponde a Função Comissionada de Coordenação de Curso - código <strong>FCC</strong>, a partir de sua publicação no Diário Oficial da União.</p> 		
		
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Coordenador da Pós-Graduação Pro Tempore ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1017,'Designação de Coordenador da Pós-Graduação Pro Tempore','Designação de Coordenador da Pós-Graduação Pro Tempore','template/freemarker', null, 6, 1017,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1017;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1017 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="funcao" titulo="Função" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]

	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento dos Cursos de Pós-Graduação “Lato Sensu”, aprovado pela Resolução nº. 150 de 28 de abril de 2010, do Conselho de Ensino e Pesquisa, bem como a Resolução nº 200 de 14 de maio de 2014, do mesmo Conselho, que altera o Artigo 11, § 1º e o Artigo 22, § 2º da Resolução CEP nº 150/2010; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>,<i> com efeitos retroativos a </i> ${dt_efeitos_retroativos!}, <strong>${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} do Quadro Permanente desta Universidade, para exercer, <strong><i>pro tempore</i></strong>, a função de <strong>${funcao!}</strong> do <strong>Curso de Pós-Graduação</strong> ${curso!} , ${preposicao!} ${unidade!}, complementando, assim, o mandato de 04 (quatro) anos iniciado pela Portaria nº ${num_portaria_inicial!} de ${dt_portaria_inicial!} e publicada no Diário Oficial da União de ${dt_publicacao_dou}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta designação não corresponde a Função Comissionada de Coordenação de Curso . </p> 
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Designação de Coordenador e Diretor Acadêmico ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1018,'Designação de Coordenador e Diretor Acadêmico','Designação de Coordenador e Diretor Acadêmico','template/freemarker', null, 6, 1018,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1018;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1018 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Designação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="nomen_diretor" titulo="Nomenclatura do Diretor" opcoes= "Diretor;Diretora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="diretor" titulo="Diretor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape_diretor" titulo="Siape do Diretor"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="cargo_diretor" titulo="Cargo do Diretor"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="nomen_coordenador" titulo="Nomenclatura do Coordenador" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="coordenador" titulo="Coordenador"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape_coordenador" titulo="Siape do Coordenador"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao_setor" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="setor" titulo="Setor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao_unidade" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]

	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais – RGCE, aprovado pela Resolução nº 104, de 03 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado final da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha do Diretor e Coordenador Acadêmico da ${setor!}; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>dentre os eleitos através da lista tríplice, <strong>${diretor!?upper_case}</strong, ${cargo_diretor!}, matrícula SIAPE nº ${siape_diretor!} e <strong>${coordenador!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº ${siape_coordenador!}, ambos do Quadro Permanente da Universidade, para exercerem, por um mandato de 04 (quatro) anos, respectivamente, as funções de <strong>${nomen_diretor!} e ${nomen_coordenador!} Acadêmico ${preposição_setor!} ${setor!}</strong>, ${preposição_unidade!} ${unidade}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação não corresponde a função gratificada ou a cargo de direção.</p> 
	
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Atribuição de Coordenador de Pós-Graduação ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1019,'Atribuição de Coordenador de Pós-Graduação','Atribuição de Coordenador de Pós-Graduação','template/freemarker', null, 6, 1019,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1019;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1019 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Atribuição"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="nomenclatura" titulo="Nomenclatura do Coordenador" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="coordenador" titulo="Coordenador"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="portaria_designacao" titulo="Portaria de designação"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de designação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que mais consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º -  <strong>Atribuir</strong> a Função Comissionada  de Coordenação de Curso - FCC ao titular da função de <strong>Coordenador do Programa de Pós-Graduação em</strong> ${curso!}, ${coordenador!}, Professor do Magistério Superior, matrícula SIAPE nº ${siape!}, designada pela Portaria nº ${portaria_designacao!}, de ${dt_portaria_designacao!}.</p> 
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Nomeação de Diretor Decano de unidade ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1020,'Nomeação de Diretor Decano de unidade','Nomeação de Diretor Decano de unidade','template/freemarker', null, 6, 1020,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1020;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1020 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Nomeação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="nomenclatura" titulo="Nomenclatura do Diretor" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="diretor" titulo="Diretor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="cargo" titulo="Cargo" opcoes= "Diretor;Diretora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="qualidade" titulo="Qualidade" opcoes= "Decano;Decana" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="efeitos_retroativos" titulo="Efeitos Retroativos" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="nomeacao" titulo="Data de Nomeação" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="dt_nomeacao" titulo="Data" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="homolog_consulta" titulo="Válido até a homologação da consulta eleitoral" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="publicacao_dou" titulo="Válido a partir da publicação em Diário Oficial" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Nomear</strong>,
		[#if (efeitos_retroativos!"") == "Sim"]
			 com efeitos retroativos a ${dt_efeitos_retroativos!} , 
		[/#if]
		[#if (nomeacao!"") == "Sim"]
			 a partir de ${dt_nomeacao!},  
		[/#if]
 		<strong>${diretor!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº ${siape!}, do Quadro Permanente da Universidade, para, na qualidade de ${qualidade!}, exercer 
		[#if (pro_tempore!"") == "Sim"]
			 <strong><i>pro tempore </i></strong> 
		[/#if]
		o cargo de ${cargo!} ${preposicao!} ${unidade!} 
		[#if (homolog_consulta!"") == "Sim"]
			  , até a homologação final do resultado da Consulta Eleitoral  
		[/#if]
		.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta nomeação corresponde a Cargo de Direção – código <strong>CD-3</strong> 
		[#if (publicacao_dou!"") == "Sim"]
		, a partir de sua publicação no Diário Oficial da União   
		[/#if] 
		.</p>
  		
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Nomeação de Diretor e Vice-Diretor de unidade ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1021,'Nomeação de Diretor e Vice-Diretor de unidade','Nomeação de Diretor e Vice-Diretor de unidade','template/freemarker', null, 6, 1021,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1021;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1021 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Nomeação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="cargo" titulo="Cargo" opcoes= "Diretor;Diretora;Vice-Diretor;Vice-Diretora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="nomeado" titulo="Nomeado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_nomeacao" titulo="Data de nomeação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="direcao" titulo="Cargo de Direção" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o disposto no art.1º, IV, da Lei nº 9.192 de 21.12.95 e o constante no parágrafo 5º do art. 1º e, no art. 5º, caput, do Decreto nº 1.916, de 23.05.96;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais – RGCE, aprovado pela Resolução nº 104, de 03 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado final da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha do Diretor e Vice-Diretor ${preposicao!} <strong>${unidade!}</strong>; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong>, finalmente, o que consta do Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º -  <strong>Nomear a partir de ${dt_nomeacao!}</strong>, dentre os eleitos através da lista tríplice, <strong>${nomeado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, para exercer, com mandato de 04 (quatro) anos, o cargo de <strong>${cargo!} ${preposicao!} ${unidade!}</strong>.</p> 
		[#if (direcao!"") == "Sim"]
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta nomeação corresponde a Cargo de Direção – código <strong>CD-3</strong.</p> 
		[#else]
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º – Esta nomeação não corresponde a Cargo de Direção.</p> 
		[/#if] 
  		
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Dispensa de Chefe ou Sub-Chefe de Departamento ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1022,'Dispensa de Chefe ou Sub-Chefe de Departamento','Dispensa de Chefe ou Sub-Chefe de Departamento','template/freemarker', null, 6, 1022,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1022;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1022 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Dispensa"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="função" titulo="Função" opcoes= "Chefe;Sub-Chefe" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="dispensado" titulo="Nome do Servidor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="portaria_designacao" titulo="Portaria de Designação"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de Designação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pedido" titulo="A pedido" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="publicacao_dou" titulo="Publicado em Diário Oficial" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="dt_publicacao_dou" titulo="Data da Publicação em Diário Oficial" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_gratificada" titulo="Função Gratificada" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º – Dispensar [#if (pedido!"") == "Sim"], a pedido , [/#if] <strong>${dispensado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!}, pertencente ao Quadro Permanente da Universidade, da função de ${funcao!} [#if (pro_tempore!"") == "Sim"] <strong><i>“pro tempore”</i></strong> [/#if] do <strong>${departamento!}</strong>, ${preposicao!} ${unidade!}, designada pela Portaria nº. ${portaria_designacao!}, de ${dt_portaria_designacao!} [#if (publicacao_dou!"") == "Sim"], publicada no DOU de ${dt_publicacao_dou!} [/#if].[#if (funcao_gratificada!"") == "Sim"] <strong>FG-1 </strong>>.[/#if]</p> 
  		
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Dispensa de Chefe de Departamento por motivo de Falecimento ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1023,'Dispensa de Chefe de Departamento por motivo de Falecimento','Dispensa de Chefe de Departamento por motivo de Falecimento','template/freemarker', null, 6, 1023,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1023;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1023 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Dispensa"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="dispensado" titulo="Nome do Servidor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="portaria_designacao" titulo="Portaria de Designação"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de Designação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_publicacao_dou" titulo="Data da Publicação em Diário Oficial" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_cessamento_portaria_designacao" titulo="Data de Cessamento da Portaria de Designação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º – <strong>Declarar cessado, a partir de ${dt_cessamento_portaria_designacao!}</strong>, os efeitos da Portaria nº ${portaria_designacao!}, datada de ${dt_portaria_designacao}, publicada no D.O.U de ${dt_publicacao_dou}, por meio da qual ${dispensado!?upper_case}, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, fora designado para a função gratificada <strong>(FG-1)</strong> de <strong>Chefe</strong> [#if (pro_tempore!"") == "Sim"] <strong><i>“pro tempore”</i></strong> [/#if] do <strong>${departamento!}</strong>, ${preposicao!} ${unidade!}, <strong>por motivo de seu falecimento</strong>. </p> 
  		
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Dispensa de Coordenador e Vice-Coordenador da Graduação e Pós-Graduação ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1024,'Dispensa de Coordenador e Vice-Coordenador da Graduação e Pós-Graduação','Dispensa de Coordenador e Vice-Coordenador da Graduação e Pós-Graduação','template/freemarker', null, 6, 1024,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1024;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1024 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Dispensa"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="dispensado" titulo="Nome do Servidor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="funcao" titulo="Função" opcoes= "Coordenador;Coordenadora;Vice-Coordenador;Vice-Coordenadora" desativado="${desabilitadoEdicao}"/]
	[@grupo]
	[@grupo]
		[@checkbox var="qualidade" titulo="Qualidade" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@selecao var="desc_qualidade" titulo="Descrição da qualidade" opcoes= "Decano;Decana" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
		[@texto var="tipo_curso" titulo="Tipo de Curso"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="nivel" titulo="Nível" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="desc_nivel" titulo="Descrição do Nível" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="portaria_designacao" titulo="Portaria de Designação"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de Designação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="publicacao_dou" titulo="Publicado em Diário Oficial" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="dt_publicacao_dou" titulo="Data da Publicação em Diário Oficial" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="efeitos_retroativos" titulo="Efeitos Retroativos" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pedido" titulo="A pedido" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="entre_membros" titulo="Entre os membros do colegiado" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_comissionada" titulo="Função Comissionada" default="Não" obrigatorio="true" desativado="${desabilitadoEdicao}/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no Processo nº ${num_processo!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º – Dispensar [#if (pedido!"") == "Sim"] , a pedido, [/#if] [#if (efeitos_retroativos!"") == "Sim"] , com efeitos retroativos a ${dt_efeitos_retroativos!}, [/#if] [#if (membros_colegiado!"") == "Sim"] , dentre os membros do Colegiado, [/#if] <strong>${dispensado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº ${siape!}, pertencente ao Quadro Permanente desta Universidade [#if (qualidade!"") == "Sim"], na qualidade de <strong>${desc_qualidade!}</strong>, [/#if] da função de <strong>${funcao!}</strong> [#if (pro_tempore!"") == "Sim"] <strong><i>pro tempore</i></strong> [/#if] do <strong>${tipo_curso!} ${curso!}</strong>, [#if (nivel!"") == "Sim"] <strong>${desc_nivel!}</strong> [/#if] ${preposicao!} ${unidade!}, designada pela Portaria nº. ${portaria_designacao!} de ${dt_portaria_designacao} [#if (publicacao_dou!"") == "Sim"] , publicada no D.O.U de ${dt_publicacao_dou} [/#if]. [#if (funcao_comissionada!"") == "Sim"]<strong>FCC</strong>.[/#if]</p> 
  		
[/#assign]


[@portaria texto=texto_portaria ementa=""/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/