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
package br.gov.jfrj.siga.base;

import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.InternetHeaders;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.bouncycastle.util.encoders.Base64;


public class Correio {

	public static void enviar(final String destinatario, final String assunto,
			final String conteudo) throws Exception {
		final String[] to = { destinatario };

		Correio.enviar(SigaBaseProperties.getString("servidor.smtp.usuario.remetente"), to,
				assunto, conteudo, null);
	}

	public static void enviar(final String remetente,
			final String[] destinatarios, final String assunto,
			final String conteudo, final String conteudoHTML) throws Exception {

		// Cria propriedades a serem usadas na sess�o.
		final Properties props = new Properties();

		// Define propriedades da sess�o.
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", SigaBaseProperties.getString("servidor.smtp"));
		props.put("mail.host", SigaBaseProperties.getString("servidor.smtp"));
		props.put("mail.mime.charset", "UTF-8");

		// Cria sess�o. setDebug(true) � interessante pois
		// mostra os passos do envio da mensagem e o
		// recebimento da mensagem do servidor no console.
		Session session = null;
		if (Boolean.valueOf(SigaBaseProperties.getString("servidor.smtp.auth"))){
			props.put("mail.smtp.auth", "true");
			final String usuario = SigaBaseProperties.getString("servidor.smtp.auth.usuario"); 
			final String senha = SigaBaseProperties.getString("servidor.smtp.auth.senha");
			session = Session.getInstance(props,new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(usuario, senha);
				}
			});
		}else{
			session = Session.getInstance(props);
		}

		final boolean debug = Boolean.parseBoolean("false");
		// final boolean debug = Boolean.parseBoolean(Mensagens
		// .getString("servidor.smtp.debug"));
		session.setDebug(debug);
		// Cria mensagem e seta alguns valores que constituem
		// os seus headers.
		final Message msg = new MimeMessage(session);

		try {
			if (destinatarios.length == 1) {
				msg.setRecipient(Message.RecipientType.TO, new InternetAddress(
						destinatarios[0]));

			} else {
				Set<String> destSet = new HashSet<String>();
				for (String s : destinatarios) {
					if (!destSet.contains(s))
						destSet.add(s);
				}

				final InternetAddress[] endereco = new InternetAddress[destSet
						.size()];
				int i = 0;
				for (String email : destSet) {
					endereco[i] = new InternetAddress(email);
					i++;
				}
				msg.setRecipients(Message.RecipientType.TO, endereco);
			}
			msg.setFrom(new InternetAddress(remetente));
			msg.setSubject(assunto);

			if (conteudoHTML == null) {
				// msg.setText(conteudo);
				msg.setSubject(assunto);
				msg.setContent(conteudo, "text/plain;charset=UTF-8");
			} else {
				Multipart mp = new MimeMultipart("alternative");

				// Add text version
				InternetHeaders ihs = new InternetHeaders();
				ihs.addHeader("Content-Type", "text/plain; charset=UTF-8");
				ihs.addHeader("Content-Transfer-Encoding", "base64");
				MimeBodyPart mb1 = new MimeBodyPart(ihs, Base64.encode(conteudo
						.getBytes("utf-8")));
				mp.addBodyPart(mb1);

				// Do the same with the HTML part
				InternetHeaders ihs2 = new InternetHeaders();
				ihs2.addHeader("Content-Type", "text/html; charset=UTF-8");
				ihs2.addHeader("Content-Transfer-Encoding", "base64");
				MimeBodyPart mb2 = new MimeBodyPart(ihs2, Base64
						.encode(conteudoHTML.getBytes("utf-8")));
				mp.addBodyPart(mb2);

				// Set the content for the message and transmit
				msg.setContent(mp);
			}

			// Envia mensagem.
			//Transport.send(msg);
			
			Transport tr = new br.gov.jfrj.siga.base.SMTPTransport(session, null);
			tr.connect(SigaBaseProperties.getString("servidor.smtp"), Integer.valueOf(SigaBaseProperties.getString("servidor.smtp.porta")), null, null);
			msg.saveChanges(); // don't forget this
			tr.sendMessage(msg, msg.getAllRecipients());
			tr.close();

		} catch (final Exception e) {
			throw e;
		}
	}


	public static void enviar(String remetente, String[] destinatarios,
			String assunto, String conteudo) throws Exception {
		Correio.enviar(remetente, destinatarios,
				assunto, conteudo, null);
	}
}
