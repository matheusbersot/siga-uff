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
package br.gov.jfrj.ldap;

import java.io.UnsupportedEncodingException;
import java.util.Hashtable;
import java.util.logging.Logger;

import javax.naming.Context;
import javax.naming.NameNotFoundException;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.AttributeInUseException;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.ModificationItem;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

import br.gov.jfrj.siga.base.AplicacaoException;

public class LdapDaoImpl implements ILdapDao {

	protected boolean somenteLeitura;

	private Logger log = Logger.getLogger(LdapDaoImpl.class.getName());
	private LdapContext contexto = null;

	public LdapDaoImpl(boolean somenteLeitura) {
		this.somenteLeitura = somenteLeitura;
	}

	public boolean isSomenteLeitura() {
		return somenteLeitura;
	}

	private void conectar(String servidor, int porta, String usuario,
			String senha, boolean isSSL, String caminhoKeystore)
			throws AplicacaoException {
		Hashtable<String, String> environment = new Hashtable<String, String>();
		environment.put(Context.INITIAL_CONTEXT_FACTORY,
				"com.sun.jndi.ldap.LdapCtxFactory");
		environment.put(Context.SECURITY_AUTHENTICATION, "simple");
		environment.put(Context.SECURITY_PRINCIPAL, usuario);
		environment.put(Context.SECURITY_CREDENTIALS, senha);
		environment.put(Context.BATCHSIZE, "10000");
		environment.put(Context.REFERRAL, "follow");

		if (isSSL) {
			System.setProperty("javax.net.ssl.trustStore", caminhoKeystore);
			environment.put(Context.SECURITY_PROTOCOL, "ssl");
		}

		environment.put(Context.PROVIDER_URL, "ldap://" + servidor + ":"
				+ porta);

		if (contexto != null) {
			try {
				contexto.close();
			} catch (NamingException e) {
				log.info("O contexto n�o pode ser encerrado...");
			}
			contexto = null;
		}
		try {
			contexto = new InitialLdapContext(environment, null);
		} catch (NamingException e) {
			e.printStackTrace();
			throw new AplicacaoException(
					"N�o foi poss�vel criar o contexto LDAP!\n"
							+ "Verifique se o certificado foi importado coma ferramenta keytool ou se o par�metro ldap.keystore est� apontando para o arquivo cacerts correto (Exemplo: JDK_PATH/jre/lib/security/cacerts");
		}

	}

	public void conectarComSSL(String servidor, String porta, String usuario,
			String senha, String caminhoKeystore) throws AplicacaoException {
		conectar(servidor, PORTA_SSL, usuario, senha, true, caminhoKeystore);
	}

	public void conectarSemSSL(String servidor, String porta, String usuario,
			String senha) throws AplicacaoException {
		conectar(servidor, PORTA_COMUM, usuario, senha, false, null);
	}

	public void incluir(String dn, Attributes atributos)
			throws AplicacaoException {
		// Attributes attrs = converterParaAtributosLdap(atributos);
		try {
			contexto.createSubcontext(dn, atributos);
		} catch (NamingException e) {
			e.printStackTrace();
			throw new AplicacaoException("N�o foi poss�vel incluir o objeto "
					+ dn);
		}
	}

	// private Attributes converterParaAtributosLdap(Map<String, Object>
	// atributos) {
	// Attributes attrs = new BasicAttributes(true);
	// for (String k : atributos.keySet()) {
	// attrs.put(k, atributos.get(k));
	// }
	// return attrs;
	// }

	public void excluir(String dn) throws AplicacaoException {
		try {
			contexto.destroySubcontext(dn);
		} catch (NamingException e) {
			e.printStackTrace();
			throw new AplicacaoException("N�o foi poss�vel excluir o objeto "
					+ dn);
		}
	}

