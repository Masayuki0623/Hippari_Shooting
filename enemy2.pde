Enemy enemy2;
int cnt2=0;
int rt;
float cos_e=0;float sin_e=1;float d_e=1;
int t_number;
void draw_enemy2(int cnt){
  float ex=enemy2.x;
  float ey=enemy2.y;
  float er=enemy2.r;
  float hc=1;
  if(cnt<inb_max/2){hc=10;}
  if(cnt%8<4||cnt>inb_max/2){
    fill(0+1*hc*hc,50/hc,210/hc);
    pushMatrix();
    translate(ex,ey);
    pushMatrix();  
    if(cnt2%rt<rt/2||cnt2%rt>=rt-50){
      rotate(PI*sin((float)cnt/8)/4);
    }
    translate(-ex,-ey);
    ellipse(ex-er,ey+er/4,er/3,er/1.5);
    ellipse(ex+er,ey+er/4,er/4,er);
    fill(70*hc,255/hc,255/hc);
    ellipse(enemy2.x,enemy2.y-er/4+5,enemy2.r*2,enemy2.r*7/4+5);
    ellipse(ex+er/2,ey+er-er/4,er/2,er/4);
    ellipse(ex-er/2,ey+er-er/4,er/2,er/4);
    fill(0+1*hc*hc,50/hc,210/hc);
    ellipse(ex-er/2,ey-er/4,er/2,er);
    ellipse(ex+er*5/8,ey-er/2,er/3,er/1.5);
    ellipse(ex+er/8,ey+er/4,er/3,er/2);
    popMatrix();
    popMatrix();
    
  }
}
void enemy2_place(){
  float r=100;
  rt=600;
  if(enemy2.hp>0){
    if(cnt2%rt<rt/4){
      enemy2.x=width/2+r*1.5*(1+cos((cnt2-rt/2)*PI/75-PI));
      enemy2.y=height/4+r*sin((cnt2-rt/2)*PI/75-PI);
      if(cnt2>100){
      rnd_atk();
      }
    }else if(cnt2%rt<rt/2){
      enemy2.x=width/2+r*1.5*(-1+cos(-(cnt2-rt/2)*PI/75));
      enemy2.y=height/4+r*sin(-(cnt2-rt/2)*PI/75);
      rnd_atk();
    }else{
      
      enemy2.x=width/2;
      enemy2.y=height/4;
    }
  }else{
    enemy2.x=-100;
    enemy2.y=-100;
  }
}
void rnd_atk(){
  if(cnt2%2==0){
    float rnd=random(30);
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy2.x;
      bullet[bullet_number].y=enemy2.y;
      bullet[bullet_number].vx=8*sin(PI/20*(rnd-15));
      bullet[bullet_number].vy=8*cos(PI/20*(rnd-15));
      bullet[bullet_number].r=10;
      bullet_number++;
  }
}
void tgt_atk(){
  if(cnt2%rt==rt*3/4-30){//cnt2%rt==rt*3/4-30

    t_number=bullet_number;
    for(int i=0;i<6;i++){
      bullet[bullet_number+i].ex=true;
      bullet[t_number+i].r=10;
      bullet[t_number+i].x=enemy2.x;
      bullet[t_number+i].y=enemy2.y+60;
      bullet[t_number+i].vx=0;
      bullet[t_number+i].vy=0;
    }
    
  }
  if(cnt2%rt<=rt*3/4&&cnt2%rt>rt*3/4-30){//cnt2%rt<=rt*3/4&&cnt2%rt>rt*3/4-30
    d_e=dist(enemy2.x,enemy2.y+60,player_x,player_y);
    cos_e=(player_x-enemy2.x)/d_e; 
    sin_e=(player_y-(enemy2.y+60))/d_e;
    for(int i=0;i<6;i++){
      bullet[t_number+i].x=enemy2.x+20*i*cos_e/30*(cnt2%rt-rt*3/4+30);
      bullet[t_number+i].y=enemy2.y+60+20*i*sin_e/30*(cnt2%rt-rt*3/4+30);
    }
  }
  if(cnt2%rt==rt*3/4){
    for(int i=0;i<6;i++){
      bullet[t_number+i].vx=15*cos_e;
      bullet[t_number+i].vy=15*sin_e;
      bullet_number++;
    }
  }
}
void enemy2_move(){
  cnt2++;
  enemy_inb[0]++;
  if(hit_enemy(enemy2,0)){
      enemy_inb[0]=0;
    }
  show_enemy_HP(enemy2,80,100);
  enemy2_place();
  hit_enemy(enemy2,0);
  enemy_obj(enemy2);
  tgt_atk();
  draw_enemy2(enemy_inb[0]);
 
}
