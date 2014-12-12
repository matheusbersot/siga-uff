package br.gov.jfrj.siga.cp.bl;

/**
 * Combina��o de situa��es funcionais utilizados na pesquina CpDao.pessoasPorLotacao()
 * @author kpf
 *
 */
public enum SituacaoFuncionalEnum {
	APENAS_ATIVOS(new String[]{"1"}), 
	ATIVOS_E_CEDIDOS(new String[]{"1","2"}); 
	
	String[] situacao;
	
	private SituacaoFuncionalEnum(String[] situacao) {
		this.situacao = situacao;
	}
	
	public String[] getValor() {
		return situacao;
	}
}
