package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import play.db.jpa.GenericModel;

@Entity
@Table(name = "GC_ACESSO", schema = "SIGAGC")
public class GcAcesso extends GenericModel {
	public static final long ACESSO_PUBLICO = 1;
	public static final long ACESSO_ORGAO_USU = 2;
	public static final long ACESSO_LOTACAO_E_SUPERIORES = 3;
	public static final long ACESSO_LOTACAO_E_INFERIORES = 4;
	public static final long ACESSO_LOTACAO = 5;
	public static final long ACESSO_PESSOAL = 6;

	@Id
	@Column(name = "ID_ACESSO")
	public long id;

	@Column(name = "NOME_ACESSO", nullable = false)
	public String nome;

	public GcAcesso() {
		super();
	}

	public GcAcesso(long id, String nome) {
		super();
		this.id = id;
		this.nome = nome;
	}
}
