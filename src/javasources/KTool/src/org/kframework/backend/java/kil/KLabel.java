package org.kframework.backend.java.kil;

import org.kframework.backend.java.symbolic.Transformer;
import org.kframework.backend.java.symbolic.Visitor;
import org.kframework.kil.ASTNode;


/**
 * A KLabel.
 *
 * @author AndreiS
 */
public abstract class KLabel extends Term {

    protected KLabel() {
        super(Kind.KLABEL);
    }

    @Override
    public boolean isSymbolic() {
        /* AndreiS: no support for symbolic KLabels */
        return false;
    }

    /**
     * Checks if this {@code KLabel} represents a constructor. A {@code KLabel}
     * represents either a constructor or a function.
     * 
     * @return true if this {@code KLabel} represents a constructor; otherwise,
     *         false
     */
    public abstract boolean isConstructor();

    /**
     * Checks if this {@code KLabel} represents a function. A {@code KLabel}
     * represents either a constructor or a function.
     * 
     * @return true if this {@code KLabel} represents a function; otherwise,
     *         false
     */
    public abstract boolean isFunction();

    @Override
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }

    @Override
    public ASTNode accept(Transformer transformer) {
        return transformer.transform(this);
    }

}
