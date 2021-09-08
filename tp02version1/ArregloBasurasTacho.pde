class ArregloBasurasTacho {

  //Atributos
  int cant=4;//Cantidad basuras
  BasuraTacho[] arregloBasurasTacho; //Arreglo de objetos BasuraTacho

  //Constructor
  ArregloBasurasTacho() {
    arregloBasurasTacho= new BasuraTacho[cant];
    arregloBasurasTacho[0]=new BasuraTacho(width-150,height-249,"tacho-botella-agua.png");//Parámetros
    arregloBasurasTacho[1]=new BasuraTacho(width-70,height-251,"tacho-botella-cerveza.png");
    arregloBasurasTacho[2]=new BasuraTacho(width-120,height-242,"tacho-diario.png");
    arregloBasurasTacho[3]=new BasuraTacho(width-120,height-242,"tacho-lata.png");
  }
  
  //Funcionalidades
  BasuraTacho getBasura(int pos){//Devuelve basura de la posicion pos
    return arregloBasurasTacho[pos];
  }
    
  void reiniciarEnTacho() {
    for (int i=0; i<cant; i++) {
       getBasura(i).setEnTacho(false);
      }
    }
  
}
