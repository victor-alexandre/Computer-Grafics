import java.util.ArrayList;
import java.util.*;
import java.awt.event.KeyEvent;

boolean Universe = false;
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
    size(900,700);
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
    String[] lines = loadStrings("figure.dat");
    int Figure_X_universo, Figure_Y_universo;
 
    nomeFigura = lines[0];

    qtdObjetos_na_figura = Integer.parseInt(lines[2]);
    println("\nQquantidade de Objetos na figura "+ qtdObjetos_na_figura);
    
    isSelected = qtdObjetos_na_figura-1;
    
    String []parts = lines[1].split(" ");
    Figure_X_universo = abs(Integer.parseInt(parts[0]))+abs(Integer.parseInt(parts[1]));
    Figure_Y_universo = abs(Integer.parseInt(parts[2]))+abs(Integer.parseInt(parts[3]));
    println("\nTAMANHO UNIVERSO X: "+ Figure_X_universo + " Y:" + Figure_Y_universo);

    parts = lines[4].split(" ");
    int contadorLinha = 4;//vou pocisionar esse contador na linha que tras os dados das qtd de pontos linhas e faces
    int qtdpontos = Integer.parseInt(parts[0]);
    int qtdlinhas = Integer.parseInt(parts[1]);
    int qtdfaces  = Integer.parseInt(parts[2]);



    for(int i = 0; i < qtdObjetos_na_figura; i++){
        println("qtdpontos "+qtdpontos+"\nqtdlinhas "+qtdlinhas+ "\nqtdfaces "+ qtdfaces);
        int [][]Figure_Pontos = new int[qtdpontos][3];
        int [][]Figure_Lines = new int[qtdlinhas][2];      
        ArrayList <Face> Figure_Faces = new ArrayList();
        String nomeObjeto = lines[contadorLinha -1];
        println("\n"+nomeObjeto);
        
            
        for(int k = 0, j = contadorLinha+1; j <= contadorLinha+qtdpontos; j++, k++){
            parts = lines[j].split(" ");
            Figure_Pontos[k][0] = Integer.parseInt(parts[0]);
            Figure_Pontos[k][1] = Integer.parseInt(parts[1]);
            Figure_Pontos[k][2] = Integer.parseInt(parts[2]);
            println("\nlinhas dos pontos "+Figure_Pontos[k][0]+ " " + Figure_Pontos[k][1] +" " + Figure_Pontos[k][2]);
        }
        
        for(int k = 0, j = contadorLinha+qtdpontos+1; j <= contadorLinha+qtdpontos+qtdlinhas; j++, k++){
            parts = lines[j].split(" ");
            Figure_Lines[k][0] = Integer.parseInt(parts[0])-1;
            Figure_Lines[k][1] = Integer.parseInt(parts[1])-1;
            println("\nlinhas das linhas "+Figure_Lines[k][0]+" " + Figure_Lines[k][1]);
        }       
        
        for(int k = 0, j = contadorLinha+qtdpontos+qtdlinhas+1; j <= contadorLinha+qtdpontos+qtdlinhas+qtdfaces; j++, k++){             
            parts = lines[j].split(" ");
            println("linhas das faces ");
            int NumeroDePontosDaFace = Integer.parseInt(parts[0]);
            int []Figure_Face_Points = new int[NumeroDePontosDaFace];
            float R,G,B;
            for(int m = 1; m <= NumeroDePontosDaFace; m++){
                //É m-1 PQ A POSIÇÃO 0 CONTEM O NUMERO QUE DEFINE O "NumeroDePontosDaFace" 
                Figure_Face_Points[m-1] = Integer.parseInt(parts[m])-1;//e há esse -1 no final pq os indices do arquivo começam em 1 e não em 0            
                println(Figure_Face_Points[m-1]+" ");
            }

            R = Float.parseFloat(parts[NumeroDePontosDaFace+1]); 
            G = Float.parseFloat(parts[NumeroDePontosDaFace+2]);
            B = Float.parseFloat(parts[NumeroDePontosDaFace+3]);
            println(R + " " + G + " " + B);
            Figure_Faces.add(new Face(Figure_Face_Points, R,G,B));
        } 
        ObjectList_Com_Faces.add(new Objeto3D_Com_Faces(Figure_Pontos, Figure_Lines, Figure_Faces, Figure_X_universo, Figure_Y_universo, nomeObjeto));        
        
        parts = lines[contadorLinha+qtdpontos+qtdlinhas+qtdfaces+1].split(" ");        
        int VRx = Integer.parseInt(parts[0]); int VRy = Integer.parseInt(parts[1]); int VRz = Integer.parseInt(parts[2]);//VALORES PARA A ROTAÇÃO 
        println("\nlinhas das rotações "+ " " + VRx + " "+ VRy +" " + VRz);
 
        parts = lines[contadorLinha+qtdpontos+qtdlinhas+qtdfaces+2].split(" ");    
        int VSx = Integer.parseInt(parts[0]); int VSy = Integer.parseInt(parts[1]); int VSz = Integer.parseInt(parts[2]);//VALORES PARA A ESCALA      
        println("\nlinhas das escalas "+ " " + VSx + " "+ VSy +" " + VSz); 
        
        parts = lines[contadorLinha+qtdpontos+qtdlinhas+qtdfaces+3].split(" ");         
        int VTx = Integer.parseInt(parts[0]); int VTy = Integer.parseInt(parts[1]); int VTz = Integer.parseInt(parts[2]);//VALORES PARA A TRANSLAÇÃO       
        println("\nlinhas das translações "+ " " + VSx + " "+ VSy +" " + VSz); 
        
        ObjectList_Com_Faces.get(ObjectList_Com_Faces.size()-1).objectUpdate(VTx, VTy, VTz, VRx, VRy, VRz, VSx, VSy, VSz,0);
        
        if(qtdpontos+qtdlinhas+qtdfaces+4+contadorLinha < lines.length){
            contadorLinha = qtdpontos+qtdlinhas+qtdfaces+5+contadorLinha;
            println("\nContadorLinha "+contadorLinha+"   qtdPontos "+qtdpontos+"   qtdlinhas "+qtdlinhas+"   qtdFaces "+qtdpontos + "   +5\n");
            parts = lines[contadorLinha].split(" ");
            qtdpontos = Integer.parseInt(parts[0]);
            qtdlinhas = Integer.parseInt(parts[1]);
            qtdfaces  = Integer.parseInt(parts[2]);                   
        }
    }
    //for(int i = 0; i < ObjectList_Com_Faces.get(0).FaceList.size(); i++){
    //    for(int j = 0; j < ObjectList_Com_Faces.get(0).FaceList.get(i).F.length; j++){
    //        println(ObjectList_Com_Faces.get(0).FaceList.get(i).F[j]);
    //    }
    //}
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
            if(isSelected < 0) isSelected = 0;
            if(!ObjectList_Com_Faces.isEmpty()){
                for(int i = 0; i < ObjectList_Com_Faces.size(); i++){
                    ObjectList_Com_Faces.get(i).objectUpdate(-Tx, -Ty, -Tz, 0, 0, 0, 3*Sx, 3*Sy, 3*Sz, projecao);
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
