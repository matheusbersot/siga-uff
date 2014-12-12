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
package br.gov.jfrj.siga.dp.dao;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import junit.framework.TestCase;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;
import org.hibernate.dialect.Dialect;
import org.hibernate.tool.hbm2ddl.DatabaseMetadata;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import br.gov.jfrj.siga.base.AplicacaoException;
import br.gov.jfrj.siga.base.Criptografia;
import br.gov.jfrj.siga.cp.CpConfiguracao;
import br.gov.jfrj.siga.cp.CpGrupo;
import br.gov.jfrj.siga.cp.CpGrupoDeEmail;
import br.gov.jfrj.siga.cp.CpIdentidade;
import br.gov.jfrj.siga.cp.CpServico;
import br.gov.jfrj.siga.cp.CpTipoGrupo;
import br.gov.jfrj.siga.cp.CpTipoServico;
import br.gov.jfrj.siga.cp.bl.Cp;
import br.gov.jfrj.siga.cp.bl.CpAmbienteEnumBL;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.CpTipoLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;
import br.gov.jfrj.siga.model.Objeto;
import br.gov.jfrj.siga.model.dao.DaoFiltro;
import br.gov.jfrj.siga.model.dao.HibernateUtil;

public class CpDaoTest extends TestCase {

	private static final String NOVA_SENHA = "123456";
	private static final String CPF = "11111111111";
	private static final String LOGIN = "RJ11111";
	private CpDao dao;

	public CpDaoTest() throws Exception {
		// HibernateUtil
		// .configurarHibernate("/br/gov/jfrj/siga/hibernate/hibernate.cfg.xml",
		// ExMarca.class, CpMarca.class);
		CpAmbienteEnumBL ambiente = CpAmbienteEnumBL.DESENVOLVIMENTO;
		Cp.getInstance().getProp().setPrefixo(ambiente.getSigla());
		/*
		 * AnnotationConfiguration cfg = CpDao.criarHibernateCfg(
		 * "jdbc:oracle:thin:@servidor:1521:instancia", "usuario", "senha");
		 */
		AnnotationConfiguration cfg = CpDao.criarHibernateCfg(ambiente);
		// CpDao.configurarHibernateParaDebug(cfg);
		HibernateUtil.configurarHibernate(cfg, "");

		dao = CpDao.getInstance();
	}

	public void testGravarGrupoEPegarDataDeAtualizacao()
			throws AplicacaoException {
		Date dt2 = dao.consultarDataUltimaAtualizacao();

		CpTipoGrupo tpGrp = dao.consultar(
				CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO,
				CpTipoGrupo.class, false);
		dao.iniciarTransacao();

		CpGrupo grpNovo = new CpGrupoDeEmail();
		grpNovo.setCpTipoGrupo(tpGrp);
		grpNovo.setOrgaoUsuario(dao.consultar(1L, CpOrgaoUsuario.class, false));
		grpNovo.setHisDtIni(dao.consultarDataEHoraDoServidor());
		grpNovo.setCpGrupoPai(null);
		grpNovo.setDscGrupo("Teste");
		grpNovo.setSiglaGrupo("TESTE");
		grpNovo = (CpGrupo) dao.gravarComHistorico(grpNovo, null);
		Long idCpGrupo = grpNovo.getIdGrupo();

		// CpGrupo grpTest = CpDao.getInstance().consultar(idCpGrupo,
		// CpGrupo.class, false);

		Date dt1 = dao.consultarDataUltimaAtualizacao();
	}

	public void testGravarGrupoEAtualizar() throws AplicacaoException,
			Exception, IllegalAccessException {

		CpTipoGrupo tpGrp = dao.consultar(
				CpTipoGrupo.TIPO_GRUPO_GRUPO_DE_DISTRIBUICAO,
				CpTipoGrupo.class, false);
		dao.iniciarTransacao();

		CpGrupo grpNovo = new CpGrupoDeEmail();
		grpNovo.setCpTipoGrupo(tpGrp);
		grpNovo.setOrgaoUsuario(dao.consultar(1L, CpOrgaoUsuario.class, false));
		grpNovo.setCpGrupoPai(null);
		grpNovo.setDscGrupo("Teste");
		grpNovo.setSiglaGrupo("TESTE");
		grpNovo = (CpGrupo) dao.gravarComHistorico(grpNovo, null, null, null);
		Long idCpGrupo = grpNovo.getIdGrupo();

		// dao.commitTransacao();

		CpGrupo grp = grpNovo;
		grpNovo = grp.getClass().newInstance();
		PropertyUtils.copyProperties(grpNovo, grp);
		grpNovo.setIdGrupo(null);
		grpNovo.setCpGrupoPai(null);
		grpNovo.setDscGrupo("Teste");
		grpNovo.setSiglaGrupo("TESTE");

		// dao.iniciarTransacao();
		grp = (CpGrupo) dao.gravarComHistorico(grpNovo, grp, null, null);

	}

