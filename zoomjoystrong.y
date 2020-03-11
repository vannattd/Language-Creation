%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
	
%}

%define parse.error verbose
%start drawing

%union { int i; float f; }

%token POINT
%token END
%token END_STATEMENT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

drawing:	error
	|	shape_list
	|	shape_list END
	|	drawing shape_list
	|	drawing shape_list END
;


shape_list:	shape END_STATEMENT
;

shape:	point 
	| 	circle 
	| 	rectangle 
	| 	line 
	| 	color 
;

rectangle:	RECTANGLE INT INT INT INT 
		{ rectangle($2, $3, $4, $5);	}
;

circle:	CIRCLE INT INT INT 
		{ circle($2, $3, $4); }
;

line:	LINE INT INT INT INT 
		{ line($2, $3, $4, $5); }
;

point:	POINT INT INT 
		{ point($2, $3); }
;

color:		SET_COLOR INT INT INT  
		{ 
			if($2 > 255 || $3 > 255 || $4 > 255){
				printf("Color value is too high!");
			}
			else if($2 < 0 || $3 < 0 || $4 < 0){
				printf("Color value is too low!");
			}
			else{
				set_color($2, $3, $4);
			}
		 }
%%

int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
