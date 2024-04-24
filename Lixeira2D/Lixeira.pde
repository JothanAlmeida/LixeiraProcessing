import processing.sound.*;
SoundFile sound, ronco;

float olhoYDir=55, olhoYEsq=55, pupilaYEsq=35, pupilaYDir=35, sobrancelhaYEsq=295, sobrancelhaYDir=295, time = 0.0;
float trianguloY1 = 190, trianguloY2 = 230, lixoY = 20, lixoX = 40;
boolean piscaEsq = false, piscaDir = false, dormir = false, tampaAberta;
int posTamp = 0, frame = 0;
int tempoPressionado = 0;

void setup(){
  size(600, 600);
  noStroke();
  background(255);
  sound = new SoundFile(this, "./salamisound-8882847-door-squeak-and-creak-door.wav");
  ronco = new SoundFile(this, "./ronco_efeito_sonoro.wav");
}

void draw(){
  background(255);
  noStroke();
  
  if((keyPressed == true)){
    dormir = false; //Deixa de dormir
    frame = 0; //Reinicia frame
    piscaEsq = false; //Deixa de piscar
    piscaDir = false; //Deixa de piscar
  }
  if(frame > 60) frame=0; //Reinicia frame
  
  //Desenha Rodas
  fill(0);
  rect(205, 460, 15, 50, 200); //Roda esquerda
  rect(380, 460, 15, 50, 200); //Roda direita
  
  //Desenha Lixeira
  fill(150); //Cor do suporte
  rect(188, 300, 20, 20, 200); //Suporte da esquerda
  rect(390, 300, 20, 20, 200); //Suporte da direita
  fill(110); //Cor lixeira
  quad(200, 250, 400, 250, 380, 500, 220, 500); //Lixeira
  
  
  /*___________________________TAMPA___________________________*/
  if((keyPressed == true) && (key == 'P') || (keyPressed == true) && (key == 'p')){
    tempoPressionado++;
    abreTampa();
    abrePuxador();
    descePedal();
    
  }else{
    tempoPressionado = 0;
    fechaTampa();
    fechaPuxador();
    sobePedal();
  }
  /*___________________________________________________________*/
  
  //Desenha Sombras na Lixeira
  fill(color(150, 150));
  quad(220, 300, 240, 300, 250, 480, 230, 480); //Primeira listra
  quad(270, 300, 290, 300, 290, 480, 270, 480); //Segunda listra
  quad(310, 300, 330, 300, 330, 480, 310, 480); //Terceira listra
  quad(360, 300, 380, 300, 370, 480, 350, 480); //Quarta listra

  /*___________________________OLHOS___________________________*/
  if((keyPressed == true) && (key == '4')) piscaEsq = true;
  if((keyPressed == true) && (key == '6')) piscaDir = true;
  if((keyPressed == true) && (key == 'f') || (keyPressed == true) && (key == 'F')) dormir = true; //Dorme
  
  //Ronca
  if(!ronco.isPlaying() && dormir) ronco.play();
  else if(!dormir) ronco.pause();
  
  if(piscaEsq && frame < 31 || dormir)
  {
      fechaOlhoEsquerdo();
  }
  else if(!piscaEsq || frame > 30 && frame < 61)
  {
      abreOlhoEsquerdo();
  }
  
  if(piscaDir && frame < 31 || dormir)
  {
      fechaOlhoDireito();
  }
  else if(!piscaDir || frame > 30 && frame < 61)
  {
      abreOlhoDireito();
  }
  /*___________________________________________________________*/

  /*___________________________BOCA___________________________*/
  //Desenha Boca
  if(!dormir && tempoPressionado <= 3 * frameRate){
    //Boca aberta
    fill(color(0, 180)); //Preto fundo da boca
    arc(300, 385, 70, 60, 0, PI); //Boca
    fill(255); //Cor dos dentes
    arc(300, 385, 50, 10, 0, PI); //Dente
    fill(255,0,0); //Cor da lingua
    arc(300, 408, 41, 15, 0, PI); //Lingua
  }
  else if (tempoPressionado <= 3 * frameRate){
    //Boca fechada
    fill(color(0, 200));
    ellipse(290, 400, 25, 25);
  }
  /*___________________________________________________________*/
  
  //Desenha nariz
  stroke(0);
  noFill();
  strokeWeight(1);
  arc(300, 360, 20, 15, 0, PI);
  
  if((keyPressed == true) && (key == 'P') && tempoPressionado >= 3 * frameRate|| (keyPressed == true) && (key == 'p') && tempoPressionado >= 3 * frameRate)
      desenhaLixo();
  
  if(piscaEsq || piscaDir) frame++;
  
  save("Jothan_Kethlen_2Dinter.png");
}