	public void testAtualizarGrupoSemAlteracao() throws AplicacaoException,
			Exception, IllegalAccessException {

		dao.iniciarTransacao();

		CpGrupo grpIni = dao.listarGruposDeEmail().get(0);

		CpGrupo grp = (CpGrupo) Objeto.getImplementation(dao.consultar(
				grpIni.getId(), CpGrupo.class, false));
		CpGrupo grpNovo = ((CpGrupo) Objeto.getImplementation(grp)).getClass()
				.newInstance();
		PropertyUtils.copyProperties(grpNovo, grp);
		grpNovo.setIdGrupo(null);
		CpGrupo grpRecebido = (CpGrupo) dao.gravarComHistorico(grpNovo, grp,
				null, null);

		assertEquals(grpRecebido, grp);
	}

	public void testAtualizarGrupoComAlteracao() throws AplicacaoException,
			Exception, IllegalAccessException {

		dao.iniciarTransacao();

		CpGrupo grpIni = dao.listarGruposDeEmail().get(0);

		CpGrupo grp = (CpGrupo) Objeto.getImplementation(dao.consultar(
				grpIni.getId(), CpGrupo.class, false));
		CpGrupo grpNovo = ((CpGrupo) Objeto.getImplementation(grp)).getClass()
				.newInstance();
		PropertyUtils.copyProperties(grpNovo, grp);
		grpNovo.setIdGrupo(null);
		grpNovo.setDscGrupo(grp.getDscGrupo() + ".");
		CpGrupo grpRecebido = (CpGrupo) dao.gravarComHistorico(grpNovo, grp,
				null, null);

		assertEquals(grpRecebido, grpNovo);
	}

	public void testPesquisarConfiguracaoPorTipoLotacao()
			throws AplicacaoException, Exception, IllegalAccessException {
		CpTipoLotacao t_ctlTipoLotacao = dao.consultar(101L,
				CpTipoLotacao.class, false);
		final Query query = dao.getSessao().getNamedQuery(
				"consultarCpConfiguracoesPorTipoLotacao");
		query.setLong("idTpLotacao", t_ctlTipoLotacao.getIdTpLotacao());
		ArrayList<CpConfiguracao> t_arlConfigServicos = (ArrayList<CpConfiguracao>) query
				.list();
		ArrayList<CpServico> t_arlServicos = new ArrayList<CpServico>();
		for (CpConfiguracao t_cfgConfiguracao : t_arlConfigServicos) {
			t_arlServicos.add(t_cfgConfiguracao.getCpServico());
		}
		assertTrue(t_arlServicos.size() > 0);
	}

	public void testConsultarTipoServico() {
		CpTipoServico tpsrv = dao.consultar(CpTipoServico.TIPO_CONFIG_SISTEMA,
				CpTipoServico.class, false);
		assertNotNull(tpsrv);
	}

