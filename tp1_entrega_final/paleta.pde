class Paleta {
  PImage imgPaleta;

  Paleta(String nombrePaleta) {
    imgPaleta = loadImage(nombrePaleta);
  }

  color darUnColor() {
    int x = int( random( imgPaleta.width) );
    int y = int( random( imgPaleta.height) );
    return imgPaleta.get( x, y );
  }
}
