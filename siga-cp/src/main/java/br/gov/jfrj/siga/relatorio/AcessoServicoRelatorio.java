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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import ar.com.fdvs.dj.domain.builders.DJBuilderException;
import br.gov.jfrj.relatorio.dinamico.AbstractRelatorioBaseBuilder;
import br.gov.jfrj.relatorio.dinamico.RelatorioRapido;
import br.gov.jfrj.relatorio.dinamico.RelatorioTemplate;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;

/**
 * Relat�rio indicando todas as pessoas que tem acesso aos sistemas/m�dulos e
 * quais s�o os niveis de acesso
 * 
 * @author aym
 * 
 */
public class AcessoServicoRelatorio extends RelatorioTemplate {
	private CpServico cpServico;
	private ArrayList<CpSituacaoConfiguracao> cpSituacoesConfiguracao;
	private ArrayList<CpOrgaoUsuario> cpOrgaosUsuario;

	@SuppressWarnings("unchecked")
	public AcessoServicoRelatorio(Map parametros) throws DJBuilderException {
		super(parametros);
		if (parametros.get("idServico") == null) {
			throw new DJBuilderException("Par�metro idServico n�o informado!");
		}
		if (parametros.get("situacoesSelecionadas") == null) {
			throw new DJBuilderException(
					"Par�metro situacoesSelecionadas n�o informado!");
		}
		if (parametros.get("idOrgaoUsuario") == null) {
			throw new DJBuilderException(
					"Par�metro idOrgaoUsuario n�o informado!");
		}

		try {
			Long t_lngIdServico = Long.parseLong((String) parametros
					.get("idServico"));
			setCpServico(dao()
					.consultar(t_lngIdServico, CpServico.class, false));
		} catch (Exception e) {
			throw new DJBuilderException("Par�metro idServico inv�lido!");
		}
		try {
			ArrayList<CpSituacaoConfiguracao> cpSituacoes = new ArrayList<CpSituacaoConfiguracao>();
			String strSits = (String) parametros.get("situacoesSelecionadas");
			for (String strIdSit : strSits.split(",")) {
				Long idSit = Long.parseLong(strIdSit);
				CpSituacaoConfiguracao sit = dao().consultar(idSit,
						CpSituacaoConfiguracao.class, false);
				cpSituacoes.add(sit);
			}
			setCpSituacoesConfiguracao(cpSituacoes);
		} catch (Exception e) {
			throw new DJBuilderException("Situa��es inv�lidas ! erro:"
					+ e.getMessage());
		}
		try {
			if (parametros.get("idOrgaoUsuario").equals("-1")) {
				setCpOrgaosUsuario((ArrayList<CpOrgaoUsuario>) dao()
						.listarOrgaosUsuarios());
			} else {
				Long idOrg = Long.parseLong((String) parametros
						.get("idOrgaoUsuario"));
				ArrayList<CpOrgaoUsuario> cpOrgs = new ArrayList<CpOrgaoUsuario>();
				cpOrgs.add(dao().consultar(idOrg, CpOrgaoUsuario.class, false));
				setCpOrgaosUsuario(cpOrgs);
			}
		} catch (Exception e) {
			throw new DJBuilderException("Orgao Usuario inv�lido ! erro:"
					+ e.getMessage());
		}

	}

