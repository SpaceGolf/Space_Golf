// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float newv; // this variable is where the limited velocity is stored

  Mover(float m, float x, float y) {
    mass = 3;
    location = new PVector(x, y);
    velocity = new PVector(5, 0);
    newv = velocity.mag();
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, 10);
    acceleration.add(f);
  }
   //makes mover(ship) wrap around to the other side when it reaches the edge
  void wrapEdges() {
    float buffer = mass*25;
    if (location.x > width +  buffer) location.x = -buffer;
    else if (location.x <    -buffer) location.x = width+buffer;
    if (location.y > height + buffer) location.y = -buffer;
    else if (location.y <    -buffer) location.y = height+buffer;
  }
  
  /*void doNotHit(Attractor a)
  {
     float separation = a.mass;
     PVector sum = new PVector();
     int count = 0;
     float d = Pvector.dist(location, a.location);
     if((d > 0) && (d < separation))
    {
       PVector diff = PVector.sub(location, other.location);
       diff.normalize();
       diff.div(d);
       sum.add(diff);
       count++;
    }
   
     if(count > 0)
    {
       sum.div(count);
       sum.normalize();
       sum.mult(2.5);
       PVector steer = PVector.sub(sum, velocity);
       steer.limit(2);
       applyForce(steer);
    } 
  }*/

  void update() {
    velocity.add(acceleration);
    //float newv = velocity.mag();
    //newv = constrain(newv, -6.5, 6.5);
    velocity.normalize();
    velocity.mult(newv);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0,100);
    ellipse(location.x, location.y, 1*25, 1*25);
  }
}

