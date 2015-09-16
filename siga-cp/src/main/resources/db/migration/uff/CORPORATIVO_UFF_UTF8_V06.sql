----------------MACRO NORMA DE SERVIÇO ---------------------
DECLARE
  dest_blob BLOB;
  src_blob BLOB;
  
BEGIN
	select conteudo_blob_mod into dest_blob from CORPORATIVO.cp_modelo where id_modelo = 1 for update;
	src_blob := utl_raw.cast_to_raw(convert('
	[#macro norma_servico texto abertura="" tamanhoLetra="Normal" _tipo="NORMA DE SERVIÇO" ementa=""]
	    [#if tamanhoLetra! == "Normal"]
	        [#assign tl = "11pt" /]
	    [#elseif tamanhoLetra! == "Pequeno"]
	        [#assign tl = "9pt" /]
	    [#elseif tamanhoLetra! == "Grande"]
	        [#assign tl = "13pt" /]
	    [#else]     
	        [#assign tl = "11pt"]
	    [/#if]
	    [@estiloBrasaoCentralizado tipo=_tipo tamanhoLetra=tl formatarOrgao=false numeracaoCentralizada=true]
	        [@mioloDJE]
	            [#if ementa != ""]     
	              <table style="float:none;" width="100%" border="0" cellpadding="2" cellspacing="0" bgcolor="#FFFFFF">
	                  <tr>
	                      <td align="left" width="50%"></td>
	                      <td align="left" width="50%" style="font-family: Arial; font-size: ${tl};"><br/><span style="font-weight: bold">EMENTA:&nbsp;</span>${ementa!}</td>
	                  </tr>
	              </table>
	              <br/><br/>
	            [/#if]
	            
	            <div style="font-family: Arial; font-size: ${tl};">
	                [#if abertura != ""] 
	                    [@aberturaBIE]
	                        ${abertura!}
	                    [/@aberturaBIE]
	                [/#if]
	                [@corpoBIE]
	                    ${texto!}
	                [/@corpoBIE]
	                <span style="font-family: Arial; font-size: ${tl}">
	                [@fechoBIE]
	                    Publique-se, registre-se e cumpra-se.</span>
	                [/@fechoBIE]
	            </div>            
	        [/@mioloDJE]
	     [/@estiloBrasaoCentralizado]
	[/#macro]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);
END;
/
