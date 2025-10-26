int hit_timer=0;
final int scene_number=7;
boolean []scene=new boolean[scene_number];
final float br=10;
int [][]H_rnd;
int [][]S_rnd;
int [][]B_rnd;
int H_lava=0;int S_lava=0;int B_lava=0;
boolean status=false;
Enemy game_start;
Enemy restart;

void keyPressed(){
  /*for(int i=0;i<scene_number;i++){
    scene[i]=false;
  }
  /*generate_scene2bg();
  scene[2]=true;*/
  
  /*generate_bg(3);
  for(int i=0;i<riv_m;i++){
    generate_magma_riv(i);
    draw_magma_riv(i);
    flow_magma(i);
  }
  scene[3]=true;*/
  if(!status){status=true;}
  else{status=false;}
  
}
void scene_change(){
  if(player_hp<=0){
    
    for(int i=0;i<scene_number;i++){
      scene[i]=false;
    }
    reset_bullet();
    generate_bg(5);
    scene[5]=true;
    for(int i=0;i<3;i++){enemy_inb[i]=70;}
    player_hp=3;
  }
  if(scene[0]){
    scene0bg();
    
    start_UI();
    if(game_start.hp<0){
     generate_scene1bg();
      scene[0]=false;
      scene[1]=true;
      reset_bullet();
    }
  }
  if(scene[1]){
    scene3bg();
    enemy1_move();
    if(cnt1%30==0){
      draw_bush();
    }
    cnt1++;
    restart.hp=1;
    if(enemy1[0].hp<=0&&enemy1[1].hp<=0&&enemy1[2].hp<=0){
      scene[1]=false;
      scene[2]=true;
      generate_scene2bg();
      reset_bullet();
      enemy_inb[0]=70;
      enemy_inb[1]=70;
      enemy_inb[2]=70;
    }
  }
  if(scene[2]){
    scene3bg();
    enemy2_move();
    /*if(cnt2%30==0){
      draw_water();
    }*/
    if(enemy2.hp<=0){
      enemy_inb[0]=70;
      scene[2]=false;
      scene[3]=true;
      reset_bullet();
      generate_bg(3);
      for(int i=0;i<riv_m;i++){
        generate_magma_riv(i);
        draw_magma_riv(i);
        flow_magma(i);
      }
    }
  }
  if(scene[3]){
    scene3bg();
    
    enemy3_move();
    if(cnt3%10==0){
      for(int i=0;i<riv_m;i++){
        flow_magma(i);
      }
    }
    if(enemy3.hp<=0){
      enemy_inb[0]=70;
      scene[3]=false;
      scene[4]=true;
      reset_bullet();
    }
  }
  if(scene[4]){
    background(255);
    scene5();
  }
  if(scene[5]){
    scene3bg();
    //scene5bg();
    fill(0);
    textAlign(CENTER);
    textSize(50);
    text("Game Over",width/2,height/2-restart.r-30);
    restart_UI();
    if(restart.hp<0){
      restart();
      scene[5]=false;
      scene[1]=true;
      generate_scene1bg();
    }
  }
  if(scene[6]){
    background(150,150,255);
  }
}
void draw_game_start(){
  noStroke();
  if(game_start.hp>0){
    colorMode(HSB,360);
    fill(60,360,360);
    ellipse(game_start.x,game_start.y,game_start.r*2,game_start.r*2);
    textAlign(CENTER,TOP);
    colorMode(HSB,360);
    fill(0);
    textSize(50);
    float asc=textAscent();
    float des=textDescent();
    float hei=asc+des;
    text("GAME"+"\n"+"START",game_start.x,game_start.y-hei);
  }
  else{game_start.x=-100;game_start.y=-100;}
  colorMode(RGB,255);
  noStroke();
}
void draw_restart(){
  colorMode(HSB,360);
  fill(60,360,360);
  ellipse(restart.x,restart.y,restart.r*2,restart.r*2);
  textAlign(CENTER,TOP);
  textSize(50);
  float asc=textAscent();
  float des=textDescent();
  float hei=asc+des;
  fill(0);
  text("Retry",restart.x,restart.y-hei/2);
}
void start_UI(){
  draw_game_start();
  hit_enemy(game_start,0);
  textSize(100);
  textAlign(CENTER);
  colorMode(RGB,360);
  fill(0);
  textFont(createFont("HGP創英角ﾎﾟｯﾌﾟ体", 100));
  text("ひっぱりシューティング",width/2,height/4);
  colorMode(RGB,255);
}
void restart_UI(){
  draw_restart();
  hit_enemy(restart,0);
  
}
void restart(){
  cnt1=0;
  cnt2=0;
  cnt3=0;
  bullet_number=0;
  for(int i=0;i<3;i++){enemy1[i].hp=16;}
  enemy2.hp=80;
  enemy3.hp=120;
  player_hp=3;
  px1.hp=-1;
  px2.hp=-1;
  enemy3.x=width/2;
  enemy3.y=height/4;
  enemy3.r=100;
  enemy_vx=0;enemy_vy=0;
  e3vy=-e3vy_k;
  mad_timer=0;
}
void draw_player_heart(int n){
  float r=15;
  float xr=r;
  float x=10+n*(7*r+10);
  float y=10;
  int m=0;
  colorMode(HSB,360,100,100);
  fill(0,70,100);
  //rect(x,y,r,r);
  
  float s=100;
  float b=100;
  rect(x,y+r,r,r);
  rect(x,y+2*r,r,r);
  rect(x,y+3*r,r,r);
  rect(x+xr,y,r,r);
  rect(x+xr,y+r,r,r);
  rect(x+xr,y+r*2,r,r);
  rect(x+xr,y+r*3,r,r);
  rect(x+xr,y+r*3,r,r);
  rect(x+xr,y+r*4,r,r);
  rect(x+xr*2,y+r,r,r);
  rect(x+xr*2,y+r*2,r,r);
  rect(x+xr*2,y+r*3,r,r);
  rect(x+xr*2,y+r*4,r,r);
  rect(x+xr*2,y+r*5,r,r);
  rect(x+r*3,y+2*r,r,r);
  rect(x+r*3,y+3*r,r,r);
  rect(x+r*3,y+4*r,r,r);
  rect(x+r*3,y+5*r,r,r);
  rect(x+r*3,y+6*r,r,r);
  x=x+r*6;
  xr=-r;
  rect(x,y+r,r,r);
  rect(x,y+2*r,r,r);
  rect(x,y+3*r,r,r);
  rect(x+xr,y,r,r);
  rect(x+xr,y+r,r,r);
  rect(x+xr,y+r*2,r,r);
  rect(x+xr,y+r*3,r,r);
  rect(x+xr,y+r*3,r,r);
  rect(x+xr,y+r*4,r,r);
  rect(x+xr*2,y+r,r,r);
  rect(x+xr*2,y+r*2,r,r);
  rect(x+xr*2,y+r*3,r,r);
  rect(x+xr*2,y+r*4,r,r);
  rect(x+xr*2,y+r*5,r,r);

}
void player_HP(){
  if(!scene[0]&&!scene[4]&&!scene[5]){
    for(int i=0;i<player_hp;i++){
      fill(255,0,0);
      draw_player_heart(i);
    }
  }
}
void HP_bar(float x,float y,float MAX_HP,float HP,float range){
  float HP_range=range*HP/MAX_HP;
  stroke(1);
  fill(0,255,0);
  rect(x,y-range/5,HP_range,100/5);
  fill(255,0,0);
  rect(x+HP_range,y-range/5,range-HP_range,100/5);
  noStroke();
}
void show_enemy_HP(Enemy e,float mx,float rng){
  if(e.hp>0){
    if(!scene[3]){
      HP_bar(e.x-50,e.y-50,mx,e.hp,rng);
    }else if(scene[3]){
      HP_bar(e.x-100,e.y-120,mx,e.hp,rng);
    }
  }
}
void show_demage(float x,float y,float d){
  textSize(30);
  fill(255,0,0);
  text(-abs((int)d),x+100,y+20);
  hit_timer++;
  if(hit_timer>90){
    hit=false;
    hit_timer=0;
  }
}
void scene0bg(){
  colorMode(HSB,100);
  background(60,30,90);
}

