class Basura {
  float x;
  float y;
  float angulo;
  float anguloVel;
  float diametroBasura;
  float velocidadBasura;
  FCircle basura;
 
  Basura(String nombre,float peso) {
    x = 70;
    y = height-380;
    angulo = radians(random (5, 55));
    anguloVel = 2;
    diametroBasura = 50;
    velocidadBasura = random (80, 150);
    basura = new FCircle (diametroBasura);
    basura.setDensity(peso);//Peso
    basura.setName(nombre);
    basura.attachImage(loadImage(nombre+".png")); //Cargar imagen
  }

  void dispararse(FWorld mundo) {
    basura.setPosition(x, y);
    basura.setRestitution(1.1);

    float velx = velocidadBasura * cos(angulo);
    float vely = velocidadBasura * sin(angulo);

    basura.setVelocity(velx, vely);
    mundo.add(basura);
  }
}
