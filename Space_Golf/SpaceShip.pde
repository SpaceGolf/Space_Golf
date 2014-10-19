//THE PLAYER CONTROLLED OBJECT THAT MOVES
class SpaceShip
{
  //The PShape that will form the body later
  PShape body;
  //The center to be used for positioning
  PVector center = new PVector(0, 0);
  PVector spawnPoint = new PVector(100, height/2);
  
  PVector boostVector = new PVector(0, 0); 
  PVector direction = new PVector(0, 0); 
  PVector velocity = new PVector(0, 0);
  PVector resulting = new PVector(0,0); 
  PVector acceleration = new PVector(0,0);
  
  boolean alive;
  boolean gameWon = false;
  float speed = 0;
  float topSpeed= 6.2;
  float boostCooldown;
  
  //Booleans: checking for KEYRELEASED to rotate the body left and right
  boolean right = false;
  boolean left = false;
  boolean boost = false;
  
  //The constructor
  SpaceShip(PVector startPosit)
  {
    alive=true;
    center = startPosit;
    boostCooldown = 20;
    
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
    if(boostCooldown < 20 && !boost)
    {
      boostCooldown++;
    }
    
    //updates left and right booleans from KEYRELEASED events in "Space_Golf"
    if(right)
    {
     direction.rotate(.1);
    }
    
    if(left)
    {
     direction.rotate( -.1);
    }
    
    if(boost && boostCooldown == 20)
    {
      speed=6;
      boostCooldown = 0;
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
  
  void restart()
  {
    center.x = 100;
    center.y = height/2;
    //center = spawnPoint;
    PVector.fromAngle(radians(-90), direction);
    PVector.fromAngle(radians(-90), boostVector);
    velocity.mult(0);
    boostCooldown = 20;
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
    
    if(center.x > width)
    {
      center.x = width;
    }
    
    if(center.y > height)
    {
      center.y = height;
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
  
  //The method for handling victory collision
  void targetCollision(TargetPortal endTarget)
  {
    //Getting the distance of the target to the player
    //If the they are too close, the game is won
    if((sqrt(sq(endTarget.position.x - center.x) + sq(endTarget.position.y - center.y))) <= endTarget.radius)
    {
      gameWon = true;
    }
    else
    {
      gameWon = false;
    }
  }
  
  void applyForce (PVector force)
  {
    //PVector applied = PVector.div(force,10);
    acceleration.add(force);
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
  
  
