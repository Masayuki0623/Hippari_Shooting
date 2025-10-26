Enemy enemy3;
int cnt3=0;
int enemy3_hue=0;
float []rnd_fire=new float [16];
float []x_f=new float [15];
float enemy_vx=0;
float enemy_vy=0;
Enemy px1,px2;
int mad_timer=0;
final int mad_timer_max=60;
void draw_enemy3(int cnt){
  fill(255);
  int hc=1;
  
  if(cnt<inb_max/2){hc=5;}
  if(cnt%8<4||cnt>inb_max/2){
    //ellipse(enemy3.x,enemy3.y,enemy3.r*2,enemy3.r*2);
    float ky=ky_pos();
    float ex=enemy3.x;
    float ey=enemy3.y;
    float er=enemy3.r;
    float xlb=ex-er*5/4*rnd_fire[0],ylb=ey+er/3*rnd_fire[1]-ky;
    float xlm=ex-er*rnd_fire[2],ylm=ey-er/3*rnd_fire[3]-ky;
    float xlt=ex-er*3/4*rnd_fire[4],ylt=ey-er*rnd_fire[5]-ky;
    float xrb=ex+er*5/4*rnd_fire[6],yrb=ey+er/3*rnd_fire[7]-ky;
    float xrm=ex+er*rnd_fire[8],yrm=ey-er/3*rnd_fire[9]-ky;
    float xrt=ex+er*3/4*rnd_fire[10],yrt=ey-er*rnd_fire[11]-ky;
    float tr=er/2*rnd_fire[12],xt=ex-tr/2*rnd_fire[13],yt=ey-(er+er/2)*rnd_fire[14]-ky;
    //fill(255);
    //ellipse(ex,ey,2*er,2*er);
    colorMode(RGB,255,255,255);
    fill(255/hc,0,1*hc*hc*hc);
    noStroke();
    //てっぺん
    rect(xt,yt,tr,er);
    //上
    quad(xlt,ylt,xrt,yrt,xrt,ey+er,xlt,ey+er);
    //真ん中
    quad(xlm,ylm,ex,ylm,ex,ey+er,xlm,ey+er);
    quad(xrm,yrm,ex,yrm,ex,ey+er,xrm,ey+er);
    //下の段
    quad(xlb,ylb,ex,ylb,ex,ey+er,xlb,ey+er);
    quad(xrb,yrb,ex,yrb,ex,ey+er,xrb,ey+er);
    fill(255/hc,128/hc,1*hc*hc*hc);
    stroke(255);
    /*line(xlb,ey+er,xrb,ey+er);
    line(xlb,ey+er,xlb,ylb);
    line(xrb,ey+er,xrb,yrb);
    line(xlm,ylb,xlm,ylm);
    line(xrm,yrb,xrm,yrm);
    line(xlt,ylm,xlt,ylt);
    line(xrt,yrm,xrt,yrt);
    line(xlb,ylb,xlm,ylb);
    line(xrb,yrb,xrm,yrb);
    line(xlt,ylm,xlm,ylm);
    line(xrm,yrm,xrt,yrm);
    line(xlt,ylt,xt,ylt);
    line(xrt,yrt,xt+tr,yrt);*/
    xlb+=er/4*rnd_fire[0];xlm+=er/4*rnd_fire[1];xlt+=er/4*rnd_fire[2];
    xrb-=er/4*rnd_fire[3];xrm-=er/4*rnd_fire[4];xrt-=er/4*rnd_fire[5];
    ylb+=er/8*rnd_fire[6];ylm+=er/8*rnd_fire[7];ylt+=er/8*rnd_fire[8];
    yrb+=er/8*rnd_fire[9];yrm+=er/8*rnd_fire[10];yrt+=er/8*rnd_fire[11];
    noStroke();
    //上
    quad(xlt,ylt,xrt,yrt,xrt,ey+er,xlt,ey+er);
    //真ん中
    quad(xlm,ylm,ex,ylm,ex,ey+er,xlm,ey+er);
    quad(xrm,yrm,ex,yrm,ex,ey+er,xrm,ey+er);
    //下の段
    quad(xlb,ylb,ex,ylb,ex,ey+er,xlb,ey+er);
    quad(xrb,yrb,ex,yrb,ex,ey+er,xrb,ey+er);
    
    fill(255/hc,255/hc,1*hc*hc);
    rect((xlm+xrm)/2+er/4-er/8,ylm+er/4,er/4,er/2);
    rect((xlm+xrm)/2-er/4-er/8,ylm+er/4,er/4,er/2);
    colorMode(RGB,255,255,255);
    
  }
}
float ky_pos(){
  float k=0;
  int frame=60;
  float rt=900;
  if(cnt3%rt<=800+60&&cnt3%rt>=800+60-frame){
    float t=(float)(cnt3%rt-(800+60-frame))/(float)frame/2;
    k=sin(t);
    //print(k,"\n");
  }
  return k*enemy3.r;
}
void random_fire(){
  float x=1;
  int rt=900;
  int t=30;
  if(cnt3%rt<600+60&&cnt3%rt>240+60){
    float theta=((float)(cnt3%rt)-(240+60))/(600+60-300)*PI;
    x=1+0.8*sin(theta);
    enemy3.r=100*x;
  }
  //print(x,"\n");
  if(cnt3%5==0){
    for(int i=0;i<16;i++){
      rnd_fire[i]=0.9+randomGaussian()*0.1;
    }
  }
}
void bleathe_fire_all(int n){
  bullet[bullet_number].ex=true;
  bullet[bullet_number].x=enemy3.x;
  bullet[bullet_number].y=enemy3.y;
  bullet[bullet_number].vx=10*cos(-PI/2+2*PI*cnt3/100);
  bullet[bullet_number].vy=10*sin(-PI/2+2*PI*cnt3/100);
  bullet[bullet_number].r=10;
  bullet_number++;
}
final int e3vy_k=20;
float e3vy=-e3vy_k;

