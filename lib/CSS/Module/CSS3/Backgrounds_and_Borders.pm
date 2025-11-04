use v6;

# CSS3 Background and Borders Extension Module
# - reference: http://www.w3.org/TR/2012/CR-css3-background-20120724/
#
use CSS::Specification::Defs;
use CSS::Specification::Defs::Actions;
use CSS::Grammar::CSS3;
use CSS::Grammar::Actions;

class CSS::Module::CSS3::Backgrounds_and_Borders::Actions {...}

use CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Interface;
use CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Grammar;
use CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Actions;

grammar CSS::Module::CSS3::Backgrounds_and_Borders:ver<20120724.000>
    is CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Grammar
    is CSS::Specification::Defs
    is CSS::Grammar::CSS3
    does CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Interface {
    token seen($i) { <?{ @*SEEN[$i]++ }> } 
    rule image      { <uri> }
    rule bg-layer($final?) { :my ($a,$b,$c,$d,$e,$f); [ <expr-background-image> <!{$a++}> | <position> [ '/' <expr-background-size> ]? <!{$b++}> | <expr-background-repeat> <!{$c++}> | <attachment> <!{$d++}> | <expr-background-clip>**1..2 <!{$e++}> | <color> <!{$f++}> <?{$final}> ]+}
    rule final-bg-layer{ <bg-layer(True)> }
    # work around for RT#117955
##    rule position   {:i [ <percentage> | <length> | [ [ left | center | right | top | bottom ] & <keyw> ] [ <percentage> | <length> ] ? ] ** 1..2 }
    rule position   {:i [ <percentage> | <length> | <keyw( rx:i[ left | center | right | top | bottom ] )> [ <percentage> | <length> ] ? ] ** 1..2 }
    rule shadow     {:i [ <length> | <color> | inset & <keyw> ]+ }
    rule attachment {:i [ scroll | fixed | local ] & <keyw> }
    rule box        {:i [ border\-box | padding\-box | content\-box ] & <keyw> }
}

class CSS::Module::CSS3::Backgrounds_and_Borders::Actions
    is CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Actions
    is CSS::Specification::Defs::Actions
    is CSS::Grammar::Actions
    does CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Interface {

    method image($/)      { make $<uri>.ast }
    method bg-layer($/)   { make $.token( $.list($/), :type<expr:bg-layer> ) }
    method final-bg-layer($/) { make $<bg-layer>.ast }
    method position($/)   { make $.token( $.list($/), :type<expr:position> ) }
    method shadow($/)     { make $.token( $.list($/), :type<expr:shadow> ) }
    method attachment($/) { make $<keyw>.ast }
    method box($/)        { make $<keyw>.ast }

}
