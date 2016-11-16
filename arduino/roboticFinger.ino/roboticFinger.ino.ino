/*
Arduino representation for a number matrix
Use a serial inputs to simulate movements 
based on a custom device driver output.

Author OskrD

Protocol:
  touch => t
  push  => p (for on) -> P (for off)
  move  => position
 */

int push = 0;

void setup() {
  // initialize serial:
  Serial.begin(9600);
  // Pins for leds
  for (int pin = 2; pin <= 13; pin++){
    pinMode(pin, OUTPUT);
  }
  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);
}

void loop() {
  if (Serial.available()) {
    
    char input = (char)Serial.read();
    
    Serial.println(input);

    if(input == '0'){
      offAll();
      digitalWrite(2, HIGH);
    }
    else if (input == '1'){
      offAll();
      digitalWrite(3, HIGH);
    }
    else if (input == '2'){
      offAll();
      digitalWrite(4, HIGH);
    }
    else if (input == '3'){
      offAll();
      digitalWrite(5, HIGH);
    }
    else if (input == '4'){
      offAll();
      digitalWrite(6, HIGH);
    }
    else if (input == '5'){
      offAll();
      digitalWrite(7, HIGH);
    }
    else if (input == '6'){
      offAll();
      digitalWrite(8, HIGH);
    }
    else if (input == '7'){
      offAll();
      digitalWrite(9, HIGH);
    }
    else if (input == '8'){
      offAll();
      digitalWrite(10, HIGH);
    }
    else if (input == '9'){
      offAll();
      digitalWrite(11, HIGH);
    }
    else if (input == 'C'){
      offAll();
      digitalWrite(12, HIGH);
    }
    else if (input == 'E'){
      offAll();
      digitalWrite(13, HIGH);
    }
    else if (input == 't'){
      digitalWrite(A0, HIGH);
      delay(333);
      digitalWrite(A0, LOW);
    }
    else if (input == 'p'){
      digitalWrite(A1, HIGH);
    }
    else if (input == 'P'){
      digitalWrite(A1, LOW);
    }
  }
}

void offAll(){
  digitalWrite(A0, LOW);
  digitalWrite(A1, LOW);
  for(int pin = 2; pin <= 13; pin++){
    digitalWrite(pin, LOW);
  }
  
}

