package br.gov.jfrj.siga.ex.bl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExNivelAcesso;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;

public class ExAcesso {
	public static final String ACESSO_PUBLICO = "PUBLICO";

	// Armazena os acessos espec�ficos de um documento. Para calcular o acesso
	// ainda � necess�rio acrescentar os acessos do documento ao qual este est�
	// juntado, e por assim em diante.
	//
	private Map<ExDocumento, Set<Object>> cache = new HashMap<ExDocumento, Set<Object>>();

	private Set<Object> acessos = null;

	private void add(Object o) {
		if (acessos.contains(ACESSO_PUBLICO)) {
			return;
		}

		if (o instanceof DpLotacao) {
			DpLotacao l = (DpLotacao) o;
			if (acessos.contains(l.getOrgaoUsuario()))
				return;
		}

		if (o instanceof DpPessoa) {
			DpPessoa p = (DpPessoa) o;
			if (acessos.contains(p.getOrgaoUsuario()))
				return;
		}

		acessos.add(o);
	}

	private void incluirPessoas(ExDocumento doc) {
		for (ExMobil m : doc.getExMobilSet()) {
			for (ExMovimentacao mov : m.getExMovimentacaoSet()) {
				if (mov.getResp() == null) {
					add(mov.getLotaResp());
				} else {
					add(mov.getResp());
				}

				if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REDEFINICAO_NIVEL_ACESSO) {
					if (mov.getCadastrante() == null) {
						add(mov.getLotaCadastrante());
					} else {
						add(mov.getCadastrante());
					}
				}
			}
		}
	}

	private void incluirLotacoes(ExDocumento doc) {
		for (ExMobil m : doc.getExMobilSet()) {
			for (ExMovimentacao mov : m.getExMovimentacaoSet()) {
				add(mov.getLotaResp());
				if (mov.getResp() != null)
					add(mov.getResp().getLotacao());
			}
		}
	}

	private void incluirCossignatarios(ExDocumento doc) {
		if (doc.getMobilGeral().getExMovimentacaoSet() != null){
			for (ExMovimentacao mov : doc.getMobilGeral().getExMovimentacaoSet()) {
				if (mov.getExTipoMovimentacao()
						.getIdTpMov()
						.equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO)
						&& mov.getExMovimentacaoCanceladora() == null)
					add(mov.getSubscritor());
			}
		}
	}

	private void incluirPerfis(ExDocumento doc) {
		if (doc.getMobilGeral().getExMovimentacaoSet() != null){
			for (ExMovimentacao mov : doc.getMobilGeral().getExMovimentacaoSet()) {
				if (!mov.isCancelada()
						&& mov.getExTipoMovimentacao()
								.getIdTpMov()
								.equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_VINCULACAO_PAPEL)) {
					if (mov.getSubscritor() != null) {
						add(mov.getSubscritor());
					} else {
						add(mov.getLotaSubscritor());
					}
				}
			}
		}
	}

	private void incluirOrgaos(ExDocumento doc) {
		for (ExMobil m : doc.getExMobilSet()) {
			for (ExMovimentacao mov : m.getExMovimentacaoSet()) {
				if (mov.getLotaResp() != null)
					add(mov.getLotaResp().getOrgaoUsuario());
				if (mov.getResp() != null)
					add(mov.getResp().getOrgaoUsuario());
			}
		}
	}

	private void incluirSubsecretaria(DpLotacao lot) {
		DpLotacao subLotaDoc = Ex.getInstance().getComp().getSubsecretaria(lot);
		if (subLotaDoc == null) {
			add(lot);
			return;
		}
		Set<DpLotacao> lista = new HashSet<DpLotacao>();
		lista.add(subLotaDoc);
		lista = getSetoresSubordinados(lista);
		for (DpLotacao l : lista)
			add(l);
	}

	private Set<DpLotacao> getSetoresSubordinados(Set<DpLotacao> lista) {
		Set<DpLotacao> todosSubordinados = new HashSet<DpLotacao>();

		for (DpLotacao pai : lista) {
			if (pai.getDpLotacaoSubordinadosSet().size() <= 0) {
				todosSubordinados.add(pai);
				continue;
			} else {
				todosSubordinados.add(pai);
				todosSubordinados.addAll(getSetoresSubordinados(pai
						.getDpLotacaoSubordinadosSet()));
			}
		}

		return todosSubordinados;
	}

	private Set<ExDocumento> getDocumentoESeusPais(ExDocumento doc,
			Set<ExDocumento> set) {
		if (set == null) {
			set = new HashSet<ExDocumento>();
		}
		set.add(doc);

		for (ExMobil mob : doc.getExMobilSet()) {
			ExMobil pai = mob.getExMobilPai();
			if (pai != null) {
				ExDocumento docPai = pai.doc();
				if (!set.contains(docPai)) {
					getDocumentoESeusPais(docPai, set);
				}
			}
		}
		return set;
	}

	private Set<Object> calcularAcessos(ExDocumento doc, Date dt) {
		acessos = new HashSet<Object>();

		if (doc == null)
			return acessos;

		// Aberto
		if (!doc.isAssinado()) {
			switch (doc.getExNivelAcessoDoDocumento().getGrauNivelAcesso()) {
			case (int) ExNivelAcesso.NIVEL_ACESSO_PESSOAL:
			case (int) ExNivelAcesso.NIVEL_ACESSO_PESSOA_SUB:
				add(doc.getCadastrante());
				break;
			default:
				add(doc.getLotaCadastrante());
			}
			add(doc.getSubscritor());
			add(doc.getTitular());
			// podeMovimentar(titular, lotaTitular, mob)
			incluirPerfis(doc);
			incluirCossignatarios(doc);
		}

		// TODO: devemos buscar a data de cancelamento

		// Cancelado
		else if (doc.isCancelado()) {
			add(doc.getLotaCadastrante());
			add(doc.getSubscritor());
			add(doc.getTitular());
		}

		// TODO: devemos buscar a data que ficou sem efeito

		// Sem Efeito
		else if (doc.isSemEfeito()) {
			add(doc.getLotaCadastrante());
			add(doc.getSubscritor());
			add(doc.getTitular());
		}

		// Por nivel de acesso
		else {
			Set<ExDocumento> documentoESeusPais = getDocumentoESeusPais(doc,
					null);

			// Calcula os acessos de cada documento individualmente e armazena
			// no cache
			for (ExDocumento d : documentoESeusPais) {
				if (cache.containsKey(d))
					continue;

				acessos = new HashSet<Object>();

				add(doc.getSubscritor());
				add(doc.getTitular());
				incluirPerfis(doc);
				incluirCossignatarios(doc);

				// Verifica se o titular � subscritor de algum despacho do
				// dumento
				addSubscritorDespacho(doc);

				// TODO: buscar a data que foi feita a �ltima movimenta��o de
				// mudan�a de nivel de acesso

				switch (d.getExNivelAcesso().getGrauNivelAcesso().intValue()) {
				case (int) ExNivelAcesso.NIVEL_ACESSO_PUBLICO:
					add(ACESSO_PUBLICO);
					break;
				case (int) ExNivelAcesso.NIVEL_ACESSO_ENTRE_ORGAOS:
					add(d.getLotaCadastrante().getOrgaoUsuario());
					add(d.getSubscritor());
					add(d.getTitular());
					add(d.getDestinatario());
					add(d.getLotaDestinatario());
					incluirOrgaos(d);
					break;
				case (int) ExNivelAcesso.NIVEL_ACESSO_PESSOA_SUB:
					add(d.getSubscritor());
					add(d.getTitular());
					add(d.getDestinatario());
					if (d.getDestinatario() == null)
						add(d.getLotaDestinatario());
					incluirSubsecretaria(d.getLotaDestinatario());
					incluirPessoas(d);
					break;
				case (int) ExNivelAcesso.NIVEL_ACESSO_SUB_PESSOA:
					add(d.getSubscritor());
					add(d.getTitular());
					add(d.getDestinatario());
					if (d.getDestinatario() == null)
						add(d.getLotaDestinatario());
					incluirSubsecretaria(d.getLotaCadastrante());
					incluirPessoas(d);
					break;
				case (int) ExNivelAcesso.NIVEL_ACESSO_ENTRE_LOTACOES:
					add(d.getLotaCadastrante());
					add(d.getSubscritor());
					add(d.getTitular());
					add(d.getLotaDestinatario());
					incluirLotacoes(d);
					break;
				case (int) ExNivelAcesso.NIVEL_ACESSO_PESSOAL:
					add(d.getCadastrante());
					add(d.getSubscritor());
					add(d.getTitular());
					add(d.getDestinatario());
					incluirPessoas(d);
					break;
				}
				cache.put(d, acessos);
			}

			// Combina os acessos de todos os documentos para gerar o resultado
			acessos = new HashSet<Object>();
			for (ExDocumento d : documentoESeusPais) {

				for (Object o : cache.get(d))
					add(o);
			}
		}
		return acessos;
	}

	/**
	 * Retorna uma lista com os subscritores de todos os despachos n�o
	 * cancelados do documento.
	 */
	private void addSubscritorDespacho(ExDocumento doc) {
		List<DpPessoa> subscritoresDesp = new ArrayList<DpPessoa>();

		for (ExMobil mob : doc.getExMobilSet()) {
			for (ExMovimentacao mov : mob.getExMovimentacaoSet()) {
				if ((mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO
						|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO
						|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA || mov
						.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA)
						&& !mov.isCancelada())
					add(mov.getSubscritor());
			}
		}
	}

	public String getAcessosString(ExDocumento doc, Date dt) {
		calcularAcessos(doc, dt);

		if (acessos.contains(ACESSO_PUBLICO)) {
			return ACESSO_PUBLICO;
		}
		
		acessos.remove(null);

		// Otimizar a lista removendo todas as pessoas e lota��es de um �rg�o,
		// quando este �rg�o todo pode acessar o documento
		Set<Object> toRemove = new HashSet<Object>();
		for (Object o : acessos) {
			if (o instanceof CpOrgaoUsuario) {
				CpOrgaoUsuario ou = (CpOrgaoUsuario)o;
				for (Object oo : acessos) {
					if (oo instanceof DpLotacao) {
						if (((DpLotacao) oo).getOrgaoUsuario().getId().equals(ou.getId()))
							toRemove.add(oo);
					} else if (oo instanceof DpPessoa) {
						if (((DpPessoa) oo).getOrgaoUsuario().getId().equals(ou.getId()))
							toRemove.add(oo);
					}
				}
			}
		}
		acessos.removeAll(toRemove);

		SortedSet<String> result = new TreeSet<String>();
		for (Object o : acessos) {
			if (o instanceof String)
				result.add((String) o);
			else if (o instanceof CpOrgaoUsuario)
				result.add("O" + ((CpOrgaoUsuario) o).getId());
			else if (o instanceof DpLotacao)
				result.add("L" + ((DpLotacao) o).getIdInicial());
			else if (o instanceof DpPessoa)
				result.add("P" + ((DpPessoa) o).getIdInicial());
		}

		StringBuilder sb = new StringBuilder();

		for (String each : result) {
			if (sb.length() > 0)
				sb.append(",");
			sb.append(each);
		}

		return sb.toString();
	}

}
