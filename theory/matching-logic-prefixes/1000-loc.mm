$( MATCHING LOGIC $)

$c #Pattern $.
$c #ElementVariable $.
$c #SetVariable $.
$c #Variable $.
$c #Symbol $.

$v ph0 ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 $.
$v th0 th1 th2 th3 th4 th5 th6 th7 th8 $.
$v x y z w $.
$v X Y Z W $.
$v xX yY $.
$v sg0 sg1 sg2 sg3 sg4 $.

ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
ph7-is-pattern $f #Pattern ph7 $.
ph8-is-pattern $f #Pattern ph8 $.

th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
th4-is-pattern $f #Pattern th4 $.
th5-is-pattern $f #Pattern th5 $.
th6-is-pattern $f #Pattern th6 $.
th7-is-pattern $f #Pattern th7 $.
th8-is-pattern $f #Pattern th8 $.

x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
w-is-element-var $f #ElementVariable w $.

X-is-element-var $f #SetVariable X $.
Y-is-element-var $f #SetVariable Y $.
Z-is-element-var $f #SetVariable Z $.
W-is-element-var $f #SetVariable W $.

xX-is-var $f #Variable xX $.
yY-is-var $f #Variable yY $.

sg0-is-symbol $f #Symbol sg0 $.
sg1-is-symbol $f #Symbol sg1 $.
sg2-is-symbol $f #Symbol sg2 $.
sg3-is-symbol $f #Symbol sg3 $.
sg4-is-symbol $f #Symbol sg4 $.

element-var-is-var $a #Variable x $.
set-var-is-var     $a #Variable X $.
var-is-pattern     $a #Pattern xX $.
symbol-is-pattern  $a #Pattern sg0 $.

$c #Positive $.
$c #Negative $.
$c #Fresh $.
$c #ApplicationContext $.
$c #Substitution $.
$c #Notation $.
$c |- $.

$c \bot    $.
$c \imp    $.
$c \app    $.
$c \exists $.
$c \mu     $.
$c ( )     $.

bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
${ 
    mu-is-pattern.0 $e #Positive X ph0 $.
    mu-is-pattern   $a #Pattern ( \mu X ph0 ) $.
$}

