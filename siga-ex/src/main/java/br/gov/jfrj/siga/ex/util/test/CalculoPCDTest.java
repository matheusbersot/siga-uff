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
package br.gov.jfrj.siga.ex.util.test;

import java.util.List;

import junit.framework.TestCase;

import org.hibernate.cfg.AnnotationConfiguration;

import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.cp.bl.CpAmbienteEnumBL;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.dp.dao.DpPessoaDaoFiltro;
import br.gov.jfrj.siga.ex.util.CalculoPCD;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.model.dao.HibernateUtil;

/**
 * Testa as funcionalidades de c�lculo da ExCalculoPCD.
 * 
 * Os testes s�o baseados em planilhas fornecidas pela SOF e sues nomes est�o no
 * formato testDadosExcelPlanilhaXLinhaXX. A planiha 1 cont�m os dados originais
 * e foi enviada, por e-mail, em 20 de outubro de 2009 16:23. A planiha 2 foi
 * enviada, por e-mail, em 1 de fevereiro de 2010 16:58.
 * 
 * Ao incluir uma nova planilha, os testes das planilhas anteriores devem ser
 * ajustados.
 * 
 * @author kpf
 * 
 */
public class CalculoPCDTest extends TestCase {

	private CalculoPCD c;

	/**
	 * Inicia os par�metros de teste.
	 * 
	 * @throws Exception
	 */
	public CalculoPCDTest() throws Exception {
		CpAmbienteEnumBL ambiente = CpAmbienteEnumBL.DESENVOLVIMENTO;
		Cp.getInstance().getProp().setPrefixo(ambiente.getSigla());
		AnnotationConfiguration cfg = ExDao.criarHibernateCfg(ambiente);
		HibernateUtil.configurarHibernate(cfg, "");
	}

	public void testDadosExcelPlanilha1Linha20() {

		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setNome("TESTE");

		List<DpPessoa> listaPessoa = CpDao.getInstance()
				.consultarPorFiltro(flt);

		DpPessoa b = listaPessoa.get(0);

		this.c = new CalculoPCD();
		this.c.setBeneficiario(b);
		this.c.setDataInicio("27/09/2009");
		this.c.setDataFim("02/10/2009");
		this.c.setCargo("T�CNICO JUDICI�RIO");
		this.c.setFuncao("SEM FUN��O");

		c.setCarroOficial(false);
		c.setSolicitaAuxTransporte(true);
		c.setDescontoSalario(0F);
		c.setValorConcedido(0F);

		assertEquals(c.getNumeroDiasInuteis(), 1);
		assertEquals(c.getNumeroDiarias(), 5.5F);
		assertEquals(c.getValorDiaria(), 186F);
		assertEquals(c.getCalculoDiarias(), 1023F);
		assertEquals(c.getValorDeslocamento(), 53F);
		assertEquals(c.getNumeroDeslocamentos(), 2);
		assertEquals(c.getCalculoDeslocamento(), 106F);
		assertEquals(c.getValorAuxilioAlimentacaoDiario(), 28F);
		assertEquals(c.getNumeroDiariasDesconto(), 5F);
		assertEquals(c.getCalculoDescontoAlimentacao(), 140F);
		assertEquals(c.getCalculoDescontoTransporte(), 0F);
		assertEquals(c.getCalculoTotalDescontos(), 140F);
		assertEquals(c.getCalculoValorBruto(), 1129F);
		assertEquals(c.getCalculoValorLiquido(), 989F);
	}

