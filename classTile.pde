class Tile {
  boolean isBomb;
  boolean isHidden;
  boolean isFlagged;
  boolean clickedBomb;
  int points;

  Tile(boolean isBomb) {
    this.isBomb = isBomb;
    this.isHidden = true;
    this.isFlagged = false;
    this.clickedBomb = false;
  }

  void checkPoints(Tile[][] mineField, int positionX, int positionY) {
    this.points = 0;
    try {
      if (mineField[positionX-1][positionY-1].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX-1][positionY].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX-1][positionY+1].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX][positionY-1].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX][positionY+1].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX+1][positionY-1].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX+1][positionY].isBomb)this.points++;
    }
    catch(Exception e) {
    }
    try {
      if (mineField[positionX+1][positionY+1].isBomb)this.points++;
    }
    catch(Exception e) {
    }
  }

  void clickedField(int x, int y) {
    if (!this.isFlagged) {
      if (this.isBomb) {
        this.isHidden = false;
        this.clickedBomb = true;
        gameOver = true;
        update = true;
      }
      if (this.isHidden) {
        mineField[x][y].unhideAllEmpty(x, y, true);
        this.isHidden = false;
      }
    }
  }

  void unhideAllEmpty(int x, int y, boolean firstClicked) {
    if ((this.isHidden && this.points == 0 && !this.isBomb && !this.isFlagged) || firstClicked) {
      this.isHidden = false;
      try {
        mineField[x-1][y].unhideAllEmpty(x-1, y, false);
      }
      catch(Exception e) {
      }
      try {
        mineField[x+1][y].unhideAllEmpty(x+1, y, false);
      }
      catch(Exception e) {
      }
      try {
        mineField[x][y-1].unhideAllEmpty(x, y-1, false);
      }
      catch(Exception e) {
      }
      try {
        mineField[x][y+1].unhideAllEmpty(x, y+1, false);
      }
      catch(Exception e) {
      }
      if (!firstClicked) {
        try {
          mineField[x+1][y+1].unhideAllEmpty(x+1, y+1, false);
        }
        catch(Exception e) {
        }
        try {
          mineField[x-1][y+1].unhideAllEmpty(x-1, y+1, false);
        }
        catch(Exception e) {
        }
        try {
          mineField[x-1][y-1].unhideAllEmpty(x-1, y-1, false);
        }
        catch(Exception e) {
        }
        try {
          mineField[x+1][y-1].unhideAllEmpty(x+1, y-1, false);
        }
        catch(Exception e) {
        }
      }
    }
    if (this.isHidden && this.points > 0 && !this.isBomb && !this.isFlagged) {
      this.isHidden = false;
    }
  }

  void drawField(int x, int y, int fieldSize) {
    if (this.isFlagged && !gameOver) {
      image(assets[2], x*fieldSize, y*fieldSize);
      return;
    }
    if (!this.isHidden && !this.isBomb && points > 0) {
      image(assets[points+7], x*fieldSize, y*fieldSize);
      return;
    }
    if (!this.isHidden && this.isBomb && this.isFlagged) {
      image(assets[7], x*fieldSize, y*fieldSize);
      return;
    }
    if (!this.isHidden && this.isBomb && clickedBomb) {
      image(assets[6], x*fieldSize, y*fieldSize);
      return;
    }
    if (!this.isHidden && this.isBomb && !clickedBomb) {
      image(assets[5], x*fieldSize, y*fieldSize);
      return;
    }
    if (!this.isHidden) {
      image(assets[1], x*fieldSize, y*fieldSize);
      return;
    }
    image(assets[0], x*fieldSize, y*fieldSize);
  }
}
