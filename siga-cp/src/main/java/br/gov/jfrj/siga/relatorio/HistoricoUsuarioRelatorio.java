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
package br.gov.jfrj.siga.relatorio;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import net.sf.jasperreports.engine.JRException;

import org.hibernate.Query;

import ar.com.fdvs.dj.domain.builders.DJBuilderException;
import br.gov.jfrj.relatorio.dinamico.AbstractRelatorioBaseBuilder;
import br.gov.jfrj.relatorio.dinamico.RelatorioRapido;
import br.gov.jfrj.relatorio.dinamico.RelatorioTemplate;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.sinc.lib.Item;
import br.gov.jfrj.siga.sinc.lib.Sincronizador;
import br.gov.jfrj.siga.sinc.lib.Sincronizavel;

public class HistoricoUsuarioRelatorio extends RelatorioTemplate {
	private DpPessoa dpPessoa;
	private List<DpPessoa> pessoasDoUsuario;
	private Date dtAnterior;
	private DpLotacao lotacaoAnterior;

	/**
	 * @return the pessoasDoUsuario
	 */
	public List<DpPessoa> getPessoasDoUsuario() {
		return pessoasDoUsuario;
	}

	/**
	 * @param pessoasDoUsuario
	 *            the pessoasDoUsuario to set
	 */
	public void setPessoasDoUsuario(List<DpPessoa> pessoasDoUsuario) {
		this.pessoasDoUsuario = pessoasDoUsuario;
	}

	/**
	 * @return the dtAnterior
	 */
	public Date getDtAnterior() {
		return dtAnterior;
	}

	/**
	 * @param dtAnterior
	 *            the dtAnterior to set
	 */
	public void setDtAnterior(Date dtAnterior) {
		this.dtAnterior = dtAnterior;
	}

	/**
	 * @return the lotacaoAnterior
	 */
	public DpLotacao getLotacaoAnterior() {
		return lotacaoAnterior;
	}

	/**
	 * @param lotacaoAnterior
	 *            the lotacaoAnterior to set
	 */
	public void setLotacaoAnterior(DpLotacao lotacaoAnterior) {
		this.lotacaoAnterior = lotacaoAnterior;
	}

	@SuppressWarnings("unchecked")
	public HistoricoUsuarioRelatorio(Map parametros) throws DJBuilderException {
		super(parametros);
		if (parametros.get("idPessoa") == null) {
			throw new DJBuilderException("Par�metro idPessoa n�o informado!");
		}
		try {
			Long t_lngIdPessoa = Long.parseLong((String) parametros
					.get("idPessoa"));
			setDpPessoa(dao().consultar(t_lngIdPessoa, DpPessoa.class, false));
		} catch (Exception e) {
			throw new DJBuilderException("Par�metro idPessoa inv�lido!");
		}
		setPessoasDoUsuario(obterPessoasDoUsuario());
		@SuppressWarnings("unused")
		int conta = 0;
	}

	@Override
	public AbstractRelatorioBaseBuilder configurarRelatorio()
			throws DJBuilderException, JRException {
		this.setTemplateFile(null);
		this.setTitle("Hist�rico de Usu�rio: " + "(" + dpPessoa.getSesbPessoa()
				+ dpPessoa.getMatricula() + ") " + dpPessoa.getNomePessoa());
		this.addColuna("Lota��o", 0, RelatorioRapido.ESQUERDA, true, false);
		this.addColuna("Desde", 12, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Servi�o", 40, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Situa��o", 15, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Origem", 13, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Cadastrante", 20, RelatorioRapido.ESQUERDA, false,
				false);
		return this;
	}

	/**
	 * Preenche os dados com as informa��es da configura��o j� formatados
	 * 
	 * @param cfga
	 *            - Configura��o acesso
	 * @param dados
	 *            - cole��o de linhas do relat�rio
	 */

