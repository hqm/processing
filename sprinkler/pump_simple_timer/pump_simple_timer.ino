
/* 
 Automatic plant watering system
 pump control
 
 Henry Minsky hqm@alum.mit.edu
 Harry Minsky harry.minsky@gmail.com
 */

//output connected to pump motor drive
int pump = 4;
int sensor1 = 5;
int beeper = 2;
int val = 0;


int state = 0;

int START = 0;
int PUMP_ON = 1;
int PUMP_OFF = 2;
int PUMP_OFF_ALARM = 3;
int waterings = 0;

#define PUMP_TIMEOUT 60000

int THRESHOLD_LOW = 300;
int THRESHOLD_HIGH = 500;

unsigned long WAIT_TIME = 60L*1000L;

unsigned long start_time;


void setup() {
  pinMode(pump, OUTPUT);      // sets the digital pin as output
  pinMode(beeper, OUTPUT);
  // initialize the serial port:
  Serial.begin(9600);
  state = START;
}

void beep(int time){
  digitalWrite(beeper,HIGH);
  delay(time);
  digitalWrite(beeper,LOW);
  
}

void delayseconds(unsigned long nseconds) {
  for (int i = 0; i < nseconds; i++) {
      delay(1000);
  }
}

void delayminutes(unsigned long nminutes) {
  for (int i = 0; i < nminutes; i++) {
      delayseconds(60);
  }
}

void loop() {
  
  
    digitalWrite(pump, HIGH);
    Serial.println("PUMP_ON");
    delayseconds(10);
    digitalWrite(pump, LOW);
    Serial.println("PUMP_OFF");
    delayminutes(60*12);
    
  }

  


