package org.kframework.kil;

import org.w3c.dom.Element;

import aterm.ATermAppl;

/**
 * Abstract KLabel class.
 */
public abstract class KLabel extends Term {

	protected KLabel() {
		super(KSorts.KLABEL);
	}

	protected KLabel(Element element) {
		super(element);
		this.sort = KSorts.KLABEL;
		//System.out.println(this.sort);
		//assert this.sort.equals(KSorts.KLABEL);
	}

	public KLabel(ATermAppl atm) {
		super(atm);
		//assert this.sort.equals(KSorts.KLABEL);
	}

	protected KLabel(KLabel kLabel) {
		super(kLabel);
	}
}
