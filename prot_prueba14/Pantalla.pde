class Pantalla {
  PImage img; //Fondo
  Boton boton; 

  //Constructor
  Pantalla() {
    this.img=loadImage("fondo-pantalla.jpg");
    this.boton=new Boton();
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
