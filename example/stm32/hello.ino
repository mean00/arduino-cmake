#include "Arduino.h"
#define LED PC13
void setup()
{
    Serial.println("Hi there");
    pinMode(LED,OUTPUT);

}
void loop()
{
    Serial.print("Hey!\n");
    digitalWrite(LED,HIGH);
    delay(500);
    digitalWrite(LED,LOW);
    delay(500);
}
