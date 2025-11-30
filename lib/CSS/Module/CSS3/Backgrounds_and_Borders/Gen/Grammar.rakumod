unit grammar CSS::Module::CSS3::Backgrounds_and_Borders::Gen::Grammar;
#| <bg-layer> = <'background-image'> || <'background-position'> [ / <'background-size'> ]? || <'background-repeat'> || <'background-attachment'> || <'background-clip'>
rule bg-layer { :i [<css-val-background-image> :my $*A; <!{
    $*A++
}>|| <css-val-background-position> [<op("/")> <css-val-background-size> ] ?  :my $*B; <!{
    $*B++
}>|| <css-val-background-repeat> :my $*C; <!{
    $*C++
}>|| <css-val-background-attachment> :my $*D; <!{
    $*D++
}>|| <css-val-background-clip> :my $*E; <!{
    $*E++
}>]+ }
#| <final-bg-layer> = <'background-image'> || <'background-position'> [ / <'background-size'>{1,2} ]? || <'background-repeat'> || <'background-attachment'> || <'background-clip'> || <'background-color'>
rule final-bg-layer { :i [<css-val-background-image> :my $*A; <!{
    $*A++
}>|| <css-val-background-position> [<op("/")> <css-val-background-size> ** 1..2 ] ?  :my $*B; <!{
    $*B++
}>|| <css-val-background-repeat> :my $*C; <!{
    $*C++
}>|| <css-val-background-attachment> :my $*D; <!{
    $*D++
}>|| <css-val-background-clip> :my $*E; <!{
    $*E++
}>|| <css-val-background-color> :my $*F; <!{
    $*F++
}>]+ }
#| <attachment> = scroll | fixed | local
rule attachment { :i [scroll | fixed | local ]& <keyw>  }
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
rule layout-box { :i <visual-box> || "margin-box" & <keyw>  }
#| <paint-box> = <visual-box> | fill-box | stroke-box
rule paint-box { :i <visual-box> || ["fill-box" | "stroke-box" ]& <keyw>   }
#| <coord-box> = <paint-box> | view-box
rule coord-box { :i <paint-box> || "view-box" & <keyw>  }
#| <gradient> = <linear-gradient()> | <repeating-linear-gradient()> |   <radial-gradient()> | <repeating-radial-gradient()>
rule gradient { :i <linear-gradient> || <repeating-linear-gradient> || <radial-gradient> || <repeating-radial-gradient>  }
#| linear-gradient( [ <linear-gradient-syntax> ] )
rule linear-gradient { :i "linear-gradient(" [<linear-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| repeating-linear-gradient( [ <linear-gradient-syntax> ] )
rule repeating-linear-gradient { :i "repeating-linear-gradient(" [<linear-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <linear-gradient-syntax> = [ <angle> | to <side-or-corner> ]? , <color-stop-list>
rule linear-gradient-syntax { :i [<angle> || to & <keyw> <side-or-corner>  ] ? <op(",")> <color-stop-list>  }
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
}>|| <radial-size> :my $*B; <!{
    $*B++
}>]+] ? [at & <keyw> <position> ] ? <op(",")> <color-stop-list>  }
#| <radial-size> = <radial-extent> | <length [0,∞]> | <length-percentage [0,∞]>{2}
rule radial-size { :i <radial-extent> || <length> || <length-percentage> ** 2  }
#| <radial-extent> = closest-corner | closest-side | farthest-corner | farthest-side
rule radial-extent { :i ["closest-corner" | "closest-side" | "farthest-corner" | "farthest-side" ]& <keyw>  }
#| <radial-shape> = circle | ellipse
rule radial-shape { :i [circle | ellipse ]& <keyw>  }
#| <side-or-corner> = [left | right] || [top | bottom]
rule side-or-corner { :i [[[left | right ]& <keyw> ] :my $*A; <!{
    $*A++
}>|| [[top | bottom ]& <keyw> ] :my $*B; <!{
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
#| background: <bg-layer>#?, <final-bg-layer>
rule decl:sym<background> { :i (background) ":" <val(/<css-val-background> /, &?ROUTINE.WHY)>}
rule css-val-background { :i [<bg-layer> <op(",")> ]* <final-bg-layer>  }
#| background-attachment: <attachment>#
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<css-val-background-attachment> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-attachment { :i <attachment> }
#| background-clip: <visual-box>#
rule decl:sym<background-clip> { :i ("background-clip") ":" <val(/<css-val-background-clip> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-clip { :i <visual-box> }
#| background-color: <color>
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<css-val-background-color> /, &?ROUTINE.WHY)>}
rule css-val-background-color { :i <color> }
#| background-image: [<image> | none]#
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<css-val-background-image> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-image { :i [<image> || none & <keyw> ] }
#| background-origin: <visual-box>#
rule decl:sym<background-origin> { :i ("background-origin") ":" <val(/<css-val-background-origin> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-origin { :i <visual-box> }
#| background-position: <position>#
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<css-val-background-position> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-position { :i <position> }
#| background-repeat: <repeat-style>#
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<css-val-background-repeat> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-repeat { :i <repeat-style> }
#| background-size: [[ <length-percentage [0,∞]> | auto ]{1,2} | cover | contain]#
rule decl:sym<background-size> { :i ("background-size") ":" <val(/<css-val-background-size> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-background-size { :i [[<length-percentage> || auto & <keyw> ] ** 1..2 || [cover | contain ]& <keyw>  ] }
#| border: <'border-width'> || <'border-style'> || <color>
rule decl:sym<border> { :i (border) ":" <val(/<css-val-border> /, &?ROUTINE.WHY)>}
rule css-val-border { :i [<css-val-border-width> :my $*A; <!{
    $*A++
}>|| <css-val-border-style> :my $*B; <!{
    $*B++
}>|| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-bottom: <line-width> || <line-style> || <color>
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<css-val-border-bottom> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom { :i [<line-width> :my $*A; <!{
    $*A++
}>|| <line-style> :my $*B; <!{
    $*B++
}>|| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-bottom-color: <color>
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<css-val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-color { :i <color> }
#| border-bottom-left-radius: <length-percentage>{1,2}
rule decl:sym<border-bottom-left-radius> { :i ("border-bottom-left-radius") ":" <val(/<css-val-border-bottom-left-radius>** 1..2 /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-left-radius { :i <length-percentage> }
#| border-bottom-right-radius: <length-percentage>{1,2}
rule decl:sym<border-bottom-right-radius> { :i ("border-bottom-right-radius") ":" <val(/<css-val-border-bottom-right-radius>** 1..2 /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-right-radius { :i <length-percentage> }
#| border-bottom-style: <line-style>
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<css-val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-style { :i <line-style> }
#| border-bottom-width: <line-width>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<css-val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-width { :i <line-width> }
#| border-color: <color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<css-val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-color { :i <color> }
#| border-image: <'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>
rule decl:sym<border-image> { :i ("border-image") ":" <val(/<css-val-border-image> /, &?ROUTINE.WHY)>}
rule css-val-border-image { :i [<css-val-border-image-source> :my $*A; <!{
    $*A++
}>|| <css-val-border-image-slice> [<op("/")> <css-val-border-image-width>  || <op("/")> <css-val-border-image-width> ? <op("/")> <css-val-border-image-outset>  ] ?  :my $*B; <!{
    $*B++
}>|| <css-val-border-image-repeat> :my $*C; <!{
    $*C++
}>]+ }
#| border-image-outset: [ <length> | <number> ]{1,4}
rule decl:sym<border-image-outset> { :i ("border-image-outset") ":" <val(/<css-val-border-image-outset>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-image-outset { :i [<length> || <number> ] }
#| border-image-repeat: [ stretch | repeat | round | space ]{1,2}
rule decl:sym<border-image-repeat> { :i ("border-image-repeat") ":" <val(/<css-val-border-image-repeat>** 1..2 /, &?ROUTINE.WHY)>}
rule css-val-border-image-repeat { :i [[stretch | repeat | round | space ]& <keyw> ] }
#| border-image-slice: [[<number> | <percentage>] fill?]{1,4}
rule decl:sym<border-image-slice> { :i ("border-image-slice") ":" <val(/<css-val-border-image-slice>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-image-slice { :i [[<number> || <percentage> ] [fill & <keyw>] ? ] }
#| border-image-source: none | <image>
rule decl:sym<border-image-source> { :i ("border-image-source") ":" <val(/<css-val-border-image-source> /, &?ROUTINE.WHY)>}
rule css-val-border-image-source { :i none & <keyw> || <image>  }
#| border-image-width: [ <length-percentage> | <number> | auto ]{1,4}
rule decl:sym<border-image-width> { :i ("border-image-width") ":" <val(/<css-val-border-image-width>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-image-width { :i [<length-percentage> || <number> || auto & <keyw> ] }
#| border-left: <line-width> || <line-style> || <color>
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<css-val-border-left> /, &?ROUTINE.WHY)>}
rule css-val-border-left { :i [<line-width> :my $*A; <!{
    $*A++
}>|| <line-style> :my $*B; <!{
    $*B++
}>|| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-left-color: <color>
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<css-val-border-left-color> /, &?ROUTINE.WHY)>}
rule css-val-border-left-color { :i <color> }
#| border-left-style: <line-style>
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<css-val-border-left-style> /, &?ROUTINE.WHY)>}
rule css-val-border-left-style { :i <line-style> }
#| border-left-width: <line-width>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<css-val-border-left-width> /, &?ROUTINE.WHY)>}
rule css-val-border-left-width { :i <line-width> }
#| border-radius: <length-percentage>{1,4} [ / <length-percentage>{1,4} ]?
rule decl:sym<border-radius> { :i ("border-radius") ":" <val(/<css-val-border-radius> /, &?ROUTINE.WHY)>}
rule css-val-border-radius { :i <length-percentage> ** 1..4 [<op("/")> <length-percentage> ** 1..4 ] ?  }
#| border-right: <line-width> || <line-style> || <color>
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<css-val-border-right> /, &?ROUTINE.WHY)>}
rule css-val-border-right { :i [<line-width> :my $*A; <!{
    $*A++
}>|| <line-style> :my $*B; <!{
    $*B++
}>|| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-right-color: <color>
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<css-val-border-right-color> /, &?ROUTINE.WHY)>}
rule css-val-border-right-color { :i <color> }
#| border-right-style: <line-style>
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<css-val-border-right-style> /, &?ROUTINE.WHY)>}
rule css-val-border-right-style { :i <line-style> }
#| border-right-width: <line-width>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<css-val-border-right-width> /, &?ROUTINE.WHY)>}
rule css-val-border-right-width { :i <line-width> }
#| border-style: <line-style>{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<css-val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-style { :i <line-style> }
#| border-top: <line-width> || <line-style> || <color>
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<css-val-border-top> /, &?ROUTINE.WHY)>}
rule css-val-border-top { :i [<line-width> :my $*A; <!{
    $*A++
}>|| <line-style> :my $*B; <!{
    $*B++
}>|| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-top-color: <color>
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<css-val-border-top-color> /, &?ROUTINE.WHY)>}
rule css-val-border-top-color { :i <color> }
#| border-top-left-radius: <length-percentage>{1,2}
rule decl:sym<border-top-left-radius> { :i ("border-top-left-radius") ":" <val(/<css-val-border-top-left-radius>** 1..2 /, &?ROUTINE.WHY)>}
rule css-val-border-top-left-radius { :i <length-percentage> }
#| border-top-right-radius: <length-percentage>{1,2}
rule decl:sym<border-top-right-radius> { :i ("border-top-right-radius") ":" <val(/<css-val-border-top-right-radius>** 1..2 /, &?ROUTINE.WHY)>}
rule css-val-border-top-right-radius { :i <length-percentage> }
#| border-top-style: <line-style>
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<css-val-border-top-style> /, &?ROUTINE.WHY)>}
rule css-val-border-top-style { :i <line-style> }
#| border-top-width: <line-width>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<css-val-border-top-width> /, &?ROUTINE.WHY)>}
rule css-val-border-top-width { :i <line-width> }
#| border-width: <line-width>{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<css-val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-width { :i <line-width> }
#| box-shadow: none | <shadow>#
rule decl:sym<box-shadow> { :i ("box-shadow") ":" <val(/<css-val-box-shadow> /, &?ROUTINE.WHY)>}
rule css-val-box-shadow { :i none & <keyw> || <shadow> +% <op(",")>  }
#| <shadow> = <color>? && [<length>{2} <length [0,∞]>? <length>?] && inset?
rule shadow { :i [<color> ? :my $*A
; <!{
    $*A++
}>|| [<length> ** 2 <length> ? <length> ? ] :my $*B
; <!{
    $*B++
}>|| [inset & <keyw>] ? :my $*C
; <!{
    $*C++
}>]** 3 }