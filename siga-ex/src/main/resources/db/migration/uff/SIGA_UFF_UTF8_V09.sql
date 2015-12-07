SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

	DECLARE
	  dest_blob_ex_mod BLOB;
	  src_blob_ex_mod BLOB;
	  
	BEGIN
	
	-- ######## PORTARIA Designação (Chefe ou Sub-Chefe de Departamento - Chapa Única e Lista Tríplice) ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1010,'Designação (Chefe e Sub-Chefe de Departamento - Chapa Única e Lista Tríplice)','Designação (Chefe e Sub-Chefe de Departamento - Chapa Única e Lista Tríplice)','template/freemarker', null, 6, 1010,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1010;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1010 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]
		[@grupo]
			[@texto var="num_portaria" titulo="Portaria de Designação" largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]
	    [@grupo]
			[@mensagem titulo="Nº do Processo" texto="23069."/]
			[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[@mensagem titulo="" texto="/"/]
			[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[@mensagem titulo="" texto="-"/]
			[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@texto var="departamento" titulo="Departamento" largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@selecao var="preposicao" titulo="" opcoes="da;do" desativado="${desabilitadoEdicao}"/]
			[@texto var="unidade" titulo="Unidade" largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@texto var="designado" titulo="Designado" largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@selecao var="tipo_funcao" titulo="Função" opcoes="Chefe;Sub-Chefe" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[/@grupo]
		[@grupo]
			[@checkbox var="chapa" titulo="Chapa Única" default="Sim" /]
			[@checkbox var="lista_triplice" titulo="Lista Tríplice" default="Não"/]
		[/@grupo]
		[@grupo]
			[@checkbox var="funcao_gratificada" titulo="Função Gratificada" default="Sim" /]
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
			<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
			<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong> [#if (lista_triplice!"") == "Sim"],dentre os eleitos através da lista tríplice,[/#if] <strong> ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para exercer, com mandato de 2 (dois) anos, a função de ${tipo_funcao!} do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}.</p> 
			[#if (funcao_gratificada!"") == "Sim"]
					<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação corresponde a função gratificada - código <strong>FG-1</strong>, a partir de sua publicação no Diário Oficial da União.</p> 
			[#else]
					<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação não corresponde a função gratificada.</p> 
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

-- ######## Designação (Chefe de Departamento - Complemento de mandato) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1011,'Designação (Chefe de Departamento - Complemento de mandato)','Designação (Chefe de Departamento - Complemento de mandato)','template/freemarker', null, 6, 1011,1);
	
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
    [/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento" largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Nome do Servidor" largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar, ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para exercer a função de <strong>Chefe</strong> do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}, complementando assim o mandato de 02 (dois) anos, iniciado pela Portaria nº. ${num_portaria_inicial}, de ${dt_portaria_inicial} e publicada no Diário Oficial da União de ${dt_publicacao_dou}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação corresponde a função gratificada - código <strong>FG-1</strong>, a partir de sua publicação no Diário Oficial da União.</p> 
	
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

-- ######## PORTARIA Designação (Chefe de Departamento Pró Tempore) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1012,'Designação (Chefe de Departamento Pró Tempore)','Designação (Chefe de Departamento Pró Tempore)','template/freemarker', null, 6, 1012,1);
	
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta no processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para
		[#if (qualidade!"") != "--"]
		,  na qualidade de <strong>${qualidade!}</strong>,
		[/#if]
 		exercer <strong><i>pro tempore </i></strong>a função de <strong>Chefe</strong> do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação corresponde a função gratificada - código <strong>FG-1</strong>, a partir de sua publicação no Diário Oficial da União.</p> 
	
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

-- ######## PORTARIA Designação (Coordenador de Graduação - Decano)  ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1013,'Designação (Coordenador de Unidade - Decano)','Designação (Coordenador de Unidade - Decano)','template/freemarker', null, 6, 1013,1);
	
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
		[@selecao var="tipo_funcao" titulo="Funcão" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="qualidade" titulo="Qualidade" opcoes= "Decano;Decana" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta no processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} pertencente ao Quadro Permanente da Universidade, para exercer na qualidade de <strong>${qualidade!}</strong>, a função de <strong>${tipo_funcao!}</strong> do <strong>${departamento!}<strong/>, ${preposicao!} ${unidade!}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º -  Esta designação corresponde a Função Comissionada de Coordenação de Curso - código FCC, a partir de sua publicação no Diário Oficial da União.</p> 
	
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

-- ######## PORTARIA Designação (Coordenador e Vice-Coordenador de Pós-Graduação) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1014,'Designação (Coordenador e Vice-Coordenador de Pós-Graduação)','Designação (Coordenador e Vice-Coordenador de Pós-Graduação)','template/freemarker', null, 6, 1014,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1014;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1014 for update;
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
		[@checkbox var="efeitos_retroativos" titulo="Efeitos Retroativos" default="Não"/]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta no processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong>
		[#if (efeitos_retroativos!"") == "Sim"]
		, com efeitos retroativos a ${dt_efeitos_retroativos!},
		[/#if]
  		<strong> ${coordenador!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape_coordenador!} e <strong>${vice_coordenador!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape_vice_coordenador!} pertencente ao Quadro Permanente da Universidade, para exercerem, por 4 (quatro) anos, as funções de ${nomem_coordenador!} e ${nomem_vice_coordenador!}, respectivamente, do  Curso de Pós-Graduação, nível Especialização, ${tipo_especializacao!} em ${curso_especialização!}, ${preposicao!} ${unidade!}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação não corresponde a Função Comissionada de Coordenação de Curso .</p> 
	
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

-- ######## PORTARIA Designação (Coordenador ou Vice-Coordenador de Graduação) ###############	

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
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
    [/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="tipo_funcao" titulo="Função" opcoes= "Coordenador;Coordenadora;Vice-Coordenador;Vice-Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_designacao" titulo="Data da designação:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_comissionada" titulo="Função Comissionada" default="Não"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong>, o que dispõem os parágrafos 2º e 3º do artigo 38 do Estatuto;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> as prescrições contidas no Artigo 42 e 43 e seus parágrafos 2º e 3º do Regimento Geral da Universidade;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais - RGCE, aprovado pela Resolução nº 104 de 3 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha de Coordenador e Vice-Coordenador do ${curso!}, ${preposicao!} ${unidade!}; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong>, finalmente, o que mais consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar, a partir de ${dt_designacao}, ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} do Quadro Permanente da Universidade, para exercer, com mandato de 4 (quatro) anos, a função de ${tipo_funcao!} do ${curso!} , ${preposicao!} ${unidade!}.</p> 
		[#if (funcao_comissionada!"") == "Sim"]
			Art. 2º - Esta designação corresponde a Função Comissionada de Coordenação de Curso - código FCC.
		[#else]
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação não corresponde a Função Comissionada de Coordenação de Curso .</p> 		
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

-- ######## PORTARIA Designação (Coordenador de Graduação - Complemento de Mandato) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1016,'Designação (Coordenador de Graduação - Complemento de Mandato)','Designação (Coordenador de Graduação - Complemento de Mandato)','template/freemarker', null, 6, 1016,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1016;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1016 for update;
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
    [/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="tipo_funcao" titulo="Função" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
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
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} do Quadro Permanente da Universidade, para exercer a função de ${tipo_funcao!} do ${curso!} , ${preposicao!} ${unidade!}, complementando, assim, o mandato de 04 (quatro) anos iniciado pela Portaria nº ${num_portaria_inicial!} de ${dt_portaria_inicial!} e publicada no Diário Oficial da União de ${dt_publicacao_dou}.</p> 
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

-- ######## PORTARIA Designação (Coordenador de Pós-Graduação Pró Tempore) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1017,'Designação (Coordenador de Pós-Graduação Pró Tempore)','Designação (Coordenador de Pós-Graduação Pró Tempore)','template/freemarker', null, 6, 1017,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1017;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1017 for update;
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
    [/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="tipo_funcao" titulo="Função" opcoes= "Coordenador;Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_publicacao_dou" titulo="Data de publicação em Diário Oficial:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento dos Cursos de Pós-Graduação “Lato Sensu”, aprovado pela Resolução nº. 150 de 28 de abril de 2010, do Conselho de Ensino e Pesquisa, bem como a Resolução nº 200 de 14 de maio de 2014, do mesmo Conselho, que altera o Artigo 11, § 1º e o Artigo 22, § 2º da Resolução CEP nº 150/2010; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar </strong>,<i> com efeitos retroativos a </i> ${dt_efeitos_retroativos!}, <strong> ${designado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!} do Quadro Permanente desta Universidade, para exercer, <strong><i>pro tempore</i></strong>, a função de <strong>${tipo_funcao!}</strong> do <strong>Curso de Pós-Graduação</strong> ${curso!} , ${preposicao!} ${unidade!}, complementando, assim, o mandato de 04 (quatro) anos iniciado pela Portaria nº ${num_portaria_inicial!} de ${dt_portaria_inicial!} e publicada no Diário Oficial da União de ${dt_publicacao_dou}.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta designação não corresponde a Função Comissionada de Coordenação de Curso . </p> 
	
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

-- ######## PORTARIA Designação (Coordenador e Diretor de Unidade) ###############	

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
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais - RGCE, aprovado pela Resolução nº 104, de 03 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado final da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha do Diretor e Coordenador Acadêmico da ${setor!}; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Designar</strong> dentre os eleitos através da lista tríplice, <strong>${diretor!?upper_case}</strong> , ${cargo_diretor!}, matrícula SIAPE nº ${siape_diretor!} e <strong>${coordenador!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº ${siape_coordenador!}, ambos do Quadro Permanente da Universidade, para exercerem, por um mandato de 04 (quatro) anos, respectivamente, as funções de <strong>${nomen_diretor!} e ${nomen_coordenador!} Acadêmico ${preposição_setor!} ${setor!}</strong>, ${preposição_unidade!} ${unidade}.</p> 
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

-- ######## PORTARIA Atribuição de função comissionada (Coordenador de Pós-Graduação) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1019,'Atribuição de função comissionada (Coordenador de Pós-Graduação)','Atribuição de função comissionada (Coordenador de Pós-Graduação)','template/freemarker', null, 6, 1019,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1019;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1019 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Atribuição"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de designação:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que mais consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
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

-- ######## PORTARIA Nomeação (Diretor de Unidade - Decano) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1020,'Nomeação (Diretor de Unidade - Decano)','Nomeação (Diretor de Unidade - Decano)','template/freemarker', null, 6, 1020,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1020;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1020 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Nomeação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
		[@checkbox var="efeitos_retroativos" titulo="Efeitos Retroativos" default="Não" /]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="nomeacao" titulo="Data de Nomeação" default="Não" /]
		[@data var="dt_nomeacao" titulo="Data:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não" /]
	[/@grupo]
	[@grupo]
		[@checkbox var="homolog_consulta" titulo="Válido até a homologação da consulta eleitoral" default="Não" /]
	[/@grupo]
	[@grupo]
		[@checkbox var="publicacao_dou" titulo="Válido a partir da publicação em Diário Oficial" default="Não"/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Nomear</strong>,
		[#if (efeitos_retroativos!"") == "Sim"]
			 com efeitos retroativos a ${dt_efeitos_retroativos!} , 
		[/#if]
		[#if (nomeacao!"") == "Sim"]
			 a partir de ${dt_nomeacao!},  
		[/#if]
 		<strong> ${diretor!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº ${siape!}, do Quadro Permanente da Universidade, para, na qualidade de ${qualidade!}, exercer 
		[#if (pro_tempore!"") == "Sim"]
			 <strong><i>pro tempore </i></strong> 
		[/#if]
		o cargo de ${cargo!} ${preposicao!} ${unidade!} 
		[#if (homolog_consulta!"") == "Sim"]
			  , até a homologação final do resultado da Consulta Eleitoral  
		[/#if]
		.</p> 
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta nomeação corresponde a Cargo de Direção - código <strong>CD-3</strong> 
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

-- ######## PORTARIA Nomeação (Diretor ou Vice-Diretor de Unidade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1021,'Nomeação (Diretor ou Vice-Diretor de Unidade)','Nomeação (Diretor ou Vice-Diretor de Unidade)','template/freemarker', null, 6, 1021,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1021;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1021 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Nomeação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
		[@data var="dt_nomeacao" titulo="Data de nomeação:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="direcao" titulo="Cargo de Direção" default="Não"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o disposto no art.1º, IV, da Lei nº 9.192 de 21.12.95 e o constante no parágrafo 5º do art. 1º e, no art. 5º, caput, do Decreto nº 1.916, de 23.05.96;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais – RGCE, aprovado pela Resolução nº 104, de 03 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o resultado final da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha do Diretor e Vice-Diretor ${preposicao!} <strong>${unidade!}</strong>; e</p>
		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong>, finalmente, o que consta do Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º -  <strong>Nomear a partir de ${dt_nomeacao!}</strong>, dentre os eleitos através da lista tríplice, <strong>${nomeado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, para exercer, com mandato de 04 (quatro) anos, o cargo de <strong>${cargo!} ${preposicao!} ${unidade!}</strong>.</p> 
		[#if (direcao!"") == "Sim"]
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta nomeação corresponde a Cargo de Direção - código <strong>CD-3</strong.</p> 
		[#else]
		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta nomeação não corresponde a Cargo de Direção.</p> 
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

-- ######## PORTARIA Dispensa (Chefe ou Subchefe de Departamento) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1022,'Dispensa (Chefe ou Subchefe de Departamento)','Dispensa (Chefe ou Subchefe de Departamento)','template/freemarker', null, 6, 1022,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1022;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1022 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria de Dispensa"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
    [@grupo]
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
    [/@grupo]
	[@grupo]
		[@selecao var="tipo_funcao" titulo="Função" opcoes= "Chefe;Sub-Chefe" desativado="${desabilitadoEdicao}"/]
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
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de Designação:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pedido" titulo="A pedido" default="Não"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="publicacao_dou" titulo="Publicado em Diário Oficial" default="Não"/]
		[@data var="dt_publicacao_dou" titulo="Data da Publicação em Diário Oficial:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_gratificada" titulo="Função Gratificada" default="Não"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - Dispensar [#if (pedido!"") == "Sim"], a pedido , [/#if] <strong>${dispensado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!}, pertencente ao Quadro Permanente da Universidade, da função de ${tipo_funcao!} [#if (pro_tempore!"") == "Sim"] <strong><i> pro tempore</i></strong> [/#if] do <strong>${departamento!}</strong>, ${preposicao!} ${unidade!}, designada pela Portaria nº. ${portaria_designacao!}, de ${dt_portaria_designacao!} [#if (publicacao_dou!"") == "Sim"], publicada no DOU de ${dt_publicacao_dou!} [/#if].[#if (funcao_gratificada!"") == "Sim"] <strong>FG-1 </strong>.[/#if]</p> 
  		
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

-- ######## PORTARIA Dispensa por falecimento (Chefe de Departamento) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1023,'Dispensa por falecimento (Chefe de Departamento)','Dispensa por falecimento (Chefe de Departamento)','template/freemarker', null, 6, 1023,1);
	
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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
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
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de Designação:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_publicacao_dou" titulo="Data da Publicação em Diário Oficial:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_cessamento_portaria_designacao" titulo="Data de Cessamento da Portaria de Designação:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não"/]
	[/@grupo]
	
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Declarar cessado, a partir de ${dt_cessamento_portaria_designacao!}</strong>, os efeitos da Portaria nº ${portaria_designacao!}, datada de ${dt_portaria_designacao}, publicada no D.O.U de ${dt_publicacao_dou}, por meio da qual ${dispensado!?upper_case}, Professor do Magistério Superior, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, fora designado para a função gratificada <strong>(FG-1)</strong> de <strong>Chefe</strong> [#if (pro_tempore!"") == "Sim"] <strong><i> pro tempore</i></strong> [/#if] do <strong>${departamento!}</strong>, ${preposicao!} ${unidade!}, <strong>por motivo de seu falecimento</strong>. </p> 
  		
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

-- ######## PORTARIA Dispensa (Coordenador ou Vice-Coordenador da Graduação ou Pós-Graduação) ###############	

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
		[@mensagem titulo="Nº do Processo" texto="23069."/]
		[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="/"/]
		[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
		[@mensagem titulo="" texto="-"/]
		[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
    [/@grupo]
  
	[@grupo]
		[@texto var="dispensado" titulo="Nome do Servidor"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@selecao var="tipo_funcao" titulo="Função" opcoes= "Coordenador;Coordenadora;Vice-Coordenador;Vice-Coordenadora" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@checkbox var="qualidade" titulo="Qualidade" default="Não"/]
		[@selecao var="desc_qualidade" titulo="Descrição da qualidade" opcoes= "Decano;Decana" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  [@grupo]
		[@texto var="tipo_curso" titulo="Tipo de Curso"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="nivel" titulo="Nível" default="Não"/]
		[@data var="desc_nivel" titulo="Descrição do Nível:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@selecao var="preposicao" titulo="" opcoes= "da;do" desativado="${desabilitadoEdicao}"/]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="portaria_designacao" titulo="Portaria de Designação"  largura="10" maxcaracteres="15" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_designacao" titulo="Data da Portaria de Designação:" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="publicacao_dou" titulo="Publicado em Diário Oficial" default="Não"/]
		[@data var="dt_publicacao_dou" titulo="Data da Publicação em Diário Oficial:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="efeitos_retroativos" titulo="Efeitos Retroativos" default="Não"/]
		[@data var="dt_efeitos_retroativos" titulo="Data dos efeitos retroativos:" obrigatorio=false desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pro_tempore" titulo="Pro tempore" default="Não"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="pedido" titulo="A pedido" default="Não"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="entre_membros" titulo="Entre os membros do colegiado" default="Não"/]
	[/@grupo]
	[@grupo]
		[@checkbox var="funcao_comissionada" titulo="Função Comissionada" default="Não"/]
	[/@grupo]
	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> o constante no Processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - Dispensar [#if (pedido!"") == "Sim"] , a pedido, [/#if] [#if (efeitos_retroativos!"") == "Sim"] , com efeitos retroativos a ${dt_efeitos_retroativos!}, [/#if] [#if (membros_colegiado!"") == "Sim"] , dentre os membros do Colegiado, [/#if] <strong>${dispensado!?upper_case}</strong>, Professor do Magistério Superior, matrícula SIAPE nº ${siape!}, pertencente ao Quadro Permanente desta Universidade [#if (qualidade!"") == "Sim"], na qualidade de <strong>${desc_qualidade!}</strong>, [/#if] da função de <strong>${tipo_funcao!}</strong> [#if (pro_tempore!"") == "Sim"] <strong><i> pro tempore</i></strong> [/#if] do <strong>${tipo_curso!} ${curso!}</strong>, [#if (nivel!"") == "Sim"] <strong>${desc_nivel!}</strong> [/#if] ${preposicao!} ${unidade!}, designada pela Portaria nº. ${portaria_designacao!} de ${dt_portaria_designacao!} [#if (publicacao_dou!"") == "Sim"] , publicada no D.O.U de ${dt_publicacao_dou} [/#if]. [#if (funcao_comissionada!"") == "Sim"]<strong>FCC</strong>.[/#if]</p> 
  		
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

-- ######## PORTARIA: Cancelamento (Adicional de insalubridade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1025,'Cancelamento (Adicional de insalubridade)','Cancelamento (Adicional de insalubridade)','template/freemarker', null, 6, 1025,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1025;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1025 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Cancelamento (Adicional de insalubridade)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE<strong>, no uso de suas
  		atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis
		8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a
		Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do
		Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE cessar o pagamento do ADICIONAL DE INSALUBRIDADE </strong>do(s)
  		servidor(es) a seguir relacionado(s), pelo não cumprimento dos requisitos estabelecido pela Portaria
		<strong>nº 3214/78, do Ministério do Trabalho.</p> 
		<br/>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Exclusão (Adicional de insalubridade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1026,'Exclusão (Adicional de insalubridade)','Exclusão (Adicional de insalubridade)','template/freemarker', null, 6, 1026,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1026;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1026 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria_ex" titulo="Portaria de Exclusão"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@data var="dt_portaria_ex" titulo="Data da Portaria de Exclusão" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
        [@texto titulo="Nº do Boletim de Serviço" var="num_boletim" /]
    [/@grupo]
	[@grupo]
		[@data var="dt_boletim" titulo="Data do Boletim de Serviço" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]


    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Data da exclusão" var="exclusao"+i /]
            [/@grupo]
			
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Exclusão (Adicional de insalubridade)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE: </strong></p>
		<p style="text-align: justify;">1 - Excluir, na Portaria nº ${num_portaria_ex!} de ${dt_portaria_ex!} , publicada no BS/UFF nº ${num_boletim!}  de ${dt_boletim!} , o(a) servidor(a) abaixo relacionado(a): </p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
				<td width="15%" align=center><strong>A partir de</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
					<td>${.vars["exclusao"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Concessão (Gratificação de RAIO-X) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1027,'Concessão (Gratificação de RAIO-X)','Concessão (Gratificação de RAIO-X)','template/freemarker', null, 6, 1027,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1027;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1027 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concessão (Gratificação de RAIO-X)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder a GRATIFICAÇÃO DE RAIOS-X</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exercício, por estar(em) exposto(s) à ambiente(s) insalubre(s):</p> 
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Reajuste (Adicional de insalubridade Grau médio) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1028,'Reajuste (Adicional de insalubridade Grau médio)','Reajuste (Adicional de insalubridade Grau médio)','template/freemarker', null, 6, 1028,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1028;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1028 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Reajuste (Adicional de insalubridade Grau médio)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder o REAJUSTE de ADICIONAL DE INSALUBRIDADE, de Grau Médio (10%) para Grau Máximo (20%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor(es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exercício, por estar(em) exposto(s) à ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Indeferimento (Adicional de Insalubridade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1029,'Indeferimento (Adicional de Insalubridade)','Indeferimento (Adicional de Insalubridade)','template/freemarker', null, 6, 1029,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1029;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1029 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Indeferimento (Adicional de Insalubridade)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE indeferir o pedido de ADICIONAL DE INSALUBRIDADE</strong> do servidor a seguir relacionado, por não se enquadrar nos requisitos estabelecidos pela Portaria nº 3214/78, do Ministério do Trabalho.</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Indeferimento (Gratificação de RAIO-X) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1030,'Indeferimento de Gratificação de RAIO-X','Indeferimento de Gratificação de RAIO-X','template/freemarker', null, 6, 1030,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1030;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1030 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Indeferimento de Gratificação de RAIO-X
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE indeferir o pedido de GRATIFICAÇÃO DE RAIOS-X</strong>  do servidor a seguir relacionado, por não se enquadrar nos requisitos estabelecidos pela Portaria nº 3214/78, do Ministério do Trabalho</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Concessão (Adicional de insalubridade Grau máximo) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1031,'Concessão (Adicional de insalubridade Grau máximo)','Concessão (Adicional de insalubridade Grau máximo)','template/freemarker', null, 6, 1031,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1031;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1031 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concessão (Adicional de insalubridade Grau máximo)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder o ADICIONAL DE INSALUBRIDADE, no Grau Máximo (20%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor(es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exercício, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Concessão (Adicional de insalubridade Grau médio) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1032,'Concessão (Adicional de insalubridade Grau médio)','Concessão (Adicional de insalubridade Grau médio)','template/freemarker', null, 6, 1032,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1032;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1032 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Concessão (Adicional de insalubridade Grau médio)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder o ADICIONAL DE INSALUBRIDADE, no Grau Médio (10%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exercício, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Revogação (Insalubridade Grau Médio) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1033,'Revogação (Insalubridade Grau Médio)','Revogação (Insalubridade Grau Médio)','template/freemarker', null, 6, 1033,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1033;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1033 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

	[@grupo]
		[@texto var="num_portaria_rev" titulo="Portaria de Revogação"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@data var="dt_portaria_rev" titulo="Data da Portaria de Revogação" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
        [@texto titulo="Nº do Boletim de Serviço" var="num_boletim" /]
    [/@grupo]
	[@grupo]
        [@texto titulo="Página do Boletim de Serviço" var="pg_boletim" /]
    [/@grupo]
	[@grupo]
		[@data var="dt_boletim" titulo="Data do Boletim de Serviço" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="Nº do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lotação" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
			
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Revogação (Insalubridade Grau Médio)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições e considerando as determinações contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orientação Normativa Nº 6, de 18 de Março de 2013 da Secretaria de Recursos Humanos do Ministério do Planejamento, Orçamento e Gestão,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE: </strong></p>
		<p style="text-align: justify;">1 - <strong>Revogar</strong> a Portaria nº ${num_portaria_rev!} de ${dt_portaria_rev!}, publicada no BS/UFF nº ${num_boletim!} de ${dt_boletim!}, pág. ${pg_boletim!}, SEÇÃO II;</p>
		<p style="text-align: justify;">2 - <strong>Conceder o ADICIONAL DE INSALUBRIDADE, no Grau Médio (10%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exercício, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lotação</strong></td>
				<td width="10%" align=center><strong>UORG</strong></td>
				<td width="15%" align=center><strong>LAUDO</strong></td>
				<td width="15%" align=center><strong>SIAPE</strong></td>
				
			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["nome"+i]!}</td>
					<td>23069.${.vars["sequencial"+i]!}/${.vars["ano"+i]!}-${.vars["digito"+i]!}</td>
					<td>${.vars["lotacao"+i]!}</td>
					<td>${.vars["uorg"+i]!}</td>
					<td>${.vars["laudo"+i]!}</td>
					<td>${.vars["siape"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Retificação (Adicional de Insalubridade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1034,'Retificação (Adicional de Insalubridade)','Retificação (Adicional de Insalubridade)','template/freemarker', null, 6, 1034,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1034;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1034 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria" titulo="Portaria"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="desc_grau" titulo="Descrição do Grau de Insalubridade"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  	[@grupo]
		[@texto var="pct_grau" titulo="Porcentagem do Grau de Insalubridade"  largura="10" maxcaracteres="10" obrigatorio="true" desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
        [@texto titulo="Nº do Boletim de Serviço" var="num_boletim" /]
    [/@grupo]
	[@grupo]
        [@texto titulo="Página do Boletim de Serviço" var="pg_boletim" /]
    [/@grupo]
	[@grupo]
		[@data var="dt_boletim" titulo="Data do Boletim de Serviço" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
         [@texto titulo="Nome do Servidor" var="nome" /]
    [/@grupo]
	[@grupo]
         [@texto titulo="Matrícula SIAPE" var="siape" /]
    [/@grupo]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdRetificoes" titulo="Quantidade de retificações" reler=true idAjax="qtdRetificoesAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdRetificoesAjax"]
        [#list 1..(qtdRetificoes)?number as i]
			[@grupo]
                [@texto titulo="Termo" var="termo"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Retificação" var="retificacao"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Retificação (Adicional de Insalubridade)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições legais, estatutárias e regimentais;</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE: </strong></p>
		<p style="text-align: justify;"><strong>1 - Retificar, em parte a Portaria nº ${num_portaria!} de ${dt_portaria!}</strong>, que concedeu o Adicional de Insalubridade, no Grau ${desc_grau!} (${pct_grau!}%), ao servidor ${nome!}, matrícula SIAPE n° ${siape!} e publicado no BS/UFF nº ${num_boletim!} de ${dt_boletim!}, pág. ${pg_boletim!} SEÇÃO II.</p>
		<p style="text-align: justify;">2 - <strong>Conceder o ADICIONAL DE INSALUBRIDADE, no Grau Médio (10%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exercício, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="50%" align=center><strong>Onde se Lê</strong></td>
				<td width="50%" align=center><strong>Leia-se</strong></td>
			</tr>
			[#list 1..(qtdRetificoes)?number as i]				
				<tr>	
					<td>${.vars["termo"+i]!}</td>
					<td>${.vars["retificacao"+i]!}</td>
				</tr>			
		    [/#list]
		</table>
		</br>		
		<p style="text-align: justify;">2 - Esta Portaria entra em vigor na data de sua publicação.	</p>
		
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/