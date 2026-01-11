/*Franklin Li
NextCS
Project 01: GridRock
Making Conway and other Life-like simulators
Time Spent: 5hr (probably)

Notes: Don't get too enthusiastic with drag mode, it WILL throw nullrefs if your mouse gets
out of bounds.
Also, yes this code is inefficient as all heck, but that's kind of what happened.
I made each part without considering the whole thing and ended up with this behemoth.

*/


int CONWAY_MODE = 0;
int SEEDS_MODE = 1;
int DAY_NIGHT = 2;
int REPLICATOR_MODE = 3;
int currentMode = 0;


class Cell{
  boolean currentState;
  boolean nextState;
  PVector center;
  PVector indices;
  int size;
  Cell[] neighbors;
  int numAlive;
  boolean dragged = false;
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
        if (abs(cell.indices.x - indices.x) <= 1 && abs(cell.indices.y - indices.y) <= 1 && cell != this){
          neighbors[w] = cell;
          w++;
        }
      }
    }
  }
  
  void determineNextState(int posx, int posy){
    numAlive = 0;
    for (int i = 0; i < neighbors.length && neighbors[i] != null; i++){
      if (neighbors[i].currentState){
        numAlive++;
      }
    }
    calcOutcomes();
  }
  boolean conwayCalc(){
    if (currentState){
      if (numAlive == 2 || numAlive == 3){
        return true;
      }
      else{
        return false;
      }
    }
    else {
      if (numAlive == 3){
        return true;
      }
      else{ 
        return false;
      }
    }
  }
  boolean seedsCalc(){
    if (currentState){
        return false;
    }
    else {
      if (numAlive == 2){
        return true;
      }
      else{ 
        return false;
      }
    }
  }
  boolean dayCalc(){
    if (currentState){
      if (numAlive == 3 || numAlive == 4 || numAlive == 6 || numAlive == 7 || numAlive == 8){
        return true;
      }
      else{
        return false;
      }
    }
    else {
      if (numAlive == 3 || numAlive == 6 || numAlive == 7 || numAlive == 8){
        return true;
      }
      else{ 
        return false;
      }
    }
  }
  boolean replicatorCalc(){
    if (currentState){
      if (numAlive == 1 || numAlive == 3 || numAlive == 5 || numAlive == 7){
        return true;
      }
      else{
        return false;
      }
    }
    else {
      if (numAlive == 1 || numAlive == 3 || numAlive == 5 || numAlive == 7){
        return true;
      }
      else{ 
        return false;
      }
    }
  }
  void calcOutcomes(){
    if (currentMode == CONWAY_MODE){
      nextState = conwayCalc();
    }
    if (currentMode == SEEDS_MODE){
      nextState = seedsCalc();
    }
    if (currentMode == DAY_NIGHT){
      nextState = dayCalc();
    }
    if (currentMode == REPLICATOR_MODE){
      nextState = replicatorCalc();
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
  grid = new Cell[50][50];
  sze = 10;
  size(500, 500);
  populateCells();
  frameRate(40);
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
        if (frameCount % 10 == 0){
  background(#000000);
    for (int i = 0; i < grid.length; i++){
      for (int j = 0; j < grid[i].length; j++){
        grid[i][j].determineNextState(i, j);
      }
    }
    for (int i = 0; i < grid.length; i++){
      for (int j = 0; j < grid[i].length; j++){
        grid[i][j].Tick();
        grid[i][j].display();
      }
    }
  }
  }
}

void keyPressed(){
  if (key == ' '){
    running = !running;
  }
  if (key == 'r'){
    grid = new Cell[50][50];
    populateCells();
  }
  if (key == '1'){
    currentMode = CONWAY_MODE;
  }
  if (key == '2'){
    currentMode = SEEDS_MODE;
  }
  if (key == '3'){
    currentMode = DAY_NIGHT;
  }
  if (key == '4'){
    currentMode = REPLICATOR_MODE;
  }
  if (key == 'c'){
    mouseMode = CLICK_MODE;
  }
  if (key == 'd'){
    mouseMode = DRAG_MODE;
  }
}
boolean mouseMode = true;
boolean DRAG_MODE = false;
boolean CLICK_MODE = true;

void mouseReleased(){
  if (mouseMode == DRAG_MODE){
    for (int i = 0; i < grid.length; i++){
      for (int j = 0; j < grid[i].length; j++){
        grid[i][j].dragged = false;
      }
    }
  }
}
void mouseDragged(){
  if (mouseMode == DRAG_MODE && !grid[mouseX / sze][mouseY / sze].dragged){
    grid[mouseX / sze][mouseY / sze].dragged = true;
    grid[mouseX / sze][mouseY / sze].nextState = !grid[mouseX / sze][mouseY / sze].currentState;
  grid[mouseX / sze][mouseY / sze].currentState = !grid[mouseX / sze][mouseY / sze].currentState;
  grid[mouseX / sze][mouseY / sze].display();
  }
}

void mouseClicked(){
  if (mouseMode == CLICK_MODE){
  grid[mouseX / sze][mouseY / sze].nextState = !grid[mouseX / sze][mouseY / sze].currentState;
  grid[mouseX / sze][mouseY / sze].currentState = !grid[mouseX / sze][mouseY / sze].currentState;
  grid[mouseX / sze][mouseY / sze].display();
  println(grid[mouseX / sze][mouseY / sze].currentState);
  println("waw");
  }
}
