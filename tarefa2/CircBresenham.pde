public class CircBresenham {

  CircBresenham(int xc, int yc, int raio, int R, int G, int B){
    //int raioQuadrado = raio*raio;
    //int mh = (xc + 1)*(xc + 1) + yc*yc - raioQuadrado;
    //int md = (xc + 1)*(xc + 1) + (yc - 1)*(yc -1) - raioQuadrado;
    //int mv = xc*xc + (yc - 1)*(yc - 1) - raioQuadrado;   
    //int di = md;
    
    int x = raio;
    int y = 0;
    int xChange = 1 - 2*raio;
    int yChange = 1;
    int erro = 0;
    
    while(x >= y){
      stroke(R,G,B);
      point(xc + x, yc + y);
      point(xc - x, yc + y);
      point(xc - x, yc - y);
      point(xc + x, yc - y);
      point(xc + y, yc + x);
      point(xc - y, yc + x);
      point(xc - y, yc - x);
      point(xc + y, yc - x);      
      
      y++;
      erro += yChange;
      yChange += 2;
      
      if(2*erro + xChange > 0){
        x--;
        erro += xChange;
        xChange += 2;
      }   
    }

  //  if (figuraEscolhida == 0) {
  //    //FOR ABAIXO DESENHA UMA CIRCUNFERENCIA
  //    for (; flag < 2; teta = teta+0.5) {
  //      xaxis = R*cos(teta);
  //      yaxis = R*sin(teta);
  //      if (xaxis == R) {
  //        flag++;
  //      }
  //      stroke(255, 0, 0);
  //      point(xaxis + x, yaxis + y);
  //    } 
  //  for(int xi = xc; xi <= )
  //  if(di == 0){
  //    //escolhe ponto B
  //  }  
  //  else if(di < 0){
  //    int delta1 = mh - md;
  //    if(delta1 <= 0){
  //      //escolhe ponto A
  //    }  
  //    else {
  //      //escolhe ponto B
  //    }  
  //  }
  //  else {
  //    int delta2 = mh - md;
  //    if(delta2 <= 0){
  //      //escolhe ponto B
  //    }  
  //    else {
  //      //escolhe ponto C
  //    }  
  //  }  
  }
}
