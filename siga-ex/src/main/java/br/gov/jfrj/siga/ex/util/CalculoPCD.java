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
package br.gov.jfrj.siga.ex.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import br.gov.jfrj.siga.base.SigaCalendar;
import br.gov.jfrj.siga.dp.DpPessoa;

/**
 * Classe que efetua o c�lculo dos valores a serem pagos no pedido de concess�o
 * de di�rias.
 * 
 * @author kpf
 * 
 */
public class CalculoPCD {

	public static final int PERNOITE_ANTERIOR = 1;
	public static final int PERNOITE_POSTERIOR = 2;
	private SigaCalendar dataInicio;
	private SigaCalendar dataFim;
	private DpPessoa beneficiario;
	private int pernoite;
	private String cargo;
	private String funcao;
	private HashMap<String, Float> tabelaValores;

	private float descontoSalario = 0F; // informa��o do WEmul
	private float valorConcedido = 0F;// informa��o do WEmul

	/**
	 * Em valores de hoje o auxilio alimenta��o � de R$630,00
	 */
	private static final float AUXILIO_ALIMENTACAO = 630F;
	/**
	 * Se o benefici�rio utilizar carro oficial durante o per�odo de
	 * afastamento, este atributo � true. Este valor influencia no c�lculo da
	 * concess�o do adicional de deslocamento.
	 */
	private boolean carroOficial;

	/**
	 * Se o benefici�rio solicitar aux�lio transporte durante o per�odo de
	 * afastamento, este atributo � true. Este valor influencia no c�lculo da
	 * concess�o do adicional de deslocamento.
	 */
	private boolean solicitaAuxTransporte;

	/**
	 * TRUE Se o benefici�rio for EXECUTOR DE MANDADOS.
	 */
	private boolean executorMandado;

	public CalculoPCD() {
		inicializarTabelaValores();
	}

	/**
	 * Inicia e determina a tabela de valores da di�ria de acordo com o cargo ou
	 * fun��o.
	 */
	private void inicializarTabelaValores() {
		tabelaValores = new HashMap<String, Float>();

		tabelaValores.put("JUIZ FEDERAL TITULAR", 554F);
		tabelaValores.put("JUIZ FEDERAL SUBSTITUTO", 526F);
		tabelaValores.put("ASSISTENTE I", 214F);
		tabelaValores.put("ASSISTENTE II", 214F);
		tabelaValores.put("ASSISTENTE III", 214F);
		tabelaValores.put("ASSISTENTE IV", 214F);
		tabelaValores.put("SUPERVISOR", 214F);
		tabelaValores.put("COORDENADOR", 264F);
		tabelaValores.put("DIRETOR DE SUBSECRETARIA", 314F);
		tabelaValores.put("DIRETOR DE SECRETARIA", 342F);
		tabelaValores.put("ANALISTA JUDICI�RIO", 214F);
		tabelaValores.put("T�CNICO JUDICI�RIO", 186F);
		tabelaValores.put("CJ01", 264F);
		tabelaValores.put("CJ04", 368F);

	}

	/**
	 * Feriado/S�bado/Domingo s�o exclu�dos do desconto de alimenta��o e
	 * transporte;
	 * 
	 * @return
	 */
	public int getNumeroDiasInuteis() {
		int diasInuteis = 0;
		Calendar ini = new SigaCalendar(dataInicio.getTimeInMillis());
		while (ini.compareTo(dataFim) <= 0) {
			if (Feriados.verificarPorData(ini.getTime()) != null
					|| ini.get(SigaCalendar.DAY_OF_WEEK) == SigaCalendar.SATURDAY
					|| ini.get(SigaCalendar.DAY_OF_WEEK) == SigaCalendar.SUNDAY) {
				diasInuteis++;
				// System.out.println(inicio.getTime());
			}
			ini.add(SigaCalendar.DAY_OF_MONTH, 1);
		}

		return diasInuteis;
	}

	/**
	 * O n�mero de di�rias � calculado pelo per�odo entre as datas inicial e
	 * final, inclusive a ida e metade do dia da volta ex: 02/10/2009 at�
	 * 03/10/2009 = 1,5 di�rias (uma do dia 02 e 0,5 do dia 03);
	 * 
	 * @return
	 */
	public float getNumeroDiarias() {
		// AA (C�LCULO DO N� DE DI�RIAS)
		//
		// dias = dataFinal - dataInicial + 0,5
		// pernoiteOuDia30 = 0
		// SE (Q7=30)
		// entao pernoiteOuDia30 = 1
		// SEN�O
		// SE (Y7="x" ou Z7="x")
		// entao pernoiteOuDia30=1
		//
		// retorna dias + pernoiteOuDia30

		float numDiarias = (dataInicio.dias360(dataFim)) + .5F;
		int pernoiteOuDia30 = 0;
		if (dataInicio.get(SigaCalendar.DAY_OF_MONTH) == 30
				|| pernoite == PERNOITE_ANTERIOR
				|| pernoite == PERNOITE_POSTERIOR
				|| pernoite == (PERNOITE_ANTERIOR + PERNOITE_POSTERIOR)) {
			pernoiteOuDia30 = 1;
		}
		return numDiarias + pernoiteOuDia30;
	}

