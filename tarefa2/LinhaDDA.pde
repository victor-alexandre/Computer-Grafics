public class LinhaDDA{

  LinhaDDA(int xi, int xf, int yi, int yf, int R, int G, int B){
    int dx = xf - xi;
    int dy = yf - yi;
    int steps;
    float incX;
    float incY;
    float x = xi;
    float y = yi;

    if(abs(dx) > abs(dy)){
      steps = abs(dx);  
    }  else{
      steps = abs(dy);
    }
    incX = dx/float(steps);
    incY = dy/float(steps);
    
    for(int i = 0; i <= steps; i++){
      stroke(R,G,B);      
      point(x, y);
      x += incX;
      y += incY;
    }      
  }
}
