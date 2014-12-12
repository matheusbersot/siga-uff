package br.gov.jfrj.siga.dump;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DumpApp {

	private static final String OPT_TAB_USE_VALOR = "useValor";
	private static final String OPT_TAB_WHERE = "where";
	private static final String OPT_TAB_USE_NULL = "useNull";
	private static final String OPT_TAB_PK_SEQ = "pkSeq";
	private static final String PARAM_PWD_DB = "-pwdDB=";
	private static final String PARAM_USR_DB = "-usrDB=";
	private static final String PARAM_URL_DB = "-urlDB=";
	private static final String PARAM_UPDATES = "-updates=";
	private static final String PARAM_INSERTS = "-inserts=";
	private static final String PARAM_ARQUIVO_SAIDA = "-arquivoSaida=";
	private static final String PARAM_TABELAS = "-tabelas=";
	private final static List<String> _tabs= new ArrayList<String>();
	private final static List<String> _tabs_opts= new ArrayList<String>();

	private static String _arq = null;
	private static Boolean _ins = true;
	private static Boolean _upt = true;
	private static String _url_db = null;
	private static String _usr_db = null;
	private static String _pwd_db = null;
	
	
	private List<String> tabelas;
	private List<String> tabelasOpcoes;
	private String arquivoSaida;
	private Boolean processarInserts;
	private Boolean processarUpdates;
	private String urlDB;
	private String userDB;
	private String passDB;
	
	
	
	private Connection connection;
	
	private List<String> inicioScript = new ArrayList<String>();
	private List<String> inserts = new ArrayList<String>();
	private List<String> updates = new ArrayList<String>();
	private List<String> fimScript = new ArrayList<String>();
	

	public DumpApp(List<String> tabelas,List<String> tabelasOpcoes, String arquivoSaida, Boolean processarInserts, Boolean processarUpdates, String urlDB, String userDB, String passDB) {
		this.tabelas = tabelas;
		this.tabelasOpcoes = tabelasOpcoes;
		this.arquivoSaida = arquivoSaida;
		this.processarInserts = processarInserts;
		this.processarUpdates = processarUpdates;
		this.urlDB = urlDB;
		this.userDB = userDB;
		this.passDB = passDB;		
	}

	public static void main(String[] args) throws SQLException, IOException {
		System.out.println("Iniciando exportação...");
		processarArgumentos(args);
		DumpApp app = new DumpApp(_tabs,_tabs_opts,_arq,_ins,_upt,_url_db, _usr_db,_pwd_db);
		app.dump();
		System.out.println("Aplicação encerrada!");
	}

	/**
	 * Executa o dump
	 * @throws SQLException 
	 * @throws IOException 
	 */
	private void dump() throws SQLException, IOException {
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		 connection = DriverManager.getConnection(urlDB, userDB, passDB);
		 
		 inicioScript.add(getInicioScript());
		 List<String> resultadoDump = null;
		 for (int i = 0; i < tabelas.size(); i++) {
			 resultadoDump = dump(tabelas.get(i),tabelasOpcoes.get(i));
		 }
			 
		 fimScript.add(getFimScript());
		
		 
		enviarParaSaida(resultadoDump);
	}

	private void enviarParaSaida(List<String> resultadoDump) throws IOException {
		File file = new File(arquivoSaida);
		FileWriter fw = new FileWriter(file);
		
		for (String linha : inicioScript) {
			fw.write(linha + "\n");
		}
		for (String linha : resultadoDump) {
			fw.write(linha + "\n");
		}
		for (String linha : fimScript) {
			fw.write(linha + "\n");
		}
		
		fw.close();
	}

	private List<String> dump(String nomeTabela, String optTabela) throws SQLException {
		inserts.add("\n\n-- INSERTS " + nomeTabela + "\n\n");
		updates.add("\n\n-- UPDATES " + nomeTabela+ "\n\n");
		
		String pk = getPrimaryKey(nomeTabela,optTabela) ;
		
		String sql = "select * from " + nomeTabela + " " + getWhere(optTabela) + " " + getOrderBy(pk);
		
		PreparedStatement stm = connection.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		
		List<String> colunas = new ArrayList<String>();
		for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
			colunas.add(rs.getMetaData().getColumnName(i));
		}
		
		List<Object> valores = new ArrayList<Object>();
		
		while(rs.next()){
			
			String pkValue=null;
			
			boolean contemBlob = false;
			String campoBlob = null;
			String blobValue =null;
			
			for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
				//pk
				if(pk!=null && rs.getMetaData().getColumnName(i).equals(pk)){
					pkValue = rs.getObject(i).toString();
					String pkSeq = getPkSequence(optTabela);
					if(pkSeq!=null){
						valores.add(pkSeq);
						continue;
					}
				}
				
				//nulls
				if(campoDeveSeNulo(rs.getMetaData().getColumnName(i),optTabela)){
					valores.add(null);
					continue;
				}
				
				//campo tem valor definido
				String valorDefinido = campoComValorDefinido(rs.getMetaData().getColumnName(i),optTabela);
				if(valorDefinido !=null){
					valores.add(valorDefinido);
					continue;
				}
				
				
				if (rs.getMetaData().getColumnType(i) == Types.BLOB){
					contemBlob=true;
					campoBlob=rs.getMetaData().getColumnName(i);
					valores.add(null);
					try {
						blobValue = rs.getBytes(i)==null?null:blobToString(rs.getBytes(i));
					} catch (Exception e) {
						System.out.println(nomeTabela + "." + campoBlob + " com tamanho excedido (>32k)." + pk + "=" + pkValue );
						blobValue = "BLOB MAIOR QUE 32K!";
					}
				}else if(rs.getMetaData().getColumnType(i) == Types.TIMESTAMP){
					valores.add(rs.getString(i)==null?null:toDate(rs.getString(i)));
					
				}else if (rs.getMetaData().getColumnType(i) == Types.VARCHAR){
					valores.add(rs.getString(i)==null?null:getAspas(rs.getString(i)));
					
				}else {
					valores.add(rs.getObject(i));	
				}
				
			}
			
			
			inserts.add(getInsertCmd(nomeTabela,colunas,valores));
			if(contemBlob  && blobValue !=null){
				inserts.add(getUpdateBlobCmd(nomeTabela,campoBlob,blobValue,pk,pkValue));
				updates.add(getUpdateBlobCmd(nomeTabela,campoBlob,blobValue,pk,pkValue));
			}else{
				updates.add(getUpdateCmd(nomeTabela,pk,colunas,valores));	
			}
			
			
			valores = new ArrayList<Object>();
		}
		
		List<String> result = new ArrayList<String>();
		if(processarInserts){
			result.addAll(inserts);	
		}
		if(processarUpdates){
			result.addAll(updates);	
		}
		

		return result;
	}

	private String campoComValorDefinido(String nomeColuna, String optTabela) {
		String valoresDefinidos = getValorOpt(OPT_TAB_USE_VALOR, optTabela);
		if(valoresDefinidos !=null){
			List<String> lstValoresDefinidos = Arrays.asList(valoresDefinidos.split(","));
			for (String valorDefinido : lstValoresDefinidos) {
				if(valorDefinido.split("=")[0].equals(nomeColuna)){
					return valorDefinido.split("=")[1];
				}
			}
		}

		return null;
	}

	private String getOrderBy(String pk) {
		return pk==null?"":" ORDER BY " + pk;
	}

	private String getWhere(String optTabela) {
		String where  = getValorOpt(OPT_TAB_WHERE, optTabela);
		if (where!=null && where.length()>0){
			return "WHERE " +where;
		}
		return "";
	}

	private boolean campoDeveSeNulo(String nomeColuna, String optTabela) {
		String useNull = getValorOpt(OPT_TAB_USE_NULL, optTabela); 
		if (useNull!=null){
			List<String> lstNulls = Arrays.asList(useNull.split(","));	
			return lstNulls.contains(nomeColuna);
		}
		
		return false;
	}

	private String getPkSequence(String optTabela) {
		return getValorOpt(OPT_TAB_PK_SEQ, optTabela);
	}

	private String getValorOpt(String campoOpt, String listaOpt) {
		if(listaOpt==null){
			return null;
		}
		List<String> lstOpts = Arrays.asList(listaOpt.split("&"));
		for (String o : lstOpts) {
			if(o.contains(campoOpt +":")){
				return o.split(":")[1];
			}
		}
		return null;
	}

	private String getUpdateBlobCmd(String nomeTabela, String campoBlob, String blobValue, String pk, String pkValue) {
		StringBuffer sb = new StringBuffer();
		getInicioScript();
		sb.append("\n");
		sb.append("\tUPDATE "	+ nomeTabela + " SET " + campoBlob + " = utl_raw.cast_to_raw(' ') WHERE " + pk + " = " + pkValue + ";\n");
		sb.append("\tSELECT "	+ campoBlob	+ " INTO dest_blob FROM " + nomeTabela + " WHERE " + pk + " = " + pkValue + " FOR UPDATE;\n");
		sb.append("\tsrc_blob := utl_raw.cast_to_raw(convert('");
		sb.append(blobValue);
		sb.append("','AL32UTF8'));\n");
		sb.append("\tdbms_lob.append(dest_blob, src_blob);\n");
		getFimScript();
		return sb.toString();
	}

	private String getFimScript() {
		StringBuffer sb = new StringBuffer();
		sb.append("END;\n");
		sb.append("/\n");
		return sb.toString();
	}

	private String getInicioScript() {
		StringBuffer sb = new StringBuffer();
		sb.append("SET DEFINE OFF\n");
		sb.append("DECLARE\n");
		sb.append("\tdest_blob BLOB;\n");
		sb.append("\tsrc_blob BLOB;\n");
		sb.append("BEGIN\n");
		return sb.toString();
	}

	private String toDate(String str) {
		return "to_date('" + str + "','yyyy-mm-dd HH24:mi:ss')";
	}

	private String getAspas(String str) {
		return "'" + str.replaceAll("'", "''") + "'";
	}

	private String getPrimaryKey(String nomeTabela, String optTabela) throws SQLException {
		String pkDefinida = getValorOpt("pk", optTabela);  
		if (pkDefinida!=null){
			return pkDefinida;
		}else{
			return detectarPK(nomeTabela);
		}
		
	}

	private String detectarPK(String nomeTabela) throws SQLException {
		ResultSet rsPK = connection.getMetaData().getPrimaryKeys(null, null, nomeTabela);
		rsPK.next();
		try{
			return rsPK.getString(4);	
		}catch(Exception e){
			return null;
		}
	}

	private String blobToString(byte[] bytes) throws Exception {
		int dbms_output_limit = 2^32*1000; //32kB
		if(bytes.length<=dbms_output_limit){
			return new String(bytes).replaceAll("'", "''");	
		}else{
			throw new Exception("Um blob é maior que 32k!" + bytes.length);
		}
		

	}

	private String getInsertCmd(String nomeTabela,List<String> colunas, List<Object> valores) {
		String lstColunas = colunas.toString().replaceAll("^\\[|\\]$", "");
		String lstValores = valores.toString().replaceAll("^\\[|\\]$", "");
		return "INSERT INTO " + nomeTabela + " (" + lstColunas + ") VALUES (" + lstValores + ");";
	}

	private String getUpdateCmd(String nomeTabela,String pk, List<String> colunas, List<Object> valores) {
		List<String> lstSet = new ArrayList<String>();
		String valorPk = null;
		for (int i = 0; i < colunas.size(); i++) {
			lstSet.add(colunas.get(i) + "=" + String.valueOf(valores.get(i)));
			if (colunas.get(i).equals(pk)){
				valorPk = valores.get(i).toString();
			}
		}
		
		String updt =  "UPDATE " + nomeTabela + " SET " + lstSet + " WHERE " + pk + " = " + valorPk +";";
		return updt.replaceAll("\\[|\\]", "");
	}

	/**
	 * Extrai os arqumentos passados na linha de comando
	 * @param pars
	 */
	private static void processarArgumentos(String[] pars) {
		if (pars.length < 5) {
			System.err.println("Número de Parametros inválidos!");
			System.err.println("Parâmetros possíveis:");
			System.err.println(PARAM_TABELAS);
			System.err.println(PARAM_ARQUIVO_SAIDA);
			System.err.println(PARAM_INSERTS);
			System.err.println(PARAM_UPDATES);
			System.err.println(PARAM_URL_DB);
			System.err.println(PARAM_USR_DB);
			System.err.println(PARAM_PWD_DB);
		}

		for (String param : Arrays.asList(pars)) {
			if (param.startsWith(PARAM_TABELAS)) {
				String t = param.split(PARAM_TABELAS)[1];
				List<String> lstTabs = Arrays.asList(t.split(";"));
				for (String tab : lstTabs) {
					String nomeTab = tab.replaceAll("[{].*", "");
					String tabParams = tab.replaceAll(".*[{]|[}]", "");
					_tabs.add(nomeTab);
					_tabs_opts.add(tabParams.equals(nomeTab)?null:tabParams);
				}
			}
			
			if (param.startsWith(PARAM_ARQUIVO_SAIDA)) {
				String a = param.split("=")[1];
				_arq=a;
			}
			
			if (param.startsWith(PARAM_INSERTS)) {
				String a = param.split("=")[1];
				_ins=Boolean.valueOf(a);
			}
			if (param.startsWith(PARAM_UPDATES)) {
				String a = param.split("=")[1];
				_upt=Boolean.valueOf(a);
			}
			if (param.startsWith(PARAM_URL_DB)) {
				String a = param.split("=")[1];
				_url_db=a;
			}
			if (param.startsWith(PARAM_USR_DB)) {
				String a = param.split("=")[1];
				_usr_db=a;
			}
			if (param.startsWith(PARAM_PWD_DB)) {
				String a = param.split("=")[1];
				_pwd_db=a;
			}
			
			

			
		}

	}
	
}
