int widthX = 20;
int widthY = 20;
int fieldSize = 32;
int bombCount = 0;
Tile[][] mineField = new Tile[widthX][widthY];
float randomTreshhold = 0.2;
boolean gameOver = false;
boolean firstClick = true;
boolean shift = false;
boolean update = true;
boolean win = false;


PImage[] assets = new PImage[16];

void settings() {
  size(widthX*fieldSize, widthY*fieldSize);
}


void setup() {
  for (int i = 0; i < assets.length; i++) {
    assets[i] = loadImage("assets/minesweeper_" + i + ".png");
    assets[i].resize(fieldSize, fieldSize);
  }
  for (int i = 0; i < mineField.length; i++) {
    for (int u = 0; u < mineField[0].length; u++) {
      float random = random(0, 1);
      if (random < randomTreshhold) {
        mineField[i][u] = new Tile(true);
        bombCount++;
      } else {
        mineField[i][u] = new Tile(false);
      }
    }
  }
  for (int i = 0; i < mineField.length; i++) {
    for (int u = 0; u < mineField[0].length; u++) {
      mineField[i][u].checkPoints(mineField, i, u);
    }
  }
  textAlign(CENTER, CENTER);
  textSize(20);
}

void unhideAll() {
}

void draw() {
  if (bombCount == 0) {
    gameOver = true;
    win = true;
  }
  if (update) {
    if (gameOver == false) {
      for (int i = 0; i < mineField.length; i++) {
        for (int u = 0; u < mineField[0].length; u++) {
          mineField[i][u].drawField(i, u, fieldSize);
        }
      }
    } else {
      for (int i = 0; i < mineField.length; i++) {
        for (int u = 0; u < mineField[0].length; u++) {
          mineField[i][u].isHidden = false;
          mineField[i][u].drawField(i, u, fieldSize);
        }
      }
      if (win) {
        textSize(100);
        text("You won!", width/2, height/2);
      }
    }
    update = false;
  }
}

void mouseClicked() {
  if (!gameOver) {
    int mouseFieldPositionX = mouseX/fieldSize;
    int mouseFieldPositionY = mouseY/fieldSize;
    if (mouseButton == LEFT && !shift) {
      if (firstClick) {
        if (mineField[mouseFieldPositionX][mouseFieldPositionY].isBomb) {
          mineField[mouseFieldPositionX][mouseFieldPositionY].isBomb = false;
          bombCount--;
          mineField[mouseFieldPositionX][mouseFieldPositionY].checkPoints(mineField, mouseFieldPositionX, mouseFieldPositionY);
        }
        firstClick = false;
      }
      mineField[mouseFieldPositionX][mouseFieldPositionY].clickedField(mouseFieldPositionX, mouseFieldPositionY);
    } else {
      if (mineField[mouseFieldPositionX][mouseFieldPositionY].isFlagged) {
        mineField[mouseFieldPositionX][mouseFieldPositionY].isFlagged = false;
        if (mineField[mouseFieldPositionX][mouseFieldPositionY].isBomb) {
          bombCount++;
        }
        update = true;
        return;
      }
      mineField[mouseFieldPositionX][mouseFieldPositionY].isFlagged = true;
      if (mineField[mouseFieldPositionX][mouseFieldPositionY].isBomb) {
        bombCount--;
      }
    }
    update = true;
  }
}

void keyPressed() {
  if (keyCode == SHIFT) {
    shift = true;
  }
}

void keyReleased() {
  if (keyCode == SHIFT) {
    shift = false;
  }
}
