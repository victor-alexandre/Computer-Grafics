void setup(){
  size(700,700);
  background(0);
}

void draw(){
  float figura = random(2); 
  if(figura > 1){ 
    LinhaDDA linha = new LinhaDDA(int(random(700)),int(random(700)),int(random(700)),int(random(700)), int(random(255)), int(random(255)), int(random(255)));
  }  
  else {
    CircBresenham circulo = new CircBresenham(int(random(700)), int(random(700)),int(random(700)), int(random(255)), int(random(255)), int(random(255))); 
  }
}
