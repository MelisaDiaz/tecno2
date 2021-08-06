import fisica.*;

FWorld mundo;

FPoly bandeja;
float posXban;
float posYban;

Contador cont;

ArregloBasuras arregloBasuras;
PImage tachoDeBasura;
PImage fondo; //Fondo
Boolean hayBasura=false;

void setup() {
  size(800, 600);
  fondo = loadImage("fondo.jpg");  

  cont=new Contador(); //Instancia de Contador

  Fisica.init(this);
  arregloBasuras = new ArregloBasuras();
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
  
  int pos=int(random(0,4.9));
  if (!hayBasura) { //Si no hay basura agrega una
    arregloBasuras.getBasura(pos).dispararse(mundo);
    hayBasura=true;
  }

  cont.imprimirGanadas();//Imprime ganadas
  cont.imprimirPerdidas();//Imprime perdidas

  borrarBasura();
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

void borrarBasura() {
  ArrayList <FBody> cuerpos = mundo.getBodies();

  for (FBody este : cuerpos) {
    String nombre = este.getName();
    if (nombre != null) {
      //if (nombre.equals("basura") ) {
      if (este.getX() > width-150 && este.getY() > height-200) { //Basuras ganadas
        cont.actualizarGanadas();
        mundo.remove(este);
        hayBasura=false;
      }
      if (este.getY() >= height-35) { //Basuras perdidas
        cont.actualizarPerdidas();
        mundo.remove(este);
        hayBasura=false;
      }
    }
  }
}
