class ArregloBasuras {

  //Atributos
  int cant=5;//Cantidad basuras
  Basura[] arregloBasuras; //Arreglo de objetos Basura

  //Constructor
  ArregloBasuras() {
    arregloBasuras= new Basura[cant];
    arregloBasuras[0]=new Basura("botella-agua");
    arregloBasuras[1]=new Basura("botella-cerveza");
    arregloBasuras[2]=new Basura("banana");
    arregloBasuras[3]=new Basura("diario");
    arregloBasuras[4]=new Basura("naranja");
  }
  
  //Funcionalidades
  Basura getBasura(int pos){//Devuelve basura de la posicion pos
    return arregloBasuras[pos];
  }
}
