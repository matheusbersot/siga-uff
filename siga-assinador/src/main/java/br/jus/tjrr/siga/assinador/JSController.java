package br.jus.tjrr.siga.assinador;

import java.util.ArrayList;
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

	public static ArrayList<byte[]> getDocuments() throws JSException, Exception {

		String dataToBuildURL = (String) chamarMetodoJS("getDataToBuildURL()");

		JSONParser parser = new JSONParser();
		JSONObject jsonDataToBuildURL;
		jsonDataToBuildURL = (JSONObject) parser.parse(dataToBuildURL);

		String urlBase = (String) jsonDataToBuildURL.get("urlBase");
		String urlPath = (String) jsonDataToBuildURL.get("urlPath");
		String url = "";

		JSONArray docs = (JSONArray) jsonDataToBuildURL.get("docs");
		ArrayList<byte[]> listDocs = new ArrayList<byte[]>();
		
		for(int i=0; i < docs.size(); ++i)
		{
			JSONObject doc = (JSONObject) docs.get(0);

			url = urlBase + urlPath + (String) doc.get("url") + "&semmarcas=1";

			String documentB64 = (String) chamarMetodoJS("getContent", new Object[] { url });
			if (documentB64 == null)
				throw new Exception("Não foi possível obter o conteúdo do documento a ser assinado");

			byte[] docBytes = Base64.getDecoder().decode(documentB64);
			listDocs.add(docBytes);
		}	

		return listDocs;
	}

}
