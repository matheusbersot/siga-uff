package util;

import java.lang.annotation.Annotation;
import java.lang.reflect.Type;

import play.data.binding.Global;
import play.data.binding.TypeBinder;
import play.db.jpa.JPA;
import br.gov.jfrj.siga.dp.DpPessoa;
 
@Global
public class DpPessoaBinder implements TypeBinder<DpPessoa> {

	@Override
	public Object bind(String name, Annotation[] anns, String value,
			Class clazz, Type arg4) throws Exception {
		if (value != null && !value.equals(""))
			return JPA.em().find(DpPessoa.class, Long.valueOf(value));
		return null;
	}

}
