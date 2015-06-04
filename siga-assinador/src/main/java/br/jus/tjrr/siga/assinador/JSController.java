package br.jus.tjrr.siga.assinador;

import java.util.ArrayList;

import netscape.javascript.JSException;
import netscape.javascript.JSObject;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class JSController {

	private static JSObject jsObject;

	public static void setJsObject(JSObject jsObject) {
		JSController.jsObject = jsObject;
	}

	private static Object chamarMetodoSincronoJS(final String metodo) {
		return jsObject.call(metodo, null);
	}	

	private static Object chamarMetodoAssincronoJS(final String metodo,
			final String metodoResultado, Object[] parametros) throws Exception {

	    jsObject.call(metodo, parametros);

		Object obj = null;

		int numTries = Constants.NUMBER_TRIES;
		do {
			obj = jsObject.call(metodoResultado, null);
			Thread.sleep(Constants.SLEEP_TIME);

			numTries--;
		} while (obj == null && numTries > 0);
		
		if(obj == null)
			throw new Exception(Constants.ERROR_JAVASCRIPT_COMMUNICATION);

		return obj;
	}
	
	public static ArrayList<byte[]> getDocuments() throws JSException,
			Exception {

		String dataToBuildURL = (String) chamarMetodoSincronoJS("buildUrl");
		
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

			JSObject response = (JSObject) chamarMetodoAssincronoJS("getContent", "getResponse", new Object[] { url });
			String documentB64 = (String) response.getSlot(0);
			String errorMsg = (String) response.getSlot(1);

			if (errorMsg != null)
				throw new Exception(errorMsg);

			System.out.println("TAMANHO DOS DOCUMENTB64 = " + documentB64.length() + " bytes.");
			
			byte[] docBytes = Base64.decodeBase64(documentB64);
			listDocs.add(docBytes);
			
			System.out.println("TAMANHO DOS DADOS = " + docBytes.length + " bytes.");
		}

		return listDocs;
	}
	
	public static String getUrlPost()
	{
		Object url = chamarMetodoSincronoJS("getUrlPost");
		if(url != null)
		{
			return (String) url;
		}
		return null;
	}
	
	public static void sendDataToSigadoc(String url, String documentCode, boolean isCopy, String signatureB64, String signer) 
			throws Exception
	{
		Object response = (Object) chamarMetodoAssincronoJS("sendDataToSigadoc", 
				"getResponse", new Object[] { url, documentCode, isCopy, signatureB64, signer });
		
		if (response == null)
			throw new Exception(Constants.ERROR_JAVASCRIPT_COMMUNICATION);
		else
		{
			String responseValue = (String) response;
			if(responseValue.compareTo(Constants.HTTP_OK) != 0)
			{
				throw new Exception(responseValue);	
			}			
		}
	}
}
