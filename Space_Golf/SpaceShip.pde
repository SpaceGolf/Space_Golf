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
  PVector acceleration = new PVector(0,0);
  
  boolean alive;
  float speed = 0;
  float topSpeed= 6.2;
  
  //Booleans: checking for KEYRELEASED to rotate the body left and right
  boolean right = false;
  boolean left = false;
  boolean boost = false;
  
  //The constructor
  SpaceShip(PVector startPosit)
  {
    alive=true;
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
    
    //Adding to the resulting speed to the acceleration provided from the planets gravity
    resulting.add(acceleration);
    
    
    //The current velocity vector is equals to the calculated resulting vector.
    velocity = resulting;
    acceleration.mult(0);    // set the acceleration to zero for the next update
    
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
  
  void restart()
  {
    center.x = width/2;
    center.y = height/2;
    PVector.fromAngle(radians(-90), direction);
    PVector.fromAngle(radians(-90), boostVector);
    velocity.mult(0);
    alive=true;
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
    
    if(center.x > 1500)
    {
      center.x = 1500;
    }
    
    if(center.y > 800)
    {
      center.y = 800;
    }
     
  }
  
  boolean planetCollision(Planets planet)
  {
    if(PVector.sub(center,planet.planetCenter).mag() <= planet.radius /2)
    {
      return true;
    }
    else
    {
      return false;
    }
    
    
  }
  
  void applyForce (PVector force){
    //PVector applied = PVector.div(force,10);
    acceleration.add(force);
  }
  
}
