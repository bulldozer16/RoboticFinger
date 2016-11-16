SRC = arduino_com.c
H = ../include/arduino_com.h
CC = gcc
AR = ar r
RANLIB = ranlib
LD = ld
LIB_E = libarduino_com.a 
OBJ = arduino_com.o

all: estatica


estatica: $(SRC) $(H)
		@$(CC) -c $(SRC)
		@$(AR) $(LIB_E) $(OBJ)
		@$(RANLIB) $(LIB_E)
		@echo "Creating a static library"


clean:
		@rm *.a $(OBJ)
		@echo "Eliminando biblioteca" 
