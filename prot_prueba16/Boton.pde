class Boton {

  //Atributos
  
  float x, y, alto, ancho; //Posicion x y, altura y ancho
  float tam;//Tamaño texto boton
  String texto;

  //Constructor
  
  Boton(String texto,int ancho) {
    this.x=350;
    this.y=275;
    this.alto=70;
    this.ancho=ancho;
    this.tam=50;
    this.texto=texto;
  }

  //Funcionalidades
  
  void dibujar() { //Dibujar boton
  
    //Boton
    pushStyle();  
    fill(#FFFF33); //Color boton
    strokeWeight(2); //Ancho marco boton
    rect(x, y, ancho, alto, 10);
    
    //Texto boton 
    textSize(tam); //Tamaño texto
    fill(0); //Color texto
    text(texto, x+7, y+50); //Texto boton
    popStyle();
  }

  Boolean click() { //Verificar click boton
    if (mouseX>x && mouseX<x+ancho && mouseY>y && mouseY<y+alto) {
      return true;
    } else {
      return false;
    }
  }
}
