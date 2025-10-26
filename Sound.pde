void sling_sound_rate(){
  
  float rate =exp((abs(energy))/100);
  //print(rate,"\n");
  float amp=0.001;
  float amp_d=30;
  if(abs(energy)<amp_d){
    //float theta=(cnt)*PI/10;
    amp=(amp_d-abs(energy))/amp_d;
    //print(theta,"\n");
    
  }
  
  if(rate>0){
    sling_sound.rate(rate);
    print(rate,"\n");
  }
  sling_sound.amp(5);
}
