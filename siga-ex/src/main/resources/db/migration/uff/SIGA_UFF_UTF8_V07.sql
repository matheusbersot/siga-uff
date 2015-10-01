SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Nomeação de Coordenador da Pós-Graduação ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1003,'Nomeação de Coordenador da Pós-Graduação','Nomeação de Coordenador da Pós-Graduação','template/freemarker', null, 6, 1003,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1003;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1003 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@memo var="texto_ementa" titulo="Ementa" colunas="63" linhas="3"/]
	[/@grupo] 
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="cargo" titulo="Cargo"  largura="20" maxcaracteres="30" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="curso" titulo="Curso"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="setor" titulo="Setor"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que prescreve o Regulamento dos Programas de Pós-Graduação "stricto sensu", aprovado pela Resolução nº 02 de 13.01.2010, do Conselho de Ensino e Pesquisa;</p>
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>  
  		<p style=\"margin-left:1.25cm\"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.1º <strong> - Designar</strong>, dentre os membros do Colegiado, <strong>${designado!}</strong>, ${cargo!}, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, para exercer, com mandato de 04 (quatro) anos, a função de <strong>COORDENADOR(A)</strong><strong> </strong>do(a) <strong>${curso!}</strong><strong>, </strong>do(a) <strong>${setor!}, níveis Mestrado e Doutorado.</strong></p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.2º - Esta designação corresponde a Função Comissionada de Coordenação de Curso - código <strong>FCC</strong>, a partir de sua publicação no Diário Oficial da União<strong>.</strong></p> <p> </p>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Progressão por Capacitação Profissional ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1004,'Progressão por Capacitação Profissional','Progressão por Capacitação Profissional','template/freemarker', null, 6, 1004,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1004;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1004 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_ementa]
  		<p style="text-align: justify;">Concessão de Progressão por Capacitação Profissional a servidores técnico-administrativos.</p>
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong> no uso de suas atribuições e tendo em vista o Parecer emitido pela Divisão de Capacitação e Qualificação, da Coordenação de Pessoal Técnico-Administrativo, resolve:</p>
  		<p style="text-align: justify; text-indent:1.25cm;">Conceder a PROGRESSÃO POR CAPACITAÇÃO PROFISSIONAL, nos termos do § 1° do artigo 10 da Lei n° 11.091, de 12 de janeiro de 2005, regulamentado pelo Decreto n° 5824, de 29 de junho de 2006, pela Portaria MEC n° 09, de 29 de junho de 2006, e pela Norma de Serviço de n° 580, de 10 de outubro de 2006, retificada pela norma de Serviço de nº 586, de 14 de dezembro de 2006, aos servidores relacionados no Anexo à presente Portaria, mantendo-se os níveis de classificação e observando-se a respectiva vigência, referente ao exercício financeiro do ano em curso. </p>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Progressão por Mérito Profissional ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1005,'Progressão por Mérito Profissional','Progressão por Mérito Profissional','template/freemarker', null, 6, 1005,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1005;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1005 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_ementa]
  		<p style="text-align: justify;">Concessão de Progressão por Mérito Profissional a servidores técnico-administrativos.</p>
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições legais, estatutárias e regimentais,</p>
  		<p style="text-align: justify; text-indent:1.25cm;">Considerando o disposto no § 2º do artigo 10 da Lei nº 11.091, de 12 de janeiro de 2005, alterado pelo artigo 15 da Lei 11.784, de 22 de setembro de 2008, assim como o que estabelece o inciso V do § 1º do art. 8º, do Decreto 5825, de 29 de junho de 2006 e a IS/PROGEPE nº 001 de 05/08/2013 em seu art. 10 §2º;</p>
		<p style="text-align: justify; text-indent:1.25cm;">RESOLVE:</p>
		<p style="text-align: justify; text-indent:1.25cm;">Art. 1º - <strong>Conceder Progressão por Mérito Profissional aos servidores técnico-administrativos</strong> relacionados nos anexos à presente portaria, observando-se as respectivas vigências e efeitos financeiros.</p>
		<p style="text-align: justify; text-indent:1.25cm;">Art. 2º - Esta Portaria entra em vigor na data de sua publicação.</p>
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Nomeação de Chefe de Departamento Pro Tempore ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1006,'Nomeação de Chefe de Departamento Pro Tempore','Nomeação de Chefe de Departamento Pro Tempore','template/freemarker', null, 6, 1006,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1006;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1006 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@memo var="texto_ementa" titulo="Ementa" colunas="63" linhas="3"/]
	[/@grupo] 
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="cargo" titulo="Cargo"  largura="20" maxcaracteres="30" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@selecao var="codigo_func" titulo="Código da Função" opcoes= "FG-1;FG-2;FG-3;FG-4;FG-5;FG-6;FG-7;FG-8;FG-9;"/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>  
  		<p style=\"margin-left:1.25cm\"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.1º <strong> - Designar ${designado!}</strong>, ${cargo!}, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, para exercer,<strong> "pro tempore"</strong>, a função de <strong>CHEFE</strong> do(a) <strong>${departamento!}</strong>, </strong>do(a) <strong>${unidade!}.</strong></p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.2º - Esta designação corresponde a Função Gratificada - código <strong>${codigo_func!}</strong>, a partir de sua publicação no Diário Oficial da União<strong>.</strong></p>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Nomeação de Chefe de Departamento Complemento ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1007,'Nomeação de Chefe de Departamento Complemento','Nomeação de Chefe de Departamento Complemento','template/freemarker', null, 6, 1007,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1007;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1007 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@memo var="texto_ementa" titulo="Ementa" colunas="63" linhas="3"/]
	[/@grupo] 
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="cargo" titulo="Cargo"  largura="20" maxcaracteres="30" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="dt_inicio_mandato" titulo="Data do Início do Mandato"  largura="30" maxcaracteres="50" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="num_portaria_primeiro_mandato" titulo="Número da Portaria do Primeiro Mandato"  largura="10" maxcaracteres="10" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@data var="dt_portaria_primeiro_mandato" titulo="Data da Portaria do Primeiro Mandato"  obrigatorio=true/]
	[/@grupo]
	[@grupo]
		[@selecao var="codigo_func" titulo="Código da Função" opcoes= "FG-1;FG-2;FG-3;FG-4;FG-5;FG-6;FG-7;FG-8;FG-9;"/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>  
  		<p style=\"margin-left:1.25cm\"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.1º <strong> - Designar ${designado!}</strong>, ${cargo!}, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, para exercer, a função de <strong>CHEFE</strong> do(a) <strong>${departamento!}</strong>, </strong>do(a) <strong>${unidade!}</strong>, complementando assim o mandato de 02 (dois) anos, iniciado em ${dt_inicio_mandato!}, pela Portaria nº. ${num_portaria_primeiro_mandato!}, de ${dt_portaria_primeiro_mandato!}.</p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.2º - Esta designação corresponde a Função Gratificada - código <strong>${codigo_func!}</strong>, a partir de sua publicação no Diário Oficial da União<strong>.</strong></p>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA Nomeação de Chefe de Departamento Simples - Chapa Única ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1008,'Nomeação de Chefe de Departamento Simples - Chapa Única','Nomeação de Chefe de Departamento Simples - Chapa Única','template/freemarker', null, 6, 1008,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1008;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1008 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@memo var="texto_ementa" titulo="Ementa" colunas="63" linhas="3"/]
	[/@grupo] 
    [@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="designado" titulo="Designado"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="cargo" titulo="Cargo"  largura="20" maxcaracteres="30" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="departamento" titulo="Departamento"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio="true"/]
	[/@grupo]
	[@grupo]
		[@selecao var="codigo_func" titulo="Código da Função" opcoes= "FG-1;FG-2;FG-3;FG-4;FG-5;FG-6;FG-7;FG-8;FG-9;"/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR</strong> da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais;</p>
		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que dispõem os parágrafos 1º e 2º do artigo 14, e o artigo 17 do Estatuto;</p> 
		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> as prescrições contidas nos Artigos 33 e 37 do Regimento Geral da Universidade;</p> 
		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que prescreve o Regulamento Geral das Consultas Eleitorais - RGCE, aprovado pela Resolução nº 104, de 03 de dezembro de 1997, do Conselho Universitário;</p>
		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o resultado final da consulta à comunidade universitária, com o objetivo de identificar as preferências com respeito à escolha do Chefe e Subchefe do <strong>${departamento!}</strong>, do(a) <strong>${unidade!}</strong>; e </p>
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>Considerando</strong> o que consta do Processo nº ${num_processo!},</p>  
  		<p style=\"margin-left:1.25cm\"><strong>RESOLVE:</strong></p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.1º <strong> - Designar ${designado!}</strong>, ${cargo!}, matrícula SIAPE nº. ${siape!}, do Quadro Permanente da Universidade, para exercer, com mandato de 2 (dois) anos, a função de <strong>CHEFE</strong> do(a) <strong>${departamento!}</strong>, </strong>do(a) <strong>${unidade!}</strong>.</p> 
  		<p style="text-align: justify; text-indent:1.25cm;">Art.2º - Esta designação corresponde a Função Gratificada - código <strong>${codigo_func!}</strong>, a partir de sua publicação no Diário Oficial da União<strong>.</strong></p>
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/

--REM INSERTING into SIGA.EX_MODELO

DECLARE
  dest_blob_ex_mod BLOB;
  src_blob_ex_mod BLOB;
  
BEGIN

-- ######## PORTARIA: Homologação Avaliação de Desempenho - Estágio Probatório ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1009,'Homologação Avaliação de Desempenho - Estágio Probatório','Homologação Avaliação de Desempenho - Estágio Probatório','template/freemarker', null, 6, 1009,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1009;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1009 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_processo" titulo="Nº do Processo"  largura="30" maxcaracteres="40" obrigatorio="true"/]
	[/@grupo]
[/@entrevista]

[#-- Bloco Documento --]
[@documento margemEsquerda="2cm" margemDireita="2cm" margemSuperior="0.5cm" margemInferior="2cm"]

[#assign texto_ementa]
  		<p style="text-align: justify;">Homologação do resultado de processo de Avaliação de Desempenho de servidores técnico-administrativos em Estágio Probatório.</p>
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:1.25cm;"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribuições legais, estatutárias e regimentais, cumprindo o que determina o artigo 20 da Lei nº 8.112, de 11.12.90 (RJU) e tendo em vista o que consta do Processo nº ${num_processo!}</p>  		
		<p style="text-align: justify; text-indent:1.25cm;">RESOLVE:</p>
		<p style="text-align: justify; text-indent:1.25cm;">Art. 1º - Homologar o resultado do processo de Avaliação de Desempenho dos Servidores Técnico-Administrativos, relacionados em anexo.</p>
[/#assign]

[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/


