import java.util.ArrayList;
import java.util.*;
import java.awt.event.KeyEvent;

boolean Universe = true;
PImage imgMENU;
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

float URx , URy , URz;//INCREMENTOS PARA A ROTAÇÃO DO UNIVERSO

int[][] cubo = { {50, -50, -50}, {50, -50, 50}, {-50, -50, 50}, {-50, -50, -50}, {-50, 50, 50}, {-50, 50, -50}, {50, 50, -50}, {50, 50, 50} };
int[][] arestaCubo = { {0, 1}, {1, 2}, {2, 3}, {3, 0}, {7, 4}, {4, 5}, {5, 6}, {6, 7}, {7, 1}, {4, 2}, {5, 3}, {6, 0} };

ArrayList <Objeto3D> ObjectList = new ArrayList();
ArrayList <Objeto3D_Com_Faces> ObjectList_Com_Faces = new ArrayList();

String nomeFigura;
int qtdObjetos_na_figura;
void setup(){
    //PRIMEIRA COISA QUE ESTOU FAZENDO É ADICIONAR O CHÃO DO BANG
    int [][]Floor_Points = {{3*width/8, 0, 2*width/8}, {3*width/8, 0, -2*width/8},
                            {-3*width/8, 0, 2*width/8}, {-3*width/8, 0, -2*width/8}};
    int [][]Floor_Lines = {{0,2}, {2,3}, {3,1}, {1,0}};
    int []Floor_Faces_Points = {0,2,3,1};
    ArrayList <Face> Floor_Faces_Indexes = new ArrayList();
    Floor_Faces_Indexes.add(new Face(Floor_Faces_Points, 124/255.0, 59/255.0, 65/255.0));
    int Floor_X_universo = width;
    int Floor_Y_universo = height;
    //ObjectList_Com_Faces.add(new Objeto3D_Com_Faces(Floor_Points, Floor_Lines, Floor_Faces_Indexes, Floor_X_universo, Floor_Y_universo, "Floor"));
    
    
    
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
    
    URx = 0;
    URy = 0;
    URz = 0;
    
    
    iObject = 0;
    isSelected = 0;
    projecao = 0;
    
    imgMENU = loadImage ("menu.png");
    projection_font = createFont("Meera", 12,true);
   // ObjectList.add(new Objeto3D(cubo, arestaCubo,500,500,500));    
   
    //LEIO OS OBJETOS DO ARQUIVO figure.dat E CONSTRUO OS OBJETOS COM OS DADOS DO ARQUIVO
    String[] lines = loadStrings("teste1.txt");
    int NumeroDePontos = lines.length;
    int Figure_X_universo = width, Figure_Y_universo = height;
    int [][]pontos = new int[NumeroDePontos][3];
    int [][]linhas = new int [NumeroDePontos][2];
    
    for(int i = 0; i < NumeroDePontos; i+=2){
        String []parts = lines[i].split(" ");
        int xi = round(Float.parseFloat(parts[0]));
        int yi = round(Float.parseFloat(parts[1]));
        int zi = round(Float.parseFloat(parts[2]));
        
        parts = lines[i+1].split(" ");
        int xf = round(Float.parseFloat(parts[0]));
        int yf = round(Float.parseFloat(parts[1]));
        int zf = round(Float.parseFloat(parts[2]));
        
        pontos[i][0] = xi;
        pontos[i][1] = yi;
        pontos[i][2] = zi;
       
        pontos[i+1][0] = xf;
        pontos[i+1][1] = yf;
        pontos[i+1][2] = zf;  
        
        int li = i, lf = i+1;
        linhas[i][0]=i;
        linhas[i][1]= i+1;      
    }
    ObjectList.add(new Objeto3D(pontos, linhas, Figure_X_universo, Figure_Y_universo, Figure_X_universo));


}

