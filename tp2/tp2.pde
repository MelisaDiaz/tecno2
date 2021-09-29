import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import netP5.*;
import oscP5.*;
import fisica.*;

OscP5 oscP5;
FWorld mundo;
FMouseJoint cadena;

Minim minim;
AudioPlayer sonidoFondo;
AudioPlayer sonidoGanar;
AudioPlayer sonidoPerder;
AudioSample sonidoMal;
AudioSample sonidoPunto;
AudioSample sonidoRebote;

Bandeja bandeja;
Pantalla pantalla0, pantalla2, pantalla3;
Contador cont;

ArregloBasuras arregloBasuras;
ArregloBasurasTacho arregloBasurasTacho;
Vida vidas;

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
  size(1000, 600);
  Fisica.init(this);

  //Sonidos
  minim = new Minim( this );
  sonidoFondo = minim.loadFile("musica-fondo.mp3", 2048);  
  sonidoGanar = minim.loadFile("ganar.mp3", 2048);
  sonidoPerder = minim.loadFile("perder.mp3", 2048);
  sonidoMal = minim.loadSample("mal.mp3", 512);
  sonidoPunto = minim.loadSample("punto.mp3", 512);
  sonidoRebote = minim.loadSample( "boing.mp3", 512);

  //Parametros: Texto boton, titulo pantalla, ancho boton
  pantalla0=new Pantalla("Jugar", 130, "fondo1.png", width-200, height-130); 
  pantalla2=new Pantalla("Volver a jugar", 280, "fondo2.png", width-350, height-130);
  pantalla3=new Pantalla("Jugar otra vez", 285, "fondo3.png", width-350, height-130);

  fuente = createFont("fuente.ttf", 10);
  textFont(fuente, 10);

  fondo = loadImage("fondo.jpg"); 
  camion = loadImage("camion1.png");
  tachoDeBasura = loadImage("tacho de reciclaje.png");

  cont=new Contador(); //Instancia de Contador
  arregloBasuras = new ArregloBasuras();
  arregloBasurasTacho = new ArregloBasurasTacho();
  vidas = new Vida();

  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 800);

  bandeja=new Bandeja(); //Instancia de Bandeja
  mundo.add(bandeja.getBandeja());
  mundo.add(bandeja.a);

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
}

void draw() {
  //println (frameRate);
  switch(estado) {
  case 0://Pantalla inicial
    pantalla0.mostrarPantalla();
    break;
  case 1://Juego
    image(fondo, 0, 0);
    image(camion, -10, 150, 190, 484);

    if ( sonidoPerder.isPlaying() )
    {
      sonidoPerder.pause();
      sonidoPerder.rewind();
    }
    if ( sonidoGanar.isPlaying() )
    {
      sonidoGanar.pause();
      sonidoGanar.rewind();
    }
    if (!sonidoFondo.isPlaying()) {
      sonidoFondo.play();
    }

    if (found > 0) {
      cursorPosition.x += speed * poseOrientation.y;
      cursorPosition.y += speed * poseOrientation.x;
      cursorPosition.x = constrain(cursorPosition.x, 0, width-100);
      cursorPosition.y = constrain(cursorPosition.y, 0, height-100);

      bandeja.dibujarBandeja(map(cursorPosition.x, 0, width, 0, width), height-50);
    }
    //cadena.setTarget(cursorPosition.x, cursorPosition.y);
    //println(cursorPosition.x);
    //bandeja.dibujarBandeja(map(cursorPosition.x, 0, width, 0, width));

    int pos=int(random(0, 6.9));
    if (!hayBasura) { //Si no hay basura agrega una
      if (frameCount%200==0) {
        arregloBasuras.getBasura(pos).dispararse(mundo);
        hayBasura=true;
      }
    }

    cont.imprimirGanadas();//Imprime ganadas
    //cont.imprimirVidas();//Imprime vidas
    vidas.dibujarVidas();

    borrarBasura();
    image(tachoDeBasura, width-180, height-160);

    for (int i=0; i<=3; i++) {
      if (arregloBasurasTacho.getBasura(i).getEnTacho()) {
        arregloBasurasTacho.getBasura(i).dibujarBasuraTacho();
      }
    }

    if (vidas.cant == 0) {
      estado=2;
      arregloBasurasTacho.reiniciarEnTacho();
    } else if (cont.ganar()) {
      estado=3;
      arregloBasurasTacho.reiniciarEnTacho();
    }
    mundo.step();
    mundo.draw();
    break;
  case 2://Pantalla perder
    pantalla2.mostrarPantalla();
    cont.reiniciarGanadas();
    vidas.reiniciarVidas();

    sonidoFondo.pause();
    sonidoFondo.rewind();
    sonidoPerder.play();

    break;
  case 3://Pantalla ganar
    pantalla3.mostrarPantalla();
    vidas.reiniciarVidas();

    sonidoFondo.pause();
    sonidoFondo.rewind();
    sonidoGanar.play();

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
    if (pantalla2.getBoton().click()) {
      estado = 1;
    }
  }
  if (estado==3) {
    if (pantalla3.getBoton().click()) {
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
          sonidoPunto.trigger();
          mundo.remove(este); //...y se borra del mundo
          hayBasura=false;
          if (nombre.equals("botella-agua")) {
            arregloBasurasTacho.getBasura(0).setEnTacho(true);
          } else if (nombre.equals("botella-cerveza")) {
            arregloBasurasTacho.getBasura(1).setEnTacho(true);
          } else if (nombre.equals("diario")) {
            arregloBasurasTacho.getBasura(2).setEnTacho(true);
          } else if (nombre.equals("lata")) {
            arregloBasurasTacho.getBasura(3).setEnTacho(true);
          }
        }
        if (este.getY() >= height-45 || este.getX() < 40) { //Si toca el piso...
          vidas.cant--; //...resta una vida...
          sonidoMal.trigger();
          mundo.remove(este); //...y se borra del mundo
          hayBasura=false;
        }
      }

      //si son cosas no reciclables...
      if (nombre.equals("banana") || nombre.equals("naranja") || nombre.equals("manzana") ) {
        if (este.getY() >= height-45 || este.getX() < 40) { //Si toca el piso...
          mundo.remove(este); //...se borra del mundo
          hayBasura=false;
        }
        if (este.getX() > width-150 && este.getY() > height-200) { //Si toca el tacho de basura...
          vidas.cant--; //...resta una vida...
          sonidoMal.trigger();
          mundo.remove(este); //...y se borra del mundo
          hayBasura=false;
        }
      }
    }
  }
}

void contactStarted(FContact contacto)//Contacto
{
  FBody body1 = contacto.getBody1();
  FBody body2 = contacto.getBody2();

  if (body1 != null && body2 != null)
  {
    if (body1.getName() != null && body2.getName() != null)
    {
      if (body1.getName()=="bandeja" || body2.getName()=="bandeja") {
        sonidoRebote.trigger();//Sonido rebote de bandeja
      }
    }
  }
}
