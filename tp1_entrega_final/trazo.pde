class Trazo {
  PImage manchas[];
  PImage mascara;
  int cant = 3; //cant de imágenes de manchas
  float tam;
  int limiteManchasGrandes = 130;
  int limiteManchasChicas = 150;
  int memoriaLimiteManchasGrandes = 130;
  int memoriaLimiteManchasChicas = 150;

  int timer = 60;
  int memoriaTimer = 60;

  Paleta paleta0, paleta1, paleta2; //declaro 3 paletas
  int cualPaleta = int( random(1, 4) ); // variable para que elija una de las tres paletas aleatoriamente

  Trazo() {
    paleta0 = new Paleta ("paleta00.png");
    paleta1 = new Paleta ("paleta01.png");
    paleta2 = new Paleta ("paleta02.png");

    manchas = new PImage [cant];

    for (int i = 0; i< cant; i++) {
      String nombreimg = "acuarela" + nf(i, 2) + ".png";
      mascara = loadImage( nombreimg );
      mascara.filter( INVERT );
      manchas[i] = createImage( 200, 200, RGB);
      manchas[i].filter( INVERT );
      manchas[i].mask( mascara );
    }
  }


  void dibujarManchasGrandes() {
    if (limiteManchasGrandes > 0 ) {
      int transp = 100;
      int limiteEnLaPantalla = 60; 
      tam = random(80, 120 );

      int cualMancha = int(random (0, 3) );
      float x = random(limiteEnLaPantalla, width-limiteEnLaPantalla);
      float y = random(limiteEnLaPantalla, height-limiteEnLaPantalla);
      float cx = width/2;
      float cy = height/2;
      float probabilidad = map(dist(x, y, cx, cy), 0, height/2.3, 100, 10);
      boolean dibujar = random(100)<probabilidad;

      if ( cualPaleta == 1) {
        tint(paleta0.darUnColor(), transp );
      } 
      if ( cualPaleta == 2) {
        tint(paleta1.darUnColor(), transp );
      } 
      if ( cualPaleta == 3) {
        tint(paleta2.darUnColor(), transp );
      }


      if ( dibujar ){
        image (manchas[cualMancha], x, y, tam, tam);
      }

      limiteManchasGrandes --;
    }
  }

  void dibujarManchasChicas() {
    if ( limiteManchasChicas > 0 ) {
      int transp = 230;
      int limiteEnLaPantalla = 80;
      tam = random(30, 75 );

      int cualMancha = int(random (0, 3) );
      float x = random(limiteEnLaPantalla, width-limiteEnLaPantalla);
      float y = random(limiteEnLaPantalla, height-limiteEnLaPantalla);

      if ( cualPaleta == 1) {
        tint(paleta0.darUnColor(), transp );
      } 
      if ( cualPaleta == 2) {
        tint(paleta1.darUnColor(), transp );
      } 
      if ( cualPaleta == 3) {
        tint(paleta2.darUnColor(), transp );
      }


      if ( x > 300 && y > 200 && x < 800 && y < 600) {
        image (manchas[cualMancha], x, y, tam, tam);
      }

      limiteManchasChicas --;
    }
  }


  void reset () {
    if (limiteManchasGrandes <= 0 && limiteManchasChicas <= 0 ) {
      timer --;
      if ( timer < 0 ) {
        background (#f1edee);
        limiteManchasGrandes = memoriaLimiteManchasGrandes;
        limiteManchasChicas = memoriaLimiteManchasChicas;
        timer = memoriaTimer;
      }
    }
  }
}
