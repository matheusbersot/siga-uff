SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

	DECLARE
	  dest_blob_ex_mod BLOB;
	  src_blob_ex_mod BLOB;
	  
	BEGIN
	
	-- ######## PORTARIA Designação para Coordenação de Acordo de Cooperação (Docente) ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1060,'Designação para Coordenação de Acordo de Cooperação (Docente)','Designação para Coordenação de Acordo de Cooperação (Docente)','template/freemarker', null, 6, 1060,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1060;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1060 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]
	    [@grupo]
			[@mensagem titulo="Nº do Processo" texto="23069."/]
			[@texto var="sequencial" titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[@mensagem titulo="" texto="/"/]
			[@texto var="ano" titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[@mensagem titulo="" texto="-"/]
			[@texto var="digito" titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
			[@selecao var="artigo" titulo="" opcoes="o;a" desativado="${desabilitadoEdicao}"/]
			[@texto var="nome_professor" titulo="Nome do Professor(a)" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
			[@texto var="universidade" titulo="Universidade" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
			[@texto var="siape" titulo="Siape"  largura="10" maxcaracteres="15" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
			[@selecao var="preposicao" titulo="" opcoes="no;na" desativado="${desabilitadoEdicao}"/]
			[@texto var="unidade" titulo="Unidade"  largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
                [@data titulo="Data de Celebração" var="dtcelebracao" obrigatorio=true desativado="${desabilitadoEdicao}"/]
        [/@grupo]
	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
    	Designar Docente para Coordenar o Acordo de Cooperação entre a UFF e ${universidade!}, celebrado em ${dtcelebracao!}.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR</strong> da <strong>Universidade Federal Fluminense</strong>, no uso de suas atribuições legais, regimentais e estatutárias, </p>
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>Considerando</strong> os autos do processo nº 23069.${sequencial!}/${ano!}-${digito!},</p>  

			<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE:</strong></p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>1</strong> - Designar como Coordenador do Acordo de Cooperação, celebrado entre a <strong>UFF</strong> e ${universidade!}, em ${dtcelebracao!}, ${artigo!} Professor${artigo!} ${nome_professor!} , matrícula SIAPE nº ${siape!}, lotad${artigo} ${preposicao!} ${instituto!}. </p>	
			<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>2</strong> - Esta designação não corresponde à função gratificada.</p>	
		
	[/#assign]
	
	
	[@portaria texto=texto_portaria ementa=texto_ementa/]
	[/@documento]
	','AL32UTF8'));
	dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);
	
	END;
	/