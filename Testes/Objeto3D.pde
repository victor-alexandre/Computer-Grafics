public class Objeto3D{
    int [][]P;
    int [][]L;
    int [][]info;
    int maxProfundidade;
    int maxAltura;
    
    String nomeObjeto;
    
    int projecao; 
    
    int troncoR = (int)random(51,153);
    int troncoG = (int)random(76,25);
    int troncoB = (int)random(0,0);
    
    int galhoR = (int)random(204,255);
    int galhoG = (int)random(102,204);
    int galhoB = (int)random(0,51);
    
    int folhaR = (int)random(0,102);
    int folhaG = (int)random(153,255);
    int folhaB = (int)random(0,100);
    
    //int xcentro = 0;
    //int ycentro = 0;
    //int zcentro = 0;
    
    int VTx, VTy, VTz;//VALORES PARA A TRANSLAÇÃO
    float VRx , VRy , VRz;//VALORES PARA A ROTAÇÃO
    float VSx, VSy, VSz;//VALORES PARA A ESCALA
    
    float EscalaProporcionalAoUniverso;
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
        
        if(this.Y_universo/(height*1.0) <= this.X_universo/(width*1.0))this.EscalaProporcionalAoUniverso = this.VSx = this.VSy = this.VSz = this.Y_universo/(height*1.0);
        else this.EscalaProporcionalAoUniverso = this.VSx = this.VSy = this.VSz = this.X_universo/(width*1.0);
                      
        //calculaCentro();println(xcentro+" " + ycentro + " " +zcentro);
        this.transformacoes = new TransV2(VTx, VTy, VTz, VRx, VRy, VRz, VSx, VSy, VSz); 
        projecao = 0;
    }
    
    void ObjectSetInfo(int [][]info, int maxProfundidade, int maxAltura){
        this.info = info;
        this.maxProfundidade = maxProfundidade;
        this.maxAltura = maxAltura;
        //println(this.maxAltura);
    }
    
    void desenhaObjeto3D(boolean isSelected){         
        int [][] Pontos = transformacoes.aplicarTransformacao(this.P);
        if(isSelected){
            
            for(int rows = 0; rows < L.length; rows++){
                int xi = Pontos[L[rows][0]][0];
                int yi = Pontos[L[rows][0]][1]; 
                int xf = Pontos[L[rows][1]][0];
                int yf = Pontos[L[rows][1]][1]; 
                
                float espessura;
                
                if(this.info[L[rows][0]][0] == 0){
                    if(rows % 10 <= 8)stroke(folhaR,folhaG,folhaB);            
                    else stroke(255,255,0);//flor                   
                    espessura = 5;
                    strokeWeight(espessura); 
                    line(xi, yi, xf, yf);
                }
               
                else{                    
                    espessura = map(this.info[L[rows][0]][1], 1, this.maxProfundidade, 1.5 + maxAltura/60, 1);
                    //float espessura =  (float)(Math.pow(1,-this.info[L[rows][0]][1] ) * 10 );
                    
                    //LinhaDDA temp = new LinhaDDA(xi, yi, xf, yf, color(0,255,0));
                    strokeWeight(espessura);

                    //else if(this.info[L[rows][0]][0] <= 5)stroke(galhoR,galhoG,galhoB);
                    stroke(troncoR,troncoG,troncoB);
                    line(xi, yi, xf, yf);
                }
            }
        }
        //else{
        //    for(int rows = 0; rows < L.length; rows++){
        //        int xi = Pontos[L[rows][0]][0];
        //        int yi = Pontos[L[rows][0]][1]; 
        //        int xf = Pontos[L[rows][1]][0];
        //        int yf = Pontos[L[rows][1]][1];
                
        //        //LinhaDDA temp = new LinhaDDA(xi, yi, xf, yf, color(255,0,0)); 
        //        stroke(R,G,B);
        //        line(xi, yi, xf, yf);
        //    }
        //}
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
    
    void objectReset(){
        this.VTx = 0;
        this.VTy = 0;
        this.VTz = 0;
        
        this.VRx = 0;
        this.VRy = 0;
        this.VRz = 0;
        
        
        this.transformacoes.TransV2Reset();
        this.VSz = this.VSy = this.VSx = this.EscalaProporcionalAoUniverso;        
        this.transformacoes.update(this.VTx,this.VTy,this.VTz,this.VRx,this.VRy,this.VRz,this.VSx,this.VSy,this.VSz,this.projecao);
        objectApplyTransformations();
        
    } 
}
