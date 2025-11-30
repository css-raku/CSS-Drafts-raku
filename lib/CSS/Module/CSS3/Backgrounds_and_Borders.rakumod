use v6;

grammar CSS::Module::CSS3::Backgrounds_and_Borders {
    # CSS3 Background and Borders Extension Module
    # - reference: http://www.w3.org/TR/2012/CR-css3-background-20120724/
    #
    use CSS::Specification::Base::Grammar;
    use CSS::Grammar::CSS3;
    use CSS::Grammar::Actions;

    use CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Interface;
    use CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Grammar;

    also is CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Grammar;

    also does CSS::Specification::Base::Grammar;
    also is CSS::Grammar::CSS3;
    also does CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Interface;

    rule position   {:i [ <percentage> | <length> | <keyw( rx:i[ left | center | right | top | bottom ] )> [ <percentage> | <length> ] ? ] ** 1..2 }


    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

    our class Actions {
        use CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Actions;
        use CSS::Specification::Base::Actions;
        also is CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Actions;
        also is CSS::Specification::Base::Actions;
        also is CSS::Grammar::Actions;
        also does CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Interface;
        use Method::Also;

        method position($/)    { make $.token( $.list($/), :type<expr:position> ) }
        method bg-layer($/) is also<final-bg-layer>    { make $.token( $.list($/), :type<expr:bg-layer> ) }
    }
}
