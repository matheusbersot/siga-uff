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

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.jfree.util.Log;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.Correio;
import br.gov.jfrj.siga.base.SigaBaseProperties;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.dp.dao.CpDao;
import br.gov.jfrj.siga.ex.ExConfiguracao;
import br.gov.jfrj.siga.ex.ExModelo;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExPapel;
import br.gov.jfrj.siga.ex.ExTipoFormaDoc;
import br.gov.jfrj.siga.ex.ExTipoMovimentacao;
import br.gov.jfrj.siga.ex.SigaExProperties;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.ex.ExEmailNotificacao;

public class Notificador {

	public static int TIPO_NOTIFICACAO_GRAVACAO = 1;
	public static int TIPO_NOTIFICACAO_CANCELAMENTO = 2;
	public static int TIPO_NOTIFICACAO_EXCLUSAO = 3;

	// private static String servidor = "localhost:8080"; // teste

	// private static String servidor = "siga"; // produ��o

	// private static String servidor = "http://"
	// + SigaBaseProperties.getString(SigaBaseProperties
	// .getString("ambiente") + ".servidor.principal");

	private static String servidor = SigaBaseProperties.getString("siga.ex."
					+ SigaBaseProperties.getString("ambiente") + ".url");

	
	private static ExDao exDao() {
		return ExDao.getInstance();	}
	
	

	
	/**
	 * M�todo que notifica as pessoas com perfis vinculados ao documento.
	 * 
	 * @param mov
	 * @param tipoNotificacao
	 *            - Se � uma grava��o, cancelamento ou exclus�o de movimenta��o.
	 * @throws AplicacaoException
	 */
	public static void notificarDestinariosEmail(ExMovimentacao mov,
			int tipoNotificacao) throws AplicacaoException {
		
		if(mov.getExMobil().isApensadoAVolumeDoMesmoProcesso())
			return;

		StringBuilder conteudo = new StringBuilder(); // armazena o corpo do
		// e-mail
		StringBuilder conteudoHTML = new StringBuilder(); // armazena o corpo
		// do e-mail no formato HTML

		// lista de destinat�rios com informa��es adicionais de perfil e c�digo
		// da movimenta��o que adicionou o perfil para permitir o cancelamento.
		HashSet<Destinatario> destinatariosEmail = new HashSet<Destinatario>();

		List<Notificacao> notificacoes = new ArrayList<Notificacao>();
		
		if (mov.getIdTpMov().equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA)
				|| (mov.getIdTpMov().equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_ASSINATURA_DIGITAL_MOVIMENTACAO)  
						&& (mov.getExMovimentacaoRef().getIdTpMov().equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_INTERNO_TRANSFERENCIA) 
								|| mov.getExMovimentacaoRef().getIdTpMov().equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA)))
				) {
			DpLotacao  lotacao;			
			try {
				if (mov.getResp() != null)
					lotacao = null;
				else lotacao = mov.getLotaResp();
					adicionarDestinatariosEmail(mov, destinatariosEmail, null, mov.getResp(), lotacao); /* verificar ExEmailNotifica��o tamb�m */
			} catch (Exception e) {
				throw new AplicacaoException(
						"Erro ao enviar email de notifica��o de movimenta��o.", 0,
						e);
			}	
		}

		/*
		 * Para cada movimenta��o do mobil geral (onde fica as movimenta��es
		 * vincula��es de perfis) verifica se: 1) A movimenta��o n�o est�
		 * cancelada; 2) Se a movimenta��o � uma vincula��o de perfil; 3) Se h�
		 * uma configura��o permitindo a notifica��o por e-mail.
		 * 
		 * Caso TODAS as condi��es acima sejam verdadeiras, adiciona o e-mail �
		 * lista de destinat�rios.
		 * Cada notifica��o representa um perfil lido no mobil geral. Uma notifica��o pode  ter um ou 
		 * v�rios emails, dependendo da classe ExEmailNotificacao.		 
		 */
		for (ExMovimentacao m : mov.getExDocumento().getMobilGeral()
				.getExMovimentacaoSet()) {
			if (!m.isCancelada()
					&& m.getExTipoMovimentacao()
							.getIdTpMov()
							.equals(ExTipoMovimentacao.TIPO_MOVIMENTACAO_VINCULACAO_PAPEL)) {
				
				try {
					if (m.getSubscritor() != null) {
						/*
						 * Se a movimenta��o � um cancelamento de uma
						 * movimenta��o que pode ser notificada, adiciona o
						 * e-mail.
						 */
						if (mov.getExMovimentacaoRef() != null)
							adicionarDestinatariosEmail(mov.getExMovimentacaoRef(), destinatariosEmail, m, m.getSubscritor().getPessoaAtual(), null); /* verificar ExEmailNotifica��o */
						else
							adicionarDestinatariosEmail(mov, destinatariosEmail, m, m.getSubscritor().getPessoaAtual(), null); /* verificar ExEmailNotifica��o tamb�m */				
					} else {
						if (m.getLotaSubscritor() != null) {
							/*
							 * Se a movimenta��o � um cancelamento de uma
							 * movimenta��o que pode ser notificada, adiciona o
							 * e-mail.
							 */
							if (mov.getExMovimentacaoRef() != null)
								adicionarDestinatariosEmail(mov.getExMovimentacaoRef(), destinatariosEmail, m, null, m.getLotaSubscritor().getLotacaoAtual()); /* verificar ExEmailNotifica��o tmb*/
							else 
								adicionarDestinatariosEmail(mov, destinatariosEmail, m, null, m.getLotaSubscritor().getLotacaoAtual()); /* verificar ExEmailNotifica��o tmb*/
						}
					}
				} catch (Exception e) {
					throw new AplicacaoException(
							"Erro ao enviar email de notifica��o de movimenta��o.", 0,
							e);
				}	
				
			}
		}

		for (Destinatario dest : destinatariosEmail) {			
			
			prepararTexto(dest, conteudo, conteudoHTML, mov,
					tipoNotificacao);

			String html = conteudoHTML.toString();
			String txt = conteudo.toString();
			String assunto;
			
			if (dest.tipo == "P")
				assunto = "Notifica��o Autom�tica -"+ mov.getExMobil().getSigla() +"- Movimenta��o de Documento";			
			else /* transferencia */ 
				assunto = "Documento transferido para " + dest.sigla;

			conteudoHTML.delete(0, conteudoHTML.length());
			conteudo.delete(0, conteudo.length());

			Notificacao not = new Notificacao(dest, html, txt, assunto);
			notificacoes.add(not);
		}

		notificarPorEmail(notificacoes);

	}

	/**
	 * Inclui destinat�rios na lista baseando-se nas configura��es existentes na
	 * tabela EX_CONFIGURACAO
	 * 
	 * @param mov
	 * @param destinatariosEmail
	 * @param m
	 * @throws AplicacaoException
	 */
	
	private static void adicionarDestinatariosEmail(ExMovimentacao mov,
			HashSet<Destinatario> destinatariosEmail, ExMovimentacao m, DpPessoa pess, DpLotacao lot)
			throws AplicacaoException, Exception {
		
	//	Destinatario dest = new Destinatario();				
		HashSet<String> emailsTemp = new HashSet<String>();
		String sigla;
		ExPapel papel = new ExPapel();
		Long idMovPapel = null;
		
		List<ExEmailNotificacao> listaDeEmails = exDao().consultarEmailNotificacao(pess, lot);		
		papel = null;
		
		if (m != null) {
			papel = m.getExPapel();
			idMovPapel = m.getIdMov();
		}	
		
		if (listaDeEmails.size() > 0) {			
			
			for (ExEmailNotificacao emailNot : listaDeEmails) {
				// Caso exista alguma configura��o com pessoaEmail, lotacaoEmail e email
				// nulos, significa que deve ser enviado para a pessoa ou para
				// todos da lota��o				
				
				if (emailNot.getPessoaEmail() == null  // configura��o default
						&& emailNot.getLotacaoEmail() == null
						&& emailNot.getEmail() == null) {
					if (emailNot.getDpPessoa() != null){
						if (m != null){ /* perfil */
							if (temPermissao(mov.getExDocumento().getExFormaDocumento().getExTipoFormaDoc(),
									papel, emailNot.getDpPessoa(), mov.getExTipoMovimentacao()))								
								emailsTemp.add(emailNot.getDpPessoa().getEmailPessoaAtual());
						} else {  /* transfer�ncia */ 
							if (temPermissao(emailNot.getDpPessoa(), emailNot.getDpPessoa().getLotacao(), mov.getExDocumento().getExModelo(),mov.getIdTpMov() ))						
								emailsTemp.add(emailNot.getDpPessoa().getEmailPessoaAtual());
						}	
					} else {
						for (DpPessoa pes : emailNot.getDpLotacao().getLotacaoAtual().getDpPessoaLotadosSet()) {
							if (m != null) { /* perfil */ 
								if (temPermissao(mov.getExDocumento().getExFormaDocumento().getExTipoFormaDoc(),
									papel, pes, mov.getExTipoMovimentacao()))							
								emailsTemp.add(pes.getEmailPessoaAtual());	
							} else { /* transfer�ncia */
								if (temPermissao(pes, pes.getLotacao(), mov.getExDocumento().getExModelo(),mov.getIdTpMov() ))						
									emailsTemp.add(pes.getEmailPessoaAtual());
							}	
						}	
					}					
				} else {				
						if(emailNot.getPessoaEmail() != null){ // Mandar para pessoa
							if (m != null) {/* perfil */ 
								if (temPermissao(mov.getExDocumento().getExFormaDocumento().getExTipoFormaDoc(),
									papel, emailNot.getPessoaEmail(), mov.getExTipoMovimentacao()))							
								emailsTemp.add(emailNot.getPessoaEmail().getEmailPessoaAtual());	
							}else { /* transfer�ncia */
								if (temPermissao(emailNot.getPessoaEmail(), emailNot.getPessoaEmail().getLotacao(), mov.getExDocumento().getExModelo(),mov.getIdTpMov()))						
									emailsTemp.add(emailNot.getPessoaEmail().getEmailPessoaAtual());
							}	
						} else {
							if (emailNot.getLotacaoEmail() != null) {
								for (DpPessoa pes : emailNot.getLotacaoEmail().getLotacaoAtual().getDpPessoaLotadosSet()) {
									if (m != null) {/* perfil */ 
										if (temPermissao(mov.getExDocumento().getExFormaDocumento().getExTipoFormaDoc(),
											papel, pes, mov.getExTipoMovimentacao()))							
											emailsTemp.add(pes.getEmailPessoaAtual());	
									} else /* transfer�ncia */
										if (temPermissao(pes, pes.getLotacao(), mov.getExDocumento().getExModelo(),mov.getIdTpMov() ))						
											emailsTemp.add(pes.getEmailPessoaAtual());								
								}
							} else {
								emailsTemp.add(emailNot.getEmail());								
							}
						}						
					}
				}	
		} else { /* n�o h� ocorrencias em Ex_email_notificacao */
			if (pess != null){
				if (m != null) { /* perfil */ 
					if (temPermissao(mov.getExDocumento().getExFormaDocumento().getExTipoFormaDoc(),
						papel, pess, mov.getExTipoMovimentacao()))							
						emailsTemp.add(pess.getEmailPessoaAtual());	
				} else {/* transfer�ncia */
					if (temPermissao(pess, pess.getLotacao(), mov.getExDocumento().getExModelo(),mov.getIdTpMov() ))						
						emailsTemp.add(pess.getEmailPessoaAtual());
				}	
			} else {
				for (DpPessoa pes : lot.getLotacaoAtual().getDpPessoaLotadosSet()) {
					if (m != null) { /* perfil */ 
						if (temPermissao(mov.getExDocumento().getExFormaDocumento().getExTipoFormaDoc(),
							papel, pes, mov.getExTipoMovimentacao()))							
						emailsTemp.add(pes.getEmailPessoaAtual());	
					} else  {/* transfer�ncia */
						if (temPermissao(pes, pes.getLotacao(), mov.getExDocumento().getExModelo(),mov.getIdTpMov() ))						
							emailsTemp.add(pes.getEmailPessoaAtual());				
					}	
				}			
			}
		}
		
		if (pess != null)
			sigla = pess.getPessoaAtual().getNomePessoa() + " (" + pess.getPessoaAtual().getSigla() + ")";
		else
			sigla = lot.getLotacaoAtual().getNomeLotacao() + " (" + lot.getLotacaoAtual().getSigla() + ")";
		
		if (m != null) /* perfil */{			
			if (!emailsTemp.isEmpty())	
				destinatariosEmail.add(new Destinatario("P", sigla, papel.getDescPapel(),
					idMovPapel, null, null, emailsTemp));
		} else { /* transferencia */
			if (!emailsTemp.isEmpty())	
				destinatariosEmail.add(new Destinatario("T", sigla, null, null, mov.getExMobil().getSigla(), 
						mov.getExDocumento().getDescrDocumento(), emailsTemp));
		}	
	}	
	
	private static boolean temPermissao(ExTipoFormaDoc tipoFormaDoc,
			ExPapel papel, DpPessoa pessoa, ExTipoMovimentacao tipoMovimentacao) throws AplicacaoException, Exception {		
		
				return (Ex.getInstance()
						.getConf()
						.podePorConfiguracao(
						tipoFormaDoc,
						papel,
						pessoa,
						tipoMovimentacao,
						CpTipoConfiguracao.TIPO_CONFIG_NOTIFICAR_POR_EMAIL));
				
	}
	
	private static boolean temPermissao(DpPessoa pessoa, DpLotacao lotacao, ExModelo modelo, Long idTpMov) throws AplicacaoException, Exception {
		
			return (Ex.getInstance().getConf().podePorConfiguracao(pessoa,
							lotacao, modelo,idTpMov,
							CpTipoConfiguracao.TIPO_CONFIG_NOTIFICAR_POR_EMAIL));		
				
	}
	
	/*
	 * Notifica os destinat�rios assincronamente.
	 * 
	 * @param conteudo
	 *            - texto do e-mail
	 * @param conteudoHTML
	 *            - texto do e-mail no formato HTML
	 * @param destinatariosEmail
	 *            - Conjunto de destinat�rios.
	 */
	private static void notificarPorEmail(List<Notificacao> notificacoes) {
		// Se existirem destinat�rios, envia o e-mail. O e-mail � enviado
		// assincronamente.
		if (notificacoes.size() > 0) {
			CorreioThread t = new CorreioThread(notificacoes);
			t.start();
		}
	}

	/**
	 * Monta o corpo do e-mail que ser� recebido pelas pessoas com perfis
	 * vinculados.
	 * 
	 * @param dest
	 * 
	 * @param conteudo
	 * @param conteudoHTML
	 * @param mov
	 * @param tipoNotificacao
	 *            - Se � uma grava��o, cancelamento ou exclus�o de movimenta��o.
	 */
	private static void prepararTexto(Destinatario dest,
			StringBuilder conteudo, StringBuilder conteudoHTML,
			ExMovimentacao mov, int tipoNotificacao) {
        
		if (dest.tipo == "P") {
		// conte�do texto
			conteudo.append("Documento: ");
			conteudo.append(mov.getExMobil().getSigla());
			conteudo.append("\nDescri��o:");
			conteudo.append(mov.getExDocumento().getDescrDocumento());
			conteudo.append("\nMovimenta��o:");
			if (tipoNotificacao == TIPO_NOTIFICACAO_GRAVACAO
					|| tipoNotificacao == TIPO_NOTIFICACAO_EXCLUSAO) {
				conteudo.append(mov.getExTipoMovimentacao().getDescricao());
			}
			if (tipoNotificacao == TIPO_NOTIFICACAO_CANCELAMENTO) {
				conteudo.append(mov.getExMovimentacaoRef().getDescrTipoMovimentacao()+"(Cancelamento)");
			}
			if (mov.getCadastrante() != null) {
				conteudo.append("\nRealizada por '"
						+ mov.getCadastrante().getNomePessoa() + " (Matr�cula: "
						+ mov.getCadastrante().getMatricula() + ")'.\n\n");

			}
		
			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA
					|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA) {
				if (mov.getResp() != null) {
					conteudo.append("Destinat�rio:  <b>"
							+ mov.getResp().getNomePessoa()
							+ " (Matr�cula: "
							+ mov.getResp().getMatricula() + ") do (a) "
							+ mov.getLotaResp().getNomeLotacao()
							+ " (sigla: " + mov.getLotaResp().getSigla()
							+ ")" + "</b>");
				} else {
					conteudo.append("Lota��o Destinat�ria: <b>"
							+ mov.getLotaResp().getNomeLotacao()
							+ " (sigla: "
							+ mov.getLotaResp().getSigla()
							+ ")" + "</b>");
				}	
			}
			conteudo.append("<p>Para visualizar o documento, ");
			conteudo.append("clique <a href=\"");
			conteudo.append(servidor
					+ "/expediente/doc/exibir.action?sigla=");
			conteudo.append(mov.getExDocumento().getSigla());
			conteudo.append("\">aqui</a>.</p>");		
			conteudo.append("\n\nEste email foi enviado porque ");
			conteudo.append(dest.sigla);
			conteudo.append(" tem o perfil de '");
			conteudo.append(dest.papel);
			conteudo.append("' no documento ");
			conteudo.append(mov.getExDocumento().getSigla());
			conteudo.append(". Caso n�o deseje mais receber notifica��es desse documento, clique no link abaixo para se descadastrar:\n\n");
			conteudo.append(servidor + "/expediente/mov/cancelar.action?id=");
			conteudo.append(dest.idMovPapel);
		
		
		// conte�do html
			conteudoHTML.append("<html><body>");
		
			conteudoHTML.append("<p>Documento: <b>");
			conteudoHTML.append(mov.getExMobil().getSigla()+ "</b></p>");
			conteudoHTML.append("<p>Descri��o: <b>");
			conteudoHTML.append(mov.getExDocumento().getDescrDocumento()+"</b></p>");
			conteudoHTML.append("<p>Movimenta��o: <b>");		

			if (tipoNotificacao == TIPO_NOTIFICACAO_GRAVACAO)					 {
				conteudoHTML.append(mov.getExTipoMovimentacao().getDescricao() + "</b></p>");
			}
			if (tipoNotificacao == TIPO_NOTIFICACAO_EXCLUSAO) {
				conteudoHTML.append(mov.getExTipoMovimentacao().getDescricao() + " (Exclu�da)</b></p>");
			}			
			if (tipoNotificacao == TIPO_NOTIFICACAO_CANCELAMENTO) {
				conteudoHTML.append(mov.getExMovimentacaoRef().getDescrTipoMovimentacao()
						+ "</b></p>.");
			}
			if (mov.getCadastrante() != null) {
				conteudoHTML.append("Realizada por <b>"
						+ mov.getCadastrante().getNomePessoa() + " (Matr�cula: "
						+ mov.getCadastrante().getMatricula() + ")</b></p>");
			}

			if (mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_TRANSFERENCIA
					|| mov.getExTipoMovimentacao().getIdTpMov() == ExTipoMovimentacao.TIPO_MOVIMENTACAO_DESPACHO_TRANSFERENCIA) {
				if (mov.getResp() != null) {
					conteudoHTML.append("<p>Destinat�rio:  <b>"
							+ mov.getResp().getNomePessoa() + " (Matr�cula: "
							+ mov.getResp().getMatricula() + ") do (a) "
							+ mov.getLotaResp().getNomeLotacao() + " (sigla: "
							+ mov.getLotaResp().getSigla() + ")" + "</b></p>");
				} else {
					conteudoHTML.append("<p>Lota��o Destinat�ria: <b>"
							+ mov.getLotaResp().getNomeLotacao() + " (sigla: "
							+ mov.getLotaResp().getSigla() + ")" + "</b></p>");
				}
			}

			conteudoHTML.append("<p>Para visualizar o documento, ");
			conteudoHTML.append("clique <a href=\"");
			conteudoHTML.append(servidor
					+ "/expediente/doc/exibir.action?sigla=");
			conteudoHTML.append(mov.getExDocumento().getSigla());
			conteudoHTML.append("\">aqui</a>.</p>");

			conteudoHTML.append("<p>Este email foi enviado porque <b>");
			conteudoHTML.append(dest.sigla);
			conteudoHTML.append(" </b> tem o perfil de '");
			conteudoHTML.append(dest.papel);
			conteudoHTML.append("' no documento ");
			conteudoHTML.append(mov.getExDocumento().getSigla());
			conteudoHTML
					.append(". <br> Caso n�o deseje mais receber notifica��es desse documento, clique <a href=\"");
			conteudoHTML.append(servidor
					+ "/expediente/mov/cancelar.action?id=");
			conteudoHTML.append(dest.idMovPapel);
			conteudoHTML.append("\">aqui</a> para descadastrar.</p>");

			conteudoHTML.append("</body></html>");
		} else {
			String mensagemTeste = null;
			if (!SigaExProperties.isAmbienteProducao())
				mensagemTeste = SigaExProperties.getString("email.baseTeste");

			conteudo.append("O documento ");

			conteudo.append(dest.siglaMobil);

			conteudo.append(", com descri��o '");

			conteudo.append(dest.descrDocumento);

			conteudo.append("', foi transferido para ");

			conteudo.append(dest.sigla);

			conteudo.append(" e aguarda recebimento.\n\n");

			conteudo.append("Para visualizar o documento, ");

			conteudo.append("clique no link abaixo:\n\n");

			conteudo.append(servidor + "/expediente/doc/exibir.action?sigla=");

			conteudo.append(dest.siglaMobil);

			if (mensagemTeste != null)
				conteudo.append("\n " + mensagemTeste + "\n");

			conteudoHTML.append("<html><body>");

			conteudoHTML.append("<p>O documento <b>");

			conteudoHTML.append(dest.siglaMobil);

			conteudoHTML.append("</b>, com descri��o '<b>");

			conteudoHTML.append(dest.descrDocumento);

			conteudoHTML.append("</b>', foi transferido para <b>");

			conteudoHTML.append(dest.sigla);

			conteudoHTML.append("</b> e aguarda recebimento.</p>");

			conteudoHTML.append("<p>Para visualizar o documento, ");

			conteudoHTML.append("clique <a href=\"");

			conteudoHTML
					.append(servidor + "/expediente/doc/exibir.action?sigla=");

			conteudoHTML.append(dest.siglaMobil);

			conteudoHTML.append("\">aqui</a>.</p>");

			if (mensagemTeste != null)
				conteudoHTML.append("<p><b>" + mensagemTeste + "</b></p>");

			conteudoHTML.append("</body></html>");
		}
	}



	/**
	 * Classe que representa um thread de envio de e-mail. H� a necessidade do
	 * envio de e-mail ser ass�ncrono, caso contr�rio, o usu�rio sentir� uma
	 * degrada��o de performance.
	 * 
	 * @author kpf
	 * 
	 */
	static class CorreioThread extends Thread {

		private List<Notificacao> notificacoes;

		public CorreioThread(List<Notificacao> notificacoes) {
			super();
			this.notificacoes = notificacoes;
		}

		@Override
		public void run() {			
			String txt;
			String html;			
			try {
				for (Notificacao not : notificacoes){
					txt = not.txt;
					html = not.html;				
					Correio.enviar(SigaBaseProperties
								.getString("servidor.smtp.usuario.remetente"),
								not.dest.emails.toArray(new String[not.dest.emails.size()]),		
								not.assunto, txt, html);					
				}
					
			} catch (Exception e) {
				Log.error(e);
			}
		}
	}

	
	static class Notificacao {
		Destinatario dest;
		String html;
		String txt;
		String assunto;

		public Notificacao(Destinatario dest, String html, String txt, String assunto) {
			super();
			this.dest = dest;
			this.html = html;
			this.txt = txt;	
			this.assunto = assunto;
		}
	}

	static class Destinatario implements Comparable<Destinatario> {

		public String tipo;
		public String sigla;
		public String papel;
		public Long idMovPapel;
		public String siglaMobil;		
		public String descrDocumento;		
		public HashSet<String> emails = new HashSet<String>();
		
		public Destinatario(String tipo, String sigla, String papel,
				Long idMovPapel, String siglaMobil, String descrDocumento, 
				HashSet<String> emails ) {
			super();			
			this.tipo = tipo;
			this.sigla = sigla;
			this.papel = papel;
			this.idMovPapel = idMovPapel;
			this.siglaMobil = siglaMobil;	
			this.descrDocumento = descrDocumento;	
			this.emails = emails;				
		}

		public int compareTo(Destinatario o) {
			// TODO Auto-generated method stub
//			return email.compareTo(o.email);
			return 0; /* RETIRAR */
		}

	}

}
