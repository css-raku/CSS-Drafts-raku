use v6;
use Test;
use CSS::Drafts::CSS3;

my %prop = CSS::Drafts::CSS3.module.property-metadata;
is-deeply %prop<azimuth>, {:default['center', [{:keyw<center>},] ], :inherit, :synopsis("<angle> | [ <direction> || <behind> ] | <delta>")}, 'azimuth';
is-deeply %prop<border>, {:box, :children["border-width", "border-style"], :edges["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("<'border-width'> || <'border-style'> || <color>")}, 'border';
is-deeply %prop<border-style>, {:box, :edges["border-top-style", "border-right-style", "border-bottom-style", "border-left-style"], :!inherit, :synopsis("<line-style>\{1,4}")}, 'border-style';
is-deeply %prop<box-shadow>, {:default($["none", [{:keyw("none")},]]), :!inherit, :synopsis("none | <shadow>#")}, 'box-shadow';

done-testing;
