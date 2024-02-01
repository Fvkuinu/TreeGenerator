
//L-systemを用いた木の作成で
//アニメーションを再生することができ
//自由に視点を変えられる


String command;
PImage miki;
PImage cutSurface;
PShape box;
float MOVE_SPEED = 5;
int repeat = 5; //再帰の回数
int seed = 512; //ランダムシード
int mitudo = 5; //葉の密度
float animation = 0; //再帰のアニメーションの位置
float fov = 60; //視野角
//HashMap<char,VariableUI> variableMap = new HashMap<char,VariableUI>();
void setup() {

  fullScreen(P3D);
  //size(500, 500, P3D);
  CameraControl c = new CameraControl(this);
  setupUI();

  smooth();
  //テクスチャ
  miki = loadImage("Bark012_1K-PNG_Color.png");
  cutSurface = loadImage("TreeEnd005.png");
  background(255);
  camera(0, 0, 100, -100, 0, -10, 0, -1, 0);
  //box(100, 100, 100);
  //translate(width/2, height);
  //rotate(PI);
  //strokeWeight(10);

  command = generateCommand("FFFA", repeat);
  //println(command);
}

void draw() {

  background(250);

  perspective(radians(fov), float(width)/float(height), 0.001, 10000);
  lights();
  ambientLight(100, 100, 100, 0, -1, 0);
  noStroke();
  //box = createShape(BOX, 100);

  //box.setTexture(miki); //テクスチャ
  //shape(box);
  //translate(200, 200, 200);
  //fill(255);
  //box(100, 100, 100);
  //pillar(frameCount, 50 , 50);   //円柱の作成(長さ,上面の半径,底面の半径)
  randomSeed(seed);

  drawTree(varList.getList().getOrDefault("START", ""), repeat, animation);


  //println(222);

  drawUI();
}