$( #Positive and #Negative $)

positive-in-var $a #Positive xX yY $.
positive-in-symbol $a #Positive xX sg0 $.
positive-in-bot $a #Positive xX \bot $.
${
    positive-in-imp.0 $e #Negative xX ph0 $.
    positive-in-imp.1 $e #Positive xX ph1 $.
    positive-in-imp   $a #Positive xX ( \imp ph0 ph1 ) $.
$}
${
    positive-in-app.0 $e #Positive xX ph0 $.
    positive-in-app.1 $e #Positive xX ph1 $.
    positive-in-app   $a #Positive xX ( \app ph0 ph1 ) $.
$}
${
    positive-in-exists.0 $e #Positive xX ph0 $.
    positive-in-exists   $a #Positive xX ( \exists x ph0 ) $.
$}
${
    positive-in-mu.0 $e #Positive xX ph0 $.
    positive-in-mu   $a #Positive xX ( \mu X ph0 ) $.
$}
${
    $d xX ph0 $.
    positive-disjoint $a #Positive xX ph0 $.
$}

${
    $d xX yY $.
    negative-in-var $a #Negative xX yY $.
$}
negative-in-symbol $a #Negative xX sg0 $.
negative-in-bot $a #Negative xX \bot $.
${
    negative-in-imp.0 $e #Positive xX ph0 $.
    negative-in-imp.1 $e #Negative xX ph1 $.
    negative-in-imp   $a #Negative xX ( \imp ph0 ph1 ) $.
$}
${
    negative-in-app.0 $e #Negative xX ph0 $.
    negative-in-app.1 $e #Negative xX ph1 $.
    negative-in-app   $a #Negative xX ( \app ph0 ph1 ) $.
$}
${
    negative-in-exists.0 $e #Negative xX ph0 $.
    negative-in-exists   $a #Negative xX ( \exists x ph0 ) $.
$}
${
    negative-in-mu.0 $e #Negative xX ph0 $.
    negative-in-mu   $a #Negative xX ( \mu X ph0 ) $.
$}
${
    $d xX ph0 $.
    negative-disjoint $a #Negative xX ph0 $.
$}

$( Fresh $)

${
    $d xX yY $.
    fresh-in-var $a #Fresh xX yY $.
$}
fresh-in-symbol $a #Fresh xX sg0 $.
fresh-in-bot    $a #Fresh xX \bot $.
${
    fresh-in-imp.0 $e #Fresh xX ph0 $.
    fresh-in-imp.1 $e #Fresh xX ph1 $.
    fresh-in-imp   $a #Fresh xX ( \imp ph0 ph1 ) $.
$}
${
    fresh-in-app.0 $e #Fresh xX ph0 $.
    fresh-in-app.1 $e #Fresh xX ph1 $.
    fresh-in-app   $a #Fresh xX ( \app ph0 ph1 ) $.
$}
${
    $d xX x $.
    fresh-in-exists.0 $e #Fresh xX ph0 $.
    fresh-in-exists $a #Fresh xX ( \exists x ph0 ) $.
$}
fresh-in-exists-shadowed $a #Fresh x ( \exists x ph0 ) $.
${
    $d xX X $.
    fresh-in-mu.0 $e #Fresh xX ph0 $.
    fresh-in-mu   $a #Fresh xX ( \mu X ph0 ) $.
$}
fresh-in-mu-shadowed $a #Fresh X ( \mu X ph0 ) $.
${
    $d xX ph0 $.
    fresh-disjoint $a #Fresh xX ph0 $.
$}
${
    fresh-in-substitution.0 $e #Fresh xX ph1 $.
    fresh-in-substitution.1 $e #Substitution ph2 ph0 ph1 xX $.
    fresh-in-substitution $a #Fresh xX ph2 $.
$}
${
    fresh-after-substitution.0 $e #Fresh xX ph0 $.
    fresh-after-substitution.1 $e #Fresh xX ph1 $.
    fresh-after-substitution.2 $e #Substitution ph2 ph0 ph1 yY $.
    fresh-after-substitution $a #Fresh xX ph2 $.
$}

$( Substitution $)
$( #Substitution ph0 ph1 ph2 xX means ph0 === ph1[ph2/xX] $)

substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${
    $d xX yY $.
    substitution-var-diff $a #Substitution yY yY ph0 xX $.
$}
substitution-symbol $a #Substitution sg0 sg0 ph0 xX $.
substitution-bot    $a #Substitution \bot \bot ph0 xX $.
${
    substitution-imp.0  $e #Substitution ph1 ph3 ph0 xX $.
    substitution-imp.1  $e #Substitution ph2 ph4 ph0 xX $.
    substitution-imp    $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $.
$}
${
    substitution-app.0  $e #Substitution ph1 ph3 ph0 xX $.
    substitution-app.1  $e #Substitution ph2 ph4 ph0 xX $.
    substitution-app    $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph0 xX $.
$}
substitution-exists-shadowed $a #Substitution ( \exists x ph1 ) ( \exists x ph1 ) ph0 x $.
${
    $d xX x  $.
    $d y ph0 $.
    substitution-exists.0 $e #Substitution ph2 ph1 y x $.
    substitution-exists.1 $e #Substitution ph3 ph2 ph0 xX $.
    substitution-exists   $a #Substitution ( \exists y ph3 ) ( \exists x ph1 ) ph0 xX $.
$}
substitution-mu-shadowed $a #Substitution ( \mu X ph1 ) ( \mu X ph1 ) ph0 X $.
${
    $d xX X  $.
    $d Y ph0 $.
    substitution-mu.0 $e #Substitution ph2 ph1 Y X $.
    substitution-mu.1 $e #Substitution ph3 ph2 ph0 xX $.
    substitution-mu   $a #Substitution ( \mu Y ph3 ) ( \mu X ph1 ) ph0 xX $.
$}
substitution-identity $a #Substitution ph0 ph0 xX xX $.
${
    $( if yY is free in ph0, then (ph0[yY/xX])[ph3/yY] === ph0[ph3/xX] $)
    yY-free-in-ph0 $e #Fresh yY ph0 $.
    ph1-definition $e #Substitution ph1 ph0 yY xX $.
    ${
        substitution-fold.0   $e #Substitution ph2 ph1 ph3 yY $.
        substitution-fold     $a #Substitution ph2 ph0 ph3 xX $.
    $}
    ${
        substitution-unfold.0 $e #Substitution ph2 ph0 ph3 xX $.
        substitution-unfold   $a #Substitution ph2 ph1 ph3 yY $.
    $}
$}
${
    substitution-inverse.0 $e #Fresh xX ph0 $.
    substitution-inverse.1 $e #Substitution ph1 ph0 xX yY $.
    substitution-inverse   $a #Substitution ph0 ph1 yY xX $.
$}
${
    substitution-fresh.0 $e #Fresh xX ph0 $.
    substitution-fresh $a #Substitution ph0 ph0 ph1 xX $.
$}

$( Application Contexts $)

application-context-var $a #ApplicationContext xX xX $.
${
    $d xX ph1 $.
    application-context-app-left.0 $e #ApplicationContext xX ph0 $.
    application-context-app-left   $a #ApplicationContext xX ( \app ph0 ph1 ) $.
$}
${
    $d xX ph0 $.
    application-context-app-right.0 $e #ApplicationContext xX ph1 $.
    application-context-app-right   $a #ApplicationContext xX ( \app ph0 ph1 ) $.
$}

$( Meta-Level Equality for Defining Syntactic Sugar $)
$( #Notation is a congruence. $)

notation-reflexivity $a #Notation ph0 ph0 $.
${
    notation-symmetry.0 $e #Notation ph0 ph1 $.
    notation-symmetry   $a #Notation ph1 ph0 $.
$}
${
    notation-transitivity.0 $e #Notation ph0 ph1 $.
    notation-transitivity.1 $e #Notation ph1 ph2 $.
    notation-transitivity   $a #Notation ph0 ph2 $.
$}
${
    notation-positive.0 $e #Positive xX ph0 $.
    notation-positive.1 $e #Notation ph1 ph0 $.
    notation-positive   $a #Positive xX ph1 $.
$}
${
    notation-negative.0 $e #Negative xX ph0 $.
    notation-negative.1 $e #Notation ph1 ph0 $.
    notation-negative   $a #Negative xX ph1 $.
$}
${
    notation-fresh.0 $e #Fresh xX ph0 $.
    notation-fresh.1 $e #Notation ph1 ph0 $.
    notation-fresh   $a #Fresh xX ph1 $.
$}
${
    notation-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
    notation-substitution.1 $e #Notation ph3 ph0 $.
    notation-substitution.2 $e #Notation ph4 ph1 $.
    notation-substitution.3 $e #Notation ph5 ph2 $.
    notation-substitution   $a #Substitution ph3 ph4 ph5 xX $.
$}
${
    notation-notation.0 $e #Notation ph0 ph1 $.
    notation-notation.1 $e #Notation ph2 ph0 $.
    notation-notation.2 $e #Notation ph3 ph1 $.
    notation-notation   $p #Notation ph2 ph3 $=
        $(
            apply "notation-transitivity"
            apply "notation-notation.1"
            apply "notation-transitivity"
            apply "notation-notation.0"
            apply "notation-symmetry"
            apply "notation-notation.2"
        $)
        ( notation-transitivity notation-symmetry ) CADFABDEDBGIHH $.
$}
${
    notation-application-context.0 $e #ApplicationContext xX ph0 $.
    notation-application-context.1 $e #Notation ph1 ph0 $.
    notation-application-context   $a #ApplicationContext xX ph1 $.
$}
${
    notation-proof.0 $e |- ph0 $.
    notation-proof.1 $e #Notation ph1 ph0 $.
    notation-proof   $a |- ph1 $.
$}
${
    notation-imp.0 $e #Notation ph0 ph2 $.
    notation-imp.1 $e #Notation ph1 ph3 $.
    notation-imp $a #Notation ( \imp ph0 ph1 ) ( \imp ph2 ph3 ) $.
$}
${
    notation-app.0 $e #Notation ph0 ph2 $.
    notation-app.1 $e #Notation ph1 ph3 $.
    notation-app $a #Notation ( \app ph0 ph1 ) ( \app ph2 ph3 ) $.
$}
${
    notation-exists.0 $e #Notation ph0 ph1 $.
    notation-exists $a #Notation ( \exists x ph0 ) ( \exists x ph1 ) $.
$}
${
    notation-mu.0 $e #Notation ph0 ph1 $.
    notation-mu $a #Notation ( \mu X ph0 ) ( \mu X ph1 ) $.
$}

$( Defining Very Basic Syntactic Sugar $)
$( It is used in the proof system. $)

$c \not $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar   $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.

$c \or $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar   $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.

$c \and $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
and-is-sugar   $a #Notation ( \and ph0 ph1 ) ( \not ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.

$( Matching Logic Proof System $)
$(
   Part 1 (7 rules). FOL Reasoning
   Part 2 (8 rules). Frame Reasoning
   Part 3 (2 rules). Fixpoint Reasoning
   Part 4 (3 rules). Misc
   Total (20 rules).
$)

$( Proof System Part 1 (7 rules) $)
$( FOL Reasoning $)

proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
proof-rule-prop-2 $a |- ( \imp ( \imp ph0 ( \imp ph1 ph2 ) ) ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph2 ) ) ) $.
proof-rule-prop-3 $a |- ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 ) $.
${
    proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
    proof-rule-mp.1 $e |- ph0 $.
    proof-rule-mp   $a |- ph1 $.
$}
${
    proof-rule-exists.0 $e #Substitution ph0 ph1 y x $.
    proof-rule-exists   $a |- ( \imp ph0 ( \exists x ph1 ) ) $.
$}
${
    proof-rule-gen.0 $e |- ( \imp ph0 ph1 ) $.
    proof-rule-gen.1 $e #Fresh x ph1 $.
    proof-rule-gen   $a |- ( \imp ( \exists x ph0 ) ph1 ) $.
$}

