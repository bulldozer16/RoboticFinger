%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sim.tab.h"

// Regex for decimal numbers
%}

numd	([0-9])+
%%
	/* Language keywords and their return value */

("TOUCH"|"touch")			{return INSTR_TOUCH;}
("PUSH"|"push")				{return INSTR_PUSH;}
("DRAG"|"drag")				{return INSTR_DRAG;}
("MOVE"|"move")				{return INSTR_MOVE;}
("PIN"|"pin")				{return INSTR_PIN;}

[ \t]					/* Do nothing in case of tab and whitespace */
[\n]					{return NEWLINE;}		
{numd}					{yylval.ival = atoi(yytext); return NUM;}
					/* Obtain integer value and store it in yylval variable. Return NUM */
.					{return *yytext;}		

%%

/* Function called by Lex at the end of the lexical analysis */

int yywrap()
{
	return 1;
}