int [][]H_bg;
int [][]S_bg;
int [][]B_bg;
void generate_scene1bg(){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  int bush=20;
  int []bush_posx=new int [bush];
  int []bush_posy=new int [bush];
 
  for(int i=0;i<w_br;i++){
    for(int j=0;j<h_br;j++){
      H_rnd[i][j]=30+(int)random(5)-25;
      S_rnd[i][j]=(int)random(5)+5+10;
      B_rnd[i][j]=75+(int)random(5)+20;
      H_bg[i][j]=H_rnd[i][j];
      S_bg[i][j]=S_rnd[i][j];
      B_bg[i][j]=B_rnd[i][j];
    }
  }
  int r=9;
  for(int i=0;i<bush;i++){
    
    bush_posx[i]=i%5*30+15;
    bush_posy[i]=(i/5)*30+10;
    if(i>4&&i<10){
      bush_posx[i]=i%5*30+15-15;
    }
    for(int j=-r;j<r;j++){
      int xr=j+bush_posx[i];
      for(int k=-r;k<r;k++){
        int yr=k+bush_posy[i];
        if(dist(xr+random(0.5),yr+random(0.5),bush_posx[i],bush_posy[i])<r){
          if(xr>=0&&xr<w_br&&yr>=0&&yr<h_br){
            H_rnd[xr][yr]=120+(int)random(5)-25;
            S_rnd[xr][yr]=(int)random(5)+5+10;
            B_rnd[xr][yr]=70+(int)random(5)+10;
          }
        }
      }
    }
  }

}
void draw_bush(){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  int bush=20;
  int []bush_posx=new int [bush];
  int []bush_posy=new int [bush];
  int r=9;
  for(int i=0;i<w_br;i++){
    for(int j=0;j<h_br;j++){
      H_rnd[i][j]=H_bg[i][j];
      S_rnd[i][j]=S_bg[i][j];
      B_rnd[i][j]=B_bg[i][j];
    }
  }
  for(int i=0;i<bush;i++){
    
    bush_posx[i]=i%5*30+15+(int)random(2)-1;
    bush_posy[i]=(i/5)*30+10+(int)random(2)-1;
    if(i>4&&i<10){
      bush_posx[i]=i%5*30+15-15+(int)random(2)-1;
    }
    for(int j=-r;j<r;j++){
      int xr=j+bush_posx[i];
      for(int k=-r;k<r;k++){
        int yr=k+bush_posy[i];
        if(dist(xr+random(2)-1,yr+random(2)-1,bush_posx[i],bush_posy[i])<r){
          if(xr>=0&&xr<w_br&&yr>=0&&yr<h_br){
            H_rnd[xr][yr]=120+(int)random(5)-25;
            S_rnd[xr][yr]=(int)random(5)+5+10;
            B_rnd[xr][yr]=70+(int)random(5)+10;
          }
        }
      }
    }
  }
}
void scene2bg(){
  colorMode(HSB,100);
  for(int i=0;i<(int)(width/br)+1;i++){
    for(int j=0;j<(int)(height/br)+1;j++){
      fill(H_rnd[i][j],S_rnd[i][j],B_rnd[i][j]);
      rect(br*i,br*j,br,br);
    }
    
  }
  colorMode(RGB,255);
}
/*
void draw_water(){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  for(int i=0;i<w_br;i++){
    for(int j=0;j<h_br;j++){
      H_rnd[i][j]=H_bg[i][j];
      S_rnd[i][j]=S_bg[i][j];
      B_rnd[i][j]=B_bg[i][j];
    }
  }
  for(int i=0;i<w_br;i++){//影
    for(int j=0;j<h_br;j++){
      float y1=(float)((i-w_br/2)*(i-w_br/2)/500+20);
      float y=(float)((i-w_br/2-random(1))*(i-w_br/2+random(1)))/150-2;
      if(j<y1&&j>y){
        if(random(1)>0.8){
          H_rnd[i][j]=210+(int)random(30)-15;
        }else{
          H_rnd[i][j]=30+(int)random(30)-15;
        }
        S_rnd[i][j]=(int)random(15)+75;
        B_rnd[i][j]=(int)random(10)+j;
      }
    }
  }
  for(int i=0;i<w_br;i++){//湖
    for(int j=0;j<h_br;j++){
      int rnd=5;
      float y1=-(float)((i-w_br/2-random(rnd))*(i-w_br/2+random(rnd)))/200+50+random(rnd);
      float y2=(float)((i-w_br/2-random(1))*(i-w_br/2+random(1))/500+20-random(1)-1);
      if(j<y1&&j>=y2){
        H_rnd[i][j]=210+(int)random(30)-15;
        S_rnd[i][j]=(int)random(15);
        B_rnd[i][j]=60+(int)random(15);
      }
    }
  }
}*/
void generate_scene2bg(){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  for(int i=0;i<w_br;i++){//湖
    for(int j=0;j<h_br;j++){
      int rnd=5;
      float y1=-(float)((i-w_br/2-random(rnd))*(i-w_br/2+random(rnd)))/200+30+random(rnd);
        H_rnd[i][j]=(int)random(5)+90-(int)random(j*5);
        S_rnd[i][j]=(int)random(5)+20;
        B_rnd[i][j]=90+(int)random(5);
      
    }
  }
  
  
}
final int riv_m=15;
final int riv_l=450;
int [][][]magma_riv=new int [riv_m][riv_l][2];
boolean [][]burn_glass;
void setup_burnglass(){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  burn_glass=new boolean[w_br][h_br];
  for(int i=0;i<w_br;i++){
    for(int j=0;j<h_br;j++){
      burn_glass[i][j]=false;
    }
  }
}


