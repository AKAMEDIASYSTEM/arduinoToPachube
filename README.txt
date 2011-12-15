Hi, this is a very unambitious set of scripts culled from the forums of Pachube and Arduino's fine user communities. 

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
 *
 * * This is AKA's modification of the above-mentioned example.
 * I have this running on an Arduino Diecimila and Arduino 19. The Ethernet shield is the second official version
 * (that is, the first board to have a mini-SD card slot on it).
 *
 * The code here is a very basic loop that sends an update to Pachube.com at specified intervals. 
 * Right now, I only have a photocell on Analog 0 and and a TMP36 on Analog pin 4
 * =============================== */

Best, AKA
2010/10/30
akamediasystem.com