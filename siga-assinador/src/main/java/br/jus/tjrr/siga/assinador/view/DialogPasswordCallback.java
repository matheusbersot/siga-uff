package br.jus.tjrr.siga.assinador.view;

import org.mozilla.jss.util.Password;
import org.mozilla.jss.util.PasswordCallback;
import org.mozilla.jss.util.PasswordCallbackInfo;

public class DialogPasswordCallback implements PasswordCallback {

	@Override
	public Password getPasswordAgain(PasswordCallbackInfo arg0)
			throws GiveUpException {

		return null;
	}

	@Override
	public Password getPasswordFirstAttempt(PasswordCallbackInfo arg0)
			throws GiveUpException {

		DialogPassword dialogPassword = new DialogPassword();
		char[] result = dialogPassword.getResult();

		Password p = null;
		if(result != null)
		  p = new Password(result);
		
		return p;
	}

}
