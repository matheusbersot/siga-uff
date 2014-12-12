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
package br.gov.jfrj.webwork.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.cp.CpSituacaoConfiguracao;
import br.gov.jfrj.siga.cp.CpTipoConfiguracao;
import br.gov.jfrj.siga.ex.ExClassificacao;
import br.gov.jfrj.siga.ex.ExConfiguracao;
import br.gov.jfrj.siga.ex.ExDocumento;
import br.gov.jfrj.siga.ex.ExEstadoDoc;
import br.gov.jfrj.siga.ex.ExFormaDocumento;
import br.gov.jfrj.siga.ex.ExMobil;
import br.gov.jfrj.siga.ex.ExModelo;
import br.gov.jfrj.siga.ex.ExMovimentacao;
import br.gov.jfrj.siga.ex.ExNivelAcesso;
import br.gov.jfrj.siga.ex.ExTipoDocumento;
import br.gov.jfrj.siga.ex.bl.Ex;
import br.gov.jfrj.siga.ex.bl.ExConfiguracaoBL;
import br.gov.jfrj.siga.ex.util.MascaraUtil;
import br.gov.jfrj.siga.hibernate.ExDao;
import br.gov.jfrj.siga.libs.webwork.SigaActionSupport;
import br.gov.jfrj.siga.util.ExProcessadorModelo;

public class ExActionSupport extends SigaActionSupport {

	static {
		if (Ex.getInstance().getBL().getProcessadorModeloJsp() == null) {
			Ex.getInstance().getBL()
					.setProcessadorModeloJsp(new ExProcessadorModelo());
		}
	}

	protected void verificaNivelAcesso(ExMobil mob) throws Exception {
		if (!Ex.getInstance().getComp()
				.podeAcessarDocumento(getTitular(), getLotaTitular(), mob)) {
			throw new AplicacaoException("Acesso ao documento "
					+ mob.getSigla()
					+ " permitido somente a usu�rios autorizados. ("
					+ getTitular().getSigla() + "/"
					+ getLotaTitular().getSiglaCompleta() + ")");
		}
	}

	public String getNomeServidor() {
		return getRequest().getServerName();
	}

	public String getNomeServidorComPorta() {
		if (getRequest().getServerPort() > 0)
			return getRequest().getServerName() + ":"
					+ getRequest().getServerPort();
		return getRequest().getServerName();
	}

	public List<ExNivelAcesso> getListaNivelAcesso(ExTipoDocumento exTpDoc,
			ExFormaDocumento forma, ExModelo exMod, ExClassificacao classif)
			throws Exception {
		List<ExNivelAcesso> listaNiveis = ExDao.getInstance()
				.listarOrdemNivel();
		ArrayList<ExNivelAcesso> niveisFinal = new ArrayList<ExNivelAcesso>();
		Date dt = ExDao.getInstance().consultarDataEHoraDoServidor();

		ExConfiguracao config = new ExConfiguracao();
		CpTipoConfiguracao exTpConfig = new CpTipoConfiguracao();
		config.setDpPessoa(getTitular());
		config.setLotacao(getLotaTitular());
		config.setExTipoDocumento(exTpDoc);
		config.setExFormaDocumento(forma);
		config.setExModelo(exMod);
		config.setExClassificacao(classif);
		exTpConfig
				.setIdTpConfiguracao(CpTipoConfiguracao.TIPO_CONFIG_NIVEL_ACESSO_MINIMO);
		config.setCpTipoConfiguracao(exTpConfig);
		int nivelMinimo = ((ExConfiguracao) Ex
				.getInstance()
				.getConf()
				.buscaConfiguracao(config,
						new int[] { ExConfiguracaoBL.NIVEL_ACESSO }, dt))
				.getExNivelAcesso().getGrauNivelAcesso();
		exTpConfig
				.setIdTpConfiguracao(CpTipoConfiguracao.TIPO_CONFIG_NIVEL_ACESSO_MAXIMO);
		config.setCpTipoConfiguracao(exTpConfig);
		int nivelMaximo = ((ExConfiguracao) Ex
				.getInstance()
				.getConf()
				.buscaConfiguracao(config,
						new int[] { ExConfiguracaoBL.NIVEL_ACESSO }, dt))
				.getExNivelAcesso().getGrauNivelAcesso();

		for (ExNivelAcesso nivelAcesso : listaNiveis) {
			if (nivelAcesso.getGrauNivelAcesso() >= nivelMinimo
					&& nivelAcesso.getGrauNivelAcesso() <= nivelMaximo)
				niveisFinal.add(nivelAcesso);
		}

		return niveisFinal;
	}
	
