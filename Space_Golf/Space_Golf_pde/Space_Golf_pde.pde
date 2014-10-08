//THE MAIN CLASS
//Creating an instance of the player class
SpaceShip player;
TargetPortal portal;
//Creating an array list for the planets to be stored in
ArrayList <Planets> planets = new ArrayList<Planets>();

//The setup method. initializes all of the main classes stuff
void setup()
{
  //Setting the size of the screen
    size(1500, 800, P2D);
    
    //Creating the player instance and placing it in the actual position (CHANGE LATER)
    player = new SpaceShip(new PVector(width/2, height/2));
    portal = new TargetPortal();
    
    //HArdcoded planet positions and size for the game
    planets.add(new Planets(new PVector(150, 150), 100));
    planets.add(new Planets(new PVector(250, 650), 150));
    planets.add(new Planets(new PVector(400, 400), 100));
    planets.add(new Planets(new PVector(600, 225), 75));
    planets.add(new Planets(new PVector(650, 650), 80));
    planets.add(new Planets(new PVector(975, 400), 250));
    planets.add(new Planets(new PVector(1350, 550), 100));
    
    //Randomized planets for testing purposes DELETE WHEN NO LONGER NEEDED
    /*for(int i = 0; i < 10; i++)
    {
      float sizeRand = random(100, 250);
      
      planets.add(new Planets(new PVector(random(100, 1400), random(100, 700)), sizeRand));
    }*/
}

//The update method
void draw()
{
  //Setting the color of the background to black
  background(0);
  
  pushMatrix();
  translate(player.center.x, player.center.y);
  
  
  //must update with new information from the SpaceShip class
   player.movementUpdate();
   
   popMatrix();
  
  //Calling the display for all of the planets
  for(Planets planBodies: planets)
  {
    planBodies.display();
  }
  
  //Calling the display for the player
  player.display(); 
  portal.display();
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
   }
}