	/*
	 * O M�TODO testBL foi DESATIVADO pois est� usando a conta de um usu�rio
	 * real e, al�m disso, disparando e-mais por causa das trocas de senha e
	 * cria��o de identidades. Esse teste deve ser REFATORADO para fazer parte
	 * da integra��o cont�nua.
	 */
	public void __DESATIVADO__testBL() throws AplicacaoException, Exception,
			IllegalAccessException {

		// Carrega uma identidade ativa
		CpIdentidade idAntiga = null;
		try {
			idAntiga = dao.consultaIdentidadeCadastrante(LOGIN, true);
		} catch (Exception e) {
		}

		// Cancela a identidade
		if (idAntiga != null) {
			CpIdentidade idCancelada = null;
			Cp.getInstance().getBL().cancelarIdentidade(idAntiga, null);
			try {
				idCancelada = dao.consultaIdentidadeCadastrante(LOGIN, true);
			} catch (Exception e) {
			}
			assertNull(idCancelada);
		}

		// Cria uma nova identidade
		CpIdentidade idNova = Cp.getInstance().getBL()
				.criarIdentidade(LOGIN, CPF, null, null, null, false);
		assertTrue(idNova.getDscSenhaIdentidade().length() > 0);

		// Altera a identidade
		Date dt = dao.consultarDataEHoraDoServidor();
		Calendar c = Calendar.getInstance();
		c.setTime(dt);
		c.add(Calendar.YEAR, 1);
		CpIdentidade idAlterada = Cp.getInstance().getBL()
				.alterarIdentidade(idNova, c.getTime(), null);
		assertEquals(idAlterada.getDtExpiracaoIdentidade(), c.getTime());

		// Se n�o h� altera��o, a ID deve ser mantida
		CpIdentidade idAlterada2 = Cp.getInstance().getBL()
				.alterarIdentidade(idAlterada, c.getTime(), null);
		assertEquals(idAlterada.getId(), idAlterada2.getId());

		// Altera novamente e verifica se foi criada uma nova ID
		CpIdentidade idAlterada3 = Cp.getInstance().getBL()
				.alterarIdentidade(idAlterada, null, null);
		assertFalse(idAlterada3.getId().equals(idAlterada2.getId()));

		// Verificar se a busca por identidades retorna somente um item
		List<CpIdentidade> l = dao
				.consultaIdentidades(idAlterada.getDpPessoa());
		assertEquals(l.size(), 1);

		// A identidade est� bloqueada?
		assertFalse(idAlterada.isBloqueada());

		// A pessoa est� bloqueada?
		assertFalse(idAlterada.getDpPessoa().isBloqueada());

		// Bloquear a identidade
		Cp.getInstance().getBL().bloquearIdentidade(idAlterada, null, true);
		assertTrue(idAlterada.isBloqueada());
		assertFalse(idAlterada.getDpPessoa().isBloqueada());

		// Desbloquear a identidade
		Cp.getInstance().getBL().bloquearIdentidade(idAlterada, null, false);
		assertFalse(idAlterada.isBloqueada());
		assertFalse(idAlterada.getDpPessoa().isBloqueada());

		// Bloquear a pessoa
		Cp.getInstance().getBL()
				.bloquearPessoa(idAlterada.getDpPessoa(), null, true);
		assertTrue(idAlterada.isBloqueada());
		assertTrue(idAlterada.getDpPessoa().isBloqueada());

		// Desnloquear a pessoa
		Cp.getInstance().getBL()
				.bloquearPessoa(idAlterada.getDpPessoa(), null, false);
		assertFalse(idAlterada.getDpPessoa().isBloqueada());

		// Depois de desbloquear a pessoa, a identidade continua bloqueada. Por
		// isso, temos que desbloquea-la tb.
		assertTrue(idAlterada.isBloqueada());
		Cp.getInstance().getBL().bloquearIdentidade(idAlterada, null, false);
		assertFalse(idAlterada.isBloqueada());

		/*
		 * O TESTE DE TROCA DE SENHA ABAIXO FOI DESATIVADO, PORQUE SEMPRE ENVIA
		 * E-MAIL PARA O USU�RIOCOM O BUILD AUTOMATICO DA FERRAMENTA HUDSON(CI).
		 */
		// Troca a senha
		String senha = decodificarSenha(idAlterada);
		CpIdentidade idNovaSenha = Cp
				.getInstance()
				.getBL()
				.trocarSenhaDeIdentidade(senha, NOVA_SENHA, NOVA_SENHA, LOGIN,
						null);
		assertEquals(decodificarSenha(idNovaSenha), NOVA_SENHA);

	}

	private String decodificarSenha(CpIdentidade id) throws Exception {
		BASE64Decoder b64dec = new BASE64Decoder();
		BASE64Encoder b64enc = new BASE64Encoder();
		String chave = b64enc.encode(id.getDpPessoa().getIdInicial().toString()
				.getBytes());
		String senha = new String(Criptografia.desCriptografar(
				b64dec.decodeBuffer(id.getDscSenhaIdentidadeCripto()), chave));

		return senha;
	}

	// Esse teste deve ficar sempre desativado. Caso ele seja executado, todas
	// as senhas ser�o lidas do esquema "ACESSO_TOMCAT" e depois ser�o escritas
	// identidades no esquema "CORPORATIVO"
	// public void testImportarAcessoTomcar() throws AplicacaoException,
	// Exception, IllegalAccessException {
	// dao.iniciarTransacao();
	// dao.importarAcessoTomcat();
	// dao.commitTransacao();
	// }

