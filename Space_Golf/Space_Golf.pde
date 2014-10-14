//THE MAIN CLASS
//Creating an instance of the player class
SpaceShip player;
TargetPortal portal;
//Creating an array list for the planets to be stored in
ArrayList <Planets> planets = new ArrayList<Planets>();

//The int for the player's score and the timer that decriments the score
int scoreCounter = 60;
int boostPenalty = 50;
int score = 1000;

//The timer to be used for the player respawn
int respawnCounter = 60;

//The setup method. initializes all of the main classes stuff
void setup()
{
  //Setting the size of the screen
    size(1500, 800, P2D);
    
    //Creating the player instance and placing it in the actual position (CHANGE LATER)
    player = new SpaceShip(new PVector(100, height/2));
    portal = new TargetPortal(new PVector(1400, 100), 75);
    
    //Hardcoded planet positions and mass of the planets
    planets.add(new Planets(new PVector(150, 150), 10));
    planets.add(new Planets(new PVector(250, 650), 15));
    planets.add(new Planets(new PVector(400, 200), 11));
    planets.add(new Planets(new PVector(450, 400), 8));
    planets.add(new Planets(new PVector(650, 225), 7.5));
    planets.add(new Planets(new PVector(650, 650), 8));
    planets.add(new Planets(new PVector(700, 75), 7));
    planets.add(new Planets(new PVector(975, 400), 17));
    planets.add(new Planets(new PVector(1050, 50), 10));
    planets.add(new Planets(new PVector(1200, 750), 13));
    planets.add(new Planets(new PVector(1350, 550), 10));
    planets.add(new Planets(new PVector(1300, 275), 12));
}

//methods looking for key presses to send information on rotation back to the SpaceShip class
void keyReleased()
{
  //checking for key presses.
 if(key == CODED)
 {
   if(keyCode == RIGHT)
   {
     //sets RIGHT boolean in SpaceShip
     player.right = false;
   }
   else if(keyCode == LEFT)
   {
     //sets LEFT boolean in SpaceShip
     player.left = false;
   }
   else if(keyCode == UP)
   {
     //sets LEFT boolean in SpaceShip
     player.boost = false;
   }
 }
}

void keyPressed()
{
 if(keyCode == RIGHT)
  {
    player.right = true;
  } 
  else if(keyCode == LEFT)
  { 
    player.left = true; 
  }
  else if(keyCode == UP)
   {
     //sets LEFT boolean in SpaceShip
     player.boost = true;
     //Each press of the boost, the score decriments
     score -= boostPenalty;
   }
}

//The update method
void draw()
{
  //Setting the color of the background to black
  background(0);
  
  //Calling the display for all of the planets
  for(Planets planBodies: planets)
  {
    planBodies.display();
    
    //display of the gravity field.
    ellipseMode(CENTER);
    fill(97, 240, 250, 126);
    ellipse(planBodies.planetCenter.x, planBodies.planetCenter.y, planBodies.gravField, planBodies.gravField);
  }
  
  //Draw the portal
  portal.display();
  
  //The game only plays if the player hasn't won (the win bool is false)
  if(player.gameWon == false)
  {
    //The score timer (counter) drops to 0 after 60 1/60ths of a second (the score drops after one second)
    if(scoreCounter > 0)
    {
      scoreCounter--;
    }
    //The score decriments if the counter drops to 0 and counter resets
    else
    {
      scoreCounter = 60;
      score--;
    }
    //Writing out the player's score and placing it in the top right score
    fill(255);
    textSize(25);
    text("Score: " + score, width - 200,  40);

    text("BoostCooldown: " + player.boostCooldown, 50, 40);
    
    //If the player is dead (.alive == false)
    if(player.alive == false)
    {
      //just like the score counter, when the respawn counter drops to 0 after 1 second 
      if(respawnCounter == 0)
      {
        respawnCounter = 60;
        player.restart();
        score = 1000;
      }
      else
      {
        respawnCounter--;
      }  
    }  
    //The rest of the in game draw function (until game over) executes while the player is alive
    else
    {     
      //For each planet, calculate the force of gravity to be applied to the player
      for(int i = 0; i < planets.size(); i++)
      {
        if(planets.get(i).InsideGravField(player)) //only applies the force if the player is inside the gravitational field
        {
          PVector force = planets.get(i).attract(player);     //Setting up the force of gravity
          player.applyForce(force);    //applying the resulting force
          
          if(player.planetCollision(planets.get(i)))
          {
            player.alive = false;
          }
        }
      }
      
      //If the score drops to 0, the player dies
      if(score <= 0)
      {
        player.alive = false;
      } 
      
      //must update with new information from the SpaceShip class
      player.movementUpdate();
      //Calling the player's target collision method
      player.targetCollision(portal);
      player.display();
    }
  }
  else
  {
    //Calling the game won screen
    background(255);
    
    //Printing out the text and placing it in the screen
    fill(0);
    textSize(100);
    text("LEVEL COMPLETED", width/2 - 400, height/2);
    textSize(75);
    text("Your Final Score is: " + score, width/2 - 350, height/2 + 125);
  }
}
