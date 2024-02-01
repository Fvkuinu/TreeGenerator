
int pt = 0;
//uiを作る
//ランダムにするかどうか
//seed(int,1-1024),repeat(int,0-6),mitudo(int,0-10),animation(再生ボタンと動画みたいなスライダーで実装）,文字変更
Slider repeatSlider;
Slider seedSlider;
Slider mitudoSlider;
Slider animationSlider;
VariableList varList;
color slclr = #ff3652;
color texclr = #000000;
boolean isAnimation = false; //アニメーションを再生するか
boolean isChecked = false; // チェックボックスの状態
void setupUI() {
  //(label,posx,posy,length,min,max,value,color1,color2)
  repeatSlider = new Slider("Repeat", width-500, 100, 400, 1, 6, 3, slclr, texclr);
  seedSlider = new Slider("Seed", width-500, 200, 400, 1, 1024, 512, slclr, texclr);
  mitudoSlider = new Slider("Density", width-500, 300, 400, 0, 20, 5, slclr, texclr);
  animationSlider = new Slider("Animation", 60, height-30, width-80, 0, 1000000, 1000000, slclr, texclr);
  animationSlider.isShowText = false;
  varList = new VariableList(width-550,300);
}

void drawUI() {
  noLights();
  pushMatrix();
  ortho();
  resetMatrix();
  translate(-width/2.0, -height/2.0);
  hint(DISABLE_DEPTH_TEST);
  
  fill(100, 100, 100);
  //rect(width-500,0,509,height);
  repeatSlider.show();
  drawCheckbox(width-420, 145, 30, 30);
  seedSlider.show();
  mitudoSlider.show();
  if (isAnimation) {
    //drawPlayButton(width / 3, height / 2, 80); // 再生ボタンを描画
    drawPauseButton(30, height-30, 30); // 一時停止ボタンを描画
  } else {
    drawPlayButton(30, height-30, 30); // 再生ボタンを描画
    //drawPauseButton(2 * width / 3, height / 2, 80); // 一時停止ボタンを描画
  }
  varList.draw();
  
  fill(0);
  textSize(16);
  textAlign(LEFT,TOP);
  text("FPS: "+frameRate,0,0);
  updateValue();
  //println(frameRate);
  
  
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}

//UIの値をもとに変数の値を更新
void updateValue() {
  repeat = repeatSlider.getValue();
  seed = seedSlider.getValue();
  mitudo = mitudoSlider.getValue();

  seedSlider.isAvailable = !isChecked;
  animationSlider.show();
  animation=map(animationSlider.getValue(), 0, 1000000.0, 0, repeat);
  //println(animation);
  if (isAnimation) {
    //animation += millis()/1000.0-pt/1000.0;
    animation += 0.02;
  }
  pt = millis();
  if (animation > repeat) animation = 0;
  //animation=map(animationSlider.getValue(),0,100,0,repeat);
  animationSlider.updateValue(map(animation,0,repeat,animationSlider.posX,animationSlider.posX+animationSlider.l));
}
//チェックボックスを描画
void drawCheckbox(float x, float y, float w, float h) {
  // 枠線の描画
  stroke(0);
  noFill();
  rect(x, y, w, h);

  // チェック状態の描画
  if (isChecked) {
    line(x, y, x + w, y + h);
    line(x, y + h, x + w, y);
  }
}
// 再生ボタンを描画する関数
void drawPlayButton(float x, float y, float size) {
  fill(0, 102, 153); // ボタンの色を設定
  noStroke(); // ボタンの外枠を非表示にする

  // 三角形を描画
  beginShape();
  vertex(x - size/2, y - size/2);
  vertex(x + size/2, y);
  vertex(x - size/2, y + size/2);
  endShape(CLOSE);
}

// 一時停止ボタンを描画する関数
void drawPauseButton(float x, float y, float size) {
  fill(255, 0, 0); // ボタンの色を設定
  noStroke(); // ボタンの外枠を非表示にする

  // 二つの長方形（一時停止記号）を描画
  rect(x - size/3, y - size/2, size/4, size);
  rect(x + size/12, y - size/2, size/4, size);
}
