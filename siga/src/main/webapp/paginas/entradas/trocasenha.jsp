<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/sigatags" prefix="siga"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>
<style>
#passwordStrength {
	height: 10px;
	display: block;
	float: left;
}

.strength0 {
	width: 250px;
	background: #cccccc;
}

.strength1 {
	width: 50px;
	background: #ff0000;
}

.strength2 {
	width: 100px;
	background: #ff5f5f;
}

.strength3 {
	width: 150px;
	background: #56e500;
}

.strength4 {
	background: #4dcd00;
	width: 200px;
}

.strength5 {
	background: #399800;
	width: 250px;
}

.tabela-senha td {
	padding: 3px 5px 3px 5px;
}
</style>

<script type="text/javascript" language="Javascript1.1">

/*  converte para mai�scula a sigla do estado  */
function converteUsuario(nomeusuario){
	nomeusuario.value = nomeusuario.value.toUpperCase();
}

function validateUsuarioForm(form) {
	var s = document.getElementById("passwordStrength").className;
	if (s == "strength0" || s == "strength1" || s == "strength2") {
		alert("Senha muito fraca. Por favor, utilize uma senha com pelo menos 6 caracteres incluindo letras mai�sculas, min�sculas e n�meros");
		return false;
	}
	var p1 = document.getElementById("pass").value;
	var p2 = document.getElementById("pass2").value;
	if (p1 != p2) {
		alert("Repeti��o da nova senha n�o confere, favor redigitar.");
		return false;
	}
	return true;
}


function passwordStrength(password) {
        var desc = new Array();
        desc[0] = "Inaceit�vel";
        desc[1] = "Muito Fraca";
        desc[2] = "Fraca";
        desc[3] = "Razo�vel";
        desc[4] = "Boa";
        desc[5] = "Forte";
        var score   = 0;
        
        //if password bigger than 6 give 1 point
        if (password.length >= 6) score++;

        //if password has both lower and uppercase characters give 1 point      
        if ( ( password.match(/[a-z]/) ) && ( password.match(/[A-Z]/) ) ) score++;

        //if password has at least one number give 1 point
        if ( ( password.match(/[a-z]/) ||  password.match(/[A-Z]/) ) && (password.match(/\d+/))) score++;

        //if password has at least one special caracther give 1 point
        if ( password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;

        //if password bigger than 12 give another 1 point
        if (password.length >= 12) score++;
        
        //mininum requirements to be accepted by the AD
        if (score > 2 && (password.length < 6 || !password.match(/[a-z]/) || !password.match(/[A-Z]/) || !password.match(/\d+/)))
        	score = 2;

         document.getElementById("passwordDescription").innerHTML = desc[score];
         document.getElementById("passwordStrength").className = "strength" + score;
}
</script>

<siga:pagina popup="false" titulo="Troca de Senha">
	<!-- main content -->
	<div class="gt-bd clearfix">
		<div class="gt-content clearfix">
	<c:if test="${baseTeste}">
		<div id="msgSenha" style="font-size: 12pt;color: red; font-weight: bold;">ATEN��O: Esta � uma vers�o de testes. Para sua seguran�a, N�O utilize a mesma senha da vers�o de PRODU��O.</div>
	</c:if>
			<h1 class="gt-form-head">${param.titulo}</h1>

			<h2>${mensagem}</h2>
			<h2 class="gt-form-head">Trocar senha</h2>
			<div class="gt-form gt-content-box tabela-senha">
				<ww:form action="trocar_senha_gravar"
					onsubmit="return validateUsuarioForm(this);" method="post">
					<ww:hidden name="page" value="1" />
					<h1>${mensagem }</h1>

					<tr>
							<td><label>Matr�cula<a href="#"
								title="Ex.:	XX99999, onde XX � a sigla do seu �rg�o (T2, RJ e ES) e 99999 � o n�mero da sua matr�cula."><img
									style="position: relative; margin-top: -3px; top: +3px; left: +3px; z-index: 0;"
									src="/siga/css/famfamfam/icons/information.png" /> </a> </label></td>
							<td><label>Senha atual</label></td>									
					</tr>

					<tr>
						
							<td><ww:textfield name="nomeUsuario"
								onblur="javascript:converteUsuario(this)" theme="simple"
								cssClass="gt-form-text" /></td>
						<td><ww:password name="senhaAtual" theme="simple"
							cssClass="gt-form-text" /></td>
					</tr>

					</div>

					<tr>
						<td><label>Nova Senha<a href="#"
							title="Utilize mai�sculas, min�sculas e n�meros para aumentar a for�a da senha."><img
								style="position: relative; margin-top: -3px; top: +3px; left: +3px;"
								src="/siga/css/famfamfam/icons/information.png" /> </a> </label></td>
						<td><label>Repeti��o da nova senha</label></td>								
						<td><label>For�a da nova senha</label></td>
					</tr>

					<tr>
						<td><ww:password name="senhaNova" id="pass"
							onkeyup="passwordStrength(this.value)" theme="simple"
							cssClass="gt-form-text" /></td>
						
						<td><ww:password name="senhaConfirma" id="pass2" theme="simple"
							cssClass="gt-form-text" /></td>
						<td><div id="passwordDescription">Senha n�o informada</div><div id="passwordStrength" class="strength0"></div></td>
					</tr>
					<c:if test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;GI;INT_LDAP:Integrar ao Ldap')}">
						<tr>
							<td><input type="checkbox" checked="checked" id="trocarSenhaRede" name="trocarSenhaRede" style="float: left" class="gt-form-checkbox"></input><label>Trocar tamb�m a senha do computador, da rede e do e-mail</label></td>
						</tr>
					</c:if>
					<tr>
						<td><ww:submit label="OK" value="OK" theme="simple"
							cssClass="gt-btn-medium gt-btn-left" /></td>
					</tr>
				</ww:form>
			</div>
		</div>
	</div>
</siga:pagina>

