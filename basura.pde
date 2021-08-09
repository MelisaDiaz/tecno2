class Basura {
  float x;
  float y;
  float angulo;

  float anguloVel;
  float diametroBasura;
  float velocidadBasura;
  FCircle basura;

  Basura(String nombre) {
    x = 70;
    y = height-380;
    angulo = radians(random (5, 45));
    anguloVel = 2;
    diametroBasura = 50;
    velocidadBasura = random (100,250);
    basura = new FCircle (diametroBasura);
    basura.setName(nombre);
    basura.attachImage(loadImage(nombre+".png")); //Cargar imagen 
  }

  void dispararse(FWorld mundo) {
    basura.setPosition(x, y);
    //basura.setFriction(1.5);
    //basura.setDensity(50);
    basura.setRestitution(1.3);

    float velx = velocidadBasura * cos(angulo);
    float vely = velocidadBasura * sin(angulo);

    basura.setVelocity(velx, vely);
    mundo.add(basura);
  }
}
