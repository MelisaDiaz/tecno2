class Contador {

  //Atributos
  int ganadas, vidas; 

  //Constructor
  Contador() {
    vidas = 10; //Inicializa vidas en 10
    ganadas = 0; //Inicializa puntaje en 0
  }

  //Funcionalidades
  void reiniciarGanadas() {//Reinciar puntaje a 0
    this.ganadas=0;
  }

  void reiniciarVidas() {//Reinciar vidas
    this.vidas=10;
  }

  Boolean ganar() {//Si puntaje=10 devuelve true
    if (ganadas==10) {
      return true;
    }
    return false;
  }

  Boolean perder() {//Si vidas=0 devuelve true
    if (vidas==0) {
      return true;
    }
    return false;
  }

  void actualizarVidas() { //Resta 1 vida
    vidas--;
  }

  void actualizarGanadas() { //Suma 1 a ganadas
    ganadas++;
  }

  void imprimirGanadas() { //Imprimir ganadas
    pushStyle();  
    fill(0);
    textSize(20);
    textAlign(RIGHT);
    text("Puntos: "+ ganadas, width-30, 80);
    popStyle();
  }

  void imprimirVidas() { //Imprimir vidas
    pushStyle();  
    fill(0);
    textSize(20);
    textAlign(RIGHT);
    text("Vidas: "+ vidas, width-30, 40);
    popStyle();
  }
}
