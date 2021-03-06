public abstract class Carro {

  PImage img; 
  float x, y; 

  public boolean colidiu(float x1, float y1) {
    if (x >= x1 - 30 && x + img.width <= x1 + 70 && y >= y1 - 30 && y <= y1 + 50  ) {
      return true;
    } else {
      return false;
    }
  }

  public void desenhar() {
    img.resize(30, 0);
    image(img, x, y);
  }

  abstract void acelerar();

  public void tratarBordas() {
    if (y < -600) {
      y = random(100, 550);
    }
  }
}