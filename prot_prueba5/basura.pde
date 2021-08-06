class Basura {
  float x;
  float y;
  float angulo;

  float anguloVel;
  float diametroBasura;
  float velocidadBasura;


  Basura() {
    x = 15;
    y = height-450;
    angulo = radians(60);
    anguloVel = 2;
    diametroBasura = 50;
    velocidadBasura = 700;
  }

  void dispararse(FWorld mundo) {

    FCircle basura = new FCircle (diametroBasura);
    basura.setPosition(x, y);
    //basura.setFriction(1.5);
    basura.setDensity(100);
    basura.setRestitution(1);
    basura.setName("basura");

    float velx = velocidadBasura * cos(angulo);
    float vely = velocidadBasura * sin(angulo);

    basura.setVelocity(velx, vely);
    mundo.add(basura);
  }

  void borrarBasura() {
    ArrayList <FBody> cuerpos = mundo.getBodies();

    for (FBody este : cuerpos) {
      String nombre = este.getName();
      if (nombre != null) {
        if (nombre.equals("basura") ) {
          if (este.getX() > width-150 && este.getY() > height-200) { //Basuras ganadas
            cont.actualizarGanadas();
            mundo.remove(este);
            hayBasura=false;
          }
          if (este.getY() >= height-35) { //Basuras perdidas
            cont.actualizarPerdidas();
            mundo.remove(este);
            hayBasura=false;
          }
        }
      }
    }
  }
}
