float x,y;
float speed; 

void setup(){
  background(255);
  size(700, 700);
  x = 350;
  y = 350;
  speed = 8;//Já inicia na velocidade máxima
}


void draw() {
  stroke(0);
  rectMode(CENTER);
  //colore o retangulo de preto
  fill(0);
  //cria um retangulo 8x8 nas coordenadas x e y 
  rect(x, y, 8, 8); 
}

void keyPressed(){
  //Encerra o programa se for pressionado a tecla ESC
  if(key == ESC){
    exit(); 
  }
  
  if(key == 's' || key == 'S' || key == '5'){
    //pinta a tela de branco
    background(255);
  } 
  
  //USE AS TECLAS '+' E '-' PARA CONTROLAR A VELOCIDADE DO RETANGULO OBS: A VELOCIDADE MÁXIMA É 8 E A MÍNIMA É 1
  if(key == '+' && speed < 8 ){
    speed++;
    //println(speed);
  }
  
  if(key == '-' && speed > 1){
    speed--; 
    //println(speed);
  } 
  
  //TECLAS PARA MOVIMENTAR O RETANGULO
  if(key == '8' || key == 'w' || key == 'W'){
    if(y - speed < 0 + 4){//do nothing / assim o retangulo não passará das bordas obs: O -4 é o tamanho da metade do lado do retangulo usado nesse programa
    } else{
        y = y - speed;
      }
  }

  if(key == '2' || key == 'x' || key == 'X'){
    if(y + speed > 700 - 4){//do nothing / assim o retangulo não passará das bordas obs: O -4 é o tamanho da metade do lado do retangulo usado nesse programa
    } else{
        y = y + speed;
      }
  }
  
  if(key == '6' || key == 'd' || key == 'D'){
    if(x + speed > 700 - 4){//do nothing / assim o retangulo não passará das bordas obs: O -4 é o tamanho da metade do lado do retangulo usado nesse programa
    } else{
        x = x + speed;
      }
  }
  
  if(key == '4' || key == 'a' || key == 'A'){
    if(x - speed < 0 + 4){//do nothing / assim o retangulo não passará das bordas obs: O -4 é o tamanho da metade do lado do retangulo usado nesse programa
    } else{
        x = x - speed;
      }
  }
}