	/**
	 * O valor da di�ria � baseado no cargo/fun��o do benefici�rio.
	 * 
	 * @param
	 * @return
	 */
	public float getValorDiaria() {

		if (cargo != null) {
			if (cargo.equals("JUIZ FEDERAL TITULAR")
					|| cargo.equals("JUIZ FEDERAL SUBSTITUTO")) {
				return tabelaValores.get(cargo);
			}
		}

		if (funcao != null) {
			if (funcao.equals("ASSISTENTE I") || funcao.equals("ASSISTENTE II")
					|| funcao.equals("ASSISTENTE III")
					|| funcao.equals("ASSISTENTE IV")
					|| funcao.equals("SUPERVISOR")
					|| funcao.equals("COORDENADOR") || funcao.equals("CJ01")
					|| funcao.equals("CJ04")
					|| funcao.equals("DIRETOR DE SUBSECRETARIA")
					|| funcao.equals("DIRETOR DE SECRETARIA")) {
				return tabelaValores.get(funcao);
			}
		}

		if (cargo != null) {
			if (cargo.equals("ANALISTA JUDICI�RIO")
					|| cargo.equals("T�CNICO JUDICI�RIO")) {
				return tabelaValores.get(cargo);
			}
		}
		return 0F; // retorna null para dar erro no c�lculo caso n�o tenha

	}

	/**
	 * N� de di�rias * valor da di�ria + ajuste di�ria (arrendondado para baixo)
	 * 
	 * @return
	 */
	public float getCalculoDiarias() {
		return (float) Math.floor((getNumeroDiarias() * getValorDiaria()));
	}

	/**
	 * Seja qual for o cargo ocupado pelo servidor ou mesmo o magistrado, o
	 * adicional de deslocamento corresponde a 25% da di�ria de um analista.
	 * 
	 * @return
	 */
	public float getValorDeslocamento() {
		return (float) Math.floor((tabelaValores.get("ANALISTA JUDICI�RIO") * 0.25));
	}

	/**
	 * O n�mero de deslocamentos depende se o benefici�rio utilizar� carro
	 * oficial e/ou solicitou o aux�lio transporte para po per�odo de
	 * afastamento. A tabela � a seguinte:
	 * 
	 * carroOficial(false) e solicitaAuxTransporte (true) = 2 carroOficial(true)
	 * e solicitaAuxTransporte (false) = 0 carroOficial(true) e
	 * solicitaAuxTransporte (true) = 1 carroOficial(false) e
	 * solicitaAuxTransporte (false) = 0
	 * 
	 * @return
	 */
	public int getNumeroDeslocamentos() {
		if (!carroOficial && solicitaAuxTransporte) {
			return 2;
		}

		if ((carroOficial && !solicitaAuxTransporte)
				|| (!carroOficial && !solicitaAuxTransporte)) {
			return 0;
		}

		if (carroOficial && solicitaAuxTransporte) {
			return 1;
		}

		return 0;

	}

	/**
	 * valor do deslocamento * n� de deslocamentos
	 * 
	 * @return
	 */
	public float getCalculoDeslocamento() {
		return getValorDeslocamento() * getNumeroDeslocamentos();
	}

	/**
	 * Retorna o valor di�rio do aux�lio alimenta��o.
	 * 
	 * @return
	 */
	public float getValorAuxilioAlimentacaoDiario() {

		if (this.executorMandado) {
			return 0F;
		}

		return (float) Math.floor(AUXILIO_ALIMENTACAO/22);
	}