$( Proof System Part 2 (8 rules) $)
$( Frame Reasoning $)

${
    proof-rule-propagation-bot.0 $e #ApplicationContext xX ph0 $.
    proof-rule-propagation-bot.1 $e #Substitution ph1 ph0 \bot xX $.
    proof-rule-propagation-bot $a |- ( \imp ph1 \bot ) $.
$}

${
    proof-rule-propagation-or.0 $e #ApplicationContext xX ph0 $.
    proof-rule-propagation-or.1 $e #Substitution ph1 ph0 ( \or ph4 ph5 ) xX $.
    proof-rule-propagation-or.2 $e #Substitution ph2 ph0 ph4 xX $.
    proof-rule-propagation-or.3 $e #Substitution ph3 ph0 ph5 xX $.
    proof-rule-propagation-or $a |- ( \imp ph1 ( \or ph2 ph3 ) ) $.
$}

${
    proof-rule-propagation-exists.0 $e #ApplicationContext xX ph0 $.
    proof-rule-propagation-exists.1 $e #Substitution ph1 ph0 ( \exists y ph3 ) xX $.
    proof-rule-propagation-exists.2 $e #Substitution ph2 ph0 ph3 xX $.
    proof-rule-propagation-exists.3 $e #Fresh y ph0 $.
    proof-rule-propagation-exists $a |- ( \imp ph1 ( \exists y ph2 ) ) $.
$}

${
    proof-rule-frame.0 $e #ApplicationContext xX ph0 $.
    proof-rule-frame.1 $e #Substitution ph1 ph0 ph3 xX $.
    proof-rule-frame.2 $e #Substitution ph2 ph0 ph4 xX $.
    proof-rule-frame.3 $e |- ( \imp ph3 ph4 ) $.
    proof-rule-frame   $a |- ( \imp ph1 ph2 ) $.
$}

$( Proof System Part 3 (2 rules) $)
$( Fixpoint Reasoning $)
${
    proof-rule-prefixpoint.0 $e #Substitution ph0 ph1 ( \mu X ph1 ) X $.
    proof-rule-prefixpoint   $a |- ( \imp ph0 ( \mu X ph1 ) ) $.
$}
${
    proof-rule-kt.0 $e #Substitution ph0 ph1 ph2 X $.
    proof-rule-kt.1 $e |- ( \imp ph0 ph2 ) $.
    proof-rule-kt   $a |- ( \imp ( \mu X ph1 ) ph2 ) $.
$}