	// public void testRelAlteracaoDeAcesso() throws AplicacaoException,
	// Exception, IllegalAccessException {
	// Map<String, String> listaParametros = new HashMap<String, String>();
	// listaParametros.put("dataInicio", "06/01/2011");
	// listaParametros.put("dataFim", "06/01/2011");
	// listaParametros.put("idOrgaoUsuario", "1");
	// AlteracaoDireitosRelatorio rel = new AlteracaoDireitosRelatorio(
	// listaParametros);
	// rel.gerar();
	// }

	// public void testRelHistoricoUsuario() throws AplicacaoException,
	// Exception, IllegalAccessException {
	// Map<String, String> listaParametros = new HashMap<String, String>();
	// listaParametros.put("idPessoa", "160632");
	// HistoricoUsuarioRelatorio rel = new HistoricoUsuarioRelatorio(
	// listaParametros);
	// rel.gerar();
	// }

	/**
	 * @param args
	 * @throws Exception
	 * @throws NoSuchMethodException
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws SecurityException
	 */
	public static void main(String[] args) throws SecurityException,
			IllegalAccessException, InvocationTargetException,
			NoSuchMethodException, Exception {

		CpAmbienteEnumBL ambiente = CpAmbienteEnumBL.DESENVOLVIMENTO;
		Cp.getInstance().getProp().setPrefixo(ambiente.getSigla());

		AnnotationConfiguration cfg = CpDao.criarHibernateCfg(ambiente);
		HibernateUtil.configurarHibernate(cfg, "");

		CpDao dao = CpDao.getInstance();

		System.out.println("Data e hora da ultima atualiza��o - "
				+ dao.consultarDataUltimaAtualizacao());

		dao.iniciarTransacao();
		// dao.importarAcessoTomcat();
		dao.commitTransacao();

		if (true)
			return;

		CpServico ser = dao.consultar(3L, CpServico.class, false);
		System.out.println(ser.getSiglaServico() + " - " + ser.getDscServico());

		DpPessoa pesSigla = new DpPessoa();
		pesSigla.setSesbPessoa("RJ");
		pesSigla.setMatricula(13635L);
		DpPessoa pes = dao.consultarPorSigla(pesSigla);

		System.out.println(pes.getSigla() + " - " + pes.getDescricao());
		System.out.println(pes.getCargo().getDescricao());
		System.out.println(pes.getFuncaoConfianca().getDescricao());
		System.out.println(pes.getLotacao().getSigla() + " - "
				+ pes.getLotacao().getDescricao());

		DpPessoaDaoFiltro flt = new DpPessoaDaoFiltro();
		flt.setSigla(LOGIN);
		System.out.print("consultarQuantidade: ");
		System.out.println(dao.consultarQuantidade((DaoFiltro) flt));

		CpDao.freeInstance();
	}

	public static void printSchema(SessionFactory fact, Configuration cfg) {
		Dialect dialect = Dialect.getDialect(cfg.getProperties());
		// printDropSchemaScript(cfg, dialect);
		// printSchemaCreationScript(cfg, dialect);
		printSchemaUpdateScript(fact, cfg, dialect);
	}

	public static void printSchemaCreationScript(final Configuration cfg,
			final Dialect dialect) {
		String[] schemaCreationScript = cfg
				.generateSchemaCreationScript(dialect);
		for (String stmt : schemaCreationScript) {
			System.out.println(stmt + ";");
		}
	}

	public static void printDropSchemaScript(final Configuration cfg,
			final Dialect dialect) {
		String[] dropSchemaScript = cfg.generateDropSchemaScript(dialect);
		for (String stmt : dropSchemaScript) {
			System.out.println(stmt + ";");
		}
	}

	public static void printSchemaUpdateScript(final SessionFactory sf,
			final Configuration cfg, final Dialect dialect) {
		DatabaseMetadata metadata;
		try {
			metadata = new DatabaseMetadata(HibernateUtil.getSessao()
					.connection(), dialect);
			String[] schemaUpdateScript = cfg.generateSchemaUpdateScript(
					dialect, metadata);
			for (String stmt : schemaUpdateScript) {
				System.out.println(stmt + ";");
			}
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
