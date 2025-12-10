class Cell{
  boolean currentState;
  boolean nextState;
  PVector center;
  PVector indices;
  int size;
  Cell[] neighbors;
  Cell(int x, int y, int s, int i, int j){
    center = new PVector(x, y);
    currentState = false;
    size = s;
    indices = new PVector(i, j);
  }
  
  void firstTick(){
    neighbors = new Cell[8];
    int w = 0;
    for (Cell[] cellColumn : grid){
      for (Cell cell : cellColumn){
        if (abs(cell.indices.x - indices.x) == 1 && abs(cell.indices.y - indices.y) == 1){
          neighbors[w] = cell;
          w++;
        }
      }
    }
  }
  
  void determineNextState(int posx, int posy){
    int numAlive = 0;
    for (int i = 0; i < neighbors.length && neighbors[i] != null; i++){
      if (neighbors[i].currentState){
        numAlive++;
      }
    }
    if (currentState){
      if (numAlive > 6 || numAlive < 3){
        nextState = false;
      }
      else {
        nextState = true;
      }
    }
    else {
      if (numAlive > 2) {
        nextState = true;
      }
      else {
        nextState = false;
      }
    }
  }
  
  void Tick(){
    currentState = nextState;
  }
  
  void display(){
    if (currentState){
      fill(#ffffff);
    }
    else{
      fill(#000000);
    }
    square(center.x, center.y, size);
  }
}

public Cell[][] grid;
public int sze;
public boolean running;

void setup(){
  grid = new Cell[15][15];
  sze = 20;
  size(300, 300);
  populateCells();
  frameRate(1);
  running = false;
}

void populateCells(){
  for (int i = 0; i < grid.length; i++){
    for (int j = 0; j < grid[i].length; j++){
      grid[i][j] = new Cell(i * sze, j * sze, sze, i, j);
    }
  }
  for (int i = 0; i < grid.length; i++){
    for (int j = 0; j < grid[i].length; j++){
      grid[i][j].firstTick();
    }
  }
}

void draw(){
  if (running){
    for (int i = 0; i < grid.length; i++){
      for (int j = 0; j < grid[i].length; j++){
        grid[i][j].determineNextState(i, j);
        grid[i][j].Tick();
        grid[i][j].display();
      }
    }
  }
}

void keyPressed(){
  if (key == ' '){
    running = !running;
  }
}

void mouseClicked(){
  grid[mouseX / sze][mouseY / sze].nextState = !grid[mouseX / sze][mouseY / sze].currentState;
  grid[mouseX / sze][mouseY / sze].currentState = !grid[mouseX / sze][mouseY / sze].currentState;
  println(grid[mouseX / sze][mouseY / sze].currentState);
  println("waw");
}
