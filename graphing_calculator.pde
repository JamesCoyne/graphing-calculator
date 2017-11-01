void setup(){
  size(400,400);
  strokeWeight(3);
  pixelDensity(displayDensity());
}

class function{
  
  function(){
  
  }
  
  public float g(float x){
    return 0;
  }
}

float func1(float x){
  return (pow(x,4) - 3*pow(x,3) + 2);
  //return pow(x,2);
  //return sin(x/10)*5;
}

float df(float x){
  return (4*pow(x,3) - 9*pow(x,2));
}

void plotGraph(float xoff, float yoff, float xscl, float yscl){
  //translate(0, (height/2)+yoff);
  //xoff /= xscl;
  yoff /= yscl;
  
  float x = 0;
  PVector lastPoint1 = new PVector(0,(func1(x-xoff)/yscl) + yoff);
    PVector lastPoint2 = new PVector(0,(df(x-xoff)/yscl) + yoff);
    
    for(float cx = 0; cx < width; cx++){
    stroke(255,0,0);
    line(cx, (func1(x-xoff)/yscl) + yoff,lastPoint1.x,lastPoint1.y);
    lastPoint1 = new PVector(cx, (func1(x-xoff)/yscl) + yoff);
    
    stroke(0,255,0);
    line(cx, (df(x-xoff)/yscl) + yoff,lastPoint2.x,lastPoint2.y);
    lastPoint2 = new PVector(cx, (df(x-xoff)/yscl) + yoff);
    
    x+= xscl;
  }
     stroke(200);
     line(0,yoff,width,yoff);
     fill(0);
     for(int i = 0; i < width; i+= (width/10)){
       text(i,i,yoff);
     }
     line(xoff/xscl,-height,xoff/xscl,height);
}
float scl = 1;
float x = 200;
float y = 200;
float speed = 5;

float cur_x = 6; // The algorithm starts at x=6
float prev_x = 0;
float gamma = 0.01; // step size multiplier
float precision = 0.00001;
float previous_step_size = cur_x;

void draw(){
  if(previous_step_size > precision){
    prev_x = cur_x;
    cur_x += -gamma * df(prev_x);
    previous_step_size = abs(cur_x - prev_x);
  }
  else{
  println("The local minimum occurs at" + cur_x);
  }
  float xscl = 0.05;
  background(255);
  plotGraph(x,y, xscl, scl);
}

void keyPressed(){
  switch(keyCode){
    case '-': 
    {
     scl--;
    }
    break;
    case '=': scl++;
    break;
    case UP: y+= speed;
    break;
    case DOWN: y-= speed;
    break;
      case LEFT: x+= speed;
    break;
    case RIGHT: x-= speed;
    break;
  }
}