void drawTree(String command, int maxStep, float repeat) {
  int matrixCount = 0;
  //randomSeed(1);
  if (maxStep < 0) return;
  //int mitudo = 10;
  int happaStart = 3;
  float happaSize = 10;
  float unitLength = 5;
  float angleYawBase = radians(30);
  float angleRollBase = radians(45);
  float anglePitchBase = radians(34);


  if ((repeat)-1.0 > 0) {
    for (int i = 0; i < command.length(); i++) {
      char c = command.charAt(i);
      float rnd = random(-15, 15);
      if (isChecked) {
        rnd = 0;
      }
      float angleYaw = angleYawBase+radians(rnd);
      float angleRoll = angleRollBase+radians(rnd);
      float anglePitch = anglePitchBase+radians(rnd);
      switch(c) {
        //case 'A':
        //  //translate(0, unitLength);
        //  drawTree("\"[&FFFA]///[&FFFA]///[&FFFA]///[&FFFA]", maxStep-1, repeat-1);
        //  break;
      case 'F':
        //stroke(0);
        noStroke();
        //line(0, 0, 0, unitLength);
        noFill();
        pillar(unitLength, 1, 1);
        if (maxStep < happaStart)
          for (int j = 0; j< 20; j++) {
            float pos = map(j, 0, mitudo, 0, unitLength);
            pushMatrix();
            translate(0, pos);
            rotateY(random(0, 2*PI));
            rotateX(angleRollBase+radians(random(-5, 5)));
            //stroke(0,255,0);
            //line(0,0,0,0,10,0);
            fill(0, random(100, 255), 0, 200);
            if (j<mitudo) {
                ellipse(0, happaSize/2.0, 1, happaSize);
            }
            
            
            popMatrix();
          }
        translate(0, unitLength);
        break;
      case '+':
        rotateZ(-anglePitch);
        break;
      case '-':
        rotateZ(+anglePitch);
        break;
      case '&':
        rotateX(+angleRoll);
        break;
      case '^':
        rotateX(-angleRoll);
        break;
      case '/':
        rotateY(+angleYaw);
        break;
      case '\\':
        rotateY(-angleYaw);
        break;
      case '[':
        pushMatrix();
        matrixCount++;
        break;
      case ']':
        if (matrixCount > 0) {
          popMatrix();
          matrixCount--;
        }
        break;
      case '"':
        scale(0.7, 0.7, 0.7);
        break;

      default:
        String tmp = "";
        tmp += c;
        drawTree(varList.getList().getOrDefault(tmp, ""), maxStep-1, repeat-1);
        break;
      }
    }
  } else if ((repeat) > 0) {
    for (int i = 0; i < command.length(); i++) {
      char c = command.charAt(i);
      float rnd = random(-15, 15);
      if (isChecked) {
        rnd = 0;
      }
      float angleYaw = angleYawBase+radians(rnd);
      float angleRoll = angleRollBase+radians(rnd);
      float anglePitch = anglePitchBase+radians(rnd);
      switch(c) {
      case 'H':
        pushMatrix();
        stroke(0, 255, 0);
        rotateY(random(0, 2*PI));
        rotateX(+angleRoll);
        line(0, 0, 0, unitLength);
        popMatrix();
        break;
        //case 'A':
        //  //translate(0, unitLength);
        //  drawTree("\"[&FFFA]///[&FFFA]///[&FFFA]///[&FFFA]", maxStep-1, repeat-1);
        //  break;
      case 'F':
        //stroke(0);
        noStroke();
        //line(0, 0, 0, unitLength);
        noFill();
        pillar(unitLength*(repeat), 1, 1);
        if (maxStep < happaStart)
          for (int j = 0; j< 20; j++) {
            float pos = map(j, 0, mitudo, 0, unitLength);
            pushMatrix();
            translate(0, pos);
            rotateY(random(0, 2*PI));
            rotateX(angleRollBase+radians(random(-5, 5)));
            //stroke(0,255,0);
            //line(0,0,0,0,10,0);

            fill(0, random(150, 255), 0, 200);
            if (j<mitudo) {
              ellipse(0, happaSize/2.0*repeat, 1, happaSize*repeat);
            }
            popMatrix();
          }
        translate(0, unitLength*(repeat));
        break;
      case '+':
        rotateZ(-anglePitch);
        break;
      case '-':
        rotateZ(+anglePitch);
        break;
      case '&':
        rotateX(+angleRoll);
        break;
      case '^':
        rotateX(-angleRoll);
        break;
      case '/':
        rotateY(+angleYaw);
        break;
      case '\\':
        rotateY(-angleYaw);
        break;
      case '[':
        pushMatrix();
        matrixCount++;
        break;
      case ']':
        if (matrixCount > 0) {
          popMatrix();
          matrixCount--;
        }
        break;
      case '"':
        scale(0.7, 0.7, 0.7);
        break;

      default:
        String tmp = "";
        tmp += c;
        drawTree(varList.getList().getOrDefault(tmp, ""), maxStep-1, repeat-1);
        break;
      }
    }
  } else {
    for (int i = 0; i < command.length(); i++) {
      char c = command.charAt(i);
      float rnd = random(-15, 15);
      if (isChecked) {
        rnd = 0;
      }

      float angleYaw = angleYawBase+radians(rnd);
      float angleRoll = angleRollBase+radians(rnd);
      float anglePitch = anglePitchBase+radians(rnd);
      switch(c) {
        //case 'A':
        //  //translate(0, unitLength);
        //  drawTree("\"[&FFFA]///[&FFFA]///[&FFFA]///[&FFFA]", maxStep-1, repeat-1);
        //  break;
      case 'F':
        //stroke(0);
        noStroke();
        //line(0, 0, 0, unitLength);
        noFill();
        //pillar(unitLength*(repeat), 1, 1);
        if (maxStep < happaStart)
          for (int j = 0; j< 20; j++) {
            float pos = map(j, 0, mitudo, 0, unitLength);
            pushMatrix();
            translate(0, pos);
            rotateY(random(0, 2*PI));
            rotateX(angleRollBase+radians(random(-5, 5)));
            //stroke(0,255,0);
            //line(0,0,0,0,10,0);
            fill(0, random(100, 255), 0, 200);
            if(j<mitudo){
              //ellipse(0, happaSize/2, 1, happaSize);
            }
            
            popMatrix();
          }
        translate(0, unitLength*(repeat));
        break;
      case '+':
        rotateZ(-anglePitch);
        break;
      case '-':
        rotateZ(+anglePitch);
        break;
      case '&':
        rotateX(+angleRoll);
        break;
      case '^':
        rotateX(-angleRoll);
        break;
      case '/':
        rotateY(+angleYaw);
        break;
      case '\\':
        rotateY(-angleYaw);
        break;
      case '[':
        pushMatrix();
        matrixCount++;
        break;
      case ']':
        if (matrixCount > 0) {
          popMatrix();
          matrixCount--;
        }
        break;
      case '"':
        scale(0.7, 0.7, 0.7);
        break;

      default:
        String tmp = "";
        tmp += c;
        drawTree(varList.getList().getOrDefault(tmp, ""), maxStep-1, repeat-1);
        break;
      }
    }
  }
  for (int i = 0; i<matrixCount; i++) {
  }
}
String generateCommand(String command, int repeat) {
  for (int i=0; i<repeat; i++) {
    String com = "";
    for (int index = 0; index < command.length(); index++) {
      char c = command.charAt(index);
      //println(com,index);
      switch(c) {
      case 'F':
        com += "F";
        break;
      case 'A':
        //println(22);
        com += "\"[&FFFA]///[&FFFA]///[&FFFA]///[&FFFA]";
        break;
      case 'H':
        break;
      default:
        com += c;
        break;
      }
    }
    command = com;
  }

  return command;
}


void mousePressed() {
  varList.mousePressed();
  if ((mouseX > 30-30/2) && (mouseX < 30+30/2) && (mouseY > height-30-30/2) && (mouseY < height-30+30/2)) {
    if (isAnimation) {
      isAnimation = false;
    } else {
      isAnimation = true;
    }
  }
  // マウスクリックでチェック状態を切り替え
  float x = width-420, y = 145, w = 30, h = 30;
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    //println(111);
    isChecked = !isChecked;
    //println(isChecked);
  }
  //frameCount = -1;
  //redraw();
}
void keyTyped() {
  //println(keyCode);
  varList.keyTyped(keyCode);
}
void keyPressed() {
  varList.keyPressed(keyCode);
}
