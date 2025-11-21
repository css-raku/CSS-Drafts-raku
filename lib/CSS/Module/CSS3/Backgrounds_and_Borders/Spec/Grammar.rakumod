unit grammar CSS::Module::CSS3::Backgrounds_and_Borders::Spec::Grammar;
#| <bg-image> = <image> | none
rule bg-image { :i <image> || none & <keyw>   }
#| <attachment> = scroll | fixed | local
rule attachment { :i [scroll | fixed | local ]& <keyw>  }
#| <bg-size> = [ <length-percentage [0,∞]> | auto ]{1,2} | cover | contain
rule bg-size { :i [<length-percentage> || auto & <keyw>  ] ** 1..2 || [cover | contain ]& <keyw>   }
#| <line-style> = none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
rule line-style { :i [none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw>  }
#| <image> = <url> | <gradient>
rule image { :i <url> || <gradient>  }
#| <line-width> = <length [0,∞]> | thin | medium | thick
rule line-width { :i <length> || [thin | medium | thick ]& <keyw>   }
#| <repeat-style> = repeat-x | repeat-y | [repeat | space | round | no-repeat]{1,2}
rule repeat-style { :i ["repeat-x" | "repeat-y" ]& <keyw>  || [[repeat | space | round | "no-repeat" ]& <keyw> ] ** 1..2  }
#| <visual-box> = content-box | padding-box | border-box
rule visual-box { :i ["content-box" | "padding-box" | "border-box" ]& <keyw>  }
#| <layout-box> = <visual-box> | margin-box
rule layout-box { :i <visual-box> || "margin-box" & <keyw>   }
#| <paint-box> = <visual-box> | fill-box | stroke-box
rule paint-box { :i <visual-box> || ["fill-box" | "stroke-box" ]& <keyw>   }
#| <coord-box> = <paint-box> | view-box
rule coord-box { :i <paint-box> || "view-box" & <keyw>   }
#| <gradient> = <linear-gradient()> | <repeating-linear-gradient()> |   <radial-gradient()> | <repeating-radial-gradient()>
rule gradient { :i <linear-gradient> || <repeating-linear-gradient> || <radial-gradient> || <repeating-radial-gradient>  }
#| linear-gradient( [ <linear-gradient-syntax> ] )
rule linear-gradient { :i "linear-gradient(" [<linear-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| repeating-linear-gradient( [ <linear-gradient-syntax> ] )
rule repeating-linear-gradient { :i "repeating-linear-gradient(" [<linear-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <linear-gradient-syntax> = [ <angle> | to <side-or-corner> ]? , <color-stop-list>
rule linear-gradient-syntax { :i [<angle> || to & <keyw>  <side-or-corner>  ] ? <op(",")> <color-stop-list>  }
#| repeating-radial-gradient( [ <radial-gradient-syntax> ] )
rule repeating-radial-gradient { :i "repeating-radial-gradient(" [<radial-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <color-stop-list> = <linear-color-stop> , [ <linear-color-hint>? , <linear-color-stop> ]#
rule color-stop-list { :i <linear-color-stop> <op(",")> [<linear-color-hint> ? <op(",")> <linear-color-stop> ] +% <op(",")>  }
#| <linear-color-stop> = <color> <length-percentage>?
rule linear-color-stop { :i <color> <length-percentage> ?  }
#| <linear-color-hint> = <length-percentage>
rule linear-color-hint { :i <length-percentage> }
#| radial-gradient( [ <radial-gradient-syntax> ] )
rule radial-gradient { :i "radial-gradient(" [<radial-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <radial-gradient-syntax> = [ <radial-shape> || <radial-size> ]? [ at <position> ]? ,  <color-stop-list>
rule radial-gradient-syntax { :i [[<radial-shape> :my $*A; <!{
    $*A++
}>| <radial-size> :my $*B; <!{
    $*B++
}>]+] ? [at & <keyw>  <position> ] ? <op(",")> <color-stop-list>  }
#| <radial-size> = <radial-extent> | <length [0,∞]> | <length-percentage [0,∞]>{2}
rule radial-size { :i <radial-extent> || <length> || <length-percentage> ** 2  }
#| <radial-extent> = closest-corner | closest-side | farthest-corner | farthest-side
rule radial-extent { :i ["closest-corner" | "closest-side" | "farthest-corner" | "farthest-side" ]& <keyw>  }
#| <radial-shape> = circle | ellipse
rule radial-shape { :i [circle | ellipse ]& <keyw>  }
#| <side-or-corner> = [left | right] || [top | bottom]
rule side-or-corner { :i [[[left | right ]& <keyw> ] :my $*A; <!{
    $*A++
}>| [[top | bottom ]& <keyw> ] :my $*B; <!{
    $*B++
}>]+ }
#| <length-percentage> = <length> | <percentage>
rule length-percentage { :i <length> || <percentage>  }
#| <frequency-percentage> = <frequency> | <percentage>
rule frequency-percentage { :i <frequency> || <percentage>  }
#| <angle-percentage> = <angle> | <percentage>
rule angle-percentage { :i <angle> || <percentage>  }
#| <time-percentage> = <time> | <percentage>
rule time-percentage { :i <time> || <percentage>  }
#| background: <bg-layer>#
rule decl:sym<background> { :i (background) ":" <val(/<expr=.prop-val-background> /, &?ROUTINE.WHY)>}
rule prop-val-background { :i <bg-layer> +% <op(",")> }
#| background-attachment: <attachment>#
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<expr=.prop-val-background-attachment> /, &?ROUTINE.WHY)>}
rule prop-val-background-attachment { :i <attachment> +% <op(",")> }
#| background-clip: <visual-box>#
rule decl:sym<background-clip> { :i ("background-clip") ":" <val(/<expr=.prop-val-background-clip> /, &?ROUTINE.WHY)>}
rule prop-val-background-clip { :i <visual-box> +% <op(",")> }
#| background-color: <color>
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<expr=.prop-val-background-color> /, &?ROUTINE.WHY)>}
rule prop-val-background-color { :i <color> }
#| background-image: <bg-image>#
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<expr=.prop-val-background-image> /, &?ROUTINE.WHY)>}
rule prop-val-background-image { :i <bg-image> +% <op(",")> }
#| background-origin: <visual-box>#
rule decl:sym<background-origin> { :i ("background-origin") ":" <val(/<expr=.prop-val-background-origin> /, &?ROUTINE.WHY)>}
rule prop-val-background-origin { :i <visual-box> +% <op(",")> }
#| background-position: <bg-position>#
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<expr=.prop-val-background-position> /, &?ROUTINE.WHY)>}
rule prop-val-background-position { :i <bg-position> +% <op(",")> }
#| background-repeat: <repeat-style>#
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<expr=.prop-val-background-repeat> /, &?ROUTINE.WHY)>}
rule prop-val-background-repeat { :i <repeat-style> +% <op(",")> }
#| background-size: <bg-size>#
rule decl:sym<background-size> { :i ("background-size") ":" <val(/<expr=.prop-val-background-size> /, &?ROUTINE.WHY)>}
rule prop-val-background-size { :i <bg-size> +% <op(",")> }
#| border: <line-width> || <line-style> || <color>
rule decl:sym<border> { :i (border) ":" <val(/<expr=.prop-val-border> /, &?ROUTINE.WHY)>}
rule prop-val-border { :i [<line-width> :my $*A; <!{
    $*A++
}>| <line-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-bottom: <line-width> || <line-style> || <color>
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<expr=.prop-val-border-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom { :i [<line-width> :my $*A; <!{
    $*A++
}>| <line-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-bottom-color: <color>
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<expr=.prop-val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-color { :i <color> }
#| border-bottom-left-radius: <length-percentage>{1,2}
rule decl:sym<border-bottom-left-radius> { :i ("border-bottom-left-radius") ":" <val(/<expr=.prop-val-border-bottom-left-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-left-radius { :i <length-percentage> ** 1..2 }
#| border-bottom-right-radius: <length-percentage>{1,2}
rule decl:sym<border-bottom-right-radius> { :i ("border-bottom-right-radius") ":" <val(/<expr=.prop-val-border-bottom-right-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-right-radius { :i <length-percentage> ** 1..2 }
#| border-bottom-style: <line-style>
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<expr=.prop-val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-style { :i <line-style> }
#| border-bottom-width: <line-width>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<expr=.prop-val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-width { :i <line-width> }
#| border-color: <color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<expr=.prop-val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-color { :i <color> }
#| border-image: <'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>
rule decl:sym<border-image> { :i ("border-image") ":" <val(/<expr=.prop-val-border-image> /, &?ROUTINE.WHY)>}
rule prop-val-border-image { :i [<prop-val-border-image-source> :my $*A; <!{
    $*A++
}>| <prop-val-border-image-slice> [<op("/")> <prop-val-border-image-width>  || <op("/")> <prop-val-border-image-width> ? <op("/")> <prop-val-border-image-outset>  ] ?  :my $*B; <!{
    $*B++
}>| <prop-val-border-image-repeat> :my $*C; <!{
    $*C++
}>]+ }
#| border-image-outset: [ <length> | <number> ]{1,4}
rule decl:sym<border-image-outset> { :i ("border-image-outset") ":" <val(/<expr=.prop-val-border-image-outset>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-image-outset { :i [<length> || <number> ] }
#| border-image-repeat: [ stretch | repeat | round | space ]{1,2}
rule decl:sym<border-image-repeat> { :i ("border-image-repeat") ":" <val(/<expr=.prop-val-border-image-repeat> /, &?ROUTINE.WHY)>}
rule prop-val-border-image-repeat { :i [[stretch | repeat | round | space ]& <keyw> ] ** 1..2 }
#| border-image-slice: [[<number> | <percentage>] fill?]{1,4}
rule decl:sym<border-image-slice> { :i ("border-image-slice") ":" <val(/<expr=.prop-val-border-image-slice>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-image-slice { :i [[<number> || <percentage> ] [fill & <keyw>] ? ] }
#| border-image-source: none | <image>
rule decl:sym<border-image-source> { :i ("border-image-source") ":" <val(/<expr=.prop-val-border-image-source> /, &?ROUTINE.WHY)>}
rule prop-val-border-image-source { :i none & <keyw>  || <image>  }
#| border-image-width: [ <length-percentage> | <number> | auto ]{1,4}
rule decl:sym<border-image-width> { :i ("border-image-width") ":" <val(/<expr=.prop-val-border-image-width>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-image-width { :i [<length-percentage> || <number> || auto & <keyw>  ] }
#| border-left: <line-width> || <line-style> || <color>
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<expr=.prop-val-border-left> /, &?ROUTINE.WHY)>}
rule prop-val-border-left { :i [<line-width> :my $*A; <!{
    $*A++
}>| <line-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-left-color: <color>
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<expr=.prop-val-border-left-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-color { :i <color> }
#| border-left-style: <line-style>
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<expr=.prop-val-border-left-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-style { :i <line-style> }
#| border-left-width: <line-width>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<expr=.prop-val-border-left-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-width { :i <line-width> }
#| border-radius: <length-percentage>{1,4} [ / <length-percentage>{1,4} ]?
rule decl:sym<border-radius> { :i ("border-radius") ":" <val(/<expr=.prop-val-border-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-radius { :i <length-percentage> ** 1..4 [<op("/")> <length-percentage> ** 1..4 ] ?  }
#| border-right: <line-width> || <line-style> || <color>
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<expr=.prop-val-border-right> /, &?ROUTINE.WHY)>}
rule prop-val-border-right { :i [<line-width> :my $*A; <!{
    $*A++
}>| <line-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-right-color: <color>
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<expr=.prop-val-border-right-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-color { :i <color> }
#| border-right-style: <line-style>
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<expr=.prop-val-border-right-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-style { :i <line-style> }
#| border-right-width: <line-width>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<expr=.prop-val-border-right-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-width { :i <line-width> }
#| border-style: <line-style>{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<expr=.prop-val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-style { :i <line-style> }
#| border-top: <line-width> || <line-style> || <color>
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<expr=.prop-val-border-top> /, &?ROUTINE.WHY)>}
rule prop-val-border-top { :i [<line-width> :my $*A; <!{
    $*A++
}>| <line-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-top-color: <color>
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<expr=.prop-val-border-top-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-color { :i <color> }
#| border-top-left-radius: <length-percentage>{1,2}
rule decl:sym<border-top-left-radius> { :i ("border-top-left-radius") ":" <val(/<expr=.prop-val-border-top-left-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-left-radius { :i <length-percentage> ** 1..2 }
#| border-top-right-radius: <length-percentage>{1,2}
rule decl:sym<border-top-right-radius> { :i ("border-top-right-radius") ":" <val(/<expr=.prop-val-border-top-right-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-right-radius { :i <length-percentage> ** 1..2 }
#| border-top-style: <line-style>
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<expr=.prop-val-border-top-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-style { :i <line-style> }
#| border-top-width: <line-width>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<expr=.prop-val-border-top-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-width { :i <line-width> }
#| border-width: <line-width>{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<expr=.prop-val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-width { :i <line-width> }
#| box-shadow: none | <shadow>#
rule decl:sym<box-shadow> { :i ("box-shadow") ":" <val(/<expr=.prop-val-box-shadow> /, &?ROUTINE.WHY)>}
rule prop-val-box-shadow { :i none & <keyw>  || <shadow> +% <op(",")>  }
#| <shadow> = <color>? && [<length>{2} <length [0,∞]>? <length>?] && inset?
rule shadow { :i [<color> ? :my $*A
; <!{
    $*A++
}>| [<length> ** 2 <length> ? <length> ? ] :my $*B
; <!{
    $*B++
}>| [inset & <keyw>] ? :my $*C
; <!{
    $*C++
}>]** 3 }