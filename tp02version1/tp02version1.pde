import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;

Minim minim;
AudioPlayer sonidoFondo;
AudioSample sonidoRebote;

FWorld mundo;

Bandeja bandeja;
Pantalla pantalla0, pantalla2, pantalla3;
Contador cont;

ArregloBasuras arregloBasuras;
ArregloBasurasTacho arregloBasurasTacho;

//Estados: 0=pantalla inicial, 1=juego, 2=pantalla perder, 3=pantalla ganar 
int estado=0; 

PFont fuente;
PImage tachoDeBasura;
PImage camion;
PImage fondo; //Fondo
Boolean hayBasura=false;

void setup() {
  size(1000, 600);
  Fisica.init(this);

  //Sonidos
  minim = new Minim( this );
  sonidoFondo = minim.loadFile("musica-fondo.mp3", 2048);  
  sonidoRebote = minim.loadSample( "rebote.mp3", 512);  
  sonidoFondo.loop();

  //Parametros: Texto boton, titulo pantalla, ancho boton,nombre archivo fondo, x e y de boton
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

  mundo = new FWorld();
  mundo.setEdges();
  mundo.setGravity(0, 400);

  bandeja=new Bandeja(); //Instancia de Bandeja
  mundo.add(bandeja.getBandeja());
}

void draw() {
  switch(estado) {
  case 0://Pantalla inicial
    pantalla0.mostrarPantalla();
    break;
  case 1://Juego
    image(fondo, 0, 0);
    image(camion, -10, 150, 190, 484);

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

    for (int i=0; i<=3; i++) {
      if (arregloBasurasTacho.getBasura(i).getEnTacho()) {
        arregloBasurasTacho.getBasura(i).dibujarBasuraTacho();
      }
    }

    if (cont.perder()) {
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
    break;
  case 3://Pantalla ganar
    pantalla3.mostrarPantalla();
    break;
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

void contactStarted(FContact contacto)  //Comienzo contacto 
{
  FBody body1 = contacto.getBody1();
  FBody body2 = contacto.getBody2();

  if (body1 != null && body2 != null)
  {
    if (body1.getName() != null && body2.getName() != null)
    {
      if (body1.getName()=="bandeja") {
        sonidoRebote.trigger();
      }
    }
  }
}
