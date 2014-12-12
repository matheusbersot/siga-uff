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

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.SigaCalendar;
import br.gov.jfrj.siga.dp.CpFeriado;

public class DatasPublicacaoDJE {

	private Date dataDisponibilizacao;
	private Date dataPublicacao;
	private Date hojeMeiaNoite;
	private Long difHojeDisponib;
	private CpFeriado feriadoPublicacao;
	private CpFeriado feriadoDisponibilizacao;

	// Necess�rio para verifica��o do dia da semana
	private Calendar calPublicacao;

	// Necess�rio para verifica��o do dia da semana
	private Calendar calDisponibilizacao;

	// Necess�rio para verifica��o do hor�rio limite
	private Calendar calHoje;

	public DatasPublicacaoDJE(Date dataDisponib) throws AplicacaoException {
		if (dataDisponib == null)
			throw new AplicacaoException(
					"N�o foi informada uma data de disponibiliza��o para c�lculos");
		setDataDisponibilizacao(dataDisponib);
	}

	public String validarDataDeDisponibilizacao(boolean apenasSolicitacao)
			throws AplicacaoException {
		if (getDataDisponibilizacao() == null)
			throw new AplicacaoException(
					"N�o foi informada uma data de disponibiliza��o para c�lculos");

		if (isDisponibilizacaoDMais30())
			return "Data de disponibiliza��o est� al�m do limite: mais de 31 dias a partir de hoje";
		else if (isDisponibilizacaoAntesDeDMais2())
			return "Data de disponibiliza��o n�o permitida: menos de 2 dias a partir de hoje";
		else if (sao17Horas() && apenasSolicitacao)
			return "Data de disponibiliza��o n�o permitida: Excedido Hor�rio de Solicita��o (17 Horas). Defina a disponibiliza��o para um dia depois do escolhido";
		else if (isDisponibilizacaoDomingo())
			return "Data de disponibiliza��o � domingo";
		else if (isDisponibilizacaoSabado())
			return "Data de disponibiliza��o � s�bado";
		else if (isDisponibilizacaoFeriado())
			return "Data de disponibiliza��o � feriado: "
					+ getFeriadoDisponibilizacao().getDscFeriado();

		while (true) {
			if (isPublicacaoDomingo() || isPublicacaoSabado()
					|| isPublicacaoFeriado())
				setDataPublicacao(adicionaUmDia(getDataPublicacao()));
			else
				break;
		}

		return null;
	}

	private Date adicionaUmDia(Date data) {
		Calendar cal = new GregorianCalendar();
		cal.setTime(data);
		cal.add(Calendar.DAY_OF_MONTH, 1);

		return cal.getTime();
	}

	public boolean isDisponibilizacaoDMais30() {
		return getDifHojeDisponib() > 30;
	}

	public boolean isDisponibilizacaoAntesDeDMais2() {
		return getDifHojeDisponib() < 2;
	}

	public boolean isDisponibilizacaoDMais2() {
		return getDifHojeDisponib() == 2;
	}

	public boolean isDisponibilizacaoMaiorQueDMais1() {
		return getDifHojeDisponib() > 1;
	}

	public boolean isPublicacaoDomingo() {
		return (getCalPublicacao().get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY);
	}

	public boolean isPublicacaoSabado() {
		return (getCalPublicacao().get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY);
	}

	public boolean isPublicacaoFeriado() {
		return getFeriadoPublicacao() != null;
	}

	public boolean isDisponibilizacaoDomingo() {
		return (getCalDisponibilizacao().get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY);
	}

	public boolean isDisponibilizacaoSabado() {
		return (getCalDisponibilizacao().get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY);
	}

	public boolean isDisponibilizacaoFeriado() {
		return getFeriadoDisponibilizacao() != null;
	}

	public boolean sao17Horas() {
		int hora = getCalHoje().get(Calendar.HOUR_OF_DAY);
		return (hora >= 17 && getDifHojeDisponib() <= 2);
	}

	public Date getDataDisponibilizacao() {
		return dataDisponibilizacao;
	}

	public void setDataDisponibilizacao(Date dataDisponibilizacao) {
		this.dataDisponibilizacao = dataDisponibilizacao;
		setDataPublicacao(null);
		setCalDisponibilizacao(null);
		setFeriadoDisponibilizacao(null);
		setDifHojeDisponib(null);
	}

