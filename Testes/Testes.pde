import java.util.ArrayList;
import java.util.*;
import java.awt.event.KeyEvent;

String PATH = "/home/accelerator/Documents/4 semestre/computaçãografica/trees/models";

boolean Universe = true;
PImage imgMENU;
PImage imgBackground;
boolean menu = true;
boolean shiftPressed = false;
boolean FuncaoDoProcessing = true;

int iObject; 
int isSelected;
PFont projection_font;

int projecao;

int Tx, Ty, Tz;//INCREMENTOS PARA A TRANSLAÇÃO
float Rx , Ry , Rz;//INCREMENTOS PARA A ROTAÇÃO
float Sx, Sy, Sz;//INCREMENTOS PARA A ESCALA

//float URx , URy , URz;//INCREMENTOS PARA A ROTAÇÃO DO UNIVERSO

int[][] cubo = { {50, -50, -50}, {50, -50, 50}, {-50, -50, 50}, {-50, -50, -50}, {-50, 50, 50}, {-50, 50, -50}, {50, 50, -50}, {50, 50, 50} };
int[][] arestaCubo = { {0, 1}, {1, 2}, {2, 3}, {3, 0}, {7, 4}, {4, 5}, {5, 6}, {6, 7}, {7, 1}, {4, 2}, {5, 3}, {6, 0} };

ArrayList <Objeto3D> ObjectList = new ArrayList();
ArrayList <Objeto3D_Com_Faces> ObjectList_Com_Faces = new ArrayList();

String nomeFigura;
int qtdObjetos_na_figura;


int NumeroDeArquivos = new File(PATH).list().length;


