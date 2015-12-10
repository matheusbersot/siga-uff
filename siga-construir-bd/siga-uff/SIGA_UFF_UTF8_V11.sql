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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis
		8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a
		Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do
		Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE cessar o pagamento do ADICIONAL DE INSALUBRIDADE </strong>do(s)
  		servidor(es) a seguir relacionado(s), pelo n�o cumprimento dos requisitos estabelecido pela Portaria
		<strong>n� 3214/78, do Minist�rio do Trabalho.</p> 
		<br/>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Exclus�o (Adicional de insalubridade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1026,'Exclus�o (Adicional de insalubridade)','Exclus�o (Adicional de insalubridade)','template/freemarker', null, 6, 1026,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1026;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1026 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]
	[@grupo]
		[@texto var="num_portaria_ex" titulo="Portaria de Exclus�o"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@data var="dt_portaria_ex" titulo="Data da Portaria de Exclus�o" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
        [@texto titulo="N� do Boletim de Servi�o" var="num_boletim" /]
    [/@grupo]
	[@grupo]
		[@data var="dt_boletim" titulo="Data do Boletim de Servi�o" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]


    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="UORG" var="uorg"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Laudo" var="laudo"+i /]
            [/@grupo]
			[@grupo]
                [@texto titulo="Data da exclus�o" var="exclusao"+i /]
            [/@grupo]
			
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Exclus�o (Adicional de insalubridade)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE: </strong></p>
		<p style="text-align: justify;">1 - Excluir, na Portaria n� ${num_portaria_ex!} de ${dt_portaria_ex!} , publicada no BS/UFF n� ${num_boletim!}  de ${dt_boletim!} , o(a) servidor(a) abaixo relacionado(a): </p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Concess�o (Gratifica��o de RAIO-X) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1027,'Concess�o (Gratifica��o de RAIO-X)','Concess�o (Gratifica��o de RAIO-X)','template/freemarker', null, 6, 1027,1);
	
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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		Concess�o (Gratifica��o de RAIO-X)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder a GRATIFICA��O DE RAIOS-X</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exerc�cio, por estar(em) exposto(s) � ambiente(s) insalubre(s):</p> 
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Reajuste (Adicional de insalubridade Grau m�dio) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1028,'Reajuste (Adicional de insalubridade Grau m�dio)','Reajuste (Adicional de insalubridade Grau m�dio)','template/freemarker', null, 6, 1028,1);
	
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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		Reajuste (Adicional de insalubridade Grau m�dio)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder o REAJUSTE de ADICIONAL DE INSALUBRIDADE, de Grau M�dio (10%) para Grau M�ximo (20%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor(es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exerc�cio, por estar(em) exposto(s) � ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE indeferir o pedido de ADICIONAL DE INSALUBRIDADE</strong> do servidor a seguir relacionado, por n�o se enquadrar nos requisitos estabelecidos pela Portaria n� 3214/78, do Minist�rio do Trabalho.</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Indeferimento (Gratifica��o de RAIO-X) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1030,'Indeferimento de Gratifica��o de RAIO-X','Indeferimento de Gratifica��o de RAIO-X','template/freemarker', null, 6, 1030,1);
	
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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		Indeferimento de Gratifica��o de RAIO-X
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE indeferir o pedido de GRATIFICA��O DE RAIOS-X</strong>  do servidor a seguir relacionado, por n�o se enquadrar nos requisitos estabelecidos pela Portaria n� 3214/78, do Minist�rio do Trabalho</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Concess�o (Adicional de insalubridade Grau m�ximo) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1031,'Concess�o (Adicional de insalubridade Grau m�ximo)','Concess�o (Adicional de insalubridade Grau m�ximo)','template/freemarker', null, 6, 1031,1);
	
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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		Concess�o (Adicional de insalubridade Grau m�ximo)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder o ADICIONAL DE INSALUBRIDADE, no Grau M�ximo (20%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor(es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exerc�cio, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Concess�o (Adicional de insalubridade Grau m�dio) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1032,'Concess�o (Adicional de insalubridade Grau m�dio)','Concess�o (Adicional de insalubridade Grau m�dio)','template/freemarker', null, 6, 1032,1);
	
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
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		Concess�o (Adicional de insalubridade Grau m�dio)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE conceder o ADICIONAL DE INSALUBRIDADE, no Grau M�dio (10%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exerc�cio, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Revoga��o (Insalubridade Grau M�dio) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1033,'Revoga��o (Insalubridade Grau M�dio)','Revoga��o (Insalubridade Grau M�dio)','template/freemarker', null, 6, 1033,1);
	
update SIGA.EX_MODELO set conteudo_blob_mod = utl_raw.cast_to_raw(' ') where id_mod = 1033;

select conteudo_blob_mod into dest_blob_ex_mod from SIGA.EX_MODELO where id_mod = 1033 for update;
src_blob_ex_mod := utl_raw.cast_to_raw(convert('
[#-- Bloco Entrevista --]

[@entrevista]

	[@grupo]
		[@texto var="num_portaria_rev" titulo="Portaria de Revoga��o"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  
	[@grupo]
		[@data var="dt_portaria_rev" titulo="Data da Portaria de Revoga��o" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
        [@texto titulo="N� do Boletim de Servi�o" var="num_boletim" /]
    [/@grupo]
	[@grupo]
        [@texto titulo="P�gina do Boletim de Servi�o" var="pg_boletim" /]
    [/@grupo]
	[@grupo]
		[@data var="dt_boletim" titulo="Data do Boletim de Servi�o" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdServidores" titulo="Quantidade de servidores" reler=true idAjax="qtdServidoresAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdServidoresAjax"]
        [#list 1..(qtdServidores)?number as i]
			[@grupo]
                [@texto titulo="Nome do Servidor" var="nome"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Matr�cula SIAPE" var="siape"+i /]
            [/@grupo]
            [@grupo]
				[@mensagem titulo="N� do Processo" texto="23069."/]
				[@texto var="sequencial"+i titulo="" largura="6" maxcaracteres="6" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="/"/]
				[@texto var="ano"+i titulo="" largura="4" maxcaracteres="4" obrigatorio=true desativado="${desabilitadoEdicao}"/]
				[@mensagem titulo="" texto="-"/]
				[@texto var="digito"+i titulo="" largura="2" maxcaracteres="2" obrigatorio=true desativado="${desabilitadoEdicao}"/]
			[/@grupo]
			[@grupo]
                [@texto titulo="Lota��o" var="lotacao"+i /]
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
  		Revoga��o (Insalubridade Grau M�dio)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es e considerando as determina��es contidas nos artigos 68 e 12, inciso I, das Leis 8.112/90 e 8.270/91, respectivamente, e tendo em vista o laudo pericial, e de acordo com a Orienta��o Normativa N� 6, de 18 de Mar�o de 2013 da Secretaria de Recursos Humanos do Minist�rio do Planejamento, Or�amento e Gest�o,</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE: </strong></p>
		<p style="text-align: justify;">1 - <strong>Revogar</strong> a Portaria n� ${num_portaria_rev!} de ${dt_portaria_rev!}, publicada no BS/UFF n� ${num_boletim!} de ${dt_boletim!}, p�g. ${pg_boletim!}, SE��O II;</p>
		<p style="text-align: justify;">2 - <strong>Conceder o ADICIONAL DE INSALUBRIDADE, no Grau M�dio (10%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exerc�cio, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="30%" align=center><strong>Nome</strong></td>
				<td width="15%" align=center><strong>Processo</strong></td>
				<td width="15%" align=center><strong>Lota��o</strong></td>
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

-- ######## PORTARIA: Retifica��o (Adicional de Insalubridade) ###############	

Insert into SIGA.EX_MODELO (ID_MOD,NM_MOD,DESC_MOD,CONTEUDO_TP_BLOB,ID_CLASSIFICACAO,ID_FORMA_DOC,HIS_ID_INI, HIS_ATIVO) 
values (1034,'Retifica��o (Adicional de Insalubridade)','Retifica��o (Adicional de Insalubridade)','template/freemarker', null, 6, 1034,1);
	
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
		[@texto var="desc_grau" titulo="Descri��o do Grau de Insalubridade"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
  	[@grupo]
		[@texto var="pct_grau" titulo="Porcentagem do Grau de Insalubridade"  largura="10" maxcaracteres="10" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
        [@texto titulo="N� do Boletim de Servi�o" var="num_boletim" /]
    [/@grupo]
	[@grupo]
        [@texto titulo="P�gina do Boletim de Servi�o" var="pg_boletim" /]
    [/@grupo]
	[@grupo]
		[@data var="dt_boletim" titulo="Data do Boletim de Servi�o" obrigatorio=true desativado="${desabilitadoEdicao}"/]
	[/@grupo]
	[@grupo]
         [@texto titulo="Nome do Servidor" var="nome" /]
    [/@grupo]
	[@grupo]
         [@texto titulo="Matr�cula SIAPE" var="siape" /]
    [/@grupo]

    [#assign valores = 1..100 /]  
    [@selecao var="qtdRetificoes" titulo="Quantidade de retifica��es" reler=true idAjax="qtdRetificoesAjax" opcoes=valores?join(";") /]
    [@grupo depende="qtdRetificoesAjax"]
        [#list 1..(qtdRetificoes)?number as i]
			[@grupo]
                [@texto titulo="Termo" var="termo"+i /]
            [/@grupo]
            [@grupo]
                [@texto titulo="Retifica��o" var="retificacao"+i /]
            [/@grupo]
        [/#list]
    [/@grupo]	
[/@entrevista]

[#-- Bloco Documento --]
[@documento]

[#assign texto_ementa]
  		Retifica��o (Adicional de Insalubridade)
[/#assign]

[#assign texto_portaria]
  		<p style="text-align: justify; text-indent:${recuo_paragrafo};"><strong>O REITOR DA UNIVERSIDADE FEDERAL FLUMINENSE</strong>, no uso de suas atribui��es legais, estatut�rias e regimentais;</p>
		<p style="text-indent:${recuo_paragrafo};"><strong>RESOLVE: </strong></p>
		<p style="text-align: justify;"><strong>1 - Retificar, em parte a Portaria n� ${num_portaria!} de ${dt_portaria!}</strong>, que concedeu o Adicional de Insalubridade, no Grau ${desc_grau!} (${pct_grau!}%), ao servidor ${nome!}, matr�cula SIAPE n� ${siape!} e publicado no BS/UFF n� ${num_boletim!} de ${dt_boletim!}, p�g. ${pg_boletim!} SE��O II.</p>
		<p style="text-align: justify;">2 - <strong>Conceder o ADICIONAL DE INSALUBRIDADE, no Grau M�dio (10%)</strong>, incidente sobre o vencimento do cargo efetivo, ao(s) servidor (es) a seguir relacionado(s), enquanto desempenhar(em) as atividades que ora executa(m) e permanecer(em) no atual local de exerc�cio, por estar(em) exposto(s) a ambiente(s) insalubre(s):</p>
		</br>
		<table width="100%">
			<tr>	
				<td width="50%" align=center><strong>Onde se L�</strong></td>
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
		<p style="text-align: justify;">2 - Esta Portaria entra em vigor na data de sua publica��o.	</p>
		
[/#assign]


[@portaria texto=texto_portaria ementa=texto_ementa/]
[/@documento]
','AL32UTF8'));
dbms_lob.append(dest_blob_ex_mod, src_blob_ex_mod);

END;
/