void generate_magma_riv(int n){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  magma_riv[n][0][0]=(int)random(w_br);
  magma_riv[n][0][1]=0;
  for(int i=1;i<riv_l;i++){
    int rnd=(int)random(10);
    
    int vecter=0;
    if(rnd==0){
      vecter=0;
    }else if(rnd<4){
      vecter=1;
    }
    else if(rnd<7){
      vecter=2;
    }else{
      vecter=3;
    }
    if(vecter==0&&magma_riv[n][i-1][1]>0){//上
      magma_riv[n][i][0]=magma_riv[n][i-1][0];
      magma_riv[n][i][1]=magma_riv[n][i-1][1]-1;
    }else if(vecter==1&&magma_riv[n][i-1][0]<w_br-1){//右
      magma_riv[n][i][0]=magma_riv[n][i-1][0]+1;
      magma_riv[n][i][1]=magma_riv[n][i-1][1];
    }else if(vecter==2&&magma_riv[n][i-1][1]<h_br-1){//下
      magma_riv[n][i][0]=magma_riv[n][i-1][0];
      magma_riv[n][i][1]=magma_riv[n][i-1][1]+1;
    }else if(vecter==3&&magma_riv[n][i-1][0]>0){//左
      magma_riv[n][i][0]=magma_riv[n][i-1][0]-1;
      magma_riv[n][i][1]=magma_riv[n][i-1][1];
    }else{
      magma_riv[n][i][0]=magma_riv[n][i-1][0];
      magma_riv[n][i][1]=magma_riv[n][i-1][1];
    }
  }
}
void draw_magma_riv(int n){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
  for(int i=0;i<riv_l;i++){
    H_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=(int)random(60)-15;
    if(H_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]<0){
      H_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=360-H_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]];
    }
    S_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=20+(int)random(5);
    
    B_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=90+(int)random(5);
    
  }
}
void generate_bg(int n){
  int rnd=0;
  if(n==1){rnd=120;}
  else if(n==2){rnd=210;}
  else if(n==3){rnd=0;}
  for(int i=0;i<(int)(width/br)+1;i++){
    for(int j=0;j<(int)(height/br)+1;j++){
      H_rnd[i][j]=120+(int)random(5);
      S_rnd[i][j]=10+(int)random(5);
      B_rnd[i][j]=90+(int)random(5);
      H_bg[i][j]=H_rnd[i][j];
      S_bg[i][j]=S_rnd[i][j];
      B_bg[i][j]=B_rnd[i][j];
      
    }
  }
  
  if(n==5){
    for(int i=0;i<(int)(width/br)+1;i++){
      for(int j=0;j<(int)(height/br)+1;j++){
        H_rnd[i][j]=(int)random(360);
        S_rnd[i][j]=(int)random(15);
        B_rnd[i][j]=60+(int)random(15);
      }
    }
  }
}
void flow_magma(int n){
  int w_br=(int)(width/br)+1;
  int h_br=(int)(height/br)+1;
 for(int i=0;i<w_br;i++){
    for(int j=0;j<h_br;j++){
      H_rnd[i][j]=H_bg[i][j];
      S_rnd[i][j]=S_bg[i][j];
      B_rnd[i][j]=B_bg[i][j];
    }
  }
  H_rnd[magma_riv[n][0][0]][magma_riv[n][0][1]]=(int)random(60)-15;
  if(H_rnd[magma_riv[n][0][0]][magma_riv[n][0][1]]<0){
    H_rnd[magma_riv[n][0][0]][magma_riv[n][0][1]]=360-H_rnd[magma_riv[n][0][0]][magma_riv[n][0][1]];
  }
  S_rnd[magma_riv[n][0][0]][magma_riv[n][0][1]]=15+(int)random(5);
  B_rnd[magma_riv[n][0][0]][magma_riv[n][0][1]]=90+(int)random(5);
  for(int i=riv_l-1;i>0;i--){
    H_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=H_rnd[magma_riv[n][i-1][0]][magma_riv[n][i-1][1]];
    S_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=S_rnd[magma_riv[n][i-1][0]][magma_riv[n][i-1][1]];
    B_rnd[magma_riv[n][i][0]][magma_riv[n][i][1]]=B_rnd[magma_riv[n][i-1][0]][magma_riv[n][i-1][1]];
    
  }
  for(int i=0;i<w_br;i++){
    for(int j=0;j<h_br;j++){
      H_bg[i][j]=H_rnd[i][j];
      S_bg[i][j]=S_rnd[i][j];
      B_bg[i][j]=B_rnd[i][j];
    }
  }
  
  
  
}
void scene3bg(){
  colorMode(HSB,360,100,100);
  for(int i=0;i<(int)(width/br)+1;i++){
    for(int j=0;j<(int)(height/br)+1;j++){
      fill(H_rnd[i][j],S_rnd[i][j],B_rnd[i][j]);
      
      rect(br*i,br*j,br,br);
    }
    
  }
  colorMode(RGB,255);
}

void scene5(){
  textAlign(CENTER,TOP);
  textSize(100);
  float asc=textAscent();
  float des=textDescent();
  float hei=asc+des;
  text("GAME CLEAR\nTAHNK YOU FOR PLAYING",width/2,height/2-hei);
  textSize(40);
  textAlign(LEFT,TOP);
  text("クリアタイム\n1:"+cnt1/60+"秒\n2:"+cnt2/60+"秒\n3:"+cnt3/60+"秒\n"+"合計:"+(cnt1/60+cnt2/60+cnt3/60)+"秒",0,0);
}
/*final int number5=100;
float []h5=new float[number5];
float []s5=new float[number5];
float []r5=new float[number5];
float []x5=new float[number5];
float []y5=new float[number5];
void det_5bg(){
  for(int i=0;i<number5;i++){
    h5[i]=random(360);
    s5[i]=20+random(80);
    r5[i]=100+random(100);
    x5[i]=random(width);
    y5[i]=random(height);
  }
}
void scene5bg(){
  colorMode(HSB,360,100,100);
  int i=0;
  while(i<number5){
    
    fill(h5[i],s5[i],100);
    ellipse(x5[i],y5[i],r5[i],r5[i]);
    i++;
  }
  colorMode(RGB,255);
}*/
