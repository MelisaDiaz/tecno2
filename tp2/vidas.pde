
class Vida {

  float posX, posY, tam, cant;
  PImage[] corazon = new PImage[3];

  Vida() {
    posY = 30;
    posX = 10;
    tam = 80;
    cant = 3;
    

    corazon[0] = loadImage("corazon.png");
    corazon[1] = loadImage("corazon.png");
    corazon[2] = loadImage("corazon.png");
  }

  void dibujarVidas() {
    pushStyle();
    imageMode(CORNER);
    for (int i = 0; i < cant; i++) {  
      image(corazon[i], posX+i*85, posY, tam, tam);
    }
    
    popStyle();
  }
  
  void reiniciarVidas(){
    cant = 3;
  }
}
