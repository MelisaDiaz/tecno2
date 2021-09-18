class Bandeja {

  //Atributos  
  float x;
  float y;
  FPoly bandeja;


  //Constructor
  Bandeja() {
    bandeja = new FPoly();
    x= width/4;
    y=height;
    bandeja.setPosition(x,y);
    bandeja.vertex(-50, -80);
    bandeja.vertex(-45, -79);
    bandeja.vertex(-40, -78);
    bandeja.vertex(-35, -77);
    bandeja.vertex(-30, -76);
    bandeja.vertex(-25, -75);
    bandeja.vertex(-20, -74);
    bandeja.vertex(-15, -73);
    bandeja.vertex(-10, -72);
    bandeja.vertex(-5, -71);
    bandeja.vertex(0, -70);
    bandeja.vertex(5, -69);
    bandeja.vertex(10, -68);
    bandeja.vertex(15, -67);
    bandeja.vertex(20, -66);
    bandeja.vertex(25, -65);
    bandeja.vertex(30, -64);
    bandeja.vertex(35, -63);
    bandeja.vertex(40, -62);
    bandeja.vertex(45, -61);
    bandeja.vertex(50, -60);
    bandeja.vertex(50, -20);
    bandeja.vertex(0, -20);
    bandeja.vertex(-50, -20);
    bandeja.setRestitution(0);
    bandeja.setFriction(6);
    bandeja.setRotatable (false);
    bandeja.setDamping (0.5);
    //bandeja.attachImage(loadImage("trampolin2.png")); //Cargar imagen
  
  }

  //Funcionalidades
  void dibujarBandeja(float posx) {
    bandeja.setPosition(posx, y);
    //bandeja.vertex(-50, -80);
    //bandeja.vertex(50, -60);
    //bandeja.vertex(50, -20);
    //bandeja.vertex(-50, -20);
    //bandeja.setRestitution(0);
    //bandeja.setFriction(6);
    //bandeja.setRotatable (false);
    //bandeja.setDamping (0.5);
    //bandeja.attachImage(loadImage("trampolin2.png")); //Cargar imagen
  }

 FPoly getBandeja() { //Devuelve bandeja
    return bandeja;
  }

  void mover() { //Mover bandeja
    if (keyCode==LEFT) { //Mover a la izquierda
      bandeja.setVelocity(-150, bandeja.getVelocityY() );
    } else if (keyCode==RIGHT) { //Mover a la derecha
      bandeja.setVelocity(150, 0);
    }
  }

  void reiniciarPosBandeja() {    
    x=width/4;
    y=height;
  }
}
