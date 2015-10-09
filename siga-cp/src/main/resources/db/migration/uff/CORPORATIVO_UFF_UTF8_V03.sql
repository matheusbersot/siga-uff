SET DEFINE OFF;

----------------TAGS PARA MODELOS FREEMARKER UFF ---------------------

DECLARE
  dest_blob BLOB;
  src_blob BLOB;
  
BEGIN

select conteudo_blob_mod into dest_blob from CORPORATIVO.cp_modelo where id_modelo = 1 for update;

src_blob := utl_raw.cast_to_raw(convert('
<!-- ------------------------ macros UFF ------------------------ -->','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#macro br]<br/>[/#macro]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#macro assinaturaCentroUff formatarOrgao=false]
<p style="font-family: Arial; font-size: 5 pt;" align="center">
_________________________________________
<br/>
    [#if (doc.nmSubscritor)??]
        ${doc.nmSubscritor?capitalize}
    [#else]
        ${((doc.subscritor.descricao)!)?capitalize}
    [/#if]
    [#if !apenasNome??] 
        <br />
        [#if apenasCargo??]
                ${((doc.subscritor.cargo.nomeCargo)!)?capitalize}
        [#else]
            [#if (doc.nmFuncao)??]
                ${doc.nmFuncao}
            [#elseif (doc.titular.funcaoConfianca.nomeFuncao)??]
                ${doc.titular.funcaoConfianca.nomeFuncao?capitalize}
                [#if (doc.titular.idPessoa)! != (doc.subscritor.idPessoa)!] EM EXERCÍCIO [/#if]
            [#elseif (doc.subscritor.funcaoConfianca.nomeFuncao)??]
                ${doc.subscritor.funcaoConfianca.nomeFuncao?capitalize}
            [#else]
                ${((doc.subscritor.cargo.nomeCargo)!)?capitalize}
            [/#if]
        [/#if]
         
        [#if formatarOrgao]
            <br>
            [#if (doc.nmLotacao)??]
                ${doc.nmLotacao}
            [#else]
                ${((doc.titular.lotacao.nomeLotacao)!)?capitalize}
            [/#if]
        [/#if]
        
                [#if (doc.mobilGeral.exMovimentacaoSet)??]
        [#list doc.mobilGeral.exMovimentacaoSet as mov]
                    [#if (mov.exTipoMovimentacao.idTpMov)! == 24]
                        <br/><br/><br/>
                        [#if mov.nmSubscritor??]
                            ${mov.nmSubscritor?capitalize}
                        [#else]
                            ${((mov.subscritor.nomePessoa)!)?capitalize}
                        [/#if]      
                        <br>
                        [#if mov.nmFuncao??]
                            ${mov.nmFuncao?capitalize}
                        [#elseif (mov.titular.funcaoConfianca.nomeFuncao)??]
                            ${mov.titular.funcaoConfianca.nomeFuncao?capitalize} 
                                [#if substituicao!false && ((doc.titular.idPessoa)!-1) != ((doc.subscritor.idPessoa)!-1)] EM EXERCÍCIO [/#if]
                        [#elseif (mov.subscritor.funcaoConfianca.nomeFuncao)??]
                            ${mov.subscritor.funcaoConfianca.nomeFuncao?capitalize}
                        [#else]
                            ${((mov.subscritor.cargo.nomeCargo)!)?capitalize}
                        [/#if]
                        [#if formatarOrgao]
                            <br>
                            [#if mov.nmLotacao??]
                                ${mov.nmLotacao?capitalize}
                            [#else]
                                ${mov.titular.lotacao.nomeLotacao?capitalize}
                            [/#if]
                        [/#if]
            [/#if]
        [/#list]
            [/#if]
    [/#if]
    [#if textoFinal??]
        <br/>${textoFinal?capitalize}
    [/#if]
</p>
[/#macro]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#macro estiloBrasaoCentralizadoPADUff tipo tamanhoLetra="11pt"]
    [@primeiroCabecalho]
    [@cabecalhoCentralizadoPrimeiraPagina/]
    [/@primeiroCabecalho]

    [@br/]
    [@br/]
    [@br/]
    [@br/]

    [@letra tamanho=tamanhoLetra]
          
            <table align="center" width="60%" border="1" cellspacing="1"  bgcolor="#000000">
              <tr>
                 <td width="30%" bgcolor="#FFFFFF" align="center"><br />
                 <b>${tipo} N&ordm;</b><br />
                 <br />
                 </td>

              </tr>

              <tr>
                 <td bgcolor="#FFFFFF" align="center" ><p>
                 <br/>${doc.codigo}<br/>&nbsp;</p>
                 </td>
                 </tr>
	    </table>

            [@br/]
            [@br/]
            [@br/]
            [@br/]
            [#nested]
            <p>&nbsp;</p>
            [@br/]
            [@br/]
            [@br/]
            [@br/] 
			[#if mov??]
            [@assinaturaMovCentro formatarOrgao=formatarOrgao/]
            [#else]
            [@assinaturaCentroUff formatarOrgao=formatarOrgao/]
            [/#if]           
    [/@letra]
    
    [@br/]

    [@primeiroRodape]
    [@rodapeClassificacaoDocumental/]       
    [/@primeiroRodape]

[/#macro]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#macro pad txCorpo tamanhoLetra="14pt" _tipo="Processo" ]
[#assign tl = tamanhoLetra /]
[#local negrito = "font-weight:bold"]

        [@estiloBrasaoCentralizadoPADUff tipo=_tipo tamanhoLetra=tl ]
                <span style="font-size: ${tl}"> ${txCorpo!} </span>                
        [/@estiloBrasaoCentralizadoPADUff]
[/#macro]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#function formatarCPF strCPF=""]
[#local strCPFFormatado = ""]
[#local strCPFSoComNumeros = ""]
[#list 0..(strCPF?length)-1 as i]
  [#if (strCPF[i]! == "0") || (strCPF[i]! == "1") || (strCPF[i]! == "2")  || (strCPF[i]! == "3")  || (strCPF[i]! == "4")  || (strCPF[i]! == "5") || (strCPF[i]! == "6") || (strCPF[i]! == "7") || (strCPF[i]! == "8") || (strCPF[i]! == "9")] 
     [#local strCPFSoComNumeros = "${strCPFSoComNumeros}${strCPF[i]}"]
  [/#if]
[/#list]
[#if strCPFSoComNumeros?length < 11]
  [#local strCPFSoComNumeros = strCPFSoComNumeros?left_pad(11, "0")]
[/#if]
[#local strCPFFormatado = "${strCPFSoComNumeros?substring(0,3)}.${strCPFSoComNumeros?substring(3,6)}.${strCPFSoComNumeros?substring(6,9)}-${strCPFSoComNumeros?substring(9,11)}"] 
[#return strCPFFormatado]
[/#function]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#assign codigos_fg = "FG-1;FG-2;FG-3;FG-4;FG-5;FG-6;FG-7;FG-8;FG-9;" /]','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

src_blob := utl_raw.cast_to_raw(convert('
[#assign localidades = "Angra dos Reis;Arraial do Cabo;Bom Jesus do Itabapoana;Cabo Frio;Campos dos Goytacazes;Itaperuna;Macaé;Miracema;Niterói;Nova Friburgo;Nova Iguaçu;Pinheiral;Quissamã;Rio das Ostras;Santo Antônio de Pádua;São João De Meriti;Volta Redonda" /]
','WE8ISO8859P1'));
dbms_lob.append(dest_blob, src_blob);

commit;
END;
/