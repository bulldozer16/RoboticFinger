SRC = useLibrary.c
CC = gcc
LIB = libarduino_com.a 
APP = testing
OUT = ../bin/$(APP)
CFLAGS = -I ../include
LFLAGS = ../lib/$(LIB)

all: $(APP)

$(APP): $(SRC)
		@$(CC) $(CFLAGS) -o $(OUT) $(SRC) $(LFLAGS)
		@echo "Creating executable \"$(APP)\""

clean:
		@rm $(OUT)
		@echo "Deleting executables"
