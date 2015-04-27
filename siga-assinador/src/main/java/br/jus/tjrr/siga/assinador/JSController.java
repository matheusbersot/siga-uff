package br.jus.tjrr.siga.assinador;

import java.util.Base64;

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

		String dataToBuildURL = (String) chamarMetodoJS("getDataToBuildURL()");

		JSONParser parser = new JSONParser();
		JSONObject jsonDataToBuildURL;
		jsonDataToBuildURL = (JSONObject) parser.parse(dataToBuildURL);

		String urlBase = (String) jsonDataToBuildURL.get("urlBase");
		String urlPath = (String) jsonDataToBuildURL.get("urlPath");
		String url = "";

		JSONArray docs = (JSONArray) jsonDataToBuildURL.get("docs");
		JSONObject doc = (JSONObject) docs.get(0);

		url = urlBase + urlPath + (String) doc.get("url") + "&semmarcas=1";
		
		JSObject response = (JSObject) chamarMetodoJS("getContent", new Object[] {url});
		if(response == null )
			throw new Exception("Erro na comunicação com o JavaScript");
		
		String responseText = (String) response.getSlot(0);
		String documentB64 = (String) response.getSlot(1);
		byte[] documentBytes = null;
		
		if(documentB64 != null) //document was returned
		{
			documentBytes = Base64.getDecoder().decode(documentB64);			
		}
		else
		{
			throw new Exception(responseText);
		}
		
		return documentBytes;
	}

}
