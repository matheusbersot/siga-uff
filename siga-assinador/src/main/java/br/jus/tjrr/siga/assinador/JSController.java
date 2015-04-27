package br.jus.tjrr.siga.assinador;

import netscape.javascript.JSException;
import netscape.javascript.JSObject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class JSController {

	private static JSObject jsObject;

	public static void setJsObject(JSObject jsObject) {
		JSController.jsObject = jsObject;
	}

	private static Object chamarMetodoJS(final String metodo) {
		return jsObject.eval(metodo);
	}

	private static Object chamarMetodoJS(String metodo, Object[] parametros) {
		return jsObject.call(metodo, parametros);
	}

	public static byte[] getDocuments() throws JSException, Exception {

		// obter dados para auxiliar no processo de assinatura do
		// documento
		String dadosGerais = (String) chamarMetodoJS("getDataToSignDocument()");

		JSONParser parser = new JSONParser();
		JSONObject jsonDadosGerais;
		jsonDadosGerais = (JSONObject) parser.parse(dadosGerais);

		String urlBase = (String) jsonDadosGerais.get("urlBase");
		String urlPath = (String) jsonDadosGerais.get("urlPath");

		String url = "";

		JSONArray docs = (JSONArray) jsonDadosGerais.get("docs");

		JSONObject doc = (JSONObject) docs.get(0);
		url = urlBase + urlPath + (String) doc.get("url") + "&semmarcas=1";
		
		Object resposta = chamarMetodoJS("getContent", new Object[] {url});
		if(resposta == null )
			throw new Exception("resposta nula");
		
		JSObject r1 = (JSObject) resposta;
		Object responseText = r1.getSlot(0);
		Object document = r1.getSlot(1); 
		
		/*if (resposta.getSlot(0) instanceof String) {
			throw new Exception((String) resposta.getSlot(0));
		} else {
			byte[] dados = (byte[]) resposta.getSlot(1);
			if (dados == null) {
				throw new Exception("Não foi possível obter o arquivo PDF.");
			} else {
				return dados;
			}
		}*/
		
		String b = "aaa";
		return b.getBytes();
	}

}