	public void testDadosExcelPlanilha1Linha26() {

		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setNome("TESTE2");

		List<DpPessoa> listaPessoa = CpDao.getInstance()
				.consultarPorFiltro(flt);

		DpPessoa b = listaPessoa.get(0);

		this.c = new CalculoPCD();
		this.c.setBeneficiario(b);
		this.c.setDataInicio("30/08/2009");
		this.c.setDataFim("04/09/2009");
		this.c.setCargo("T�CNICO JUDICI�RIO");
		this.c.setFuncao("SEM FUN��O");

		c.setCarroOficial(false);
		c.setSolicitaAuxTransporte(true);
		c.setDescontoSalario(0F);
		c.setValorConcedido(0F);

		assertEquals(c.getNumeroDiasInuteis(), 1);
		assertEquals(c.getNumeroDiarias(), 5.5F);
		assertEquals(c.getValorDiaria(), 186F);
		assertEquals(c.getCalculoDiarias(), 1023F);
		assertEquals(c.getValorDeslocamento(), 53F);
		assertEquals(c.getNumeroDeslocamentos(), 2);
		assertEquals(c.getCalculoDeslocamento(), 106F);
		assertEquals(c.getValorAuxilioAlimentacaoDiario(), 28F);
		assertEquals(c.getNumeroDiariasDesconto(), 5F);
		assertEquals(c.getCalculoDescontoAlimentacao(), 140F);
		assertEquals(c.getCalculoDescontoTransporte(), 0F);
		assertEquals(c.getCalculoTotalDescontos(), 140F);
		assertEquals(c.getCalculoValorBruto(), 1129F);
		assertEquals(c.getCalculoValorLiquido(), 989F);
	}

	public void testDadosExcelPlanilha1Linha31() {

		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setNome("TESTE3");

		List<DpPessoa> listaPessoa = CpDao.getInstance()
				.consultarPorFiltro(flt);

		DpPessoa b = listaPessoa.get(0);

		this.c = new CalculoPCD();
		this.c.setBeneficiario(b);
		this.c.setDataInicio("15/09/2009");
		this.c.setDataFim("18/09/2009");
		this.c.setCargo("JUIZ FEDERAL TITULAR");
		this.c.setFuncao("SEM FUN��O");

		c.setCarroOficial(true);
		c.setSolicitaAuxTransporte(true);
		c.setDescontoSalario(0F);
		c.setValorConcedido(0F);

		assertEquals(c.getNumeroDiasInuteis(), 0);
		assertEquals(c.getNumeroDiarias(), 3.5F);
		assertEquals(c.getValorDiaria(), 554F);
		assertEquals(c.getCalculoDiarias(), 1939F);
		assertEquals(c.getValorDeslocamento(), 53F);
		assertEquals(c.getNumeroDeslocamentos(), 1);
		assertEquals(c.getCalculoDeslocamento(), 53F);
		assertEquals(c.getValorAuxilioAlimentacaoDiario(), 28F);
		assertEquals(c.getNumeroDiariasDesconto(), 0F);
		assertEquals(c.getCalculoDescontoAlimentacao(), 0F);
		assertEquals(c.getCalculoDescontoTransporte(), 0F);
		assertEquals(c.getCalculoTotalDescontos(), 0F);
		assertEquals(c.getCalculoValorBruto(), 1992F);
		assertEquals(c.getCalculoValorLiquido(), 1992F);
	}

	public void testDadosExcelPlanilha1Linha64() {
		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setNome("TESTE4");

		List<DpPessoa> listaPessoa = CpDao.getInstance()
				.consultarPorFiltro(flt);

		DpPessoa b = listaPessoa.get(0);

		this.c = new CalculoPCD();
		this.c.setBeneficiario(b);
		this.c.setDataInicio("13/09/2009");
		this.c.setDataFim("15/09/2009");
		this.c.setCargo("ANALISTA JUDICI�RIO");
		this.c.setFuncao("ASSISTENTE IV");
		this.c.setCarroOficial(false);
		this.c.setSolicitaAuxTransporte(true);
		this.c.setDescontoSalario(19.60F);
		this.c.setValorConcedido(286.36F);

		assertEquals(c.getNumeroDiasInuteis(), 1);
		assertEquals(c.getNumeroDiarias(), 2.5F);
		assertEquals(c.getValorDiaria(), 214F);
		assertEquals(c.getCalculoDiarias(), 535F);
		assertEquals(c.getValorDeslocamento(), 53F);
		assertEquals(c.getNumeroDeslocamentos(), 2);
		assertEquals(c.getCalculoDeslocamento(), 106F);
		assertEquals(c.getValorAuxilioAlimentacaoDiario(), 28F);
		assertEquals(c.getNumeroDiariasDesconto(), 2F);
		assertEquals(c.getCalculoDescontoAlimentacao(), 56F);
		assertEquals(c.getCalculoDescontoTransporte(), 13F);
		assertEquals(c.getCalculoTotalDescontos(), 69F);
		assertEquals(c.getCalculoValorBruto(), 641F);
		assertEquals(c.getCalculoValorLiquido(), 572F);
	}

