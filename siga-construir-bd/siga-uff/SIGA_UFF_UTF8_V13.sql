SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

	DECLARE
	  dest_blob_ex_mod BLOB;
	  src_blob_ex_mod BLOB;
	  
	BEGIN
	
	-- ######## Concessão de Progressão por Mérito Profissional (Exercício Anterior ou em Curso) ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1061,'Concessão de Progressão por Mérito Profissional (Exercício Anterior ou em Curso)','Concessão de Progressão por Mérito Profissional (Exercício Anterior ou em Curso)','template/freemarker', null, 6, 1061,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1061;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1061 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]

 		[@grupo]
			[@selecao var="tipo_exercicio" titulo="Tipo" opcoes="exercícios anteriores;exercício em curso" desativado="${desabilitadoEdicao}"/]
		[/@grupo]

	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
		Concessão de Progressão por Mérito Profissional a servidores técnicos-administrativos, referente a ${tipo_exercicio!}.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O Reitor da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais, </p>
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Considerando o disposto no &sect 2º do artigo 10 da Lei nº 11.091, de 12 de janeiro de 2005, alterado pelo artigo 15 da Lei 11.784, de 22 de setembro de 2008, assim como o que estabelece o inciso V do &sect 1º do art. 8º, do Decreto 5825, de 29 de junho de 2006,</p>   
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">1. Conceder Progressão por Mérito Profissional aos servidores técnico-administrativos relacionados nos anexos à presente portaria, observando-se a respectiva vigência, referente a ${tipo_exercicio!}</p>		
		
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
	
	-- ######## Concessão de Progressão por Mérito Profissional ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1062,'Concessão de Progressão por Mérito Profissional','Concessão de Progressão por Mérito Profissional','template/freemarker', null, 6, 1062,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1062;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1062 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]
		[#assign valores = 1..100 /]
    	[@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    	
		[@grupo]
            [@texto titulo="Número da Instrução de Serviço" var="numero_is_progepe" obrigatorio=true desativado="${desabilitadoEdicao}/]
        [/@grupo]

		[@grupo]
		    [@data var="dt_is_progepe" titulo="Data da Instrução de Serviço" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo depende="qtdServidoresAjax"]       		
		[#list 1..(qtdServidores)?number as i]
			[@grupo]
				[@selecao var="artigo"+i titulo="" opcoes="o;a" desativado="${desabilitadoEdicao}"/]
				[@texto var="nome_servidor"+i titulo="Nome do Servidor(a)" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]

            [@grupo]
                [@texto titulo="Matrícula SIAPE" var="siape"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Cargo" var="cargo"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Nível de Classificação" var="nivel_class"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Padrão de Vencimento" var="vencimento"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Vigência" var="vigencia"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Efeito financeiro" var="efeito_financeiro"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

 			[@separador/]
        [/#list]
    [/@grupo]

	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
		Concessão de Progressão por Mérito Profissional a servidores técnicos-administrativos.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O Reitor da Universidade Federal Fluminense</strong>, no uso de suas atribuições legais, estatutárias e regimentais, </p>
			<p style="text-align: justify; text-indent:${recuo_paragrafo};><strong>Considerando</strong> o disposto no &sect 2º do artigo 10 Lei nº 11.091, de 12 de janeiro de 2005, alterado pelo artigo 15 da Lei 11.784, de 22 de setembro de 2008, assim como o que estabelece o inciso V do &sect 1º do art. 8º do Decreto 5825, de 29 de junho de 2006 e a IS/PROGEPE ${numero_is_progepe!} de ${dt_is_progepe!} em seu art. 10 &sect2º;</p>
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Conceder Progressão por Mérito Profissional</strong> ao ${.vars["nome_servidor1"!} SIAPE ${.vars["siape1"]!}, conforme se segue: </p>

		</br>
		<table width="100%" style="font-size:8pt">
			<tr>	
				<td width="30%" align=center><strong>Matrícula SIAPE</strong></td>
				<td width="18%" align=center><strong>Nome</strong></td>
				<td width="13%" align=center><strong>Cargo</strong></td>
				<td width="9%" align=center><strong>Nível de Classificação</strong></td>
				<td width="16%" align=center><strong>Padrão de Vencimento</strong></td>
				<td width="14%" align=center><strong>Vigência</strong></td>
				<td width="14%" align=center><strong>Efeito Financeiro</strong></td>

			</tr>
			[#list 1..(qtdServidores)?number as i]				
				<tr>	
					<td>${.vars["siape"+i]!}</td>
					<td>${.vars["nome_servidor"+i]!}</td>
					<td>${.vars["cargo"+i]!}</td>
					<td>${.vars["nivel_class"+i]!}</td>
					<td>${.vars["vencimento"+i]!}</td>
					<td>${.vars["vigencia"+i]!}</td>
					<td>${.vars["efeito_financeiro"+i]!}</td>
				</tr>			
		    [/#list]
		</table>	

		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta Portaria entra em vigor na data de sua publicação. </p>
	
		
	[/#assign]
	
	
	[@portaria texto=texto_portaria ementa=texto_ementa/ texto_anexo=tabela_anexo/]
	[/@documento]
	','AL32UTF8'));
	dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);
	
	END;
	/
	
	DECLARE
	  dest_blob_ex_mod BLOB;
	  src_blob_ex_mod BLOB;
	  
	BEGIN
	
	-- ######## Homologação de Avaliação de Desempenho em Estágio Probatório. ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1063,'Homologação de Avaliação de Desempenho em Estágio Probatório','Homologação de Avaliação de Desempenho em Estágio Probatório','template/freemarker', null, 6, 1063,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1063;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1063 for update;
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

	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
		Homologação do resultado de processo de Avaliação de Desempenho de servidores técnico-administrativos em Estágio Probatório.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O Reitor da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais, cumprindo o que determina o artigo 20 da Lei nº 8.112, de 11.12.90 (RJU) e tendo em vista o que consta do processo nº 23069.${sequencial!}/${ano!}-${digito!}. </p>
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">1 - Homologar o resultado do processo de Avaliação de Desempenho dos Servidores Técnico-Administrativos, relacionados em anexo.</p>		
		
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
	
	-- ######## Retificação de Portaria de homologação de Estágio Probatório ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1064,'Retificação de Portaria de homologação de Estágio Probatório','Retificação de Portaria de homologação de Estágio Probatório','template/freemarker', null, 6, 1064,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1064;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1064 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]
	
		[@grupo]
			[@checkbox var="em_parte" titulo="em parte" obrigatorio=false/]
		[/@grupo]

 		[@grupo]
			[@texto var="num_portaria" titulo="Portaria" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
                [@data titulo="Data da Portaria" var="data_portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
        [/@grupo]

 		[@grupo]
			[@texto var="num_bs/uff" titulo="Número BS/UFF" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
                [@data titulo="Data da publicação no BS/UFF" var="data_bs/uff" obrigatorio=true desativado="${desabilitadoEdicao}"/]
        [/@grupo]

		[@grupo]
			[@checkbox var="ch_siape" titulo="Siape" obrigatorio=false/]

			[@checkbox var="ch_nome" titulo="Nome" obrigatorio=false/]

			[@checkbox var="ch_cargo" titulo="Cargo" obrigatorio=false/]

			[@checkbox var="ch_vencimento" titulo="Vencimento do Estágio" obrigatorio=false/]

			[@checkbox var="ch_situacao" titulo="Situação" obrigatorio=false/]

            [@texto titulo="Nome do Servidor" var="nome_servidor" obrigatorio=true desativado="${desabilitadoEdicao}/]

            [@texto titulo="Matrícula SIAPE" var="siape" obrigatorio=true desativado="${desabilitadoEdicao}/]
        [/@grupo]

	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
		Retificação de Portaria de homologação de Estágio Probatório.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O Reitor da Universidade Federal Fluminense, no uso de suas atribuições legais, estatutárias e regimentais; </p>
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1º - <strong>Retificar, ${em_parte!}, o anexo à Portaria nº ${num_portaria!} de ${data_portaria!}, publicada no BS/UFF nº ${num_bs/uff!} de ${data_bs/uff!}</strong>, que homologa o estágio probatório de servidores técnico-administrativos desta Universidade, <strong>alterando o [] da servidor(a) ${!nome_servidor}, SIAPE nº ${siape!}, conforme se segue:</strong></p>		
		
		</br>
		<table width="100%" style="font-size:8pt">
			<tr>	
				<td width="30%" align=center><strong>Matrícula SIAPE</strong></td>
				<td width="18%" align=center><strong>Nome</strong></td>
				<td width="13%" align=center><strong>Cargo</strong></td>
				<td width="9%" align=center><strong>Vencimento do Estágio</strong></td>
				<td width="16%" align=center><strong>Situação</strong></td>

			</tr>	

		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2º - Esta Portaria entra em vigor na data de sua publicação. </p>

	[/#assign]
	
	[@portaria texto=texto_portaria ementa=texto_ementa/ texto_anexo=tabela_anexo/]
	[/@documento]
	','AL32UTF8'));
	dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);
	
	END;
	/	
	