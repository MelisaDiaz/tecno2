import fisica.*;

FWorld mundo;

FPoly bandeja;
float posXban;
float posYban;

Contador cont;

Basura basura;
PImage tachoDeBasura;
PImage fondo; //Fondo
Boolean hayBasura=false;

void setup() {
  size(800, 600);
  fondo = loadImage("fondo.jpg");  

  cont=new Contador(); //Instancia de Contador

  Fisica.init(this);
  basura = new Basura();
  tachoDeBasura = loadImage("tacho de reciclaje.png");

  mundo = new FWorld(-100, 0, width, height);
  mundo.setEdges(-100, 0, width, height);
  //mundo.setGravity(1.1, 0);

  bandeja = new FPoly();
  bandeja.vertex(width/4, height-100);
  bandeja.vertex(width/4+100, height-100+10);
  bandeja.vertex(width/4+100, height-50);
  bandeja.vertex(width/4, height-50);

  //posXban = width/4;
  //posYban = height-50;
  // bandeja.setPosition(posXban, posYban);
  bandeja.setStatic(true);
  bandeja.setRestitution(1.2); 
  //bandeja.attachImage(loadImage("bandeja.png"));

  mundo.add(bandeja);
}

void draw() {
  image(fondo, 0, 0);

  if (!hayBasura) { //Si no hay basura agrega una
    basura.dispararse(mundo);
    hayBasura=true;
  }

  cont.imprimirGanadas();//Imprime ganadas
  cont.imprimirPerdidas();//Imprime perdidas

  basura.borrarBasura();
  image(tachoDeBasura, width-180, height-200, 200, 200);

  mundo.step();
  mundo.draw();
}


void keyPressed() {
  if (keyCode==LEFT) {  
    posXban-=5;
    bandeja.setPosition(posXban, posYban); //Mover a la izquierda
    //bandeja.addImpulse(-500, 0);
  } else if (keyCode==RIGHT) { 
    posXban+=5;
    bandeja.setPosition(posXban, posYban);//Mover a la derecha
    //bandeja.addImpulse(500, 0);
  }
}