	/**
	 * O auxilio alimenta��o di�rio sempre � descontado em valor inteiro.
	 * Exemplo: 02/10/2009 at� 03/10/2009 = 1,5 di�rias (uma do dia 02 e 0,5 do
	 * dia 03). Embora seja condida 1,5 di�rias o desconto de alimenta��o ser�
	 * de 2 um referente ao dia 02 e um referente ao dia 03. Os magistrados
	 * recebem subs�dio �nico, desta forma n�o recebem e n�o descontam auxilo
	 * alimenta��o e transporte.
	 * 
	 * C�lculo: Se for juiz federal (titular ou sibstituto) = 0 Sen�o d1 =
	 * dataInicial - dataFinal + 1 se (dia(dataInicial)=30) d1 + 1; retorna d1 -
	 * DiasInuteis;
	 * 
	 * 
	 * @return
	 */
	public float getNumeroDiariasDesconto() {
		if (cargo.equals("JUIZ FEDERAL TITULAR")
				|| cargo.equals("JUIZ FEDERAL SUBSTITUTO")) {
			return 0F;
		}

		float diariasDesconto = dataInicio.dias360(dataFim) + 1;
		if (dataInicio.get(SigaCalendar.DAY_OF_MONTH) == 30) {
			diariasDesconto += 1;
		}
		return (diariasDesconto - getNumeroDiasInuteis());
	}

	/**
	 * Retorna o total do desconto referente ao aux�lio alimenta��o.
	 * 
	 * @return
	 */
	public float getCalculoDescontoAlimentacao() {
		return getValorAuxilioAlimentacaoDiario() * getNumeroDiariasDesconto();
	}

	/**
	 * Retorna o total do desconto referente ao aux�lio transporte.
	 * 
	 * @return
	 */
	public float getCalculoDescontoTransporte() {
		return (float) Math.floor(getValorAuxilioTransporteDiario()
				* getNumeroDiariasDesconto());
	}

	/**
	 * Para o desconto de transporte � necess�rio ter acesso via wemul ao
	 * sistema de vale transporte (se��o de benef�cios na SGP) � efetuado
	 * tomando por base o valor di�rio total R$ 34,8 menos a divis�o do valor
	 * dos 6% V.BAs. ex (tabela em anexo): R$ 311,76/30 (um m�s) = R$ 10,39 que
	 * � igual a R$ R$ 24,41 x o valor inteiro do delocamento (vide item 7) que
	 * � 2 totalizando R$ 48,00 (desprezndo-se os centavos, arrendondado para
	 * baixo).
	 * 
	 * VD = valor concedido / 30; difDSVD = DS - VD; difDSVD *
	 * getNumeroDiariasDesconto()
	 * 
	 * @return
	 */
	public float getValorAuxilioTransporteDiario() {
		if (descontoSalario > 0 && valorConcedido > 0) {
			float vd = valorConcedido / 22;
			float difDSVD = descontoSalario - vd;
			return difDSVD;
		}

		return 0F;

	}

	/**
	 * Retorna o total de todos os descontos. getCalculoDescontoAlimentacao() +
	 * getCalculoDescontoTransporte()
	 * 
	 * @return
	 */
	public float getCalculoTotalDescontos() {
		return getCalculoDescontoAlimentacao() + getCalculoDescontoTransporte();
	}

	/**
	 * getCalculoDiarias() + getCalculoDeslocamento() + ajusteTotalPCD
	 * 
	 * @return
	 */
	public float getCalculoValorBruto() {
		return getCalculoDiarias() + getCalculoDeslocamento();
	}

	/**
	 * getCalculoValorBruto() - getCalculoTotalDescontos();
	 * 
	 * @return
	 */
	public float getCalculoValorLiquido() {
		return getCalculoValorBruto() - getCalculoTotalDescontos();
	}

	/**
	 * Retorna a data de in�cio do c�lculo
	 * 
	 * @return
	 */
	public String getDataInicio() {
		return new SimpleDateFormat("dd/mm/yyyy").getDateInstance().format(
				dataInicio.getTime());
	}

	/**
	 * Retorna a data final do c�lculo
	 * 
	 * @return
	 */
	public String getDataFim() {
		return new SimpleDateFormat("dd/mm/yyyy").getDateInstance().format(
				dataFim.getTime());
	}

	/**
	 * Retorna se o c�lculo considera o uso de carro oficial.
	 * 
	 * @return
	 */
	public boolean isCarroOficial() {
		return carroOficial;
	}

	/**
	 * Informa se o c�lculo considera o uso de carro oficial.
	 * 
	 * @param carroOficial -
	 *            TRUE se o c�lculo deve considerar o uso de carro oficial
	 */
	public void setCarroOficial(boolean carroOficial) {
		this.carroOficial = carroOficial;
	}

	/**
	 * Retorna se o c�lculo considera a solicita��o de aux�lio transporte.
	 * 
	 * @return
	 */
	public boolean isSolicitaAuxTransporte() {
		return solicitaAuxTransporte;
	}

	/**
	 * Informa se o c�lculo considera a solicita��o de aux�lio transporte.
	 * 
	 * @param solicitaAuxTransporte -
	 *            TRUE se considera a solicita��o de aux�lio transporte.
	 */
	public void setSolicitaAuxTransporte(boolean solicitaAuxTransporte) {
		this.solicitaAuxTransporte = solicitaAuxTransporte;
	}

