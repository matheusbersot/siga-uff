package br.gov.jfrj.siga.ex;

import java.util.ArrayList;
import java.util.List;

public class ExTopicoDestinacao {

	public ExTopicoDestinacao(String titulo, boolean selecionavel) {
		this.titulo = titulo;
		this.selecionavel = selecionavel;
		itens = new ArrayList<ExItemDestinacao>();
	}

	private String titulo;

	private List<ExItemDestinacao> itens;

	private boolean selecionavel;

	public String getTitulo() {
		return titulo;
	}

	public void adicionar(ExItemDestinacao item) {
		itens.add(item);
	}

	// Edson: isto n�o � o ideal. Quem der um getItens() ser� capaz de manipular
	// diretamente a lista, que � private
	public List<ExItemDestinacao> getItens() {
		return itens;
	}

	public boolean isSelecionavel() {
		return selecionavel;
	}

}