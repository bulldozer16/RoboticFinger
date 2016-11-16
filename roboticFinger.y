%{

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* Lex and Yacc variables */

extern int yylex();
extern int yyparse();
extern FILE *yyin;

FILE *inputf;		// Configurations file
FILE *err_file;		// Error module file

int linenumber = 1;	// Keeps track of the current line

int t = 0;		// Time to be pushed the current position
int curr_x = 0;		// Current x coordinate
int curr_y = 0;		// Current y coordinate
int x = 0;		// x coordinate of the matrix
int y = 0;		// y coordenate of the matrix
int p = 0;		// Pin to dial

int keyboard[4][3] = { {0, 1, 2}, {3, 4, 5}, {6, 7, 8}, {9, 67, 69} };	// Keyboard

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
	INSTR_TOUCH				{/*touch();*/}
	;

instr_push:
	INSTR_PUSH time				{
							if (t > 60)
							{
								yyerror("Push time cannot exceed 60 seconds");							
							}
							else
							{
								push("ON");
								sleep(t);
								push("OFF");
							}							
						}
	;

instr_drag:
	INSTR_DRAG final_x final_y		{drag(x, y);}
	;

instr_move:
	INSTR_MOVE final_x final_y		{_move(x, y);}
	;

instr_pin:
	INSTR_PIN pin				{pin(p);}
	;

time:
	NUM					{t = $<ival>1;}
	;

final_x:
	NUM					{
							curr_x = x;
							x = $<ival>1;
						 	if (x > 2)
							{
								yyerror("Invalid x coordinate");
								x = 0;
							}
						}
	;

final_y:
	NUM					{
							curr_y = y;
							y = $<ival>1;
						 	if (y > 3)
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

/* Makes successive calls to the library's move function to perform
   the movement on the keyboard */

void _move(int _x, int _y)
{
	if (curr_x == _x && curr_y == _y)
	{
		//printf("======================\n");
		return;	
	}
	else
	{
		if (_x > curr_x) {curr_x++;}
		else if (_x < curr_x) {curr_x--;}
		else if (_y > curr_y) {curr_y++;}
		else {curr_y--;}

		//printf("Next move: (%d, %d)\n", curr_x, curr_y);
		int val = keyboard[curr_y][curr_x];
		if (val == 67)
		{
			move('C');
		}
		else if (val == 69)
		{
			move('E');
		}
		else
		{
			move(val)
		}
		sleep(1);
		_move(_x, _y);
	}
}

/* Sets x and y value of a number in the keyboard */

void set_coordinates(int number)
{
	for (int i = 0; i < 4; i++)
	{
		y = i;
		for (int j = 0; j < 3; j++)
		{
			x = j;
			if (keyboard[i][j] == number) return;
		}
	}
}

/* Performs the drag operation based on the primitive operations
   of move and touch provided by the library */

void drag(int _x, int _y)
{
	/*touch();*/
	_move(_x, _y);
	/*touch();*/
}

/* Performs the dialing of the pin established by the PIN instruction */

void pin(int _pin)
{
	char *buffer = (char *) malloc(sizeof(char) * 7);
	snprintf(buffer, 7, "%d", _pin);
	
	for ( ; *buffer; ++buffer)
	{
		int val = *buffer - '0';
		set_coordinates(val);
		_move(x, y);
		/*touch();*/
	}

	free(*buffer);
}

/* Writes an error message to the error module file along with the line number
   where it occurred. */

void yyerror(const char *s) 
{
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

	fclose(err_file);
	fclose(inputf);

	printf("Done...\n");
	
	return 0;
}
