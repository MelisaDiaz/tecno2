class Contador {

  //Atributos
  int ganadas, vidas; 

  //Constructor
  Contador() {
    vidas = 3; //Inicializa vidas en 10
    ganadas = 0; //Inicializa puntaje en 0
  }

  Boolean ganar() {//Si puntaje=10 devuelve true
    if (ganadas==3) {
      this.ganadas=0;
      this.vidas=3;
      return true;
    }
    return false;
  }

  Boolean perder() {//Si vidas=0 devuelve true
    if (vidas==0) {
      this.ganadas=0;
      this.vidas=3;
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
    fill(0); //Cuadro
    noStroke();
    rect(width-130, 20, 100, 40, 10);
    fill(#FFFF33); //Texto
    textSize(20);
    text("Puntos: "+ ganadas, width-120, 47);
    popStyle();
  }

  void imprimirVidas() { //Imprimir vidas
    pushStyle();  
    fill(0); //Cuadro
    noStroke();
    rect(width-130, 65, 100, 40, 10);
    fill(#FFFF33); //Texto
    textSize(20);
    text("Vidas x "+ vidas, width-120, 93 );
    popStyle();
  }
}
