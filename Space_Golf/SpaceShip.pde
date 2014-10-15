//THE PLAYER CONTROLLED OBJECT THAT MOVES
class SpaceShip
{
  //The PShape that will form the body later
  PShape body;
  //The center to be used for positioning
  PVector position = new PVector(0, 0);
  PVector spawnPoint = new PVector(100, height/2);
  
  PVector boostVector = new PVector(0, 0); 
  PVector direction = new PVector(0, 0); 
  PVector velocity = new PVector(0, 0);
  PVector resulting = new PVector(0,0); 
  PVector acceleration = new PVector(0,0);
  
  int leftCamBorder;
  int rightCamBorder;
  int upperCamBorder;
  int lowerCamBorder;
  
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
    position = startPosit;
    boostCooldown = 30;
    
    leftCamBorder = width / 3;
    rightCamBorder = 2* width/3;
    upperCamBorder = 2* height/3;
    lowerCamBorder = height/3;
    
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
    PVector.fromAngle(radians(0), direction);
    PVector.fromAngle(radians(0), boostVector);
    
  }
  
  void movementUpdate()
  {
    if(boostCooldown < 30)
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
    
    if(boost && boostCooldown == 30)
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
 
    position.add(velocity);
    
    cameraBox();
    bordersCollisions();
  }
  
  void restart()
  {
    position.x = 100;
    position.y = height/2;
    //position = spawnPoint;
    PVector.fromAngle(radians(-90), direction);
    PVector.fromAngle(radians(-90), boostVector);
    velocity.mult(0);
    alive=true;
    boostCooldown = 30;
  }
  
  //Checking for collisions with the borders of the screen
  void bordersCollisions()
  {
    if(position.x < 0)
    {
      position.x = 0;
    }
    
    if(position.y < 0)
    {
      position.y = 0;
    } 
    
    if(position.x > width)
    {
      position.x = width;
    }
    
    if(position.y > height)
    {
      position.y = height;
    }
     
  }
  
  boolean planetCollision(Planets planet)
  {
    if(PVector.sub(position,planet.position).mag() < planet.radius /2)
    {
      return true;
    }
    else
    {
      return false;
    }        
  }
  
  void cameraBox()
  {
    if(position.x > rightCamBorder)
    {
      position.x = rightCamBorder;
    }
    
    if(position.x < leftCamBorder)
    {
      position.x = leftCamBorder;
    }
    
    if(position.y < upperCamBorder)
    {
      position.y = upperCamBorder;
    }
    
    if(position.y > lowerCamBorder)
    {
      position.y = lowerCamBorder;
    }  
  }
  
  //The method for handling victory collision
  void targetCollision(TargetPortal endTarget)
  {
    //Getting the distance of the target to the player
    //If the they are too close, the game is won
    if(PVector.sub(position,endTarget.position).mag() < endTarget.radius)
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
    translate(position.x, position.y);
    rotate(direction.heading());
    shape(body);
    popMatrix();
  }
}
  
  
