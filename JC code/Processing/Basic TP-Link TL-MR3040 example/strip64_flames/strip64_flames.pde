OPC opc;
//PImage im;

// NEW - - - - - - - - - - - - - - - - - -

float angle = 0;

void setup()
{
  size(800, 200);

  // Load a sample image
//  im = loadImage("flames.jpeg");

  // Connect to the local instance of fcserver
//opc = new OPC(this, "127.0.0.1", 7890);              // For running locally.
opc = new OPC(this, "192.168.2.1", 7890);            // For running remotely on TP-Link.

  // Map one 64-LED strip to the center of the window
opc.ledStrip(0, 64, width/2, height/2, width / 70.0, 0, false);

// NEW - - - - - - - - - - - - - - - - - -

  noStroke();
  noStroke();
  fill(255, 255, 255);
}

void draw()
{
//  // Scale the image so that it matches the width of the window
//  int imHeight = im.height * width / im.width;
//
//  // Scroll down slowly, and wrap around
//  float speed = 0.05;
//  float y = (millis() * -speed) % imHeight;
//  
//  // Use two copies of the image, so it seems to repeat infinitely  
//  image(im, 0, y, width, imHeight);
//  image(im, 0, y + imHeight, width, imHeight);

// NEW - - - - - - - - - - - - - - - - - -

  background(0);
  
  float x = (sin(angle) * width/2) + width/2;
//  float d2 = 10 + (sin(angle + PI/2) * diameter/2) + diameter/2;
//  float d3 = 10 + (sin(angle + PI) * diameter/2) + diameter/2;
  
  ellipse(x, height/2, 100, 100);
  
  angle += 0.02;
  
}

