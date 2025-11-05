unit grammar CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Grammar;
#| background: [ <bg-layer> , ]* <final-bg-layer>
rule decl:sym<background> { :i (background) ":" <val(/<expr=.val-background> /, &?ROUTINE.WHY)>}
rule val-background { :i [<bg-layer> <op(",")> ] * <final-bg-layer>  }
#| background-attachment: [ scroll | fixed | local ]#
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<expr=.val-background-attachment> /, &?ROUTINE.WHY)>}
rule val-background-attachment { :i [[scroll | fixed | local ]& <keyw> ] +% <op(",")> }
#| background-clip: <box>#
rule decl:sym<background-clip> { :i ("background-clip") ":" <val(/<expr=.val-background-clip> /, &?ROUTINE.WHY)>}
rule val-background-clip { :i <box> +% <op(",")> }
#| background-color: <color>
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<expr=.val-background-color> /, &?ROUTINE.WHY)>}
rule val-background-color { :i <color> }
#| background-image: [ <image> | none ]#
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<expr=.val-background-image> /, &?ROUTINE.WHY)>}
rule val-background-image { :i [<image> || none & <keyw>  ] +% <op(",")> }
#| background-origin: <box>#
rule decl:sym<background-origin> { :i ("background-origin") ":" <val(/<expr=.val-background-origin> /, &?ROUTINE.WHY)>}
rule val-background-origin { :i <box> +% <op(",")> }
#| background-position: <position>#
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<expr=.val-background-position> /, &?ROUTINE.WHY)>}
rule val-background-position { :i <position> +% <op(",")> }
#| background-repeat: [ repeat-x | repeat-y | [ repeat | space | round | no-repeat ]{1,2} ]#
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<expr=.val-background-repeat> /, &?ROUTINE.WHY)>}
rule val-background-repeat { :i [["repeat-x" | "repeat-y" ]& <keyw>  || [[repeat | space | round | "no-repeat" ]& <keyw> ] ** 1..2 ] +% <op(",")> }
#| background-size: [ [ <length> | <percentage> | auto ]{1,2} ]#
rule decl:sym<background-size> { :i ("background-size") ":" <val(/<expr=.val-background-size> /, &?ROUTINE.WHY)>}
rule val-background-size { :i [[<length> || <percentage> || auto & <keyw>  ] ** 1..2] +% <op(",")> }
#| border: <'border-width'> || <'border-style'> || <color>
rule decl:sym<border> { :i (border) ":" <val(/<expr=.val-border> /, &?ROUTINE.WHY)>}
rule val-border { :i [<val-border-width> :my $a; <!{
    $a++
}>| <val-border-style> :my $b; <!{
    $b++
}>| <color> :my $c; <!{
    $c++
}>]+ }
#| border-color: <color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<expr=.val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule val-border-color { :i <color> }
#| border-image: <‘border-image-source’> || <‘border-image-slice’> [ / <‘border-image-width’> | / <‘border-image-width’>? / <‘border-image-outset’> ]? || <‘border-image-repeat’>
rule decl:sym<border-image> { :i ("border-image") ":" <val(/<expr=.val-border-image> /, &?ROUTINE.WHY)>}
rule val-border-image { :i [<val-border-image-source> :my $a; <!{
    $a++
}>| <val-border-image-slice> [<op("/")> <val-border-image-width>  || <op("/")> <val-border-image-width> ? <op("/")> <val-border-image-outset>  ] ?  :my $b; <!{
    $b++
}>| <val-border-image-repeat> :my $c; <!{
    $c++
}>]+ }
#| border-image-outset: [ <length> | <number> ]{1,4}
rule decl:sym<border-image-outset> { :i ("border-image-outset") ":" <val(/<expr=.val-border-image-outset>** 1..4 /, &?ROUTINE.WHY)>}
rule val-border-image-outset { :i [<length> || <number> ] }
#| border-image-repeat: [ stretch | repeat | round | space ]{1,2}
rule decl:sym<border-image-repeat> { :i ("border-image-repeat") ":" <val(/<expr=.val-border-image-repeat> /, &?ROUTINE.WHY)>}
rule val-border-image-repeat { :i [[stretch | repeat | round | space ]& <keyw> ] ** 1..2 }
#| border-image-slice: <val-border-image-slice>{1,4} && fill?
rule decl:sym<border-image-slice> { :i ("border-image-slice") ":" <val(/<expr=.val-border-image-slice> /, &?ROUTINE.WHY)>}
#| <number> | <percentage>
rule val-border-image-slice { :i <number> || <percentage>  }
#| border-image-source: none | <image>
rule decl:sym<border-image-source> { :i ("border-image-source") ":" <val(/<expr=.val-border-image-source> /, &?ROUTINE.WHY)>}
rule val-border-image-source { :i none & <keyw>  || <image>  }
#| border-image-width: [ <length> | <percentage> | <number> | auto ]{1,4}
rule decl:sym<border-image-width> { :i ("border-image-width") ":" <val(/<expr=.val-border-image-width>** 1..4 /, &?ROUTINE.WHY)>}
rule val-border-image-width { :i [<length> || <percentage> || <number> || auto & <keyw>  ] }
#| border-radius: [ <length> | <percentage> ]{1,4} [ / [ <length> | <percentage> ]{1,4} ]?
rule decl:sym<border-radius> { :i ("border-radius") ":" <val(/<expr=.val-border-radius> /, &?ROUTINE.WHY)>}
rule val-border-radius { :i [<length> || <percentage> ] ** 1..4 [<op("/")> [<length> || <percentage> ] ** 1..4 ] ?  }
#| border-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<expr=.val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule val-border-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top: <'border-top-width'> || <'border-top-style'> || <color>
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<expr=.val-border-top> /, &?ROUTINE.WHY)>}
rule val-border-top { :i [<val-border-top-width> :my $a; <!{
    $a++
}>| <val-border-top-style> :my $b; <!{
    $b++
}>| <color> :my $c; <!{
    $c++
}>]+ }
#| border-right: <'border-right-width'> || <'border-right-style'> || <color>
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<expr=.val-border-right> /, &?ROUTINE.WHY)>}
rule val-border-right { :i [<val-border-right-width> :my $a; <!{
    $a++
}>| <val-border-right-style> :my $b; <!{
    $b++
}>| <color> :my $c; <!{
    $c++
}>]+ }
#| border-bottom: <'border-bottom-width'> || <'border-bottom-style'> || <color>
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<expr=.val-border-bottom> /, &?ROUTINE.WHY)>}
rule val-border-bottom { :i [<val-border-bottom-width> :my $a; <!{
    $a++
}>| <val-border-bottom-style> :my $b; <!{
    $b++
}>| <color> :my $c; <!{
    $c++
}>]+ }
#| border-left: <'border-left-width'> || <'border-left-style'> || <color>
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<expr=.val-border-left> /, &?ROUTINE.WHY)>}
rule val-border-left { :i [<val-border-left-width> :my $a; <!{
    $a++
}>| <val-border-left-style> :my $b; <!{
    $b++
}>| <color> :my $c; <!{
    $c++
}>]+ }
#| border-top-color: <color>
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<expr=.val-border-top-color> /, &?ROUTINE.WHY)>}
rule val-border-top-color { :i <color> }
#| border-top-color: <color>
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<expr=.val-border-right-color> /, &?ROUTINE.WHY)>}
rule val-border-right-color { :i <color> }
#| border-top-color: <color>
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<expr=.val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule val-border-bottom-color { :i <color> }
#| border-top-color: <color>
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<expr=.val-border-left-color> /, &?ROUTINE.WHY)>}
rule val-border-left-color { :i <color> }
#| border-top-left-radius: [ <length> | <percentage> ]{1,2}
rule decl:sym<border-top-left-radius> { :i ("border-top-left-radius") ":" <val(/<expr=.val-border-top-left-radius> /, &?ROUTINE.WHY)>}
rule val-border-top-left-radius { :i [<length> || <percentage> ] ** 1..2 }
#| border-top-left-radius: [ <length> | <percentage> ]{1,2}
rule decl:sym<border-top-right-radius> { :i ("border-top-right-radius") ":" <val(/<expr=.val-border-top-right-radius> /, &?ROUTINE.WHY)>}
rule val-border-top-right-radius { :i [<length> || <percentage> ] ** 1..2 }
#| border-top-left-radius: [ <length> | <percentage> ]{1,2}
rule decl:sym<border-bottom-right-radius> { :i ("border-bottom-right-radius") ":" <val(/<expr=.val-border-bottom-right-radius> /, &?ROUTINE.WHY)>}
rule val-border-bottom-right-radius { :i [<length> || <percentage> ] ** 1..2 }
#| border-top-left-radius: [ <length> | <percentage> ]{1,2}
rule decl:sym<border-bottom-left-radius> { :i ("border-bottom-left-radius") ":" <val(/<expr=.val-border-bottom-left-radius> /, &?ROUTINE.WHY)>}
rule val-border-bottom-left-radius { :i [<length> || <percentage> ] ** 1..2 }
#| border-top-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<expr=.val-border-top-style> /, &?ROUTINE.WHY)>}
rule val-border-top-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<expr=.val-border-right-style> /, &?ROUTINE.WHY)>}
rule val-border-right-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<expr=.val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule val-border-bottom-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<expr=.val-border-left-style> /, &?ROUTINE.WHY)>}
rule val-border-left-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-width: [ <length> | thin | medium | thick ]
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<expr=.val-border-top-width> /, &?ROUTINE.WHY)>}
rule val-border-top-width { :i [<length> || [thin | medium | thick ]& <keyw>  ] }
#| border-top-width: [ <length> | thin | medium | thick ]
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<expr=.val-border-right-width> /, &?ROUTINE.WHY)>}
rule val-border-right-width { :i [<length> || [thin | medium | thick ]& <keyw>  ] }
#| border-top-width: [ <length> | thin | medium | thick ]
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<expr=.val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule val-border-bottom-width { :i [<length> || [thin | medium | thick ]& <keyw>  ] }
#| border-top-width: [ <length> | thin | medium | thick ]
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<expr=.val-border-left-width> /, &?ROUTINE.WHY)>}
rule val-border-left-width { :i [<length> || [thin | medium | thick ]& <keyw>  ] }
#| border-width: [ <length> | thin | medium | thick ]{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<expr=.val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule val-border-width { :i [<length> || [thin | medium | thick ]& <keyw>  ] }
#| box-decoration-break: slice | clone
rule decl:sym<box-decoration-break> { :i ("box-decoration-break") ":" <val(/<expr=.val-box-decoration-break> /, &?ROUTINE.WHY)>}
rule val-box-decoration-break { :i [slice | clone ]& <keyw>  }
#| box-shadow: none | <shadow>#
rule decl:sym<box-shadow> { :i ("box-shadow") ":" <val(/<expr=.val-box-shadow> /, &?ROUTINE.WHY)>}
rule val-box-shadow { :i none & <keyw>  || <shadow> +% <op(",")>  }