class Contador {

  //Atributos
  int ganadas, perdidas; 

  //Constructor
  Contador() {
    perdidas = 0; //Inicializa perdidas en 0
    ganadas = 0; //Inicializa puntaje en 0
  }

  //Funcionalidades
  void reiniciarGanadas() {//Reinciar puntaje a 0
    ganadas=0;
  }

  void reiniciarPerdidas() {//Reinciar perdidas a 0
    perdidas=0;
  }

  Boolean ganar() {//Si puntaje=10 devuelve true
    if (ganadas==10) {
      return true;
    }
    return false;
  }

  Boolean perder() {//Si perdidas=10 devuelve true
    if (perdidas==10) {
      return true;
    }
    return false;
  }

  void actualizarPerdidas() { //Suma 1 a perdidas
    perdidas++;
  }

  void actualizarGanadas() { //Suma 1 a ganadas
    ganadas++;
  }

  void imprimirGanadas() { //Imprimir ganadas
    pushStyle();  
    fill(254, 255, 0, 120);
    textSize(20);
    textAlign(LEFT);
    text("Juntaste "+ ganadas, 30, 30);
    popStyle();
  }

  void imprimirPerdidas() { //Imprimir perdidas
    pushStyle();  
    fill(254, 255, 0, 120);
    textSize(20);
    textAlign(RIGHT);
    text("Perdiste "+ perdidas, width-30, 30);
    popStyle();
  }
}