	public void alterar(String dn, Attributes atributos)
			throws AplicacaoException {
		// Attributes attrs = converterParaAtributosLdap(atributos);

		NamingEnumeration<String> iAttrs = atributos.getIDs();
		while (iAttrs.hasMoreElements()) {
			Attribute attr;
			try {
				attr = atributos.get(iAttrs.next());
			} catch (NamingException e1) {
				e1.printStackTrace();
				throw new AplicacaoException(
						"N�o foi poss�vel ler os pr�ximos atributos!");
			}
			if (attr.getID().equals("cn")
					|| attr.getID().equals("distinguishedName")
					|| attr.getID().equals("groupType")
					|| attr.getID().equals("objectClass"))
				continue;
			ModificationItem member[] = new ModificationItem[1];
			member[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, attr);
			try {
				contexto.modifyAttributes(dn, member);
			} catch (AttributeInUseException e) {
				e.printStackTrace();
				throw new AplicacaoException("O atributo j� existe!");
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	public Attributes pesquisar(String dn) throws AplicacaoException {
		// Map<String, Object> atributos = new HashMap<String, Object>();

		Attributes attrs = null;
		try {
			attrs = contexto.getAttributes(dn);
			// NamingEnumeration<String> ids = attrs.getIDs();
			// while (ids.hasMoreElements()) {
			// String id = ids.nextElement();
			// Attribute a = attrs.get(id);
			// atributos.put(id, a.get());
			// }

		} catch (NamingException e) {
			if (e instanceof NameNotFoundException) {
				return null;
			}
			e.printStackTrace();
			throw new AplicacaoException(
					"N�o foi poss�vel ler os atributos de " + dn);
		}

		return attrs;
	}

	public void definirSenha(String dnUsuario, String senhaNova)
			throws AplicacaoException {
		// try {
		String quotedPassword = "\"" + senhaNova + "\"";
		byte unicodePwd[];
		try {
			unicodePwd = quotedPassword.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			throw new AplicacaoException(
					"N�o foi poss�vel converter a senha para bytes em UTF-8");
		}
		byte pwdArray[] = new byte[unicodePwd.length * 2];
		for (int i = 0; i < unicodePwd.length; i++) {
			pwdArray[i * 2 + 1] = (byte) (unicodePwd[i] >>> 8);
			pwdArray[i * 2 + 0] = (byte) (unicodePwd[i] & 0xff);
		}

		ModificationItem[] mods = new ModificationItem[1];
		mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE,
				new BasicAttribute("UnicodePwd", pwdArray));
		try {
			contexto.modifyAttributes(dnUsuario, mods);
		} catch (NamingException e) {
			e.printStackTrace();
			throw new AplicacaoException(
					"N�o foi poss�vel alterar a senha do usu�rio "
							+ dnUsuario
							+ " \nVerifique se a senha atende aos requisitos de complexidade impostos pelo servidor LDAP");
		}

	}

	/**
	 * Define se uma conta est� ativa ou n�o.
	 * 
	 * @param dnUsuario
	 * @param ativo
	 * @throws AplicacaoException
	 */
	private void ativarUsuario(String dnUsuario, boolean ativo)
			throws AplicacaoException {
		Attributes ats;
		try {
			ats = contexto.getAttributes(dnUsuario);
		} catch (NamingException e) {
			throw new AplicacaoException(
					"N�o foi poss�vel ler os atributos do usu�rio " + dnUsuario);
		}
		ModificationItem member[] = new ModificationItem[1];
		Attribute at = ats.get("useraccountcontrol");
		String uac = null;
		try {
			if (ativo) {
				uac = String
						.valueOf((Integer.valueOf(at.get().toString()) & (~UF_ACCOUNTDISABLE)));
			} else {
				uac = String
						.valueOf((Integer.valueOf(at.get().toString()) | UF_ACCOUNTDISABLE));
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			throw new AplicacaoException("Erro no formato num�rico!");
		} catch (NamingException e) {
			e.printStackTrace();
			throw new AplicacaoException(
					"N�o foi poss�vel ler um atributo do usu�rio!");
		}

		at.clear();
		at.add(uac);
		member[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, at);
		try {
			this.contexto.modifyAttributes(dnUsuario, member);
		} catch (NamingException e) {
			e.printStackTrace();
			throw new AplicacaoException(
					"N�o foi poss�vel alterar o atributo de ativa��o do usu�rio!");
		}
	}

	/**
	 * Define se uma conta est� ativa
	 * 
	 * @param dnUsuario
	 * @throws AplicacaoException
	 */
	public void ativarUsuario(String dnUsuario) throws AplicacaoException {
		ativarUsuario(dnUsuario, true);
	}

	/**
	 * Define se uma conta est� n�o est� ativa
	 * 
	 * @param dnUsuario
	 * @throws AplicacaoException
	 */
	public void desativarUsuario(String dnUsuario) throws AplicacaoException {
		ativarUsuario(dnUsuario, false);
	}

	/**
	 * Verifica se um objeto existe em algum objeto da �rvore LDAP
	 * 
	 * @param cn
	 *            - Common Name do objeto a ser encontrado
	 * @return - true se o objeto existe.
	 */
	public boolean existe(String cn) {
		try {
			this.contexto.getAttributes(cn);
		} catch (NamingException e) {
			return false;
		}

		return true;

	}

	/**
	 * Muda a localiza��o de um objeto na �rvore LDAP
	 * 
	 * @param dn
	 * @param novoDN
	 * @throws AplicacaoException
	 */
	public void mover(String dn, String novoDN) throws AplicacaoException {
		try {
			this.contexto.rename(dn, novoDN);
		} catch (NamingException e) {
			throw new AplicacaoException("N�o foi poss�vel mover " + dn
					+ " para " + novoDN + "\n" + e.getMessage());
		}
	}

	// private boolean isTipoGrupo(String dn){
	// Attributes attrs = this.contexto.getAttributes(dn);
	// }

	/**
	 * Verifica se � um grupo de seguran�a.
	 * Ref:http://msdn.microsoft.com/en-us/library/ms675935(VS.85).aspx
	 * 
	 * @param dn
	 * @return
	 * @throws NamingException
	 */
	public boolean isGrupoSeguranca(String dn) {
		if (isGrupo(dn)) {
			return isTipoGrupoSeguranca(getTipoGrupo(dn));
		}
		return false;
	}

	private boolean isTipoGrupoSeguranca(Integer tipoGrupo) {
		return (tipoGrupo & ADS_GROUP_TYPE_SECURITY_ENABLED) == ADS_GROUP_TYPE_SECURITY_ENABLED;
	}

	/**
	 * Verifica se � um grupo de distribui��o.
	 * Ref:http://msdn.microsoft.com/en-us/library/ms675935(VS.85).aspx
	 * 
	 * @param dn
	 * @return
	 * @throws AplicacaoException
	 * @throws NamingException
	 * @throws NamingException
	 */
	public boolean isGrupoDistribuicao(String dn) {
		if (isGrupo(dn)) {
			return isTipoGrupoDistribuicao(getTipoGrupo(dn));
		}
		return false;
	}

	private boolean isTipoGrupoDistribuicao(Integer tipoGrupo) {
		return (tipoGrupo & ADS_GROUP_TYPE_SECURITY_ENABLED) == 0;
	}

	public boolean isGrupoSistema(String dn) throws AplicacaoException {
		if (isGrupo(dn)) {
			return isTipoGrupoSistema(getTipoGrupo(dn));
		}
		return false;
	}

	private boolean isTipoGrupoSistema(Integer tipoGrupo) {
		return (tipoGrupo & ADS_GROUP_TYPE_SYSTEM) == ADS_GROUP_TYPE_SYSTEM;
	}

	public boolean isGrupoGlobal(String dn) {
		if (isGrupo(dn)) {
			return isTipoGrupoGlobal(getTipoGrupo(dn));
		}
		return false;
	}

	public boolean isGrupo(String dn) {
		return getAttributes(dn).get("groupType") != null;

	}

	public Attributes getAttributes(String dn) {
		Attributes attrs = null;
		try {
			attrs = this.contexto.getAttributes(dn);
		} catch (NamingException e) {
			new AplicacaoException("N�o foi poss�vel ler os atributos de " + dn);
		}
		return attrs;
	}

	private Integer getTipoGrupo(String dn) {
		Attributes attrs = getAttributes(dn);
		try {
			return Integer.valueOf(attrs.get("groupType").get().toString());
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NamingException e) {
			new AplicacaoException(
					"N�o foi poss�vel identificar o tipo do grupo " + dn);
		}
		return null;
	}

	private boolean isTipoGrupoGlobal(Integer tipoGrupo) {
		return (tipoGrupo & ADS_GROUP_TYPE_GLOBAL_GROUP) == ADS_GROUP_TYPE_GLOBAL_GROUP;
	}

	public boolean isGrupoDomainLocal(String dn) {
		if (isGrupo(dn)) {
			return isTipoGrupoDomainLocal(getTipoGrupo(dn));
		}
		return false;
	}

	private boolean isTipoGrupoDomainLocal(Integer tipoGrupo) {
		return (tipoGrupo & ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP) == ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP;
	}

	public boolean isGrupoUniversal(String dn) {
		if (isGrupo(dn)) {
			return isTipoGrupoUniversal(getTipoGrupo(dn));
		}
		return false;
	}

	private boolean isTipoGrupoUniversal(Integer tipoGrupo) {
		return (tipoGrupo & ADS_GROUP_TYPE_UNIVERSAL_GROUP) == ADS_GROUP_TYPE_UNIVERSAL_GROUP;
	}

	public boolean isUsuario(String dn) throws AplicacaoException {
		Attributes attrs = getAttributes(dn);
		if (attrs.get("objectClass").toString().contains("user")) {
			return true;
		}
		return false;
	}

	public void inserirValorAtributoMultivalorado(String dn,
			String nomeAtributo, Object valorAtributo)
			throws AplicacaoException {
		ModificationItem member[] = new ModificationItem[1];
		member[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE,
				new BasicAttribute(nomeAtributo, valorAtributo));
		try {
			this.contexto.modifyAttributes(dn, member);
		} catch (NamingException e) {
			throw new AplicacaoException("N�o foi poss�vel inserir o valor "
					+ valorAtributo + " no atributo " + nomeAtributo
					+ " do objeto " + dn + "!");
		}
	}

	public void removerValorAtributoMultivalorado(String dn,
			String nomeAtributo, Object valorAtributo)
			throws AplicacaoException {
		ModificationItem member[] = new ModificationItem[1];
		member[0] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE,
				new BasicAttribute(nomeAtributo, valorAtributo));
		try {
			this.contexto.modifyAttributes(dn, member);
		} catch (NamingException e) {
			throw new AplicacaoException("N�o foi poss�vel remover o valor "
					+ valorAtributo + " no atributo " + nomeAtributo
					+ " do objeto " + dn + "!");
		}
	}

	public void alterarAtributo(String dn, String nomeAtributo,
			Object valorAtributo) throws AplicacaoException {
		Attributes ats = pesquisar(dn);
		ModificationItem member[] = new ModificationItem[1];
		Attribute at = ats.get(nomeAtributo);
		if (at==null){
			throw new AplicacaoException("Atributo [" + nomeAtributo + "] n�o existe para [+ " + dn + "]!");
		}
		at.clear();
		at.add(valorAtributo);
		member[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, at);
		try {
			this.contexto.modifyAttributes(dn, member);
		} catch (NamingException e) {
			throw new AplicacaoException(
					"N�o foi poss�vel substitur o valor atual do atributo "
							+ nomeAtributo + " pelo valor " + valorAtributo
							+ " do objeto " + dn);
		}

	}

	public LdapContext getContexto() {
		return contexto;
	}

	public LdapDaoProxy getProxy() {
		return new LdapDaoProxy(somenteLeitura);
	}

	/**
	 * Verifica se um usuario pode se autenticar na �rvore LDAP. Esse m�todo �
	 * mais simples que o conectarComSSL() e conectarSemSSL() e tem o prop�sito
	 * apenas de confirmar se o usu�rio/senha est�o corretos. Este m�todo n�o
	 * possibilita o uso de ssl, n�o retorna o contexto LDAP para o usu�rio
	 * manipular e n�o permite informar o DN para autentica��o. Se for essa a
	 * sua necessidade, use o m�todo conectarComSSL() ou conectarSemSSL().
	 * 
	 * @param usuario
	 *            - nome do usu�rio a se logar, na JFRJ � a sigla da pessoa (ex:
	 *            kpf)
	 * @param dominio
	 *            - dom�nio do AD
	 * @param senha
	 *            - senha do usu�rio
	 * @param servidor
	 *            - servidor de autentica��o
	 * @param porta
	 *            - porta do servidor de autentica��o (padr�o: 389)
	 * @return true - se o login foi bem sucedido. <br/>
	 *         false - em caso de falha.
	 */
	public boolean verificarConexao(String usuario, String dominio,
			String senha, String servidor, String porta) {
		Hashtable<String, String> environment = new Hashtable<String, String>();
		environment.put(Context.INITIAL_CONTEXT_FACTORY,
				"com.sun.jndi.ldap.LdapCtxFactory");

		environment.put(Context.PROVIDER_URL, "ldap://" + servidor + ":"
				+ porta);
		environment.put(Context.SECURITY_AUTHENTICATION, "simple");

		environment.put(Context.SECURITY_PRINCIPAL, usuario + "@" + dominio);
		environment.put(Context.SECURITY_CREDENTIALS, senha);

		try {
			return (new InitialLdapContext(environment, null) != null);

		} catch (NamingException e) {
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * Altera a senha de um usu�rio. � necess�rio informar a senha antiga.
	 * 
	 * Alterar a senha � uma opera��o de mudan�a do ldap que deleta a senha
	 * antiga e adiciona a nova senha. http://support.microsoft.com/kb/269190
	 * 
	 * 
	 * @param dnUsuario
	 * @param senhaAntiga
	 * @param senhaNova
	 * @throws AplicacaoException
	 * @throws UnsupportedEncodingException
	 * @throws NamingException
	 * @throws AplicacaoException
	 */
	public void alterarSenha(String dnUsuario, String senhaAntiga,
			String senhaNova) throws AplicacaoException {

		String siglaUsuario = dnToSamAccountName(dnUsuario);

		boolean senhaAntigaOK = verificarConexao(siglaUsuario,
				getDominioContexto(), senhaAntiga, getServidorContexto(), "389");

		if (!senhaAntigaOK) {
			throw new AplicacaoException("A senha antiga � inv�lida!");
		}

		ModificationItem[] mods = new ModificationItem[2];

		byte[] oldUnicodePassword = null;
		byte[] newUnicodePassword = null;
		try {
			String oldQuotedPassword = "\"" + senhaAntiga + "\"";
			oldUnicodePassword = oldQuotedPassword.getBytes("UTF-16LE");
			String newQuotedPassword = "\"" + senhaNova + "\"";
			newUnicodePassword = newQuotedPassword.getBytes("UTF-16LE");
		} catch (UnsupportedEncodingException e) {
			new AplicacaoException(
					"N�o foi poss�vel converter as senhas em bytes UTF-16LE!");
		}

		definirSenha(dnUsuario, senhaNova);
	}

	private String getPortaServidorContexto() throws AplicacaoException {
		String urlServidor = null;
		try {
			urlServidor = contexto.getEnvironment()
					.get("java.naming.provider.url").toString();
		} catch (NamingException e) {
			throw new AplicacaoException(
					"N�o foi poss�vel determinar o servidor do contexto!");
		}
		return urlServidor.substring(urlServidor.lastIndexOf(":") + 1);
	}

	private String getServidorContexto() throws AplicacaoException {
		String urlServidor = null;
		try {
			urlServidor = contexto.getEnvironment()
					.get("java.naming.provider.url").toString();
		} catch (NamingException e) {
			throw new AplicacaoException(
					"N�o foi poss�vel determinar o servidor do contexto!");
		}
		return urlServidor.substring(urlServidor.lastIndexOf("/") + 1,
				urlServidor.lastIndexOf(":"));
	}

	private String getDominioContexto() throws AplicacaoException {
		String usuarioAutenticadoContexto = null;
		try {
			usuarioAutenticadoContexto = contexto.getEnvironment()
					.get("java.naming.security.principal").toString();
		} catch (NamingException e) {
			throw new AplicacaoException(
					"N�o foi poss�vel determinar o dom�nio do contexto!");
		}
		return usuarioAutenticadoContexto.substring(usuarioAutenticadoContexto
				.indexOf("@") + 1);
	}

	private String dnToSamAccountName(String dnUsuario)
			throws AplicacaoException {
		Attributes attrs = pesquisar(dnUsuario);

		String siglaUsuario = null;
		try {
			siglaUsuario = attrs.get("samaccountname").get().toString();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return siglaUsuario;
	}

	@Override
	public void criarContato(String nome, String dnPontoCriacao)
			throws AplicacaoException {
		String dn = "CN=" + nome + "," + dnPontoCriacao;
		Attributes atributos = new BasicAttributes(true);
		atributos.put("objectClass", "contact");
		atributos.put("cn", nome);
		atributos.put("distinguishedName", dn);
		incluir(dn, atributos);
	}

	@Override
	public void criarGrupoSeguranca(String nome, String dnPontoCriacao)
			throws AplicacaoException {
		String dn = "CN=" + nome + "," + dnPontoCriacao;
		Attributes atributos = new BasicAttributes(true);

		atributos.put("objectClass", "group");
		atributos.put("cn", nome);
		atributos.put("samAccountName", nome);
		atributos.put(
				"groupType",
				Integer.toString(ADS_GROUP_TYPE_GLOBAL_GROUP
						| ADS_GROUP_TYPE_SECURITY_ENABLED));
		atributos.put("distinguishedName", dn);

		atributos.put("displayName", nome);

		incluir(dn, atributos);

	}

	@Override
	public void criarGrupoDistribuicao(String nome, String dnPontoCriacao)
			throws AplicacaoException {
		String dn = "CN=" + nome + "," + dnPontoCriacao;
		Attributes atributos = new BasicAttributes(true);

		atributos.put("objectClass", "group");
		atributos.put("cn", nome);
		atributos.put("groupType",
				Integer.toString(ADS_GROUP_TYPE_UNIVERSAL_GROUP));
		atributos.put("distinguishedName", dn);
		atributos.put("samAccountName", nome);

		atributos.put("displayName", nome);

		incluir(dn, atributos);
	}

	@Override
	public void criarUnidadeOrganizacional(String nome, String dnPontoCriacao)
			throws AplicacaoException {
		String dn = "OU=" + nome + "," + dnPontoCriacao;
		Attributes atributos = new BasicAttributes(true);

		atributos.put("objectClass", "organizationalUnit");
		atributos.put("cn", nome);
		atributos.put("distinguishedName", dn);

		incluir(dn, atributos);

	}

	@Override
	public void criarUsuario(String login, String nomeUsuario,
			String dnPontoCriacao) throws AplicacaoException {
		String dn = "CN=" + nomeUsuario + "," + dnPontoCriacao;
		Attributes atributos = new BasicAttributes(true);

		atributos.put("objectClass", "user");
		atributos.put("samAccountName", login);
		atributos.put("cn", nomeUsuario);
		atributos.put("distinguishedName", dn);

		incluir(dn, atributos);
	}

	@Override
	public void excluirAtributo(String dn, String nomeAtributo)
			throws AplicacaoException {
		ModificationItem member[] = new ModificationItem[1];
		member[0] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE,
				new BasicAttribute(nomeAtributo));
		try {
			this.contexto.modifyAttributes(dn, member);
		} catch (NamingException e) {
			throw new AplicacaoException("N�o foi poss�vel excluir o atributo "
					+ nomeAtributo + " do objeto " + dn + "!");
		}

	}

}
