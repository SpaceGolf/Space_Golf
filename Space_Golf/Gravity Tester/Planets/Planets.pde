// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

//number of ships
Mover movers;

Attractor[] attractors = new Attractor[10];
//Attractor c;
int moverspeed = 1; // max speed of mover
int blue = 0;
boolean reverse = false;

void setup() {
  size(1300, 800);
  movers = new Mover(1, 10, height/4);
  for(int i = 0; i < attractors.length; i++)
  {
    attractors[i] = new Attractor((int)random(width), (int)random(height), (int)random(50)+30); 
  }
  //a = new Attractor(width/2, height/2, 80);
  //b = new Attractor((int)random(width), (int)random(height), 50);
  //c = new Attractor((int)random(width), (int)random(height), 60);
  }

void draw() 
{
  background(100,0,230);
  colorChange();
  for(int i = 0; i < attractors.length; i++)
  {
    attractors[i].display();
    attractors[i].drag();
    attractors[i].hover(mouseX, mouseY);
  }
  /*b.display();
  b.drag();
  b.hover(mouseX, mouseY);*/
  /*c.display();
  c.drag();
  c.hover(mouseX, mouseY);*/

    //a planet attracting code

      //testing
      
      for(int i = 0; i < attractors.length; i++)
      {
        println("A: " + PVector.sub(movers.location,attractors[i].location).mag());
        println("A: " + (PVector.sub(movers.location,attractors[i].location).mag() <= (50 * ((attractors[i].mass * .1) / 2))));
        println("A: " + (50 * ((attractors[i].mass * .1) / 2)));  
        // Checks how close an attractor is to the mover. The radius the attractor effect has is determined by the attractor mass
          if(PVector.sub(movers.location,attractors[i].location).mag() <= (50 * ((attractors[i].mass * .1) / 2)))
          {
            
            //checks the velocity of the ship and limits the velocity to the exit velocity
            float gg = attractors[i].G;
            movers.newv = movers.velocity.mag();
            float limit = sqrt((float)(2*gg*attractors[i].mass)/PVector.sub(movers.location,attractors[i].location).mag()) * moverspeed;
            movers.newv = constrain(movers.newv,-1 * limit, limit);
            PVector force = attractors[i].attract(movers);
            //applies the force
            movers.applyForce(force);
            println("limit: " + limit);
            println("velocity: " + movers.velocity);
            println("Acceleration A: " + movers.acceleration);
          }
            movers.update();
            movers.wrapEdges();
            movers.display();
          
    
        // effect size debug
        ellipseMode(CENTER);
        strokeWeight(4);
        stroke(0);
        tint(255, 127);
        ellipse(attractors[i].location.x,attractors[i].location.y,((50 * ((attractors[i].mass * .1) / 2))*2),((50 * ((attractors[i].mass * .1) / 2)))*2);
      }

 /*//b planet attracting code
    println("B: " + PVector.sub(movers.location,b.location).mag());
    println("B: " + (PVector.sub(movers.location,b.location).mag() <= (50 * ((b.mass * .1) / 2))));
    
    // Checks how close an attractor is to the mover. The radius the attractor effect has is determined by the attractor mass
    if(PVector.sub(movers.location,b.location).mag() <= (50 * ((b.mass * .1) / 2)))
    {
      float gg = b.G;
       movers.newv = movers.velocity.mag();
       float limit = sqrt((float)(2*gg*b.mass)/PVector.sub(movers.location,b.location).mag()) * moverspeed;
       println("limit: " + limit);
       movers.newv = constrain(movers.newv,-1 * limit, limit);
      PVector force = b.attract(movers);
      //checks the velocity of the ship and limits the velocity to the exit velocity
        //applies the force
      movers.applyForce(force);
      println("Acceleration B: " + movers.acceleration);
    }
      movers.update();
      movers.wrapEdges();
      movers.display();
    

  
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    tint(255, 127);
    ellipse(b.location.x,b.location.y,((50 * ((b.mass * .1) / 2)) * 2),((50 * ((b.mass * .1) / 2)) * 2 ));
  
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
  for(int i = 0; i < attractors.length; i++)
  {
    attractors[i].clicked(mouseX, mouseY);
  }
  //b.clicked(mouseX, mouseY);
  /*c.clicked(mouseX, mouseY);*/
}

void mouseReleased() {
  for(int i = 0; i < attractors.length; i++)
  {
    attractors[i].stopDragging();
  }
  //a.stopDragging();
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










