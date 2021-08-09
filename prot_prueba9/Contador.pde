class Contador {

  //Atributos
  int ganadas, vidas; 

  //Constructor
  Contador() {
    vidas = 10; //Inicializa perdidas en 0
    ganadas = 0; //Inicializa puntaje en 0
  }

  //Funcionalidades
  void reiniciarGanadas() {//Reinciar puntaje a 0
    this.ganadas=0;
  }

  void reiniciarPerdidas() {//Reinciar perdidas a 0
    this.vidas=10;
  }

  Boolean ganar() {//Si puntaje=10 devuelve true
    if (ganadas==10) {
      return true;
    }
    return false;
  }

  Boolean perder() {//Si perdidas=10 devuelve true
    if (vidas==0) {
      return true;
    }
    return false;
  }

  void actualizarVidas() { //Suma 1 a perdidas
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

  void imprimirVidas() { //Imprimir perdidas
    pushStyle();  
    fill(0);
    textSize(20);
    textAlign(RIGHT);
    text("Vidas: "+ vidas, width-30, 40);
    popStyle();
  }
}
