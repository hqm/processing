import java.io.Serializable;
import processing.core.*;

class Face implements Serializable {
  Poly3 leftEye = new Poly3();
  Poly3 rightEye = new Poly3();
  Poly4 nose = new Poly4();
  Poly4 mouth = new Poly4();
  Poly4 face = new Poly4();

  String name = "";
  String filename = "none.jpg";
  String URL = "www.imdb.com";
  transient PImage image;

  public Face() {
  }
  public Face(String name, String filename) {
    this.name = name;
    this.filename = filename;

  }
}
