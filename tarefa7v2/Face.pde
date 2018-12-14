public class Face{
    int R,G,B;
    //LISTA DE INDICES DOS PONTOS QUE CONTEM AS FACES
    int []F;
    int Z_medio;
    
    Face(int []F, float R, float G, float B){
        this.F = F;
        this.R = round(R*255);
        this.G = round(G*255);
        this.B = round(B*255);       
    }  
    
    
    void calculaZmedio(int [][]P){
        int Zsum = 0;
        for(int i = 0; i < F.length; i++){
            Zsum += P[F[i]][2];
        }
        this.Z_medio = Zsum/F.length;
    }
    
    void setZmedio(int zmedio){
        this.Z_medio = zmedio;
    }
}