void draw(){             
    if(menu){
        background(255);
        image(imgMENU,100,0);      
    } //<>//
    
    else{
        background(0);
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
            if(!ObjectList.isEmpty()){
                for(int i = 0; i < ObjectList.size(); i++){
                    ObjectList.get(i).objectUpdate(-3*Tx, -3*Ty, -3*Tz, 0, 0, 0, 3*Sx, 3*Sy, 3*Sz, projecao);
                    ObjectList.get(i).transformacoes.updateUniverse(URx, URy, URz);
                    ObjectList.get(i).desenhaObjeto3D(true);                              
                }
            }
               

            if(isSelected < 0) isSelected = 0;
            if(!ObjectList_Com_Faces.isEmpty()){
                for(int i = 0; i < ObjectList_Com_Faces.size(); i++){
                    ObjectList_Com_Faces.get(i).objectUpdate(-3*Tx, -3*Ty, -3*Tz, 0, 0, 0, 3*Sx, 3*Sy, 3*Sz, projecao);
                    ObjectList_Com_Faces.get(i).transformacoes.updateUniverse(URx, URy, URz);
                }
            }
            reset();
            for(int i = 0; i < ObjectList_Com_Faces.size(); i++){
                if(i == isSelected)ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(false);
                else ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(false);
            }
        }
        else{                   
            if(isSelected < 0) isSelected = 0;
            if(!ObjectList_Com_Faces.isEmpty())ObjectList_Com_Faces.get(isSelected).objectUpdate(Tx, Ty, Tz, Rx, Ry, Rz, Sx, Sy, Sz, projecao);
            reset();
            for(int i = 0; i < ObjectList_Com_Faces.size(); i++){ //<>//
                if(i == isSelected)ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(true);
                else ObjectList_Com_Faces.get(i).desenhaObjeto3Dcolorido(false);
                //ObjectList_Com_Faces.get(i).transformacoes.ResetUniverse();//essa linha é para mim resetar o universo sempre que for trocado a escolha da rotação do objeto ou universo
            } //<>//
        }
    } //<>//
}

//implementação para fazer funcionar a entrada de mais de uma tecla no caso o shift+tab
void keyReleased(){
    if(key == CODED){
        if(keyCode == SHIFT)shiftPressed = false;
    }
} //<>//
void keyPressed(){
    
    if(key == 'F' || key == 'f')FuncaoDoProcessing = !FuncaoDoProcessing;
    if(key == 'U' || key == 'u'){
        Universe = !Universe; 
    }    
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
       if(keyCode == SHIFT)shiftPressed = true;       
   }

     
   
   if(key == TAB){
       // SELECIONA PROXIMO OBJETO DO ARRAYLIST
       if(shiftPressed){
           reset();
           if(isSelected == 0) isSelected = ObjectList_Com_Faces.size();
           isSelected--;
       }
       //SELECIONA OBJETO ANTERIOR DO ARRAYLIST
       else{   
           reset();         
           isSelected++;
           if(isSelected > ObjectList_Com_Faces.size()-1)isSelected %= ObjectList_Com_Faces.size();
       }
   }
    
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
    
    //KEYS PARA ROTACIONAR O UNIVERSO
    if(key == 't' || key == 'T')URy = 0.1; 
    if(key == 'g' || key == 'G')URy = -0.1; 
    if(key == 'b' || key == 'B')URx = 0.1; 
    if(key == 'y' || key == 'Y')URx = -0.1; 
    if(key == 'h' || key == 'H')URz = -0.1; 
    if(key == 'n' || key == 'N')URz = 0.1;  
    
    //Key para controlar qual projeção será aplicada
    if(key == 'p' || key == 'P')projecao++;

    // CRIA CÓPIA DO OBJETO ATUAL
   if(key == 'c' || key == 'C' && !ObjectList_Com_Faces.isEmpty()){
       reset();
       int wasSelected = isSelected;
       ObjectList_Com_Faces.add(new Objeto3D_Com_Faces(ObjectList_Com_Faces.get(isSelected).P, ObjectList_Com_Faces.get(isSelected).L, ObjectList_Com_Faces.get(isSelected).FaceList, ObjectList_Com_Faces.get(isSelected).X_universo,ObjectList_Com_Faces.get(isSelected).Y_universo,ObjectList_Com_Faces.get(isSelected).nomeObjeto));    
       isSelected = ObjectList_Com_Faces.size()-1;
       ObjectList_Com_Faces.get(isSelected).objectSet(ObjectList_Com_Faces.get(wasSelected).VTx, ObjectList_Com_Faces.get(wasSelected).VTy, ObjectList_Com_Faces.get(wasSelected).VTz, ObjectList_Com_Faces.get(wasSelected).VRx, ObjectList_Com_Faces.get(wasSelected).VRy, ObjectList_Com_Faces.get(wasSelected).VRz, ObjectList_Com_Faces.get(wasSelected).VSx, ObjectList_Com_Faces.get(wasSelected).VSy, ObjectList_Com_Faces.get(wasSelected).VSz);      
   }        
    
   // // CRIA NOVA INSTANCIA DE UM CUBO//ATUALIZAR PARA ADICINAR UM NOVO OBJETO DO TIPO OBJETO3D_COM_FACES
   //if(key == '+'){
   //    reset();
   //    ObjectList_Com_Faces.add(new Objeto3D_Com_Faces(cubo, arestaCubo,500,500,500));    
   //    isSelected = ObjectList.size()-1;
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
        URx = 0;
        URy = 0;
        URz = 0;   
    
    
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
