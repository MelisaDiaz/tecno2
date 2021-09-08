class Boton {

  //Atributos
  
  float x, y, alto, ancho; //Posicion x y, altura y ancho
  float tam;//Tamaño texto boton
  String texto;

  //Constructor
  
  Boton(String texto,int ancho, float x, float y) {
    this.x=x;
    this.y=y;
    this.alto=70;
    this.ancho=ancho;
    this.tam=40;
    this.texto=texto;
  }

  //Funcionalidades
  
  void dibujar() { //Dibujar boton
  
    //Boton
    pushStyle();  
    fill(#FFC602); //Color boton
    stroke(0);
    strokeWeight(5); //Ancho marco boton
    rect(x, y, ancho, alto, 10);
    
    //Texto boton 
    textSize(tam); //Tamaño texto
    fill(0); //Color texto
    text(texto, x+20, y+50); //Texto boton
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
