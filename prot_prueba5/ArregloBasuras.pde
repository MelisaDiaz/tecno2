class ArregloBasuras {

  //Atributos
  int cant=5;//Cantidad basuras
  Basura[] arregloBasuras; //Arreglo de objetos Basura

  //Constructor
  ArregloBasuras() {
    arregloBasuras= new Basura[cant];
    arregloBasuras[0]=new Basura("botella-agua",true);
    arregloBasuras[1]=new Basura("botella-cerveza",true);
    arregloBasuras[2]=new Basura("banana",false);
    arregloBasuras[3]=new Basura("diario",true);
    arregloBasuras[4]=new Basura("naranja",false);
  }
  
  //Funcionalidades
  Basura getBasura(int pos){//Devuelve basura de la posicion pos
    return arregloBasuras[pos];
  }
  
  Boolean esReciclable(int pos){//Devuelve si es reciclable la basura de la posicion pos
        return arregloBasuras[pos].reciclable;
  }
  
}
