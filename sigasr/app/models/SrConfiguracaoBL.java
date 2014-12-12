package models;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.bl.CpConfiguracaoBL;

public class SrConfiguracaoBL extends CpConfiguracaoBL {

	public static int ITEM_CONFIGURACAO = 31;

	public static int ACAO = 32;

	public static int LISTA_PRIORIDADE = 33;

	public static int TIPO_ATRIBUTO = 34;

	public static SrConfiguracaoBL get() {
		return (SrConfiguracaoBL) Sr.getInstance().getConf();
	}

	public SrConfiguracaoBL() {
		super();
		setComparator(new SrConfiguracaoComparator());
	}

	@Override
	public void deduzFiltro(CpConfiguracao cpConfiguracao) {
		super.deduzFiltro(cpConfiguracao);
		if (cpConfiguracao instanceof SrConfiguracao) {
			SrConfiguracao srConf = (SrConfiguracao) cpConfiguracao;
			if (srConf.itemConfiguracaoFiltro != null)
				srConf.itemConfiguracaoFiltro = srConf.itemConfiguracaoFiltro.getAtual();
			if (srConf.acaoFiltro != null)
				srConf.acaoFiltro = srConf.acaoFiltro.getAtual();
			if (srConf.listaPrioridade != null)
				srConf.listaPrioridade = srConf.listaPrioridade.getListaAtual();
		}

	}

	@Override
	public boolean atendeExigencias(CpConfiguracao cfgFiltro,
			Set<Integer> atributosDesconsiderados, CpConfiguracao cfg,
			SortedSet<CpPerfil> perfis) {

		if (!super.atendeExigencias(cfgFiltro, atributosDesconsiderados, cfg,
				perfis))
			return false;

		if (cfg instanceof SrConfiguracao
				&& cfgFiltro instanceof SrConfiguracao) {
			SrConfiguracao conf = (SrConfiguracao) cfg;
			SrConfiguracao filtro = (SrConfiguracao) cfgFiltro;

			if (filtro.subTipoConfig == SrSubTipoConfiguracao.DESIGNACAO_PRE_ATENDENTE
					&& conf.preAtendente == null)
				return false;

			if (filtro.subTipoConfig == SrSubTipoConfiguracao.DESIGNACAO_ATENDENTE
					&& conf.atendente == null)
				return false;

			if (filtro.subTipoConfig == SrSubTipoConfiguracao.DESIGNACAO_POS_ATENDENTE
					&& conf.posAtendente == null)
				return false;

			if (filtro.subTipoConfig == SrSubTipoConfiguracao.DESIGNACAO_EQUIPE_QUALIDADE
					&& conf.equipeQualidade == null)
				return false;
			
			if (filtro.subTipoConfig == SrSubTipoConfiguracao.DESIGNACAO_PESQUISA_SATISFACAO
					&& conf.pesquisaSatisfacao == null)
				return false;

			if (!atributosDesconsiderados.contains(ACAO)
					&& conf.acoesSet != null && conf.acoesSet.size() > 0) {
				boolean acaoAtende = false;
				for (SrAcao item : conf.acoesSet) {
					if (filtro.acaoFiltro != null
							&& item.getAtual().isPaiDeOuIgualA(
									filtro.acaoFiltro)) {
						acaoAtende = true;
						break;
					}
				}
				if (!acaoAtende)
					return false;
			}
			
			if (!atributosDesconsiderados.contains(ITEM_CONFIGURACAO)
					&& conf.itemConfiguracaoSet != null
					&& conf.itemConfiguracaoSet.size() > 0) {
				boolean itemAtende = false;
				for (SrItemConfiguracao item : conf.itemConfiguracaoSet) {
					if (filtro.itemConfiguracaoFiltro != null
							&& item.getAtual().isPaiDeOuIgualA(
									filtro.itemConfiguracaoFiltro)){
						itemAtende = true;
						break;
					}
				}
				if (!itemAtende)
					return false;
			}			
			
			if (!atributosDesconsiderados.contains(LISTA_PRIORIDADE)
					&& conf.listaPrioridade != null
					&& (filtro.listaPrioridade == null || (filtro.listaPrioridade != null && !conf.listaPrioridade
							.getListaAtual().equivale(filtro.listaPrioridade))))
				return false;

			if (!atributosDesconsiderados.contains(TIPO_ATRIBUTO)
					&& conf.tipoAtributo != null
					&& (filtro.tipoAtributo == null || (filtro.tipoAtributo != null && !conf.tipoAtributo
							.getAtual().equivale(filtro.tipoAtributo))))
				return false;

		}
		return true;
	}