	private void processarItem(Item itm, List<String> dados, Date dt) {

		AlteracaoDireitosItem novo = (AlteracaoDireitosItem) itm.getNovo();
		DpLotacao lot = novo.getPessoa().getLotacao();
		try {
			dados.add(lot.getSiglaLotacao());
		} catch (Exception e) {
			dados.add("");
		}
		try {
			if (getDtAnterior() == null
					|| !printDate(getDtAnterior()).equals(printDate(dt))
					|| getLotacaoAnterior() == null
					|| !lot.equals(getLotacaoAnterior())) {
				dados.add(printDate(dt));
			} else {
				dados.add("");
			}
		} catch (Exception e) {
			dados.add(" *");
		}
		try {
			dados.add(novo.getServico().getDescricao());
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(novo.getSituacao().getDscSitConfiguracao());
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(novo.printOrigemCurta());
		} catch (Exception e) {
			dados.add("");
		}

		try {
			dados.add(String.valueOf(novo.getCadastrante().getSesbPessoa()
					+ novo.getCadastrante().getMatricula()));
		} catch (Exception e) {
			dados.add("");
		}
		setDtAnterior(dt);
		setLotacaoAnterior(lot);
	}

	private String printDate(Date dte) {
		try {
			SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			return df.format(dte);
		} catch (Exception e) {
			return "";
		}
	}

	private SortedSet<Date> obterDatasRelevantes() {
		SortedSet<Date> datas = new TreeSet<Date>();
		datas.addAll(obterDatasAlteracaoPessoa());
		datas.addAll(obterDatasAlteracaoConfiguracao());
		datas.add(new Date());
		return datas;
	}

	private ArrayList<Date> obterDatasAlteracaoPessoa() {
		ArrayList<Date> arlDatas = new ArrayList<Date>();
		for (DpPessoa pes : getPessoasDoUsuario()) {
			arlDatas.add(pes.getDataInicio());
			if (pes.getDataFim() != null) {
				arlDatas.add(pes.getDataFim());
			}
		}
		return arlDatas;
	}

	private DpPessoa obterPessoaDoUsuarioAtivaNaData(Date dt) {
		for (DpPessoa pes : getPessoasDoUsuario()) {
			if (pes.ativaNaData(dt)) {
				return pes;
			}
		}
		return getDpPessoa();
	}

	private ArrayList<Date> obterDatasAlteracaoConfiguracao() {
		List<CpConfiguracao> confs = dao().listarConfiguracoes();
		ArrayList<Date> arlDatas = new ArrayList<Date>();
		for (CpConfiguracao conf : confs) {

			if (conf.getCpTipoConfiguracao().getIdTpConfiguracao().equals(
					CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO)
					|| conf.getCpTipoConfiguracao().getIdTpConfiguracao()
							.equals(CpTipoConfiguracao.TIPO_CONFIG_PERTENCER)) {
				arlDatas.add(conf.getHisDtIni());
				if (conf.getHisDtFim() != null) {
					arlDatas.add(conf.getHisDtFim());
				}
			}
		}
		return arlDatas;
	}

	@SuppressWarnings("unchecked")
	private List<DpPessoa> obterPessoasDoUsuario() {
		final Query queryPessoas = dao().getSessao().getNamedQuery(
				"consultarPorIdInicialDpPessoaInclusiveFechadas");
		Long t_lngIdPessoaInicial = getDpPessoa().getIdInicial();
		queryPessoas.setLong("idPessoaIni", t_lngIdPessoaInicial);
		return (List<DpPessoa>) queryPessoas.list();
	}

	/**
	 * Processa as configura��es ativas ou n�o para os v�rios ids da pessoa
	 * (mesmo id inicial que a pessoa selecionada)
	 */

	@SuppressWarnings("unchecked")
	@Override
	public Collection processarDados() {
		ArrayList<String> dados = new ArrayList<String>();
		List<CpServico> servicos = CpDao.getInstance().listarServicos();
		CpTipoConfiguracao tipo = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO,
				CpTipoConfiguracao.class, false);

