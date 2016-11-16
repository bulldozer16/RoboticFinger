#include <arduino_com.h>
#include <stdio.h>
#include <stdlib.h>


int main(){
	push("ON");
	usleep(1500 * 1000);
	push("OFF");
	usleep(1500 * 1000);
	move_ce('e');
	usleep(1500 * 1000);
	touch();
	return 0;
}
