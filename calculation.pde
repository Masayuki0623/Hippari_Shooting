float va;
float vb;
int time_cnt=0;
boolean line_exit=false;
float velocity_p=0;
final float nearly_zero=0.000001;
final float nearly_inf=1/nearly_zero;
float velocity_bx,velocity_by;
float sin_p,cos_p,tan_p;
float sin_vp,cos_vp,tan_vp;
float dist_x,dist_y;
float velocity_b;
float[][] hand_diff=new float[3][3];
float diff_x,diff_y;
float velocity_x,velocity_y;
float acceleration_x,acceleration_y;
float energy_l,energy_r;
float energy_x,energy_y;
float energy_xl,energy_yl;
float energy_xr,energy_yr;
float dist_l,dist_r;
float cos_l,sin_l,cos_r,sin_r;
float theta_h;


void liner_equation(){//一次方程式を求める
  float x=0;
  float y=0;
  if(mousePressed||!player_is_free){
    if(abs(player_x-handX)>=nearly_zero){
      cos_p=(handX-player_x)/string_dist;
      sin_p=(handY-player_y)/string_dist;
      tan_p=sin_p/cos_p;
      theta_h=atan((handY-player_y)/(handX-player_x));
      
    }else if(player_y>handY){
      cos_p=0;
      sin_p=1;
      tan_p=nearly_inf;
      theta_h=PI/2;
   }else{
      cos_p=0;
      sin_p=-1;
      tan_p=-nearly_inf;
      theta_h=-PI/2;
   }
  float a=tan(theta_h);
  float b=handY-a*handX;
  if(status){
    while(((x>=0&&x<=width)||(y>=0&&y<=height))&&abs(handX-player_x)>=nearly_zero&&abs(player_y-handY)>=nearly_zero){
      x++;
      y=a*x+b;
      
      noStroke();
      fill(0);
      ellipse(x,y,1,1);
    }
    }
  }
}

void vertical_line(){
if(mousePressed||!player_is_free){
  time_cnt++;
  float vx=0,vy=0;
  cos_vp=sin_p;sin_vp=-cos_p;
if(abs(cos_vp)>=nearly_zero){
  tan_vp=sin_vp/cos_vp;
  
  }else if((player_x>handX&&player_y<handY)||(player_x>handX&&player_y>handY)){
      cos_vp=0;
      sin_vp=1;
      tan_vp=nearly_inf;
   }else{
      cos_vp=-0;
      sin_vp=-1;
      tan_vp=-nearly_inf;
   }
   va=tan_vp;
  vb=handY-handX*va;
  if(status){
    while(((vx>=0&&vx<=width)||(vy>=0&&vy<=height))&&time_cnt>5&&abs(cos_vp)>=nearly_zero&&abs(sin_vp)>=nearly_zero){
      vx++;
      vy=va*vx+vb;
      noStroke();
      fill(0);
      ellipse(vx,vy,1,1);
    }  
  }
}
}
void caluculate_dist(){
  string_dist=dist(player_x,player_y,handX,handY);
  dist_l=dist(boh[0],boh[1],handX_left,handY_left);
  dist_r=dist(boh[2],boh[3],handX_right,handY_right);
  diff_x=player_x-handX;
  diff_y=player_y-handY;
  dist_x=string_dist*cos_p;
  dist_y=string_dist*sin_p;
}
void calculate_energy(){
  float F=0.2;
  float k=1;
  float m=1;
  energy=(F*string_dist-m*velocity_p)*k;
  energy_l=(F*dist_l-m*velocity_p)*k;
  energy_r=(F*dist_r-m*velocity_p)*k;
  energy_x=energy*cos_p;
  energy_y=energy*sin_p;
  energy_xl=energy_l*cos_l;
  energy_yl=energy_l*sin_l;
  energy_xr=energy_r*cos_r;
  energy_yr=energy_r*sin_r;
  //print(energy_xl*energy_xl+energy_yl*energy_yl,energy_l*energy_l,"\n");
  //print(energy_xl,energy_yl,energy_l,"\n");
  //print(energy_xr*energy_xr+energy_yr*energy_yr,energy_r*energy_r,"\n");
  //print(energy_xr,energy_yr,energy_r,"\n");
  //print(energy_x,energy_xl+energy_xr,"\n");
  //print(energy_y,energy_yl+energy_yr,"\n");
}


void calculate_player_xy(){
  diff_x+=velocity_x/1;
  diff_y+=velocity_y/1;
}

void calculate_player_velocity(){
  
  if(!player_is_free){
    velocity_p+=player_acceleration;
    velocity_x+=acceleration_x;
    velocity_y+=acceleration_y;
    //print(velocity_x,velocity_y,"\n");
  }else{
    velocity_p=0;
    velocity_x=0;
    velocity_y=0;
  }
}

void calculate_player_acceleration(){
  player_acceleration=energy;
  acceleration_x=(energy_xl+energy_xr);
  acceleration_y=(energy_yl+energy_yr);
  //print(acceleration_x,acceleration_y,"\n");
}

void calculate_hand_vector(){
  cos_l=(handX_left-boh[0])/dist_l;
  sin_l=(handY_left-boh[1])/dist_l;
  cos_r=(handX_right-boh[2])/dist_r;
  sin_r=(handY_right-boh[3])/dist_r;
}

void calculate_hand_diff(){
  hand_diff[0][0]=1;
  hand_diff[0][1]=0;
  hand_diff[0][2]=string_dist;
  hand_diff[1][0]=0;
  hand_diff[1][1]=1;
  hand_diff[1][2]=0;
  hand_diff[2][0]=0;
  hand_diff[2][1]=0;
  hand_diff[2][2]=1;
  hand_diff=rotate_array(hand_diff,sin_vp,cos_vp);
}
