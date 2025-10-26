int change_time=0;
Enemy []enemy1=new Enemy[3];
int cnt1=0;
int []enemy_inb=new int [3];
class Enemy{
  float x,y,r,hp;
  Enemy(float xpos,float ypos,float radius,float HP){
    x=xpos;
    y=ypos;
    r=radius;
    hp=HP;
  }
}

void draw_enemy1(int n,int cnt){
  
    if(enemy1[n].hp>0){
      float ex=enemy1[n].x;
      float ey=enemy1[n].y;
      //image(enemy1_img,ex,ey,enemy1[i].r*2,enemy1[i].r*2);
      fill(255,0,0);
      enemy1_img(ex,ey,enemy1[n].r,cnt);
      
      //ellipse(ex,ey,enemy1[i].r*2,enemy1[i].r*2);
    
  }
}
void enemy1_img(float x,float y,float r,int cnt){
  float hc=1;
  if(cnt<inb_max/2){hc=2;}
  colorMode(HSB,360,100,100);
  if(cnt%8<4||cnt>inb_max/2){
    
    if(hc==1){
      fill(104,70,50);
    }else{
      fill(0,60,90);
    }
    triangle(x,y-r,x-r,y+r,x+r,y+r);
    triangle(x-r*3/4-r/8,y-r*3/4,x-r+r/4,y+r-r/4,x+r-r/4,y+r-r/4);
    triangle(x+r*3/4+r/8,y-r*3/4,x+r-r/4,y+r-r/4,x-r+r/4,y+r-r/4);
    if(hc==1){
      fill(30,80,35);
    }else{
      fill(0,60,60);
    }
    triangle(x-r/4,y+r*3/8,x-r*3/8,y+r/8,x-r/8,y+r/8);
    triangle(x+r/4,y+r*3/8,x+r*3/8,y+r/8,x+r/8,y+r/8);
    triangle(x,y+r/2,x+r/8,y+r*3/4,x-r/8,y+r*3/4);
    
  }
  colorMode(RGB,255,255,255);
}
void enemy_place(){
  
  for(int i=0;i<3;i++){
    if(enemy1[i].hp<=0){
      enemy1[i].x=-100;
      enemy1[i].y=-100;
      
    }
    else{
      enemy1[i].x=width/2+(i-1)*100;
      if(i==1){enemy1[i].y=100+100;}
      else{enemy1[i].y=100;}
      
      
    }
  }
}
void enemy_obj(Enemy e){
  if(dist(player_x,player_y,e.x,e.y)<=ellipse_round/2+e.r&&inb_cnt>inb_max&&e.hp>0){
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
  }
}
boolean hit_enemy(Enemy e,int img){
    float er;
    boolean hit=false;
  if(img==1){er=e.r;}
  else{er=0;}
    float ex=e.x;
    float ey=e.y;
    fill(255,0,0);
  for(int i=0;i<3;i++){
    if(dist(ex+er,ey+er,ball_x[i],ball_y[i])<e.r+ellipse_round){
      if(!scene[5]&&!scene[0]){
        if(velocity_b<e.hp){
          hit_sound.play();
          hit_sound.rewind();
        }else{
          kill_sound.play();
          kill_sound.rewind();
        }
      }else{
        restart_sound.play();
        restart_sound.rewind();
      }
      e.hp-=abs(velocity_b);
      ball_x[i]=width+100;ball_y[i]=height+100;
      ball_vx[i]=0;
      ball_vy[i]=0;
      hit_place_x=ex;
      hit_place_y=ey;
      hit_demage=velocity_b;
      hit=true;
      if(!scene[0]){hit=true;}
      velocity_b=0;
      hit=true;
    }
  }
  return hit;
} //<>// //<>// //<>// //<>// //<>// //<>//
void enemy1_move(){
  
  for(int i=0;i<3;i++){
    enemy_inb[i]++;
    if(hit_enemy(enemy1[i],0)){
      enemy_inb[i]=0;
    }
    
  draw_enemy1(i,enemy_inb[i]);
  show_enemy_HP(enemy1[i],16,100);
  enemy_obj(enemy1[i]);
}

  
  enemy_place();
  if(cnt1%60==0){
    e1b_knife();
  }
}
