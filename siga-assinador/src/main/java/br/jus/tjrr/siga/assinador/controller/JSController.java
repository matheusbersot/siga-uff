package br.jus.tjrr.siga.assinador.controller;

import java.util.HashMap;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import netscape.javascript.JSObject;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import br.jus.tjrr.siga.assinador.Constants;
import br.jus.tjrr.siga.assinador.Document;

public class JSController {

	private static Logger logger = Logger.getLogger(JSController.class.getName());
	
	private static JSObject jsObject;
	

	public static void setJsObject(JSObject jsObject) {
		JSController.jsObject = jsObject;
	}

	private static Object chamarMetodoSincronoJS(final String method) {
		return jsObject.call(method, null);
	}	
	
	private static Object chamarMetodoSincronoJS(final String method, Object[] parameters) {
		return jsObject.call(method, parameters);
	}
	
	public static HashMap<String, Document> getDocuments() throws ParseException
	{
		String dataToBuildURL = (String) chamarMetodoSincronoJS("buildUrl");
		
		JSONParser parser = new JSONParser();
		JSONObject jsonDataToBuildURL;
		jsonDataToBuildURL = (JSONObject) parser.parse(dataToBuildURL);

		JSONArray docs = (JSONArray) jsonDataToBuildURL.get("docs");		
		HashMap<String, Document> listDocs = new HashMap<String, Document>();
		
		logger.log(Level.INFO,"DOCS.SIZE = " + docs.size());
		
		for (int i = 0; i < docs.size(); ++i) {
			JSONObject doc = (JSONObject) docs.get(i);
			
			if((Boolean) doc.get("chk"))
			{		
				Document d = new Document((String) doc.get("name"), (String) doc.get("url"), (Boolean) doc.get("chk"));
				listDocs.put((String) doc.get("name"), d);
			}
		}
		
		return listDocs;
	}
	
	public static byte[] getDocumentContent(Entry<String, Document> docInf) throws Exception
	{
		byte[] docBytes = null;
		
		String dataToBuildURL = (String) chamarMetodoSincronoJS("buildUrl");
		
		JSONParser parser = new JSONParser();
		JSONObject jsonDataToBuildURL;
		jsonDataToBuildURL = (JSONObject) parser.parse(dataToBuildURL);

		String urlBase = (String) jsonDataToBuildURL.get("urlBase");
		String urlPath = (String) jsonDataToBuildURL.get("urlPath");
		String url = "";
		
		Document doc = docInf.getValue(); 
		
		if(doc.isChecked())
		{	
			url = urlBase + urlPath + doc.getUrl() + "&semmarcas=1";			

			JSObject response = (JSObject) chamarMetodoSincronoJS("getContent", new Object[] { url });
			String documentB64 = (String) response.getSlot(0);
			String errorMsg = (String) response.getSlot(1);

			if (errorMsg != null)
				throw new Exception(errorMsg);
			
			logger.log(Level.INFO,"DOCUMENTB64 = " + documentB64);

			logger.log(Level.INFO,"TAMANHO DOS DOCUMENTB64 = " + documentB64.length() + " bytes.");
			
			docBytes = Base64.decodeBase64(documentB64);
			
			logger.log(Level.INFO,"TAMANHO DOS DADOS = " + docBytes.length + " bytes.");			
		}
		
		return docBytes;
	}
	
	public static int getQtyDocuments()
	{
		Integer qty = (Integer) chamarMetodoSincronoJS("getQtyDocuments");
		return  qty;
	}
	
	/*public static HashMap<String, byte[]> getDocuments() throws JSException,
			Exception {

		String dataToBuildURL = (String) chamarMetodoSincronoJS("buildUrl");
		
		JSONParser parser = new JSONParser();
		JSONObject jsonDataToBuildURL;
		jsonDataToBuildURL = (JSONObject) parser.parse(dataToBuildURL);

		String urlBase = (String) jsonDataToBuildURL.get("urlBase");
		String urlPath = (String) jsonDataToBuildURL.get("urlPath");
		String url = "";

		JSONArray docs = (JSONArray) jsonDataToBuildURL.get("docs");
		HashMap<String, byte[]> listDocs = new HashMap<String,byte[]>();

		for (int i = 0; i < docs.size(); ++i) {
			JSONObject doc = (JSONObject) docs.get(i);
			
			if((Boolean) doc.get("chk"))
			{	
				url = urlBase + urlPath + (String) doc.get("url") + "&semmarcas=1";			
	
				JSObject response = (JSObject) chamarMetodoSincronoJS("getContent", new Object[] { url });
				String documentB64 = (String) response.getSlot(0);
				String errorMsg = (String) response.getSlot(1);
	
				if (errorMsg != null)
					throw new Exception(errorMsg);
				
				logger.log(Level.INFO,"DOCUMENTB64 = " + documentB64);
	
				logger.log(Level.INFO,"TAMANHO DOS DOCUMENTB64 = " + documentB64.length() + " bytes.");
				
				byte[] docBytes = Base64.decodeBase64(documentB64);
				listDocs.put((String) doc.get("name"), docBytes);
				
				logger.log(Level.INFO,"TAMANHO DOS DADOS = " + docBytes.length + " bytes.");
			}
		}

		return listDocs;
	}*/
	
	public static void sendDataToSigadoc(String documentCode, boolean isCopy, String signatureB64, String signer) 
			throws Exception
	{	
		Object response = (Object) chamarMetodoSincronoJS("sendDataToSigadoc", 
				         new Object[] { documentCode, isCopy, signatureB64, signer });	
		
		String responseValue = (String) response;
		logger.log(Level.INFO,"sendDataToSigadoc - response == " + responseValue);
		if(responseValue.compareTo(Constants.HTTP_OK) != 0)
		{
			throw new Exception(responseValue);	
		}
	}
	
	public static void redirectToDocumentPage()
	{
		chamarMetodoSincronoJS("redirectToNextURL");		
	}
}
