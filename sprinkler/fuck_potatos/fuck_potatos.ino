
/* 
 pump control
 
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

int THRESHOLD_LOW = 300;
int THRESHOLD_HIGH = 500;

unsigned long WAIT_TIME = 60L*60L*1000L;

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


void loop() {
  
  if (state == START) {
    Serial.println("STATE = START");
    Serial.print("waterings = "); 
    Serial.println(waterings);

      val = analogRead(sensor1);    // read the input pin
      Serial.println(val);
      delay(1000);
      if (val < THRESHOLD_LOW) {
           digitalWrite(pump, HIGH);
           Serial.println("entering state PUMP_ON");
           state = PUMP_ON;
           start_time = millis();
      }
    
  } else if (state == PUMP_ON) {  
      Serial.println("STATE = PUMP_ON");
      waterings = waterings + 1;
  
      val = analogRead(sensor1);    // read the input pin
      Serial.println(val);
      delay(1000);
      if (val  > THRESHOLD_HIGH) {
           digitalWrite(pump, LOW);
           Serial.println("entering state PUMP_OFF");
           state = PUMP_OFF;
      }
      if (millis() - start_time > 20000) {
        state = PUMP_OFF_ALARM;
      }
  } else if (state == PUMP_OFF) {
       digitalWrite(pump, LOW);
        Serial.println("STATE = PUMP_OFF");
        Serial.println("waiting one hour between waterings");
        delay(WAIT_TIME);
        state = START;
    
  } else if (state == PUMP_OFF_ALARM) {
               digitalWrite(pump, LOW);

        Serial.println("STATE = ALARM");

    beep(5000);
    delay(1000);
     val = analogRead(sensor1);    // read the input pin
      Serial.println(val);
      if (val  > THRESHOLD_HIGH) {
           digitalWrite(pump, LOW);
           Serial.println("entering state PUMP_OFF");
           state = PUMP_OFF;
      }
    
  }
    delay(250);
    
  }

  
  
  
  
  //beep(2000);  
  

  /*
   //Serial.println("start");
  digitalWrite(pump, HIGH);
  delay(2000);
  //Serial.println("stop");
  delay(2000);
  */
   


