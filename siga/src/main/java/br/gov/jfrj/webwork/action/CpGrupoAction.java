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

/*
 * Criado em  13/09/2005
 *
 * To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.gov.jfrj.webwork.action;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpGrupo;
import br.gov.jfrj.siga.cp.CpGrupoDeEmail;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpPerfilJEE;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoGrupo;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.cp.bl.CpConfiguracaoBL;
import br.gov.jfrj.siga.cp.grupo.ConfiguracaoGrupo;
import br.gov.jfrj.siga.cp.grupo.ConfiguracaoGrupoEmail;
import br.gov.jfrj.siga.cp.grupo.ConfiguracaoGrupoFabrica;
import br.gov.jfrj.siga.cp.grupo.ConfiguracaoGrupoFormula;
import br.gov.jfrj.siga.cp.grupo.TipoConfiguracaoGrupoEnum;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.dao.CpGrupoDaoFiltro;
import br.gov.jfrj.siga.libs.webwork.DpLotacaoSelecao;
import br.gov.jfrj.siga.model.Objeto;
import br.gov.jfrj.siga.model.Selecionavel;
import br.gov.jfrj.siga.model.dao.ModeloDao;

import com.opensymphony.xwork.Action;
import com.opensymphony.xwork.Preparable;

public abstract class CpGrupoAction<T extends CpGrupo> extends
		GiSelecionavelActionSupport<T, CpGrupoDaoFiltro> implements Preparable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3768576909382652437L;
	private ArrayList<String> codigoTipoConfiguracao; // 0- Pessoa, 1 -
	// Lota��o,

	private Integer codigoTipoConfiguracaoNova;

	// Campos da lista de configura��es do grupo
	private ArrayList<ConfiguracaoGrupo> configuracoesGrupo;

	// 2 - email, etc.
	private ArrayList<String> conteudoConfiguracao; // Id Pessoa ou Id Lota��o,

	private String conteudoConfiguracaoNova;

	private CpTipoGrupo cpTipoGrupo;

	private String dscCpTipoGrupo;
	private String dscGrupo;

	private DpLotacaoSelecao lotacaoGestoraSel;

	// erro
	private Exception exception;
	private CpGrupoDeEmailSelecao grupoPaiSel;
	private ArrayList<String> idConfiguracao;
	// Texto endereco email,
	// etc. , conforme
	// codigoTipoConfiguracao.
	// Campos para uma nova configura��o par ao grupo
	private String idConfiguracaoNova;
	// Lista de grupos est� em itens da superclasse
	// campos do grupo
	private Long idCpGrupo;
	private Long orgaoUsu;
	private String siglaGrupo;
	private CpTipoConfiguracao tipoConfiguracao;
	private List<TipoConfiguracaoGrupoEnum> tiposConfiguracaoGrupoParaTipoDeGrupo;
	// Carga inicial
	private List<CpTipoGrupo> tiposDeGrupo;

	private Long idConfGestor;

	@Override
	public String aBuscar() throws Exception {
		if (param("postback") == null)
			setOrgaoUsu(getLotaTitular().getOrgaoUsuario().getIdOrgaoUsu());
		return super.aBuscar();
	}

	/**
	 * Seleciona um procedimento que ter� suas permiss�es configuradas.
	 * 
	 * @return
	 * @throws Exception
	 */
	public String aConfigurar() throws Exception {

		return "SUCESS";
	}

	/*
	 * Prepara a edi��o do grupo selecionado na lista
	 */
	public String aEditar() throws Exception {
		Cp.getInstance().getConf().limparCacheSeNecessario();

		Integer t_idTpGrupo = getIdTipoGrupo();
		setCpTipoGrupo(dao().consultar(t_idTpGrupo, CpTipoGrupo.class, false));

		// idCpGrupo vazio indica inclus�o
		if (idCpGrupo == null || idCpGrupo.equals("")) {
			dscGrupo = "";
			siglaGrupo = "";
			tiposConfiguracaoGrupoParaTipoDeGrupo = obterTiposConfiguracaoGrupoParaTipoDeGrupo(getCpTipoGrupo());
			configuracoesGrupo = new ArrayList<ConfiguracaoGrupo>();
			return "edita";
		} else {
			CpGrupo grp;
			grp = daoGrupo(getIdCpGrupo());
			if (grp == null) {
				throw new AplicacaoException(
						"Grupo n�o encontrado para Id do grupo: " + idCpGrupo
								+ ".");
			}
			if (!grp.isAtivo()) {
				throw new AplicacaoException(
						"Grupo antigo n�o pode ser editado. Favor atualizar a p�gina da lista de grupos antes de selecionar um grupo para edi��o.");
			}
			dscGrupo = grp.getDscGrupo();
			siglaGrupo = grp.getSiglaGrupo();
			getGrupoPaiSel().buscarPorObjeto(grp.getCpGrupoPai());

			CpTipoGrupo tpGrp = grp.getCpTipoGrupo();

			tiposConfiguracaoGrupoParaTipoDeGrupo = obterTiposConfiguracaoGrupoParaTipoDeGrupo(tpGrp);
			dscCpTipoGrupo = tpGrp.getDscTpGrupo();
			try {
				configuracoesGrupo = Cp.getInstance().getConf()
						.obterCfgGrupo(grp);
				for (ConfiguracaoGrupo t_cfgConfiguracaoGrupo : configuracoesGrupo) {
					CpConfiguracao t_cpcConfiguracaoCorrente = t_cfgConfiguracaoGrupo
							.getCpConfiguracao();
					Long t_lngIdConfiguracao = t_cpcConfiguracaoCorrente
							.getIdConfiguracao();
					idConfiguracao.add(t_lngIdConfiguracao.toString());
					TipoConfiguracaoGrupoEnum t_tpcTipo = t_cfgConfiguracaoGrupo
							.getTipo();
					codigoTipoConfiguracao.add(String.valueOf(t_tpcTipo
							.getCodigo()));
					String t_strConteudoConfiguracaoCorrente = t_cfgConfiguracaoGrupo
							.getConteudoConfiguracao();
					conteudoConfiguracao.add(t_strConteudoConfiguracaoCorrente);

				}
			} catch (Exception e) {
				throw new AplicacaoException("Id do grupo: " + idCpGrupo
						+ " erro ao obter configura��es do grupo.", 0, e);
			}
		}
		return "edita";
	}

	/**
	 * Exclui o grupo e as configura��es A exclus�o no caso � l�gica: atribui a
	 * data de fim de vig�ncia das configura��es do grupo e tamb�m a data de fim
	 * do grupo.
	 * 
	 * @throws AplicacaoException
	 */
	public String aExcluir() throws Exception {
		try {
			ModeloDao.iniciarTransacao();
			Date dt = dao().consultarDataEHoraDoServidor();
			CpGrupo grp = daoGrupo(getIdCpGrupo());
			configuracoesGrupo = Cp.getInstance().getConf().obterCfgGrupo(grp);
			for (ConfiguracaoGrupo t_cfgConfiguracaoGrupo : configuracoesGrupo) {
				CpConfiguracao t_cpcConfiguracao = t_cfgConfiguracaoGrupo
						.getCpConfiguracao();
				t_cpcConfiguracao.setHisDtFim(dt);
				dao().gravarComHistorico(t_cpcConfiguracao,
						getIdentidadeCadastrante());
			}
			grp.setHisDtFim(dt);
			dao().gravarComHistorico(grp, getIdentidadeCadastrante());
			ModeloDao.commitTransacao();
		} catch (Exception e) {
			ModeloDao.rollbackTransacao();
			throw new AplicacaoException("Erro ao excluir grupo de id: "
					+ idCpGrupo + ".", 0, e);
		}
		return "lista";
	}

	public CpGrupo daoGrupo(long id) {
		return dao().consultar(id, CpGrupo.class, false);
	}

	/**
	 * Grava o grupo e as configura��es
	 * 
	 * @throws AplicacaoException
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 * @throws InvocationTargetException
	 */
	public String aGravar() throws Exception {
		if (siglaGrupo == null) {
			throw new AplicacaoException("A sigla do grupo deve ser definida!");
		}
		try {
			CpGrupo grp = null;
			CpGrupo grpNovo = null;
			Date dt = dao().consultarDataEHoraDoServidor();
			CpTipoGrupo tpGrp = obterCpTipoGrupoPorId(getIdTipoGrupo());
			if (tpGrp == null) {
				throw new AplicacaoException(
						"Tipo de grupo nulo para Id do grupo: " + idCpGrupo);
			}

			// Substituir isso por uma f�brica
			//
			if (tpGrp.getIdTpGrupo() == CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO)
				grpNovo = new CpGrupoDeEmail();
			if (tpGrp.getIdTpGrupo() == CpTipoGrupo.TIPO_GRUPO_PERFIL_DE_ACESSO)
				grpNovo = new CpPerfil();
			if (tpGrp.getIdTpGrupo() == CpTipoGrupo.TIPO_GRUPO_PERFIL_JEE)
				grpNovo = new CpPerfilJEE();

			if (getIdCpGrupo() == null) {
				grpNovo.setCpTipoGrupo(tpGrp);
				grpNovo.setOrgaoUsuario(getLotaTitular().getOrgaoUsuario());
			} else {
				grp = (CpGrupo) Objeto
						.getImplementation(daoGrupo(getIdCpGrupo()));
				PropertyUtils.copyProperties(grpNovo, grp);
				grpNovo.setIdGrupo(null);
			}
			grpNovo.setCpGrupoPai(getGrupoPaiSel().getObjeto());
			grpNovo.setDscGrupo(dscGrupo);
			grpNovo.setSiglaGrupo(siglaGrupo);

			dao().iniciarTransacao();
			grp = (CpGrupo) dao().gravarComHistorico(grpNovo, grp, dt,
					getIdentidadeCadastrante());
			idCpGrupo = grp.getIdGrupo();

			// Fabrica
			ConfiguracaoGrupoFabrica fabrica = new ConfiguracaoGrupoFabrica();
			// grava uma nova configura��o

			TipoConfiguracaoGrupoEnum tpCfgGrpEnum = TipoConfiguracaoGrupoEnum
					.obterPara(tpGrp, codigoTipoConfiguracaoNova);
			if (tpCfgGrpEnum != null) {
				ConfiguracaoGrupo cfgGrp = fabrica.getInstance(tpCfgGrpEnum);
				if (isConfiguracaoAvancada(cfgGrp) && !podeEditarConfiguracoesAvancadas()){
					throw new AplicacaoException("Voc� n�o tem permiss�o para configurar " + tpCfgGrpEnum.getDescricao()+ ". Por favor, entre em contato com o suporte t�cnico para realizar tal configura��o.");
				}

				cfgGrp.setConteudoConfiguracao(conteudoConfiguracaoNova);
				if (cfgGrp.getConteudoConfiguracao() == null
						|| cfgGrp.getConteudoConfiguracao().equals("")) {
					throw new AplicacaoException(
							"Erro ao gravar nova configura��o para o grupo: conte�do do(a)"
									+ tpCfgGrpEnum.getDescricao()
									+ " inexistente! ");
				}
				CpConfiguracao cfg = new CpConfiguracao();
				cfg.setCpTipoConfiguracao(tipoConfiguracao);
				cfg.setHisDtIni(dt);
				cfgGrp.setCpConfiguracao(cfg);
				cfgGrp.setCpGrupo(grp);
				cfgGrp.atualizarCpConfiguracao();
				dao().gravarComHistorico(cfg, getIdentidadeCadastrante());
			}

			// processa as configura��es existentes
			configuracoesGrupo = Cp.getInstance().getConf().obterCfgGrupo(grp);
			for (int i = 0; i < idConfiguracao.size(); i++) {
				Long idCfg = Long.parseLong(idConfiguracao.get(i));
				for (ConfiguracaoGrupo cfgGrpGravada : configuracoesGrupo) {
					Long idCfgGravada = cfgGrpGravada.getCpConfiguracao()
							.getIdConfiguracao();
					if (idCfgGravada.equals(idCfg)) {
						Integer tpCfg = Integer.parseInt(codigoTipoConfiguracao
								.get(i));
						// Remo��o de uma configura��o gravada antes
						if (tpCfg.equals(-1)) {
							// exclus�o remove apenas logicamente, deixa o
							// registro antigo como log
							if (isConfiguracaoAvancada(cfgGrpGravada) && !podeEditarConfiguracoesAvancadas()){
								throw new AplicacaoException("Voc� n�o tem permiss�o para remover " + cfgGrpGravada.getTipo().getDescricao()+ ". Por favor, entre em contato com o suporte t�cnico para realizar tal configura��o.");
							}
							
							cfgGrpGravada.getCpConfiguracao().setHisDtFim(dt);
							dao().gravarComHistorico(
									cfgGrpGravada.getCpConfiguracao(),
									getIdentidadeCadastrante());
						} else {
							String cfgConteudo = conteudoConfiguracao.get(i);
							// Nato: o ideal seria se pud�ssemos utilizar o
							// m�todo "semelhante" para comparar configura��es.
							// No entanto, como as configura��es anteriores s�o
							// lidas do "cache-da-aplica��o", e n�o do
							// Hibernate, fica imposs�vel fazer a compara��o
							// automaticamente. Por isso, � necess�rio esse "if"
							// que s� grava altera��es se n�o for do mesmo tipo
							// ou n�o tiver mesmo conte�do que a gravada
							if (!tpCfg.equals(cfgGrpGravada.getTipo()
									.getCodigo())
									|| !cfgConteudo.equals(cfgGrpGravada
											.getConteudoConfiguracao())) {
								TipoConfiguracaoGrupoEnum tpCfgGrpNova = TipoConfiguracaoGrupoEnum
														.obterPara(tpGrp, tpCfg);
								ConfiguracaoGrupo cfgGrpNova = fabrica
										.getInstance(tpCfgGrpNova);
								if (isConfiguracaoAvancada(cfgGrpNova) && !podeEditarConfiguracoesAvancadas()){
									throw new AplicacaoException("Voc� n�o tem permiss�o para configurar " + tpCfgGrpNova.getDescricao()+ ". Por favor, entre em contato com o suporte t�cnico para realizar tal configura��o.");
								}
								if (cfgConteudo == null
										|| cfgConteudo.equals("")) {
									throw new AplicacaoException(
											"Erro ao gravar altera��o da configura��o para o grupo: conte�do do(a)"
													+ tpCfgGrpEnum
															.getDescricao()
													+ " inexistente!");
								}
								cfgGrpNova.setConteudoConfiguracao(cfgConteudo);
								CpConfiguracao cfgNova = new CpConfiguracao();
								cfgNova.setCpTipoConfiguracao(tipoConfiguracao);
								cfgGrpNova.setCpConfiguracao(cfgNova);
								cfgGrpNova.setCpGrupo(grp);
								cfgGrpNova.atualizarCpConfiguracao();
								dao().gravarComHistorico(cfgNova,
										cfgGrpGravada.getCpConfiguracao(), dt,
										getIdentidadeCadastrante());
							}
						}
					}
				}
			}

			dao().commitTransacao();
			Cp.getInstance()
					.getConf()
					.limparCache(
							dao().consultar(
									CpTipoConfiguracao.TIPO_CONFIG_PERTENCER,
									CpTipoConfiguracao.class, false));
		} catch (Exception e) {
			throw new AplicacaoException("Id do grupo: " + idCpGrupo
					+ " erro ao gravar grupo e configura��es.", 0, e);
		}

		return "edita";
	}

	private boolean isConfiguracaoAvancada(
			ConfiguracaoGrupo cfgGrupo) {
		return cfgGrupo instanceof ConfiguracaoGrupoEmail
				|| cfgGrupo instanceof ConfiguracaoGrupoFormula;
	}

	private boolean podeEditarConfiguracoesAvancadas() throws Exception {
		return Cp.getInstance().getComp().getConfiguracaoBL().podeUtilizarServicoPorConfiguracao(getTitular(), getLotaTitular(), "SIGA;GI;GDISTR;CONF_AVANC:Configurac�es Avan�adas");
	}

	public String aGravarGestorGrupo() {
		DpLotacao lot = getLotacaoGestoraSel().getObjeto();
		if (lot == null){
			throw new AplicacaoException("A unidade deve ser definida!");
		}else{
			CpTipoConfiguracao tpConf = dao().consultar(
					CpTipoConfiguracao.TIPO_CONFIG_GERENCIAR_GRUPO,
					CpTipoConfiguracao.class, false);
			CpSituacaoConfiguracao situacao = dao().consultar(
					CpSituacaoConfiguracao.SITUACAO_PODE,
					CpSituacaoConfiguracao.class, false);
			
			CpConfiguracao conf = new CpConfiguracao();
			conf.setLotacao(lot);
			conf.setCpTipoConfiguracao(tpConf);
			conf.setCpSituacaoConfiguracao(situacao);
			conf.setCpGrupo(daoGrupo(idCpGrupo));
			conf.setHisDtIni(dao().consultarDataEHoraDoServidor());
			dao().gravarComHistorico(conf, getIdentidadeCadastrante());
			
			setIdCpGrupo(getIdCpGrupo());
		}

		return SUCCESS;
	}

	public String aExcluirGestorGrupo() {
		dao().iniciarTransacao();
		CpConfiguracao conf = dao().consultar(idConfGestor,
				CpConfiguracao.class, false);
		conf.setHisDtFim(dao().consultarDataEHoraDoServidor());
		dao().gravarComHistorico(conf, getIdentidadeCadastrante());

		setIdCpGrupo(getIdCpGrupo());
		dao().commitTransacao();
		return SUCCESS;
	}

	public List<CpConfiguracao> getConfGestores() {
		CpTipoConfiguracao tpConf = dao().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_GERENCIAR_GRUPO,
				CpTipoConfiguracao.class, false);
		CpSituacaoConfiguracao situacao = dao().consultar(
				CpSituacaoConfiguracao.SITUACAO_PODE,
				CpSituacaoConfiguracao.class, false);
		CpGrupo grp = daoGrupo(getIdCpGrupo());
		CpConfiguracao fltConf = new CpConfiguracao();
		fltConf.setCpGrupo(grp);
		fltConf.setCpTipoConfiguracao(tpConf);
		fltConf.setCpSituacaoConfiguracao(situacao);

		List<CpConfiguracao> confs = dao().consultar(fltConf);

		Iterator it = confs.iterator();
		while (it.hasNext()) {
			CpConfiguracao c = (CpConfiguracao) it.next();
			if (c.getHisDtFim() != null
					|| c.getCpGrupo() == null
					|| !c.getCpGrupo().getIdInicial()
							.equals(grp.getIdInicial())) {
				it.remove();
			}
		}

		return confs;
	}

	/*
	 * Prepara a lista de grupos a exibir
	 */
	public String aListar() throws Exception {

		int offset = 0;
		int itemPagina = 0;
		if (getP().getOffset() != null) {
			offset = getP().getOffset();
		}
		if (getItemPagina() != null) {
			itemPagina = getItemPagina();
		}
		CpGrupoDaoFiltro flt = new CpGrupoDaoFiltro();
		Integer t_idTpGrupo = getIdTipoGrupo();
		setCpTipoGrupo(dao().consultar(t_idTpGrupo, CpTipoGrupo.class, false));
		flt.setIdTpGrupo(t_idTpGrupo);
		int intQtd = dao().consultarQuantidade(flt);
		setTamanho(intQtd);
		List<CpGrupo> itgGrupos = dao().consultarPorFiltro(flt, offset,
				itemPagina);

		Iterator<CpGrupo> it = itgGrupos.iterator();

		CpConfiguracaoBL conf = Cp.getInstance().getConf();
		// se n�o for administrador, exibe apenas os grupos que pode gerir
		if (getIdTipoGrupo() == CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO
				&& !conf.podeUtilizarServicoPorConfiguracao(
						getTitular(),
						getLotaTitular(),
						"SIGA:Sistema Integrado de Gest�o Administrativa;GI:M�dulo de Gest�o de Identidade;GDISTR:Gerenciar grupos de distribui��o")) {
			while (it.hasNext()) {
				CpGrupo cpGrp = it.next();
				CpConfiguracaoBL bl = Cp.getInstance().getConf();
				if (!bl.podePorConfiguracao(getTitular(), getLotaTitular(),
						cpGrp, CpTipoConfiguracao.TIPO_CONFIG_GERENCIAR_GRUPO)) {
					it.remove();
				}

			}
		}

		setItens(itgGrupos);
		return "lista";
	}

	public abstract int getIdTipoGrupo();

	@Override
	public CpGrupoDaoFiltro createDaoFiltro() {
		final CpGrupoDaoFiltro flt = new CpGrupoDaoFiltro();
		flt.setIdTpGrupo(getIdTipoGrupo());
		flt.setNome(Texto.removeAcentoMaiusculas(getNome()));
		return flt;
	}

	/**
	 * @return the codigoTipoConfiguracao
	 */
	public ArrayList<String> getCodigoTipoConfiguracao() {
		return codigoTipoConfiguracao;
	}

	/**
	 * @return the codigoTipoConfiguracaoNova
	 */
	public Integer getCodigoTipoConfiguracaoNova() {
		return codigoTipoConfiguracaoNova;
	}

	/**
	 * @return the configuracoesGrupo
	 */
	public ArrayList<ConfiguracaoGrupo> getConfiguracoesGrupo() {
		return configuracoesGrupo;
	}

	/**
	 * @return the conteudoConfiguracao
	 */
	public ArrayList<String> getConteudoConfiguracao() {
		return conteudoConfiguracao;
	}

	/**
	 * @return the conteudoConfiguracaoNova
	 */
	public String getConteudoConfiguracaoNova() {
		return conteudoConfiguracaoNova;
	}

	public CpTipoGrupo getCpTipoGrupo() {
		return cpTipoGrupo;
	}

	/**
	 * @return the dscCpTipoGrupo
	 */
	public String getDscCpTipoGrupo() {
		return dscCpTipoGrupo;
	}

	/**
	 * @return the dscGrupo
	 */
	public String getDscGrupo() {
		return dscGrupo;
	}

	/**
	 * @return the exception
	 */
	public Exception getException() {
		return exception;
	}

	public CpGrupoDeEmailSelecao getGrupoPaiSel() {
		return grupoPaiSel;
	}

	/**
	 * @return the idConfiguracao
	 */
	public ArrayList<String> getIdConfiguracao() {
		return idConfiguracao;
	}

	/**
	 * @return the idCpGrupoPai
	 */

	/**
	 * @return the idConfiguracaoNova
	 */
	public String getIdConfiguracaoNova() {
		idConfiguracaoNova = String.valueOf(Long.MAX_VALUE);
		return idConfiguracaoNova;
	}

	/**
	 * @return the idCpGrupo
	 */
	public Long getIdCpGrupo() {
		return idCpGrupo;
	}

	public Long getOrgaoUsu() {
		return orgaoUsu;
	}

	/**
	 * @return the siglaGrupo
	 */
	public String getSiglaGrupo() {
		return siglaGrupo;
	}

	/**
	 * @return the tipoConfiguracao
	 */
	public CpTipoConfiguracao getTipoConfiguracao() {
		return tipoConfiguracao;
	}

	/**
	 * @return the tiposConfiguracaoGrupoParaTipoDeGrupo
	 */
	public List<TipoConfiguracaoGrupoEnum> getTiposConfiguracaoGrupoParaTipoDeGrupo() {
		return tiposConfiguracaoGrupoParaTipoDeGrupo;
	}

	/**
	 * @return the tiposDeGrupo
	 */
	public List<CpTipoGrupo> getTiposDeGrupo() {
		return tiposDeGrupo;
	}

	/**
	 * Localiza CpTipoGrupo de um determinado Id
	 * 
	 * @param Integer
	 *            p_intIdTipoGrupo - O id do tipo grupo que deseja localizar. @
	 *            return CpTipoGrupo
	 */
	private CpTipoGrupo obterCpTipoGrupoPorId(Integer p_intIdTipoGrupo) {
		return dao().consultar(p_intIdTipoGrupo, new CpTipoGrupo().getClass(),
				false);
	}

	/**
	 * Localiza CpGrupo
	 * 
	 * @return CpGrupo
	 */
	public CpTipoGrupo getTipoGrupo() {
		return obterCpTipoGrupoPorId(getIdTipoGrupo());
	}

	/**
	 * Obt�m a configuracao de grupo para o �ndice
	 * 
	 * @return ArrayList<TipoConfiguracaoGrupoEnum> - Tipos de configura��o
	 *         possiveis para o grupo
	 */
	private ArrayList<TipoConfiguracaoGrupoEnum> obterTiposConfiguracaoGrupoParaTipoDeGrupo(
			CpTipoGrupo p_ctgTipoGrupo) throws AplicacaoException {
		try {
			return TipoConfiguracaoGrupoEnum
					.valoresParaTipoDeGrupo(p_ctgTipoGrupo);
		} catch (Exception e) {
			throw new AplicacaoException("Id do grupo: " + idCpGrupo
					+ " erro ao obterTiposConfiguracaoGrupoParaTipoDeGrupo.",
					0, e);
		}
	}

	/**
	 * Localiza todos os CpTipoGrupo
	 * 
	 */
	@SuppressWarnings("unchecked")
	private List<CpTipoGrupo> obterTiposGrupo() {
		return (List<CpTipoGrupo>) dao().listarTiposGrupo();
	}

	/**
	 * Prepara as listas de rela��o
	 * 
	 */
	public void prepare() {
		lotacaoGestoraSel = new DpLotacaoSelecao();
		grupoPaiSel = new CpGrupoDeEmailSelecao();
		tiposDeGrupo = obterTiposGrupo();
		tipoConfiguracao = dao().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_PERTENCER,
				CpTipoConfiguracao.class, false);
		idConfiguracao = new ArrayList<String>();
		codigoTipoConfiguracao = new ArrayList<String>(); // 0- Pessoa, 1 -
		// Lota��o, 2 -
		// email, etc.
		conteudoConfiguracao = new ArrayList<String>();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Selecionavel selecionarPorNome(final CpGrupoDaoFiltro flt) {
		// Procura por nome
		flt.setNome(Texto.removeAcentoMaiusculas(flt.getSigla()));
		flt.setSigla(null);
		try {
			final List l = dao().consultarPorFiltro(flt);
			if (l != null)
				if (l.size() == 1)
					return (DpLotacao) l.get(0);
			return null;
		} catch (Exception e) {
			return null;
		}

	}

	/**
	 * @param codigoTipoConfiguracao
	 *            the codigoTipoConfiguracao to set
	 */
	public void setCodigoTipoConfiguracao(
			ArrayList<String> codigoTipoConfiguracao) {
		this.codigoTipoConfiguracao = codigoTipoConfiguracao;
	}

	/**
	 * @param codigoTipoConfiguracaoNova
	 *            the codigoTipoConfiguracaoNova to set
	 */
	public void setCodigoTipoConfiguracaoNova(Integer codigoTipoConfiguracaoNova) {
		this.codigoTipoConfiguracaoNova = codigoTipoConfiguracaoNova;
	}

	/**
	 * @param configuracoesGrupo
	 *            the configuracoesGrupo to set
	 */
	public void setConfiguracoesGrupo(
			ArrayList<ConfiguracaoGrupo> configuracoesGrupo) {
		this.configuracoesGrupo = configuracoesGrupo;
	}

	/**
	 * @param conteudoConfiguracao
	 *            the conteudoConfiguracao to set
	 */
	public void setConteudoConfiguracao(ArrayList<String> conteudoConfiguracao) {
		this.conteudoConfiguracao = conteudoConfiguracao;
	}

	/**
	 * @param conteudoConfiguracaoNova
	 *            the conteudoConfiguracaoNova to set
	 */
	public void setConteudoConfiguracaoNova(String conteudoConfiguracaoNova) {
		this.conteudoConfiguracaoNova = conteudoConfiguracaoNova;
	}

	public void setCpTipoGrupo(CpTipoGrupo cpTipoGrupo) {
		this.cpTipoGrupo = cpTipoGrupo;
	}

	/**
	 * @param dscCpTipoGrupo
	 *            the dscCpTipoGrupo to set
	 */
	public void setDscCpTipoGrupo(String dscCpTipoGrupo) {
		this.dscCpTipoGrupo = dscCpTipoGrupo;
	}

	/**
	 * @param dscGrupo
	 *            the dscGrupo to set
	 */
	public void setDscGrupo(String dscGrupo) {
		this.dscGrupo = dscGrupo;
	}

	/**
	 * @param exception
	 *            the exception to set
	 */
	public void setException(Exception exception) {
		this.exception = exception;
	}

	public void setGrupoPaiSel(CpGrupoDeEmailSelecao grupoPaiSel) {
		this.grupoPaiSel = grupoPaiSel;
	}

	/**
	 * @param idConfiguracao
	 *            the idConfiguracao to set
	 */
	public void setIdConfiguracao(ArrayList<String> idConfiguracao) {
		this.idConfiguracao = idConfiguracao;
	}

	/**
	 * @param idConfiguracaoNova
	 *            the idConfiguracaoNova to set
	 */
	public void setIdConfiguracaoNova(String idConfiguracaoNova) {
		this.idConfiguracaoNova = idConfiguracaoNova;
	}

	/**
	 * @param idCpGrupo
	 *            the idCpGrupo to set
	 */
	public void setIdCpGrupo(Long idCpGrupo) {
		this.idCpGrupo = idCpGrupo;
	}

	public void setOrgaoUsu(Long orgaoUsu) {
		this.orgaoUsu = orgaoUsu;
	}

	/**
	 * @param siglaGrupo
	 *            the siglaGrupo to set
	 */
	public void setSiglaGrupo(String siglaGrupo) {
		this.siglaGrupo = siglaGrupo;
	}

	/**
	 * @param tipoConfiguracao
	 *            the tipoConfiguracao to set
	 */
	public void setTipoConfiguracao(CpTipoConfiguracao tipoConfiguracao) {
		this.tipoConfiguracao = tipoConfiguracao;
	}

	/**
	 * @param tiposConfiguracaoGrupoParaTipoDeGrupo
	 *            the tiposConfiguracaoGrupoParaTipoDeGrupo to set
	 */
	public void setTiposConfiguracaoGrupoParaTipoDeGrupo(
			ArrayList<TipoConfiguracaoGrupoEnum> tiposConfiguracaoGrupoParaTipoDeGrupo) {
		this.tiposConfiguracaoGrupoParaTipoDeGrupo = tiposConfiguracaoGrupoParaTipoDeGrupo;
	}

	/**
	 * @param tiposDeGrupo
	 *            the tiposDeGrupo to set
	 */
	public void setTiposDeGrupo(ArrayList<CpTipoGrupo> tiposDeGrupo) {
		this.tiposDeGrupo = tiposDeGrupo;
	}

	public void setLotacaoGestoraSel(DpLotacaoSelecao lotacaoGestoraSel) {
		this.lotacaoGestoraSel = lotacaoGestoraSel;
	}

	public DpLotacaoSelecao getLotacaoGestoraSel() {
		return lotacaoGestoraSel;
	}

	public void setIdConfGestor(Long idConfGestor) {
		this.idConfGestor = idConfGestor;
	}

	public Long getIdConfGestor() {
		return idConfGestor;
	}

}