void jump_enemy(int t,float g){
  if(t==0){e3vy=-e3vy_k;}
  if(t==2*20/g){e3vy=-e3vy_k;}
  if(t<2*e3vy_k/g||t<4*e3vy_k/g){
  e3vy+=g;
  enemy3.y+=e3vy;
  //print(t,"\n");
  }
  
}
void screw_bullet(){
  int m=100;
  for(int i=0;i<m;i++){
    
    if(cnt3%m==i){
      int rnd=10;
      float v=5+random(rnd);
      
      bullet[bullet_number].ex=true;
      bullet[bullet_number].x=enemy3.x;
      bullet[bullet_number].y=enemy3.y;
      bullet[bullet_number].vx=v*cos(2*PI*i/m);
      bullet[bullet_number].vy=v*sin(2*PI*i/m);
      bullet[bullet_number].r=10;
      bullet_number++;
    }
  }
}
void bleathe_fire(){
  float a=atan2(player_y-enemy3.y,player_x-enemy3.x);
  float b=PI/4/20*(random(8)-4);
  float v=15+random(10);
    bullet[bullet_number].ex=true;
    bullet[bullet_number].x=enemy3.x+0*cos(a)+enemy3.r*cos(a);
    bullet[bullet_number].y=enemy3.y+0*sin(a)+enemy3.r*sin(a);
    bullet[bullet_number].vx=v*cos(a+b);
    bullet[bullet_number].vy=v*sin(a+b);
    bullet[bullet_number].r=10;
    bullet_number++;
}