	public ExNivelAcesso getNivelAcessoDefault(ExTipoDocumento exTpDoc,
			ExFormaDocumento forma, ExModelo exMod, ExClassificacao classif)
			throws Exception {
		Date dt = ExDao.getInstance().consultarDataEHoraDoServidor();
		
		ExConfiguracao config = new ExConfiguracao();
		CpTipoConfiguracao exTpConfig = new CpTipoConfiguracao();
		CpSituacaoConfiguracao exStConfig = new CpSituacaoConfiguracao();
		config.setDpPessoa(getTitular());
		config.setLotacao(getLotaTitular());
		config.setExTipoDocumento(exTpDoc);
		config.setExFormaDocumento(forma);
		config.setExModelo(exMod);
		config.setExClassificacao(classif);
		exTpConfig
				.setIdTpConfiguracao(CpTipoConfiguracao.TIPO_CONFIG_NIVELACESSO);
		config.setCpTipoConfiguracao(exTpConfig);
		exStConfig
			.setIdSitConfiguracao(CpSituacaoConfiguracao.SITUACAO_DEFAULT);
		config.setCpSituacaoConfiguracao(exStConfig);
		
		ExConfiguracao exConfig = ((ExConfiguracao) Ex
				.getInstance()
				.getConf()
				.buscaConfiguracao(config,
						new int[] { ExConfiguracaoBL.NIVEL_ACESSO }, dt));
		
		if(exConfig != null)
			return exConfig.getExNivelAcesso();
		
		return null;
	}

	public String getDescrDocConfidencial(ExDocumento doc) {
		return Ex.getInstance().getBL()
				.descricaoSePuderAcessar(doc, getTitular(), getLotaTitular());
	}

	public List<ExTipoDocumento> getTiposDocumento() throws AplicacaoException {
		return dao().listarExTiposDocumento();
	}

	public ExDao dao() {
		return ExDao.getInstance();
	}

	public ExDocumento daoDoc(long id) {
		return dao().consultar(id, ExDocumento.class, false);
	}

	public ExMovimentacao daoMov(long id) {
		return dao().consultar(id, ExMovimentacao.class, false);
	}

	public ExMobil daoMob(long id) {
		return dao().consultar(id, ExMobil.class, false);
	}

	public List<ExEstadoDoc> getEstados() throws AplicacaoException {
		return ExDao.getInstance().listarExEstadosDoc();
	}

	public Map<Integer, String> getListaTipoResp() {
		final Map<Integer, String> map = new TreeMap<Integer, String>();
		map.put(1, "Matr�cula");
		map.put(2, "�rg�o Integrado");
		return map;
	}

	public List<String> getListaAnos() {
		final ArrayList<String> lst = new ArrayList<String>();
		// map.add("", "[Vazio]");
		final Calendar cal = Calendar.getInstance();
		for (Integer ano = cal.get(Calendar.YEAR); ano >= 1990; ano--)
			lst.add(ano.toString());
		return lst;
	}

	public void assertAcesso(String pathServico) throws AplicacaoException,
			Exception {
		super.assertAcesso("DOC:M�dulo de Documentos;" + pathServico);
	}
	


}
