public class Objeto3D{
    int [][]P;
    int [][]L;
    
    String nomeObjeto;
    
    int projecao; 
    
    int R = (int)random(0,150);
    int G = (int)random(80,255);
    int B = (int)random(0,100);
    
    //int xcentro = 0;
    //int ycentro = 0;
    //int zcentro = 0;
    
    int VTx, VTy, VTz;//VALORES PARA A TRANSLAÇÃO
    float VRx , VRy , VRz;//VALORES PARA A ROTAÇÃO
    float VSx, VSy, VSz;//VALORES PARA A ESCALA
    
    int X_universo, Y_universo, Z_universo;

    TransV2 transformacoes;
    
    Objeto3D(int [][]P, int [][]L, int X_universo, int Y_universo, int Z_universo){
        this.P = P;
        this.L = L;       
      
        this.VTx = this.VTy = this.VTz = 0;
        this.VRx = this.VRy = this.VRz = 0;
        //this.VSx = this.VSy = this.VSz = 1;
       
        //Nessa linha eu seto o tamanho do universo, nas proximas tarefas deverei pegar esses valores no momento de criação do objeto
        this.X_universo = X_universo;
        this.Y_universo = Y_universo;
        this.Z_universo = Z_universo;
        
        if(this.Y_universo/(height*1.0) <= this.X_universo/(width*1.0))this.VSx = this.VSy = this.VSz = this.Y_universo/(height*1.0);
        else this.VSx = this.VSy = this.VSz = this.X_universo/(width*1.0);
                      
        //calculaCentro();println(xcentro+" " + ycentro + " " +zcentro);
        this.transformacoes = new TransV2(VTx, VTy, VTz, VRx, VRy, VRz, VSx, VSy, VSz); 
        projecao = 0;
    }
    
    void desenhaObjeto3D(boolean isSelected){         
        int [][] Pontos = transformacoes.aplicarTransformacao(this.P);
        if(isSelected){
            
            for(int rows = 0; rows < L.length; rows++){
                int xi = Pontos[L[rows][0]][0];
                int yi = Pontos[L[rows][0]][1]; 
                int xf = Pontos[L[rows][1]][0];
                int yf = Pontos[L[rows][1]][1];
                
                //LinhaDDA temp = new LinhaDDA(xi, yi, xf, yf, color(0,255,0));

                stroke(R,G,B);
                line(xi, yi, xf, yf);
            }
        }
        else{
            for(int rows = 0; rows < L.length; rows++){
                int xi = Pontos[L[rows][0]][0];
                int yi = Pontos[L[rows][0]][1]; 
                int xf = Pontos[L[rows][1]][0];
                int yf = Pontos[L[rows][1]][1];
                
                //LinhaDDA temp = new LinhaDDA(xi, yi, xf, yf, color(255,0,0)); 
                stroke(255,0,0);
                line(xi, yi, xf, yf);
            }
        }
    } 
    
    void objectUpdate(int Tx, int Ty, int Tz, float Rx, float Ry, float Rz, float Sx, float Sy, float Sz, int projecao){
        this.VTx += Tx;
        this.VTy += Ty;
        this.VTz += Tz;
        
        this.VRx += Rx;
        this.VRy += Ry;
        this.VRz += Rz;
        
        if(VSx + Sx >= 0)this.VSx += Sx; else this.VSx = 0;
        if(VSy + Sy >= 0)this.VSy += Sy; else this.VSy = 0;
        if(VSz + Sz >= 0)this.VSz += Sz; else this.VSz = 0;
        
        this.projecao = projecao % 5;
        this.transformacoes.update(this.VTx,this.VTy,this.VTz,this.VRx,this.VRy,this.VRz,this.VSx,this.VSy,this.VSz,this.projecao);
        objectApplyTransformations();
    }
    
    void objectSet(int VTx, int VTy, int VTz, float VRx, float VRy, float VRz, float VSx, float VSy, float VSz){
        this.VTx = VTx;
        this.VTy = VTy;
        this.VTz = VTz;
        
        this.VRx = VRx;
        this.VRy = VRy;
        this.VRz = VRz;
        
        if(VSx >= 0)this.VSx = VSx; else this.VSx = 0;
        if(VSy >= 0)this.VSy = VSy; else this.VSy = 0;
        if(VSz >= 0)this.VSz = VSz; else this.VSz = 0;

        this.transformacoes.update(this.VTx,this.VTy,this.VTz,this.VRx,this.VRy,this.VRz,this.VSx,this.VSy,this.VSz,this.projecao);
        objectApplyTransformations();
    }
        
    void objectApplyTransformations(){
        this.transformacoes.rotacionarX();
        this.transformacoes.rotacionarY();
        this.transformacoes.rotacionarZ();
        this.transformacoes.escalar();       
    }
    
    //void calculaCentro(){
    //        for(int i = 0; i < P.length; i++){
    //        xcentro += P[i][0];
    //        ycentro += P[i][1];
    //        zcentro += P[i][2];
    //    }
        
    //    xcentro = xcentro/P.length;
    //    ycentro = ycentro/P.length;
    //    zcentro = zcentro/P.length;     
    //}   
}