void setup(){
    //PRIMEIRA COISA QUE ESTOU FAZENDO É ADICIONAR O CHÃO DA FLORESTA
    int [][]Floor_Points = {{3*width/8, 0, 2*width/8}, {3*width/8, 0, -2*width/8},
                            {-3*width/8, 0, 2*width/8}, {-3*width/8, 0, -2*width/8}};

    int [][]Floor_Lines = {{0,2}, {2,3}, {3,1}, {1,0}};
    int []Floor_Faces_Points = {0,2,3,1};
    ArrayList <Face> Floor_Faces_Indexes = new ArrayList();
    Floor_Faces_Indexes.add(new Face(Floor_Faces_Points, 255, 204, 153));
    int Floor_X_universo = width;
    int Floor_Y_universo = height;
    ObjectList_Com_Faces.add(new Objeto3D_Com_Faces(Floor_Points, Floor_Lines, Floor_Faces_Indexes, Floor_X_universo, Floor_Y_universo, "Floor"));
    

    
    fullScreen();
    background(0); 
    Rx = 0;
    Ry = 0;
    Rz = 0;
    
    Tx = 0;
    Ty = 0;
    Tz = 0;
    
    Sx = 0;
    Sy = 0;
    Sz = 0;

    
    iObject = 0;
    isSelected = 0;
    projecao = 0;
    
    imgBackground = loadImage("ceu.jpeg");
    imgMENU = loadImage ("menu.png");
    projection_font = createFont("Meera", 12,true);

      

    IntList random_X;
    IntList random_Z;
    IntList random_Files;
    //Z RANGE = 680
    //X RANGE = 1020
    
    println("xmax: " + 3*width/8 + "   xmin : "  + -3*width/8 + "     zmax: " + 2*width/8 + "   zmin : "  + -2*width/8 ); 

    //int NumeroDeArquivos1 = new File("/home/accelerator/Documents/4 semestre/computaçãografica/lsystem_trees/trees/models/grass").list().length;

    ////LEIO todos os modelos da pasta.
    //for(int k = 0; k < NumeroDeArquivos1; k++){

        
        
    //    String pad = "";
    //    if(k<10) pad = "00";
    //    if(k>=10) pad = "0";
    //    if(k>=100) pad = "";
    //    String[] lines = loadStrings("/home/accelerator/Documents/4 semestre/computaçãografica/lsystem_trees/trees/models/grass/"+ "grass"+pad+k+".txt");
    //    int NumeroDePontos = lines.length;
    //    int Figure_X_universo = width, Figure_Y_universo = height;
    //    int [][]pontos = new int[NumeroDePontos][3];
    //    int [][]info = new int[NumeroDePontos][2];
    //    int [][]linhas = new int [NumeroDePontos][2];
    //    int maxProfundidade = 1;
    //    int maxAltura = 0;
        

    //    int  translacaoX = (int)random(-3*width/8, 3*width/8);
    //    int  translacaoZ = (int)random(-2*width/8, 2*width/8);

           
    //   // println("random x: " + translacaoX + "     random z: " + translacaoZ);
    //    for(int i = 0; i < NumeroDePontos; i+=2){
    //        String []parts = lines[i].split(" ");
    //        int xi = round(Float.parseFloat(parts[0]));
    //        int yi = round(Float.parseFloat(parts[1]));
    //        int zi = round(Float.parseFloat(parts[2]));
    //        int nivel = round(Float.parseFloat(parts[3]));
    //        int stroke_weight = round(Float.parseFloat(parts[4]));   
            

            
    //        parts = lines[i+1].split(" ");
    //        int xf = round(Float.parseFloat(parts[0]));
    //        int yf = round(Float.parseFloat(parts[1]));
    //        int zf = round(Float.parseFloat(parts[2]));
            
    //        if(maxAltura < yi)maxAltura = yi;
    //        if(maxAltura < yf)maxAltura = yf;
            
    //        int nivel1 = round(Float.parseFloat(parts[3]));
    //        int stroke_weight1 = round(Float.parseFloat(parts[4]));    
            
    //        pontos[i][0] = xi + translacaoX;
    //        pontos[i][1] = yi;
    //        pontos[i][2] = zi + translacaoZ;
    //        info[i][0] = nivel;
    //        info[i][1] = stroke_weight;
    //        if(maxProfundidade < stroke_weight) maxProfundidade = stroke_weight;
            
    //        pontos[i+1][0] = xf + translacaoX;
    //        pontos[i+1][1] = yf;
    //        pontos[i+1][2] = zf + translacaoZ;
    //        info[i+1][0] = nivel1;
    //        info[i+1][1] = stroke_weight1;
    //        if(maxProfundidade < stroke_weight1) maxProfundidade = stroke_weight1;
            
    //        linhas[i][0]=i;
    //        linhas[i][1]= i+1;                 
    //    }
    //    ObjectList.add(new Objeto3D(pontos, linhas, Figure_X_universo, Figure_Y_universo, Figure_X_universo));
    //    ObjectList.get(ObjectList.size()-1).ObjectSetInfo(info, maxProfundidade, maxAltura);
    //}
    
    
    
    
    
    int [][]random_points = new int[NumeroDeArquivos][2];    
    //LEIO todos os modelos da pasta.
    for(int k = 0; k < NumeroDeArquivos; k++){      
        String pad = "";
        if(k<10) pad = "00";
        if(k>=10) pad = "0";
        if(k>=100) pad = "";
        String[] lines = loadStrings(PATH+ "/"+"tree"+pad+k+".txt");
        int NumeroDePontos = lines.length;
        int Figure_X_universo = width, Figure_Y_universo = height;
        int [][]pontos = new int[NumeroDePontos][3];
        int [][]info = new int[NumeroDePontos][2];
        int [][]linhas = new int [NumeroDePontos][2];
        int maxProfundidade = 1;
        int maxAltura = 0;
        

        int  translacaoX = (int)random(-3*width/8, 3*width/8);
        int  translacaoZ = (int)random(-2*width/8, 2*width/8);
        while(verifica_sorteio(random_points,translacaoX,translacaoZ)){
            translacaoX = (int)random(-3*width/8, 3*width/8);
            translacaoZ = (int)random(-2*width/8, 2*width/8);
        }
            
       // println("random x: " + translacaoX + "     random z: " + translacaoZ);
        for(int i = 0; i < NumeroDePontos; i+=2){
            String []parts = lines[i].split(" ");
            int xi = round(Float.parseFloat(parts[0]));
            int yi = round(Float.parseFloat(parts[1]));
            int zi = round(Float.parseFloat(parts[2]));
            int nivel = round(Float.parseFloat(parts[3]));
            int stroke_weight = round(Float.parseFloat(parts[4]));            
            
            parts = lines[i+1].split(" ");
            int xf = round(Float.parseFloat(parts[0]));
            int yf = round(Float.parseFloat(parts[1]));
            int zf = round(Float.parseFloat(parts[2]));

            if(maxAltura < yi)maxAltura = yi;
            if(maxAltura < yf)maxAltura = yf;
            
            int nivel1 = round(Float.parseFloat(parts[3]));
            int stroke_weight1 = round(Float.parseFloat(parts[4]));    
            
            pontos[i][0] = xi + translacaoX;
            pontos[i][1] = yi;
            pontos[i][2] = zi + translacaoZ;
            info[i][0] = nivel;
            info[i][1] = stroke_weight;
            if(maxProfundidade < stroke_weight) maxProfundidade = stroke_weight;
            
            pontos[i+1][0] = xf + translacaoX;
            pontos[i+1][1] = yf;
            pontos[i+1][2] = zf + translacaoZ;
            info[i+1][0] = nivel1;
            info[i+1][1] = stroke_weight1;
            if(maxProfundidade < stroke_weight1) maxProfundidade = stroke_weight1;
            
            linhas[i][0]=i;
            linhas[i][1]= i+1;                 
        }
        ObjectList.add(new Objeto3D(pontos, linhas, Figure_X_universo, Figure_Y_universo, Figure_X_universo));
        //println(maxAltura);
        ObjectList.get(ObjectList.size()-1).ObjectSetInfo(info, maxProfundidade, maxAltura);
    }
}

