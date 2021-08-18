import fisica.*;

FWorld mundo;

Bandeja bandeja;
Pantalla pantalla;
Contador cont;

ArregloBasuras arregloBasuras;
int estado=0; //Estados: 0=pantalla inicial, 1=juego
PFont fuente;
PImage tachoDeBasura;
PImage camion;
PImage fondo; //Fondo
Boolean hayBasura=false;

void setup() {
  size(800, 600);
  Fisica.init(this);
  
  pantalla=new Pantalla();

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
}

void draw() {
  switch(estado) {
  case 0://Pantalla inicial
      pantalla.mostrarPantalla();
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

    mundo.step();
    mundo.draw();
    break;
  }
}


void keyPressed() {
  bandeja.mover();
}


void mousePressed() {
   if (pantalla.getBoton().click()) {//Click en boton
        estado = 1;
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