$( Proof System Part 4 (3 rules) $)
$( Misc $)
${
    proof-rule-set-var-substitution.0 $e #Substitution ph0 ph1 ph2 X $.
    proof-rule-set-var-substitution.1 $e |- ph1 $.
    proof-rule-set-var-substitution   $a |- ph0 $.
$}

proof-rule-existence $a |- ( \exists x x ) $.

${
    proof-rule-singleton.0 $e #ApplicationContext xX ph0 $.
    proof-rule-singleton.1 $e #ApplicationContext yY ph1 $.
    proof-rule-singleton.2 $e #Substitution ph3 ph0 ( \and x ph2 ) xX $.
    proof-rule-singleton.3 $e #Substitution ph4 ph1 ( \and x ( \not ph2 ) ) yY $.
    proof-rule-singleton $a |- ( \not ( \and ph3 ph4 ) ) $.    
$}


$( MATCHING LOGIC PRELUDE $)
$(
    Part 0. More Metavariables
    Part 1. More Syntactic Sugar for Vanilla Matching Logic
    Part 2. Definedness
    Part 3. Sorts and Inhabitants
    Part 4. Special Patterns (Singletons, Top, Bottom, Predicates)
    Part 5. Constant, Unary, and Binary Functions (internal use only)
    Part 6. Unit
    Part 7. Pairs
    Part 8. Modality
$)

$( Part 0. More Metavariables $)

$v x0 x1 x2 x3 $.
x0-is-element-var $f #ElementVariable x0 $.
x1-is-element-var $f #ElementVariable x1 $.
x2-is-element-var $f #ElementVariable x2 $.
x3-is-element-var $f #ElementVariable x3 $.
$v s0 s1 s2 s3 $.
s0-is-element-var $f #ElementVariable s0 $.
s1-is-element-var $f #ElementVariable s1 $.
s2-is-element-var $f #ElementVariable s2 $.
s3-is-element-var $f #ElementVariable s3 $.


$( Part 1. More Syntactic Sugar for Vanilla Matching Logic $)

$c \top $.
top-is-pattern $a #Pattern \top $.
top-is-sugar   $a #Notation \top ( \not \bot ) $.

$c \iff $.
iff-is-pattern $a #Pattern ( \iff ph0 ph1 ) $.
iff-is-sugar   $a #Notation ( \iff ph0 ph1 ) ( \and ( \imp ph0 ph1 ) ( \imp ph1 ph0 ) ) $.

$c \forall $.
forall-is-pattern $a #Pattern ( \forall x ph0 ) $.
forall-is-sugar   $a #Notation ( \forall x ph0 ) ( \not ( \exists x ( \not ph0 ) ) ) $.

$c \nu $.
${
    nu-is-pattern.0 $e #Positive X ph0 $.
    nu-is-pattern   $a #Pattern ( \nu X ph0 ) $.
$}
${
    nu-is-sugar.0 $e #Substitution ph0 ph1 ( \not X ) X $.
    nu-is-sugar   $a #Notation ( \nu X ph1 ) ( \not ( \mu X ( \not ph0 ) ) ) $.
$}

$( Part 2. Definedness $)

$c \definedness $.
definedness-is-symbol $a #Symbol \definedness $.

$c \ceil $.
ceil-is-pattern $a #Pattern ( \ceil ph0 ) $.
ceil-is-sugar   $a #Notation ( \ceil ph0 ) ( \app \definedness ph0 ) $.

axiom-definedness $a |- ( \ceil x ) $.

$c \floor $.
floor-is-pattern $a #Pattern ( \floor ph0 ) $.
floor-is-sugar   $a #Notation ( \floor ph0 ) ( \not ( \ceil ( \not ph0 ) ) ) $.

$c \in $.
in-is-pattern $a #Pattern ( \in x ph0 ) $.
in-is-sugar   $a #Notation ( \in x ph0 ) ( \ceil ( \and x ph0 ) ) $.

$c \included $.
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
included-is-sugar   $a #Notation ( \included ph0 ph1 ) ( \floor ( \imp ph0 ph1 ) ) $.

$c \eq $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
eq-is-sugar   $a #Notation ( \eq ph0 ph1 ) ( \floor ( \iff ph0 ph1 ) ) $.

${
    eq-elim.0 $e #Substitution ph2 ph4 ph0 x $.
    eq-elim.1 $e #Substitution ph3 ph4 ph1 x $.
    eq-elim $a |- ( \imp ( \eq ph0 ph1 ) ( \imp ph2 ph3 ) ) $.
$}

$( Part 3. Sorts and Inhabitants $)

$c \sort $.
sort-is-symbol $a #Symbol \sort $.

$c \inhabitant $.
inhabitant-is-symbol $a #Symbol \inhabitant $.

$c \inh $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
inh-is-sugar   $a #Notation ( \inh ph0 ) ( \app \inhabitant ph0 ) $.

$c \in-sort $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
in-sort-is-sugar   $a #Notation ( \in-sort ph0 ph1 ) ( \included ph0 ( \inh ph1 ) ) $.

inh-sort-nonempty $a |- ( \exists x ( \in-sort x \sort ) ) $.

$c \sorted-forall $.
sorted-forall-is-pattern $a #Pattern ( \sorted-forall x ph0 ph1 ) $.
sorted-forall-is-sugar   $a #Notation ( \sorted-forall x ph0 ph1 ) ( \forall x ( \imp ( \in-sort x ph0 ) ph1 ) ) $. 

$c \sorted-exists $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
sorted-exists-is-sugar   $a #Notation ( \sorted-exists x ph0 ph1 ) ( \exists x ( \and ( \in-sort x ph0 ) ph1 ) ) $.

