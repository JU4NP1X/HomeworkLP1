%option outfile = "flex.c"
%option yywrap
%{
    #include "validarContrasena.tab.h"
%}

%%
"\n" return (END);
<<EOF>> {yyterminate();}
[a-z] return(LOWERCASE);
[A-Z]  return (UPPERCASE);
[0-9]  return (NUMBER);
[\=\*\-\_\.] return (SPECIALCHART);
("á")|("é")|("í")|("ó")|("ú")|("ñ")|("Á")|("É")|("Í")|("Ó")|("Ú")|("Ñ") return (INVALID2BYTESCHART);
[^a-zA-Z0-9\=\*\-\_\.\&\@] return (INVALIDCHART);
A{4}|B{4}|C{4}|D{4}|E{4}|F{4}|G{4}|H{4}|I{4}|J{4}|K{4}|M{4}|N{4}|O{4}|P{4}|Q{4}|R{4}|S{4}|T{4}|U{4}|V{4}|W{4}|X{4}|Y{4}|Z{4} return (CONSECUTIVEUPPER);
a{4}|b{4}|c{4}|d{4}|e{4}|f{4}|g{4}|h{4}|i{4}|j{4}|k{4}|m{4}|n{4}|o{4}|p{4}|q{4}|r{4}|s{4}|t{4}|u{4}|v{4}|w{4}|x{4}|y{4}|z{4} return (CONSECUTIVELOWER);
0{4}|1{4}|2{4}|3{4}|4{4}|5{4}|6{4}|7{4}|8{4}|9{4} return (CONSECUTIVENUMBER);
(\=){4}|(\*){4}|(\-){4}|(\_){4}|(\.){4}|(\&){4}|(\@){4} return (CONSECUTIVESPECIAL);

%%
