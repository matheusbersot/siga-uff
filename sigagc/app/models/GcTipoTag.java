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
@Table(name = "GC_TIPO_TAG", schema = "SIGAGC")
public class GcTipoTag extends GenericModel {
	public static final long TIPO_TAG_CLASSIFICACAO = 1;
	public static final long TIPO_TAG_HASHTAG = 2;
	public static final long TIPO_TAG_ANCORA = 3;

	@Id
	@Column(name = "ID_TIPO_TAG")
	public long id;

	@Column(name = "NOME_TIPO_TAG", nullable = false)
	public String nome;

	public GcTipoTag() {
		super();
	}

	public GcTipoTag(long id, String nome) {
		super();
		this.id = id;
		this.nome = nome;
	}
}
