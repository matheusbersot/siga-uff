package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import models.GcInformacao;
import models.GcTag;
import models.GcTipoInformacao;
import play.db.jpa.JPA;
import br.gov.jfrj.siga.dp.CpMarcador;
import br.gov.jfrj.siga.dp.CpOrgaoUsuario;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.DpPessoa;

public class GcInformacaoFiltro extends GcInformacao {
	
	public boolean pesquisa = false;
	public String dtCriacaoIni;
	public String dtCriacaoFim;
	public String dtIni;
	public String dtFim;
	public CpMarcador situacao;
	public CpOrgaoUsuario orgaoUsu;
	public String titulo;
	public String conteudo;
	public GcTag tag;
	public DpPessoa responsavel;
	public DpLotacao lotaResponsavel;

	public List<GcInformacao> buscar() {
		
		String query = null;
		final SimpleDateFormat dfUsuario = new SimpleDateFormat("dd/MM/yyyy");
		final SimpleDateFormat dfHibernate = new SimpleDateFormat("yyyy-MM-dd");

		query = "from GcInformacao inf where inf.hisDtIni is not null ";

		if(tag != null)
			//query = "select inf from models.GcInformacao as inf inner join inf.tags as tag where inf.hisDtFim is null and tag.id = " + tag.id;
			query = "select inf from GcInformacao inf inner join inf.tags tags where tags.titulo = '" + tag.titulo + "'";
			//query += " and inf.tags.id = " + tag.id;

		if(orgaoUsu != null)
			query += " and inf.ou = " + orgaoUsu.getId();
		
		if(autor != null)
			query += " and inf.autor.idPessoaIni = " + autor.getIdInicial();
		if(lotacao != null)
			query += " and inf.lotacao.idLotacaoIni = " + lotacao.getIdInicial();
		
		if(tipo != null)
				query += " and inf.tipo = " + tipo.id;
		
		if(ano != null)
			query += " and inf.ano = " + Integer.parseInt(ano.toString());
		
		if(numero != null)
			query += " and inf.numero = " + Integer.parseInt(numero.toString());
		
		if(conteudo != null && !conteudo.trim().equals("")) {
			for (String s : conteudo.split(" ")){
				/*query += " and lower(inf.arq.conteudo) like '%"
						+ s.toLowerCase() + "%' ";
				 */		
				//forma de consultar em uma coluna BLOB através do SQL
				query += " and dbms_lob.instr(inf.arq.conteudo,utl_raw.cast_to_raw('" + s + "'),1,1) > 0";
			}	
		}
		if(titulo != null && !titulo.trim().equals("")){
			for (String t : titulo.split(" "))
				query += " and lower(inf.arq.titulo) like '%" + t.toLowerCase() + "%' ";
		}

		if (dtCriacaoIni != null && !dtCriacaoIni.trim().equals(""))
			try {
				query += " and inf.hisDtIni >= to_date('"
						+ dfHibernate.format(dfUsuario.parse(dtCriacaoIni))
						+ "', 'yyyy-MM-dd') ";
			} catch (ParseException e) {
				//
			}

		if (dtCriacaoFim != null && !dtCriacaoFim.trim().equals(""))
			try {
				query += " and inf.hisDtIni <= to_date('"
						+ dfHibernate.format(dfUsuario.parse(dtCriacaoFim))
						+ " 23:59', 'yyyy-MM-dd HH24:mi') ";
			} catch (ParseException e) {
				//
			}
		
		String subquery = "";

		if (situacao != null && situacao.getIdMarcador() != null && situacao.getIdMarcador() > 0)
			subquery += " and situacao.cpMarcador.idMarcador = " + situacao.getIdMarcador() + 
						" and (situacao.dtFimMarca is null or situacao.dtFimMarca > sysdate)";

		if (responsavel != null)
			subquery += " and situacao.dpPessoaIni.idPessoa = " + responsavel.getIdInicial();
		if (lotaResponsavel != null)
			subquery += " and situacao.dpLotacaoIni.idLotacao  = " + lotaResponsavel.getIdInicial();
		
		if (dtIni != null && !dtIni.trim().equals(""))
			try {
				subquery += " and situacao.dtIniMarca >= to_date('"
						+ dfHibernate.format(dfUsuario.parse(dtIni))
						+ "', 'yyyy-MM-dd') ";
			} catch (ParseException e) {
				//
			}

		if (dtFim != null && !dtFim.trim().equals(""))
			try {
				subquery += " and situacao.dtIniMarca <= to_date('"
						+ dfHibernate.format(dfUsuario.parse(dtFim))
						+ " 23:59', 'yyyy-MM-dd HH24:mi') ";
			} catch (ParseException e) {
				//
			}
		if (subquery.length() > 0)
			subquery = " and exists (from GcMarca situacao where situacao.inf = inf "
					+ subquery + " )";

		List listaRetorno = JPA.em().createQuery(query + subquery + "order by inf.hisDtIni desc")
				.getResultList();

		return listaRetorno;
	}
}
