%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sim.tab.h"  	/* Se incluye el archivo donde se definen los valores de las constantes 
			   correspondientes a cada palabra clave. */
%}

numd	([0-9])+
%%
			/* Se definen todas las palabras clave del lenguaje y su valor de retorno (definido en
			   constantes con el mismo nombre, que se declaran en y.tab.h; */

("TOUCH"|"touch")			{return INSTR_TOUCH;}
("PUSH"|"push")				{return INSTR_PUSH;}
("DRAG"|"drag")				{return INSTR_DRAG;}
("MOVE"|"move")				{return INSTR_MOVE;}
("PIN"|"pin")				{return INSTR_PIN;}

					/* Definición de las expresiones regulares que describen los tokens válidos. */

[ \t]					/* No hacer nada si se encuentra un espacio o una tabulación. */
[\n]					{return NEWLINE;}		
					/* Si se encuentra un cambio de línea, aumentar el número de línea y retornar 
					   el valor constante NEWLINE (ver y.tab.h). */
{numd}					{ yylval.ival = atoi(yytext);return NUM;}
					/* Cuando se encuentra un NUM, se pasa el valor real del  identificador a una 
					   de las variables de yacc y se retorna el valor constante NUM (ver y.tab.h). */
.					{ return *yytext;}		
					/* Si se encuentra algo que no coincida con las categorías anteriores, retornarlo. */

%%

/* Es necesario definir esta función, pues se hace una llamada a yywrap cuando yylex()
   alcanza el final del archivo. */

int yywrap()
{
	return 1;
}