	public List<SrConfiguracao> listarConfiguracoesAtivasPorFiltro(
			SrConfiguracao confFiltro, int atributoDesconsideradoFiltro[])
			throws Exception {

		deduzFiltro(confFiltro);
		Set<Integer> atributosDesconsiderados = new LinkedHashSet<Integer>();
		for (int i = 0; i < atributoDesconsideradoFiltro.length; i++) {
			atributosDesconsiderados.add(atributoDesconsideradoFiltro[i]);
		}

		List<SrConfiguracao> listaFinal = new ArrayList<SrConfiguracao>();
		TreeSet<CpConfiguracao> lista = getListaPorTipo(confFiltro
				.getCpTipoConfiguracao().getIdTpConfiguracao());

		for (CpConfiguracao cpConfiguracao : lista) {
			if (cpConfiguracao.getHisDtFim() == null
					&& atendeExigencias(confFiltro, atributosDesconsiderados,
							(SrConfiguracao) cpConfiguracao, null))
				listaFinal.add((SrConfiguracao) cpConfiguracao);
		}
		return listaFinal;
	}

	@Override
	protected void evitarLazy(List<CpConfiguracao> provResults) {
		super.evitarLazy(provResults);

		for (CpConfiguracao conf : provResults) {
			if (!(conf instanceof SrConfiguracao))
				continue;
			SrConfiguracao srConf = (SrConfiguracao) conf;
			if (srConf.preAtendente != null)
				srConf.preAtendente.getLotacaoAtual();
			if (srConf.atendente != null)
				srConf.atendente.getLotacaoAtual();
			if (srConf.posAtendente != null)
				srConf.posAtendente.getLotacaoAtual();
			if (srConf.itemConfiguracaoSet != null)
				for (SrItemConfiguracao i : srConf.itemConfiguracaoSet)
					i.getAtual();
			if (srConf.acoesSet != null)
				for (SrAcao i : srConf.acoesSet)
					i.getAtual();
			if (srConf.tipoAtributo != null)
				srConf.tipoAtributo.getHisIdIni();
			if (srConf.listaPrioridade != null)
				srConf.listaPrioridade.getHisIdIni();
			if (srConf.pesquisaSatisfacao != null)
				srConf.pesquisaSatisfacao.getHisIdIni();
			if (srConf.getListaConfiguracaoSet() != null) {
				for (SrLista listaConf : srConf.getListaConfiguracaoSet()){
					listaConf.getId();
				}
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void atualizarConfiguracoesDoCache(List<SrConfiguracao> configs) {
		List<SrConfiguracao> evitarLazy = new ArrayList<SrConfiguracao>();
		for (SrConfiguracao conf : configs) {
			hashListas.get(conf.getCpTipoConfiguracao().getIdTpConfiguracao())
					.remove(conf);
			SrConfiguracao newConf = SrConfiguracao.findById(conf
					.getIdConfiguracao());
			hashListas.get(
					newConf.getCpTipoConfiguracao().getIdTpConfiguracao()).add(
					newConf);
			evitarLazy.add(newConf);
		}
		evitarLazy((List<CpConfiguracao>) (List<?>) evitarLazy);
	}

}
