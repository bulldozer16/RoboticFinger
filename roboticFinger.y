%{

#include <stdio.h>
#include <stdlib.h>

/* Lex and Yacc variables */

extern int yylex();
extern int yyparse();
extern FILE *yyin;

FILE *inputf;		// Configurations file
FILE *err_file;		// Error module file

int linenumber = 1;	// Keeps track of the current line
int err_bool = 0;	// Indicates if an error has occurred

int t = 0;		// Time to be pushed the current position
int x = 0;		// x coordinate of the matrix
int y = 0;		// y coordenate of the matrix
int p = 0;		// Pin to dial

%}

%union {int ival; char *string;};

/* Initial symbol and grammar tokens */

%start program

%token INSTR_TOUCH
%token INSTR_PUSH
%token INSTR_DRAG
%token INSTR_MOVE
%token INSTR_PIN

%token NEWLINE
%token NUM

%%

program: 
	instruction newline program			
	| NEWLINE program
	|
	;

newline: 
	NEWLINE					{linenumber++;}
	;

instruction: 
	instr_touch				
	| instr_push			
	| instr_drag			
	| instr_move
	| instr_pin
	;

instr_touch:
	INSTR_TOUCH				{/* touch() */}
	;

instr_push:
	INSTR_PUSH time				{/* push(t) */}
	;

instr_drag:
	INSTR_DRAG final_x final_y		{/* drag(x, y) */}
	;

instr_move:
	INSTR_MOVE final_x final_y		{/* move(x, y) */}
	;

instr_pin:
	INSTR_PIN pin				{/* pin(p) */}
	;

time:
	NUM					{t = $<ival>1;}
	;

final_x:
	NUM					{
							x = $<ival>1;
						 	if (x > 3)
							{
								yyerror("Invalid x coordinate");
								x = 0;
							}
						}
	;

final_y:
	NUM					{
							y = $<ival>1;
						 	if (y > 2)
							{
								yyerror("Invalid y coordinate");
								y = 0;
							}
						}
	;

pin:
	NUM					{p = $<ival>1;}
	;
%%

/* Writes an error message to the error module file along with the line number
   where it occurred. */

void yyerror(const char *s) 
{
	if (err_bool == 0) err_bool = 1;
	fprintf(err_file, "Error in line %d. Error: %s.\n", linenumber, s);
	printf("Error in line %d. Error: %s.\n", linenumber, s);
} 

/* Main function. Reads and executes a program specified in the 
   configuration file. The instructions are passed to the driver using
   the library developed. */

int main(int argc, char **argv) 
{
	if (argc != 3)
	{
		printf("Usage: %s -c <config_file>\n", argv[0]);
		return -1;
	}

	if (strcmp("-c", argv[1]) != 0)
	{
		printf("Usage: %s -c <config_file>\n", argv[0]);
		return -1;
	}

	inputf = fopen(argv[2], "r");
	if (!inputf)
	{
		printf("Can't open configuration file. File %s may not exist\n", argv[2]);
		return -1;
	}

	err_file = fopen("Error module", "w");

	char line[32];				
	yyin = inputf;

	do 
	{
    		yyparse();
	} 
	while (!feof(yyin));

	if (err_bool) 
	{
		printf("Error durante la simulación. Ver archivo Error Module.\n");
		fclose(err_file);
		return 1;
	}

	fprintf(err_file, "¡No hay errores en el archivo %s!", argv[2]);

	fclose(err_file);
	fclose(inputf);

	printf("Simulado exitosamente.\n");
	
	return 0;
}
