class Target
{
  PVector position;
  TargetPortal portal;
  
  Target(TargetPortal port)
  {
    position = new PVector(0,0);
    portal = port;
  }
  
  void updateTarget()
  {
    if(portal.position.x > width - 50 && portal.position.y > height- 50)
    {
      position.x = width - 50;
      position.y = height - 50;
      return;
    }
    
    if(portal.position.x > width- 50 && portal.position.y < 50)
    {
       position.x = width - 50;
       position.y = 50;
       return;
    }
    
    if(portal.position.x < 50 && portal.position.y > height- 50)
    {
      position.x = 50;
      position.y = height - 50;
      return;
    }
    
    if(portal.position.x < 50 && portal.position.y < 50)
    {
      position.x = 50;
      position.y = 50;
      return;
      
    }
    
    if(portal.position.x > width- 50)
    {
      position.x = width - 50;     
      position.y = portal.position.y;       
      return;
    }
    
    if( portal.position.x < 50)
    {
      position.x = 50;        
      position.y = portal.position.y;      
      return;
    }
    
    if(portal.position.y > height- 50)
    {
      position.y = height - 50;      
      position.x = portal.position.x;        
      return;    
     
    }
    
    if(portal.position.y < 50)
    {
      position.y = 50;      
      position.x = portal.position.x;            
      return;
    }
  }
  
  void display()
  {
    if(portal.isPortalVisible() == false)
    {
      updateTarget();
      fill(255,0,0);
      triangle(position.x - 15, position.y ,position.x, position.y - 35 , position.x + 15, position.y);            
    }
  }
  
  
  
}