void draw(){             
    if(menu){
        background(255);
        image(imgMENU,width/4,0);      
    } //<>//
    
    else{
        

        background(0);
        image(imgBackground,0,0,width,height);
        textFont(projection_font,25);
        String projection_name = "Projeção: ";
        if(projecao % 5 == 0)projection_name = projection_name + "Cavaleira";
        else if(projecao % 5 == 1)projection_name = projection_name + "Cabinet";
        else if(projecao % 5 == 2)projection_name = projection_name + "Isométrica";
        else if(projecao % 5 == 3)projection_name = projection_name + "Ponto de fuga em Z";
        else if(projecao % 5 == 4)projection_name = projection_name + "Ponto de fuga em X e Z";

        fill(255);
        text(projection_name, 3.9*width/6, 25);
        
        
        if(Universe){
            fill(255);
            text("Universo", 50,25);   

            if(isSelected < 0) isSelected = 0;
            if(!ObjectList_Com_Faces.isEmpty()){
                for(int i = 0; i < ObjectList_Com_Faces.size(); i++){
                    ObjectList_Com_Faces.get(i).objectUpdate(-6*Tx, -6*Ty, -6*Tz, 0, 0, 0, 3*Sx, 3*Sy, 3*Sz, projecao);
                    ObjectList_Com_Faces.get(i).transformacoes.updateUniverse(Rx, Ry, Rz);
                }
            }
            
            if(!ObjectList.isEmpty()){
                for(int i = 0; i < ObjectList.size(); i++){
                    ObjectList.get(i).transformacoes.updateUniverse(Rx, Ry, Rz);
                    ObjectList.get(i).objectUpdate(-6*Tx, -6*Ty, -6*Tz, 0, 0, 0, 3*Sx, 3*Sy, 3*Sz, projecao);                                                
                }
            }
            reset();
            
            for(int i = 0; i < ObjectList_Com_Faces.size(); i++){
                ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(false);
            }
            
            //Aqui eu desenho as arvores por ultimo
            //for(int i = 0; i < 20; i++){
            //    ObjectList.get(i).desenhaObjeto3D(true); 
            //} 

              for(int i = 0; i < NumeroDeArquivos; i++){
                ObjectList.get(i).desenhaObjeto3D(true); 
            } 
          

            
        }
        //else{ 
                       
        //    if(isSelected < 0) isSelected = 0;
        //    if(!ObjectList_Com_Faces.isEmpty())ObjectList_Com_Faces.get(isSelected).objectUpdate(Tx, Ty, Tz, Rx, Ry, Rz, Sx, Sy, Sz, projecao);
        //    if(!ObjectList.isEmpty()){
        //        for(int i = 0; i < ObjectList.size(); i++){
        //            ObjectList.get(i).objectUpdate(Tx, Ty, Tz, Rx, Ry, Rz, Sx, Sy, Sz, projecao);
        //            ObjectList.get(i).desenhaObjeto3D(true);                              
        //        }
        //    }
        //    reset();
        //    for(int i = 0; i < ObjectList_Com_Faces.size(); i++){ //<>//
        //        if(i == isSelected)ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(true);
        //        else ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(false);
        //        //ObjectList_Com_Faces.get(i).transformacoes.ResetUniverse();//essa linha é para mim resetar o universo sempre que for trocado a escolha da rotação do objeto ou universo
        //    } //<>//
        //}
    } //<>//
}

