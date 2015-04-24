package br.jus.tjrr.siga.assinador;

import javax.naming.InvalidNameException;
import javax.naming.ldap.LdapName;
import javax.naming.ldap.Rdn;

public class DN {
	
	private String commonName; 
	private String organizationUnit;
	private String organization; 
	private String locality; 
	private String state; 
	private String country;
	private String email;
	private String dnCompleto;
	
	public DN(String DN)
	{
		dnCompleto = DN;
		
		LdapName ln;
		try {
			ln = new LdapName(DN);
			for(Rdn rdn : ln.getRdns()) {
			    
				if(rdn.getType().equalsIgnoreCase("CN")) {
			        commonName = rdn.getValue().toString();			        
			    }else if (rdn.getType().equalsIgnoreCase("OU"))
			    {
			    	organizationUnit= rdn.getValue().toString();	
			    }else if (rdn.getType().equalsIgnoreCase("O"))
			    {
			    	organization = rdn.getValue().toString();	
			    }else if (rdn.getType().equalsIgnoreCase("L"))
			    {
			    	locality = rdn.getValue().toString();	
			    }else if (rdn.getType().equalsIgnoreCase("ST"))
			    {
			    	state = rdn.getValue().toString();	
			    }else if (rdn.getType().equalsIgnoreCase("C"))
			    {
			    	country = rdn.getValue().toString();	
			    }else if (rdn.getType().equalsIgnoreCase("E"))
			    {
			    	email = rdn.getValue().toString();	
			    }				
			}
		} catch (InvalidNameException e) {
			e.printStackTrace();
		}		
	}	
	

	public String getCommonName() {
		return commonName;
	}

	public void setCommonName(String commonName) {
		this.commonName = commonName;
	}

	public String getOrganizationUnit() {
		return organizationUnit;
	}

	public void setOrganizationUnit(String organizationUnit) {
		this.organizationUnit = organizationUnit;
	}

	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}

	public String getLocality() {
		return locality;
	}

	public void setLocality(String locality) {
		this.locality = locality;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String toString()
	{
		return dnCompleto;
	}

}
