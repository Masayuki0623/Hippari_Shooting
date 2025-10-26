import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
float ellipse_round=50;
float energy=0;
float string_dist=0;
float player_x;
float player_y;
float player_acceleration=0;
int time=0;
boolean pressed=false;
PImage enemy1_img;
PImage f1;
PImage f3;
int timer=0;
AudioOutput out;
//SineWave wave;
Minim minim;
AudioPlayer hit_sound;
SoundFile sling_sound;
AudioPlayer kill_sound;
AudioPlayer damage_sound;
AudioPlayer death_sound;
AudioPlayer restart_sound;
AudioPlayer BGM1;
import processing.sound.*;


void setup() {
  size(1980*5/8,1080*3/4);
  frameRate(60);
  //fullScreen();
  colorMode(RGB); 
  noStroke();
  for(int i=0;i<scene_number;i++){scene[i]=false;}
  scene[0]=true;
  game_start=new Enemy(width/2,height/2,100,1);
  restart=new Enemy(width/2,height/2,100,1);
  for(int i=0;i<3;i++){enemy_inb[i]=60;}
  for(int i=0;i<16;i++){rnd_fire[i]=1;}
  for(int i=0;i<15;i++){x_f[i]=random(100);}
  for(int i=0;i<3;i++){enemy1[i]=new Enemy(-1,-1,50,16);}
  enemy2=new Enemy(width/2,height/4,50,80);
  enemy3=new Enemy(width/2,height/4,100,120);
  
  for(int i=0;i<px1_nmax;i++){px1_vx[i]=0;}/////////////////////////////////////////////////////////////////////////////////////////////////////
  for(int i=0;i<px1_nmax;i++){px1_vy[i]=0;}
  px1=new Enemy(-20,-20,30,-1);
  px2=new Enemy(-20,-20,30,-1);
  for(int i=0;i<ball_max;i++){ball_x[i]=width+100;ball_y[i]=height+100;ball_vx[i]=0;ball_vy[i]=0;}
  enemy1_img=loadImage("p/enemy1.png");
  f1=loadImage("p/field1.png");
  f3=loadImage("p/magma.jpg");
  minim = new Minim(this);
  hit_sound=minim.loadFile("s/Windows Pop-up Blocked.wav");
  kill_sound=minim.loadFile("s/Windows Error.wav");
  sling_sound=new SoundFile(this,"s/Windows Ringout.wav");
  damage_sound=minim.loadFile("s/Windows Default.wav");
  death_sound=minim.loadFile("s/Windows Logoff Sound.wav");
  restart_sound=minim.loadFile("s/Windows Logon.wav");
  out = minim.getLineOut(Minim.MONO);
  //wave = new SineWave(440, 1.0, out.sampleRate());
  //wave.portamento(200);
  //out.addSignal(wave);
  BGM1=minim.loadFile("s/Ring02.wav");
  for(int i=0;i<bullet_max;i++){bullet[i]=new Bullet(-1,-1,-1,-1,-1,false);}
  //det_5bg();
  H_rnd=new int [(int)(width/br)+1][(int)(height/br)+1];
  S_rnd=new int [(int)(width/br)+1][(int)(height/br)+1];
  B_rnd=new int [(int)(width/br)+1][(int)(height/br)+1];
  H_bg=new int [(int)(width/br)+1][(int)(height/br)+1];
  S_bg=new int [(int)(width/br)+1][(int)(height/br)+1];
  B_bg=new int [(int)(width/br)+1][(int)(height/br)+1];
  setup_burnglass();
  for(int i=0;i<(int)(width/br)+1;i++){
    for(int j=0;j<(int)(height/br)+1;j++){
      H_rnd[i][j]=15+(int)random(15);
      S_rnd[i][j]=(int)random(15);
      B_rnd[i][j]=60+(int)random(15);
      H_bg[i][j]=15+(int)random(15);
      S_bg[i][j]=(int)random(15);
      B_bg[i][j]=60+(int)random(15);
    }
  }
//BGM1.loop();
}

void draw() {
  if(inb_cnt<5){
    int t=0;
    if(inb_cnt%2==0){
      t=inb_cnt;
    }
    else{
      t=-inb_cnt;
    }
    translate(3*t,3*t);
  }
  timer++;
  background(0);
  colorMode(RGB);
  
  time++;
  fill(0);
  function();
  noStroke();
  
  textSize(20);
  fill(0);
  if(status){
    textFont(createFont("Arial", 20));
    textAlign(LEFT);
    text("energy="+energy+"\ndist="+string_dist+"\n( diff_x , diff_y )=("+diff_x+","+diff_y+")\n( x , y )=("+player_x+" , "+player_y+")\nplayer_velocity="+velocity_p+"\nplayer_acceleration="+player_acceleration+"\n(ball_x,ball_y)=("+ball_x+","+ball_y+")"+"\nvelocity_b="+velocity_b,0,50);
  }else{
    textFont(createFont("Arial", 20));
    textAlign(LEFT);
    text("dist_l="+dist_l+"\ndist_r="+dist_r+"\ncos_l="+cos_l+"\nsin_l"+sin_l+"\ncos_r"+cos_r+"\nsin_r="+sin_r+"\ncos_p="+cos_p+"\nsin_p="+sin_p,10,50);
  }
}
int cnt=0;
void function(){
  scene_change();
  free_player();
  
  player_HP();
  calculate_hand_vector();
  calculate_hand_diff();
  caluculate_dist();
  liner_equation();
  vertical_line();
  calculate_energy();
  calculate_player_acceleration();
  shoot();
  calculate_player_velocity();
  player_place();
  hand_place();
  sling_sound_rate();
  //print(come_back_cnt,"\n");
  //if(player_is_free){print(1);}
  //else{print(0);}
  colorMode(RGB,255);
  draw_player();
  
  move_ball();
  bullet();
  //print(cnt1,cnt2,cnt3,"\n");
  cnt++;
  //print(velocity_x,"\n");
  for(int i=0;i<3;i++){
    if(enemy_inb[i]<inb_max/2){
      show_demage(hit_place_x,hit_place_y,hit_demage);
    }
  }
  
}
