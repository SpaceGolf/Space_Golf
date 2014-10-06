//THE PLAYER CONTROLLED OBJECT THAT MOVES
class SpaceShip
{
  //The PShape that will form the body later
  PShape body;
  //The center to be used for positioning
  PVector center = new PVector(0, 0);
  
  //Booleans: checking for KEYRELEASED to rotate the body left and right
  boolean right = false;
  boolean left = false;
  
  //The constructor
  SpaceShip(PVector startPosit)
  {
    center = startPosit;
  }
  
  //The method to control the player object
  void playerControls()
  {
  }
  
  //The method that draws the ship with vertecies
  void createShipBody()
  {
    //The color
    fill(255);
    //Creating and starting the shape 
    body = createShape();
    body.beginShape();
      //The vertex for the front
      body.vertex(center.x, center.y - 35);
      //The vertex for the left
      body.vertex(center.x - 15, center.y + 15);
      //The vertex for the right
      body.vertex(center.x + 15, center.y + 15);
    body.endShape(CLOSE);
  }
  
  void update()
  {
    //updates left and right booleans from KEYRELEASED events in "Space_Golf"
    if(right)
    {
     body.rotate(.1);
    }
    
    if(left)
    {
     body.rotate( -.1);
    }
  }
  
  //Display
  void display()
  {
    //Calling the createBody method, then drawing the created shape
    createShipBody();
    shape(body);
  }
}
