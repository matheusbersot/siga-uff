
/*******************************************************************************
 * Copyright (c) 2006 - 2011 SJRJ.
 * 
 *     This file is part of SIGA.
 * 
 *     SIGA is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     SIGA is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with SIGA.  If not, see <http://www.gnu.org/licenses/>.
 ******************************************************************************/
package br.gov.jfrj.siga.ex.service.impl;

import java.io.ByteArrayOutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.ws.rs.Path;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.dp.CpOrgao;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.DpResponsavel;
import br.gov.jfrj.siga.ex.ExClassificacao;
import br.gov.jfrj.siga.ex.ExConfiguracao;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExFormaDocumento;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExModelo;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExNivelAcesso;
import br.gov.jfrj.siga.ex.ExSituacaoConfiguracao;
import br.gov.jfrj.siga.ex.ExTipoDocumento;
import br.gov.jfrj.siga.ex.ExTipoMobil;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.ex.bl.ExCompetenciaBL;
import br.gov.jfrj.siga.ex.bl.ExConfiguracaoBL;
import br.gov.jfrj.siga.ex.service.ExService;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.parser.PessoaLotacaoParser;
import br.gov.jfrj.siga.persistencia.ExMobilDaoFiltro;
import br.gov.jfrj.webwork.action.ExMobilSelecao;

//@WebService(endpointInterface = "br.gov.jfrj.siga.ex.service.ExService")
@Path("/servicos")
public class ExServiceImpl implements ExService {

	private boolean hideStackTrace = false;
	@Resource
	private WebServiceContext context;

	public boolean isHideStackTrace() {
		return hideStackTrace;
	}

	public void setHideStackTrace(boolean hideStackTrace) {
		this.hideStackTrace = hideStackTrace;
	}

	private ExDao dao() {
		return ExDao.getInstance();
	}

	public Boolean transferir(String codigoDocumentoVia, String siglaDestino,
			String siglaCadastrante, Boolean forcarTransferencia) throws Exception {
		if (codigoDocumentoVia == null)
			return false;
		try {
			ExMobil mob = buscarMobil(codigoDocumentoVia);
			if (mob.isGeral() && mob.doc().isProcesso())
				mob = mob.doc().getUltimoVolume();
			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			PessoaLotacaoParser destinoParser = new PessoaLotacaoParser(
					siglaDestino);
			if (destinoParser.getLotacao() == null
					&& destinoParser.getPessoa() == null)
				return false;
			if (destinoParser.getLotacao() == null)
				destinoParser
						.setLotacao(destinoParser.getPessoa().getLotacao());
			if (mob.getUltimaMovimentacaoNaoCancelada() != null
					&& ((destinoParser.getLotacao() == null || !destinoParser
							.getLotacao().equivale(
									mob.getUltimaMovimentacaoNaoCancelada()
											.getLotaResp())) || (destinoParser
							.getPessoa() == null || !destinoParser.getPessoa()
							.equivale(
									mob.getUltimaMovimentacaoNaoCancelada()
											.getResp())))) {
				Ex.getInstance()
						.getBL()
						.transferir(null, null, cadastranteParser.getPessoa(),
								cadastranteParser.getLotacao(), mob, null,
								null, null, destinoParser.getLotacao(),
								destinoParser.getPessoa(), null, null, null,
								null, null, false, null, null, null, forcarTransferencia, false);
			}
			return true;
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			return false;
		}
	}

