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
package br.gov.jfrj.siga.libs.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.gov.jfrj.siga.cp.CpModelo;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.dao.CpDao;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class ProcessadorFreemarkerSimples implements 
		TemplateLoader {

	private Configuration cfg;

	public ProcessadorFreemarkerSimples() {
		super();
		cfg = new Configuration();
		String s = cfg.getVersionNumber();
		// Specify the data source where the template files come from.
		cfg.setTemplateLoader(this);
		// Specify how templates will see the data-model.
		cfg.setObjectWrapper(new DefaultObjectWrapper());
		cfg.setWhitespaceStripping(true);
		cfg.setTagSyntax(Configuration.SQUARE_BRACKET_TAG_SYNTAX);
		cfg.setLocalizedLookup(false);
	}

	public String processarModelo(CpOrgaoUsuario ou, Map<String, Object> attrs,
			Map<String, Object> params) throws Exception {
		// Create the root hash
		Map root = new HashMap();
		root.put("root", root);

		root.putAll(attrs);
		root.put("param", params);

		String sTemplate = "[#compress]\n[#include \"GERAL\"]\n";
		if (ou != null) {
			sTemplate += "[#include \"" + ou.getAcronimoOrgaoUsu() + "\"]";
		}
		sTemplate += "\n" + (String) attrs.get("template") + "\n[/#compress]";

		Template temp = new Template((String) attrs.get("nmMod"),
				new StringReader(sTemplate), cfg);

		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		Writer out = new OutputStreamWriter(baos);
		try {
			temp.process(root, out);
		} catch (TemplateException e) {
			return (e.getMessage() + "\n" + e.getFTLInstructionStack()).replace("\n", "<br/>").replace("\r", "");
		} catch (IOException e) {
			return e.getMessage();
		}
		out.flush();
		return baos.toString();
	}

	public void closeTemplateSource(Object arg0) throws IOException {
	}

	public Object findTemplateSource(String source) throws IOException {
		List<CpModelo> l = CpDao.getInstance().consultaCpModelos();
		for (CpModelo mod : l) {
			if ("GERAL".equals(source) && mod.getCpOrgaoUsuario() == null) {
				return mod.getConteudoBlobString() == null ? "" : mod
						.getConteudoBlobString();
			} else if (mod.getCpOrgaoUsuario() != null
					&& mod.getCpOrgaoUsuario().getAcronimoOrgaoUsu().equals(
							source)) {
				return mod.getConteudoBlobString() == null ? "" : mod
						.getConteudoBlobString();
			}
		}
		return null;
	}

	public long getLastModified(Object arg0) {
		return 0;
	}

	public Reader getReader(Object arg0, String arg1) throws IOException {
		return new StringReader((String) arg0);
	}

}