	public void testDadosExcelPlanilha1Linha79() {
		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setNome("TESTE5");

		List<DpPessoa> listaPessoa = CpDao.getInstance()
				.consultarPorFiltro(flt);

		DpPessoa b = listaPessoa.get(0);

		this.c = new CalculoPCD();
		this.c.setBeneficiario(b);
		this.c.setDataInicio("29/09/2009");
		this.c.setDataFim("02/10/2009");
		this.c.setCargo("ANALISTA JUDICI�RIO");
		this.c.setFuncao("SEM FUN��O");

		this.c.setExecutorMandado(true);

		assertEquals(c.getNumeroDiasInuteis(), 0);
		assertEquals(c.getNumeroDiarias(), 3.5F);
		assertEquals(c.getValorDiaria(), 214F);
		assertEquals(c.getCalculoDiarias(), 749F);
		assertEquals(c.getValorDeslocamento(), 53F);
		assertEquals(c.getNumeroDeslocamentos(), 0);
		assertEquals(c.getCalculoDeslocamento(), 0F);
		assertEquals(c.getValorAuxilioAlimentacaoDiario(), 0F);
		assertEquals(c.getNumeroDiariasDesconto(), 4F);
		assertEquals(c.getCalculoDescontoAlimentacao(), 0F);
		assertEquals(c.getCalculoDescontoTransporte(), 0F);
		assertEquals(c.getCalculoTotalDescontos(), 0F);
		assertEquals(c.getCalculoValorBruto(), 749F);
		assertEquals(c.getCalculoValorLiquido(), 749F);

	}

	public void testDadosExcelPlanilha2Linha6() {
		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setNome("TESTE6");

		List<DpPessoa> listaPessoa = CpDao.getInstance()
				.consultarPorFiltro(flt);

		DpPessoa b = listaPessoa.get(0);

		this.c = new CalculoPCD();
		this.c.setBeneficiario(b);
		this.c.setDataInicio("27/01/2010");
		this.c.setDataFim("28/01/2010");
		this.c.setCargo("ANALISTA JUDICI�RIO");
		this.c.setFuncao("SEM FUN��O");
		this.c.setCarroOficial(false);
		this.c.setSolicitaAuxTransporte(true);

		this.c.setDescontoSalario(34.92F);
		this.c.setValorConcedido(235.49F);

		assertEquals(c.getNumeroDiasInuteis(), 0);
		assertEquals(c.getNumeroDiarias(), 1.5F);
		assertEquals(c.getValorDiaria(), 214F);
		assertEquals(c.getCalculoDiarias(), 321F);
		assertEquals(c.getValorDeslocamento(), 53F);
		assertEquals(c.getNumeroDeslocamentos(), 2);
		assertEquals(c.getCalculoDeslocamento(), 106F);
		assertEquals(c.getValorAuxilioAlimentacaoDiario(), 28F);
		assertEquals(c.getNumeroDiariasDesconto(), 2F);
		assertEquals(c.getCalculoDescontoAlimentacao(), 56F);
		assertEquals(c.getCalculoDescontoTransporte(), 48F);
		assertEquals(c.getCalculoTotalDescontos(), 104F);
		assertEquals(c.getCalculoValorBruto(), 427F);
		assertEquals(c.getCalculoValorLiquido(), 323F);

	}

}
