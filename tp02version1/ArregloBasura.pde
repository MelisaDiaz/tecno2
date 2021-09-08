class ArregloBasuras {

  //Atributos
  int cant=6;//Cantidad basuras
  Basura[] arregloBasuras; //Arreglo de objetos Basura

  //Constructor
  ArregloBasuras() {
    arregloBasuras= new Basura[cant];
    arregloBasuras[0]=new Basura("botella-agua",0.1);//Parámetros: nombre archivo, peso
    arregloBasuras[1]=new Basura("botella-cerveza",0.2);
    arregloBasuras[2]=new Basura("banana",0.8);
    arregloBasuras[3]=new Basura("diario",5);
    arregloBasuras[4]=new Basura("naranja",0.9);
    arregloBasuras[5]=new Basura("lata",0.3);
  }
  
  //Funcionalidades
  Basura getBasura(int pos){//Devuelve basura de la posicion pos
    return arregloBasuras[pos];
  }
}