	/**
	 * Retorna o benefici�rio do c�lculo.
	 * 
	 * @return
	 */
	public DpPessoa getBeneficiario() {
		return beneficiario;
	}

	/**
	 * Configura o benefici�rio do c�lculo.
	 * 
	 * @param beneficiario
	 */
	public void setBeneficiario(DpPessoa beneficiario) {
		this.beneficiario = beneficiario;
	}

	/**
	 * Retorna se o c�lculo considera pernoite.
	 * 
	 * @return 1 - pernoite no dia anterior 2 - pernoite no dia posterior
	 */
	public int getPernoite() {
		return pernoite;
	}

	/**
	 * Informa se o c�lculo considera pernoite
	 * 
	 * @param pernoite
	 */
	public void setPernoite(int pernoite) {
		this.pernoite = pernoite;
	}

	/**
	 * Retorna o valor que � descontado do sal�rio do benefici�rio devido ao
	 * pagamento do aux�lio transporte. A SOF realiza a consulta desse valor no
	 * WEmul.
	 * 
	 * @return
	 */
	public float getDescontoSalario() {
		return descontoSalario;
	}

	/**
	 * Informa o valor que � descontado do sal�rio do benefici�rio devido ao
	 * pagamento do aux�lio transporte. A SOF realiza a consulta desse valor no
	 * WEmul.
	 * 
	 * @param ds
	 */
	public void setDescontoSalario(float ds) {
		this.descontoSalario = ds;
	}

	/**
	 * Retorna o valor que � concedido ao benefici�rio pelo aux�lio transporte.
	 * A SOF realiza a consulta desse valor no WEmul.
	 * 
	 * @return
	 */
	public float getValorConcedido() {
		return valorConcedido;
	}

	/**
	 * Informa o valor que � concedido ao benefici�rio pelo aux�lio transporte.
	 * A SOF realiza a consulta desse valor no WEmul.
	 * 
	 * @param valorConcedido
	 */
	public void setValorConcedido(float valorConcedido) {
		this.valorConcedido = valorConcedido;
	}

	/**
	 * Informa a data de in�cio do c�lculo.
	 * 
	 * @param data
	 */
	public void setDataInicio(String data) {
		if (data != null && data.length() > 0) {
			Integer dia = new Integer(data.substring(0, 2));
			Integer mes = new Integer(data.substring(3, 5));
			Integer ano = new Integer(data.substring(6));
			this.dataInicio = new SigaCalendar(ano, mes - 1, dia);
		}
	}

	/**
	 * Informa a data final do c�lculo.
	 * 
	 * @param data
	 */
	public void setDataFim(String data) {
		if (data != null && data.length() > 0) {
			Integer dia = new Integer(data.substring(0, 2));
			Integer mes = new Integer(data.substring(3, 5));
			Integer ano = new Integer(data.substring(6));
			this.dataFim = new SigaCalendar(ano, mes - 1, dia);
		}
	}

	/**
	 * Retorna se o benefic�rio � executor de mandados. Os oficiais de justi�a
	 * posuem c�culo diferenciado do adicional de deslocamento.
	 * 
	 * @return
	 */
	public boolean isExecutorMandado() {
		return executorMandado;
	}

	/**
	 * Informa se o benefic�rio � executor de mandados. Os oficiais de justi�a
	 * posuem c�culo diferenciado do adicional de deslocamento.
	 * 
	 * @param executorMandado
	 */
	public void setExecutorMandado(boolean executorMandado) {
		this.executorMandado = executorMandado;
	}

	/**
	 * Retorna o cargo a ser considerado para o c�lculo. As di�rias possuem
	 * diferentes valores dependendo do cargo do benefici�rio.
	 * 
	 * @return
	 */
	public String getCargo() {
		return cargo;
	}

	/**
	 * Informa o cargo a ser considerado para o c�lculo. As di�rias possuem
	 * diferentes valores dependendo do cargo do benefici�rio.
	 * 
	 * @param cargo
	 */
	public void setCargo(String cargo) {
		this.cargo = cargo.trim();
	}

	/**
	 * Retorna a fun��o comissionada a ser considerada para o c�lculo. As
	 * di�rias possuem diferentes valores dependendo da fun��o.
	 * 
	 * @return
	 */
	public String getFuncao() {
		return funcao;
	}

	/**
	 * Informa a fun��o comissionada a ser considerada para o c�lculo. As
	 * di�rias possuem diferentes valores dependendo da fun��o.
	 * 
	 * @param funcao
	 */
	public void setFuncao(String funcao) {
		this.funcao = funcao.trim();
	}

}
