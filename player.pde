final int ball_max=3;
final int sling_cnt_mx=15;
int ball_n=0;
float []ball_x=new float[ball_max];
float []ball_y=new float[ball_max];
float []ball_vx=new float[ball_max];
float []ball_vy=new float[ball_max];
float []cos_b=new float[ball_max];
float []sin_b=new float[ball_max];
float handX_left,handY_left;
float handX_right,handY_right;
float handX,handY;
float velocity_max=0;
int inb_max=60;//無敵時間
int player_hp=3;
float[] hand_tmp=new float[4];
float[]boh=new float[4];//base of hand の略 手の付け根[leftx,lefty,rightx,righty]
int sling_cnt=0;
float a_before,a_after;
float eye_x=0,eye_y=0;
float cos_ri=0,sin_ri=0,cos_li=0,sin_li=0;
float player_g=255;
int cb_cnt=0;
boolean ready_for_shoot=false;
boolean player_is_free=true;
boolean sling_moving=false;
void player_place(){
  if(player_is_free){//マウスを動かせるとき
    float resist=5;
    sling_cnt=0;
    if(abs(energy)>=resist){
      float k=0.03;
      

      player_x=mouseX+(abs(energy)-resist)*cos_p*3;
      player_y=mouseY+(abs(energy)-resist)*sin_p*3;
      if(time%4<2){
        player_x+=abs(energy)*cos_vp*k;
        player_y+=abs(energy)*sin_vp*k;
      }else{
        player_x-=abs(energy)*cos_vp*k;
        player_y-=abs(energy)*sin_vp*k;
      }
     }else{
      player_x=mouseX;
      player_y=mouseY;
    }
  }
  if(player_x>=width-ellipse_round/2){
    player_x=width-ellipse_round/2;
  }
  if(player_y>=height-ellipse_round/2){
    player_y=height-ellipse_round/2;
  }
  if(player_x<=0+ellipse_round/2){
    player_x=0+ellipse_round/2;
  }
  if(player_y<=0+ellipse_round/2){
    player_y=0+ellipse_round/2;
  }
    if(dist(handX_left,handY_left,handX_right,handY_right)<=200||string_dist<200&&sling_cnt<sling_cnt_mx){
    handX_left=handX+hand_diff[0][2]/2;
    handX_right=handX-hand_diff[0][2]/2;
    handY_left=handY+hand_diff[1][2]/2;
    handY_right=handY-hand_diff[1][2]/2;
    float freq = map(mouseX, 0, width, 0, 15000);
  //wave.setFreq(freq);
    }
  if(mousePressed==false&&player_is_free||sling_cnt>=sling_cnt_mx){//マウスを押していない間
    handX=player_x;
    handY=player_y;
    handX_left=handX-ellipse_round/2;
    handX_right=handX+ellipse_round/2;
    handY_left=handY;
    handY_right=handY;

    cos_li=-1;sin_li=0;cos_ri=1;sin_ri=0;
    //print(cos_li,sin_li,cos_ri,sin_ri,"\n");
    ///////////////////////////////////////////////////////////////////////////////////
  }
  if(mousePressed){
    hand_tmp[0]=handX_left;
    hand_tmp[1]=handX_right;
    hand_tmp[2]= handY_left;
    hand_tmp[3]=handY_right;
  }
  if(!player_is_free){
    calculate_player_xy();
    player_x=diff_x+handX;
    player_y=diff_y+handY;
    if(sling_cnt<sling_cnt_mx){
      handX_left=hand_tmp[0];
      handX_right=hand_tmp[1];
      handY_left=hand_tmp[2];
      handY_right=hand_tmp[3];
    }else{
    
    }
    sling_cnt++;
  }
  if(sling_cnt>=sling_cnt_mx){
    cos_li=1;
      sin_li=0;
      cos_ri=-1;
      sin_ri=0;
      handX_left=handX-ellipse_round/2;
    handX_right=handX+ellipse_round/2;
    handY_left=handY;
    handY_right=handY;
    sling_moving=false;
  }
  
}
float shoot_x=0,shoot_y=0;
void define_shoot_place(){
  shoot_x=player_x;
  shoot_y=player_y;
}
void mousePressed(){
  pressed=true;
  sling_moving=true;
  sling_sound.loop();
}

