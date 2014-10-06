//THE CLASS FOR THE PLANET OBJECTS THAT EXERT FORCE/GRAVITY
class Planets
{
  //The center PVector for position reference
  PVector planetCenter = new PVector(0, 0);
  //The radius for the planet
  float radius = 0;
  
  //The constructor that takes the position and radius
  Planets(PVector posit, float planRad)
  {
    //Setting the PVectors to equal one another and the floats to do the same
    planetCenter.x = posit.x;
    planetCenter.y = posit.y;
    radius = planRad;
  }
  
  //The display, same as the others
  void display()
  {
    fill(140, 75, 10);  
    ellipse(planetCenter.x, planetCenter.y, radius, radius);
  }
}