//implementação para fazer funcionar a entrada de mais de uma tecla no caso o shift+tab
//void keyReleased(){
//    if(key == CODED){
//        if(keyCode == SHIFT)shiftPressed = false;
//    }
//} //<>//
void keyPressed(){
    if(key == 'R' || key == 'r')ResetAll();
    
    //COMENTEI AS FUNÇÕES ABAIXO PARA ELAS NUNCA SEREM ALTERADAS E SEMPRE FICAREM ATIVAS
    //if(key == 'F' || key == 'f')FuncaoDoProcessing = !FuncaoDoProcessing;
    //if(key == 'U' || key == 'u'){
    //    Universe = !Universe; 
    //}    
    
    
    
    //KEYS PARA TRANSLADAR //<>//
    if(key == '1')Tz=-5;
    if(key == '2')Tz=5;
    if(key == CODED){
        if(keyCode == UP)Ty=5;
        if(keyCode == DOWN)Ty=-5;
        if(keyCode == LEFT)Tx=-5;
        if(keyCode == RIGHT)Tx=5;
         
        //Key DO MENU
        if (keyCode == KeyEvent.VK_F1)menu = !menu;   

       //PERMITE QUE EU USE A FUNÇÃO DA TECLA SHIT + TAB   
       //if(keyCode == SHIFT)shiftPressed = true;       
   }

     
   
   //if(key == TAB){
   //    // SELECIONA PROXIMO OBJETO DO ARRAYLIST
   //    if(shiftPressed){
   //        reset();
   //        if(isSelected == 0) isSelected = ObjectList_Com_Faces.size();
   //        isSelected--;
   //    }
   //    //SELECIONA OBJETO ANTERIOR DO ARRAYLIST
   //    else{   
   //        reset();         
   //        isSelected++;
   //        if(isSelected > ObjectList_Com_Faces.size()-1)isSelected %= ObjectList_Com_Faces.size();
   //    }
   //}
    
    //KEYS PARA REESCALAR OS EIXOS INDIVIDUALMENTE
    if(key == 'w' || key == 'W')Sy = 0.2; 
    if(key == 's' || key == 'S')Sy = -0.2; 
    if(key == 'd' || key == 'D')Sx = 0.2; 
    if(key == 'a' || key == 'A')Sx = -0.2; 
    if(key == 'e' || key == 'E' )Sz = 0.2; 
    if(key == 'q' || key == 'Q')Sz = -0.2;     
    //KEYS PARA REESCALAR PROPORCIALNALMENTE TODAS AS COORDENADAS
    if(key == '4'){
        Sx = -0.2;
        Sy = -0.2;
        Sz = -0.2;    
    }
    if(key == '5'){
        Sx = 0.2;
        Sy = 0.2;
        Sz = 0.2;    
    }

    //KEYS PARA ROTACIONAR
    if(key == 'i' || key == 'I')Ry = 0.1; 
    if(key == 'k' || key == 'K')Ry = -0.1; 
    if(key == 'l' || key == 'L')Rx = 0.1; 
    if(key == 'j' || key == 'J')Rx = -0.1; 
    if(key == '7')Rz = -0.1; 
    if(key == '8')Rz = 0.1;  
    
    ////KEYS PARA ROTACIONAR O UNIVERSO
    //if(key == 't' || key == 'T')URy = 0.1; 
    //if(key == 'g' || key == 'G')URy = -0.1; 
    //if(key == 'b' || key == 'B')URx = 0.1; 
    //if(key == 'y' || key == 'Y')URx = -0.1; 
    //if(key == 'h' || key == 'H')URz = -0.1; 
    //if(key == 'n' || key == 'N')URz = 0.1;  
    
    //Key para controlar qual projeção será aplicada
    if(key == 'p' || key == 'P'){projecao++; if(projecao % 5 == 3)  Tz += 220; if(projecao % 5 == 0)  Tz -= 220;}

   // // CRIA CÓPIA DO OBJETO ATUAL
   //if(key == 'c' || key == 'C' && !ObjectList_Com_Faces.isEmpty()){
   //    reset();
   //    int wasSelected = isSelected;
   //    ObjectList_Com_Faces.add(new Objeto3D_Com_Faces(ObjectList_Com_Faces.get(isSelected).P, ObjectList_Com_Faces.get(isSelected).L, ObjectList_Com_Faces.get(isSelected).FaceList, ObjectList_Com_Faces.get(isSelected).X_universo,ObjectList_Com_Faces.get(isSelected).Y_universo,ObjectList_Com_Faces.get(isSelected).nomeObjeto));    
   //    isSelected = ObjectList_Com_Faces.size()-1;
   //    ObjectList_Com_Faces.get(isSelected).objectSet(ObjectList_Com_Faces.get(wasSelected).VTx, ObjectList_Com_Faces.get(wasSelected).VTy, ObjectList_Com_Faces.get(wasSelected).VTz, ObjectList_Com_Faces.get(wasSelected).VRx, ObjectList_Com_Faces.get(wasSelected).VRy, ObjectList_Com_Faces.get(wasSelected).VRz, ObjectList_Com_Faces.get(wasSelected).VSx, ObjectList_Com_Faces.get(wasSelected).VSy, ObjectList_Com_Faces.get(wasSelected).VSz);      
   //}        
    
   
   // DESTROI INSTANCIA DO OBJETO
   if(key == '-'  && ObjectList_Com_Faces.size() > 0){
       reset();
       ObjectList_Com_Faces.remove(isSelected); 
       if(ObjectList.size() > 0)isSelected--;
       if(ObjectList.size() == 0)isSelected = 0;
       
   }
}

//FUNÇÃO PRA RESETAR OS PARAMETROS DE TRANSLAÇÃO, ROTACÃO E ESCALA
void reset(){        
    Rx = 0;
    Ry = 0;
    Rz = 0;
           
    Tx = 0;
    Ty = 0;
    Tz = 0;
    
    Sx = 0;
    Sy = 0;
    Sz = 0;
}

void ResetAll(){
    reset();
    projecao = 0;
    if(!ObjectList.isEmpty()){
        for(int i = 0; i < ObjectList.size(); i++)ObjectList.get(i).objectReset();
    }
   if(!ObjectList_Com_Faces.isEmpty()){
        for(int i = 0; i < ObjectList_Com_Faces.size(); i++)ObjectList_Com_Faces.get(i).objectReset();
    }    
}

boolean verifica_sorteio(int [][]random_points, int new_x, int new_z){
    for(int i = 0; i < random_points.length; i++){
        if(random_points[i][0]== new_x && random_points[i][1] == new_z)return true;
    }
    return false;
}

boolean verifica_sorteio2(int []random_values, int new_value){
    for(int i = 0; i < random_values.length; i++){
        if(random_values[i]== new_value)return true;
    }
    return false;
}
