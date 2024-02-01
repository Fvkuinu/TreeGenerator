class Slider {
  String name;
  int min, max, value, l, posX, posY;
  float posV;
  color slclr, texclr;
  boolean isShowText = true;
  boolean isAvailable = true;
  Slider(String cname, int cposX, int cposY, int clengh, int cmin, int cmax, int cvalue, color cslclr, color ctexclr) {
    name = cname;
    min = cmin;
    max = cmax;
    l = clengh;
    value = cvalue;
    posX = cposX;
    posY = cposY;
    posV = map(value, min, max, posX, posX+l);
    slclr = cslclr;
    texclr = ctexclr;
  }

  void show() {


    rectMode(CENTER);
    textSize(30);
    textAlign(LEFT, CENTER);
    stroke(200, 200, 200);
    //strokeWeight(15);
    //line(posX, posY, l+posX, posY);
    fill(200, 200, 200);
    rectMode(CORNER);
    noStroke();
    rect(posX-1, posY-7.5, l, 15.15, 15);
    stroke(slclr);
    strokeWeight(10);
    //line(posX, posY, posV, posY);
    noStroke();
    fill(slclr);
    if (isAvailable) {
      rect(posX, posY-5, posV-posX, 10, 10);
    }
    strokeWeight(3);
    fill(160);
    stroke(slclr);

    //noStroke();
    if (isAvailable) {
      ellipse(posV, posY, 25, 25);
    }
    if (mouseX >= posX-25 && mouseX <= posX+l+25 && mouseY >= posY-20 && mouseY <= posY+20) {
      if (mousePressed) {
        posV = mouseX;
        posV = constrain(posV, posX, posX+l);
      }
    }
    fill(texclr);
    if (isShowText)text(name, posX, posY-45);
    fill(texclr);
    if (isShowText)text(value, posX+l+20, posY-5);
    value = (int)map(posV, posX, posX+l, min, max);
    //return value;
  }

  int getValue() {
    int value = (int)map(posV, posX, posX+l, min, max);
    return value;
  }
  void updateValue(float a) {
    //value = a;
    //posV = (int)map(value,min,max,posX,posX+l);
    posV = a;
    posV = constrain(posV, posX, posX+l);
  }
  void mousePressed() {
    println(21);
  }
}
