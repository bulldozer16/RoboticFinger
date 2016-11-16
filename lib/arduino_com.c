#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Library to arduino_usb.ko
 * Write to /dev/arduino1 file to send serial data to device
 * Author: OskrD
 */
FILE * device;   //pointer for a file handled to driver

//handle a begin or end to push function 
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

//handle a touch function 
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

//handle a move function, receive an appropiate new position for the movement
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

//handle a move function, receive an appropiate value for the cancel or enter buttons
void move_ce(char pos){
	device = fopen("/dev/arduino1","r+");
		
    if(device != NULL){
		fprintf(device, "%c", pos);
		fclose(device);
	}
	else{
		printf("File no found\n");
	}
}