	@Override
	public AbstractRelatorioBaseBuilder configurarRelatorio()
			throws DJBuilderException, JRException {
		this.setTemplateFile(null);
		this.setTitle("Acesso - " + getDescricaoTipoConfiguracao() + " - "
				+ "(" + cpServico.getSiglaServico() + ") "
				+ cpServico.getDscServico());
		this.addColuna("Situa��o", 20, RelatorioRapido.ESQUERDA, true, false);
		this.addColuna("Pessoa", 60, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Lota��o", 20, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Desde", 12, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Origem", 20, RelatorioRapido.ESQUERDA, false, false);
		this.addColuna("Cadastrante", 18, RelatorioRapido.ESQUERDA, false,
				false);
		return this;
	}

	/**
	 * Processa as configura��es
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Collection processarDados() {
		CpTipoConfiguracao tipo = CpDao.getInstance().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO,
				CpTipoConfiguracao.class, false);
		ArrayList<AlteracaoDireitosItem> aldis = new ArrayList<AlteracaoDireitosItem>();
		ArrayList<String> dados = new ArrayList<String>();
		try {
			for (CpOrgaoUsuario cpou : getCpOrgaosUsuario()) {
				for (DpPessoa pes : obterPessoas(cpou)) {
					AlteracaoDireitosItem it = gerar(tipo, null, pes, null,
							cpou, getCpServico(), null);
					if (getCpSituacoesConfiguracao().contains(it.getSituacao())) {
						aldis.add(it);
					}
				}
			}
			ordenarConfiguracoes(aldis);
			for (AlteracaoDireitosItem it : aldis) {
				processarItem(it, dados);
			}
		} catch (Exception e) {
			dados = new ArrayList<String>();
		}
		return dados;
	}

	private AlteracaoDireitosItem gerar(CpTipoConfiguracao tipo,
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

	private ArrayList<DpPessoa> obterPessoas(CpOrgaoUsuario cpou) {
		return (ArrayList<DpPessoa>) dao().listarAtivos(DpPessoa.class,
				"dataFimPessoa", cpou.getIdOrgaoUsu());
	}

	/**
	 * Utilizado apenas para teste subtituindo obterPessoas
	 * 
	 * @param cpou
	 * @return
	 */
	@SuppressWarnings("unused")
	private ArrayList<DpPessoa> obterPessoasTeste(CpOrgaoUsuario cpou) {
		ArrayList<DpPessoa> psas = new ArrayList<DpPessoa>();
		psas.add(dao().consultar(131078L, DpPessoa.class, true));
		psas.add(dao().consultar(132232L, DpPessoa.class, true));
		psas.add(dao().consultar(129903L, DpPessoa.class, true));
		psas.add(dao().consultar(131002L, DpPessoa.class, true));
		psas.add(dao().consultar(129929L, DpPessoa.class, true));
		return psas;
	}

	/**
	 * Ordena o ArraList de ConfiguracaoAcesso
	 * 
	 * @param arl
	 *            ArrayList com as configura��es a rodenar
	 */
	@SuppressWarnings("unchecked")
	private void ordenarConfiguracoes(ArrayList<AlteracaoDireitosItem> arl) {
		Collections.sort(arl, new Comparator() {
			public int compare(Object o1, Object o2) {
				AlteracaoDireitosItem c1 = (AlteracaoDireitosItem) o1;
				AlteracaoDireitosItem c2 = (AlteracaoDireitosItem) o2;
				String dscSit1;
				if (c1.getSituacao() == null) {
					dscSit1 = new String();
				} else {
					dscSit1 = c1.getSituacao().getDscSitConfiguracao();
				}
				String dscSit2;
				if (c2.getSituacao() == null) {
					dscSit2 = new String();
				} else {
					dscSit2 = c2.getSituacao().getDscSitConfiguracao();
				}
				if (dscSit1.equals(dscSit2)) {
					String nome1;
					if (c1.getPessoa() == null) {
						nome1 = new String();
					} else {
						nome1 = c1.getPessoa().getNomePessoa();
					}
					String nome2;
					if (c2.getPessoa() == null) {
						nome2 = new String();
					} else {
						nome2 = c2.getPessoa().getNomePessoa();
					}
					return nome1.compareToIgnoreCase(nome2);
				} else {
					return dscSit1.compareToIgnoreCase(dscSit2);
				}
			}
		});
	}

	/**
	 * Preenche os dados com as informa��es da configura��o j� formatados
	 * 
	 * @param cfga
	 *            - Configura��o acesso
	 * @param dados
	 *            - cole��o de linhas do relat�rio
	 */
	private void processarItem(AlteracaoDireitosItem cfga, List<String> dados) {
		try {
			dados.add(cfga.getSituacao().getDscSitConfiguracao());
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(cfga.getPessoa().getNomePessoa());
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(cfga.getPessoa().getLotacao().getSigla());
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(printDate(cfga.getInicio()));
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(printOrigem(cfga));
		} catch (Exception e) {
			dados.add("");
		}
		try {
			dados.add(String.valueOf(cfga.getCadastrante().getSesbPessoa()
					+ cfga.getCadastrante().getMatricula()));
		} catch (Exception e) {
			dados.add("");
		}
	}

	private String printDate(Date dte) {
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return df.format(dte);
	}

	/**
	 * @param configura��o
	 *            acesso
	 * @return Uma String representativa da origem
	 */
	private String printOrigem(AlteracaoDireitosItem cfga) {
		return cfga.printOrigemCurta();
	}

	private Long getIdTipoConfiguracao() {
		return CpTipoConfiguracao.TIPO_CONFIG_UTILIZAR_SERVICO;
	}

	private CpTipoConfiguracao getTipoConfiguracao() {
		return dao().consultar(getIdTipoConfiguracao(),
				CpTipoConfiguracao.class, false);
	}

	private String getDescricaoTipoConfiguracao() {
		return getTipoConfiguracao().getDscTpConfiguracao();
	}

	private CpDao dao() {
		return CpDao.getInstance();
	}

	public static void main(String args[]) throws Exception {
	}

	/**
	 * @return the cpServico
	 */
	public CpServico getCpServico() {
		return cpServico;
	}

	/**
	 * @param cpServico
	 *            the cpServico to set
	 */
	public void setCpServico(CpServico cpServico) {
		this.cpServico = cpServico;
	}

	/**
	 * @return the cpSituacoesConfiguracao
	 */
	public ArrayList<CpSituacaoConfiguracao> getCpSituacoesConfiguracao() {
		return cpSituacoesConfiguracao;
	}

	/**
	 * @param cpSituacoesConfiguracao
	 *            the cpSituacoesConfiguracao to set
	 */
	public void setCpSituacoesConfiguracao(
			ArrayList<CpSituacaoConfiguracao> cpSituacoesConfiguracao) {
		this.cpSituacoesConfiguracao = cpSituacoesConfiguracao;
	}

	/**
	 * @return the cpOrgaosUsuario
	 */
	public ArrayList<CpOrgaoUsuario> getCpOrgaosUsuario() {
		return cpOrgaosUsuario;
	}

	/**
	 * @param cpOrgaosUsuario
	 *            the cpOrgaosUsuario to set
	 */
	public void setCpOrgaosUsuario(ArrayList<CpOrgaoUsuario> cpOrgaosUsuario) {
		this.cpOrgaosUsuario = cpOrgaosUsuario;
	}

}
