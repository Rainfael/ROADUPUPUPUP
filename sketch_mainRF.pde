Cenario cenario; 
CarroV carrinho; 
ArrayList<Carro> carros = new ArrayList<Carro>();
PFont fonte; 
float posy = -50; 
int life = 3;
PImage lateral, lateral2, hearts, menu;
int fase, pontos, quadro;


void setup() {
  lateral = loadImage("lateral.png");
  lateral2 = loadImage("lateral2.png");
  hearts = loadImage("3hearts.png");
  menu = loadImage("mainmenu2.png");
  //eu fiz uma img pro menu so q nao precisava ne que só eh texto praticamente
  // kk mas era pq eu ia fazer alguma outra coisa mas enfim muda dps SE QUSIE


  fonte = createFont("pixel.TTF", 28);
  textFont(fonte);

  size(615, 600);
  fase = -1; // A FASE -1 É PRA SER O MENU, A FASE 0 É PRA SER ENQUANTO ESTÁ JOGANDO

  cenario = new Cenario();
  carrinho = new CarroV(loadImage("car1teste.png"), 300, 500 ); //CARRO DO JOGADOR
}

void draw() {


  quadro++; 

  cenario.cena(); // adicionando os elementos do cenário 
  cenario.pista();
  cenario.des(lateral, lateral2, hearts);

  if (life == 3) {
    hearts = loadImage("3hearts.png");
  }

  if (life == 2) {
    hearts = loadImage("2hearts.png");
  }

  if (life == 1) {
    hearts = loadImage("1heart.png");
  }

  if (life == 0) {
    hearts = loadImage("0heart.png");
  }

  for (int i = carros.size() - 1; i >= 0; i--) {
    Carro car = carros.get(i);   
    car.desenhar();   
    car.acelerar();
  }

  carrinho.desenhar();

  if (quadro > 90 ) {
    quadro = 0;
    if (random(1) > 0.3 && fase == 0) {
      carros.add(new CarroA(loadImage("c2.png"), random(100, 450 -30), posy));
    }
  }

  for (int i = carros.size() - 1; i >= 0; i--) {
    Carro c = carros.get(i);
    if (c.colidiu(carrinho.x, carrinho.y)) {
      carros.remove(i);
      life--;
      if (life < 1) { // SE AS VIDAS ACABAREM MUDAR PARA FASE 1 (game over)
        fase = 1;
      }
    }
    if (c.y >= 540 && c.y <= 543 && fase == 0) {
      pontos += 100;
    }
  }

  if (fase == 1) { // A FASE 1 REPRESENTA A TELA DE GAME OVER
    textSize(60);
    background(0);
    text("GAME OVER", 80, 250);
    textSize(15);
    text("PONTOS: ", 250, 350);
    text(pontos, 340, 350);
    text("***CLIQUE PARA RECOMEÇAR***", 140, 500);
  }

  if (fase == -1) {
    image(menu, 0, 0);
  }

  if (fase == 0) {
    textSize(20);
    fill(255);
    text("Road", 485, 80);
    text("Fighter", 510, 115);

    text("Pontos:", 480, 200);
    text(pontos, 480, 250);

    text("Vidas:", 480, 450); 
    text(life, 500, 500);
  }
} //FIM DO DRAW

void mousePressed() { // TELA DE GAME OVER, SE CLICAR RECOMEÇA O JOGO
  if ( fase == 1 ) {
    fase = 0; 
    life = 3;
    carros.clear();
    pontos = 0;
  }
  if ( fase == -1 ) {
    fase = 0;
  }
} 

void keyPressed() {
  if (keyCode == 37) {
    carrinho.mover(carrinho.getX() - 10);
  } else if (keyCode == 39) {
    carrinho.mover(carrinho.getX() + 10);
  } //keyCode 32
}