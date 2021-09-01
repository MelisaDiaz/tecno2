class Bandeja {

  //Atributos  
  float x;
  float y;
  FPoly bandeja;


  //Constructor
  Bandeja() {
    bandeja = new FPoly();
    x=width/4;
    y=height;
    bandeja.setPosition(x, y);
    bandeja.vertex(-50, -80);
    bandeja.vertex(50, -60);
    bandeja.vertex(50, -20);
    bandeja.vertex(-50, -20);
    bandeja.setRestitution(0);
    bandeja.setFriction(6);
    bandeja.setRotatable (false);
    bandeja.setDamping (0.5);
    //mundo.add(bandeja);
    //bandeja.attachImage(loadImage("trampolin2.png")); //Cargar imagen
  }

  //Funcionalidades

  FPoly getBandeja() { //Devuelve bandeja
    return bandeja;
  }

  void mover() { //Mover bandeja
    if (keyCode==LEFT) { //Mover a la izquierda
      bandeja.setVelocity(-180, bandeja.getVelocityY() );
    } else if (keyCode==RIGHT) { //Mover a la derecha
      bandeja.setVelocity(180, 0);
    }
  }

  void reiniciarPosBandeja() {    
    x=width/4;
    y=height;
  }
}
