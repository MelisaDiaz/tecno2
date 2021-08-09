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
    bandeja.vertex(width/4-50, height-80);
    bandeja.vertex(width/4+100-50, height-80+20);
    bandeja.vertex(width/4+100-50, height-20);
    bandeja.vertex(width/4-50, height-20);
    bandeja.setRestitution(0);
    bandeja.setFriction(6);
    bandeja.setDamping (0.5);
    bandeja.setName("bandeja");
    //bandeja.attachImage(loadImage("bandeja.png")); //Cargar imagen
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
