public class Face{
    float R,G,B;
    //LISTA DE INDICES DOS PONTOS QUE CONTEM AS FACES
    int []F;
    int Z_medio;
    
    Face(int []F, float R, float G, float B){
        this.F = F;
        this.R = R;
        this.G = G;
        this.B = B;       
    }  
    
    
    void calculaZmedio(int [][]P){
        int Zsum = 0;
        for(int i = 0; i < F.length; i++){
            Zsum += P[F[i]][2];
        }
        this.Z_medio = Zsum/F.length;
    }
}
