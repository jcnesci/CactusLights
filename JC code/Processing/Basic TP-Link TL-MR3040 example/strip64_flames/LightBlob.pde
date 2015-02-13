public class LightBlob 
{
  
  float x;
  float angle = 0;
  
  LightBlob( PApplet parent )
  {
    parent.registerDraw( this ); 
    noStroke();
    fill(255, 255, 255);
  }
  
  void draw()
  {
    setState( "idle" );
  }
  
  void setState( String iState )
  {
    if ( iState == "idle" ) {
      x = (sin(angle) * width/8) + width/2;
      ellipse(x, height/2, 100, 100);
      angle += 0.02;
    }
  }
  
}