void mouseReleased(){//マウスを離した瞬間
  sling_sound.pause();
  if(pressed){
    player_is_free=false;
    if(energy>=0){velocity_b=sqrt(abs(energy));}
    else{velocity_b=-sqrt(abs(energy));}
    
  }
  if(string_dist>100)
  {
    ready_for_shoot=true;
  }
  time=0;
  time_cnt=0;
  cos_b[ball_n]=cos_p;sin_b[ball_n]=sin_p;
}
void free_player(){//再びプレイヤーがマウス操作をすべてできるようにする
  if(sling_cnt>=sling_cnt_mx&&pressed){
    player_acceleration=0;
    velocity_p=0;
    player_is_free=true;
    
  }
}

void draw_player(){
  fill(0);
  inb_cnt++;
  if(inb_cnt>=inb_max){
    draw_hand();
    player_img(player_x,player_y,ellipse_round);
    
  }else if(inb_cnt%10<5){
    draw_hand();
    player_img(player_x,player_y,ellipse_round);
    
  }
}
void player_img(float x, float y, float r){
  float eye_xr=r/6;
  float eye_yr=r/4;
  float eye_r=r/10;
  colorMode(RGB);
  if(inb_cnt>=inb_max){
    if(!mousePressed){
      cal_eye(eye_xr,eye_yr,eye_r);
      player_g=255;
      fill(255,player_g,0);
      ellipse(x,y,r,r);    
      fill(255);
      ellipse(x-eye_xr,y-r/8,2*eye_xr,2*eye_yr);
      ellipse(x+eye_xr,y-r/8,2*eye_xr,2*eye_yr);
      fill(0);
      noStroke();
      ellipse(x+eye_x-eye_xr,y-r/8+eye_y,eye_r*2,eye_r*2);
      ellipse(x+eye_x+eye_xr,y-r/8+eye_y,eye_r*2,eye_r*2);
    }
    else{
      player_g=255-energy*3;
      fill(255,player_g,0);
      ellipse(x,y,r,r);    
      fill(0);
      stroke(0);
      strokeWeight(2);
      line(x-(3/2*eye_yr)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,y-(r/8-3/2*eye_xr)*cos_vp-(3/2*eye_yr)*sin_vp,x-(eye_xr/4)*cos_vp+(r/8)*sin_vp,y-(r/8)*cos_vp-(eye_xr/4)*sin_vp);
      line(x-(3/2*eye_yr)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,y-(r/8+3/2*eye_xr)*cos_vp-(3/2*eye_yr)*sin_vp,x-(eye_xr/4)*cos_vp+(r/8)*sin_vp,y-(r/8)*cos_vp-(eye_xr/4)*sin_vp);
      line(x+(3/2*eye_yr)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,y-(r/8-3/2*eye_xr)*cos_vp+(3/2*eye_yr)*sin_vp,x+(eye_xr/4)*cos_vp+(r/8)*sin_vp,y-(r/8)*cos_vp+(eye_xr/4)*sin_vp);
      line(x+(3/2*eye_yr)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,y-(r/8+3/2*eye_xr)*cos_vp+(3/2*eye_yr)*sin_vp,x+(eye_xr/4)*cos_vp+(r/8)*sin_vp,y-(r/8)*cos_vp+(eye_xr/4)*sin_vp);
      strokeWeight(1);
    }
  }else{
    if((!mousePressed)){
      player_g=200;
      fill(255,player_g,0);
      ellipse(x,y,r,r);    
      fill(255);
      stroke(0);
      strokeWeight(2);
      line(x-(3/2*eye_yr),y-(r/8-3/2*eye_xr),x-(r/16),y-(r/8+3/2*eye_xr));
      line(x-(3/2*eye_yr),y-(r/8+3/2*eye_xr),x-(r/16),y-(r/8-3/2*eye_xr));
      line(x+(3/2*eye_yr),y-(r/8-3/2*eye_xr),x+(r/16),y-(r/8+3/2*eye_xr));
      line(x+(3/2*eye_yr),y-(r/8+3/2*eye_xr),x+(r/16),y-(r/8-3/2*eye_xr));
      strokeWeight(1);
    }else {
      fill(255,255-energy*3,0);
      ellipse(x,y,r,r);    
      fill(0);
      stroke(0);
      strokeWeight(2);
      line(x-(3/2*eye_yr)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,y-(r/8-3/2*eye_xr)*cos_vp-(3/2*eye_yr)*sin_vp,x-(r/16)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,y-(r/8+3/2*eye_xr)*cos_vp-(r/16)*sin_vp);
      line(x-(3/2*eye_yr)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,y-(r/8+3/2*eye_xr)*cos_vp-(3/2*eye_yr)*sin_vp,x-(r/16)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,y-(r/8-3/2*eye_xr)*cos_vp-(r/16)*sin_vp);
      line(x+(3/2*eye_yr)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,y-(r/8-3/2*eye_xr)*cos_vp+(3/2*eye_yr)*sin_vp,x+(r/16)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,y-(r/8+3/2*eye_xr)*cos_vp+(r/16)*sin_vp);
      line(x+(3/2*eye_yr)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,y-(r/8+3/2*eye_xr)*cos_vp+(3/2*eye_yr)*sin_vp,x+(r/16)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,y-(r/8-3/2*eye_xr)*cos_vp+(r/16)*sin_vp);
      strokeWeight(1);
    
    }
  }
}
void cal_eye(float xr,float yr,float er){
  float ex=0,ey=0;
  if(scene[0]){
    ex=game_start.x;ey=game_start.y;
  }else  if(scene[1]){
    for(int i=0;i<3;i++){
      if(enemy1[i].hp>0){
        ex=enemy1[i].x;ey=enemy1[i].y;
      }
    }
  }else if(scene[2]){
    ex=enemy2.x;ey=enemy2.y;
  }
  float dist_e=dist(ex,ey,player_x,player_y);
  float cos=(ex-player_x)/dist_e;float sin=(ey-player_y)/dist_e;
  eye_x=(xr-er)*cos;
  eye_y=(xr-er)*sin;
}
void draw_hand(){
  //手を描く
 
  if((player_is_free&&mousePressed)){
    cos_li=cos_l;sin_li=sin_l;cos_ri=cos_r;sin_ri=sin_r;
  }
  float w=0.01;
  if(energy<100){
  w=10-sqrt(abs(energy));
}
    strokeWeight(w);
    stroke(255,player_g,0);
    line(boh[0],boh[1],handX_left,handY_left);
    stroke(255,player_g,0);
    line(boh[2],boh[3],handX_right,handY_right);
    strokeWeight(1);
    hand_img(handX_left,handY_left,sin_li,cos_li,ellipse_round/2);
    hand_img(handX_right,handY_right,sin_ri,cos_ri,ellipse_round/2); //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  
}
void hand_img(float x,float y,float s, float c,float r){
  
  float t=atan2(s,c);
  stroke(0);
  pushMatrix();
  translate(x,y);
  pushMatrix();
  rotate(t);
  fill(255,player_g,0);
  translate(-x,-y);
  noStroke();
  ellipse(x-r/6+r*3/6,y-r/4,r/2,r/3);
  ellipse(x-r/6+r*3/6,y+r/4,r/2,r/3);
  ellipse(x-r/8+r*3/6,y,r/2,r/3);
  ellipse(x-r/2+r/6+r*3/6,y,r/2,r*2/3);
  popMatrix();
  popMatrix();
}
void shoot(){
  a_after=abs(player_acceleration);
  //print(a_before,a_after,"\n");
  //print(velocity_x,"\n");
 if(a_after>a_before&&sling_cnt>1&&!mousePressed&&ready_for_shoot){
   ready_for_shoot=false;
   ball_x[ball_n]=player_x;
   ball_y[ball_n]=player_y;
   ball_vx[ball_n]=velocity_x/2;
   ball_vy[ball_n]=velocity_y/2;
   //print(velocity_x,velocity_y,"\n");
   ball_n++;
   define_shoot_place();
   if(ball_n>2){ball_n=0;}
 }
 a_before=abs(player_acceleration);
}
void move_ball(){
  for(int i=0;i<3;i++){
    ball_x[i]+=ball_vx[i];
    ball_y[i]+=ball_vy[i];
    
    
    fill(255,255,0);
    noStroke();
    ellipse(ball_x[i],ball_y[i],ellipse_round,ellipse_round);
    pushMatrix();
    translate(ball_x[i],ball_y[i]);
    pushMatrix();
    fill(255);
    float r=ellipse_round;
    float eye_xr=r/6;
    float eye_yr=r/4;
    float eye_r=r/10;
    //print(cnt,"\n");
    rotate(atan2(ball_vy[i],ball_vx[i])+PI/2+(float)cnt/5);
    /*
    ellipse(-eye_xr,-ellipse_round/2+eye_yr,2*eye_xr,2*eye_yr);
    ellipse(eye_xr,-ellipse_round/2+eye_yr,2*eye_xr,2*eye_yr);
    fill(0);
    ellipse(eye_xr,-ellipse_round/2+eye_yr-eye_yr+eye_r,eye_r*2,eye_r*2);
    ellipse(-eye_xr,-ellipse_round/2+eye_yr-eye_yr+eye_r,eye_r*2,eye_r*2);*/
    stroke(0);
    strokeWeight(2);
    line(-(3/2*eye_yr)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,-(r/8-3/2*eye_xr)*cos_vp-(3/2*eye_yr)*sin_vp,-(eye_xr/4)*cos_vp+(r/8)*sin_vp,-(r/8)*cos_vp-(eye_xr/4)*sin_vp);
    line(-(3/2*eye_yr)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,-(r/8+3/2*eye_xr)*cos_vp-(3/2*eye_yr)*sin_vp,-(eye_xr/4)*cos_vp+(r/8)*sin_vp,-(r/8)*cos_vp-(eye_xr/4)*sin_vp);
    line(+(3/2*eye_yr)*cos_vp+(r/8-3/2*eye_xr)*sin_vp,-(r/8-3/2*eye_xr)*cos_vp+(3/2*eye_yr)*sin_vp,+(eye_xr/4)*cos_vp+(r/8)*sin_vp,-(r/8)*cos_vp+(eye_xr/4)*sin_vp);
    line(+(3/2*eye_yr)*cos_vp+(r/8+3/2*eye_xr)*sin_vp,-(r/8+3/2*eye_xr)*cos_vp+(3/2*eye_yr)*sin_vp,+(eye_xr/4)*cos_vp+(r/8)*sin_vp,-(r/8)*cos_vp+(eye_xr/4)*sin_vp);
    strokeWeight(1);
    popMatrix();
    translate(-ball_x[i],-ball_y[i]);
    popMatrix();
  }

}

void hand_place(){
  
  if(sling_moving){
    boh[0]=player_x+ellipse_round/2*cos_vp;
    boh[1]=player_y+ellipse_round/2*sin_vp;
    boh[2]=player_x-ellipse_round/2*cos_vp;
    boh[3]=player_y-ellipse_round/2*sin_vp;
  }else{
    boh[0]=player_x+ellipse_round/2*1;
    boh[1]=player_y+ellipse_round/2*0;
    boh[2]=player_x-ellipse_round/2*1;
    boh[3]=player_y-ellipse_round/2*0;
  }
}
