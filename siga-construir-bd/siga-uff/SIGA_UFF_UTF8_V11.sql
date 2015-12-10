SET DEFINE OFF;

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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
		[@texto var="num_portaria_ex" titulo="Portaria de Exclusão"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
		[@texto var="num_portaria_rev" titulo="Portaria de Revogação"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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
		[@texto var="num_portaria" titulo="Portaria"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@data var="dt_portaria" titulo="Data da Portaria" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
		[@texto var="desc_grau" titulo="Descrição do Grau de Insalubridade"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  	[@grupo]
		[@texto var="pct_grau" titulo="Porcentagem do Grau de Insalubridade"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
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