/* ==============================
 * This code, which assumes you're using the official Arduino Ethernet shield,
 * updates a Pachube feed with your analog-in values and grabs values from a Pachube
 * feed - basically it enables you to have both "local" and "remote" sensors.
 * 
 * Tested with Arduino 14
 *
 * Pachube is www.pachube.com - connect, tag and share real time sensor data
 * code by usman (www.haque.co.uk), may 2009
 * copy, distribute, whatever, as you like.
 *
 * v1.1 - added User-Agent & fixed HTTP parser for new Pachube headers
 * and check millis() for when it wraps around
 * * This is AKA's modification of the above-mentioned example.
 * I have this running on an Arduino Diecimila and Arduino 19. The Ethernet shield is the second official version
 * (that is, the first board to have a mini-SD card slot on it).
 *
 * The code here is a very basic loop that sends an update to Pachube.com at specified intervals. 
 * Right now, I only have a photocell on Analog 0 and and a TMP36 on Analog pin 4
 * =============================== */


#include <Ethernet.h>
#include <string.h>

#undef int() // needed by arduino 0011 to allow use of stdio
#include <stdio.h> // for function sprintf

#define SHARE_FEED_ID              YOUR_FEED_ID_HERE     // this is your Pachube feed ID that you want to share to
//#define REMOTE_FEED_ID             256      // this is the ID of the remote Pachube feed that you want to connect to
//#define REMOTE_FEED_DATASTREAMS    4        // make sure that remoteSensor array is big enough to fit all the remote data streams
#define UPDATE_INTERVAL            60000    // if the connection is good wait 60 seconds before updating again - should not be less than 5
#define RESET_INTERVAL             10000    // if connection fails/resets wait 10 seconds before trying again - should not be less than 5

#define PACHUBE_API_KEY            "YOUR_API_KEY_HERE" // fill in your API key 

#define tempPin 4 //our tmp36 probe is on Analog pin 0 NOTE this is digital pin 14!
#define photoPin 0 //photocell is on analog pin 0
byte mac[] = { 0x00, 0x18, 0x41, 0xEF, 0x21, 0x96 }; // make sure this is unique on your network. This is the wiznet's MAC address as seen by my router
// 192.168.10.9 is the IP I assigned to my new ethernet shield - your IP is probably different
byte ip[] = { 192, 168, 10, 9 };
byte remoteServer[] = {173,203,98,29};           // pachube.com (want to check? open a terminal and type "ping pachube.com"



// float remoteSensor[REMOTE_FEED_DATASTREAMS];        // we know that feed 256 has floats - this might need changing for feeds without floats

void setup()
{
  Serial.begin(9600); 
  setupEthernet(); 

 // pinMode(3, OUTPUT);
 // pinMode(5, OUTPUT);
 // pinMode(6, OUTPUT);
  pinMode(13,OUTPUT);
  pinMode(14,INPUT); //analog pin 0 (photocell)
  pinMode(15,INPUT); //analog pin 1 (not used yet)
  pinMode(18,INPUT); //analog pin 4 (TMP36)
}

void loop()
{

  // call 'pachube_in_out' at the beginning of the loop, handles timing, requesting
  // and reading. use serial monitor to view debug messages

  pachube_in_out();

  // then put your code here, you can access remote sensor values
  // by using the remoteSensor float array, e.g.: 

 // analogWrite(3, (int)remoteSensor[3] * 10); // remoteSensor is a float
 // analogWrite(5, (int)remoteSensor[1]); 

  // you can have code that is time sensitive (e.g. using 'delay'), but 
  // be aware that it will be affected by a short pause during connecting
  // to and reading from ethernet (approx. 0.5 to 1 sec).
  // e.g. this code should carry on flashing regularly, with brief pauses
  // every few seconds during Pachube update.

  digitalWrite(13, HIGH);
  delay(100);
  digitalWrite(13, LOW);
  delay(100);

}