	private ExMobil buscarMobil(String codigoDocumentoVia) throws Exception,
			IllegalAccessException, InvocationTargetException,
			NoSuchMethodException {
		try {
			ExMobil mob = null;
			{
				final ExMobilDaoFiltro filter = new ExMobilDaoFiltro();
				filter.setSigla(codigoDocumentoVia);
				mob = (ExMobil) dao().consultarPorSigla(filter);
			}
			return mob;
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean arquivarCorrente(String codigoDocumentoVia,
			String siglaDestino, String siglaCadastrante) throws Exception {
		try {
			ExMobil mob = buscarMobil(codigoDocumentoVia);

			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			PessoaLotacaoParser destinoParser = new PessoaLotacaoParser(
					siglaDestino);
			Ex.getInstance()
					.getBL()
					.arquivarCorrente(cadastranteParser.getPessoa(),
							cadastranteParser.getLotacao(), mob, null, null,
							destinoParser.getPessoa(), false);
			return true;
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean juntar(String codigoDocumentoViaFilho,
			String codigoDocumentoViaPai, String siglaDestino,
			String siglaCadastrante) throws Exception {
		try {
			ExMobil mobFilho = buscarMobil(codigoDocumentoViaFilho);
			ExMobil mobPai = buscarMobil(codigoDocumentoViaPai);

			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			PessoaLotacaoParser destinoParser = new PessoaLotacaoParser(
					siglaDestino);

			Ex.getInstance()
					.getBL()
					.juntarDocumento(cadastranteParser.getPessoa(),
							cadastranteParser.getPessoa(),
							cadastranteParser.getLotacao(), null, mobFilho,
							mobPai, null, destinoParser.getPessoa(),
							destinoParser.getPessoa(), "1");
			return true;
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean isAssinado(String codigoDocumento, String siglaCadastrante)
			throws Exception {
		try {
			ExMobil mob = buscarMobil(codigoDocumento);
			return mob.getExDocumento().isAssinado();
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean isSemEfeito(String codigoDocumento) throws Exception {
		try {
			ExMobil mob = buscarMobil(codigoDocumento);
			return mob.getExDocumento().isSemEfeito();
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean podeMovimentar(String codigoDocumento,
			String siglaCadastrante) throws Exception {
		try {
			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			ExMobil mob = buscarMobil(codigoDocumento);
			return Ex
					.getInstance()
					.getComp()
					.podeMovimentar(
							cadastranteParser.getPessoa(),
							cadastranteParser.getLotacao() == null ? cadastranteParser
									.getPessoa().getLotacao()
									: cadastranteParser.getLotacao(), mob);
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean podeTransferir(String codigoDocumento,
			String siglaCadastrante, Boolean forcarTransferencia) throws Exception {
		try {
			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			ExMobil mob = buscarMobil(codigoDocumento);
			if (mob.isGeral() && mob.doc().isProcesso())
				mob = mob.doc().getUltimoVolume();
			if (forcarTransferencia)
				return Ex
						.getInstance()
						.getComp()
						.podeSerTransferido(mob);
			else
				return Ex
						.getInstance()
						.getComp()
						.podeTransferir(cadastranteParser.getPessoa(),
								cadastranteParser.getLotacao(), mob);
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public Boolean isAtendente(String codigoDocumento, String siglaTitular)
			throws Exception {
		try {
			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaTitular);
			ExMobil mob = buscarMobil(codigoDocumento);
			return ExCompetenciaBL.isAtendente(cadastranteParser.getPessoa(),
					cadastranteParser.getLotacao(), mob);
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public String getAtendente(String codigoDocumento, String siglaTitular)
			throws Exception {
		try {
			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaTitular);
			ExMobil mob = buscarMobil(codigoDocumento);
			DpResponsavel resp = ExCompetenciaBL.getAtendente(mob);
			if (resp == null)
				return null;

			if (resp instanceof DpPessoa) {
				return resp.getSiglaCompleta() + "@"
						+ ((DpPessoa) resp).getLotacao().getSiglaCompleta();
			} else {
				return "@" + resp.getSiglaCompleta();
			}
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public byte[] obterPdfPorNumeroAssinatura(String num) throws Exception {
		return Ex.getInstance().getBL().obterPdfPorNumeroAssinatura(num);
	}

	public String buscarPorCodigo(String codigo) throws Exception {
		ExMobilSelecao sel = new ExMobilSelecao();
		sel.setSigla(codigo);
		sel.buscarPorSigla();
		String s = sel.getSigla();
		if (s != null && s.length() > 0)
			return s;
		return null;
	}

	public String criarVia(String codigoDocumento, String siglaCadastrante)
			throws Exception {
		if (codigoDocumento == null)
			return null;
		try {
			ExMobil mob = buscarMobil(codigoDocumento);
			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			if (cadastranteParser.getLotacao() == null
					&& cadastranteParser.getPessoa() == null)
				return null;
			Ex.getInstance()
					.getBL()
					.criarVia(
							cadastranteParser.getPessoa(),
							cadastranteParser
									.getLotacaoOuLotacaoPrincipalDaPessoa(),
							mob.doc());
			return mob.doc().getUltimaVia().getSigla();
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			return null;
		}
	}

	public String form(String codigoDocumento, String variavel)
			throws Exception {
		if (codigoDocumento == null)
			return null;
		try {
			ExMobil mob = buscarMobil(codigoDocumento);
			return mob.doc().getForm().get(variavel);
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			return null;
		}
	}

	@Override
	public Boolean exigirAnexo(String codigoDocumentoVia, String siglaCadastrante, String descricaoDoAnexo) throws Exception {
		try {
			ExMobil mob = buscarMobil(codigoDocumentoVia);

			PessoaLotacaoParser cadastranteParser = new PessoaLotacaoParser(
					siglaCadastrante);
			Ex.getInstance()
					.getBL()
					.exigirAnexo(cadastranteParser.getPessoa(),
							cadastranteParser.getLotacao(), mob, descricaoDoAnexo);
			return true;
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}

	public String toJSON(String codigo) throws Exception {
		try {
			ExMobil mob = null;
			{
				final ExMobilDaoFiltro filter = new ExMobilDaoFiltro();
				filter.setSigla(codigo);
				mob = (ExMobil) dao().consultarPorSigla(filter);
				//return Ex.getInstance().getBL().toJSON(mob);
				return "";
			}
		} catch (Exception e) {
			if (!isHideStackTrace())
				e.printStackTrace(System.out);
			throw e;
		}
	}
	
	public String criarDocumento(String cadastranteStr, String subscritorStr, String destinatarioStr, String destinatarioCampoExtraStr, String descricaoTipoDeDocumento, String nomeForma ,String nomeModelo, String classificacaoStr, 
			String descricaoStr, Boolean eletronico, String nomeNivelDeAcesso, String conteudo, String siglaMobilPai, Boolean finalizar) throws Exception {
    	try {
    		DpPessoa cadastrante = null;
    		DpPessoa subscritor = null;
    		ExModelo modelo = null;
    		ExFormaDocumento forma = null;
    		ExTipoDocumento tipoDocumento = null;
    		ExClassificacao classificacao = null;
    		ExNivelAcesso nivelDeAcesso = null;
    		DpLotacao destinatarioLotacao = null;
    		DpPessoa destinatarioPessoa = null;
    		CpOrgao destinatarioOrgaoExterno = null;
    		
    		ExDocumento doc = new ExDocumento();
    		
    		if(cadastranteStr == null || cadastranteStr.isEmpty())
    			throw new AplicacaoException("A matr�cula do cadastrante n�o foi informada.");
    		
    		if(subscritorStr == null || subscritorStr.isEmpty())
    			throw new AplicacaoException("A matr�cula do subscritor n�o foi informada.");

    		cadastrante = dao().getPessoaFromSigla(cadastranteStr);
    		
    		if(cadastrante == null)
    			throw new AplicacaoException("N�o foi poss�vel encontrar um cadastrante com a matr�cula informada.");
    		
    		if(cadastrante.isFechada())
    			throw new AplicacaoException("O cadastrante n�o est� mais ativo.");
    		
    		subscritor = dao().getPessoaFromSigla(subscritorStr);
    		
    		if(subscritor == null)
    			throw new AplicacaoException("N�o foi poss�vel encontrar um subscritor com a matr�cula informada.");
 
    		if(subscritor.isFechada())
    			throw new AplicacaoException("O subscritor n�o est� mais ativo.");
    		
    		if(descricaoTipoDeDocumento == null)
    			tipoDocumento = (dao().consultar(ExTipoDocumento.TIPO_DOCUMENTO_INTERNO, ExTipoDocumento.class,
        				false));
    		else 
    			tipoDocumento = dao().consultarExTipoDocumento(descricaoTipoDeDocumento);
    		
    		if(tipoDocumento == null)
    			throw new AplicacaoException("N�o foi poss�vel encontrar o Tipo de Documento. Os Tipos de Documentos aceitos s�o: 1-Interno Produzido, 2-Interno Importado, 3-Externo");
    		
    		if(nomeForma == null)
    			throw new AplicacaoException("O Tipo n�o foi informado.");
    		
    		if(nomeModelo == null)
    			throw new AplicacaoException("O modelo n�o foi informado.");

    		modelo = dao().consultarExModelo(nomeForma, nomeModelo);
    		
    		if(modelo == null)
    			throw new AplicacaoException("N�o foi poss�vel encontrar um modelo com os dados informados.");
    		else
    			modelo = modelo.getModeloAtual();
    		
    		forma = modelo.getExFormaDocumento();
    		
    		if(!forma.podeSerDoTipo(tipoDocumento))
    			throw new AplicacaoException("O documento do tipo " + forma.getDescricao() + " n�o pode ser " + tipoDocumento.getDescricao());
    		
       		if((classificacaoStr == null || classificacaoStr.isEmpty()) && !modelo.isClassificacaoAutomatica())
       			throw new AplicacaoException("A Classifica��o n�o foi informada.");
    		
    		if(modelo.isClassificacaoAutomatica()) 
    			classificacao = modelo.getExClassificacao();
    		else
    			classificacao =  dao().consultarExClassificacao(classificacaoStr);
    		
    		if(classificacao == null)
    			throw new AplicacaoException("N�o foi poss�vel encontrar uma classifica��o com o c�digo informado.");
    		else
    			classificacao = classificacao.getClassificacaoAtual();
    		
    		if(eletronico == null)
    			eletronico = true;

    		Long idSit = Ex
    				.getInstance()
    				.getConf()
    				.buscaSituacao(modelo, tipoDocumento,cadastrante, cadastrante.getLotacao(),
    						CpTipoConfiguracao.TIPO_CONFIG_ELETRONICO)
    				.getIdSitConfiguracao();
    		
    		if (idSit == ExSituacaoConfiguracao.SITUACAO_OBRIGATORIO) {
    			eletronico = true;
    		} else if (idSit == ExSituacaoConfiguracao.SITUACAO_PROIBIDO) {
    			eletronico = false;
    		} 
    		
    		if(nomeNivelDeAcesso == null) {
    			
	    		Date dt = ExDao.getInstance().consultarDataEHoraDoServidor();
	    		
	    		ExConfiguracao config = new ExConfiguracao();
	    		CpTipoConfiguracao exTpConfig = new CpTipoConfiguracao();
	    		CpSituacaoConfiguracao exStConfig = new CpSituacaoConfiguracao();
	    		config.setDpPessoa(cadastrante);
	    		config.setLotacao(cadastrante.getLotacao());
	    		config.setExTipoDocumento(tipoDocumento);
	    		config.setExFormaDocumento(forma);
	    		config.setExModelo(modelo);
	    		config.setExClassificacao(classificacao);
	    		exTpConfig
	    				.setIdTpConfiguracao(CpTipoConfiguracao.TIPO_CONFIG_NIVELACESSO);
	    		config.setCpTipoConfiguracao(exTpConfig);
	    		exStConfig
	    			.setIdSitConfiguracao(CpSituacaoConfiguracao.SITUACAO_DEFAULT);
	    		config.setCpSituacaoConfiguracao(exStConfig);
	    		
	    		ExConfiguracao exConfig = ((ExConfiguracao) Ex
	    				.getInstance()
	    				.getConf()
	    				.buscaConfiguracao(config,
	    						new int[] { ExConfiguracaoBL.NIVEL_ACESSO }, dt));
	    		
	    		if(exConfig != null)
	    			nivelDeAcesso = exConfig.getExNivelAcesso();
    		} else {
    			nivelDeAcesso = dao().consultarExNidelAcesso(nomeNivelDeAcesso);
    		}
    		
			if(nivelDeAcesso == null)
				nivelDeAcesso = dao().consultar(6L, ExNivelAcesso.class, false);	
			
			List<ExNivelAcesso> listaNiveis = ExDao.getInstance().listarOrdemNivel();
			ArrayList<ExNivelAcesso> niveisFinal = new ArrayList<ExNivelAcesso>();
			Date dt = ExDao.getInstance().consultarDataEHoraDoServidor();

			ExConfiguracao config = new ExConfiguracao();
			CpTipoConfiguracao exTpConfig = new CpTipoConfiguracao();
			config.setDpPessoa(cadastrante);
			config.setLotacao(cadastrante.getLotacao());
			config.setExTipoDocumento(tipoDocumento);
			config.setExFormaDocumento(forma);
			config.setExModelo(modelo);
			config.setExClassificacao(classificacao);
			exTpConfig
					.setIdTpConfiguracao(CpTipoConfiguracao.TIPO_CONFIG_NIVEL_ACESSO_MINIMO);
			config.setCpTipoConfiguracao(exTpConfig);
			int nivelMinimo = ((ExConfiguracao) Ex
					.getInstance()
					.getConf()
					.buscaConfiguracao(config,
							new int[] { ExConfiguracaoBL.NIVEL_ACESSO }, dt))
					.getExNivelAcesso().getGrauNivelAcesso();
			exTpConfig
					.setIdTpConfiguracao(CpTipoConfiguracao.TIPO_CONFIG_NIVEL_ACESSO_MAXIMO);
			config.setCpTipoConfiguracao(exTpConfig);
			int nivelMaximo = ((ExConfiguracao) Ex
					.getInstance()
					.getConf()
					.buscaConfiguracao(config,
							new int[] { ExConfiguracaoBL.NIVEL_ACESSO }, dt))
					.getExNivelAcesso().getGrauNivelAcesso();

			for (ExNivelAcesso nivelAcesso : listaNiveis) {
				if (nivelAcesso.getGrauNivelAcesso() >= nivelMinimo
						&& nivelAcesso.getGrauNivelAcesso() <= nivelMaximo)
					niveisFinal.add(nivelAcesso);
			}
			
			if(niveisFinal != null && !niveisFinal.isEmpty() & !niveisFinal.contains(nivelDeAcesso))
				nivelDeAcesso = niveisFinal.get(0);
    		
    		doc.setCadastrante(cadastrante);
    		doc.setLotaCadastrante(cadastrante.getLotacao());
    		doc.setTitular(cadastrante);
    		doc.setLotaTitular(cadastrante.getLotacao());
    		
    		if(destinatarioStr != null) {
    			try {
        			destinatarioLotacao = dao().getLotacaoFromSigla(destinatarioStr);

        			if(destinatarioLotacao != null)
        				doc.setLotaDestinatario(destinatarioLotacao);
				} catch (Exception e) {
				}
    		}
    		
    		if(destinatarioStr != null && destinatarioLotacao == null) {
    			try {
        			destinatarioPessoa = dao().getPessoaFromSigla(destinatarioStr);
        			
        			if(destinatarioPessoa != null)
        				doc.setDestinatario(destinatarioPessoa);
				} catch (Exception e) {
				}
    		}
    		
    		if(destinatarioStr != null && destinatarioLotacao == null && destinatarioPessoa == null) {
    			try {
        			destinatarioOrgaoExterno = dao().getOrgaoFromSiglaExata(destinatarioStr);
        			
        			if(destinatarioOrgaoExterno != null) {
        				doc.setOrgaoExternoDestinatario(destinatarioOrgaoExterno);
        				doc.setNmOrgaoExterno(destinatarioCampoExtraStr);
        			}
				} catch (Exception e) {
				}
    		}
    		
    		if(destinatarioStr != null && destinatarioLotacao == null && destinatarioPessoa == null && destinatarioOrgaoExterno == null) {
    			doc.setNmDestinatario(destinatarioStr);
    		}
    		
    		doc.setSubscritor(subscritor);
    		doc.setLotaSubscritor(subscritor.getLotacao());
    		doc.setOrgaoUsuario(subscritor.getOrgaoUsuario());
    		doc.setExTipoDocumento(tipoDocumento);
    		doc.setExFormaDocumento(forma);
    		doc.setExModelo(modelo);
    		
    		if(!modelo.isDescricaoAutomatica())
    			doc.setDescrDocumento(descricaoStr);
    		
    		doc.setExClassificacao(classificacao);
    		if(eletronico)
    			doc.setFgEletronico("S");
    		else
    			doc.setFgEletronico("N");
    			
    		doc.setExNivelAcesso(nivelDeAcesso);
    		
    		ExMobil mob = new ExMobil();
			mob.setExTipoMobil(dao().consultar(ExTipoMobil.TIPO_MOBIL_GERAL,
					ExTipoMobil.class, false));
			mob.setNumSequencia(1);
			mob.setExMovimentacaoSet(new TreeSet<ExMovimentacao>());
			mob.setExDocumento(doc);
			
    		if(siglaMobilPai != null && !siglaMobilPai.isEmpty()) {
    			final ExMobilDaoFiltro filter = new ExMobilDaoFiltro();
    			filter.setSigla(siglaMobilPai);
    			ExMobil mobPai = (ExMobil) dao().consultarPorSigla(filter);
    			if (mobPai != null) {
    	    		ExDocumento docPai = mobPai.getExDocumento();
    				
    				if(docPai.getExMobilPai() != null)
    					throw new AplicacaoException("N�o foi poss�vel criar o documento pois o documento pai (" + docPai.getSigla() + ") j� � documento filho.");
    				
    				if(!docPai.isAssinado())
    					throw new AplicacaoException("N�o foi poss�vel criar o documento pois o documento pai (" + docPai.getSigla() + ") ainda n�o foi assinado.");
    				
    				doc.setExMobilPai(mobPai);
    			}
    		}
			
			doc.setExMobilSet(new TreeSet<ExMobil>());
			doc.getExMobilSet().add(mob);
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			baos.write(conteudo.getBytes());
			
			doc.setConteudoTpDoc("application/zip");
			doc.setConteudoBlobForm(baos.toByteArray());
			
			ServletContext servletContext =
				    (ServletContext) context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
			
			String realPath = servletContext.getRealPath("");
    		
    		doc = Ex.getInstance()
			       .getBL().gravar(cadastrante, cadastrante.getLotacao(), doc, realPath);
    		
    		if(finalizar)
    			Ex.getInstance().getBL().finalizar(cadastrante, cadastrante.getLotacao(), doc, realPath);

    		return doc.getSigla();
		} catch (Exception e) {
			throw e;
		}	
    }

}
