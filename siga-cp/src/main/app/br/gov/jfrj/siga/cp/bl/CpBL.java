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
package br.gov.jfrj.siga.cp.bl;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;

import sun.misc.BASE64Encoder;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.Correio;
import br.gov.jfrj.siga.base.Criptografia;
import br.gov.jfrj.siga.base.GeraMessageDigest;
import br.gov.jfrj.siga.base.util.CPFUtils;
import br.gov.jfrj.siga.base.util.MatriculaUtils;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpIdentidade;
import br.gov.jfrj.siga.cp.CpModelo;
import br.gov.jfrj.siga.cp.CpPerfil;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoIdentidade;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;

public class CpBL {

	CpCompetenciaBL comp;

	public CpCompetenciaBL getComp() {
		return comp;
	}

	public void setComp(CpCompetenciaBL comp) {
		this.comp = comp;
	}

	private CpDao dao() {
		return comp.getConfiguracaoBL().dao();
	}

	public CpIdentidade alterarIdentidade(CpIdentidade ident, Date dtExpiracao,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {
		try {
			Date dt = dao().consultarDataEHoraDoServidor();
			CpIdentidade idNova = new CpIdentidade();
			try {
				PropertyUtils.copyProperties(idNova, ident);
			} catch (Exception e) {
				throw new AplicacaoException(
						"Erro ao copiar as propriedades da identidade anterior.");
			}
			idNova.setIdIdentidade(null);
			idNova.setDtExpiracaoIdentidade(dtExpiracao);

			dao().iniciarTransacao();
			CpIdentidade id = (CpIdentidade) dao().gravarComHistorico(idNova,
					ident, dt, identidadeCadastrante);
			dao().commitTransacao();
			return id;
		} catch (Exception e) {
			dao().rollbackTransacao();
			throw new AplicacaoException(
					"N�o foi poss�vel cancelar a identidade.", 9, e);
		}
	}

	public void cancelarIdentidade(CpIdentidade ident,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {
		try {
			Date dt = dao().consultarDataEHoraDoServidor();
			CpIdentidade idNova = new CpIdentidade();
			try {
				PropertyUtils.copyProperties(idNova, ident);
			} catch (Exception e) {
				throw new AplicacaoException(
						"Erro ao copiar as propriedades da identidade anterior.");
			}
			idNova.setIdIdentidade(null);
			idNova.setDtCancelamentoIdentidade(dt);
			idNova.setHisDtFim(dt);
			dao().iniciarTransacao();
			dao().gravarComHistorico(idNova, ident, dt, identidadeCadastrante);
			dao().commitTransacao();
		} catch (Exception e) {
			dao().rollbackTransacao();
			throw new AplicacaoException(
					"N�o foi poss�vel cancelar a identidade.", 9, e);
		}
	}

	public void bloquearIdentidade(CpIdentidade ident,
			CpIdentidade identidadeCadastrante, boolean fBloquear)
			throws AplicacaoException {
		CpTipoConfiguracao tpConf = dao().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_FAZER_LOGIN,
				CpTipoConfiguracao.class, false);
		Date dt = dao().consultarDataEHoraDoServidor();

		CpConfiguracao confOld = null;
		try {
			CpConfiguracao confFiltro = new CpConfiguracao();
			confFiltro.setCpIdentidade(ident);
			confFiltro.setCpTipoConfiguracao(tpConf);
			confOld = comp.getConfiguracaoBL().buscaConfiguracao(confFiltro,
					new int[] { 0 }, null);
			if (confOld.getCpIdentidade() == null)
				confOld = null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		CpConfiguracao conf = new CpConfiguracao();
		conf.setCpIdentidade(ident);
		conf.setCpSituacaoConfiguracao(dao()
				.consultar(
						fBloquear ? CpSituacaoConfiguracao.SITUACAO_NAO_PODE
								: CpSituacaoConfiguracao.SITUACAO_IGNORAR_CONFIGURACAO_ANTERIOR,
						CpSituacaoConfiguracao.class, false));
		conf.setCpTipoConfiguracao(tpConf);
		conf.setHisDtIni(dt);

		dao().iniciarTransacao();
		if (confOld != null) {
			confOld.setHisDtFim(dt);
			dao().gravarComHistorico(confOld, identidadeCadastrante);
		}
		dao().gravarComHistorico(conf, identidadeCadastrante);
		dao().commitTransacao();
		try {
			comp.getConfiguracaoBL().limparCache(tpConf);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void bloquearPessoa(DpPessoa pes,
			CpIdentidade identidadeCadastrante, boolean fBloquear)
			throws AplicacaoException {
		CpTipoConfiguracao tpConf = dao().consultar(
				CpTipoConfiguracao.TIPO_CONFIG_FAZER_LOGIN,
				CpTipoConfiguracao.class, false);
		Date dt = dao().consultarDataEHoraDoServidor();

		CpConfiguracao confOld = null;
		try {
			CpConfiguracao confFiltro = new CpConfiguracao();
			confFiltro.setDpPessoa(pes);
			confFiltro.setCpTipoConfiguracao(tpConf);
			confOld = comp.getConfiguracaoBL().buscaConfiguracao(confFiltro,
					new int[] { 0 }, null);
		} catch (Exception e) {
			e.printStackTrace();
		}

		CpConfiguracao conf = new CpConfiguracao();
		conf.setDpPessoa(pes);
		conf.setCpSituacaoConfiguracao(dao()
				.consultar(
						fBloquear ? CpSituacaoConfiguracao.SITUACAO_NAO_PODE
								: CpSituacaoConfiguracao.SITUACAO_IGNORAR_CONFIGURACAO_ANTERIOR,
						CpSituacaoConfiguracao.class, false));
		conf.setCpTipoConfiguracao(tpConf);
		conf.setHisDtIni(dt);

		dao().iniciarTransacao();
		if (confOld != null) {
			confOld.setHisDtFim(dt);
			dao().gravarComHistorico(confOld, identidadeCadastrante);
		}
		dao().gravarComHistorico(conf, identidadeCadastrante);
		dao().commitTransacao();

		for (CpIdentidade ident : dao().consultaIdentidades(pes)) {
			if (fBloquear && ident.isBloqueada() == false)
				bloquearIdentidade(ident, identidadeCadastrante, true);
		}

		try {
			comp.getConfiguracaoBL().limparCache(tpConf);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void configurarAcesso(CpPerfil perfil, CpOrgaoUsuario orgao,
			DpLotacao lotacao, DpPessoa pes, CpServico servico,
			CpSituacaoConfiguracao situacao, CpTipoConfiguracao tpConf,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {
		Date dt = dao().consultarDataEHoraDoServidor();

		CpConfiguracao confOld = null;
		try {
			CpConfiguracao confFiltro = new CpConfiguracao();
			confFiltro.setCpGrupo(perfil);
			confFiltro.setDpPessoa(pes);
			confFiltro.setLotacao(lotacao);
			confFiltro.setOrgaoUsuario(orgao);
			confFiltro.setCpServico(servico);
			confFiltro.setCpTipoConfiguracao(tpConf);
			confOld = comp.getConfiguracaoBL().buscaConfiguracao(confFiltro,
					new int[] { 0 }, null);
			if (confOld != null && !confOld.isEspecifica(confFiltro))
				confOld = null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		CpConfiguracao conf = new CpConfiguracao();
		conf.setCpGrupo(perfil);
		conf.setDpPessoa(pes);
		conf.setLotacao(lotacao);
		conf.setOrgaoUsuario(orgao);
		conf.setCpServico(servico);
		conf.setCpSituacaoConfiguracao(situacao);
		conf.setCpTipoConfiguracao(tpConf);
		conf.setHisDtIni(dt);

		dao().iniciarTransacao();
		if (confOld != null) {
			confOld.setHisDtFim(dt);
			dao().gravarComHistorico(confOld, identidadeCadastrante);
		}
		dao().gravarComHistorico(conf, identidadeCadastrante);
		dao().commitTransacao();

		try {
			comp.getConfiguracaoBL().limparCache(tpConf);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Altera a senha da identidade.
	 * 
	 * @param matricula
	 * @param cpf
	 * @param idCadastrante
	 * @param senhaGerada
	 *            - Usado para retornar a senha gerada. � um array para que o
	 *            valor seja passado como refer�ncia e o m�todo que o chama
	 *            tenha a oportunidade de conhecer a senha)
	 * @return
	 * @throws AplicacaoException
	 */
	public CpIdentidade alterarSenhaDeIdentidade(String matricula, String cpf,
			CpIdentidade idCadastrante, String[] senhaGerada)
			throws AplicacaoException {
		final long longmatricula = Long.parseLong(matricula.substring(2));
		final DpPessoa pessoa = dao().consultarPorCpfMatricula(
				Long.parseLong(cpf), longmatricula);

		if (pessoa != null && pessoa.getSigla().equals(matricula)
				&& pessoa.getEmailPessoaAtual() != null) {

			// final Usuario usuario =
			// dao().consultaUsuarioCadastrante(matricula);

			CpIdentidade id = dao().consultaIdentidadeCadastrante(matricula,
					true);
			if (id != null) {
				final String novaSenha = GeraMessageDigest.geraSenha();
				if (senhaGerada != null) {
					senhaGerada[0] = novaSenha;
				}
				try {
					Date dt = dao().consultarDataEHoraDoServidor();
					CpIdentidade idNova = new CpIdentidade();
					PropertyUtils.copyProperties(idNova, id);
					idNova.setIdIdentidade(null);
					idNova.setDtCancelamentoIdentidade(null);
					idNova.setDtCriacaoIdentidade(dt);

					final String hashNova = GeraMessageDigest.executaHash(
							novaSenha.getBytes(), "MD5");
					idNova.setDscSenhaIdentidade(hashNova);

					BASE64Encoder encoderBase64 = new BASE64Encoder();
					String chave = encoderBase64.encode(id.getDpPessoa()
							.getIdInicial().toString().getBytes());
					String senhaCripto = encoderBase64.encode(Criptografia
							.criptografar(novaSenha, chave));
					idNova.setDscSenhaIdentidadeCripto(null);
					idNova.setDscSenhaIdentidadeCriptoSinc(null);

					dao().iniciarTransacao();
					dao().gravarComHistorico(idNova, id, dt, idCadastrante);
					dao().commitTransacao();
					Correio.enviar(
							pessoa.getEmailPessoaAtual(),
							"Altera��o de senha ",
							"\n"
									+ idNova.getDpPessoa().getNomePessoa()
									+ "\nMatricula: "
									+ idNova.getDpPessoa().getSigla()
									+ "\n"
									+ "\nSua senha foi alterada para: "
									+ novaSenha
									+ "\n\n Aten��o: esta � uma "
									+ "mensagem autom�tica. Por favor, n�o responda. ");

					return idNova;
				} catch (final Exception e) {
					dao().rollbackTransacao();
					throw new AplicacaoException(
							"Ocorreu um erro durante a grava��o", 0, e);
				}
			} else {
				throw new AplicacaoException(
						"Este usu�rio n�o est� cadastrado no sistema");
			}

		} else {
			if(pessoa == null) {
				throw new AplicacaoException(
						"N�o foi encontrado usu�rio com matr�cula e cpf informados.");
			} else if (pessoa.getEmailPessoaAtual() == null) {
				throw new AplicacaoException(
						"Este usu�rio n�o possui e-mail cadastrado");
			} else {
				throw new AplicacaoException("Dados Incorretos!");
			}
		}
	}

	public CpIdentidade criarIdentidade(String matricula, String cpf,
			CpIdentidade idCadastrante, final String senhaDefinida,
			String[] senhaGerada, boolean marcarParaSinc)
			throws AplicacaoException {

		final long longMatricula = MatriculaUtils.getParteNumerica(matricula);
		Long longCpf = CPFUtils.getLongValueValidaSimples(cpf);

		final DpPessoa pessoa = dao().consultarPorCpfMatricula(longCpf,
				longMatricula);

		if (pessoa != null && matricula.equals(pessoa.getSigla())) {
			CpIdentidade id;
			try {
				id = dao().consultaIdentidadeCadastrante(matricula, true);
			} catch (Exception e1) {
				id = null;
			}
			if (id == null) {
				if (pessoa.getEmailPessoaAtual() != null) {
					String novaSenha = null;
					if (senhaDefinida != null && senhaDefinida.length() > 0) {
						novaSenha = senhaDefinida;
					} else {
						novaSenha = GeraMessageDigest.geraSenha();
					}

					if (senhaGerada != null) {
						senhaGerada[0] = novaSenha;
					}
					try {
						CpIdentidade idNova = new CpIdentidade();
						final String hashNova = GeraMessageDigest.executaHash(
								novaSenha.getBytes(), "MD5");
						idNova.setDscSenhaIdentidade(hashNova);
						idNova.setNmLoginIdentidade(matricula);
						idNova.setDpPessoa(pessoa);
						idNova.setDtCriacaoIdentidade(dao()
								.consultarDataEHoraDoServidor());
						idNova.setCpOrgaoUsuario(pessoa.getOrgaoUsuario());
						idNova.setCpTipoIdentidade(dao().consultar(1,
								CpTipoIdentidade.class, false));
						idNova.setHisDtIni(idNova.getDtCriacaoIdentidade());

						dao().iniciarTransacao();
						dao().gravarComHistorico(idNova, idCadastrante);
						Correio.enviar(
								pessoa.getEmailPessoaAtual(),
								"Novo Usu�rio",
								"Seu login �: "
										+ matricula
										+ "\n e sua senha � "
										+ novaSenha
										+ "\n\n Aten��o: esta � uma "
										+ "mensagem autom�tica. Por favor n�o responda ");
						dao().commitTransacao();
						return idNova;
					} catch (final Exception e) {
						dao().rollbackTransacao();
						throw new AplicacaoException(
								"Ocorreu um erro durante a grava��o no banco de dados ou no envio do email",
								0, e);
					}
				} else {
					throw new AplicacaoException(
							"Este usu�rio n�o possui e-mail cadastrado");
				}

			} else {
				throw new AplicacaoException(
						"Usu�rio j� est� cadastrado no sistema");
			}

		} else {
			throw new AplicacaoException("Dados Incorretos!");
		}

	}

	public CpIdentidade trocarSenhaDeIdentidade(String senhaAtual,
			String senhaNova, String senhaConfirma, String nomeUsuario,
			CpIdentidade idCadastrante) throws NoSuchAlgorithmException,
			AplicacaoException {
		if (senhaAtual == null || senhaAtual.trim().length() == 0) {
			throw new AplicacaoException("Senha atual n�o confere");
		}
		final String hashAtual = GeraMessageDigest.executaHash(
				senhaAtual.getBytes(), "MD5");

		final CpIdentidade id = dao().consultaIdentidadeCadastrante(
				nomeUsuario, true);
		// se o usu�rio n�o existir
		if (id == null)
			throw new AplicacaoException("O usu�rio n�o est� cadastrado.");

		boolean podeTrocar = id.getDscSenhaIdentidade().equals(hashAtual);

		if (!podeTrocar) {
			// tenta o modo administrador...
			String servico = "SIGA: Sistema Integrado de Gest�o Administrativa;GI: M�dulo de Gest�o de Identidade;DEF_SENHA: Definir Senha";
			try {
				if (Cp.getInstance()
						.getConf()
						.podeUtilizarServicoPorConfiguracao(
								idCadastrante.getDpPessoa(),
								idCadastrante.getDpPessoa().getLotacao(),
								servico)) {

					if (hashAtual.equals(idCadastrante.getDscSenhaIdentidade())) {
						podeTrocar = true;
					} else {
						throw new AplicacaoException("Senha atual n�o confere");
					}

					try {
						Correio.enviar(
								id.getDpPessoa().getEmailPessoaAtual(),
								"Troca de Senha",
								"O Administrador do sistema alterou a senha do seguinte usu�rio, para efetuar "
										+ "uma manuten��o no sistema: "
										+ "\n"
										+ "\n - Nome: "
										+ id.getDpPessoa().getNomePessoa()
										+ "\n - Matricula: "
										+ id.getDpPessoa().getSigla()
										+ "\n - Senha: "
										+ senhaNova
										+ "\n\n Antes de utiliza-lo novamente, altere a sua senha "
										+ "ou solicite uma nova atrav�s da op��o 'esqueci minha senha'"
										+ "\n\n Aten��o: esta � uma "
										+ "mensagem autom�tica. Por favor, n�o responda.");
					} catch (Exception e) {
						System.out
								.println("Erro: N�o foi poss�vel enviar e-mail para o usu�rio informando que o administrador do sistema alterou sua senha."
										+ "\n"
										+ "\n - Nome: "
										+ id.getDpPessoa().getNomePessoa()
										+ "\n - Matricula: "
										+ id.getDpPessoa().getSigla());
					}
				}
			} catch (Exception e1) {

			}
		}

		if (podeTrocar && senhaNova.equals(senhaConfirma)) {
			try {
				Date dt = dao().consultarDataEHoraDoServidor();
				CpIdentidade idNova = new CpIdentidade();
				PropertyUtils.copyProperties(idNova, id);
				idNova.setIdIdentidade(null);
				idNova.setDtCriacaoIdentidade(dt);
				final String hashNova = GeraMessageDigest.executaHash(
						senhaNova.getBytes(), "MD5");
				idNova.setDscSenhaIdentidade(hashNova);

				BASE64Encoder encoderBase64 = new BASE64Encoder();
				String chave = encoderBase64.encode(id.getDpPessoa()
						.getIdInicial().toString().getBytes());
				String senhaCripto = encoderBase64.encode(Criptografia
						.criptografar(senhaNova, chave));
				idNova.setDscSenhaIdentidadeCripto(null);
				idNova.setDscSenhaIdentidadeCriptoSinc(null);

				dao().iniciarTransacao();
				dao().gravarComHistorico(idNova, id, dt, idCadastrante);
				dao().commitTransacao();
				return idNova;
			} catch (final Exception e) {
				dao().rollbackTransacao();
				throw new AplicacaoException(
						"Ocorreu um erro durante a grava��o", 0, e);
			}
		} else {
			throw new AplicacaoException(
					"Senha Atual n�o confere e/ou Senha nova diferente de confirma��o");
		}
	}

	public boolean podeAlterarSenha(String auxiliar1, String cpf1,
			String senha1, String auxiliar2, String cpf2, String senha2,
			String matricula, String cpf, String novaSenha)
			throws AplicacaoException {
		try {
			final long matAux1 = Long.parseLong(auxiliar1.substring(2));
			final DpPessoa pesAux1 = dao().consultarPorCpfMatricula(
					Long.parseLong(cpf1), matAux1);
			if (pesAux1 == null) {
				throw new AplicacaoException("Auxiliar 1 inv�lido!");
			}

			final long matAux2 = Long.parseLong(auxiliar2.substring(2));
			final DpPessoa pesAux2 = dao().consultarPorCpfMatricula(
					Long.parseLong(cpf2), matAux2);
			if (pesAux2 == null) {
				throw new AplicacaoException("Auxiliar 2 inv�lido!");
			}

			final long longmatricula = Long.parseLong(matricula.substring(2));
			final DpPessoa pessoa = dao().consultarPorCpfMatricula(
					Long.parseLong(cpf), longmatricula);
			if (pessoa == null) {
				throw new AplicacaoException(
						"A pessoa que ter� a senha definida inv�lida!");
			}

			CpIdentidade cpIdAux1 = null;
			CpIdentidade cpIdAux2 = null;
			for (CpIdentidade cpId : dao().consultaIdentidades(pesAux1)) {
				if (cpId.getCpTipoIdentidade().getIdCpTpIdentidade().equals(1)) {
					cpIdAux1 = cpId;
				}
			}

			for (CpIdentidade cpId : dao().consultaIdentidades(pesAux2)) {
				if (cpId.getCpTipoIdentidade().getIdCpTpIdentidade().equals(1)) {
					cpIdAux2 = cpId;
				}
			}

			if (cpIdAux1 == null || cpIdAux2 == null) {
				throw new AplicacaoException(
						"Problema ao localizar a identidade dos auxiliares!");
			}

			String hashSenha1 = null;
			String hashSenha2 = null;
			hashSenha1 = GeraMessageDigest
					.executaHash(senha1.getBytes(), "MD5");
			hashSenha2 = GeraMessageDigest
					.executaHash(senha2.getBytes(), "MD5");

			if (pesAux1.getIdInicial().equals(pesAux2.getIdInicial())
					|| pesAux1.getIdInicial().equals(pessoa.getIdInicial())
					|| pesAux2.getIdInicial().equals(pessoa.getIdInicial())) {
				throw new AplicacaoException("As pessoas devem ser diferentes!");
			}
			;
			if (!cpIdAux1.getDscSenhaIdentidade().equals(hashSenha1)
					|| !cpIdAux2.getDscSenhaIdentidade().equals(hashSenha2)) {
				throw new AplicacaoException("As senhas n�o conferem!");
			}

			List<DpPessoa> auxiliares = new ArrayList<DpPessoa>();
			auxiliares.add(pesAux1);
			auxiliares.add(pesAux2);

			if (isAuxAdministradores(pesAux1, pesAux2)) {
				return true;
			}

			if (!pessoasMesmaLotacaoOuSuperior(pessoa, auxiliares)) {
				throw new AplicacaoException(
						"Os auxiliares devem ser da mesma lota��o do usu�rio que ter� a senha trocada!\n Tamb�m � permitido que pessoas da lota��o imediatamente superior na hiearquia sejam auxiliares.");
			}

		} catch (Exception e) {
			throw new AplicacaoException(e.getMessage());
		}
		return true;

	}

	private boolean isAuxAdministradores(DpPessoa aux1, DpPessoa aux2) {

		String servico = "SIGA: Sistema Integrado de Gest�o Administrativa;GI: M�dulo de Gest�o de Identidade;DEF_SENHA: Definir Senha";
		try {

			return Cp
					.getInstance()
					.getConf()
					.podeUtilizarServicoPorConfiguracao(aux1,
							aux1.getLotacao(), servico)
					&& Cp.getInstance()
							.getConf()
							.podeUtilizarServicoPorConfiguracao(aux2,
									aux2.getLotacao(), servico);

		} catch (Exception e) {
			return false;
		}

	}

	/**
	 * Verifica se as pessoas s�o da mesma lota��o ou da lota��o imadiatamente
	 * superior da pessoa-alvo
	 * 
	 * @return
	 */
	private boolean pessoasMesmaLotacaoOuSuperior(DpPessoa alvo,
			List<DpPessoa> listaPessoas) {

		for (DpPessoa p : listaPessoas) {
			if ((alvo.getLotacao().getIdInicial()
					.equals(p.getLotacao().getIdInicial()) || (alvo
					.getLotacao().getLotacaoPai().getIdInicial().equals(p
					.getLotacao().getIdInicial())))) {
				continue;
			}
			return false;
		}
		return true;
	}

	public CpIdentidade definirSenhaDeIdentidade(String senhaNova,
			String senhaConfirma, String nomeUsuario, String auxiliar1,
			String auxiliar2, CpIdentidade idCadastrante)
			throws NoSuchAlgorithmException, AplicacaoException {

		final CpIdentidade id = dao().consultaIdentidadeCadastrante(
				nomeUsuario, true);
		// se o usu�rio n�o existir
		if (id == null)
			throw new AplicacaoException("O usu�rio n�o est� cadastrado.");

		if (senhaNova.equals(senhaConfirma)) {
			try {
				Date dt = dao().consultarDataEHoraDoServidor();
				CpIdentidade idNova = new CpIdentidade();
				PropertyUtils.copyProperties(idNova, id);
				idNova.setIdIdentidade(null);
				idNova.setDtCriacaoIdentidade(dt);
				final String hashNova = GeraMessageDigest.executaHash(
						senhaNova.getBytes(), "MD5");
				idNova.setDscSenhaIdentidade(hashNova);

				BASE64Encoder encoderBase64 = new BASE64Encoder();
				String chave = encoderBase64.encode(id.getDpPessoa()
						.getIdInicial().toString().getBytes());
				String senhaCripto = encoderBase64.encode(Criptografia
						.criptografar(senhaNova, chave));
				idNova.setDscSenhaIdentidadeCripto(null);
				idNova.setDscSenhaIdentidadeCriptoSinc(null);

				dao().iniciarTransacao();
				dao().gravarComHistorico(idNova, id, dt, idCadastrante);
				dao().commitTransacao();
				Correio.enviar(
						id.getDpPessoa().getEmailPessoaAtual(),
						"Altera��o de senha ",
						"\n"
								+ idNova.getDpPessoa().getNomePessoa()
								+ "\nMatricula: "
								+ idNova.getDpPessoa().getSigla()
								+ "\n"
								+ "\nSua senha foi alterada para: "
								+ senhaNova
								+ ".\n\n As seguintes pessoas participaram da altera��o da senha: "
								+ auxiliar1
								+ " e "
								+ auxiliar2
								+ ".\n\n Aten��o: esta � uma "
								+ "mensagem autom�tica. Por favor, n�o responda. ");
				return idNova;
			} catch (final Exception e) {
				dao().rollbackTransacao();
				throw new AplicacaoException(
						"Ocorreu um erro durante a grava��o", 0, e);
			}
		} else {
			throw new AplicacaoException("Senha nova diferente de confirma��o");
		}
	}

	public CpModelo alterarCpModelo(CpModelo mod, String conteudo,
			CpIdentidade identidadeCadastrante) throws AplicacaoException {
		try {
			Date dt = dao().consultarDataEHoraDoServidor();
			CpModelo modNew = new CpModelo();
			try {
				PropertyUtils.copyProperties(modNew, mod);
			} catch (Exception e) {
				throw new AplicacaoException(
						"Erro ao copiar as propriedades do modelo anterior.");
			}
			modNew.setIdMod(null);
			modNew.setConteudoBlobString(conteudo);

			dao().iniciarTransacao();
			CpModelo modSaved = (CpModelo) dao().gravarComHistorico(modNew,
					mod, dt, identidadeCadastrante);
			dao().commitTransacao();
			return modSaved;
		} catch (Exception e) {
			dao().rollbackTransacao();
			throw new AplicacaoException("N�o foi poss�vel alterar o modelo.",
					9, e);
		}
	}

	public void appException(String message) throws AplicacaoException {
		appException(message, null);
	}

	private void appException(String message, Throwable cause)
			throws AplicacaoException {
		throw new AplicacaoException(message, 0, cause);
	}


}
