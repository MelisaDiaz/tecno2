class Pantalla {
  PImage img; //Fondo
  Boton boton; 
  String nombre;

  //Constructor
  Pantalla(String texto, int ancho, String nombre,float x,float y) {
    this.img=loadImage(nombre);
    this.boton=new Boton(texto,ancho,x,y);
  }

  //Funcionalidades
  void mostrarPantalla() { 
    image(img, 0, 0, width, height);//Fondo con ancho y alto de pantalla 
    boton.dibujar();
  }

  Boton getBoton() {//Devuelve boton 
    return this.boton;
  }
  
}
