package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.model.Objeto;
import br.gov.jfrj.siga.sinc.lib.NaoRecursivo;

@Entity
@Table(name = "SR_FATOR_MULTIPLICACAO")
public class SrFatorMultiplicacao extends Objeto{
	
	@Id
	@SequenceGenerator(sequenceName = "SIGASR.SR_FATOR_MULTIPLICACAO_SEQ", name = "srFatorMultiplicacao")
	@GeneratedValue(generator = "srFatorMultiplicacao")
	@Column(name = "ID_FATOR_MULTIPLICACAO")
	public Long idFatorMultiplicacao;
	
	@Column(name = "NUM_FATOR_MULTIPLICACAO")
	public int numFatorMultiplicacao = 1;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_PESSOA")
	@NaoRecursivo
	private DpPessoa dpPessoa;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_LOTACAO")
	@NaoRecursivo
	private DpLotacao dpLotacao;

	@ManyToOne()
	@JoinColumn(name = "ID_ITEM_CONFIGURACAO")
	public SrItemConfiguracao itemConfiguracao;
	
	public DpPessoa getDpPessoa() {
		return dpPessoa;
	}
	
	public void setDpPessoa(DpPessoa dpPessoa) {
		this.dpPessoa = dpPessoa;
	}
	
	public DpLotacao getDpLotacao() {
		return dpLotacao;
	}
	
	public void setDpLotacao(DpLotacao dpLotacao) {
		this.dpLotacao = dpLotacao;
	}

}
