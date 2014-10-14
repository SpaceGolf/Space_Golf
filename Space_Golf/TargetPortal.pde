//THE CLASS FOR THE TARGET THAT THE PLAYER IS GOING TOWARDS
class TargetPortal
{
  PVector position = new PVector(0, 0);
  int radius = 0;
  //The constructpor
  TargetPortal(PVector posit, int rad)
  {
    position = posit;
    radius = rad;
  }
  
  //The display to print out the target
  void display()
  {
    //Setting the color
    fill(175, 175, 175);
    //Drawing a circle (FOR NOW)
    ellipse(position.x, position.y, radius, radius);
  }
}