$c \forall-sort $.
forall-sort-is-pattern $a #Pattern ( \forall-sort s0 ph0 ) $.
forall-sort-is-sugar   $a #Notation ( \forall-sort s0 ph0 ) ( \sorted-forall s0 \sort ph0 ) $.

$c \exists-sort $.
exists-sort-is-pattern $a #Pattern ( \exists-sort s0 ph0 ) $.
exists-sort-is-sugar   $a #Notation ( \exists-sort s0 ph0 ) ( \sorted-exists s0 \sort ph0 ) $.

$( Part 4. Special Patterns (Singletons, Top, Bottom, Predicates $)

$c \is-singleton $.
is-singleton-is-pattern $a #Pattern ( \is-singleton ph0 ) $.
${
    $d x ph0 $.
    is-singleton-is-sugar $a #Notation ( \is-singleton ph0 ) ( \exists x ( \eq x ph0 ) ) $.
$}

$c \is-top $.
is-top-is-pattern $a #Pattern ( \is-top ph0 ) $.
is-top-is-sugar   $a #Notation ( \is-top ph0 ) ( \eq ph0 \top ) $.

$c \is-bot $.
is-bot-is-pattern $a #Pattern ( \is-bot ph0 ) $.
is-bot-is-sugar   $a #Notation ( \is-bot ph0 ) ( \eq ph0 \bot ) $.

$c \is-predicate $.
is-predicate-is-pattern $a #Pattern ( \is-predicate ph0 ) $.
is-predicate-is-sugar   $a #Notation ( \is-predicate ph0 ) ( \or ( \is-top ph0 ) ( \is-bot ph0 ) ) $.

$c \is-singleton-or-bot $.
is-singleton-or-bot-is-pattern $a #Pattern ( \is-singleton-or-bot ph0 ) $.
is-singleton-or-bot-is-sugar   $a #Notation ( \is-singleton-or-bot ph0 ) ( \or ( \is-singleton ph0 ) ( \is-bot ph0 ) ) $.

$( Part 5. Constant, Unary, and Binary Functions (internal use only) $)

$c \is-constant $.
is-constant-is-pattern $a #Pattern ( \is-constant ph0 ph1 ) $.
${
    $d x ph0 $.
    $d x ph1 $.
    is-constant-is-sugar $a #Notation ( \is-constant ph0 ph1 )
                                   ( \sorted-exists x ph1 ( \eq ph0 x ) ) $.
$}

$c \is-unary-function $.
is-unary-function-is-pattern $a #Pattern ( \is-unary-function ph0 ph1 ph2 ) $.
${
    $d x y ph0 $.
    $d x y ph1 $.
    $d x y ph2 $.
    is-unary-function-is-sugar $a #Notation ( \is-unary-function ph0 ph1 ph2 )
                                         ( \sorted-forall x ph1
                                         ( \sorted-exists y ph2 ( \eq ( \app ph0 x ) y ) ) ) $.
$}

$c \is-binary-function $.
is-binary-function-is-pattern $a #Pattern ( \is-binary-function ph0 ph1 ph2 ph3 ) $.
${
    $d x y z ph0 $.
    $d x y z ph1 $.
    $d x y z ph2 $.
    $d x y z ph3 $.
    is-binary-function-is-sugar $a #Notation ( \is-binary-function ph0 ph1 ph2 ph3 )
                                          ( \sorted-forall x ph1
                                          ( \sorted-forall y ph2
                                          ( \sorted-exists z ph3 ( \eq ( \app ph0 x y ) z ) ) ) ) $.
$}

$( Part 6. Unit $)

$c \unit-sort $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
unit-sort-is-sort $a |- ( \exists-sort x ( \eq x \unit-sort ) ) $.

$c \unit $.
unit-is-pattern $a #Symbol \unit $.
unit-is-singleton $a |- ( \is-singleton \unit ) $.

unit-sort $a |- ( \eq \unit ( \inh \unit-sort ) ) $.

$( Part 7. Pairs $)

$c \pair-sort-symbol $.
pair-sort-symbol-is-symbol $a #Symbol \pair-sort-symbol $.

axiom-pair-sort-is-sort $a |- ( \is-binary-function \pair-sort-symbol \sort \sort \sort ) $.

$c \pair-sort $.
pair-sort-is-pattern $a #Pattern ( \pair-sort ph0 ph1 ) $.
pair-sort-is-sugar   $a #Notation ( \pair-sort ph0 ph1 ) ( \app ( \app \pair-sort-symbol ph0 ) ph1 ) $.

$c \pair-symbol $.
pair-symbol-is-symbol $a #Symbol \pair-symbol $.

axiom-pair-symbol-is-binary-function
  $a ( \forall-sort s0 ( \forall-sort s1 ( \is-binary-function \pair-symbol s0 s1 ( \pair-sort s0 s1 ) ) ) ) $.

$c \pair $.
pair-is-pattern $a #Pattern ( \pair ph0 ph1 ) $.
pair-is-sugar   $a #Notation ( \pair ph0 ph1 ) ( \app ( \app \pair-symbol ph0 ) ph1 ) $.

$c \pair-fst-symbol $.
pair-fst-symbol-is-symbol $a #Symbol \pair-fst-symbol $.

axiom-pair-fst-symbol-is-unary-function 
  $a ( \forall-sort s0 ( \forall-sort s1 ( \is-unary-function \pair-fst-symbol ( \pair-sort s0 s1 ) s0 ) ) ) $.

$c \pair-fst $.
pair-fst-is-pattern $a #Pattern ( \pair-fst ph0 ) $.
pair-fst-is-sugar   $a #Notation ( \pair-fst ph0 ) ( \app \pair-fst-symbol ph0 ) $.

$c \pair-snd-symbol $.
pair-snd-symbol-is-symbol $a #Symbol \pair-snd-symbol $.

axiom-pair-snd-symbol-is-unary-function 
  $a ( \forall-sort s0 ( \forall-sort s1 ( \is-unary-function \pair-snd-symbol ( \pair-sort s0 s1 ) s1 ) ) ) $.

$c \pair-snd $.
pair-snd-is-pattern $a #Pattern ( \pair-snd ph0 ) $.
pair-snd-is-sugar   $a #Notation ( \pair-snd ph0 ) ( \app \pair-snd-symbol ph0 ) $.

axiom-pair-fst $a |- ( \forall-sort s0 ( \forall-sort s1 
                     ( \sorted-forall x0 s0 ( \sorted-forall x1 s2
                     ( \eq ( \pair-fst ( \pair x1 x2 ) ) x1 ) ) ) ) ) $.
axiom-pair-snd $a |- ( \forall-sort s0 ( \forall-sort s1 
                     ( \sorted-forall x0 s0 ( \sorted-forall x1 s2
                     ( \eq ( \pair-snd ( \pair x1 x2 ) ) x2 ) ) ) ) ) $.
axiom-pair-inj $a |- ( \forall-sort s0 ( \forall-sort s1 
                     ( \sorted-forall x0 s0 ( \sorted-forall x1 s2
                     ( \sorted-forall x2 s0 ( \sorted-forall x3 s2 
                     ( \imp ( \eq ( \pair x0 x1 ) ( \pair x2 x3 ) )
                            ( \and ( \eq x0 x2 ) ( \eq x1 x3 ) ) ) ) ) ) ) ) ) $.
axiom-pair-sort-inh $a |- ( \forall-sort s0 ( \forall-sort s1 
                          ( \eq ( \inh ( \pair-sort s0 s1 ) ) ( \pair ( \inh s0 ) ( \inh s1 ) ) ) ) ) $.


$(

### Deduction theorem for itp proof script

Suppose we have the proof script for the following theorem

a.0 $e ... a.n $e
-----------------
a $p phi

To get a proof script of

a.1 $e ... a.n $e
-----------------
a $p a.0 -> phi

One can perform the following transformation on the proof script:

 - apply "proof-rule-mp" should be replaced by

   apply "proof-rule-mp"
   apply "proof-rule-mp"
   apply "proof-rule-prop-2"

 - apply <label> where <label> is an arbitrary statement WITHOUT essential hypotheses
   (NOTE: it can be an essential hypothesis itself)

   should be replaced by

   apply "proof-rule-mp"
   apply "proof-rule-prop-1"
   apply <label>

 - apply a.0 should be replaced by

   apply "imp-reflexivity"

And then the resulting proof script should produce a proof for the new theorem

$)

$(
    Natural proof rules (desugared version)
$)

imp-reflexivity $p |- ( \imp ph0 ph0 ) $=
    $(
        apply proof-rule-mp
        apply proof-rule-mp
        apply proof-rule-prop-2
        let $5 = "( \imp ph0 ph0 )"
        apply proof-rule-prop-1
        apply proof-rule-prop-1
    $)
    ( imp-is-pattern proof-rule-prop-1 proof-rule-mp proof-rule-prop-2 ) AAABBAABAAABABBAAABBAABBAAABAEAAABCDAACD $.

${
    rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
    rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
    rule-imp-transitivity $p |- ( \imp ph0 ph2 ) $=
        $(
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-prop-2"
            apply "proof-rule-mp"
            apply "proof-rule-prop-1"
            apply "rule-imp-transitivity.1"
            apply "rule-imp-transitivity.0"
        $)
        ( imp-is-pattern proof-rule-mp proof-rule-prop-2 proof-rule-prop-1 ) ABFACFABCFFABFACFFABCHBCFABCFFBCFAIEGGDG $.
$}

$(
The proof script of this theorem is obtained by applying
the transformation described in `Deduction theorem for
itp proof script` twice on the proof script of `rule-imp-transitivity`
$)
imp-transitivity $p |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 ph2 ) ( \imp ph0 ph2 ) ) ) $=
    $(
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-1"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-1"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-1"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "imp-reflexivity"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-1"
        apply "imp-reflexivity"
    $)
    ( imp-is-pattern proof-rule-mp proof-rule-prop-2 proof-rule-prop-1 imp-reflexivity ) ABDBCDABDDDABDBCDACDDDABDBCDABDDBCDACDDDDABDBCDABDDDABDBCDACDDDDABDBCDABDDBCDACDDFABDBCDABDACDDDDABDBCDABDDBCDACDDDDABDBCDABDACDDDBCDABDDBCDACDDDDDABDBCDABDACDDDDABDBCDABDDBCDACDDDDDABDBCDABDACDDDBCDABDDBCDACDDDFBCDABDACDDDBCDABDDBCDACDDDDABDBCDABDACDDDBCDABDDBCDACDDDDDBCDABDACDDDBCDABDDBCDACDDDDABDGBCDABDACDFEEABDBCDABCDDDDABDBCDABDACDDDDABDBCDABCDDDBCDABDACDDDDDABDBCDABCDDDDABDBCDABDACDDDDDABDBCDABCDDDBCDABDACDDDFABDBCDABCDDABDACDDDDDABDBCDABCDDDBCDABDACDDDDDABDBCDABCDDABDACDDDDBCDABCDDDBCDABDACDDDDDDABDBCDABCDDABDACDDDDDABDBCDABCDDDBCDABDACDDDDDDABDBCDABCDDABDACDDDDBCDABCDDDBCDABDACDDDDFBCDABCDDABDACDDDDBCDABCDDDBCDABDACDDDDDABDBCDABCDDABDACDDDDBCDABCDDDBCDABDACDDDDDDBCDABCDDABDACDDDDBCDABCDDDBCDABDACDDDDDABDGBCDABCDDABDACDDFEEABDABCDDABDACDDDDABDBCDABCDDABDACDDDDDABDABCDDABDACDDDBCDABCDDABDACDDDDDDABDABCDDABDACDDDDABDBCDABCDDABDACDDDDDDABDABCDDABDACDDDBCDABCDDABDACDDDDFABCDDABDACDDDBCDABCDDABDACDDDDDABDABCDDABDACDDDBCDABCDDABDACDDDDDDABCDDABDACDDDBCDABCDDABDACDDDDDABDGABCDDABDACDDDBCDGEEABCDDABDACDDDABDABCDDABDACDDDDABCDDABDACDDDABDGABCFEEEEABDBCDBCDDDABDBCDABCDDDDABDBCDBCDDBCDABCDDDDDABDBCDBCDDDABDBCDABCDDDDDABDBCDBCDDBCDABCDDDFABDBCDBCDABCDDDDDABDBCDBCDDBCDABCDDDDDABDBCDBCDABCDDDDBCDBCDDBCDABCDDDDDDABDBCDBCDABCDDDDDABDBCDBCDDBCDABCDDDDDDABDBCDBCDABCDDDDBCDBCDDBCDABCDDDDFBCDBCDABCDDDDBCDBCDDBCDABCDDDDDABDBCDBCDABCDDDDBCDBCDDBCDABCDDDDDDBCDBCDABCDDDDBCDBCDDBCDABCDDDDDABDGBCDBCDABCDDFEEABDBCDABCDDDDABDBCDBCDABCDDDDDABDBCDABCDDDBCDBCDABCDDDDDDABDBCDABCDDDDABDBCDBCDABCDDDDDDABDBCDABCDDDBCDBCDABCDDDDFBCDABCDDDBCDBCDABCDDDDDABDBCDABCDDDBCDBCDABCDDDDDDBCDABCDDDBCDBCDABCDDDDDABDGBCDABCDDDBCDGEEBCDABCDDDABDBCDABCDDDDBCDABCDDDABDGBCDAGEEEEBCDBCDDABDBCDBCDDDBCDBCDDABDGBCDHEEEEEABDABDDABDBCDABDDDABDABDBCDABDDDDABDABDDABDBCDABDDDDABDABDBCDABDDFABDBCDABDDDABDABDBCDABDDDDABDBCDABDDDABDGABDBCDGEEABDHEE $.

