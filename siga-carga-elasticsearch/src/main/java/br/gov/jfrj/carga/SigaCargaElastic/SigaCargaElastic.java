package br.gov.jfrj.carga.SigaCargaElastic;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.hibernate.cfg.AnnotationConfiguration;

import br.gov.jfrj.siga.cp.bl.CpAmbienteEnumBL;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.model.dao.HibernateUtil;

public class SigaCargaElastic {

	private Logger logger = Logger
			.getLogger("br.gov.jfrj.carga.SigaCargaElastic");
	private Level logLevel = Level.WARNING;
	private Boolean logAtivado = false;

	private String servidorBD = "";
	private String arqSaida = "saida.json";

	public SigaCargaElastic(String[] args) {

		try {
			parseParametros(args);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (logAtivado) {
			log(">>>Iniciando em modo LOG!<<<\nUse -modoLog=false para sair do modo LOG e escrever as alterações");
		}
	}

	protected void parseParametros(String[] params) throws Exception {

		if (params.length < 1) {
			throw new Exception("Número de Parametros inválidos");
		}

		String servidor = params[0];
		if (!servidor.toLowerCase().contains("-prod")
				&& !servidor.toLowerCase().contains("-desenv")
				&& !servidor.toLowerCase().contains("-homolo")
				&& !servidor.toLowerCase().contains("-treina")) {
			throw new Exception("Servidor não informado");
		}
		this.servidorBD = servidor.substring(servidor.indexOf("-") + 1);

		for (String param : Arrays.asList(params)) {

			if (param.startsWith("-arqSaida=")) {
				this.arqSaida = param.split("=")[1];
			} else if (param.equals("-modoLog=true")) {
				logAtivado = true;
			} else if (param.startsWith("-logLevel")) {
				setLogLevel(param.split("=")[1]);
			}
		}
	}

	private void setLogLevel(String logLevel) {
		this.logLevel = Level.parse(logLevel);
	}

	private void log(String message) {
		logger.log(logLevel, message);
	}

	/**
	 * @param args
	 *            - recebe os parametros da linha de comando. Os parâmetros
	 *            devem ser definidos na ordem abaixo:
	 * 
	 *            ****Banco de dados**** -prod --> aponta para o banco de dados
	 *            de produção -homolo --> aponta para o banco de dados de
	 *            homologação -treina --> aponta para o banco de dados de
	 *            treinamento -desenv --> aponta para o banco de dados de testes
	 * 
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		SigaCargaElastic carga = new SigaCargaElastic(args);
		carga.executar();
	}

	public void executar() throws Exception {

		AnnotationConfiguration cfg;

		if (servidorBD.equals("prod"))
			cfg = ExDao.criarHibernateCfg(CpAmbienteEnumBL.PRODUCAO);
		else if (servidorBD.equals("homolo"))
			cfg = ExDao.criarHibernateCfg(CpAmbienteEnumBL.HOMOLOGACAO);
		else if (servidorBD.equals("treina"))
			cfg = ExDao.criarHibernateCfg(CpAmbienteEnumBL.TREINAMENTO);
		else if (servidorBD.equals("desenv"))
			cfg = ExDao.criarHibernateCfg(CpAmbienteEnumBL.DESENVOLVIMENTO);
		else
			cfg = ExDao.criarHibernateCfg(CpAmbienteEnumBL.DESENVOLVIMENTO);

		HibernateUtil.configurarHibernate(cfg, "");

		Date dt = new Date();
		log("--- Processando  " + dt + "--- ");
		log("--- Parametros: servidor= " + servidorBD + "  e arqSaida= "
				+ arqSaida);

		ExDao.getInstance().listarFeriados();

		List<ExDocumento> listaDocumentos = ExDao.getInstance()
				.obterTodosDocumentos();
		List<ExMovimentacao> listaMovimentacoes = ExDao.getInstance()
				.obterTodasMovimentacoes();

		exportarJson(listaDocumentos, listaMovimentacoes);
		
		
		log(" ---- Fim do Processamento --- ");
	}
	
	private String gerarAcaoIndexaoJson(String nomeIndice, String tipo, Long id)
	{
		StringBuilder sb = new StringBuilder();
		sb.append("{\"index\":{\"_index\":\"");
		sb.append(nomeIndice);
		sb.append("\",\"_type\":\"");
		sb.append(tipo);
		sb.append("\",\"_id\":");
		sb.append(id);
		sb.append("}}");
		return sb.toString();		
	}

	public void exportarJson(List<ExDocumento> listaDocumentos,
			List<ExMovimentacao> listaMovimentacoes) throws IOException {
		
		FileWriter saida = null;
		try {
			saida = new FileWriter(arqSaida);
			
			for (ExDocumento doc : listaDocumentos) {
				saida.write(gerarAcaoIndexaoJson("documentos", "documento", doc.getIdDoc()));	
				saida.write("\n");
				saida.write(doc.toJson());
				saida.write("\n");
			}
			
			for (ExMovimentacao mov : listaMovimentacoes) {
				saida.write(gerarAcaoIndexaoJson("movimentacoes", "movimentacao", mov.getIdMov()));	
				saida.write("\n");
				saida.write(mov.toJson());
				saida.write("\n");				
			}
			
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (saida != null){			
				saida.close();
			}			
		}
	}
}
