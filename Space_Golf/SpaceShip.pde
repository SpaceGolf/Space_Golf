//THE PLAYER CONTROLLED OBJECT THAT MOVES
class SpaceShip
{
  //The PShape that will form the body later
  PShape body;
  //The center to be used for positioning
  PVector center = new PVector(0, 0);
  
  PVector boostVector = new PVector(0, 0); 
  PVector direction = new PVector(0, 0); 
  PVector velocity = new PVector(0, 0);
  PVector resulting = new PVector(0,0); 
  
  float speed = 0;
  float topSpeed= 6;
  
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
    PVector.fromAngle(radians(-90), boostVector);
    
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
      speed=2;
    }
    else
    {
      if(speed > 0)
      {
        speed--;
      }
    }
    
    //Calculating the boost vector
    boostVector = PVector.mult(direction,speed);
    
    //Calculating the resulting vector, getting the previous velocity vector and adding to it the boost vector.
    resulting= PVector.add(boostVector, velocity);
    
    //The current velocity vector is equals to the calculated resulting vector.
    velocity = resulting;
    
    //Checking for the top speed
    if(velocity.mag() > topSpeed)
    {
      velocity.normalize();
      velocity = PVector.mult(velocity, topSpeed);
    }
 
    center.add(velocity);
    bordersCollisions();
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
  
  //Checking for collisions with the borders of the screen
  void bordersCollisions()
  {
    if(center.x < 0)
    {
      center.x = 0;
    }
    
    if(center.y < 0)
    {
      center.y = 0;
    }
    
    if(center.x > displayWidth)
    {
      center.x = displayWidth;
    }
    
    if(center.y > displayHeight)
    {
      center.y = displayHeight;
    }
    
    
  }
  
}
