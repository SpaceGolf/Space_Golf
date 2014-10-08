//THE PLAYER CONTROLLED OBJECT THAT MOVES
class SpaceShip
{
  //The PShape that will form the body later
  PShape body;
  //The center to be used for positioning
  PVector center = new PVector(0, 0);
  
  PVector boostDirect = new PVector(0, 0); 
  PVector direction = new PVector(0, 0); 
  PVector velocity = new PVector(0, 0); 
  
  float speed = 0;
  
  //Booleans: checking for KEYRELEASED to rotate the body left and right
  boolean right = false;
  boolean left = false;
  boolean boost = false;
  
  //The constructor
  SpaceShip(PVector startPosit)
  {
    center = startPosit;
    
     fill(255);
    //Creating and starting the shape 
    body = createShape();
    body.beginShape();
      //The vertex for the front
      body.vertex(0, 0 - 35);
      //The vertex for the left
      body.vertex(0 - 15, 0 + 15);
      //The vertex for the right
      body.vertex(0 + 15, 0 + 15);
    body.endShape(CLOSE);
    
    body.rotate(radians(90));
    PVector.fromAngle(radians(-90), direction); 
    
  }
  
  void movementUpdate()
  {
    //updates left and right booleans from KEYRELEASED events in "Space_Golf"
    if(right)
    {
     direction.rotate(.1);
    }
    
    if(left)
    {
     direction.rotate( -.1);
    }
    
    if(boost)
    {
      if(speed < 20)
      {
        speed = speed + 2;
      }
    }
    else
    {
      if(speed > 1)
      {
        speed--;
      }
    }
    
    velocity = PVector.mult(direction, speed);   
    center.add(velocity);
  }
  
  //Display
  void display()
  {
    //Calling the createBody method, then drawing the created shape
    pushMatrix();
    translate(center.x, center.y);
    rotate(direction.heading());
    shape(body);
    popMatrix();
  }
}
