#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE * device;   //pointer for a file handled to driver


void push(char * state){
	device = fopen("/dev/arduino1","r+");
	if(device != NULL){
		if (strcmp(state, "ON") == 0) {
			fprintf(device, "%c", 'p');
		}
		else if (strcmp(state, "OFF") == 0){
			fprintf(device, "%c", 'P');
		}
		fclose(device);
	}
	else{
		printf("File no found\n");
	}
}


void touch(){
	device = fopen("/dev/arduino1","r+");
	if(device != NULL){
		fprintf(device, "%c", 't');
		fclose(device);
	}
	else{
		printf("File no found\n");
	}
}

void move(int pos){
	device = fopen("/dev/arduino1","r+");
	if(device != NULL){
		fprintf(device, "%d", pos);
		fclose(device);
	}
	else{
		printf("File no found\n");
	}
}

void move_ce(char pos){
	device = fopen("/dev/arduino1","r+");
	/*if (strcmp(pos, "C") != 0 || strcmp(pos, "E") != 0){
		printf("Position not posible |%s|\n ", pos);
	}	
	else*/ if(device != NULL){
		fprintf(device, "%c", pos);
		fclose(device);
	}
	else{
		printf("File no found\n");
	}
}
