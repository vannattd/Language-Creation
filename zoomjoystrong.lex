%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%

[-+]?[0-9]*\.[0-9]+			{ yylval.f = atof(yytext); return FLOAT; }
[-+]?[0-9]+					{ yylval.i = atoi(yytext); return INT; }
circle						{ return CIRCLE; }
end                         { return END; }
rectangle					{ return RECTANGLE; }
point						{ return POINT; }
set_color					{ return SET_COLOR; }
line						{ return LINE; }
;							{ return END_STATEMENT; }
[ \t\n]						;
.							{ return yytext[0]; }

%%