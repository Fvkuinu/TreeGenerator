class TextArea {
  String currentText = ""; // 現在の行のテキスト
  int caretPosition = 0; // キャレットの位置
  boolean isFocused = false;
  int caretTimer = 0;
  float x, y, w, h;
  TextArea(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    fill(255);
    stroke(0);
    rect(x, y, w, h);

    fill(0);
    textSize(h-10);
    textAlign(LEFT, CENTER);
    text(currentText, x + 10, y + h / 2-5);
    handleCaret(y, h);
  }

  void handleCaret(float y, float h) {
    if (isFocused) {
      caretTimer++;
      if (caretTimer / 30 % 2 == 0) {
        
        float caretX = 60 + textWidth(currentText.substring(0, caretPosition));
        stroke(0);
        line(x+caretX-50, y+5, x+caretX-50, y+h-5);
        
      }
    }
  }
  void setText(String str){
    currentText = str;
    caretPosition = str.length();
  }
  void mouseClicked() {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      isFocused = true;
    } else {
      isFocused = false;
    }
  }

  void keyTyped(int keyCode) {
    //println(keyCode);
    if (isFocused) {
      if (keyCode == 8) {
        if (caretPosition > 0) {
          currentText = currentText.substring(0, caretPosition - 1) + currentText.substring(caretPosition);
          caretPosition--;
        }
      } else if (!(key == CODED)) {
        currentText = currentText.substring(0, caretPosition) + key + currentText.substring(caretPosition);
        caretPosition++;
      }
      if (keyCode == 37) {
        caretPosition = max(0, caretPosition - 1);
      } else if (keyCode == 39) {
        caretPosition = min(currentText.length(), caretPosition + 1);
      }
    }
  }

  void keyPressed(int keyCode) {
    if (isFocused) {
      if (keyCode == 37) {
        caretPosition = max(0, caretPosition - 1);
      } else if (keyCode == 39) {
        caretPosition = min(currentText.length(), caretPosition + 1);
      }
    }
  }
}
