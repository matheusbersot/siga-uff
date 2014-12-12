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
package br.gov.jfrj.siga.cp.bl;

public class Cp<TConf extends CpConfiguracaoBL, TComp extends CpCompetenciaBL, TBL extends CpBL, TProp extends CpPropriedadeBL> {
	@SuppressWarnings("unchecked")
	static private Cp instance;

	TComp comp;
	TConf conf;
	TBL BL;
	TProp prop;

	public TBL getBL() {
		return BL;
	}

	public void setBL(TBL bl) {
		BL = bl;
	}

	@SuppressWarnings("unchecked")
	public static Cp getInstance() {
		if (instance == null) {
			synchronized (Cp.class) {
				if (instance == null) {
					instance = new Cp();
					instance.setConf(new CpConfiguracaoBL());
					instance.getConf().setComparator(
							new CpConfiguracaoComparator());
					instance.setComp(new CpCompetenciaBL());
					instance.getComp().setConfiguracaoBL(instance.getConf());
					instance.setBL(new CpBL());
					instance.getBL().setComp(instance.getComp());
					instance.setProp(new CpPropriedadeBL());
				}
			}
		}
		return instance;
	}

	public static void setInstance(Cp instance) {
		Cp.instance = instance;
	}

	public static boolean isInstantiated() {
		return instance != null;
	}

	public TComp getComp() {
		return comp;
	}

	public void setComp(TComp comp) {
		this.comp = comp;
	}

	public TConf getConf() {
		return conf;
	}

	public void setConf(TConf conf) {
		this.conf = conf;
	}

	/**
	 * @return the prop
	 */
	public TProp getProp() {
		return prop;
	}

	/**
	 * @param prop
	 *            the prop to set
	 */
	public void setProp(TProp prop) {
		this.prop = prop;
	}

}