bot-elim $p |- ( \imp \bot ph0 ) $=
    $(
        apply "proof-rule-mp"
        let $0 = "( \imp \bot ( \imp ( \imp ph0 \bot ) \bot ) )"
        apply "proof-rule-mp"
        let $2 = "( \imp \bot ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 ) )"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        let $7 = "( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 )"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-3"
        apply "proof-rule-prop-1"
    $)
    ( imp-is-pattern bot-is-pattern proof-rule-mp proof-rule-prop-1 proof-rule-prop-2 proof-rule-prop-3 ) CACBCBBCABCACBCBABBCACBCBBCABBCACBCBAFACBCBABCACBCBABBACBCBABCEAGDDCACBED $.

contradiction $p |- ( \imp ( \imp ( \not ph0 ) \bot ) ph0 ) $=
    $(
        desugar "\not"
        apply "proof-rule-prop-3"
    $)
    ( bot-is-pattern imp-is-pattern not-is-pattern notation-reflexivity notation-imp proof-rule-prop-3 not-is-sugar notation-symmetry notation-transitivity notation-proof ) ABCBCACADBCACAGADBCAABCBCAADBABCBADABCABCAHABCABCABCEIJBEFAEFK $.

top-intro $p |- \top $=
    $(
        desugar-all
        apply "imp-reflexivity"
    $)
    ( bot-is-pattern imp-is-pattern not-is-pattern notation-symmetry top-is-pattern notation-transitivity imp-reflexivity top-is-sugar not-is-sugar notation-reflexivity notation-proof ) AABEAGEACAABHAABACACAABACAABAABAIAABAABAABJDFDDFK $.

