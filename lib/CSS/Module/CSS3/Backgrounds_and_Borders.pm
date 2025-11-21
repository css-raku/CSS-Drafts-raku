use v6;

grammar CSS::Module::CSS3::Backgrounds_and_Borders {
    # CSS3 Background and Borders Extension Module
    # - reference: http://www.w3.org/TR/2012/CR-css3-background-20120724/
    #
    use CSS::Specification::Base::Grammar;
    use CSS::Grammar::CSS3;
    use CSS::Grammar::Actions;

    use CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Interface;
    use CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Grammar;

    also is CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Grammar;

    also does CSS::Specification::Base::Grammar;
    also is CSS::Grammar::CSS3;
    also does CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Interface;
    rule bg-layer { :i [
         <prop-val-background-image> :my $*A; <!{  $*A++ }>
      || <bg-position> [<op("/")> <bg-size> ] ?  :my $*B; <!{ $*B++ }>
      || <repeat-style> :my $*C; <!{ $*C++}>
      || <attachment> :my $*D; <!{$*D++}>
      || <visual-box> :my $*E; <!{$*E++}>
      || <color> :my $*F; <!{ $*F++}>
      ]+
   }
# work around for RT#117955
##    rule position   {:i [ <percentage> | <length> | [ [ left | center | right | top | bottom ] & <keyw> ] [ <percentage> | <length> ] ? ] ** 1..2 }
    rule position   {:i [ <percentage> | <length> | <keyw( rx:i[ left | center | right | top | bottom ] )> [ <percentage> | <length> ] ? ] ** 1..2 }
    rule bg-position { <position> }

    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

    our class Actions {
        use CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Actions;
        use CSS::Specification::Base::Actions;
        also is CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Actions;
        also is CSS::Specification::Base::Actions;
        also is CSS::Grammar::Actions;
        also does CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Interface;
        method position($/)    { make $.token( $.list($/), :type<expr:position> ) }
        method bg-position($/) { make $<position>.ast } 

        method bg-layer($/)    { make $.token( $.list($/), :type<expr:bg-layer> ) }
        method prop-val-background($/) {
            my @layers = @<bg-layer>;
            @layers.pop;
            $.warning: 'color; not on final background layer'
                if @layers && @layers.first: *.<color>;
        }

    }
}
