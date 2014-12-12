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
package br.gov.jfrj.siga.integracao.ldap;

import br.gov.jfrj.ldap.ILdapDao;
import br.gov.jfrj.ldap.LdapDaoImpl;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpIdentidade;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.dao.CpDao;

public class IntegracaoLdap {

	private static IntegracaoLdap instancia;
	
	private IntegracaoLdap(){
		
	}
	
	public synchronized static IntegracaoLdap getInstancia(){
		if (instancia == null){
			instancia = new IntegracaoLdap();
		}
		return instancia;
	}
	

	public boolean atualizarSenhaLdap(CpIdentidade id, String senha) {
		String localidade = id.getDpPessoa().getOrgaoUsuario().getAcronimoOrgaoUsu().toLowerCase();
		
		IntegracaoLdapProperties prop = configurarProperties(localidade);
		
		try {
			if (!integrarComLdap(id.getDpPessoa().getOrgaoUsuario())){
				return false;
			}
			
			ILdapDao ldap = new LdapDaoImpl(false);
			ldap.conectarComSSL(prop.getServidorLdap(), prop.getPortaSSLLdap(), prop.getUsuarioLdap(), prop.getSenhaLdap(), prop.getKeyStore());
			

				String cnPessoa = id.getDpPessoa().getSesbPessoa() + id.getDpPessoa().getMatricula();
				ldap.definirSenha("CN=" + cnPessoa +  "," + prop.getDnUsuarios() , senha);
				limparSenhaSincDB(id);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;

		
	}

	private void limparSenhaSincDB(CpIdentidade id) throws AplicacaoException {
		CpDao dao = CpDao.getInstance();
//		dao.iniciarTransacao();
		id.setDscSenhaIdentidadeCriptoSinc(null);
//		dao.commitTransacao();
	}
	
	public boolean integrarComLdap(CpOrgaoUsuario orgaoUsuario){
		String localidade = orgaoUsuario.getAcronimoOrgaoUsu().toLowerCase();
		IntegracaoLdapProperties prop = configurarProperties(localidade);
		
		return prop.sincronizarSenhaLdap();
		
	}

	private IntegracaoLdapProperties configurarProperties(String localidade) {
		String ambiente = System.getProperty("ambiente", "");
		IntegracaoLdapProperties prop = new IntegracaoLdapProperties();
		if (localidade.length()>0 && ambiente.length()>0){
			prop.setPrefixo("siga.cp.sinc.ldap." + localidade + "." +ambiente) ;	
		}
		return prop;
	}
}
