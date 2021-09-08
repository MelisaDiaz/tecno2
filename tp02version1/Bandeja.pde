class Bandeja {

  //Atributos  
  float x;
  float y;
  FPoly bandeja;


  //Constructor
  Bandeja() {
    bandeja = new FPoly();
    bandeja.setName("bandeja");
    x=width/4;
    y=height+14;
    bandeja.vertex(x-50, y-80);
    bandeja.vertex(x+50, y-60);
    bandeja.vertex(x+50, y-20);
    bandeja.vertex(x-50, y-20);
    bandeja.setRestitution(0);
    bandeja.setFriction(6);
    bandeja.setRotatable (false);
    bandeja.setDamping (0.5);
    //mundo.add(bandeja);
    //bandeja.attachImage(loadImage("bandeja.png")); //Cargar imagen
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
}
