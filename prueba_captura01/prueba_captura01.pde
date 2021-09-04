import netP5.*;
import oscP5.*;
import fisica.*;

OscP5 oscP5;
FWorld mundo;
FMouseJoint cadena;

Bandeja bandeja;
Pantalla pantalla0, pantalla2, pantalla3;
Contador cont;

ArregloBasuras arregloBasuras;

//Estados: 0=pantalla inicial, 1=juego, 2=pantalla perder, 3=pantalla ganar 
int estado=0; 

PFont fuente;
PImage tachoDeBasura;
PImage camion;
PImage fondo; //Fondo
Boolean hayBasura=false;

int found;
PVector poseOrientation = new PVector();
PVector cursorPosition = new PVector();

float speed = 30;


void setup() {
  size(800, 600);
  Fisica.init(this);

  //Parametros: Texto boton, titulo pantalla, ancho boton
  pantalla0=new Pantalla("Jugar", "El juego del reciclaje", 130); 
  pantalla2=new Pantalla("Volver a jugar", "Perdiste", 305);
  pantalla3=new Pantalla("Jugar otra vez", "Ganaste", 305);

  fuente = createFont("fuente.ttf", 25);
  textFont(fuente, 25);

  fondo = loadImage("fondo.jpg"); 
  camion = loadImage("camion1.png");
  tachoDeBasura = loadImage("tacho de reciclaje.png");

  cont=new Contador(); //Instancia de Contador
  arregloBasuras = new ArregloBasuras();

  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 400);

  bandeja=new Bandeja(); //Instancia de Bandeja
  mundo.add(bandeja.getBandeja());

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
}

void draw() {
  switch(estado) {
  case 0://Pantalla inicial
    pantalla0.mostrarPantalla();
    break;
  case 1://Juego
    image(fondo, 0, 0);
    image(camion, -10, 150, 190, 484);

    if (found > 0) {
      cursorPosition.x += speed * poseOrientation.y;
      cursorPosition.y += speed * poseOrientation.x;
      cursorPosition.x = constrain(cursorPosition.x, 0, width-100);
      cursorPosition.y = constrain(cursorPosition.y, 0, height-100);
      
      bandeja.dibujarBandeja(map(cursorPosition.x, 0, width, 0, width));
    }
    //cadena.setTarget(cursorPosition.x, cursorPosition.y);
    //println(cursorPosition.x);
    //bandeja.dibujarBandeja(map(cursorPosition.x, 0, width, 0, width));

    int pos=int(random(0, 5.9));
    if (!hayBasura) { //Si no hay basura agrega una
      if (frameCount%200==0) {
        arregloBasuras.getBasura(pos).dispararse(mundo);
        hayBasura=true; 
      }
    }

    cont.imprimirGanadas();//Imprime ganadas
    cont.imprimirVidas();//Imprime vidas

    borrarBasura();
    image(tachoDeBasura, width-180, height-200);

    if (cont.perder()) {
      estado=2;
    } else if (cont.ganar()) {
      estado=3;
    }
    mundo.step();
    mundo.draw();
    break;
  case 2://Pantalla perder
    pantalla2.mostrarPantalla();
    break;
  case 3://Pantalla ganar
    pantalla3.mostrarPantalla();
    break;
  }
}

public void found(int i) {
  found = i;
}

public void poseOrientation(float x, float y, float z) {
  poseOrientation.set(x, y, z);
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
  }
}


void keyPressed() {
  bandeja.mover();
}


void mousePressed() {
  if (estado==0) {
    if (pantalla0.getBoton().click()) {//Click en boton
      estado = 1;
    }
  }
  if (estado==2) {
    if (pantalla2.getBoton().click()) {//Click en boton
      estado = 1;
    }
  }
  if (estado==3) {
    if (pantalla3.getBoton().click()) {//Click en boton
      estado = 1;
    }
  }
}


void borrarBasura() {
  ArrayList <FBody> cuerpos = mundo.getBodies();

  for (FBody este : cuerpos) {
    String nombre = este.getName();
    if (nombre != null) {
      //si son cosas reciclables...
      if (nombre.equals("botella-agua") || nombre.equals("botella-cerveza") || nombre.equals("diario") || nombre.equals("lata") ) {

        if (este.getX() > width-150 && este.getY() > height-200) { //Si toca el tacho de basura...
          cont.actualizarGanadas(); //...suma un punto...
          mundo.remove(este); //...y se borra del mundo
          hayBasura=false;
        }
        if (este.getY() >= height-45 || este.getX() < 40) { //Si toca el piso...
          cont.actualizarVidas(); //...resta una vida...
          mundo.remove(este); //...y se borra del mundo
          hayBasura=false;
        }
      }

      //si son cosas no reciclables...
      if (nombre.equals("banana") || nombre.equals("naranja") ) {
        if (este.getY() >= height-45 || este.getX() < 40) { //Si toca el piso...
          mundo.remove(este); //...se borra del mundo
          hayBasura=false;
        }
        if (este.getX() > width-150 && este.getY() > height-200) { //Si toca el tacho de basura...
          cont.actualizarVidas(); //...resta una vida...
          mundo.remove(este); //...y se borra del mundo
          hayBasura=false;
        }
      }
    }
  }
}
