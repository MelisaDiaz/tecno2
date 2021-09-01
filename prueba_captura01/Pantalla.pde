class Pantalla {
  PImage img; //Fondo
  Boton boton; 
  String titulo;

  //Constructor
  Pantalla(String texto, String titulo,int ancho) {
    this.img=loadImage("fondo-pantalla.jpg");
    this.titulo=titulo;
    this.boton=new Boton(texto,ancho);
  }

  //Funcionalidades
  void mostrarPantalla() { 
    image(img, 0, 0, width, height);//Fondo con ancho y alto de pantalla 
    dibujarTitulo();
    boton.dibujar();
  }

  Boton getBoton() {//Devuelve boton 
    return this.boton;
  }
  
  void dibujarTitulo() { 
    pushStyle(); 
    fill(0);
    textSize(60);
    text(titulo, 100, 100);
    popStyle();
  }
  
}
