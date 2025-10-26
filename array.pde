

float [][]mul_array(float [][]x,float[][]y){//配列の掛け算
  float [][]mul_a=new float[3][3];
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      mul_a[i][j]=0;
    }
  }
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      for(int k=0;k<3;k++){
          mul_a[i][j]+=x[i][k]*y[k][j];
      }            
    }
  }
    return mul_a;
}

void print_array(float [][]x){//配列を表示する
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      
      print(x[i][j]+"  ");
      
    }
    print("\n");
  }
}

float [][]rotate_array(float [][]x,float s,float c){
  float [][]r_array={{c,-s,0},
                      {s,c,0},
                      {0,0,1}};
                      
  r_array=mul_array(r_array,x);
  
  return r_array;
}
