import java.awt.*;
import java.awt.Robot.*;
public class CameraControl {
  PApplet parent;
  Robot bot;
  private int mouseSensitivity = 15;
  private float moveVelocity = 5;
  private HashMap<Integer, Boolean> keyMap = new HashMap<Integer, Boolean>();
  private int fov = 90;
  private float near = 1.0;
  private float far = 5000.0;
  private float thetaV = 180;
  private float thetaH = 0;
  private boolean cameraRotate = true;
  CameraControl(PApplet parent) {
    this(parent, 0.0, 0.0, 0.0);
  }
  CameraControl(PApplet parent, float x, float y, float z) {
    noCursor();
    //Robot使うための処理
    try {
      bot = new Robot();
      bot.mouseMove(50, 50);
    }
    catch (AWTException e) {
      e.printStackTrace();
    }
    this.parent = parent;
    parent.registerMethod("dispose", this);
    parent.registerMethod("pre", this);
    parent.registerMethod("post", this);
    parent.registerMethod("keyEvent", this);
  }

  public void dispose() {
    parent.unregisterMethod("dispose", this);
    parent.unregisterMethod("pre", this);
    parent.unregisterMethod("post", this);
    parent.unregisterMethod("keyEvent", this);
  }

  public void pre() {
    control();
  }

  public void control() {
    perspective(radians(fov), float(width)/float(height), near, far);

    PMatrix3D M = new PMatrix3D();

    if (cameraRotate) {
      cameraRotate(M);
    }

    cameraTranslate(M);

    PMatrix3D C = ((PGraphicsOpenGL)(this.parent.g)).camera.get(); // コピー
    C.preApply(M);
    // 上を向くように修正
    C.invert();
    float ex = C.m03;
    float ey = C.m13;
    float ez = C.m23;
    float cx = -C.m02 + ex;
    float cy = -C.m12 + ey;
    float cz = -C.m22 + ez;
    parent.camera( ex, ey, ez, cx, cy, cz, 0, -1, 0 );
  }

  public void cameraRotate(PMatrix M) {
    PointerInfo pi = MouseInfo.getPointerInfo();
    Point pt = pi.getLocation();
    float x = (float)pt.getX();    //  マウスカーソルのスクリーンX座標
    float y = (float)pt.getY();    //  マウスカーソルのスクリーンY座標
    float pThetaH = thetaH;
    float pThetaV = thetaV;
    bot.mouseMove(displayWidth/2, displayHeight/2);
    thetaH += mouseSensitivity/400.0*(x-displayWidth/2.0);
    thetaV -= mouseSensitivity/400.0*(y-displayHeight/2.0);
    thetaV = constrain(thetaV, 91, 269);
    M.rotateY(radians(thetaH-pThetaH));
    M.rotateX(radians(thetaV-pThetaV));
  }

  public void cameraTranslate(PMatrix M) {
    PVector v = new PVector(0, 0, 0);

    if (keyMap.getOrDefault(87, false)) { //'w'
      v.add(0, 0, 1);
      //M.translate(0,0,5);
    }
    if (keyMap.getOrDefault(65, false)) { //'a'
      v.add(1, 0, 0);
      // M.translate(5,0,0);
    }
    if (keyMap.getOrDefault(83, false)) { //'s'
      v.add(0, 0, -1);
      // M.translate(0,0,-5);
    }
    if (keyMap.getOrDefault(68, false)) { //'d'
      v.add(-1, 0, 0);
      //M.translate(-5,0,0);
    }
    if (keyMap.getOrDefault(32, false)) { //'space'
      M.translate(0, moveVelocity, 0);
    }
    if (keyMap.getOrDefault(16, false)) { //'ctrl'
      M.translate(0, -moveVelocity, 0);
    }
    v.setMag(moveVelocity);
    M.translate(v.x, v.y, v.z);
  }

  public void post() {
    ////noLights();
    //pushMatrix();
    //ortho();
    //resetMatrix();
    //translate(-width/2.0, -height/2.0);
    //hint(DISABLE_DEPTH_TEST);
    //fill(0);

    //hint(ENABLE_DEPTH_TEST);
    //popMatrix();
  }

  public void keyEvent(KeyEvent evt) {
    //println(evt.getAction());
    int keyEventAction = evt.getAction();
    switch(keyEventAction) {
    case KeyEvent.PRESS:
      keyPressed();
      break;
    case KeyEvent.RELEASE:
      keyReleased();
      break;
    case KeyEvent.TYPE:
      keyTyped();
      break;
    }
  }
  private void keyPressed() {
    if (cameraRotate) {
      keyMap.put(keyCode, true);
    }
    //println(keyCode);

    if (keyCode == 84) {//'h'
      if (cameraRotate) {
        cameraRotate = false;
        cursor();
      } else {
        cameraRotate = true;
        noCursor();
      }
    }
  }
  private void keyReleased() {
    keyMap.put(keyCode, false);
  }
  private void keyTyped() {
    //println(key);
  }
}