mp $p |- ( \imp ph0 ( \imp ( \imp ph0 ph1 ) ph1 ) ) $=
    $(
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        let $0 = "( \imp ph0 ( \imp ( \imp ph0 ph1 ) ph0 ) )"
        let $2 = "( \imp ph0 ( \imp ( \imp ( \imp ph0 ph1 ) ph0 ) ( \imp ( \imp ph0 ph1 ) ph1 ) ) )"
        apply "proof-rule-prop-2"
        meh
        apply "proof-rule-prop-1"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        let $9 = "( \imp ph0 ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph1 ) ) )"
        let $11 = "( \imp ph0 ( \imp ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph1 ) ) ( \imp ( \imp ( \imp ph0 ph1 ) ph0 ) ( \imp ( \imp ph0 ph1 ) ph1 ) ) ) )"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        let $16 = "( \imp ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph1 ) ) ( \imp ( \imp ( \imp ph0 ph1 ) ph0 ) ( \imp ( \imp ph0 ph1 ) ph1 ) ) )"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        let $23 = "( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph1 ) )"
        apply "proof-rule-prop-1"
        apply "imp-reflexivity"
    $)
    ( imp-is-pattern proof-rule-mp proof-rule-prop-2 proof-rule-prop-1 imp-reflexivity ) AABCACCAABCBCCAABCACABCBCCCAABCACCAABCBCCCAABCACABCBCEAABCABCCCAABCACABCBCCCAABCABCCABCACABCBCCCCAABCABCCCAABCACABCBCCCCAABCABCCABCACABCBCCEABCABCCABCACABCBCCCAABCABCCABCACABCBCCCCABCABCCABCACABCBCCCAFABCABEDDABCABCCAABCABCCCABCABCCAFABCGDDDAABCFD $.

