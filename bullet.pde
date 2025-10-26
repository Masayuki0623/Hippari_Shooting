int bullet_number=0;
int knife_number=0;
int delete_knife;
boolean hit=false;
int inb_cnt=100;//無敵であるかどうか
float hit_place_x,hit_place_y,hit_demage;
final int bullet_max=800;
Bullet []bullet=new Bullet[bullet_max];
class Bullet{
  float x,y,vx,vy,r;
  boolean ex;
  Bullet(float xpos,float ypos,float verx,float very,float radius,boolean exist){
    x=xpos;
    y=ypos;
    vx=verx;
    vy=very;
    r=radius;
    ex=exist;
  }
}
void reset_bullet(){
  for(int i=0;i<bullet_max;i++){
    bullet[i].ex=false;
  }
}
void bullet(){
  for(int i=0;i<bullet_max;i++){
    noStroke();
    fill(255,0,0);
    if(scene[1]){
      colorMode(HSB,360,100,100);
      fill(104,70,50);
      colorMode(RGB,255,255,255);
    }
    if(scene[3]){
      fill(255,0,0);
    }
    if(bullet[i].ex){
      if(bullet_number>bullet_max-100){bullet_number=0;}//弾丸の要素数を超えると初期化する。
      bullet[i].x+=bullet[i].vx;
      bullet[i].y+=bullet[i].vy;
      if(scene[2]){
        if(i%2==0){
          fill(70,255,255);
        }else{
          fill(0,50,210);
        }
      }
      ellipse(bullet[i].x,bullet[i].y,bullet[i].r*2,bullet[i].r*2);
      if(dist(bullet[i].x,bullet[i].y,player_x,player_y)<=bullet[i].r+ellipse_round/2&&inb_cnt>inb_max){//被弾したとき
        bullet[i].ex=false;
        inb_cnt=0;
        player_hp--;
        if(player_hp>0){
          damage_sound.play();
          damage_sound.rewind();
        }
        else{
          death_sound.play();
          death_sound.rewind();
        }
        if(scene[1]){
          delete_knife=i-i%10;
          for(int j=0;j<10;j++){
            bullet[j+delete_knife].ex=false;
          }
        }
        if(scene[2]){
          if(t_number<=i&&t_number+6>i){
            for(int j=0;j<6;j++){
              bullet[t_number+j].ex=false;
            }
          }
        }
      }
      if(bullet[i].x<=-bullet[i].r&&bullet[i].x>=width+bullet[i].r&&bullet[i].y<=-bullet[i].r&&bullet[i].y>=height+bullet[i].r){
        bullet[i].ex=false;//球が枠外へ行くと消す
        bullet[i].vx=0;
        bullet[i].vy=0;
        bullet[i].x=-100;
        bullet[i].x=-100;
      }
    }else{
      bullet[i].x=-bullet[i].r;
      bullet[i].y=-bullet[i].r;
      bullet[i].vx=0;
      bullet[i].vy=0;
    }
  }
}
void e1b_knife(){//ナイフを発射かつ軌道
  for(int i=0;i<3;i++){
    if(enemy1[i].x>0){
      int rnd=(int)random(10)-5;
      float cos_k=cos(rnd*PI/12);
      float sin_k=sin(rnd*PI/12);
      
      knife_number=bullet_number;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+8*cos_k-0*sin_k;
      bullet[bullet_number].y=enemy1[i].y+8*sin_k+0*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;//中心
      bullet[bullet_number].x=enemy1[i].x-8*cos_k-0*sin_k;
      bullet[bullet_number].y=enemy1[i].y-8*sin_k+0*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+(24)*cos_k-(0)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+(24)*sin_k+(0)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+(-24)*cos_k-(0)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+(-24)*sin_k+(0)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+0*cos_k-(18)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+0*sin_k+(18)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+16*cos_k-(18)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+16*sin_k+(18)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x-16*cos_k-(18)*sin_k;
      bullet[bullet_number].y=enemy1[i].y-16*sin_k+(18)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+8*(cos_k)-(36)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+8*(sin_k)+(36)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+(-8)*cos_k-(36)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+(-8)*sin_k+(36)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy1[i].x+(0)*cos_k-(54)*sin_k;
      bullet[bullet_number].y=enemy1[i].y+(0)*sin_k+(54)*cos_k;
      bullet[bullet_number].vx=-5*sin_k;
      bullet[bullet_number].vy=5*cos_k;
      bullet[bullet_number].r=10;
      bullet_number++;
    
    }
  }
}
