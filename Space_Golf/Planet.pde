//THE CLASS FOR THE PLANET OBJECTS THAT EXERT FORCE/GRAVITY
class Planet
{
  
  PVector position = new PVector(0, 0);    //The center PVector for position reference  
  float radius = 0;    //The radius for the planet
  float mass;    //mass of the planet
  float constG;    //Gravitational constant
  float gravField;    //radius of the gravitational field
  
  //The constructor that takes the position and the mass of the planet
  Planet(PVector a_position, float a_mass)
  {
    //Setting the PVectors to equal one another and the floats to do the same
    position.x = a_position.x;
    position.y = a_position.y;
    radius = a_mass * 10;
    mass = a_mass;
    gravField =  40 * a_mass;
    constG = 8;
  }
  
  //This method is used for attractign the player to the planet
  PVector attract(SpaceShip player)
  {   
   PVector force = PVector.sub(position,player.position);
   float distance = force.mag(); //the distance between the planet and the player
   distance = constrain(distance,10.0,25.0); // constraining for big and short distances.
   force.normalize(); //normalizing the vector, so that we just use the direction of the vector for the calculation
   
   float gravForce = (constG * mass ) / (distance * distance); //calculating the force of gravity magnetitude for the planet
   
   force.mult(gravForce);
   
   return force;     
  }
                
  //Method for checking if the player is inside the gravitational field, if it is, return true
  boolean InsideGravField(SpaceShip player)
  {    
    if(PVector.sub(player.position,position).mag() <= gravField /2)
    {
      return true;
    }
    else
    {
      return false;
    }
        
  }
  
  //The display, same as the others
  void display()
  {
    fill(140, 75, 10);  
    ellipse(position.x, position.y, radius, radius);
  }
}






