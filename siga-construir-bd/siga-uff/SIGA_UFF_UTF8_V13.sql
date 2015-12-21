SET DEFINE OFF;
--REM INSERTING into SIGA.EX_MODELO

	DECLARE
	  dest_blob_ex_mod BLOB;
	  src_blob_ex_mod BLOB;
	  
	BEGIN
	
	-- ######## Concess�o de Progress�o por M�rito Profissional (Exerc�cio Anterior ou em Curso) ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1061,'Concess�o de Progress�o por M�rito Profissional (Exerc�cio Anterior ou em Curso)','Concess�o de Progress�o por M�rito Profissional (Exerc�cio Anterior ou em Curso)','template/freemarker', null, 6, 1061,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1061;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1061 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]

 		[@grupo]
			[@selecao var="tipo_exercicio" titulo="Tipo" opcoes="exerc�cios anteriores;exerc�cio em curso" desativado="${desabilitadoEdicao}"/]
		[/@grupo]

	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
		Concess�o de Progress�o por M�rito Profissional a servidores t�cnicos-administrativos, referente a ${tipo_exercicio!}.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O Reitor da Universidade Federal Fluminense, no uso de suas atribui��es legais, estatut�rias e regimentais, </p>
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Considerando o disposto no &sect 2� do artigo 10 da Lei n� 11.091, de 12 de janeiro de 2005, alterado pelo artigo 15 da Lei 11.784, de 22 de setembro de 2008, assim como o que estabelece o inciso V do &sect 1� do art. 8�, do Decreto 5825, de 29 de junho de 2006,</p>   
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">1. Conceder Progress�o por M�rito Profissional aos servidores t�cnico-administrativos relacionados nos anexos � presente portaria, observando-se a respectiva vig�ncia, referente a ${tipo_exercicio!}</p>		
		
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
	
	-- ######## Concess�o de Progress�o por M�rito Profissional ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1062,'Concess�o de Progress�o por M�rito Profissional','Concess�o de Progress�o por M�rito Profissional','template/freemarker', null, 6, 1062,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1062;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1062 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]
		[#assign valores = 1..100 /]
    	[@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    	
		[@grupo]
            [@texto titulo="N�mero da Instru��o de Servi�o" var="numero_is_progepe" obrigatorio=true desativado="${desabilitadoEdicao}/]
        [/@grupo]

		[@grupo]
		    [@data var="dt_is_progepe" titulo="Data da Instru��o de Servi�o" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo depende="qtdServidoresAjax"]       		
		[#list 1..(qtdServidores)?number as i]
			[@grupo]
				[@selecao var="artigo"+i titulo="" opcoes="o;a" desativado="${desabilitadoEdicao}"/]
				[@texto var="nome_servidor"+i titulo="Nome do Servidor(a)" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]

            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Cargo" var="cargo"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="N�vel de Classifica��o" var="nivel_class"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Padr�o de Vencimento" var="vencimento"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
            [/@grupo]

            [@grupo]
                [@texto titulo="Vig�ncia" var="vigencia"+i obrigatorio=true desativado="${desabilitadoEdicao}/]
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
		Concess�o de Progress�o por M�rito Profissional a servidores t�cnicos-administrativos.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O Reitor da Universidade Federal Fluminense</strong>, no uso de suas atribui��es legais, estatut�rias e regimentais, </p>
			<p style="text-align: justify; text-indent:${recuo_paragrafo};><strong>Considerando</strong> o disposto no &sect 2� do artigo 10 Lei n� 11.091, de 12 de janeiro de 2005, alterado pelo artigo 15 da Lei 11.784, de 22 de setembro de 2008, assim como o que estabelece o inciso V do &sect 1� do art. 8� do Decreto 5825, de 29 de junho de 2006 e a IS/PROGEPE ${numero_is_progepe!} de ${dt_is_progepe!} em seu art. 10 &sect2�;</p>
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - <strong>Conceder Progress�o por M�rito Profissional</strong> ao ${.vars["nome_servidor1"!} SIAPE ${.vars["siape1"]!}, conforme se segue: </p>

		</br>
		<table width="100%" style="font-size:8pt">
			<tr>	
				<td width="30%" align=center><strong>Matr�cula SIAPE</strong></td>
				<td width="18%" align=center><strong>Nome</strong></td>
				<td width="13%" align=center><strong>Cargo</strong></td>
				<td width="9%" align=center><strong>N�vel de Classifica��o</strong></td>
				<td width="16%" align=center><strong>Padr�o de Vencimento</strong></td>
				<td width="14%" align=center><strong>Vig�ncia</strong></td>
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

		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2� - Esta Portaria entra em vigor na data de sua publica��o. </p>
	
		
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
	
	-- ######## Homologa��o de Avalia��o de Desempenho em Est�gio Probat�rio. ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1063,'Homologa��o de Avalia��o de Desempenho em Est�gio Probat�rio','Homologa��o de Avalia��o de Desempenho em Est�gio Probat�rio','template/freemarker', null, 6, 1063,1);
		
	update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1063;
	
	select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1063 for update;
	src_blob_ex_mod := utl_raw.cast_to_raw(convert('
	[#-- Bloco Entrevista --]
	
	[@entrevista]
    [@grupo]
		[@mensagem titulo="N� do Processo" texto="23069."/]
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
		Homologa��o do resultado de processo de Avalia��o de Desempenho de servidores t�cnico-administrativos em Est�gio Probat�rio.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O Reitor da Universidade Federal Fluminense, no uso de suas atribui��es legais, estatut�rias e regimentais, cumprindo o que determina o artigo 20 da Lei n� 8.112, de 11.12.90 (RJU) e tendo em vista o que consta do processo n� 23069.${sequencial!}/${ano!}-${digito!}. </p>
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">1 - Homologar o resultado do processo de Avalia��o de Desempenho dos Servidores T�cnico-Administrativos, relacionados em anexo.</p>		
		
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
	
	-- ######## Retifica��o de Portaria de homologa��o de Est�gio Probat�rio ###############	
	
	Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
	values (1064,'Retifica��o de Portaria de homologa��o de Est�gio Probat�rio','Retifica��o de Portaria de homologa��o de Est�gio Probat�rio','template/freemarker', null, 6, 1064,1);
		
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
			[@texto var="num_bs/uff" titulo="N�mero BS/UFF" largura="50" maxcaracteres="100" obrigatorio=true desativado="${desabilitadoEdicao}"/]
		[/@grupo]

		[@grupo]
                [@data titulo="Data da publica��o no BS/UFF" var="data_bs/uff" obrigatorio=true desativado="${desabilitadoEdicao}"/]
        [/@grupo]

		[@grupo]
			[@checkbox var="ch_siape" titulo="Siape" obrigatorio=false/]

			[@checkbox var="ch_nome" titulo="Nome" obrigatorio=false/]

			[@checkbox var="ch_cargo" titulo="Cargo" obrigatorio=false/]

			[@checkbox var="ch_vencimento" titulo="Vencimento do Est�gio" obrigatorio=false/]

			[@checkbox var="ch_situacao" titulo="Situa��o" obrigatorio=false/]

            [@texto titulo="Nome do Servidor" var="nome_servidor" obrigatorio=true desativado="${desabilitadoEdicao}/]

            [@texto titulo="Matr�cula SIAPE" var="siape" obrigatorio=true desativado="${desabilitadoEdicao}/]
        [/@grupo]

	[/@entrevista]
	
	[#-- Bloco Documento --]
	[@documento]

    [#assign texto_ementa]
		Retifica��o de Portaria de homologa��o de Est�gio Probat�rio.
	[/#assign]

	[#assign texto_portaria]
	  		<p style="text-align: justify; text-indent:${recuo_paragrafo};">O Reitor da Universidade Federal Fluminense, no uso de suas atribui��es legais, estatut�rias e regimentais; </p>
			<p style="text-indent:${recuo_paragrafo};">RESOLVE:</p> 
			<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 1� - <strong>Retificar, ${em_parte!}, o anexo � Portaria n� ${num_portaria!} de ${data_portaria!}, publicada no BS/UFF n� ${num_bs/uff!} de ${data_bs/uff!}</strong>, que homologa o est�gio probat�rio de servidores t�cnico-administrativos desta Universidade, <strong>alterando o [] da servidor(a) ${!nome_servidor}, SIAPE n� ${siape!}, conforme se segue:</strong></p>		
		
		</br>
		<table width="100%" style="font-size:8pt">
			<tr>	
				<td width="30%" align=center><strong>Matr�cula SIAPE</strong></td>
				<td width="18%" align=center><strong>Nome</strong></td>
				<td width="13%" align=center><strong>Cargo</strong></td>
				<td width="9%" align=center><strong>Vencimento do Est�gio</strong></td>
				<td width="16%" align=center><strong>Situa��o</strong></td>

			</tr>	

		<p style="text-align: justify; text-indent:${recuo_paragrafo};">Art. 2� - Esta Portaria entra em vigor na data de sua publica��o. </p>

	[/#assign]
	
	[@portaria texto=texto_portaria ementa=texto_ementa/ texto_anexo=tabela_anexo/]
	[/@documento]
	','AL32UTF8'));
	dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);
	
	END;
	/	
	