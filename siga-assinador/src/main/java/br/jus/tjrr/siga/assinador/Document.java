package br.jus.tjrr.siga.assinador;

public class Document {
	
	private String code;
	private String url;
	private boolean checked;
	
	public Document(String code, String url, boolean checked)
	{
		this.code = code;		
		this.url = url;
		this.checked = checked;
	}

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}
