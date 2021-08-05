import fisica.*;

FWorld mundo;

FBox bandeja;
float posXban;
float posYban;

Basura basura;
PImage tachoDeBasura;

void setup() {
  size(800, 600);
  Fisica.init(this);
  basura = new Basura();
  tachoDeBasura = loadImage("tacho de reciclaje.png");

  mundo = new FWorld(-100, 0, width, height);
  mundo.setEdges(-100, 0, width, height);

  bandeja = new FBox(100, 50);
  posXban = width/2;
  posYban = height-50;
  bandeja.setPosition(posXban, posYban);
  bandeja.setStatic(true);
  bandeja.setRestitution(1.2); 
  mundo.add(bandeja);
}

void draw() {
  background(255);
  if (frameCount % 200 == 0) {
    basura.dispararse(mundo);
  }
  basura.borrarBasura();
  image(tachoDeBasura, width-180, height-200, 200, 200);

  mundo.step();
  mundo.draw();
}

//void keyPressed(){
// if(key == ' '){
//   basura.dispararse(mundo);
// }
//}

void keyPressed(){
    if (keyCode==LEFT) {  
      posXban-=5;
      bandeja.setPosition(posXban, posYban); //Mover a la izquierda
    } else if (keyCode==RIGHT) { 
      posXban+=5;
      bandeja.setPosition(posXban+10, posYban);//Mover a la derecha
    }
}
