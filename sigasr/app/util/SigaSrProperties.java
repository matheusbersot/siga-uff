package util;

import java.util.HashMap;

import play.Play;
import br.gov.jfrj.siga.base.SigaBaseProperties;
import br.gov.jfrj.siga.model.prop.ModeloPropriedade;

public class SigaSrProperties extends ModeloPropriedade {

	private String ambiente;
	
	protected SigaSrProperties() {
		// construtor privado
	}

	private static SigaSrProperties instance = new SigaSrProperties();

	public static String getString(final String key) {
		try {
			return instance.obterPropriedade(key);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	@Override
	public String getPrefixoModulo() {
		return "siga.sr";
	}
	
	public static String getAmbiente() {
		if (instance.ambiente == null)
			instance.ambiente = getString("ambiente");
		return instance.ambiente;
	}

}
