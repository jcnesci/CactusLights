// References:
// https://processing.org/examples/softbody.html

public class LightBlob 
{
  
//  float x;
//  float y;
//  float angle = 0;
  
  float shapeX;
  float shapeY;
  int nodes = 4;
  float centerX = 0, centerY = 0;
  float nodeStartX[] = new float[nodes];
  float nodeStartY[] = new float[nodes];
  float radius = 45, rotAngle = -90;
  float accelX, accelY;
  float springing = .0009, damping = .98;
  float[]nodeX = new float[nodes];
  float[]nodeY = new float[nodes];
  float[]angle = new float[nodes];
  float[]frequency = new float[nodes];
  // soft-body dynamics
  float organicConstant = 1;
  
  int savedTime;
  int totalTime = 2000;
  
  LightBlob( PApplet parent )
  {
    parent.registerDraw( this ); 
    noStroke();
    fill(255, 255, 255);
    frameRate(30);
    
    //center shape in window
    centerX = width/2;
    centerY = height/2;
    // iniitalize frequencies for corner nodes
    for (int i=0; i<nodes; i++){
      frequency[i] = random(5, 15);
    }
  }
  
  void draw()
  {
//    setState( "idle" );
    
    // Calculate how much time has passed
    int passedTime = millis() - savedTime;
    // Has five seconds passed?
    if (passedTime > totalTime) {
      println( " 5 seconds have passed! " );
      changeShapePosition();
      savedTime = millis(); // Save the current time to restart the timer!
    }
    drawShape();
    moveShape();
    
  }
  
//  void setState( String iState )
//  {
//    if ( iState == "idle" ) {
//      x = (sin(angle) * width/8) + width/2;
//      y = (sin(angle) * height/8) + height/2;
//      ellipse(x, y, 100, 100);
//      angle += 0.02;
//    }
//  }
  
  void changeShapePosition()
  {
    shapeX = random( -width/5, width/5 ) + width/2;
    shapeY = random( -height/7, height/7 ) + height/2;  
  }
  
  void drawShape() {
    //  calculate node  starting locations
    for (int i=0; i<nodes; i++){
      nodeStartX[i] = centerX+cos(radians(rotAngle))*radius;
      nodeStartY[i] = centerY+sin(radians(rotAngle))*radius;
      rotAngle += 360.0/nodes;
    }
  
    // draw polygon
    curveTightness(organicConstant);
    fill(255);
    beginShape();
    for (int i=0; i<nodes; i++){
      curveVertex(nodeX[i], nodeY[i]);
    }
    for (int i=0; i<nodes-1; i++){
      curveVertex(nodeX[i], nodeY[i]);
    }
    endShape(CLOSE);
  }
  
  void moveShape() {
    //move center point
    float deltaX = shapeX-centerX;
    float deltaY = shapeY-centerY;
  
    // create springing effect
    deltaX *= springing;
    deltaY *= springing;
    accelX += deltaX;
    accelY += deltaY;
  
    // move predator's center
    centerX += accelX;
    centerY += accelY;
  
    // slow down springing
    accelX *= damping;
    accelY *= damping;
  
    // change curve tightness
    organicConstant = 1-((abs(accelX)+abs(accelY))*.1);
  
    //move nodes
    for (int i=0; i<nodes; i++){
      nodeX[i] = nodeStartX[i]+sin(radians(angle[i]))*(accelX*2);
      nodeY[i] = nodeStartY[i]+sin(radians(angle[i]))*(accelY*2);
      angle[i]+=frequency[i];
    }
  }
  
}