void mad_atk(){
    float ra=random(2);
    float v=2.0;
    float x=0,y=0,vx=0,vy=0;
    float r=random(1);
    if(ra<0.5){
      x=random(width);y=0;vx=v*cos(PI*r);vy=v*sin(PI*r);
    }else if(ra<1){
      x=width;y=random(height);vx=v*cos(PI/2+PI*r);vy=v*sin(PI/2+PI*r);
    }else if(ra<1.5){
      x=random(width);y=height;vx=v*cos(PI+PI*r);vy=v*sin(PI+PI*r);
    }else {
      x=0;y=random(height);vx=v*cos(PI*3/2+PI*r);vy=v*sin(PI*3/2+PI*r);
    }
    
    bullet[bullet_number].ex=true;
    bullet[bullet_number].x=x;
    bullet[bullet_number].y=y;
    bullet[bullet_number].vx=vx;
    bullet[bullet_number].vy=vy;
    bullet[bullet_number].r=10;
    bullet_number++;
}

void enemy_random_moving(){
  int wm=30;//動いている間
  int ws=0;//止まっている間
  float ra=PI*random(2);
  float v=5;
  if(cnt3%(wm+ws)==0){
      enemy_vx=v*cos(ra);
      enemy_vy=v*sin(ra);
  }
  if(enemy3.x+enemy_vx<width-enemy3.r&&enemy3.x+enemy_vx>0+enemy3.r){
    enemy3.x+=enemy_vx;
  }
  if(enemy3.y+enemy_vy<height-enemy3.r&&enemy3.y+enemy_vy>0+enemy3.r){
    enemy3.y+=enemy_vy;
  }
}
void auto_moving(){
  
  if(cnt3%60==0){
    float a=atan2(player_y-enemy3.y,player_x-enemy3.x);
    enemy_vx=10*cos(a);
    enemy_vy=10*sin(a);
  }
  if(cnt3%(60)<50){
    
    if(enemy3.x+enemy_vx<width-enemy3.r&&enemy3.x+enemy_vx>0+enemy3.r){
      enemy3.x+=enemy_vx;
    }
    if(enemy3.y+enemy_vy<height-enemy3.r&&enemy3.y+enemy_vy>0+enemy3.r){
      enemy3.y+=enemy_vy;
    }
  }
}
void move_center(int t){
  enemy3.x=((float)t/30)*width/2+(30-(float)t)/30*enemy3.x;
  enemy3.y=((float)t/30)*height/2+(30-(float)t)/30*enemy3.y;
}
void sumon_pixie(){
  //print(3,px1.hp,px2.hp);
  if(px1.hp<=0){
    px1.x=enemy3.x;
    px1.y=enemy3.y+enemy3.r;
    px1.hp=1;
    px1_vx_sum=0;
    px1_vy_sum=0;
    //print(1,px1.hp,"\n");
  }else if(px2.hp<=0){
    px2.x=enemy3.x;
    px2.y=enemy3.y+enemy3.r;
    px2.hp=1;
    px2_vx_sum=0;
    px2_vy_sum=0;
    //print(2,px2.hp,"\n");
  }
}
void draw_pixie(){
  
  if(px1.hp>0){
    float x=px1.x;
    float y=px1.y;
    float r=px1.r*rnd_fire[15];
    fill(255,0,0);
    rect(x-r,y-r,r*2,r*2);
    fill(255,128,0);
    rect(x-r/2,y-r/4,r,r+r/4);
  }else{px1.x=-100;px1.y=-100;}
  if(px2.hp>0){
    float x=px2.x;
    float y=px2.y;
    float r=px2.r*rnd_fire[15];
    fill(255,0,0);
    rect(x-r,y-r,r*2,r*2);
    fill(255,128,0);
    rect(x-r/2,y-r/4,r,r+r/4);
  }else{px2.x=-100;px2.y=-100;}
  
}
int px1_n=0;
final int px1_nmax=30;
float []px1_vx=new float [px1_nmax];
float []px1_vy=new float [px1_nmax];
float px1_vx_sum=0;
float px1_vy_sum=0;
float px2_vx_sum=0;
float px2_vy_sum=0;
float px1_theta=0;
void chase_enemy(boolean p1){
  float a=1;
  float k=10;
  
  /*if(p1){
    if(cnt3%5==1){px1_theta=atan2(player_y-px1.y,player_x-px1.x);}
    //px1_vx[px1_n]=a*cos(px1_theta)*dist(px1.x,px1.y,player_x,player_y)/100;
    //px1_vy[px1_n]=a*sin(px1_theta)*dist(px1.x,px1.y,player_x,player_y)/100;
    px1_vx[px1_n]=a*cos(px1_theta)*dist(px1.x,px1.y,player_x,player_y)/600;
    px1_vy[px1_n]=a*sin(px1_theta)*dist(px1.x,px1.y,player_x,player_y)/600;
    px1_n++;
    if(px1_n>=px1_nmax){
      px1_n=0;
    }
    px1_vx_sum=0;
    px1_vy_sum=0;
    for(int i=0;i<px1_nmax;i++){
      px1_vx_sum+=px1_vx[i];
      px1_vy_sum+=px1_vy[i];
    }
    px1.x+=px1_vx_sum;
    px1.y+=px1_vy_sum;
  }*/
  
   if(p1){
    float theta=atan2(player_y-px1.y,player_x-px1.x);
    if(cnt3%3==0){
      px1_vx_sum*=0.9;
      px1_vy_sum*=0.9;
      px1_vx_sum+=a*cos(theta);
      px1_vy_sum+=a*sin(theta);
    }
    
    px1.x+=px1_vx_sum;
    px1.y+=px1_vy_sum;
  }
  else{
    float theta=atan2(player_y-px2.y,player_x-px2.x);
    if(cnt3%3==0){
      px2_vx_sum*=0.9;
      px2_vy_sum*=0.9;
      px2_vx_sum+=a*cos(theta);
      px2_vy_sum+=a*sin(theta);
    }
    
    px2.x+=px2_vx_sum;
    px2.y+=px2_vy_sum;
  }
}
void e3_mad(){
  if(enemy3.hp<=60){
    mad_timer++;
    mad_change();
  }
  
}
void mad_change(){
  enemy3.x+=sin(mad_timer);
  
}
void enemy3_move(){
  
  cnt3++;
  enemy_inb[0]++;
  
  int rt=900;//行動パターンの周期t
  //enemy_random_moving();
  if(hit_enemy(enemy3,0)){
      enemy_inb[0]=0;
  }
  //screw_bullet();
  if(cnt3%rt<60){jump_enemy(cnt3%rt,2);}
  else if(cnt3%rt<180+60){
    if(cnt3%60<30&&cnt3>60){
     for(int i=0;i<5;i++)bleathe_fire();
   }
    auto_moving();
    
  }else if(cnt3%rt<210+60){
    int ct=cnt3%rt-180-60;
    move_center(ct);
  }
  
  if(cnt3%rt<600+60&&cnt3%rt>240+60){
    screw_bullet();
  }
  if(cnt3%rt>600+60&&cnt3%rt<840+60){
    if(cnt3%rt==800+60){
      sumon_pixie();
    }
  }
  //bleathe_fire_all(1);
  if(enemy3.hp<=60){if(cnt3%20==0){mad_atk();}}
  /////////////////////////////////////////////////////////////////////
 
  /*if(cnt3%10==0){
      sumon_pixie();
    }
  
  //print(px1_vx,px1_vy,"\n");*/
 ///////////////////////////////////////////////////////////////////////////////////
  if(px1.hp>0){chase_enemy(true);}
  if(px2.hp>0){chase_enemy(false);}
  random_fire();
  draw_enemy3(enemy_inb[0]);
  hit_enemy(px1,0);
  hit_enemy(px2,0);
  enemy_obj(enemy3);
  enemy_obj(px1);
  enemy_obj(px2);
  draw_pixie();
  e3_mad();
  show_enemy_HP(enemy3,120,200);
}
