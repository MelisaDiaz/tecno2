import oscP5.*;
OscP5 osc;
float amp = 0.0;
float pitch = 0.0;
float factorAmort = 0.9;

GestorSenial gestorAmplitud;
float minAmp = 45;
float maxAmp = 100;

GestorSenial gestorPitch;
//para hacer graves y agudos con la voz
float minPitch = 59;
float maxPitch = 69;

//para silbido
//float minPitch = 90;
//float maxPitch = 97;


Trazo manchas;

void setup() {
  size(800, 800);
  imageMode(CENTER);
  background( #f1edee );

  osc = new OscP5(this, 12345);
  manchas = new Trazo();

  gestorAmplitud = new GestorSenial( minAmp, maxAmp, factorAmort);
  gestorPitch = new GestorSenial( minPitch, maxPitch, factorAmort);
}

void draw() {
  gestorAmplitud.actualizar( amp );
  gestorPitch.actualizar( pitch );
  println( pitch );
  manchas.reset();

  if (frameCount%1.5==0) {
    if ( amp > 40 ) {
      if ( pitch <= minPitch ) { //si el sonido es grave
        manchas.dibujarManchasGrandes(); // se dibujan manchas grandes
      }
      if ( pitch >= minPitch  ) { //si el sonido es agudo
        manchas.dibujarManchasChicas(); // se dibujan manchas chicas
      }
    }
  }
}



void oscEvent( OscMessage m) {

  if (m.addrPattern().equals("/amp")) {
    amp = m.get(0).floatValue();
    //println("amp: " + amp);
  }

  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
    //println("pitch: " + pitch);
  }
}