not-elim $p |- ( \imp ph0 ( \imp ( \imp ph0 \bot ) \bot ) ) $= $( apply mp $) ( bot-is-pattern mp ) ABC $.

or-intro-left $p |- ( \imp ph0 ( \imp ( \imp ph0 \bot ) ph1 ) ) $=
    $(
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        # let $0 = "( \imp ph0 ( \imp ( \imp ph0 \bot ) \bot ) )"
        # let $2 = "( \imp ph0 ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ( \imp ph0 \bot ) ph1 ) ) )"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        # let $9 = "( \imp ph0 ( \imp ( \imp ( \imp ph0 \bot ) ( \imp \bot ph1 ) ) ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ( \imp ph0 \bot ) ph1 ) ) ) )"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "bot-elim"
        apply "not-elim"
    $)
    ( imp-is-pattern bot-is-pattern proof-rule-mp proof-rule-prop-2 proof-rule-prop-1 bot-elim not-elim ) AADCDCCAADCBCCAADCDCADCBCCCAADCDCCAADCBCCCAADCDCADCBCFAADCDBCCCAADCDCADCBCCCAADCDBCCADCDCADCBCCCCAADCDBCCCAADCDCADCBCCCCAADCDBCCADCDCADCBCCFADCDBCCADCDCADCBCCCAADCDBCCADCDCADCBCCCCADCDBCCADCDCADCBCCCAGADCDBFEEADCDBCCAADCDBCCCADCDBCCAGDBCADCDBCCDBCADCGBHEEEEAIE $.

contrapositive $p |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) ) $=
    $( apply "imp-transitivity" $) ( bot-is-pattern imp-transitivity ) ABCD $.

${
    rule-contrapositive.0 $e |- ( \imp ph0 ph1 ) $.
    rule-contrapositive $p |- ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) $=
        $(
            apply "proof-rule-mp"
            apply "contrapositive"
            apply "rule-contrapositive.0"
        $)
        ( imp-is-pattern bot-is-pattern contrapositive proof-rule-mp ) ABDBEDAEDDABFCG $.
$}

and-elim-left $p |- ( \imp ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) ph0 ) $=
    $(
        apply "rule-imp-transitivity"
        apply "rule-contrapositive"
        apply "or-intro-left"
        apply "proof-rule-prop-3"
    $)
    ( imp-is-pattern bot-is-pattern or-intro-left rule-contrapositive proof-rule-prop-3 rule-imp-transitivity ) ADCDCBDCCDCADCDCAADCADCDCBDCCADCBDCEFAGH $.

and-elim-right $p |- ( \imp ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) ph1 ) $=
    $(
        apply "rule-imp-transitivity"
        apply "rule-contrapositive"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-3"
    $)
    ( imp-is-pattern bot-is-pattern proof-rule-prop-1 rule-contrapositive proof-rule-prop-3 rule-imp-transitivity ) ADCDCBDCCDCBDCDCBBDCADCDCBDCCBDCADCDCEFBGH $.

not-elim-alt $p |- ( \imp ( \imp ph0 \bot ) ( \imp ph0 ph1 ) ) $=
    $(
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-1"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "bot-elim"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-mp"
        apply "proof-rule-prop-2"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "proof-rule-prop-1"
        apply "imp-reflexivity"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "imp-reflexivity"
    $)
    ( imp-is-pattern bot-is-pattern proof-rule-mp proof-rule-prop-2 proof-rule-prop-1 imp-reflexivity bot-elim ) ADCADCCADCABCCADCADCABCCCADCADCCADCABCCCADCADCABCFADCADBCCCADCADCABCCCADCADBCCADCABCCCCADCADBCCCADCADCABCCCCADCADBCCADCABCCFADBCCADCABCCCADCADBCCADCABCCCCADBCCADCABCCCADCGADBFEEADCDBCCADCADBCCCADCDBCADBCCCCADCDBCCADCADBCCCCADCDBCADBCCFDBCADBCCCADCDBCADBCCCCDBCADBCCCADCGDBCAGEEDBCADCDBCCDBCADCGBIEEEEADCAACCADCADCCADCAACADCCCADCAACCADCADCCCADCAACADCFADCAADCCCADCAACADCCCADCAADCCAACADCCCCADCAADCCCADCAACADCCCCADCAADCCAACADCCFAADCCAACADCCCADCAADCCAACADCCCCAADCCAACADCCCADCGAADFEEADCADCCADCAADCCCADCADCAADCCCCADCADCCADCAADCCCCADCADCAADCCFADCAADCCCADCADCAADCCCCADCAADCCCADCGADCAGEEADCHEEEAACADCAACCAACADCGAHEEE $.

${
    rule-peirce-bot.0 $e |- ( \imp ( \imp ph0 \bot ) ph0 ) $.
    rule-peirce-bot $p |- ph0 $=
        $(
            apply "proof-rule-mp"
            apply "proof-rule-prop-3"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-prop-2"
            apply "imp-reflexivity"
            apply "rule-peirce-bot.0"
        $)
        ( imp-is-pattern bot-is-pattern proof-rule-mp proof-rule-prop-3 proof-rule-prop-2 imp-reflexivity ) ADCDCAAFADCACADCDCADCADCCADCACADCDCCADCADGADCHEBEE $.
$}
