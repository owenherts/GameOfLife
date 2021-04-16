import de.bezier.guido.*;
public final static int NUM_ROWS=30;
public final static int NUM_COLS=30;
private Life[][] buttons;
private boolean[][] buffer;
private boolean running = false;

public void setup () {
  size(400, 400);
  frameRate(6);
  Interactive.make( this );

buttons = new Life[NUM_ROWS][NUM_COLS];
for(int r=0; r<NUM_ROWS; r++)
  for(int c=0; c<NUM_COLS; c++)
    buttons[r][c]= new Life(r,c);
  buffer= new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false)
    return;
  copyFromButtonsToBuffer();
  for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c<NUM_COLS; c++){
      if(countNeighbors(r,c)==3)
        {buffer[r][c]=true;}
      else if (countNeighbors(r,c)==2 && buttons[r][c].getLife()==true)
        {buffer[r][c]=true;}
      else
        {buffer[r][c]=false;}
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(running==true)
    running=false;
  else if(running==false)
    running=true;
}

public void copyFromBufferToButtons() {
  for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c<NUM_COLS; c++){
      if(buffer[r][c]==true){
        buttons[r][c].setLife(true);}
      
      if(buffer[r][c]==false){
        buttons[r][c].setLife(false);}
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c<NUM_COLS; c++){
       if(buttons[r][c].getLife()==true)
         buffer[r][c]=true;
       
       if(buttons[r][c].getLife()==false)
         buffer[r][c]=false;
    } 
    }
}

public boolean isValid(int r, int c) {
  if(r<=19 && r>=0)
    if(c<=19 && c>=0)
      return true;
  return false;
}

public int countNeighbors(int row, int col) {
  int count = 0;
  if(isValid(row+1, col+1) == true && buttons[row+1][col+1].getLife()==true)
    count++;
  if(isValid(row, col+1) == true && buttons[row][col+1].getLife()==true)
    count++;
  if(isValid(row+1, col) == true && buttons[row+1][col].getLife()==true)
    count++;
  if(isValid(row-1, col-1) == true && buttons[row-1][col-1].getLife()==true)
    count++;
  if(isValid(row-1, col) == true && buttons[row-1][col].getLife()==true)
    count++;
  if(isValid(row, col-1) == true && buttons[row][col-1].getLife()==true)
    count++;
  if(isValid(row+1, col-1) == true && buttons[row+1][col-1].getLife()==true)
    count++;
  if(isValid(row-1,col+1)== true && buttons[row-1][col+1].getLife()==true)
    count++;
  return count;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5;
    Interactive.add( this );
  }

  public void mousePressed () {
    alive = !alive;
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill(50,50,200);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    if(alive==true)
      return true;
    return false;
  }
  public void setLife(boolean living) {
   if(living==true)
      alive=true;
   if(living==false)
     alive=false;
  }
}
