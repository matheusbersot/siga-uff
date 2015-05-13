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

	private static Object chamarMetodoSincronoJS(final String metodo) {
		return jsObject.call(metodo);
	}
	
	private static Object chamarMetodoSincronoJS(final String metodo,
			final String listener, Object[] parametros) {

		return jsObject.call(metodo, parametros);
	}

	private static Object chamarMetodoAssincronoJS(final String metodo,
			final String listener) {

		jsObject.call(metodo);

		JSObject obj = null;

		int numTries = Constants.NUMBER_TRIES;
		do {
			obj = (JSObject) jsObject.call(listener);
			numTries--;
		} while (obj == null && numTries > 0);

		return obj;
	}

	private static Object chamarMetodoAssincronoJS(final String metodo,
			final String listener, Object[] parametros) {

		jsObject.call(metodo, parametros);

		JSObject obj = null;

		int numTries = Constants.NUMBER_TRIES;
		do {
			obj = (JSObject) jsObject.call(listener);
			numTries--;
		} while (obj == null && numTries > 0);

		return obj;
	}

	public static ArrayList<byte[]> getDocuments() throws JSException,
			Exception {

		String dataToBuildURL = (String) chamarMetodoSincronoJS("getDataToBuildURL()");

		JSONParser parser = new JSONParser();
		JSONObject jsonDataToBuildURL;
		jsonDataToBuildURL = (JSONObject) parser.parse(dataToBuildURL);

		String urlBase = (String) jsonDataToBuildURL.get("urlBase");
		String urlPath = (String) jsonDataToBuildURL.get("urlPath");
		String url = "";

		JSONArray docs = (JSONArray) jsonDataToBuildURL.get("docs");
		ArrayList<byte[]> listDocs = new ArrayList<byte[]>();

		for (int i = 0; i < docs.size(); ++i) {
			JSONObject doc = (JSONObject) docs.get(0);

			url = urlBase + urlPath + (String) doc.get("url") + "&semmarcas=1";

			JSObject response = (JSObject) chamarMetodoAssincronoJS("getContent", "requestListener", new Object[] { url });
			String documentB64 = (String) response.getSlot(0);
			String errorMsg = (String) response.getSlot(1);

			if (errorMsg != null)
				throw new Exception(errorMsg);

			byte[] docBytes = Base64.getDecoder().decode(documentB64);
			listDocs.add(docBytes);
		}

		return listDocs;
	}
}
