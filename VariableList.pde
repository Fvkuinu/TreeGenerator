class VariableList {
  HashMap<String, String> pseudoVariables;
  String currentKey = "";
  String currentValue = "";

  boolean isFocusedKey = false;
  boolean isFocusedValue = false;
  String editingKey = "";
  float x = 10;
  float y = 10;
  TextArea[] textArea = new TextArea[2];
  VariableList(float x, float y) {
    this.x = x;
    this.y = y;
    textArea[0] = new TextArea(x+50, y+50, 400, 30);
    textArea[1] = new TextArea(x+50, y+100, 400, 30);
    pseudoVariables = new HashMap<String, String>();
    pseudoVariables.put("A","\"[&FFFA]///[&FFFA]///[&FFFA]///[&FFFA]");
    pseudoVariables.put("START","FFFA");
  }
  void draw() {
    //background(255);
    strokeWeight(1);
    stroke(0);
    handleInputBoxes();
    displayVariables();
  }
  HashMap<String, String> getList(){
    return pseudoVariables;
  }
  void handleInputBoxes() {
    //fill(200);
    //rect(50, 50, 200, 30); // キー入力ボックス
    //rect(50, 100, 200, 30); // 値入力ボックス

    //fill(0);
    //text(keyInput, 55, 70);
    //text(valueInput, 55, 120);
    for (int i = 0; i<2; i++) {
      textArea[i].draw();
    }
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(100, 200, 100);
    rect(x+260+200, y+75, 80, 30); // 追加/更新ボタン
    fill(255);
    text(editingKey.isEmpty() ? "Add" : "Update", x+300+200, y+90);
  }

  void displayVariables() {
    fill(0);
    float y = 150+this.y;
    for (String keydayo : pseudoVariables.keySet()) {
      fill(0);
      textAlign(LEFT, CENTER);
      textSize(25);
      text(keydayo + ": " + pseudoVariables.get(keydayo), 50+x, y);
      fill(100, 100, 200);
      rect(300+x+200, y-10, 50, 20); // 編集ボタン
      fill(255);
      textSize(16);
      textAlign(CENTER, CENTER);
      text("Edit", 325+x+200, y);
      y += 30;
    }
  }

  void mousePressed() {
    for (int i = 0; i<2; i++) {
      textArea[i].mouseClicked();
    }
    //編集ボタン
    float y = 150+this.y;
    for (String keydayo : pseudoVariables.keySet()) {
      if (mouseX > x+300+200 && mouseX < x+350+200 && mouseY > y - 15 && mouseY < y + 5) {
        editingKey = keydayo;
        textArea[0].setText(keydayo);
        textArea[1].setText(pseudoVariables.get(keydayo));
        return;
      }
      y += 30;
    }

    if (mouseX > x+260+200 && mouseX < x+340+200 && mouseY > this.y+75 && mouseY < this.y+105) {
      if (!editingKey.isEmpty() && !textArea[0].currentText.equals(editingKey)) {
        pseudoVariables.remove(editingKey);
        editingKey = "";
      }
      pseudoVariables.put(textArea[0].currentText, textArea[1].currentText);
      textArea[0].setText("");
      textArea[1].setText("");
      editingKey = "";
    } else {
      isFocusedKey = false;
      isFocusedValue = false;
    }
  }

  void keyTyped(int keyCode) {
    //println(keyCode);
    
    //if (isFocusedKey) {
    //  keyInput += key;
    //} else if (isFocusedValue) {
    //  valueInput += key;
    //}
  }

  void keyPressed(int keyCode) {
    for (int i = 0; i<2; i++) {
      textArea[i].keyTyped(keyCode);
    }
    for (int i = 0; i<2; i++) {
      textArea[i].keyPressed(keyCode);
    }
    //if (isFocusedKey && key == BACKSPACE && keyInput.length() > 0) {
    //  keyInput = keyInput.substring(0, keyInput.length() - 1);
    //} else if (isFocusedValue && key == BACKSPACE && valueInput.length() > 0) {
    //  valueInput = valueInput.substring(0, valueInput.length() - 1);
    //}
  }
}
