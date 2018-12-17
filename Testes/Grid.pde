public class Grid{
    int [][]points = {{width/2,height/2,0}, {width,height/2,0}, {0,height/2,0}, {width/2,height,0}, {width/2,0,0} };
    float URx = 0, URy = 0, URz = 0;//INCREMENTOS PARA A ROTAÇÃO DO UNIVERSO
    
    float [][]MU = matrizIdentidade();
    
    void updateGrid(float urx, float ury, float urz){
        this.URx += urx;
        this.URy += ury;
        this.URz += urz;
                       
        int x1 = points[1][0], y1= points[1][1], x2 = points[2][0], y2 = points[2][1], x3 = points[3][0], y3 = points[3][1], x4 = points[4][0], y4 = points[4][1];
       
        UrotacionarX(); 
        UrotacionarY();
        UrotacionarZ();
        float tempx1 = (x1*MU[0][0] + y1*MU[1][0]);
        float tempy1 = (x1*MU[0][1] + y1*MU[1][1]);
        
        float tempx2 = (x2*MU[0][0] + y2*MU[1][0]);
        float tempy2 = (x2*MU[0][1] + y2*MU[1][1]);        
        
        float tempx3 = (x3*MU[0][0] + y3*MU[1][0]);
        float tempy3 = (x3*MU[0][1] + y3*MU[1][1]);
        
        float tempx4 = (x4*MU[0][0] + y4*MU[1][0]);
        float tempy4 = (x4*MU[0][1] + y4*MU[1][1]); 
        
        line(tempx1, tempy1, tempx2, tempy2);
        line(tempx3, tempy3, tempx4, tempy4);
        float [][]MU = matrizIdentidade();
    }
    
    void UrotacionarX(){MU = multiplicaMatriz3X3(MU, matrizRotacaoX(URx));}
    void UrotacionarY(){MU = multiplicaMatriz3X3(MU, matrizRotacaoY(URy));}
    void UrotacionarZ(){MU = multiplicaMatriz3X3(MU, matrizRotacaoZ(URz));} 
    
    float [][] matrizIdentidade(){
        float m[][] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};
        return m;
    }
    
    float [][] multiplicaMatriz3X3(float [][]a, float [][]b){
        float [][]resultado = new float [3][3];
               
        resultado[0][0] = a[0][0]*b[0][0] + a[0][1]*b[1][0] + a[0][2]*b[2][0];
        resultado[0][1] = a[0][0]*b[0][1] + a[0][1]*b[1][1] + a[0][2]*b[2][1];
        resultado[0][2] = a[0][0]*b[0][2] + a[0][1]*b[1][2] + a[0][2]*b[2][2];
        
        resultado[1][0] = a[1][0]*b[0][0] + a[1][1]*b[1][0] + a[1][2]*b[2][0];
        resultado[1][1] = a[1][0]*b[0][1] + a[1][1]*b[1][1] + a[1][2]*b[2][1];
        resultado[1][2] = a[1][0]*b[0][2] + a[1][1]*b[1][2] + a[1][2]*b[2][2];
        
        resultado[2][0] = a[2][0]*b[0][0] + a[2][1]*b[1][0] + a[2][2]*b[2][0];
        resultado[2][1] = a[2][0]*b[0][1] + a[2][1]*b[1][1] + a[2][2]*b[2][1];
        resultado[2][2] = a[2][0]*b[0][2] + a[2][1]*b[1][2] + a[2][2]*b[2][2];      
    
        return resultado;
    }  
    
    
    float [][]matrizRotacaoZ(float Rz){
        float [][]m = {{cos(Rz), sin(Rz), 0}, {-sin(Rz), cos(Rz), 0}, {0, 0, 1}};
        return m;
    
    }
 
    float [][]matrizRotacaoX(float Rx){
        float [][]m = {{1, 0, 0}, {0, cos(Rx), sin(Rx)}, {0, -sin(Rx), cos(Rx)} };
        return m;
    
    }    
 
    float [][]matrizRotacaoY(float Ry){
        float [][]m = {{cos(Ry), 0, -sin(Ry)}, {0, 1, 0}, {sin(Ry), 0, cos(Ry)} };
        return m;
    
    }   

}