void desenhaLixo(){
  fill(0);
  
  if (tempoPressionado >=3 * frameRate && tempoPressionado <=4* frameRate){
    arc(300, 250, 150, 40, PI, PI*2);
    triangle(275, 210, 325, 210, 300, 240);
    
    //boca reta
    stroke(0);
    noFill();
    strokeWeight(5);
    arc(300, 400, 50, 3, PI, PI*2);
    
  }else if (tempoPressionado >=4 * frameRate && tempoPressionado <=5 * frameRate){
    arc(300, 250, 150, 60, PI, PI*2);
    triangle(275, 200, 325, 200, 300, 230);
    
    noStroke();
    fill(0, 0, 255); // Cor azul
    triangle(250, 335, 244, 345, 256, 345);
    ellipse(250 ,350, 15,15); 
    
    //boca um pouco triste
    stroke(0);
    noFill();
    strokeWeight(5);
    arc(300, 400, 50, 10, PI, PI*2);
    
  }else if (tempoPressionado >=5 * frameRate){
    arc(300, 250, 150, 80, PI, PI*2);
    triangle(275, 190, 325, 190, 300, 230);
    
    // Desenhe a lágrima
    noStroke();
    fill(0, 0, 255); // Cor azul
    triangle(250, 335, 244, 345, 256, 345);
    ellipse(250 ,350, 15,15); 
    triangle(350, 335, 344, 345, 356, 345);
    ellipse(350 ,350, 15,15);
    
    //boca triste
    stroke(0);
    strokeWeight(5);
    noFill();
    arc(300, 400, 50, 20, PI, PI*2);
  }
  
  noStroke();
  fill(255);
  ellipse(275 ,340, 15,15); 
  ellipse(280 ,330, 5,5); 
  ellipse(325 ,340, 15,15);
  ellipse(320 ,330, 5,5); 
}

void abreOlhoEsquerdo(){
    olhoYEsq = olhoYEsq < 55? olhoYEsq+3 : 55;
    pupilaYEsq = pupilaYEsq < 35? pupilaYEsq+3 : 35;
    sobrancelhaYEsq = sobrancelhaYEsq > 295? sobrancelhaYEsq-0.5 : 295; //Levanta sobrancelha
    //Desenha Olho Esquerdo Aberto
    fill(255); //Branco do olho
    ellipse(270, 330, 50, olhoYEsq); //Olho esquerdo
    fill(0); //Preto da pupila
    ellipse(270, 330, 30, pupilaYEsq); //Pupila esquerdo
    fill(color(0, 180)); //Preto da sobrancelha
    rect(255, sobrancelhaYEsq, 30, 10, 100); //Sobrancelha esquerda
}

void fechaOlhoEsquerdo(){
    olhoYEsq = olhoYEsq > 8? olhoYEsq-3 : 8; //Pisca o olho esquerdo
    if(olhoYEsq <= pupilaYEsq) pupilaYEsq = pupilaYEsq >= 10? pupilaYEsq-3 : 10; //Pisca pupila esquerda
    if(olhoYEsq < 9)fill(0); //Cor do olho totalmente fechado
    else fill(255); //Branco do olho
    if(olhoYEsq > 11) sobrancelhaYEsq = sobrancelhaYEsq >= 300? sobrancelhaYEsq+0.3 : 300; //Abaixa sobrancelha
    ellipse(270, 330, 50, olhoYEsq); //Olho esquerdo
    fill(0); //Preto da pupila
    ellipse(270, 330, 30, pupilaYEsq); //Pupila esquerdo
    fill(color(0, 180)); //Preto da sobrancelha
    rect(255, sobrancelhaYEsq, 30, 10, 100); //Sobrancelha esquerda
}

