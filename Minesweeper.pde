import de.bezier.guido.*;
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
public final static int NUM_MINES = 8;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); 

void setup ()  //STEP #5
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r, c);
      }
    }
    setMines();
} //end void setup()

public void setMines()  //STEP #9
{
   int rRand, cRand;
    for(int i = 0; i < NUM_MINES; i++){
      rRand = (int)(Math.random()* NUM_ROWS);
      cRand = (int)(Math.random()* NUM_COLS);
      //contains() only works with arraylist and strings
      if(!mines.contains(buttons[rRand][cRand])){
        mines.add(buttons[rRand][cRand]);
      }
    System.out.println(rRand + " , " + cRand);
    }
} //end void setMines()

public void draw ()
{
    background( 0 );
    if(isWon() == true)
      displayWinningMessage();
}  //end void draw()

public boolean isWon()  //STEP #14
{
    boolean nMines = false;
    boolean nonMines = false;
    
    // ALL MINES ARE FLAGGED
    int numMinesFlagged = 0;
    for(int i = 0; i < mines.size(); i++){
      if(mines.get(i).flagged == true)
        numMinesFlagged++;
    }
    if(numMinesFlagged == mines.size())
      nMines = true;
    return nMines;
    /*
    // ALL NON-MINES ARE CLICKED
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(!mines.contains(buttons[r][c]) && 
            buttons[r][c].clicked ==true){
          nonMines = true;
        }
      }
    }
    return nonMines && nMines;
    */
} //end boolean isWon()

public void displayLosingMessage()  //STEP #16
{
    buttons[0][NUM_COLS/2 - 1].setLabel("L");
    buttons[0][NUM_COLS/2].setLabel("o");
    buttons[0][NUM_COLS/2 + 1].setLabel("S");
    buttons[0][NUM_COLS/2 + 2].setLabel("e");
    
    //SHOW ALL MINES - flag IF !flag ????
    //for(int i = 0; i < mines.size(); i++){
    //    if(mines.get(i).flagged == false){
    //      mines.get(i).flagged = true;
    //    }
    //}
} // end void displayLosingMessage()

public void displayWinningMessage()  //STEP #15
{
    buttons[0][NUM_COLS/2 - 1].setLabel("W");
    buttons[0][NUM_COLS/2].setLabel("i");
    buttons[0][NUM_COLS/2 + 1].setLabel("N");
}

public boolean isValid(int r, int c)  //STEP #11
{
    if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
      return true;
    return false;
}

public int countMines(int row, int col)  //STEP #12
{
    int numMines = 0;
    for(int r = row-1; r<=row+1; r++){
      for(int c = col-1; c<=col+1; c++){
        if(mines.contains(buttons[row][col]) == true){
          numMines--;
        }
        if(isValid(r,c) == true && 
            mines.contains(buttons[r][c]) == true){
          numMines++;
        }
      }
    }
     return numMines;
} // end int countMines()

public class MSButton
{
  private int myRow, myCol;
  private float x,y, width, height;
  private boolean clicked, flagged;
  private String myLabel;
  
  public MSButton ( int row, int col )
  {
       width = 400/NUM_COLS;
       height = 400/NUM_ROWS;
      myRow = row;
      myCol = col; 
      x = myCol*width;
      y = myRow*height;
      myLabel = "";
      flagged = clicked = false;
      Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed ()  //STEP #13
  {
      clicked = true;
      
      if(mouseButton == RIGHT)
      {
        flagged = !flagged;
        if(flagged == false){
           clicked = false;
         }
      }
      else if(mines.contains(this)){
        displayLosingMessage(); 
      }
      else if(countMines(myRow,myCol) > 0){
        setLabel(countMines(myRow,myCol));
      }
      else{
        for(int r = myRow-1; r < myRow+1; r++){
          for(int c = myCol-1; c < myCol+1; c++){
            if(isValid(r,c) && buttons[r][c].clicked == false){
              buttons[r][c].mousePressed();
            }
          }
        }
      }
  } //end void mousePressed()

  public void draw () 
  {    
      if (flagged)
        fill(255,0,0);
       else if(clicked == true && mines.contains(this)) 
         fill(74, 74, 67);
      else if(clicked)
        fill(130, 112, 70);
      else 
        fill(59, 107, 68);

      rect(x, y, width, height);
      fill(0);
      text(myLabel,x+width/2,y+height/2);
  }
  public void setLabel(String newLabel)
  {
      myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
      myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
      return flagged;
  }
  public boolean isClicked(){
    return clicked;
  }
} // end MSButton class

/* - CALL ALL 8 RECURSIVELY
if(isValid(myRow-1,myCol-1)&& buttons[myRow-1][myCol-1].clicked == false)
  buttons[myRow-1][myCol-1].mousePressed();
if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false)
  buttons[myRow-1][myCol].mousePressed();
if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false)
  buttons[myRow-1][myCol+1].mousePressed();
  
if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false)
  buttons[myRow][myCol-1].mousePressed();
if(isValid(myRow,myCol+1) && buttons[myRow][myCol-1].clicked == false)
  buttons[myRow][myCol+1].mousePressed();
  
if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked == false)
  buttons[myRow+1][myCol-1].mousePressed();
if(isValid(myRow+1,myCol) && buttons[myRow-1][myCol].clicked == false)
  buttons[myRow+1][myCol].mousePressed();
if(isValid(myRow+1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false)
  buttons[myRow+1][myCol+1].mousePressed();
*/