		SortedSet<Sincronizavel> setAntes = new TreeSet<Sincronizavel>(); // obterItensDosServicosNaData(tipo,
		setDtAnterior(null);
		setLotacaoAnterior(null);
		for (Date dt : obterDatasRelevantes()) {
			try {
				SortedSet<Sincronizavel> setDepois = obterItensDosServicosNaData(
						tipo, servicos, dt);

				List<Item> list = compararServicosNoPeriodo(setAntes,
						setDepois, servicos);
				for (Item itm : list) {
					processarItem(itm, dados, dt);
				}
				setAntes = setDepois;
			} catch (Exception e) {
				throw new Error(e);
			}
		}
		// gerarArquivoDados(dados, "c:\\RelHistUsu.txt");
		return dados;

	}

	@SuppressWarnings("unused")
	private void gerarArquivoDados(ArrayList<String> dados, String nomeArq) {
		final int QUANTOS_CAMPOS = 6;
		File file = new File(nomeArq);
		try {
			Writer output = new BufferedWriter(new FileWriter(file));
			int contaCampos = 0;
			for (String campo : dados) {
				contaCampos++;
				output.write(campo);
				if (contaCampos < QUANTOS_CAMPOS) {
					output.write("\t");

				} else {
					output.write("\r\n");
					contaCampos = 0;
				}
			}
			output.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public List<Item> compararServicosNoPeriodo(
			SortedSet<Sincronizavel> setAntes,
			SortedSet<Sincronizavel> setDepois, List<CpServico> srvs)
			throws Exception {
		Sincronizador sinc = new Sincronizador();
		sinc.setSetNovo(setDepois);
		sinc.setSetAntigo(setAntes);
		List<Item> list = sinc.getEncaixe();
		for (Item itm : list)
			System.out.println(itm.getDescricao());
		return list;
	}

	@SuppressWarnings("unchecked")
	public SortedSet obterItensDosServicosNaData(CpTipoConfiguracao tipo,
			List<CpServico> srvs, Date dtEvn) throws Exception {
		TreeSet lista = new TreeSet<AlteracaoDireitosItem>();
		for (CpServico srv : srvs) {
			AlteracaoDireitosItem item = gerar(tipo, null,
					obterPessoaDoUsuarioAtivaNaData(dtEvn), null, null, srv,
					dtEvn);
			lista.add(item);
		}
		return lista;
	}

	static public AlteracaoDireitosItem gerar(CpTipoConfiguracao tipo,
			CpPerfil perfil, DpPessoa pessoa, DpLotacao lotacao,
			CpOrgaoUsuario orgao, CpServico servico, Date dtEvn)
			throws Exception {
		CpConfiguracao cfgFiltro = new CpConfiguracao();
		cfgFiltro.setCpGrupo(perfil);
		cfgFiltro.setDpPessoa(pessoa);
		cfgFiltro.setLotacao(lotacao);
		cfgFiltro.setOrgaoUsuario(orgao);
		cfgFiltro.setCpServico(servico);
		cfgFiltro.setCpTipoConfiguracao(tipo);
		CpConfiguracao cfg = Cp.getInstance().getConf().buscaConfiguracao(
				cfgFiltro, new int[0], dtEvn);
		AlteracaoDireitosItem itm = new AlteracaoDireitosItem();
		itm.setServico(servico);
		itm.setPessoa(pessoa);
		if (cfg != null) {
			itm.setCfg(cfg);
			itm.setSituacao(cfg.getCpSituacaoConfiguracao());
		} else {
			itm.setSituacao(servico.getCpTipoServico().getSituacaoDefault());
		}
		return itm;
	}

	private CpDao dao() {
		return CpDao.getInstance();
	}

	/**
	 * @return the cpServico
	 */
	public DpPessoa getDpPessoa() {
		return dpPessoa;
	}

	/**
	 * @param cpServico
	 *            the cpServico to set
	 */
	public void setDpPessoa(DpPessoa dpPessoa) {
		this.dpPessoa = dpPessoa;
	}
/*
	public static void main(String args[]) throws Exception {
		AnnotationConfiguration cfg = CpDao.criarHibernateCfg(
				"jdbc:oracle:thin:@servidor:1521:instancia", "usuario",
				"senha");
		HibernateUtil.configurarHibernate(cfg, "");
		Map<String, String> listaParametros = new HashMap<String, String>();
		listaParametros.put("idPessoa", "129972");
		HistoricoUsuarioRelatorio r = new HistoricoUsuarioRelatorio(
				listaParametros);
		r.gerar();
		JasperViewer.viewReport(r.getRelatorioJasperPrint());
	}
	*/
}
