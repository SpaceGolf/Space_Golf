// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

//number of ships
Mover[] movers = new Mover[1];

Attractor a;
Attractor b;
//Attractor c;
int blue = 0;
boolean reverse = false;

void setup() {
  size(1300, 800);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(2, 10, height/4);
  }
  a = new Attractor(width/2, height/2, 80);
  b = new Attractor((int)random(width), (int)random(height), 50);
  //c = new Attractor((int)random(width), (int)random(height), 60);
  }

void draw() 
{
  background(0,0,230);
  colorChange();
  a.display();
  a.drag();
  a.hover(mouseX, mouseY);
  b.display();
  b.drag();
  b.hover(mouseX, mouseY);
  /*c.display();
  c.drag();
  c.hover(mouseX, mouseY);*/

    //a planet attracting code
    for (int i = 0; i < movers.length; i++) 
    {
      //testing 
      println("A: " + PVector.sub(movers[i].location,a.location).mag());
      println("A: " + (PVector.sub(movers[i].location,a.location).mag() <= (100 * ((a.mass * .1) / 2))));
      
      // Checks how close an attractor is to the mover. The radius the attractor effect has is determined by the attractor mass
      if(PVector.sub(movers[i].location,a.location).mag() <= (100 * ((a.mass * .1) / 2)))
      {
        PVector force = a.attract(movers[i]);
        //checks the velocity of the ship and limits the velocity to the exit velocity
        float gg = a.G;
        movers[i].newv = movers[i].velocity.mag();
        float limit = sqrt((float)(2*gg*a.mass)/PVector.sub(movers[i].location,a.location).mag());
        println("limit: " + limit);
        movers[i].newv = constrain(movers[i].newv,-1 * limit, limit);
        //applies the force
        movers[i].applyForce(force);
        println("Acceleration A: " + movers[0].acceleration);
      }
        movers[i].update();
        movers[i].wrapEdges();
        movers[i].display();
      
    }
    // effect size debug
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    tint(255, 127);
    ellipse(a.location.x,a.location.y,(100 * ((a.mass * .1) / 2)),(100 * ((a.mass * .1) / 2)));

  /*//b planet attracting code
  for (int i = 0; i < movers.length; i++) 
  {
    println("B: " + PVector.sub(movers[i].location,b.location).mag());
    println("B: " + (PVector.sub(movers[i].location,b.location).mag() <= (100 * ((b.mass * .1) / 2))));
    
    // Checks how close an attractor is to the mover. The radius the attractor effect has is determined by the attractor mass
    if(PVector.sub(movers[i].location,b.location).mag() <= (100 * ((b.mass * .1) / 2)))
    {
      PVector force = b.attract(movers[i]);
      movers[i].applyForce(force);
      println("Acceleration B: " + movers[0].acceleration);
    }
      movers[i].update();
      movers[i].wrapEdges();
      movers[i].display();
    
  }
  
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    tint(255, 127);
    ellipse(b.location.x,b.location.y,(100 * ((b.mass * .1) / 2)),(100 * ((b.mass * .1) / 2)));
  
  //c planet attracting code
  for (int i = 0; i < movers.length; i++) 
  {
    println("C: " + PVector.sub(movers[i].location,c.location).mag());
    println("C: " + (PVector.sub(movers[i].location,c.location).mag() <= (100 * ((c.mass * .1) / 2))));
    
    // Checks how close an attractor is to the mover. The radius the attractor effect has is determined by the attractor mass
    if(PVector.sub(movers[i].location,c.location).mag() <= (100 * ((c.mass * .1) / 2)))
    {
      PVector force = c.attract(movers[i]);
      movers[i].applyForce(force);
      println("Acceleration C: " + movers[0].acceleration);
    }
      movers[i].update();
      movers[i].display();
    
    println("Velocity: " + movers[0].velocity);
  }*/
  
}

void mousePressed() {
  a.clicked(mouseX, mouseY);
  //b.clicked(mouseX, mouseY);
  /*c.clicked(mouseX, mouseY);*/
}

void mouseReleased() {
  a.stopDragging();
  //b.stopDragging();
  /*c.stopDragging();*/
}
 //ignore this it has nothing to do with the game
void colorChange()
{
  if(blue > 255)
  {
    reverse = true; 
  }
  else if(blue <= 0 )
  {
     reverse = false;  
  }
  if(reverse)
  {
      blue--;
  }
  else if(!reverse)
  {
    blue++;
  }
}










