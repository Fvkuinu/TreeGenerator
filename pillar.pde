void pillar(float length, float radius1, float radius2) {
  fill(255);
  //noFill();
  float x, y, z;
  pushMatrix();
  //上面の作成
  beginShape(TRIANGLE_FAN);
  texture(cutSurface);
  y = -0;
  vertex(0, y, 0,512/2,512/2);
  for (int deg = 0; deg <= 360; deg = deg + 10) {
    x = cos(radians(deg)) * radius1;
    z = sin(radians(deg)) * radius1;
    vertex(x, y, z,512/2+cos(radians(deg))*225,512/2+sin(radians(deg))*225);
  }
  endShape();              //底面の作成
  beginShape(TRIANGLE_FAN);
  texture(cutSurface);
  y = length ;
  vertex(0, y, 0,512/2,512/2);
  texture(cutSurface);
  for (int deg = 0; deg <= 360; deg = deg + 10) {
    x = cos(radians(deg)) * radius2;
    z = sin(radians(deg)) * radius2;
    vertex(x, y, z,512/2+cos(radians(deg))*225,512/2+sin(radians(deg))*225);
  }
  endShape();
  //側面の作成
  
  beginShape(TRIANGLE_STRIP);
  texture(miki);
  for (int deg =0; deg <= 360; deg = deg + 5) {
    x = cos(radians(deg)) * radius1;
    y = 0;
    z = sin(radians(deg)) * radius1;
    vertex(x, y, z,map(deg,0,360,0,1024),0);
    x = cos(radians(deg)) * radius2;
    y = length ;
    z = sin(radians(deg)) * radius2;
    vertex(x, y, z,map(deg,0,360,0,1024),1024);
  }
  endShape();
  popMatrix();
}