	private Date getHojeMeiaNoite() {
		if (hojeMeiaNoite == null) {
			Calendar calHojeMeiaNoite = new GregorianCalendar();
			calHojeMeiaNoite.setTime(new Date());
			calHojeMeiaNoite.set(Calendar.HOUR_OF_DAY, 0);
			calHojeMeiaNoite.set(Calendar.MINUTE, 0);
			calHojeMeiaNoite.set(Calendar.SECOND, 0);
			calHojeMeiaNoite.set(Calendar.MILLISECOND, 0);
			setHojeMeiaNoite(calHojeMeiaNoite.getTime());
		}
		return hojeMeiaNoite;
	}

	private long getDifHojeDisponib() {
		Long diasUteis, diasInuteis, diferencaEmMilisegundos;
		if (difHojeDisponib == null) {
			
			diferencaEmMilisegundos = getDataDisponibilizacao().getTime() - getHojeMeiaNoite().getTime();
			
			//In�cio de Hor�rio de Ver�o.
			if(diferencaEmMilisegundos == 342000000L)
				diferencaEmMilisegundos += 3600000L; 
			
			diasUteis = (diferencaEmMilisegundos) / 86400000;
			diasInuteis = getNumeroDiasInuteis(getHojeMeiaNoite(),
					getDataDisponibilizacao());

			setDifHojeDisponib(diasUteis - diasInuteis);
		}
		return difHojeDisponib;
	}

	public Date getDataPublicacao() {
		if (dataPublicacao == null) {
			Calendar cal = new GregorianCalendar();
			cal.setTime(getDataDisponibilizacao());
			cal.add(Calendar.DAY_OF_MONTH, 1);
			setDataPublicacao(cal.getTime());
		}
		return dataPublicacao;
	}

	private void setDataPublicacao(Date dataPublicacao) {
		this.dataPublicacao = dataPublicacao;
		setCalPublicacao(null);
		setFeriadoPublicacao(null);
	}

	private void setHojeMeiaNoite(Date hojeMeiaNoite) {
		this.hojeMeiaNoite = hojeMeiaNoite;
	}

	private void setDifHojeDisponib(Long difHojeDisponib) {
		this.difHojeDisponib = difHojeDisponib;
	}

	private Calendar getCalPublicacao() {
		if (calPublicacao == null) {
			GregorianCalendar provCal = new GregorianCalendar();
			provCal.setTime(getDataPublicacao());
			setCalPublicacao(provCal);
		}
		return calPublicacao;
	}

	private void setCalPublicacao(Calendar calPublicacao) {
		this.calPublicacao = calPublicacao;
	}

	public CpFeriado getFeriadoPublicacao() {
		if (feriadoPublicacao == null) {
			setFeriadoPublicacao(Feriados.verificarPorData(getDataPublicacao()));
		}
		return feriadoPublicacao;
	}

	private void setFeriadoPublicacao(CpFeriado feriadoPublicacao) {
		this.feriadoPublicacao = feriadoPublicacao;
	}

	public Calendar getCalHoje() {
		if (calHoje == null) {
			Calendar cal = new GregorianCalendar();
			cal.setTime(new Date());
			setCalHoje(cal);
		}
		return calHoje;
	}

	private void setCalHoje(Calendar calHoje) {
		this.calHoje = calHoje;
	}

	private Calendar getCalDisponibilizacao() {
		if (calDisponibilizacao == null) {
			GregorianCalendar provCal = new GregorianCalendar();
			provCal.setTime(getDataDisponibilizacao());
			// Elimina o risco de erro na contagem por causa do in�cio do
			// hor�rio de ver�o:
			provCal.add(Calendar.HOUR_OF_DAY, 3);
			setCalDisponibilizacao(provCal);
		}
		return calDisponibilizacao;
	}

	private void setCalDisponibilizacao(Calendar calDisponibilizacao) {
		this.calDisponibilizacao = calDisponibilizacao;
	}

	public CpFeriado getFeriadoDisponibilizacao() {
		if (feriadoDisponibilizacao == null) {
			setFeriadoDisponibilizacao(Feriados
					.verificarPorData(getDataDisponibilizacao()));
		}
		return feriadoDisponibilizacao;
	}

	public void setFeriadoDisponibilizacao(CpFeriado feriadoDisponibilizacao) {
		this.feriadoDisponibilizacao = feriadoDisponibilizacao;
	}

	private Long getNumeroDiasInuteis(Date pDataInicio, Date pDataFim) {
		SigaCalendar dataInicio = new SigaCalendar();
		SigaCalendar dataFim = new SigaCalendar();

		dataInicio.setTime(pDataInicio);
		dataFim.setTime(pDataFim);

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

		return Long.valueOf(diasInuteis);
	}

}
