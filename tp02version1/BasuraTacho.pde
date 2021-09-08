class BasuraTacho {
  float x;
  float y;
  PImage img; 
  Boolean enTacho;

  BasuraTacho(float x, float y, String nombre) {
    this.x = x;
    this.y = y;
    this.img=loadImage(nombre);
    enTacho=false;
  }

  void dibujarBasuraTacho() {
    image(img, x, y);
  }

  Boolean getEnTacho() {
    return this.enTacho;
  }

  void setEnTacho(Boolean enTacho) {
    this.enTacho=enTacho;
  }

}
