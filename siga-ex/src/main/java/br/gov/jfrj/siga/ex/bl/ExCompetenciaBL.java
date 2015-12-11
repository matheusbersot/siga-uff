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
package br.gov.jfrj.siga.ex.bl;

import java.lang.reflect.Method;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;

import org.hibernate.LockMode;

import sun.security.action.GetLongAction;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.bl.CpCompetenciaBL;
import br.gov.jfrj.siga.dp.CpMarca;
import br.gov.jfrj.siga.dp.CpMarcador;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.DpResponsavel;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExClassificacao;
import br.gov.jfrj.siga.ex.ExConfiguracao;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExFormaDocumento;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExModelo;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExNivelAcesso;
import br.gov.jfrj.siga.ex.ExPapel;
import br.gov.jfrj.siga.ex.ExTipoDocumento;
import br.gov.jfrj.siga.ex.ExTipoFormaDoc;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;
import br.gov.jfrj.siga.ex.ExVia;
import br.gov.jfrj.siga.hibernate.ExDao;

public class ExCompetenciaBL extends CpCompetenciaBL {

	public ExConfiguracaoBL getConf() {
		return (ExConfiguracaoBL) super.getConfiguracaoBL();
	}

	/**
	 * Retorna se � poss�vel acessar o documento ao qual pertence o m�bil
	 * passado por par�metro. Considera se o documento ainda n�o foi assinado
	 * (sendo ent�o considerado aberto; estando j� assinado, retorna verdadeiro)
	 * e se <i>uma das</i> seguintes condi��es � satisfeita:
	 * <ul>
	 * <li>Usu�rio � da lota��o cadastrante do documento</li>
	 * <li>Usu�rio � subscritor do documento</li>
	 * <li>Usu�rio � titular do documento</li>
	 * <li><i>podeMovimentar()</i> � verdadeiro para o usu�rio / m�bil</li>
	 * <li>Usu�rio � um dos cossignat�rios do documento</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAcessarAberto(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (mob == null)
			return false;
		if (!mob.doc().isAssinado()
				&& !mob.doc().getLotaCadastrante().equivale(lotaTitular)				
				&& !titular.equivale(mob.doc().getTitular())
				&& !podeMovimentar(titular, lotaTitular, mob)) {			
			return false;
		}
		return true;
	}

	/**
	 * * Retorna se � poss�vel acessar um documento ao qual pertence o m�bil
	 * passado por par�metro. Considera se o documento est� cancelado (n�o
	 * estando cancelado, retorna verdadeiro) e se <i>uma das</i> seguintes
	 * condi��es � satisfeita:
	 * <ul>
	 * <li>Usu�rio � da lota��o cadastrante do documento</li>
	 * <li>Usu�rio � subscritor do documento</li>
	 * <li>Usu�rio � titular do documento</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarCancelado(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		if (mob == null)
			return false;
		if (mob.doc().isCancelado()
				&& !mob.doc().getLotaCadastrante().equivale(lotaTitular)
				&& !titular.equivale(mob.doc().getSubscritor())
				&& !titular.equivale(mob.doc().getTitular()))
			return false;
		return true;

	}
	
	/**
	 * * Retorna se � poss�vel acessar um documento ao qual pertence o m�bil
	 * passado por par�metro. Considera se o documento est� sem efeito (n�o
	 * estando sem efeito, retorna verdadeiro) e se <i>uma das</i> seguintes
	 * condi��es � satisfeita:
	 * <ul>
	 * <li>Usu�rio � da lota��o cadastrante do documento</li>
	 * <li>Usu�rio � subscritor do documento</li>
	 * <li>Usu�rio � titular do documento</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarSemEfeito(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		if (mob == null)
			return false;
		if (mob.doc().isSemEfeito()
				&& !mob.doc().getLotaCadastrante().equivale(lotaTitular)
				&& !titular.equivale(mob.doc().getSubscritor())
				&& !titular.equivale(mob.doc().getTitular()))
			return false;
		return true;

	}

	/**
	 * Retorna se � poss�vel acessar o documento ao qual pertence o m�bil
	 * passado por par�metro, analisando <i>podeAcessarAberto()</i>,
	 * <i>podeAcessarCancelado()</i> e <i>podeAcessarPorNivel()</i>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAcessarDocumentoAntigo(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if(mob.doc().getOrgaoUsuario() != null  
				&& mob.doc().getOrgaoUsuario().getIdOrgaoUsu() != null) {
			if(podePorConfiguracao(titular, lotaTitular, CpTipoConfiguracao.TIPO_CONFIG_ACESSAR, mob.doc().getOrgaoUsuario())) {
				return true;	
			}
		}		
		
		for (DpPessoa autorizado : mob.doc().getSubscritorECosignatarios()) {
			if (titular.equivale(autorizado))
				return true;
		}	
		
		if (pessoaTemPerfilVinculado(mob.doc(), titular, lotaTitular)) {
			return true;
		}
		

		return /*
				 * podeAcessarPublico(titular, lotaTitular, mob) &&
				 */podeAcessarAberto(titular, lotaTitular, mob)
				&& podeAcessarPorNivel(titular, lotaTitular, mob)
				&& podeAcessarCancelado(titular, lotaTitular, mob)
				&& podeAcessarSemEfeito(titular, lotaTitular, mob);
	}

	public boolean podeAcessarDocumento(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		ExDocumento doc = mob.doc();
		
		if(doc.getOrgaoUsuario() != null  
				&& doc.getOrgaoUsuario().getIdOrgaoUsu() != null) {
			if(podePorConfiguracao(titular, lotaTitular, CpTipoConfiguracao.TIPO_CONFIG_ACESSAR, doc.getOrgaoUsuario())) {
				return true;	
			}
		}		
		
		if (doc.getDnmAcesso() == null) {
			Ex.getInstance().getBL().atualizarDnmAcesso(doc);
		}
		AcessoConsulta ac = new AcessoConsulta(titular == null ? 0L
				: titular.getIdInicial(), lotaTitular == null ? 0
				: lotaTitular.getIdInicial(), titular == null ? 0L : titular
				.getOrgaoUsuario().getId(), lotaTitular == null ? 0L
				: lotaTitular.getOrgaoUsuario().getId());
		return ac.podeAcessar(doc.getDnmAcesso());
	}


	/**
	 * Retorna se � poss�vel acessar documento reservado, considerando se o
	 * documento � reservado entre lota��es (se n�o for, retorna verdadeiro) e
	 * se <i>podeAcessarReservadoEntreLotacoes().</i>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarReservado(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		switch (mob.doc().getExNivelAcesso().getGrauNivelAcesso().intValue()) {
		case (int) ExNivelAcesso.NIVEL_RESERVADO_ENTRE_LOTACOES:
			return podeAcessarReservadoEntreLotacoes(titular, lotaTitular, mob);
		default:
			return true;
		}
	}

	/**
	 * Retorna se � poss�vel acessar o documento a que pertence o m�bil passado
	 * por par�metro, considerando seu n�vel de acesso, e tamb�m o seguinte:
	 * <ul>
	 * <li>Se h� documento pai e usu�rio pode acess�-lo <i>por n�vel</i>,
	 * retorna verdadeiro</li>
	 * <li>Se o usu�rio tem perfil vinculado ao documento, retorna verdadeiro</li>
	 * <li>Nos demais casos, retorna conforme a resposta de
	 * <i>podeAcessarPorNivelN()</i>, dependendo do grau do n�vel de acesso do
	 * documento</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception 
	 */
	public boolean podeAcessarPorNivel(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (mob == null)
			return false;

		if (mob.doc().getExNivelAcesso() == null) {
			return true;
		}
		
		if (mob.getExMobilPai() != null
				&& podeAcessarPorNivel(titular, lotaTitular, mob
						.getExMobilPai()))
			return true;

		if (pessoaTemPerfilVinculado(mob.doc(), titular, lotaTitular)) {
			return true;
		}
		
		// Verifica se o titular � subscritor de algum despacho do documento
		if (mob.doc().getSubscritorDespacho().contains(titular))
            return true;
		
		// Verifica se o titular � subscritor ou cosignat�rio do documento
		if (mob.doc().getSubscritorECosignatarios().contains(titular))
			return true;

		// for (int k = numViaIniBusca; k <= numViaFimBusca; k++)
		switch (mob.doc().getExNivelAcesso().getGrauNivelAcesso().intValue()) {
		case (int) ExNivelAcesso.NIVEL_ACESSO_ENTRE_ORGAOS:
			return podeAcessarNivel20(titular, lotaTitular, mob);
		case (int) ExNivelAcesso.NIVEL_ACESSO_PUBLICO:
			return podeAcessarPublico(titular, lotaTitular, mob);
		case (int) ExNivelAcesso.NIVEL_ACESSO_PESSOA_SUB:
			return podeAcessarNivel30(titular, lotaTitular, mob);
		case (int) ExNivelAcesso.NIVEL_ACESSO_SUB_PESSOA:
			return podeAcessarNivel40(titular, lotaTitular, mob);
		case (int) ExNivelAcesso.NIVEL_ACESSO_ENTRE_LOTACOES:
			return podeAcessarNivel60(titular, lotaTitular, mob);
		case (int) ExNivelAcesso.NIVEL_ACESSO_PESSOAL:
			return podeAcessarNivel100(titular, lotaTitular, mob);
		default:
			return true;
		}
	}

	/**
	 * Retorna se � poss�vel acessar documento p�blico. Sempre verdade.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarPublico(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		return true;
	}

	/**
	 * Retorna se � poss�vel acessar o documento que cont�m o m�bil passado por
	 * par�metro. N�o � checado o n�vel de acesso. Presume-se que o documento
	 * seja limitado ao �rg�o. <i>Uma das</i> seguintes condi��es tem de ser
	 * satisfeita:
	 * <ul>
	 * <li>�rg�o a que pertence a lota��o passada por par�metro tem de ser o
	 * �rg�o da lota��o cadastrante do documento</li>
	 * <li>Usu�rio � o subscritor do documento, n�o importando de que �rg�o seja
	 * </li>
	 * <li>Usu�rio � o titular do documento, n�o importando de que �rg�o seja</li>
	 * <li>Usu�rio � o destinatario do documento ou da lota��o deste, n�o
	 * importando de que �rg�o seja</li>
	 * <li><i>jaEsteveNoOrgao()</i> � verdadeiro para esses par�metros</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarNivel20(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		
		if ((lotaTitular.getOrgaoUsuario().equivale(mob.doc()
				.getLotaCadastrante().getOrgaoUsuario()))
				|| (mob.doc().getSubscritor() != null && mob.doc()
						.getSubscritor().equivale(titular))
				|| (mob.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular))
				|| (mob.doc().getDestinatario() != null && mob.doc()
						.getDestinatario().equivale(titular))
				|| (mob.doc().getLotaDestinatario() != null && mob.doc()
						.getLotaDestinatario().equivale(lotaTitular))
				|| (jaEsteveNoOrgao(mob.doc(), titular, lotaTitular)))
			return true;
		else
			return false;
	}

	/**
	 * Retorna se um documento j� esteve num �rg�o (TRF, JFRJ, JFES),
	 * verificando se alguma movimenta��o de algum m�bil do documento teve
	 * lota��o atendente pertencente ao �rg�o onde est� a lota��o passada por
	 * par�metro ou se, tendo sido definida uma pessoa atendente para a
	 * movimenta��o, o �rg�o a que a pessoa <i>pertencia*</i> � o �rg�o da
	 * pessoa passada por par�metro. <br/>
	 * * Rever o restante deste documento, se os verbos est�o no tempo correto
	 * 
	 * @param doc
	 * @param titular
	 * @param lotaTitular
	 * @return
	 */
	public static boolean jaEsteveNoOrgao(ExDocumento doc, DpPessoa titular,
			DpLotacao lotaTitular) {
		// TODO Auto-generated method stub
		for (ExMobil m : doc.getExMobilSet()) {
			for (ExMovimentacao mov : m.getExMovimentacaoSet()) {
				if ((mov.getLotaResp() != null && mov.getLotaResp()
						.getOrgaoUsuario().equivale(
								lotaTitular.getOrgaoUsuario()))
						|| (mov.getResp() != null && mov.getResp()
								.getOrgaoUsuario().equivale(
										titular.getOrgaoUsuario())))
					return true;
			}
		}
		return false;
	}

	/**
	 * Retorna se � poss�vel acessar o documento que cont�m o m�bil passado por
	 * par�metro. N�o � checado o n�vel de acesso. Presume-se que o documento
	 * seja limitado de pessoa para subsecretaria. <i>Uma das</i> seguintes
	 * condi��es tem de ser satisfeita:
	 * <ul>
	 * <li>Usu�rio � o pr�prio cadastrante do documento</li>
	 * <li>Usu�rio � o subscritor do documento</li>
	 * <li>Usu�rio � o titular do documento</li>
	 * <li>Usu�rio pertence � subsecretaria da lota��o destinat�ria do documento
	 * </li>
	 * <li><i>pessoaJaTeveAcesso()</i> � verdadeiro para esses par�metros</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarNivel30(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {

		DpLotacao subLotaTitular = getSubsecretaria(lotaTitular);
		DpLotacao subLotaDest = getSubsecretaria(mob.doc()
				.getLotaDestinatario());

		if (titular.equivale(mob.doc().getCadastrante())
				|| (mob.doc().getSubscritor() != null && mob.doc()
						.getSubscritor().equivale(titular))
				|| (mob.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular))
				|| (subLotaTitular.equivale(subLotaDest))
				|| pessoaJaTeveAcesso(mob.doc(), titular, lotaTitular))
			return true;
		else
			return false;
	}

	/**
	 * Retorna se � poss�vel acessar o documento que cont�m o m�bil passado por
	 * par�metro. N�o � checado o n�vel de acesso. Presume-se que o documento
	 * seja limitado de subsecretaria para pessoa. <i>Uma das</i> seguintes
	 * condi��es tem de ser satisfeita:
	 * <ul>
	 * <li>Usu�rio pertence � subsecretaria da lota��o cadastrante do documento</li>
	 * <li>Usu�rio � o destinat�rio do documento</li>
	 * <li>Usu�rio � o subscritor do documento</li>
	 * <li>Usu�rio � o titular do documento</li>
	 * <li>Usu�rio � da lota��o destinat�ria do documento, se n�o tiver sido
	 * definida pessoa destinat�ria</li>
	 * <li><i>pessoaJaTeveAcesso()</i> � verdadeiro para esses par�metros</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarNivel40(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {

		DpLotacao subLotaTitular = getSubsecretaria(lotaTitular);
		DpLotacao subLotaDoc = getSubsecretaria(mob.doc().getLotaCadastrante());

		if ((subLotaTitular.equivale(subLotaDoc))
				|| (mob.doc().getDestinatario() != null && mob.doc()
						.getDestinatario().equivale(titular))
				|| (mob.doc().getSubscritor() != null && mob.doc()
						.getSubscritor().equivale(titular))
				|| (mob.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular))
				|| (mob.doc().getDestinatario() == null
						&& mob.doc().getLotaDestinatario() != null && mob.doc()
						.getLotaDestinatario().equivale(lotaTitular))
				|| pessoaJaTeveAcesso(mob.doc(), titular, lotaTitular))
			return true;
		else
			return false;

	}

	/**
	 * Retorna se � poss�vel acessar documento reservado entre lota��es, com
	 * base em <i>podeAcessarPorNivel20()</i> e <i>podeAcessarPorNivel60().</i>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarReservadoEntreLotacoes(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		return podeAcessarNivel20(titular, lotaTitular, mob)
				&& podeAcessarNivel60(titular, lotaTitular, mob);
	}

	/**
	 * Retorna se � poss�vel acessar o documento que cont�m o m�bil passado por
	 * par�metro. N�o � checado o n�vel de acesso. Presume-se que o documento
	 * seja limitado entre lota��es. <i>Uma das</i> seguintes condi��es tem de
	 * ser satisfeita:
	 * <ul>
	 * <li>Usu�rio � da lota��o cadastrante do documento</li>
	 * <li>Usu�rio � o subscritor do documento</li>
	 * <li>Usu�rio � o titular do documento</li>
	 * <li>Usu�rio pertence � subsecretaria da lota��o destinat�ria do documento
	 * </li>
	 * <li>Usu�rio � da lota��o destinat�ria do documento</li>
	 * <li><i>jaPassouPor()</i> � verdadeiro para esses par�metros</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarNivel60(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {

		if ((lotaTitular.equivale(mob.doc().getLotaCadastrante()))
				|| (mob.doc().getSubscritor() != null && mob.doc()
						.getSubscritor().equivale(titular))
				|| (mob.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular))
				|| (mob.doc().getLotaDestinatario() != null && mob.doc()
						.getLotaDestinatario().equivale(lotaTitular))
				|| (jaPassouPor(mob.doc(), lotaTitular)))
			return true;
		else
			return false;
	}

	/**
	 * Retorna se � poss�vel acessar o documento que cont�m o m�bil passado por
	 * par�metro. N�o � checado o n�vel de acesso. Presume-se que o documento
	 * seja limitado entre pessoas. <i>Uma das</i> seguintes condi��es tem de
	 * ser satisfeita:
	 * <ul>
	 * <li>Usu�rio � o pr�prio cadastrante do documento</li>
	 * <li>Usu�rio � o subscritor do documento</li>
	 * <li>Usu�rio � o titular do documento</li>
	 * <li>Usu�rio � o pr�prio destinat�rio do documento</li>
	 * <li>Usu�rio � da lota��o destinat�ria do documento</li>
	 * <li><i>pessoaJaTeveAcesso()</i> � verdadeiro para esses par�metros</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeAcessarNivel100(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {

		if (titular.equivale(mob.doc().getCadastrante())
				|| (mob.doc().getSubscritor() != null && mob.doc()
						.getSubscritor().equivale(titular))
				|| (mob.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular))
				|| (mob.doc().getDestinatario() != null && mob.doc()
						.getDestinatario().equivale(titular))
				|| pessoaJaTeveAcesso(mob.doc(), titular, lotaTitular))
			return true;
		else
			return false;
	}

	/**
	 * Retorna se � poss�vel anexar arquivo a um m�bil. As condi��es s�o as
	 * seguintes:
	 * <ul>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>M�bil n�o pode estar juntado</li>
	  * <li>M�bil n�o pode estar arquivado</li>
	 * <li>Volume n�o pode estar encerrado</li>
	 * <li>M�bil tem de estar finalizado</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o m�bil / usu�rio</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAnexarArquivo(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (mob.doc().isFinalizado())
			return !mob.isEmTransito()
					&& !mob.isGeral()
					&& !mob.isJuntado()
					&& !mob.isArquivado()
					&& !mob.isSobrestado()
					&& !mob.isVolumeEncerrado()
					&& podeMovimentar(titular, lotaTitular, mob)
					&& !mob.doc().isSemEfeito()
					&& podePorConfiguracao(titular, lotaTitular,
							ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO,
							CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR, null);
		
		if(mob.isGeral() && mob.doc().isProcesso())
			return false;
			
		return mob.isGeral();
	}

	/**
	 * Retorna um configura��o existente para a combina��o dos dados passados
	 * como par�metros, caso exista.
	 * 
	 * @param titularIniciador
	 * @param lotaTitularIniciador
	 * @param tipoConfig
	 * @param procedimento
	 * @param raia
	 * @param tarefa
	 * @return
	 * @throws Exception
	 */
	private ExConfiguracao preencherFiltroEBuscarConfiguracao(
			DpPessoa titularIniciador, DpLotacao lotaTitularIniciador,
			long tipoConfig, long tipoMov, ExTipoDocumento exTipoDocumento,
			ExTipoFormaDoc exTipoFormaDoc, ExFormaDocumento exFormaDocumento,
			ExModelo exModelo, ExClassificacao exClassificacao, ExVia exVia,
			ExNivelAcesso exNivelAcesso, ExPapel exPapel, CpOrgaoUsuario orgaoObjeto) throws Exception {
		ExConfiguracao cfgFiltro = new ExConfiguracao();

		cfgFiltro.setCargo(titularIniciador.getCargo());
		cfgFiltro.setOrgaoUsuario(lotaTitularIniciador.getOrgaoUsuario());
		cfgFiltro.setFuncaoConfianca(titularIniciador.getFuncaoConfianca());
		cfgFiltro.setLotacao(lotaTitularIniciador);
		cfgFiltro.setDpPessoa(titularIniciador);
		cfgFiltro.setCpTipoConfiguracao(CpDao.getInstance().consultar(
				tipoConfig, CpTipoConfiguracao.class, false));
		if (cfgFiltro.getCpTipoConfiguracao() == null)
			throw new Exception(
					"N�o � permitido buscar uma configura��o sem definir seu tipo.");
		if (tipoMov != 0)
			cfgFiltro.setExTipoMovimentacao(CpDao.getInstance().consultar(
					tipoMov, ExTipoMovimentacao.class, false));
		cfgFiltro.setExTipoDocumento(exTipoDocumento);
		cfgFiltro.setExTipoFormaDoc(exTipoFormaDoc);
		cfgFiltro.setExFormaDocumento(exFormaDocumento);
		cfgFiltro.setExModelo(exModelo);
		cfgFiltro.setExClassificacao(exClassificacao);
		cfgFiltro.setExVia(exVia);
		cfgFiltro.setExNivelAcesso(exNivelAcesso);
		cfgFiltro.setExPapel(exPapel);
		cfgFiltro.setOrgaoObjeto(orgaoObjeto);

		ExConfiguracao cfg = (ExConfiguracao) getConfiguracaoBL()
				.buscaConfiguracao(cfgFiltro, new int[] { 0 }, null);

		// Essa linha � necess�ria porque quando recuperamos um objeto da classe
		// WfConfiguracao do TreeMap est�tico que os armazena, este objeto est�
		// detached, ou seja, n�o est� conectado com a se��o atual do hibernate.
		// Portanto, quando vamos acessar alguma propriedade dele que seja do
		// tipo LazyRead, obtemos um erro. O m�todo lock, attacha ele novamente
		// na se��o atual.
		if (cfg != null)
			ExDao.getInstance().getSessao().lock(cfg, LockMode.NONE);

		return cfg;
	}

	/**
	 * Verifica se uma pessoa ou lota��o tem permiss�o em uma configura��o
	 * passada como par�metro.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param tipoConfig
	 * @param tipoMovimentacao
	 *            - Configura��o que ter� a permiss�o verificada.
	 * @return
	 * @throws Exception
	 */
	private Boolean podePorConfiguracao(DpPessoa titular,
			DpLotacao lotaTitular, long tipoMov, long tipoConfig, CpOrgaoUsuario orgaoObjeto)
			throws Exception {
		CpSituacaoConfiguracao situacao;
		ExConfiguracao cfg = preencherFiltroEBuscarConfiguracao(titular,
				lotaTitular, tipoConfig, tipoMov, null, null, null, null, null,
				null, null, null, orgaoObjeto);

		if (cfg != null) {
			situacao = cfg.getCpSituacaoConfiguracao();
		} else {
			situacao = CpDao.getInstance().consultar(tipoConfig,
					CpTipoConfiguracao.class, false).getSituacaoDefault();

		}

		if (situacao != null
				&& situacao.getIdSitConfiguracao() == CpSituacaoConfiguracao.SITUACAO_PODE)
			return true;
		return false;
	}

	private Boolean podePorConfiguracao(DpPessoa titular,
			DpLotacao lotaTitular, long tipoConfig) throws Exception {
		return podePorConfiguracao(titular, lotaTitular, 0L, tipoConfig, null);
	}
	
	private Boolean podePorConfiguracao(DpPessoa titular,
			DpLotacao lotaTitular, long tipoConfig, CpOrgaoUsuario orgaoObjeto) throws Exception {
		return podePorConfiguracao(titular, lotaTitular, 0L, tipoConfig, orgaoObjeto);
	}

	/**
	 * Retorna se � poss�vel fazer arquivamento corrente de um m�bil, segundo as regras a

	 * seguir:
	 * <ul>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil tem de ser via ou geral de processo (caso em que se condidera a
	 * situa��o do �ltimo volume)</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeArquivarCorrente(final DpPessoa titular,
			final DpLotacao lotaTitular, ExMobil mob) throws Exception {

		if (!(mob.isVia() || mob.isGeralDeProcesso())
				|| mob.doc().isSemEfeito())
			return false;

		if (mob.isGeralDeProcesso() && mob.doc().isFinalizado())
			mob = mob.doc().getUltimoVolume();

		if (mob.doc().isEletronico()
				&& (mob.temAnexosNaoAssinados() || mob
						.temDespachosNaoAssinados()))
			return false;

		return mob != null
				&& mob.doc().isAssinado()
				&& podeMovimentar(titular, lotaTitular, mob)
				&& !mob.isArquivado()
				&& !mob.isSobrestado()
				&& !mob.isJuntado()
				&& !mob.isEmTransito()
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_CORRENTE,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}
	
	/**
	 * Retorna se � poss�vel fazer sobrestar um m�bil, segundo as
	 * regras a seguir:


	 * <ul>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil tem de ser via ou volume (n�o pode ser geral)</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeSobrestar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if(!mob.doc().isAssinado())
			return false;
		
		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();
		
		return mob.doc().isFinalizado()
				&& (mob.isVia() || mob.isVolume())
				&& podeMovimentar(titular, lotaTitular, mob)
				&& !mob.isArquivado()
				&& !mob.isSobrestado()
				&& !mob.isJuntado()
				&& !mob.isEmTransito()
				&& !mob.doc().isSemEfeito()
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_SOBRESTAR,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel tornar um documento sem efeito, segundo as
	 * regras a seguir:


	 * <ul>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil tem de ser via ou volume (n�o pode ser geral)</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeTornarDocumentoSemEfeito(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();
		
		if(mob.doc().isSemEfeito())
			return false;
		
		if(!mob.doc().isEletronico() || !mob.doc().isAssinado())
			return false;
		
		if(mob.doc().getSubscritor() == null || !mob.doc().getSubscritor().equivale(titular))
			return false;
		
		//Verifica se o documento est� com pedido de publica��o no DJE ou BIE.
		if(mob.doc().isPublicacaoSolicitada() ||  
				mob.doc().isPublicacaoAgendada() || 	
				mob.doc().isPublicacaoBoletimSolicitada() ||
				mob.doc().isBoletimPublicado() ||
				mob.doc().isDJEPublicado()) 
			return false;
		
		
		//Verifica se o subscritor pode movimentar todos os mobils
		//E Tamb�m se algum documento diferente est� apensado ou juntado a este documento


		for (ExMobil m : mob.doc().getExMobilSet()) {
			if(!m.isGeral()) {
				if (!podeMovimentar(titular, lotaTitular, m))
					return false;
				
				if(m.isJuntado() || m.isApensado())
					return false;
				
				if (m.temApensos())
					return false;
				
				if(m.temDocumentosJuntados())
					return false;
			}
		}
		
		
		return  getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_TORNAR_SEM_EFEITO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}	
	
	/**
	 * Retorna se � poss�vel criar subprocesso, segundo as regras abaixo:
	 * <ul>
	 * <li>Documento tem de ser processo</li>
	 * <li>M�bil n�o pode ser geral</li>

	 * <li>Documento n�o pode ter um m�bil pai</li>
	 * <li>Documento n�o pode estar cancelado</li>
	 * <li>Usu�rio tem de ter permiss�o para acessar o documento que cont�m o
	 * m�bil. <b>� mesmo necess�rio verificar isso?</b></li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o: Criar
	 * Documento Filho</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeCriarSubprocesso(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (!mob.doc().isProcesso())
			return false;
		if (!mob.isGeral())
			return false;

		if (mob.doc().getExMobilPai() != null)
			return false;

		return !mob.doc().isCancelado()
				&& !mob.doc().isSemEfeito()
				&& !mob.isArquivado()
				&& mob.doc().isAssinado()
				&& podeAcessarDocumento(titular, lotaTitular, mob)
				&& podePorConfiguracao(titular, lotaTitular,
						CpTipoConfiguracao.TIPO_CONFIG_CRIAR_DOC_FILHO);
	}

	/**
	 * Retorna se � poss�vel criar um documento filho do m�bil passado como
	 * par�metro, de acordo com as regras:
	 * <ul>
	 * <li>Documento n�o pode estar cancelado</li>
	 * <li>Volume n�o pode estar encerrado, pelo fato de documento filho
	 * representar conte�do agregado ao m�bil</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeCriarDocFilho(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		return !mob.doc().isCancelado()
				&& !mob.doc().isSemEfeito()
				&& !mob.isVolumeEncerrado()
				&& !mob.isArquivado()
				&& podeMovimentar(titular, lotaTitular, mob)
				&& podePorConfiguracao(titular, lotaTitular,
						CpTipoConfiguracao.TIPO_CONFIG_CRIAR_DOC_FILHO);
	}

	/**
	 * Retorna se � poss�vel fazer simula��o, com base na configura��o de tipo
	 * "Pode Simular Usu�rio"
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @return
	 * @throws Exception
	 */
	public boolean podeSimularUsuario(final DpPessoa titular,
			final DpLotacao lotaTitular) throws Exception {
		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_SIMULAR_USUARIO);
	}

	/**
	 * Retorna se � poss�vel mostrar o link para arquivamento intermedi�rio de
	 * um m�bil, de acordo com as condi��es a seguir:
	 * <ul>
	 * <li>M�bil tem de ser via ou geral de processo</li>

	 * <li>M�bil tem de estar assinado</li>
	 * <li>M�bil tem de estar arquivado corrente</li>
	 * <li>PCTT tem de prever, para o m�bil, tempo de perman�ncia no arquivo
	 * intermedi�rio</li>
	 * <li>M�bil n�o pode estar arquivado intermedi�rio nem permanente</li>
	 * <li>M�bil n�o pode estar em edital de elimina��o</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */

	public boolean podeBotaoArquivarIntermediario(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!(mob.isVia() || mob.isGeralDeProcesso())
				|| mob.doc().isSemEfeito() || mob.isEliminado())
			return false;

		return mob != null
				&& mob.doc().isAssinado()
				&& mob.isArquivadoCorrente()
				&& mob.temTemporalidadeIntermediario()
				&& !mob.isArquivadoIntermediario()
				&& !mob.isArquivadoPermanente()
				&& !mob.isEmEditalEliminacao()
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_INTERMEDIARIO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel fazer o arquivamento intermedi�rio do m�bil, ou
	 * seja, se � poss�vel mostrar o link para movimenta��o e se, al�m disso, o
	 * m�bil encontra-se na lota��o titular ou � digital.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeArquivarIntermediario(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return podeBotaoArquivarIntermediario(titular, lotaTitular, mob)
				&& (lotaTitular.equivale(mob
						.getUltimaMovimentacaoNaoCancelada().getLotaResp()) || mob
						.doc().isEletronico());
	}

	/**
	 * Retorna se � poss�vel exibir o link para arquivamento permanente de um
	 * m�bil, de acordo com as condi��es a seguir:
	 * <ul>
	 * <li>M�bil tem de ser via ou geral de processo</li>
	 * <li>M�bil n�o pode estar sem efeito</li>
	 * <li>M�bil tem de estar assinado</li>
	 * <li>M�bil tem de estar arquivado corrente ou intermedi�rio; n�o pode ter
	 * sido arquivado permanentemente</li>
	 * <li>Tem de estar prevista guarda permanente, seja por PCTT ou por
	 * indica��o</li>
	 * <li>M�bil n�o pode estar em edital de elimina��o</li>
	 * <li>M�bil n�o pode ter sido eliminado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeBotaoArquivarPermanente(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!(mob.isVia() || mob.isGeralDeProcesso())
				|| mob.doc().isSemEfeito() || mob.isEliminado())
			return false;


		return mob != null
				&& mob.doc().isAssinado()
				&& ((!mob.temTemporalidadeIntermediario() && mob.isArquivadoCorrente()) || mob
						.isArquivadoIntermediario())
				&& !mob.isArquivadoPermanente()
				&& mob.isDestinacaoGuardaPermanente()
				&& !mob.isEmEditalEliminacao()
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_PERMANENTE,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel fazer o arquivamento permanente do m�bil, ou seja,
	 * se � poss�vel mostrar o link para movimenta��o e se, al�m disso, o m�bil
	 * encontra-se na lota��o titular ou � digital.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeArquivarPermanente(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return podeBotaoArquivarPermanente(titular, lotaTitular, mob)
				&& (lotaTitular.equivale(mob
						.getUltimaMovimentacaoNaoCancelada().getLotaResp()) || mob
						.doc().isEletronico());
	}
	
	/*
	 * Retorna se � poss�vel assinar digitalmente o documento a que pertence o
	 * m�bil passado por par�metro, conforme as seguintes condi��es:
	 * <ul>
	 * <li>Documento n�o pode ser processo interno importado</li>
	 * <li>Usu�rio tem de ser cossignat�rio do documento ou subscritor ou
	 * [cadastrante, caso o documento seja externo], ou <i>podeMovimentar()</i>
	 * tem de ser verdadeiro para o m�bil / usu�rio</li>
	 * <li>Documento tem de estar finalizado</li>
	 * <li>Documento n�o pode estar cancelado</li>
	 * <li>Documento n�o pode estar em algum arquivo nem eliminado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAssinar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (mob.getDoc().isEletronico() && mob.getDoc().isAssinado())
			return false;

		if (mob.getExDocumento().isProcesso()
				&& mob.getExDocumento().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_INTERNO_ANTIGO)
			return false;

		if (mob.isArquivado() || mob.isEliminado())
			return false;

		// cosignatario pode assinar depois que o subscritor j� tiver assinado

		boolean isConsignatario = false;

		for (ExMovimentacao m : mob.doc().getMobilGeral()
				.getExMovimentacaoSet()) {
			if (m.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO
					&& m.getExMovimentacaoCanceladora() == null
					&& (m.getSubscritor() != null && m.getSubscritor()
							.equivale(titular))) {
				isConsignatario = true;
				break;
			}
		}

		boolean isCadastranteExterno = false;
		if (mob.doc().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO
				&& mob.doc().getCadastrante().equivale(titular))
			isCadastranteExterno = true;

		//condi��es para assinatura digital de cosignat�rios em documentos f�sicos 
		if 	((mob.doc().getSubscritor() != null && mob.doc().getSubscritor().equivale(titular) 
				|| isConsignatario) && mob.doc().isFisico() && mob.doc().isFinalizado())
			return true;
		
		return ((mob.doc().getSubscritor() != null && mob.doc().getSubscritor()
				.equivale(titular))

				|| isCadastranteExterno || (isConsignatario && !mob.doc().isAssinado() && mob.doc().isAssinadoSubscritor()) 
						|| podeMovimentar(
				titular, lotaTitular, mob))


				// && mob.doc().isEletronico() //Nato: Permitido assinar
				// digitalmente
				// doc em papel, a pedido do Dr Libonati.
				&& (mob.doc().isFinalizado())
				&& !mob.doc().isCancelado()
				&& !mob.doc().isSemEfeito()
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}
	
	public boolean podeSerSubscritor(final ExDocumento doc) throws Exception {
		
		if(doc.getExTipoDocumento().getIdTpDoc().equals(ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO))
			return true;
		
		return podeSerSubscritor(doc.getTitular(), doc.getLotaTitular(), doc.getExModelo());
	}
	
	/**
	 * Retorna se � poss�vel ser subscritor de um documento.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeSerSubscritor(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExModelo mod) throws Exception {
		
		if(titular == null || mod == null)
			return false;
		
		return getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						titular.getCargo(),
						titular.getFuncaoConfianca(),
						mod.getExFormaDocumento(),
						mod,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel publicar o Boletim Interno que possui mob, segundo
	 * as regras:
	 * <ul>
	 * <li>Documento tem de estar finalizado</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>Documento n�o pode estar publicado</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o:
	 * Movimentar / Publica��o Boletim</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podePublicar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return (mob.doc().isFinalizado())
				&& podeMovimentar(titular, lotaTitular, mob)
				&& mob.doc().isAssinado()
				&& !mob.doc().isBoletimPublicado()
				&& !mob.doc().isSemEfeito()
				&& !mob.doc().isEliminado()
				&& !mob.isPendenteDeAnexacao()
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								mob.doc().getExModelo(),
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_PUBLICACAO_BOLETIM,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se uma pessoa j� teve acesso a um documento. Para isso, verifica
	 * se pessoa j� foi atendente de alguma das movimenta��es de qualquer m�bil
	 * do documento, caso a movimenta��o n�o tenha como atendente toda uma
	 * lota��o, ou se ela � da lota��o atendente de alguma dessas movimenta��es.
	 * Se a movimenta��o em quest�o for uma redefini��o de n�vel de acesso,
	 * verifica se foi o pr�prio usu�rio que cadastrou a redefini��o.
	 * <b>Documentar a raz�o dessas regras.</b>
	 * 
	 * @param doc
	 * @param titular
	 * @param lotaTitular
	 * @return
	 */
	public static boolean pessoaJaTeveAcesso(ExDocumento doc, DpPessoa titular,
			DpLotacao lotaTitular) {
		for (ExMobil m : doc.getExMobilSet()) {
			for (ExMovimentacao mov : m.getExMovimentacaoSet()) {
				if ((mov.getLotaResp() != null
						&& mov.getLotaResp().equivale(lotaTitular) && mov
						.getResp() == null)
						|| (mov.getResp() != null && mov.getResp().equivale(
								titular)))
					return true;
				if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REDEFINICAO_NIVEL_ACESSO
						&& ((mov.getLotaCadastrante() != null
								&& mov.getLotaCadastrante().equivale(
										lotaTitular) && mov.getCadastrante() == null) || (mov
								.getCadastrante() != null && mov
								.getCadastrante().equivale(titular))))
					return true;

			}
		}
		return false;
	}

	/**
	 * Retorna se uma pessoa/lota��o est� vinculada a um documento por meio de algum
	 * perfil. Para isso, verifica cada movimenta��o n�o cancelada de vincula��o
	 * de perfil registrada no m�bil geral do documento e analisa se a pessoa/lota��o
	 * passada por par�metro � <i>titular/lotaTitular</i> de alguma dessas movimenta��es.

	 * 
	 * @param doc
	 * @param titular
	 * @param lotaTitular
	 * @return
	 */
	public static boolean pessoaTemPerfilVinculado(ExDocumento doc,
			DpPessoa titular, DpLotacao lotaTitular) {
		for (ExMovimentacao mov : doc.getMobilGeral().getExMovimentacaoSet()) {

			if (!mov.isCancelada()
					&& mov
							.getExTipoMovimentacao()

							.getIdTpMov()
							.equals(
									ExTipoMovimentacao.TIPO_MOVIMENTACAO_VINCULACAO_PAPEL)) {

				if (mov.getSubscritor() != null){
					 if (mov.getSubscritor().equivale(titular)) {
						 return true;
				     }
				}else {
					if (mov.getLotaSubscritor().equivale(lotaTitular)){
						return true;
					}
				}
			}
		}

		return false;
	}

	/**
	 * Retorna se uma <i>lota��o</i> j� foi atendente em alguma movimenta��o
	 * (mesmo cancelada) de algum m�bil do documento passado por par�metro
	 * 
	 * @param doc
	 * @param lota
	 * @return
	 */
	public static boolean jaPassouPor(ExDocumento doc, DpLotacao lota) {
		for (ExMobil m : doc.getExMobilSet()) {
			for (ExMovimentacao mov : m.getExMovimentacaoSet())
				if (mov.getLotaResp() != null
						&& mov.getLotaResp().equivale(lota))
					return true;
		}
		return false;
	}

	/**
	 * Retorna se � poss�vel exibir a op��o de criar via em documento.
	 * <b>Verificar qual a utilidade desse m�todo</b>. Condi��es:
	 * <ul>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>Tem de ser poss�vel criar via (<i>podeCriarVia()</i>)</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeBotaoCriarVia(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (mob.doc().isSemEfeito() || mob.doc().isEliminado())
			return false;

		if (!mob.isEmTransito() && podeCriarVia(titular, lotaTitular, mob)
				&& podeMovimentar(titular, lotaTitular, mob))
			// && (mob.doc().getNumUltimaViaNaoCancelada() == numVia))
			return true;

		return false;
	}

	/**
	 * Retorna se � poss�vel desentranhar m�bil de outro. Regras:
	 * <ul>
	 * <li>M�bil tem de ser via</li>
	 * <li>M�bil tem de estar juntado externo ou interno (verifica-se juntada
	 * interna pela exist�ncia de m�bil pai)</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>A n�o ser que o m�bil esteja juntado externo, <i>podeMovimentar()</i>
	 * tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil tem de estar juntado. <b>Obs.: essa checagem n�o torna
	 * desnecess�rios os processamentos acima?</b></li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o:
	 * Cancelar Juntada</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelarJuntada(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();

		if (!mob.isVia())
			return false;

		if (ultMovNaoCancelada == null)
			return false;

		ExMobil mobPai = null;
		if (!mob.isJuntadoExterno()) {
			mobPai = mob.getExMobilPai();
			if (mobPai == null)
				return false;
		}

		if (mob.isEmTransito()
				|| mob.isCancelada()
				|| (!mob.isJuntadoExterno() && !podeMovimentar(titular,
						lotaTitular, mobPai)) || (!mob.isJuntado()))
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_JUNTADA,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel cancelar a �ltima movimenta��o n�o cancelada do
	 * m�bil mob, segundo as regras abaixo.
	 * <ul>
	 * <li>�ltima movimenta��o n�o cancelada do m�bil n�o pode ser apensa��o nem
	 * desapensa��o</li>
	 * <li>�ltima movimenta��o n�o cancelada do m�bil n�o pode ser assinatura do
	 * documento ou de movimenta��o</li>
	 * <li>�ltima movimenta��o n�o cancelada do m�bil n�o pode ser recebimento</li>
	 * <li>�ltima movimenta��o n�o cancelada do m�bil n�o pode ser inclus�o em
	 * edital de elimina��o</li>
	 * <li>�ltima movimenta��o n�o cancelada do m�bil n�o pode ser atualiza��o
	 * resultante de assinatura do documento ou de movimenta��o</li>
	 * <li>�ltima movimenta��o n�o cancelada do m�bil n�o pode ser publica��o do
	 * Boletim nem notifica��o de publica��o do Boletim</li>
	 * <li>Se a �ltima movimenta��o n�o cancelada for agendamento de publica��o
	 * direta no DJE, o usu�rio que tem permiss�o para atender pedidos de
	 * publica��o indireta pode cancelar, n�o importando se
	 * <i>podeMovimentar()</i> � verdadeiro</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>Se a �ltima movimenta��o j� for um cancelamento, n�o permite cancelar
	 * a �ltima movimenta��o n�o cancelada, a n�o ser que a �ltima movimenta��o
	 * seja cancelamento de atualiza��o ou de recebimento transit�rio</li>
	 * <li>Apenas o usu�rio que seja da lota��o cadastrante da �ltima
	 * movimenta��o n�o cancelada pode cancel�-la, se for dos seguintes tipos:</li>
	 * <ul>
	 * <li>Transfer�ncia</li>
	 * <li>Transfer�ncia Externa</li>
	 * <li>Despacho Interno com Transfer�ncia</li>
	 * <li>Despacho com transfer�ncia Externa</li>
	 * <li>Despacho com Transfer�ncia</li>
	 * <li>Recebimento Transit�rio</li>
	 * <li>Recebimento</li>
	 * <li><b>Registro de Assinatura do Documento (desnecess�rio)</li>
	 * <li>Assinatura Digital do Documento (desnecess�rio)</b></li>
	 * </ul>
	 * <li>Excetuadas as condi��es acima, para cancelar a �ltima movimenta��o
	 * n�o cancelada do m�bil o usu�rio ter� de ser 1) o atendente da
	 * movimenta��o, 2) o subscritor da movimenta��o, 3) o titular da
	 * movimenta��o ou 4) da lota��o cadastrante da movimenta��o</li> <li>Se
	 * �ltima movimenta��o n�o cancelada for de registro de assinatura, s� deixa
	 * cancelar se n�o houver alguma movimenta��o posterior em alguma das vias.
	 * <b>Obs.: regra em desuso. Parece tamb�m haver erro no c�digo
	 * (before(dt)?)</b></li> <li>N�o pode haver configura��o impeditiva. Tipo
	 * de configura��o: Cancelar Movimenta��o</li> </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelarMovimentacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		//N�o deixa cancelar movimenta��o de um mobil diferente de geral quando um documento est� sem efeito.

		if(!mob.isGeral() && mob.doc().isSemEfeito())
			return false;
		
		if (mob.isEliminado())
			return false;
			
		final ExMovimentacao exUltMovNaoCanc = mob
				.getUltimaMovimentacaoNaoCancelada();
		final ExMovimentacao exUltMov = mob.getUltimaMovimentacao();
		if (exUltMov == null || exUltMovNaoCanc == null)
			return false;
		
		//S� deixa cancelar movimenta��o de tornar documento sem efeito, se o titular for o subscritor do documento
		//Tamb�m n�o � permitido os cosignat�rios cancelar essa movimenta��o
		if(mob.isGeral() && 
				exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_TORNAR_SEM_EFEITO &&
				!exUltMovNaoCanc.getSubscritor().equivale(titular))



			return false;

		// N�o deixa cancelar apensa��o ou desapensa��o
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_APENSACAO
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESAPENSACAO)
			return false;

		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_EM_EDITAL_DE_ELIMINACAO)
			return false;
			
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO)
			return false;

		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_PENDENCIA_DE_ANEXACAO)
			return false;

		// N�o deixa cancelar assinatura
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REGISTRO_ASSINATURA_DOCUMENTO
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CONFERENCIA_COPIA_DOCUMENTO)
			return false;

		// N�o deixa cancelar a atualiza��o (por enquanto, s� ser resultar
		// da
		// assinatura)
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ATUALIZACAO
				&& exUltMovNaoCanc.getExMovimentacaoRef() != null
				&& (exUltMovNaoCanc.getExMovimentacaoRef()
						.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REGISTRO_ASSINATURA_DOCUMENTO || exUltMovNaoCanc
						.getExMovimentacaoRef().getExTipoMovimentacao()
						.getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO))
			return false;

		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_NOTIFICACAO_PUBL_BI
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_PUBLICACAO_BOLETIM
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DISPONIBILIZACAO)
			return false;
		
		//N�o deixa cancelar juntada quando o documento est� juntado a um expediente/processo que j� sofreu outra movimenta��o
		if(exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA) {
			
			if (exUltMovNaoCanc.getExMobilRef().isArquivado())
				return false;
			
			ExMovimentacao ultimaMovimentacaoDaReferencia = exUltMovNaoCanc.getExMobilRef().getUltimaMovimentacao();

			if(ultimaMovimentacaoDaReferencia.getExTipoMovimentacao().getIdTpMov() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANOTACAO
					&& ultimaMovimentacaoDaReferencia.getDtMov().after(exUltMovNaoCanc.getDtMov()))
				return false;
			
			//Verifica se o mobil de refer�ncia j� recebeu outras movimenta��es depois da movimenta��o que vai ser cancelada.
			if(mob.doc().isEletronico()
					&& exUltMovNaoCanc.getExMobilRef() != null
					&& exUltMovNaoCanc.getExMobilRef().doc().isNumeracaoUnicaAutomatica()) {
				
				for (ExMovimentacao movDoMobilRef : exUltMovNaoCanc.getExMobilRef().getCronologiaSet()) {
					if(movDoMobilRef.getIdMov().equals(exUltMovNaoCanc.getIdMov()))
						break;

					if(!movDoMobilRef.isCancelada() &&
							movDoMobilRef.getExTipoMovimentacao().getId() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_REFERENCIA &&
							movDoMobilRef.getExTipoMovimentacao().getId() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANOTACAO &&
							movDoMobilRef.getDtIniMov().after(exUltMovNaoCanc.getDtIniMov()))
						return false;
				}
			}
		}
		

		// Verifica se a �ltima movimenta��o n�o cancelada � agendamento de
		// publica��o no DJE
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO
				&& podeAtenderPedidoPublicacao(titular, lotaTitular, mob))
			return true;


		// N�o deixa cancelar a mov se a via estiver cancelada ou h� um
		// cancelamento imediatamente anterior, a n�o ser se este for
		// cancelamento de receb transit�rio ou de atualiza��o
		if (mob.isCancelada()
				|| (exUltMovNaoCanc.getIdMov() != exUltMov.getIdMov()
						&& exUltMov.getExMovimentacaoRef() != null
						&& exUltMov.getExMovimentacaoRef()
								.getExTipoMovimentacao().getIdTpMov() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO_TRANSITORIO && exUltMov
						.getExMovimentacaoRef().getExTipoMovimentacao()
						.getIdTpMov() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_ATUALIZACAO)
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_CRIACAO)
			return false;
		// Essas s� a lota do cadastrante pode cancelar
		else if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO_TRANSITORIO
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REGISTRO_ASSINATURA_DOCUMENTO
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_DOCUMENTO) {
			return exUltMovNaoCanc.getLotaCadastrante().equivale(lotaTitular);
		} else {
			if (exUltMovNaoCanc.getLotaResp() != null) {
				if (!exUltMovNaoCanc.getLotaResp().equivale(lotaTitular))
					return false;
			} else if (exUltMovNaoCanc.getSubscritor() != null) {
				if (!exUltMovNaoCanc.getSubscritor().getLotacao().equivale(
						lotaTitular))
					return false;
			} else if (exUltMovNaoCanc.getTitular() != null) {
				if (!exUltMovNaoCanc.getTitular().getLotacao().equivale(
						lotaTitular))
					return false;
			} else {
				if (!exUltMovNaoCanc.getLotaCadastrante().equivale(lotaTitular))
					return false;
			}
		}

		// Antes de deixar cancelar a assinatura, v� antes se houve
		// movimenta��es posteriores em qualquer via
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_REGISTRO_ASSINATURA_DOCUMENTO) {
			Date dt = exUltMovNaoCanc.getDtIniMov();
			for (ExMobil m : mob.doc().getExMobilSet()) {
				ExMovimentacao move = m.getUltimaMovimentacaoNaoCancelada();
				if (move != null && move.getDtIniMov().before(dt)) {
					return false;
				}
			}
		}
		
		//N�o deixa desfazer os antigos arquivamentos feitos em volume de processo
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ARQUIVAMENTO_CORRENTE 
				&& !podeDesarquivarCorrente(titular, lotaTitular, mob)) {
			return false;
			
		}
		
		if (exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO 
				&& !podeCancelarAnexo(titular, lotaTitular, mob, exUltMovNaoCanc)) {
			return false;
			
		}

		return getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_CANCELAMENTO_DE_MOVIMENTACAO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel cancelar uma movimenta��o mov, segundo as regras
	 * abaixo. <b>M�todo em desuso?</b>
	 * <ul>
	 * <li>Movimenta��o n�o pode estar cancelada</li>
	 * <li>Usu�rio tem de ser da lota��o cadastrante da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o:
	 * Cancelar Movimenta��o</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {
		if (mov == null)
			return false;

		if (mob.isCancelada())
			return false;

		if (!mov.getLotaCadastrante().equivale(lotaTitular))
			return false;
		
		if (!mov.getLotaCadastrante().equivale(mov.getLotaResp()))
			return false;	

		return getConf().podePorConfiguracao(titular, lotaTitular,
				mov.getIdTpMov(),
				CpTipoConfiguracao.TIPO_CONFIG_CANCELAR_MOVIMENTACAO);
	}

	/**
	 * Retorna se � poss�vel cancelar a via mob, conforme estabelecido a seguir:
	 * <ul>
	 * <li>M�bil tem de ser via</li>
	 * <li>Documento que cont�m a via n�o pode estar assinado</li>
	 * <li>Via n�o pode estar cancelada</li>
	 * <li>�ltima movimenta��o n�o cancelada da via tem de ser a sua cria��o</li>
	 * <li>N�o pode haver movimenta��es canceladas posteriores � cria��o</li>
	 * <li>Com rela��o � movimenta��o de cria��o (�ltima movimenta��o n�o
	 * cancelada), o usu�rio tem de ser 1) da lota��o atendente da movimenta��o,
	 * 2) o subscritor da movimenta��o, 3) o titular da movimenta��o ou 4) da
	 * lota��o cadastrante da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelarVia(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (!mob.isVia())
			return false;
		if (mob.getExDocumento().isAssinado())
			return false;
		final ExMovimentacao exUltMovNaoCanc = mob
				.getUltimaMovimentacaoNaoCancelada();
		final ExMovimentacao exUltMov = mob.getUltimaMovimentacao();
		if (mob.isCancelada()
				|| exUltMovNaoCanc.getExTipoMovimentacao().getIdTpMov() != ExTipoMovimentacao.TIPO_MOVIMENTACAO_CRIACAO
				|| exUltMovNaoCanc.getIdMov() != exUltMov.getIdMov())
			return false;
		else if (exUltMovNaoCanc.getLotaResp() != null) {
			if (!exUltMovNaoCanc.getLotaResp().equivale(lotaTitular))
				return false;
		} else if (exUltMovNaoCanc.getSubscritor() != null) {
			if (!exUltMovNaoCanc.getSubscritor().getLotacao().equivale(
					lotaTitular))
				return false;
		} else if (exUltMovNaoCanc.getTitular() != null) {
			if (!exUltMovNaoCanc.getTitular().getLotacao()
					.equivale(lotaTitular))
				return false;
		} else {
			if (!exUltMovNaoCanc.getCadastrante().getLotacao().equivale(
					lotaTitular))
				return false;
		}
		
		//N�o � poss�vel cancelar a �ltima via de um documento pois estava gerando erros nas marcas do mobil geral.
		boolean isUnicaViaNaoCancelada = true;
		for (ExMobil outroMobil : mob.getDoc().getExMobilSet()) {
			if(!outroMobil.isGeral() &&  !outroMobil.isCancelada()
					&& !outroMobil.getIdMobil().equals(mob.getIdMobil())) {
				isUnicaViaNaoCancelada = false;
				break;
			}
		}
		
		if(isUnicaViaNaoCancelada)
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_CANCELAR_VIA);
	}

	/**
	 * Retorna se � poss�vel criar via para o documento que cont�m o m�bil
	 * passado por par�metro, de acordo com as seguintes condi��es:
	 * <ul>
	 * <li>Documento tem de ser expediente</li>
	 * <li>Documento n�o pode ter pai, pois n�o � permitido criar vias em
	 * documento filho</li>
	 * <li>N�mero da �ltima via n�o pode ser maior ou igual a 21</li>
	 * <li>Documento tem de estar finalizado</li>
	 * <li>Documento n�o pode ter sido eliminado</li>
	 * <li>Documento tem de possuir alguma via n�o cancelada</li>
	 * <li>Lota��o do titular igual a do cadastrante ou a do subscritor ou 

	 * o titular ser o pr�prio subscritor</li>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception 
	 */
	public boolean podeCriarVia(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if(mob.doc().isSemEfeito())
			return false;

		if (!mob.doc().isExpediente())
			return false;
		
		if (mob.doc().isEliminado())
			return false;
			
		if (mob.doc().getExMobilPai() != null && !mob.doc().isAssinado())
			return false;

		if (mob.doc().getNumUltimaVia() >= 21)
			return false;

		if(mob.isEmTransito())
			return false;
		
		if (mob.doc().getNumUltimaViaNaoCancelada() > 0
				&& mob.doc().isFinalizado() && 
				(podeMovimentar(titular, lotaTitular, mob) 
				   || mob.doc().getLotaCadastrante().equivale(lotaTitular)				        
				   || (mob.doc().getLotaSubscritor() != null && mob.doc().getLotaSubscritor().equivale(lotaTitular))
			       || (mob.doc().getSubscritor() != null &&  mob.doc().getSubscritor().equivale(titular))) // subscritor � null para documentos externos		      
			) {

			return true;
		}

		return false;
	}

	/**
	 * Retorna se � poss�vel criar volume para o documento que cont�m o m�bil
	 * passado por par�metro, de acordo com as seguintes condi��es:
	 * <ul>
	 * <li>Documento tem de ser processo</li>
	 * <li>Processo tem de estar finalizado</li>
	 * <li>�ltimo volume tem de estar encerrado</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeCriarVolume(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!mob.doc().isProcesso())
			return false;

		if (mob.doc().getUltimoVolume() != null
				&& (mob.doc().getUltimoVolume().isEmTransito() || mob.doc()
						.getUltimoVolume().isSobrestado()))
			return false;
			
		if (mob.isArquivadoCorrente())
			return false;
		
		if (!podeMovimentar(titular, lotaTitular, mob))
			return false;
		
		if(!mob.doc().isAssinado())
			return false;
		
		if (mob.doc().isFinalizado()
				&& mob.doc().getUltimoVolume().isVolumeEncerrado()) {
			
			if(mob.doc().isEletronico() && 
					(mob.doc().getUltimoVolume().temAnexosNaoAssinados() || mob.doc().getUltimoVolume().temDespachosNaoAssinados()))
				return false;

			return true;
		}

		return false;
	}

	/**
	 * Retorna se � poss�vel encerrar um volume, dadas as seguintes condi��es:
	 * <ul>
	 * <li>M�bil tem de ser volume</li>
	 * <li>Volume n�o pode estar encerrado</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode estar spbrestado</li>
	 * <li>Volume n�o pode estar em tr�nsito</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeEncerrarVolume(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (!mob.isVolume())
			return false;

		if (mob.isVolumeEncerrado())
			return false;

		if (mob.isArquivado())
			return false;

		if (mob.isEmTransito())
			return false;
		
		if(!mob.doc().isAssinado())
			return false;

		if (mob.isSobrestado())
			return false;




		return podeMovimentar(titular, lotaTitular, mob)
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_ENCERRAMENTO_DE_VOLUME,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel reabrir um m�bil, segundo as seguintes regras:
	 * <ul>
	 * <li>M�bil tem de ser via ou geral de processo.</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil tem de estar arquivado corrente ou intermedi�rio, mas n�o permanentemente</li>
	 * <li>M�bil n�o pode estar em edital de elimina��o</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDesarquivarCorrente(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!mob.isVia() && !mob.isGeralDeProcesso())
			return false;

		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();
		if (ultMovNaoCancelada == null)
			return false;
		return podeMovimentar(titular, lotaTitular, mob)
				&& (mob.isArquivadoCorrente() || mob.isArquivadoIntermediario())
				&& !mob.isArquivadoPermanente()
				&& !mob.isEmEditalEliminacao()
				&& !mob.isEmTransito()
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESARQUIVAMENTO_CORRENTE,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel reabrir um m�bil, segundo as seguintes regras:
	 * <ul>
	 * <li>M�bil tem de ser via ou geral de processo.</li>
	 * <li>M�bil tem de estar em arquivo intermedi�rio, n�o permanente</li>
	 * <li>M�bil n�o pode estar em edital de elimina��o</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeBotaoDesarquivarIntermediario(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!mob.isVia() && !mob.isGeralDeProcesso())
			return false;

		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();
		if (ultMovNaoCancelada == null)
			return false;
		return (mob.isArquivadoIntermediario())
				&& !mob.isArquivadoPermanente()
				&& !mob.isEmEditalEliminacao()
				&& !mob.isEmTransito()
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESARQUIVAMENTO_INTERMEDIARIO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel fazer o desarquivamento intermedi�rio do m�bil, ou
	 * seja, se � poss�vel mostrar o link para movimenta��o e se, al�m disso, o
	 * m�bil encontra-se na lota��o titular ou � digital.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDesarquivarIntermediario(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return podeBotaoDesarquivarIntermediario(titular, lotaTitular, mob)
				&& (lotaTitular.equivale(mob
						.getUltimaMovimentacaoNaoCancelada().getLotaResp()) || mob
						.doc().isEletronico());
	}

	/**
	 * Retorna se � poss�vel desobrestar um m�bil, segundo as seguintes regras:
	 * <ul>
	 * <li>M�bil tem de ser via ou volume. N�o pode ser geral</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil tem de estar sobrestado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDesobrestar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (!(mob.isVia() || mob.isVolume()))
			return false;
		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();
		if (ultMovNaoCancelada == null)
			return false;
		return podeMovimentar(titular, lotaTitular, mob)
				&& (mob.isSobrestado())
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESOBRESTAR,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}	
	
	/**
	 * Retorna se � poss�vel fazer despacho no m�bil, conforme as regras a
	 * seguir:
	 * <ul>
	 * <li>M�bil n�o pode ter despacho pendente de assinatura</li>
	 * <li>M�bil tem de ser via ou volume. N�o pode ser geral</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode estar em edital de elimina��o</li>
	 * <li>M�bil tem de estar assinado ou ser externo. <b>Mas documento externo
	 * n�o � cnsiderado assinado? <i>isAssinado</i> n�o deveria retornar
	 * verdadeiro?</b></li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDespachar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		return (mob.isVia() || mob.isVolume())
				&& !mob.isEmTransito()
				&& podeMovimentar(titular, lotaTitular, mob)
				&& !mob.isJuntado()
				&& !mob.isArquivado()
				&& !mob.isEmEditalEliminacao()
				&& !mob.isSobrestado()
				&& !mob.isPendenteDeAnexacao()
				&& !mob.doc().isSemEfeito()
				&& (mob.doc().isAssinado() || (mob.doc().getExTipoDocumento()
						.getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO) || 
						(mob.doc().isProcesso() && mob.doc().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_INTERNO_ANTIGO))
				// && mob.doc().isAssinadoPorTodosOsSignatarios()
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel fazer download do conte�do. M�todo em desuso,
	 * retornando sempre <i>false</i>.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeDownloadConteudo(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		return false;
	}

	/**
	 * Retorna se � poss�vel duplicar o documento ue cont�m o m�bil mob. Basta
	 * n�o estar eliminado o documento e n�o haver configura��o impeditiva, o
	 * que significa que, tendo acesso a um documento n�o eliminado, qualquer
	 * usu�rio pode duplic�-lo.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDuplicar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (podeAcessarDocumento(titular, lotaTitular, mob))
			return true;
			

		return !mob.isEliminado()
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						CpTipoConfiguracao.TIPO_CONFIG_DUPLICAR);
	}
	
	/**
	 * Retorna se � poss�vel exibir informa��es completas.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeExibirInformacoesCompletas(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return true;
	}

	/**
	 * Retorna se � poss�vel editar um documento, conforme as seguintes regras:
	 * <ul>
	 * <li>Se o documento for f�sico, n�o pode estar finalizado</li>
	 * <li>Documento n�o pode estar cancelado</li>
	 * <li>Se o documento for digital, n�o pode estar assinado</li>
	 * <li>Usu�rio tem de ser 1) da lota��o cadastrante do documento,
	 * 2)subscritor do documento ou 3) titular do documento</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeEditar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (mob.doc().isFinalizado() && !mob.doc().isEletronico())
			return false;
		if (mob.doc().isCancelado() || mob.doc().isSemEfeito())
			return false;
		if (mob.doc().isAssinado() || mob.doc().isEletronicoEPossuiPeloMenosUmaAssinaturaDigital())
			return false;
		if (!mob.doc().getLotaCadastrante().equivale(lotaTitular)
			&& (mob.doc().getSubscritor() != null && !mob.doc().getSubscritor().equivale(titular))
			&& (mob.doc().getTitular() != null && !mob.doc().getTitular().equivale(titular))
			&& (mob.doc().getPai() != null && !(mob.doc().getPai().temTipoMovimentacaoParaPessoaNoMobil(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA, titular)
			    || mob.doc().getPai().temTipoMovimentacaoParaPessoaNoMobil(ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA, titular))))
		{	
			if(!mob.getExDocumento().temPerfil(titular, lotaTitular, ExPapel.PAPEL_GESTOR))
				return false;
		}
	
		
		if (!getConf().podePorConfiguracao(titular, lotaTitular, mob.doc().getExFormaDocumento(),
						CpTipoConfiguracao.TIPO_CONFIG_CRIAR) &&
						!getConf().podePorConfiguracao(titular, lotaTitular, mob.doc().getExModelo(),
								CpTipoConfiguracao.TIPO_CONFIG_CRIAR))
			return false;
		
		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_EDITAR);
				
	}

	/**
	 * Retorna se � poss�vel agendar publica��o direta, de acordo com as
	 * seguintes regras:
	 * <ul>
	 * <li>Documento tem de estar fechado</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>N�o pode haver agendamento de publica��o direta em aberto</li>
	 * <li>N�o pode haver agendamento de publica��o indireta em aberto</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode estar eliminado</li>
	 * <li>Nada � dito a respeito do Boletim Interno</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAgendarPublicacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (!mob.doc().isFinalizado()
				|| !mob.doc().isAssinado() 
				|| mob.doc().isPublicacaoAgendada()
				|| mob.doc().isSemEfeito()
				|| mob.doc().isEliminado()
				|| mob.isArquivado())
			return false;
		
		if (mob.isPendenteDeAnexacao())
			return false;

		if (podeAtenderPedidoPublicacao(titular, lotaTitular,null))
			return true;
		
		return (!mob.doc().isPublicacaoSolicitada()
				&& podeMovimentar(titular, lotaTitular, mob) 
				&&  getConf().podePorConfiguracao(titular,
						lotaTitular,
						mob.doc().getExModelo(),
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR));		
		
	



	}

	/**
	 * Retorna se � poss�vel fazer o agendamento de publica��o solicitada
	 * indiretamente. Basta haver permiss�o para atender pedido de publica��o e
	 * estar com publica��o indireta solicitada o documento a que pertence o
	 * m�bil passado por par�metro.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeRemeterParaPublicacaoSolicitada(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (mob.isPendenteDeAnexacao())
			return false;
		return mob.doc().isPublicacaoSolicitada()
				&& podeAtenderPedidoPublicacao(titular, lotaTitular, mob);
	}
	
	/**
	 * Retorna se � poss�vel solicitar publica��o indireta no DJE, conforme as
	 * regras a seguir:
	 * <ul>
	 * <li>N�o pode ser poss�vel agendar publica��o direta</li>
	 * <li>Documento tem de estar fechado (verifica��o desnecess�ria, visto que
	 * abaixo se checa se est� assinado)</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>N�o pode haver outra solicita��o de publica��o no DJE em aberto</li>
	 * <li>N�o pode pode haver solicita��o de publica��o no Boletim em aberto</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode estar eliminado</li>
	 * <li>N�o pode haver agendamento de publica��o direta em aberto
	 * <b>(verifica��o desnecess�ria?)</b></li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podePedirPublicacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (podeAgendarPublicacao(titular, lotaTitular, mob)){		
			return false;
		}	
		else
			return (mob.doc().isFinalizado())
					&& (podeMovimentar(titular, lotaTitular, mob) || podeAtenderPedidoPublicacao(
							titular, lotaTitular, mob))
					&& mob.doc().isAssinado()
					&& !mob.doc().isPublicacaoSolicitada()
					&& !mob.doc().isPublicacaoBoletimSolicitada()
					&& !mob.doc().isPublicacaoAgendada()
					&& !mob.doc().isSemEfeito()
					&& !mob.doc().isEliminado()
					&& !mob.isArquivado()
					&& getConf()
							.podePorConfiguracao(
									titular,
									lotaTitular,
									mob.doc().getExModelo(),
									ExTipoMovimentacao.TIPO_MOVIMENTACAO_PEDIDO_PUBLICACAO,
									CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel utilizar o recurso Criar Anexo, com base nas
	 * seguintes regras:
	 * <ul>
	 * <li>Documento tem de estar finalizado</li>
	 * <li>Documento tem de ser interno produzido</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAnexarArquivoAlternativo(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (!mob.isGeral() && !mob.doc().isAssinado())
			return false;
		
		if(mob.isGeral() && mob.doc().isAssinado())
			return false;
		
		if (mob.doc().isExpediente() && mob.doc().getPai() != null)
			return false;
		
		if (mob.doc().isProcesso() && mob.isArquivadoCorrente())
			return false;
		
		if (mob.isArquivado())
			return false;
		
		if(mob.doc().isSemEfeito())
			return false;
		
		if(mob.isSobrestado())
			return false;
		
		if(mob.isJuntado())
			return false;
		
		final boolean podeMovimentar = podeMovimentar(titular, lotaTitular, mob);
		final boolean gerenteBIE = podeGerenciarPublicacaoBoletimPorConfiguracao(
				titular, lotaTitular, mob);
		final boolean gerenteDJE = podeAtenderPedidoPublicacao(titular,
				lotaTitular, mob);
		final boolean podePorConfigAgendar = getConf().podePorConfiguracao(
				titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR)
				&& getConf()
						.podePorConfiguracao(
								mob.getExDocumento().getExModelo(),
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
		final boolean podePorConfigPedirPubl = getConf().podePorConfiguracao(
				titular, lotaTitular, mob.getExDocumento().getExModelo(),
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_PEDIDO_PUBLICACAO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
		final boolean podePorConfigAgendarBoletim = (getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						mob.getExDocumento().getExModelo(),
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO_BOLETIM,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR));

		return (mob.getExDocumento().isFinalizado())
				&& (mob.getExDocumento().getExTipoDocumento().getIdTpDoc() != ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO)				
				&& !mob.isEmTransito()
				&& podeMovimentar;

	}
	
	/**
	 * Retorna se � poss�vel, com base em configura��o, utilizar a rotina de
	 * atendimento de pedidos indiretos de publica��o no DJE. N�o � utilizado o
	 * par�metro mob.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAtenderPedidoPublicacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_ATENDER_PEDIDO_PUBLICACAO);
	}

	/**
	 * Retorna se � poss�vel excluir o documento cujo m�bil � o representado
	 * pelo par�metro mob. As regras para o documento s�o as seguintes:
	 * <ul>
	 * <li>Documento n�o pode estar finalizado, seja f�sico ou eletr�nico</li>
	 * <li>Lota��o do usu�rio tem de ser a do cadastrante do documento</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param doc
	 * @param numVia
	 * @return
	 * @throws Exception
	 */
	public boolean podeExcluir(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (mob.doc().isFinalizado())
			return false;

		if (!mob.doc().getLotaCadastrante().equivale(lotaTitular))
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_EXCLUIR);
	}

	/**
	 * Retorna se � poss�vel excluir uma movimenta��o de anexa��o, representada
	 * por mov, conforme as regras a seguir:
	 * <ul>
	 * <li>Anexa��o n�o pode estar cancelada</li>	
	 * <li>Anexo n�o pode estar assinado</li>
	 * <li>Se o documento for f�sico, n�o pode estar finalizado</li>
	 * <li>Se o documento for eletr�nico, n�o pode estar assinado</li>
	 * <li>Lota��o do usu�rio tem de ser a lota��o cadastrante da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o: Excluir
	 * Anexo</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeExcluirAnexo(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {

		if (mov.isCancelada())
			return false;
		
		if (mov.isAssinada())
			return false;

		if (mob.doc().isFinalizado() && !mob.doc().isEletronico()) {
			return false;
		}

		if (!(mov.getLotaCadastrante().equivale(lotaTitular)))
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_EXCLUIR_ANEXO);
	}
	
	/**
	 * Retorna se � poss�vel excluir uma movimenta��o de Inclus�o de Cossignat�rio 
	 * <ul>
	 * <li>N�o pode estar cancelada</li>	
	 * <li>N�o pode estar assinado</li>
	 * <li>Se o documento for f�sico, n�o pode estar finalizado</li>
	 * <li>N�o pode estar assinado</li>
	 * <li>Lota��o do usu�rio tem de ser a lota��o cadastrante da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o: Excluir
	 * Anexo</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeExcluirCosignatario(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {
		
		if (mov.isCancelada())
			return false;
		
		if (mov.isAssinada())
			return false;

		if (mob.doc().isFinalizado() && !mob.doc().isEletronico()) {
			return false;
		}

		if (!(mov.getLotaCadastrante().equivale(lotaTitular)))
			return false;

		if(mov.getExDocumento().isAssinado() || mob.doc().isEletronicoEPossuiPeloMenosUmaAssinaturaDigital())
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_EXCLUIR);
	}	

	/**
	 * Retorna se � poss�vel cancelar uma movimenta��o mov, de anexa��o de
	 * arquivo. Regras:
	 * <ul>
	 * <li>Anexa��o n�o pode estar cancelada</li>	
	 * <li>N�o pode mais ser poss�vel <i>excluir</i> a anexa��o</li>
	 * <li>Se o documento for f�sico, anexa��o n�o pode ter sido feita antes da
	 * finaliza��o</li>
	 * <li>Se o documento for digital, anexa��o n�o pode ter sido feita antes da
	 * assinatura</li>	
	 * <li>Lota��o do usu�rio tem de ser a lota��o cadastrante da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o:
	 * Cancelar Movimenta��o</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelarAnexo(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {

		if (mov.isCancelada())
			return false;
		
		if (podeExcluirAnexo(titular, lotaTitular, mob, mov))
			return false;

		Calendar calMov = new GregorianCalendar();
		Calendar cal2 = new GregorianCalendar();
		calMov.setTime(mov.getDtIniMov());

		if (mob.doc().isFinalizado() && !mob.doc().isEletronico()) {
			cal2.setTime(mob.doc().getDtFinalizacao());
			if (calMov.before(cal2))
				return false;
		}

		if (mob.doc().isAssinado()
				&& mob.doc().getExTipoDocumento().getIdTpDoc() == 1
				&& mob.doc().isEletronico()) {
			cal2.setTime(mob.doc().getDtAssinatura());
			if (calMov.before(cal2))
				return false;
		}

		if (!(mov.getLotaCadastrante().equivale(lotaTitular)))
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANEXACAO,
				CpTipoConfiguracao.TIPO_CONFIG_CANCELAR_MOVIMENTACAO);
	}

	/**
	 * Retorna se � poss�vel cancelar uma movimenta��o de vincula��o de perfil,
	 * passada atrav�s do par�metro mov. As regras s�o as seguintes:
	 * <ul>
	 * <li>Vincula��o de perfil n�o pode estar cancelada</li>
	 * <li>Lota��o do usu�rio tem de ser a lota��o cadastrante da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o:
	 * Cancelar Movimenta��o</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelarVinculacaoPapel(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {

		if (mov.isCancelada())
			return false;
		
		if ((mov.getSubscritor()!= null && mov.getSubscritor().equivale(titular))||( mov.getSubscritor()==null && mov.getLotaSubscritor().equivale(lotaTitular)))
			return true;

		if ((mov.getCadastrante()!= null && mov.getCadastrante().equivale(titular))||( mov.getCadastrante()==null && mov.getLotaCadastrante().equivale(lotaTitular)))
			return true;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				mov.getIdTpMov(),
				CpTipoConfiguracao.TIPO_CONFIG_CANCELAR_MOVIMENTACAO);
	}

	/**
	 * <b>(Quando � usado este m�todo?)</b> Retorna se � poss�vel cancelar
	 * movimenta��o do tipo despacho, representada pelo par�metro mov. S�o estas
	 * as regras:
	 * <ul>
	 * <li>Despacho n�o pode estar cancelado</li>
	 * <li>Lota��o do usu�rio tem de ser a lota��o cadastrante do despacho</li>
	 * <li>Despacho n�o pode estar assinado</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o:
	 * Cancelar Movimenta��o</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeCancelarDespacho(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {

		if (mov.isCancelada())
			return false;

		if (!(mov.getLotaCadastrante().equivale(lotaTitular)))
			return false;
		
		if(mov.isUltimaMovimentacao())
			return false;

		for (ExMovimentacao movAssinatura : mov.getExMobil()
				.getExMovimentacaoSet()) {
			if (!movAssinatura.isCancelada()
					&& movAssinatura.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO
					&& movAssinatura.getExMovimentacaoRef().getIdMov() == mov
							.getIdMov())
				return false;
		}

		return getConf().podePorConfiguracao(titular, lotaTitular,
				mov.getIdTpMov(),
				CpTipoConfiguracao.TIPO_CONFIG_CANCELAR_MOVIMENTACAO);
	}

	/**
	 * Retorna se � poss�vel excluir anota��o realizada no m�bil, passada pelo
	 * par�metro mov. As seguintes regras incidem sobre a movimenta��o a ser
	 * exclu�da:
	 * <ul>
	 * <li>N�o pode estar cancelada</li>
	 * <li>Lota��o do usu�rio tem de ser a do cadastrante ou do subscritor
	 * (respons�vel) da movimenta��o</li>
	 * <li>N�o pode haver configura��o impeditiva. Tipo de configura��o: Excluir
	 * Anota��o</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 * @throws Exception
	 */
	public boolean podeExcluirAnotacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {

		if (mov.isCancelada())
			return false;
		
		//Verifica se foi a pessoa ou lota��o que fez a anota��o
		if (!mov.getCadastrante().getIdInicial().equals(titular.getIdInicial())
				&& !mov.getSubscritor().getIdInicial().equals(titular.getIdInicial())
				&& !mov.getLotaCadastrante().getIdInicial().equals(
				lotaTitular.getIdInicial())
				&& !mov.getLotaSubscritor().getIdInicial().equals(
						lotaTitular.getIdInicial()))
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_EXCLUIR_ANOTACAO);
	}

	/**
	 * Retorna se � poss�vel exibir todos os m�bil's. Basta o documento estar
	 * finalizado.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeExibirTodasVias(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		return (mob != null && mob.doc().isFinalizado());
	}

	/**
	 * Retorna se � poss�vel fazer anota��o no m�bil. Basta o m�bil n�o estar
	 * eliminado, n�o estar em tr�nsito, n�o ser geral e n�o haver configura��o
	 * impeditiva, o que significa que, tendo acesso a um documento n�o
	 * eliminado fora de tr�nsito, qualquer usu�rio pode fazer anota��o.

	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeFazerAnotacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		return (!mob.isEmTransitoInterno() && !mob.isEliminado() && mob.isGeral())
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_ANOTACAO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel vincular perfil ao documento. Basta n�o estar
	 * eliminado o documento e n�o haver configura��o impeditiva, o que
	 * significa que, tendo acesso a um documento n�o eliminado, qualquer
	 * usu�rio pode se cadastrar como interessado.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeFazerVinculacaoPapel(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {


		if (mob.doc().isCancelado() || mob.doc().isSemEfeito()



				|| mob.isEliminado())
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_VINCULACAO_PAPEL,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel finalizar o documento ao qual o m�bil passado por
	 * par�metro pertence. S�o estas as regras:
	 * <ul>
	 * <li>Documento n�o pode estar finalizado</li>
	 * <li>Se o documento for interno produzido, usu�rio tem de ser: 1) da
	 * lota��o cadastrante do documento, 2) o subscritor do documento ou 3) o
	 * titular do documento. <b>Obs.: por que a origem do documento est� sendo
	 * considerada nesse caso?</b></li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeFinalizar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (mob.doc().isFinalizado())
			return false;
		if (lotaTitular.isFechada())
			return false;
		if (mob.isPendenteDeAnexacao())
			return false;
		if (mob.doc().getExTipoDocumento().getIdTpDoc() != 2
				&& mob.doc().getExTipoDocumento().getIdTpDoc() != 3)
			if (!mob.doc().getLotaCadastrante().equivale(lotaTitular)
					&& (mob.doc().getSubscritor() != null && !mob.doc()
							.getSubscritor().equivale(titular))
					&& (mob.doc().getTitular() != null && !mob.doc()
							.getTitular().equivale(titular))
					&& !mob.getExDocumento().temPerfil(titular, lotaTitular, ExPapel.PAPEL_GESTOR))
				return false;
		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_FINALIZAR);
	}

	/**
	 * Retorna se � poss�vel que o usu�rio finalize o documento e assine
	 * digitalmente numa �nica opera��o. Os requisitos s�o os mesmos que t�m de
	 * ser cumpridos para se poder finalizar
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeFinalizarAssinar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return podeFinalizar(titular, lotaTitular, mob)
				&& mob.doc().isEletronico();

	}

	/**
	 * Retorna se � poss�vel incluir cossignat�rio no documento que cont�m o
	 * m�bil passado por par�metro. O documento tem de atender as seguintes
	 * condi��es:
	 * <ul>
	 * <li>N�o pode estar cancelado</li>
	 * <li>Sendo documento f�sico, n�o pode estar finalizado</li>
	 * <li>Sendo documento digital, n�o pode estar assinado</li>
	 * <li>Lota��o do usu�rio tem de ser a lota��o cadastrante do documento</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeIncluirCosignatario(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (mob.doc().isCancelado())
			return false;
		if (mob.doc().isFinalizado() && !mob.doc().isEletronico())
			return false;
		if (mob.doc().isAssinado() || mob.doc().isEletronicoEPossuiPeloMenosUmaAssinaturaDigital())
			return false;
		if (!mob.doc().getLotaCadastrante().equivale(lotaTitular))
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_DE_COSIGNATARIO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel incluir o m�bil em edital de elimina��o, de acordo
	 * com as condi��es a seguir:
	 * <ul>
	 * <li>M�bil tem de ser via ou geral de processo</li>
	 * <li>M�bil tem de estar em arquivo corrente ou intermedi�rio</li>
	 * <li>PCTT tem de prever, para o m�bil, destina��o final Elimina��o</li>
	 * <li>M�bil n�o pode estar arquivado permanentemente</li>
	 * <li>Documento a que o m�bil pertence tem de ser digital ou estar na
	 * lota��o titular</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeIncluirEmEditalEliminacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!(mob.isVia() || mob.isGeralDeProcesso())
				|| mob.doc().isSemEfeito() || mob.isEliminado())
			return false;

		ExMobil mobVerif = mob;

		if (mob.isGeralDeProcesso())
			mobVerif = mob.doc().getUltimoVolume();

		return mobVerif != null
				&& (mobVerif.isArquivadoCorrente() || mobVerif
						.isArquivadoIntermediario())
				&& !mobVerif.isArquivadoPermanente()
				&& mobVerif.isDestinacaoEliminacao()
				&& (lotaTitular.equivale(mob
						.getUltimaMovimentacaoNaoCancelada().getLotaResp()) || mob
						.doc().isEletronico())
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_EM_EDITAL_DE_ELIMINACAO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel junta este m�bil a outro. Seguem as regras:
	 * <ul>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>Volume n�o pode estar encerrado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o m�bil/usu�rio</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil n�o pode estar juntado <b>(mas pode ser juntado estando
	 * apensado?)</b></li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeJuntar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!mob.isVia())
			return false;

		if (mob.isPendenteDeAnexacao())
			return false;
		
		return !mob.isCancelada()
				&& !mob.isVolumeEncerrado()
				&& !mob.isEmTransito()
				&& podeMovimentar(titular, lotaTitular, mob)

				&& mob.doc().isAssinado()
				&& !mob.isJuntado()
				&& !mob.isApensado()
				&& !mob.isArquivado()
				&& !mob.isSobrestado()
				&& !mob.doc().isSemEfeito()
				&& podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_JUNTADA,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR, null);

		// return true;
	}

	/**
	 * Retorna se � poss�vel apensar este m�bil a outro, conforme as regras:
	 * <ul>
	 * <li>M�bil precisa ser via ou volume</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>M�bil n�o pode estar em tr�nsito <b>(o que � isEmTransito?)</b></li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o m�bil/usu�rio</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeApensar(DpPessoa titular, DpLotacao lotaTitular,
			ExMobil mob) throws Exception {

		if (!mob.isVia() && !mob.isVolume())
			return false;

		return !mob.isCancelada()
				&& !mob.doc().isSemEfeito()
				&& !mob.isEmTransito()
				&& podeMovimentar(titular, lotaTitular, mob)
				&& mob.doc().isAssinado()
				&& !mob.isApensado()
				&& !mob.isJuntado()
				&& !mob.isArquivado()
				&& !mob.isSobrestado()
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_APENSACAO,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel desapensar este m�bil de outro, conforme as
	 * seguintes condi��es para o m�bil:
	 * <ul>
	 * <li>Precisa ser via ou volume</li>
	 * <li>Precisa ter movimenta��o n�o cancelada</li>
	 * <li>Precisa estar apensado</li>
	 * <li>N�o pode estar em tr�nsito <b>(o que � isEmTransito?)</b></li>
	 * <li>N�o pode estar cancelado</li>
	 * <li>N�o pode estar em algum arquivo</li>
	 * <li>N�o pode estar juntado <b>(mas pode ser juntado estando
	 * apensado?)</b></li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o m�bil/usu�rio</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDesapensar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		final ExMovimentacao ultMovNaoCancelada = mob
				.getUltimaMovimentacaoNaoCancelada();

		if (!mob.isVia() && !mob.isVolume())
			return false;

		if (ultMovNaoCancelada == null)
			return false;
		
		if(mob.doc().isEletronico() && mob.isVolumeApensadoAoProximo())
			return false;

		if (!mob.isApensado() || mob.isEmTransito() || mob.isCancelada()
				|| mob.isArquivado()
				|| !podeMovimentar(titular, lotaTitular, mob)
				|| mob.isJuntado())
			return false;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESAPENSACAO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se o usu�rio tem a permiss�o b�sica para movimentar o documento.
	 * M�todo usado como premissa para v�rias outras permiss�es de movimenta��o.
	 * Regras:
	 * <ul>
	 * <li>Se m�bil � geral, <i>podeMovimentar()</i> tem de ser verdadeiro para
	 * algum m�bil do mesmo documento</li>
	 * <li>M�bil tem de ser geral, via ou volume</li>
	 * <li>M�bil tem de de ter alguma movimenta��o n�o cancelada</li>
	 * <li><b>M�bil n�o pode estar cancelado nem aberto</b></li>
	 * <li>Usu�rio tem de ser da lota��o atendente definida na �ltima
	 * movimenta��o n�o cancelada</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 */
	public boolean podeMovimentar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {


		if (!podeSerMovimentado(mob))
			return false;

		if (mob.isGeral()) {
			for (ExMobil m : mob.doc().getExMobilSet()) {
				if (!m.isGeral() && podeMovimentar(titular, lotaTitular, m))
					return true;
			}
			return false;
		}

		final ExMovimentacao exMov = mob.getUltimaMovimentacaoNaoCancelada();
		if (exMov == null) {
			return false;
		}

		/*
		 * Orlando: Inclui a condi��o "&& !exMov.getResp().equivale(titular))"
		 * no IF ,abaixo, para permitir que um usu�rio possa transferir quando
		 * ele for o atendente do documento, mesmo que ele n�o esteja na lota��o

		 * do documento
		 */

		if (exMov.getLotaResp() != null
				&& !exMov.getLotaResp().equivale(lotaTitular)){
			return false;
		}

		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	public boolean podeSerMovimentado(final ExMobil mob) throws Exception {
		if (mob.doc().isSemEfeito())
			return false;


		if (mob.isGeral()) {
			for (ExMobil m : mob.doc().getExMobilSet()) {
				if (!m.isGeral() && podeSerMovimentado(m))
					return true;
			}
			return false;
		}
		if (!mob.isVia() && !mob.isVolume())
			return false;

		final ExMovimentacao exMov = mob.getUltimaMovimentacaoNaoCancelada();
		if (exMov == null) {
			return false;
		}
		if (mob.isCancelada() || !mob.doc().isFinalizado())
			return false;

		return true;
	}
	
	/**
	 * Retorna se o usu�rio tem � o atendente do documento. Regras:
	 * <ul>
	 * <li>Se m�bil � geral, <i>isAtendente()</i> tem de ser verdadeiro para
	 * algum m�bil do mesmo documento</li>
	 * <li>M�bil tem de ser geral, via ou volume</li>
	 * <li>M�bil tem de de ter alguma movimenta��o n�o cancelada</li>
	 * <li><b>M�bil n�o pode estar cancelado</b></li>
	 * <li>Usu�rio tem de ser da lota��o atendente definida na �ltima
	 * movimenta��o n�o cancelada, ou no documento se ainda n�o for finalizado.</li>
	 * </ul>
	 */
	public static boolean isAtendente(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (mob.isGeral()) {
			for (ExMobil m : mob.doc().getExMobilSet()) {
				if (!m.isGeral() && isAtendente(titular, lotaTitular, m))
					return true;
			}
			return false;
		}
		if (!mob.isVia() && !mob.isVolume())
			return false;

		final ExMovimentacao exMov = mob.getUltimaMovimentacaoNaoCancelada();
		if (exMov == null) {
			return false;
		}
		if (mob.isCancelada())
			return false;

		DpLotacao lot = exMov.getLotaResp();


		if (!mob.doc().isFinalizado())
			lot = mob.doc().getLotaCadastrante();

		if (lot != null && !lot.equivale(lotaTitular))
			// && !exMov.getCadastrante().getLotacao().equivale(lotaTitular))
			return false;

		return true;
	}

	public static DpResponsavel getAtendente(final ExMobil mob)
			throws Exception {
		if (mob.isGeral()) {
			for (ExMobil m : mob.doc().getExMobilSet()) {
				if (!m.isGeral() && getAtendente(m) != null)
					return getAtendente(m);
			}
			return null;
		}
		if (!mob.isVia() && !mob.isVolume())
			return null;

		final ExMovimentacao exMov = mob.getUltimaMovimentacaoNaoCancelada();
		if (exMov == null) {
			return null;
		}
		if (mob.isCancelada())
			return null;


		if (!mob.doc().isFinalizado())
			return mob.doc().getLotaCadastrante();

		DpLotacao lot = exMov.getLotaResp();
		return lot;
	}

	/**
	 * Retorna se � poss�vel refazer um documento. T�m de ser satisfeitas as
	 * seguintes condi��es:
	 * <ul>
	 * <li>Documento tem de estar finalizado</li>
	 * <li>Usu�rio tem de ser o subscritor ou o titular do documento ou ser da
	 * lota��o cadastrante do documento</li>
	 * <li>Documento n�o pode estar assinado, a n�o ser que seja dos tipos
	 * externo ou interno importado, que s�o naturalmente considerados
	 * assinados. Por�m, se for documento de um desses tipos, n�o pode haver pdf
	 * anexado <b>(verificar por qu�)</b></li>
	 * <li>Documento tem de possuir via n�o cancelada ou volume n�o cancelado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeRefazer(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		return (mob.doc().isFinalizado())
				&& ((mob.doc().getLotaCadastrante().equivale(lotaTitular)
						|| (mob.doc().getSubscritor() != null && mob.doc()
								.getSubscritor().equivale(titular)) || (mob
						.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular)))
						&& (!mob.doc().isAssinado() || (mob.doc()
								.getExTipoDocumento().getIdTpDoc() != 1L && !mob
								.doc().hasPDF())) && (mob.doc()
						.getNumUltimaViaNaoCancelada() != 0 || (mob.doc()
						.getUltimoVolume() != null && !mob.doc()
						.getUltimoVolume().isCancelada())))
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						CpTipoConfiguracao.TIPO_CONFIG_REFAZER);
	}

	/**
	 * Retorna se � poss�vel indicar um m�bil para guarda permanente. T�m de ser
	 * satisfeitas as seguintes condi��es:
	 * <ul>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil tem de ser via ou geral de processo</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode ter sido j� indicado para guarda permanente</li>
	 * <li>M�bil n�o pode ter sido arquivado permanentemente nem eliminado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeIndicarPermanente(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (mob.isPendenteDeAnexacao())
			return false;
		
		return (mob.doc().isAssinado()
				&& (mob.isVia() || mob.isGeralDeProcesso())
				&& !mob.isCancelada() && !mob.isEmTransito()
				&& !mob.isJuntado()
				&& podeMovimentar(titular, lotaTitular, mob)
				&& !mob.isindicadoGuardaPermanente()
				&& !mob.isArquivadoPermanente() && !mob.isEmEditalEliminacao() && getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_INDICACAO_GUARDA_PERMANENTE,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR));
	}

	/**
	 * Retorna se � poss�vel reclassificar um documento. T�m de ser satisfeitas
	 * as seguintes condi��es:
	 * <ul>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil tem de ser geral</li>
	 * <li>M�bil n�o pode ter sido eliminado</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 ** 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeReclassificar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		return (mob.doc().isAssinado() && mob.isGeral() && !mob.isCancelada()
				&& !mob.isEliminado() && getConf().podePorConfiguracao(titular,
				lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECLASSIFICACAO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR));
	}

	/**
	 * Retorna se � poss�vel avaliar um documento. T�m de ser satisfeitas as
	 * seguintes condi��es:
	 * <ul>
	 * <li>Documento tem de estar assinado</li>
	 * <li>M�bil tem de ser geral</li>
	 * <li>M�bil n�o pode ter sido eliminado</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAvaliar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		return (mob.doc().isAssinado() && mob.isGeral() && !mob.isCancelada()
				&& !mob.isEliminado() && getConf().podePorConfiguracao(titular,
				lotaTitular, ExTipoMovimentacao.TIPO_MOVIMENTACAO_AVALIACAO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR));
	}

	/**
	 * Retorna se � poss�vel reverter a indica��o de um m�bil para guarda
	 * permanente. T�m de ser satisfeitas as seguintes condi��es:
	 * <ul>
	 * <li>M�bil tem de estar indicado para guarda permanente</li>
	 * <li>M�bil tem de ser via ou geral de processo</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode ter sido arquivado permanentemente nem eliminado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeReverterIndicacaoPermanente(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		return (mob.isindicadoGuardaPermanente()
				&& (mob.isVia() || mob.isGeralDeProcesso()) && !mob.isJuntado()
				&& !mob.isArquivadoPermanente() && !mob.isCancelada()
				&& !mob.isEmTransito() && getConf()
				.podePorConfiguracao(
						titular,
						lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_REVERSAO_INDICACAO_GUARDA_PERMANENTE,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR));
	}

	/**
	 * Retorna se � poss�vel retirar um m�bil de edital de elimina��o. T�m de
	 * ser satisfeitas as seguintes condi��es:
	 * <ul>
	 * <li>M�bil n�o pode ter sido eliminado</li>
	 * <li>M�bil tem de estar em edital de elimina��o</li>
	 * <li>Edital contendo o m�bil precisa estar assinado</li>
	 * <li>Pessoa a fazer a retirada tem de ser o subscritor ou titular do
	 * edital</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeRetirarDeEditalEliminacao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (mob.isEliminado())
			return false;

		ExMovimentacao movInclusao = mob
				.getUltimaMovimentacaoNaoCancelada(
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_INCLUSAO_EM_EDITAL_DE_ELIMINACAO,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_RETIRADA_DE_EDITAL_DE_ELIMINACAO);

		if (movInclusao == null)
			return false;

		ExDocumento edital = movInclusao.getExMobilRef().getExDocumento();

		if (!edital.isAssinado())
			return false;

		if (edital.getSubscritor() == null)
			return lotaTitular.equivale(edital.getLotaCadastrante());
		else
			return titular.equivale(edital.getSubscritor())
					|| titular.equivale(edital.getTitular());

	}

	/**
	 * Retorna se a lota��o ou pessoa tem permiss�o para receber documento
	 * 
	 * @param pessoa
	 * @param lotacao	
	 * @return
	 * @throws Exception
	 */
	public boolean podeReceberPorConfiguracao(final DpPessoa pessoa,
			final DpLotacao lotacao) throws Exception {
		
		return getConf().podePorConfiguracao(pessoa, lotacao,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}
	
	/**
	 * Retorna se � poss�vel receber o m�bil. conforme as regras a seguir:
	 * <ul>
	 * <li>M�bil tem de ser via ou volume</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil tem de estar em tr�nsito</li>
	 * <li>Lota��o do usu�rio tem de ser a do atendente definido na �ltima
	 * movimenta��o</li>
	 * <li>Se o m�bil for eletr�nico, n�o pode estar marcado como Despacho
	 * pendente de assinatura, ou seja, m�bil em que tenha havido despacho ou
	 * despacho com transfer�ncia n�o pode ser recebido antes de assinado o
	 * despacho</li>
	 * </ul>
	 * <b>Obs.: Teoricamente, qualquer pessoa pode receber m�bil transferido
	 * para �rg�o externo</b>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeReceber(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (!(mob.isVia() || mob.isVolume()))
			return false;
		final ExMovimentacao exMov = mob.getUltimaMovimentacaoNaoCancelada();

		if (mob.isCancelada() || mob.isSobrestado() || (!mob.isEmTransito()))
			return false;
		else if (!mob.isEmTransitoExterno()) {
			if (!exMov.getLotaResp().equivale(lotaTitular))
				return false;
		}


		// Orlando: O IF abaixo foi inclu�do para n�o permitir que o documento
		// seja recebido ap�s ter sido transferido para um �rg�o externo,
		// inclusive no caso de despacho com transfer�ncia externa.
		if (mob.isEmTransitoExterno())
			return false;


		// Verifica se o despacho j� est� assinado, em caso de documentos
		// eletr�nicos
		if (mob.doc().isEletronico()) {
			for (CpMarca marca : mob.getExMarcaSet()) {
				if (marca.getCpMarcador().getIdMarcador() == CpMarcador.MARCADOR_DESPACHO_PENDENTE_DE_ASSINATURA)
					return false;
			}
		}

		return getConf().podePorConfiguracao(titular, lotaTitular,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel receber o m�bil eletronicamente, de acordo com as
	 * regras a seguir, <b>que deveriam ser parecidas com as de podeReceber(),
	 * para n�o haver incoer�ncia</b>:
	 * <ul>
	 * <li>M�bil tem de ser via ou volume</li>
	 * <li>A �ltima movimenta��o n�o cancelada do m�bil n�o pode ser
	 * transfer�ncia externa <b>(regra falha, pois pode ser feita anota��o)</b></li>
	 * <li>M�bil n�o pode estar marcado como "Despacho pendente de assinatura",
	 * ou seja, tendo havido despacho ou despacho com transfer�ncia, este
	 * precisa ter sido assinado para haver transfer�ncia</li>
	 * <li>Se houver pessoa atendente definida na �ltima movimenta��o n�o
	 * cancelada, o usu�rio tem de ser essa pessoa</li>
	 * <li>N�o havendo pessoa atendente definida na �ltima movimenta��o, apenas
	 * lota��o atendente, a lota��o do usu�rio tem de ser essa</li>
	 * <li>Documento tem de ser eletr�nico <b>(melhor se fosse verificado no
	 * in�cio)</b></li>
	 * <li>M�bil tem de estar em tr�nsito <b>(melhor se fosse verificado no
	 * in�cio)</b></li>
	 * <li>N�o pode haver configura��o impeditiva para recebimento (n�o para
	 * recebimento eletr�nico)</li>
	 * </ul>
	 * 
	 * @param cadastrante
	 * @param lotaCadastrante
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeReceberEletronico(DpPessoa cadastrante,
			DpLotacao lotaCadastrante, final ExMobil mob) throws Exception {
		if (!(mob.isVia() || mob.isVolume()))
			return false;
		ExMovimentacao ultMov = mob.getUltimaMovimentacaoNaoCancelada();
		if (ultMov == null)
			return false;
		if (ultMov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA_EXTERNA
				|| ultMov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA_EXTERNA)
			return false;
		// Verifica se o despacho j� est� assinado
		for (CpMarca marca : mob.getExMarcaSet()) {
			if (marca.getCpMarcador().getIdMarcador() == CpMarcador.MARCADOR_DESPACHO_PENDENTE_DE_ASSINATURA)
				return false;
		}

		if ((ultMov.getResp() != null && !ultMov.getResp()
				.equivale(cadastrante))
				|| (ultMov.getResp() == null && ultMov.getLotaResp() != null && !ultMov
						.getLotaResp().equivale(lotaCadastrante)))
			return false;
		if (!mob.doc().isEletronico() || !mob.isEmTransito())
			return false;
		return getConf().podePorConfiguracao(cadastrante, lotaCadastrante,
				ExTipoMovimentacao.TIPO_MOVIMENTACAO_RECEBIMENTO,
				CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel vincular este m�bil a outro, conforme as regras:
	 * <ul>
	 * <li>M�bil tem de ser via ou volume</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o m�bil/usu�rio</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode estar cancelado</li>
	 * <li>M�bil n�o pode ter sido eliminado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeReferenciar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!(mob.isVia() || mob.isVolume()))
			return false;

		return !mob.isEmTransito()
				&& podeMovimentar(titular, lotaTitular, mob)
				&& !mob.isJuntado()
				&& !mob.isEliminado()
				&& !mob.doc().isCancelado()
				&& !mob.doc().isSemEfeito()
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_REFERENCIA,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);

		// return true;
	}

	/**
	 * Retorna se � poss�vel registrar assinatura manual de documento que cont�m
	 * o m�bil passado por par�metro. As regras s�o as seguintes:
	 * <ul>
	 * <li>M�bil tem de ser geral</li>
	 * <li>N�o pode ser m�bil de processo interno importado</li>
	 * <li>N�o pode ser m�bil de documento externo</li>
	 * <li>Documento n�o pode estar cancelado</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro ou usu�rio tem de ser o
	 * pr�prio subscritor ou titular do documento</li>
	 * <li>Documento n�o pode ser eletr�nico</li>
	 * <li>Documento tem de estar finalizado</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>M�bil n�o pode ter sido eliminado</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeRegistrarAssinatura(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (!mob.isGeral())
			return false;
		if (mob.isArquivado() || mob.isEliminado())
			return false;
		if (mob.getExDocumento().isProcesso()
				&& mob.getExDocumento().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_INTERNO_ANTIGO)
			return false;
		if (mob.doc().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO
				|| mob.doc().isCancelado())
			return false;
		return ((mob.doc().getSubscritor() != null && mob.doc().getSubscritor()
				.equivale(titular))
				|| (mob.doc().getTitular() != null && mob.doc().getTitular()
						.equivale(titular)) || podeMovimentar(titular,
				lotaTitular, mob))
				/*
				 * || (ultMovNaoCancelada .getExEstadoDoc().getIdEstadoDoc() ==
				 * ExEstadoDoc.ESTADO_DOC_EM_ANDAMENTO || ultMovNaoCancelada
				 * .getExEstadoDoc().getIdEstadoDoc() ==
				 * ExEstadoDoc.ESTADO_DOC_PENDENTE_DE_ASSINATURA)
				 */
				&& !mob.doc().isEletronico()

				&& (mob.doc().isFinalizado())
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_REGISTRO_ASSINATURA_DOCUMENTO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel agendar publica��o no Boletim. � necess�rio que n�o
	 * sejam ainda 17 horas e que <i>podeBotaoAgendarPublicacaoBoletim()</i>
	 * seja verdadeiro para este m�bil e usu�rio.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAgendarPublicacaoBoletim(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		GregorianCalendar agora = new GregorianCalendar();
		agora.setTime(new Date());
		return podeBotaoAgendarPublicacaoBoletim(titular, lotaTitular, mob)
				&& agora.get(Calendar.HOUR_OF_DAY) < 17;
	}

	/**
	 * Retorna se � poss�vel exibir a op��o para agendar publica��o no Boletim.
	 * Seguem as regras:
	 * <ul>
	 * <li>M�bil n�o pode ser geral</li>
	 * <li>Documento tem de estar finalizado</li>
	 * <li>Documento tem de ser do tipo interno produzido</li>
	 * <li><i>podeGerenciarPublicacaoBoletimPorConfiguracao()</i> ou
	 * <i>podeMovimentar()</i>tem de ser verdadeiro para o usu�rio</li>
	 * <li>Documento n�o pode j� ter sido publicado em boletim</li>
	 * <li>Publica��o no boletim n�o pode ter sido j� agendada para o documento</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>Documento n�o pode ter sido eliminado</li>
	 * <li>M�bil n�o pode estar em algum arquivo</li>
	 * <li>N�o pode haver configura��o impeditiva</li>
	 * 
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeBotaoAgendarPublicacaoBoletim(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (!mob.isGeral())
			return false;

		if (!mob.doc().isFinalizado())
			return false;
		if (mob.doc().isEliminado())
			return false;
		if (mob.doc().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO)
			return false;
		if (mob.doc().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_INTERNO_ANTIGO)
			return false;
		boolean gerente = podeGerenciarPublicacaoBoletimPorConfiguracao(
				titular, lotaTitular, mob);
		return (podeMovimentar(titular, lotaTitular, mob) || gerente)
				// && !mob.doc().isEletronico()
				&& !mob.doc().isBoletimPublicado()
				&& mob.doc().isAssinado()
				&& !mob.doc().isPublicacaoBoletimSolicitada()
				&& !mob.isArquivado()
				&& (getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								mob.doc().getExModelo(),
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_AGENDAMENTO_DE_PUBLICACAO_BOLETIM,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR) || gerente);
	}

	/**
	 * Retorna se � poss�vel alterar o n�vel de accesso do documento. �
	 * necess�rio apenas que o usu�rio possa acessar o documento e que n�o haja
	 * configura��o impeditiva. <b>Obs.: N�o � verificado se
	 * <i>podeMovimentar()</i></b>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeRedefinirNivelAcesso(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if(mob.doc().isBoletimPublicado() || mob.doc().isDJEPublicado()) {
			if(podeAtenderPedidoPublicacao(titular, lotaTitular, mob) || podeGerenciarPublicacaoBoletimPorConfiguracao(titular, lotaTitular, mob))
				return true;
			
			return false;
		}


		return !mob.isEliminado()
				&& podeAcessarDocumento(titular, lotaTitular, mob)
				&& podeMovimentar(titular, lotaTitular, mob)
				&& getConf()
						.podePorConfiguracao(
								titular,
								lotaTitular,
								ExTipoMovimentacao.TIPO_MOVIMENTACAO_REDEFINICAO_NIVEL_ACESSO,
								CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}

	/**
	 * Retorna se � poss�vel que algum m�bil seja juntado a este, segundo as
	 * seguintes regras:
	 * <ul>
	 * <li>N�o pode estar cancelado</li>
	 * <li>Volume n�o pode estar encerrado</li>
	 * <li>N�o pode estar em algum arquivo</li>
	 * <li>N�o pode estar juntado</li>
	 * <li>N�o pode estar em tr�nsito</li>
	 * <li><i>podeMovimentar()</i> precisa retornar verdadeiro para ele</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeSerJuntado(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		return !mob.isCancelada() && !mob.isVolumeEncerrado()
				&& mob.doc().isAssinado() && !mob.isJuntado()
				&& !mob.isEmTransito() && !mob.isArquivado()
				&& podeMovimentar(titular, lotaTitular, mob);
	}

	/**
	 * Retorna se � poss�vel a uma lota��o, com base em configura��o, receber
	 * m�bil de documento n�o assinado. N�o � aqui verificado se o m�bil est�
	 * realmente pendente de assinatura
	 * 
	 * @param pessoa
	 * @param lotacao
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeReceberDocumentoSemAssinatura(final DpPessoa pessoa,
			final DpLotacao lotacao, final ExMobil mob) throws Exception {
		return getConf().podePorConfiguracao(pessoa, lotacao,
				CpTipoConfiguracao.TIPO_CONFIG_RECEBER_DOC_NAO_ASSINADO);
	}

	/**
	 * Retorna se � poss�vel fazer transfer�ncia. As regras s�o as seguintes
	 * para este m�bil: <ul <li>Precisa ser via ou volume (n�o pode ser geral)</li>
	 * <li>N�o pode estar em tr�nsito</li> <li>N�o pode estar juntado.</li> <li>
	 * N�o pode estar em arquivo permanente.</li> <li><i>podeMovimentar()</i>
	 * precisa retornar verdadeiro para ele</li> <li>N�o pode haver configura��o
	 * impeditiva</li> </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeTransferir(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if(!podeSerTransferido(mob))
			return false;

		return podeMovimentar(titular, lotaTitular, mob)
				&& getConf().podePorConfiguracao(titular, lotaTitular,
						ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA,
						CpTipoConfiguracao.TIPO_CONFIG_MOVIMENTAR);
	}
	
	public boolean podeSerTransferido(final ExMobil mob) throws Exception {
		if (mob.isPendenteDeAnexacao())
			return false;

		return (mob.isVia() || mob.isVolume())
				&& !mob.isEmTransito() && !mob.isJuntado()
				&& !mob.isArquivado()
				&& (mob.doc().isAssinado() || (mob.doc().getExTipoDocumento()
						.getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_EXTERNO) || 
						(mob.doc().isProcesso() && mob.doc().getExTipoDocumento().getIdTpDoc() == ExTipoDocumento.TIPO_DOCUMENTO_INTERNO_ANTIGO))
				&& !mob.isEmEditalEliminacao()
				&& !mob.isSobrestado()
				&& !mob.doc().isSemEfeito()
				&& podeSerMovimentado(mob);
		// return true;
	}


	/**
	 * Retorna se � poss�vel fazer vincula��o deste mobil a outro, conforme as
	 * seguintes regras para <i>este</i> m�bil:
	 * <ul>
	 * <li>Precisa ser via ou volume (n�o pode ser geral)</li>
	 * <li>N�o pode estar em tr�nsito</li>
	 * <li>N�o pode estar juntado.</li>
	 * <li><i>podeMovimentar()</i> precisa retornar verdadeiro para ele</li>
	 * </ul>
	 * N�o � levada em conta, aqui, a situa��o do mobil ao qual se pertende
	 * vincular.
	 * 
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeVincular(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {

		if (!(mob.isVia() || mob.isVolume()))
			return false;

		return !mob.isEmTransito() && podeMovimentar(titular, lotaTitular, mob)
				&& !mob.isJuntado();

		// return true;

	}


	public boolean podeCancelarVinculacaoDocumento(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob,
			final ExMovimentacao mov) throws Exception {

		if (mov.isCancelada())
			return false;


		if ((mov.getCadastrante() != null && mov.getCadastrante().equivale(
				titular))
				|| (mov.getCadastrante() == null && mov.getLotaCadastrante()
						.equivale(lotaTitular)))
			return true;


		if ((mov.getSubscritor() != null && mov.getSubscritor().equivale(
				titular))
				|| (mov.getSubscritor() == null && mov.getLotaSubscritor()
						.equivale(lotaTitular)))
			return true;


		if ((mov.getLotaSubscritor().equivale(lotaTitular)))
			return true;

		return getConf().podePorConfiguracao(titular, lotaTitular,
				mov.getIdTpMov(),
				CpTipoConfiguracao.TIPO_CONFIG_CANCELAR_MOVIMENTACAO);
	}

	/**
	 * Retorna se � poss�vel visualizar impress�o do m�bil. Sempre retorna
	 * <i>true</i>, a n�o ser que o documento esteja finalizado e o mobil em
	 * quest�o n�o seja via ou volume. isso impede que se visualize impress�o do
	 * mobil geral ap�s a finaliza��o.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeVisualizarImpressao(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		if (!mob.isVia() && !mob.isVolume() && mob.doc().isFinalizado())

			return false;
		return !mob.isEliminado();/*
								 * if ((mob.doc().getConteudo() == null ||
								 * ExCompetenciaBL.viaCancelada(titular,
								 * lotaTitular, doc, numVia))) return false;

								 * return true;
								 */
	}

	/**
	 * Retorna se � poss�vel visualizar impress�o do documento em quest�o e de
	 * todos os filhos, com base na permiss�o para visualiza��o da impress�o de
	 * cada um dos filhos.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public boolean podeVisualizarImpressaoCompleta(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) {
		Set<ExDocumento> filhos = mob.getExDocumentoFilhoSet();
		return podeVisualizarImpressao(titular, lotaTitular, mob)
				&& filhos != null && filhos.size() > 0;
	}

	/*
	 * public boolean podeAtenderPedidoPublicacaoPorConfiguracao( DpPessoa
	 * titular, DpLotacao lotaTitular, final ExMobil mob) throws Exception { if
	 * (lotaTitular == null) return false; return
	 * getConf().podePorConfiguracao(titular, lotaTitular,
	 * CpTipoConfiguracao.TIPO_CONFIG_ATENDER_PEDIDO_PUBLICACAO); }
	 */

	/**
	 * Retorna se � poss�vel, com base em configura��o, utilizar rotina para
	 * redefini��o de permiss�es de publica��o no DJE. N�o � utilizado o
	 * par�metro mob. <b>Aten��o: M�todo em desuso.</b>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeDefinirPublicadoresPorConfiguracao(DpPessoa titular,
			DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		if (lotaTitular == null)
			return false;
		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_DEFINIR_PUBLICADORES);

	}

	/**
	 * Retorna se � poss�vel, com base em configura��o, utilizar rotina para
	 * redefini��o de permiss�es de publica��o no Boletim. N�o � utilizado o
	 * par�metro mob.
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeGerenciarPublicacaoBoletimPorConfiguracao(
			DpPessoa titular, DpLotacao lotaTitular, final ExMobil mob)
			throws Exception {
		if (lotaTitular == null)
			return false;
		return getConf().podePorConfiguracao(titular, lotaTitular,
				CpTipoConfiguracao.TIPO_CONFIG_GERENCIAR_PUBLICACAO_BOLETIM);
	}

	/**
	 * M�todo gen�rico que recebe fun��o por String e concatena com o m�todo de
	 * checagem de permiss�o correspondente. Por exemplo, para a fun��o juntar,
	 * � invocado <i>podeJuntar()</i>
	 * 
	 * @param funcao
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 */
	public static boolean testaCompetencia(final String funcao,
			final DpPessoa titular, final DpLotacao lotaTitular,
			final ExMobil mob) {
		final Class[] classes = new Class[] { DpPessoa.class, DpLotacao.class,
				ExMobil.class };
		Boolean resposta = false;
		try {
			final Method method = ExCompetenciaBL.class.getDeclaredMethod(
					"pode" + funcao.substring(0, 1).toUpperCase()
							+ funcao.substring(1), classes);
			resposta = (Boolean) method.invoke(Ex.getInstance().getComp(),
					new Object[] { titular, lotaTitular, mob });
		} catch (final Exception e) {
			e.printStackTrace();
		}

		return resposta.booleanValue();
	}

	/**
	 * M�todo gen�rico que recebe fun��o por String e concatena com o m�todo de
	 * checagem de permiss�o correspondente. Por exemplo, para a fun��o
	 * excluirAnexo, � invocado <i>podeExcluirAnexo()</i>
	 * 
	 * @param funcao
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @param mov
	 * @return
	 */
	public static boolean testaCompetenciaMov(final String funcao,
			final DpPessoa titular, final DpLotacao lotaTitular,
			final ExMobil mob, final ExMovimentacao mov) {
		final Class[] classes = new Class[] { DpPessoa.class, DpLotacao.class,
				ExMobil.class, ExMovimentacao.class };
		Boolean resposta = false;
		try {
			/*
			 * final Method method = ExCompetenciaBL.class.getDeclaredMethod(
			 * "pode" + funcao.substring(0, 1).toUpperCase() +
			 * funcao.substring(1), classes);
			 */
			ExCompetenciaBL comp = Ex.getInstance().getComp();
			final Method method = comp.getClass().getDeclaredMethod(
					"pode" + funcao.substring(0, 1).toUpperCase()
							+ funcao.substring(1), classes);

			resposta = (Boolean) method.invoke(comp, new Object[] { titular,
					lotaTitular, mob, mov });
		} catch (final Exception e) {
			e.printStackTrace();
		}

		return resposta.booleanValue();
	}


	/**
	 * 
	 */
	public boolean podeDesfazerCancelamentoDocumento(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {


		ExDocumento documento = mob.getDoc();


		if (documento.isEletronico()
				&& documento.isCancelado()
				&& (documento.getLotaCadastrante().equivale(lotaTitular) || documento
						.getSubscritor().equivale(titular)))
			return true;


		return false;
	}


	/**
	 * 
	 */
	public boolean podeReiniciarNumeracao(ExDocumento doc) throws Exception {
		if (doc == null || doc.getOrgaoUsuario() == null
				|| doc.getExFormaDocumento() == null)
			return false;

		return getConf().podePorConfiguracao(doc.getOrgaoUsuario(),
				doc.getExFormaDocumento(),
				CpTipoConfiguracao.TIPO_CONFIG_REINICIAR_NUMERACAO_TODO_ANO);
	}


	/**


	 * Retorna se � poss�vel autuar um expediente, com base nas seguintes
	 * regras:
	 * <ul>
	 * <li>Documento tem de ser expediente</li>
	 * <li>Documento tem de estar assinado</li>
	 * <li>Documento n�o pode estar sem efeito</li>
	 * <li>M�bil n�o pode ser geral</li>
	 * <li>M�bil n�o pode estar em edital de elimina��o</li>
	 * <li>M�bil n�o pode estar juntado</li>
	 * <li>M�bil n�o pode estar apensado</li>
	 * <li>M�bil n�o pode estar em tr�nsito</li>
	 * <li>M�bil n�o pode estar arquivado permanentemente</li>
	 * <li><i>podeMovimentar()</i> tem de ser verdadeiro para o usu�rio / m�bil</li>
	 * </ul>
	 * 
	 * @param titular
	 * @param lotaTitular
	 * @param mob
	 * @return
	 * @throws Exception
	 */
	public boolean podeAutuar(final DpPessoa titular,
			final DpLotacao lotaTitular, final ExMobil mob) throws Exception {
		
		if (mob.isPendenteDeAnexacao())
			return false;

		if (mob.doc().isSemEfeito())
			return false;

		if (mob.isEmEditalEliminacao() || mob.isArquivadoPermanente())
			return false;

		if (mob.isJuntado())
			return false;

		if (mob.isApensado())
			return false;
			
		if(mob.isArquivado())
			return false;
		
		if(mob.isSobrestado())
			return false;
			
		final boolean podeMovimentar = podeMovimentar(titular, lotaTitular, mob);

		return (!mob.isGeral() && mob.doc().isExpediente()
				&& mob.doc().isAssinado() && !mob.isEmTransito() && podeMovimentar);

	}}
