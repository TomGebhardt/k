require "k-equal.k"
module INT-SYNTAX-HOOKS
  imports #INT-INTERFACE
  syntax Int ::= #Int
endmodule

module INT-HOOKS
  imports INT-SYNTAX-HOOKS 
  imports BOOL-HOOKS
  imports K-EQUAL-HOOKS

  syntax Int ::= right:
                 "~Int" Int                     [function, right, latex(\mathop{\sim_{\scriptstyle\it Int}}{#1}), hook(#INT:~Int_)]
               > left:
                 Int "^Int" Int                 [function, left, latex({#1}\mathrel{{\char`\^}_{\!\scriptstyle\it Int}}{#2}), hook(#INT:_^Int_)]
               > left:
                 Int "*Int" Int                 [function, left, smtlib(*), latex({#1}\mathrel{\ast_{\scriptstyle\it Int}}{#2}), hook(#INT:_*Int_)]
               /* FIXME: translate /Int and %Int into smtlib */
               /* /Int and %Int implement t-division */
               | Int "/Int" Int                 [function, left, latex({#1}\mathrel{\div_{\scriptstyle\it Int}}{#2}), hook(#INT:_/Int_)]
               | Int "%Int" Int                 [function, left, latex({#1}\mathrel{\%_{\scriptstyle\it Int}}{#2}), hook(#INT:_%Int_)]
               /* divInt and modInt implement e-division */
               | Int "divInt" Int               [function, left, smtlib(div)]
               | Int "modInt" Int               [function, left, smtlib(mod)]
               > left:
                 Int "+Int" Int                 [function, left, smtlib(+), latex({#1}\mathrel{+_{\scriptstyle\it Int}}{#2}), hook(#INT:_+Int_), cons(Int1PlusSyn)]
               | Int "-Int" Int                 [function, left, smtlib(-), latex({#1}\mathrel{-_{\scriptstyle\it Int}}{#2}), hook(#INT:_-Int_)]
               > left:
                 Int ">>Int" Int                [function, left, latex({#1}\mathrel{\gg_{\scriptstyle\it Int}}{#2}), hook(#INT:_>>Int_)]
               | Int "<<Int" Int                [function, left, latex({#1}\mathrel{\ll_{\scriptstyle\it Int}}{#2}), hook(#INT:_<<Int_)]
               > left:
                 Int "&Int" Int                 [function, left, latex({#1}\mathrel{\&_{\scriptstyle\it Int}}{#2}), hook(#INT:_&Int_)]
               > left:
                 Int "xorInt" Int               [function, left, latex({#1}\mathrel{\oplus_{\scriptstyle\it Int}}{#2}), hook(#INT:_xorInt_)]
               > left:
                 Int "|Int" Int                 [function, left, latex({#1}\mathrel{|_{\scriptstyle\it Int}}{#2}), hook(#INT:_|Int_)]
               | "minInt" "(" Int "," Int ")"   [function]
               | "maxInt" "(" Int "," Int ")"   [function]
               | "absInt" "(" Int ")"           [function, smtlib(abs), klabel(absInt), hook(#INT:absInt)]

  rule I1:#Int divInt I2:#Int => (I1 -Int (I1 modInt I2)) /Int I2
  when I2 =/=Int 0
  rule
    I1:#Int modInt I2:#Int
  =>
    ((I1 %Int absInt(I2)) +Int absInt(I2)) %Int absInt(I2)
  when I2 =/=Int 0

  rule minInt(I1:Int, I2:Int) => #if I1 <Int I2 #then I1 #else I2 #fi
  rule maxInt(I1:Int, I2:Int) => #if I1 >Int I2 #then I1 #else I2 #fi

  // absInt hooked
  // rule absInt(I:Int) => I when I >=Int 0
  // rule absInt(I:Int) => 0 -Int I when I <Int 0

  syntax Bool ::= Int "<=Int" Int         [function, left, smtlib(<=), latex({#1}\mathrel{\leq_{\scriptstyle\it Int}}{#2}), hook(#INT:_<=Int_)]
                | Int "<Int" Int          [function, left, smtlib(<), latex({#1}\mathrel{<_{\scriptstyle\it Int}}{#2}), hook(#INT:_<Int_)]
                | Int ">=Int" Int         [function, left, smtlib(>=), latex({#1}\mathrel{\geq_{\scriptstyle\it Int}}{#2}), hook(#INT:_>=Int_)]
                | Int ">Int" Int          [function, left, smtlib(>), latex({#1}\mathrel{>_{\scriptstyle\it Int}}{#2}), hook(#INT:_>Int_)]
                | Int "==Int" Int         [function, left, smtlib(=), latex({#1}\mathrel{{=}{=}_{\scriptstyle\it Int}}{#2}), hook(#INT:_==Int_)]
                | Int "=/=Int" Int        [function, left, smtlib(distinct), latex({#1}\mathrel{{=}{/}{=}_{\scriptstyle\it Int}}{#2}), hook(#INT:_=/=Int_)]
                | Int "=Int" Int          [equality, function, hook(#INT:_==Int_)]
                | Int "dividesInt" Int    [function]

  rule I1:Int =/=Int I2:Int => notBool(I1 ==Int I2)
  rule (I1:Int dividesInt I2:Int) => (I2 %Int I1) ==Int 0

  //sort Nat ::= {I:Int | I >=Int 0}
  syntax Nat
  rule isNat(I:Int) => I >=Int 0 [function, anywhere]

  rule 0 +Int I:Int => I [anywhere]
  rule 0 *Int I:Int => 0 [anywhere]
endmodule

