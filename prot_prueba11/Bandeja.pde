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
    bandeja.vertex(x-50, y-80);
    bandeja.vertex(x+50, y-60);
    bandeja.vertex(x+50, y-20);
    bandeja.vertex(x-50, y-20);
    bandeja.setRestitution(0);
    bandeja.setFriction(6);
    bandeja.setRotatable (false);
    bandeja.setDamping (0.5);
    //mundo.add(bandeja);
   // bandeja.attachImage(loadImage("bandeja.png")); //Cargar imagen
    //bandeja.setPosition (width/4, height-200);
  }

  //Funcionalidades
  
    FPoly getBandeja() { //Devuelve bandeja
    return bandeja;
   }
  
  void mover() { //Mover bandeja
    if (keyCode==LEFT) {  
      //posXban-=5;
      //bandeja.setPosition(posXban, posYban); //Mover a la izquierda
      bandeja.addImpulse(-200, 0);
    } else if (keyCode==RIGHT) { 
      //posXban+=5;
      //bandeja.setPosition(posXban, posYban);//Mover a la derecha
      bandeja.addImpulse(200, 0);
    }
  }
}