void abreOlhoDireito(){
    olhoYDir = olhoYDir < 55? olhoYDir+3 : 55;
    pupilaYDir = pupilaYDir < 35? pupilaYDir+3 : 35;
    sobrancelhaYDir = sobrancelhaYDir > 295? sobrancelhaYDir-0.5 : 295; //Levanta sobrancelha
    //Desenha Olho Direito Aberto
    fill(255); //Branco do olho
    ellipse(330, 330, 50, olhoYDir); //Olho direito
    fill(0); //Preto da pupila
    ellipse(330, 330, 30, pupilaYDir); //Pupila direita
    fill(color(0, 180)); //Preto da sobrancelha
    rect(315, sobrancelhaYDir, 30, 10, 100); //Sobrancelha direita
}

void fechaOlhoDireito(){
    olhoYDir = olhoYDir > 8? olhoYDir-3 : 8;
    if(olhoYDir <= pupilaYDir) pupilaYDir = pupilaYDir >= 10? pupilaYDir-3 : 10;
    if(olhoYDir < 9) fill(0); //Cor do olho totalmente fechado
    else fill(255); //Branco do olho
    if(olhoYDir > 11) sobrancelhaYDir = sobrancelhaYDir >= 300? sobrancelhaYDir+0.3 : 300; //Abaixa sobrancelha
    ellipse(330, 330, 50, olhoYDir); //Olho direito
    fill(0); //Preto da pupila
    ellipse(330, 330, 30, pupilaYDir); //Pupila direita
    fill(color(0, 180)); //Preto da sobrancelha
    rect(315, sobrancelhaYDir, 30, 10, 100); //Sobrancelha direita
}

void abreTampa(){
    //Barulho da tampa
    if (!sound.isPlaying() && !tampaAberta) sound.play();

    if(time < 0.8){
      posTamp = posTamp+2;
      time = ((posTamp) * PI / 60 ) * 0.1;
      tampaAberta = true;
    }
    pushMatrix();
    translate(195,240);
    rotate(-time);
    
    fill(150); //Cor estrutura da tampa
    rect(0, 0, 210, 20, 100); //Tampa 
    popMatrix();
}

void fechaTampa(){
  tampaAberta = false;
  if(time > 0){
      posTamp = posTamp-3;
      time = ((posTamp) * PI / 60 ) * 0.1;
    }
    //Tampa fechada
    pushMatrix();
    translate(195,240);
    rotate(-time);
    
    fill(150); //Cor estrutura da tampa
    rect(0, 0, 210, 20, 100); //Tampa 
    popMatrix();
}


void abrePuxador(){
  if(time < 0.8){
      posTamp = posTamp+2;
      time = ((posTamp) * PI / 60 ) * 0.1;
    }
    pushMatrix();
    translate(195,240);
    rotate(-time);
    
    fill(150); //Cor estrutura da tampa
    quad(95, -10, 115, -10, 125,0, 85, 0); //Puxador da tampa
    popMatrix();
}

void fechaPuxador(){
  if(time > 0){
      posTamp = posTamp-3;
      time = ((posTamp) * PI / 60 ) * 0.1;
    }
    //Tampa fechada
    pushMatrix();
    translate(195,240);
    rotate(-time);
    
    fill(150); //Cor estrutura da tampa
    quad(95, -10, 115, -10, 125,0, 85, 0); //Puxador da tampa
    popMatrix();
}

void descePedal(){
    //Pedal
    fill(color(180, 128)); //Cor do fundo do pedal
    arc(300, 500, 30, 30, PI, 2*PI); //Fundo do pedal
    fill(60); //Cor do pedal
    rect(295, 485, 10, 15, 40); //Cabo do pedal
    arc(300, 497, 20, 15, 0, PI); //Pedal
}  

void sobePedal(){
    //Pedal
    fill(color(180, 128)); //Cor do fundo do pedal
    arc(300, 500, 30, 30, PI, 2*PI); //Fundo do pedal
    fill(60); //Cor do pedal
    rect(295, 485, 10, 13, 40); //Cabo do pedal
    arc(300, 493, 20, 15, 0, PI); //Pedal
} 
