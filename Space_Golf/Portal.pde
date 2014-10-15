//THE CLASS FOR THE TARGET THAT THE PLAYER IS GOING TOWARDS
class Portal
{
  PVector position;
  int radius;
  
  Target target;
   
  //The constructpor
  Portal(PVector posit, int rad)
  {
    position = posit;
    radius = rad;
    target = new Target(this);
    
  }
    
  boolean isPortalVisible()
  {
    if(position.x >= 0 && position.x <= width && position.y >= 0 && position.y <= height)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  //The display to print out the target
  void display()
  {
    //Setting the color
    fill(175, 175, 175);
    //Drawing a circle (FOR NOW)
    ellipse(position.x, position.y, radius, radius);
    
    target.display();
       
  }
  
  
}
