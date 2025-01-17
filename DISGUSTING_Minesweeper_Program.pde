import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
public final static int NUM_MINES = 2;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

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
}
public void setMines()  //STEP #9
{
   int rRand, cRand;
    while(mines.size() < NUM_MINES){
      rRand = (int)(Math.random()* NUM_ROWS);
      cRand = (int)(Math.random()* NUM_COLS);
      //contains() only works with arraylist and strings
      if(!mines.contains(buttons[rRand][cRand])){
        mines.add(buttons[rRand][cRand]);
      }
    System.out.println(rRand + " , " + cRand);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
      displayWinningMessage();
    else
      displayLosingMessage();
}  

public boolean isWon()  //STEP #14
{
    for(int i = 0; i < mines.size(); i++){
      if(mines.get(i).isFlagged() == true)
        return true;
    }
    return false;
    // you win when all the non mines are clicked 
}
public void displayLosingMessage()  //STEP #16
{
    buttons[0][0].setLabel("L");
    //SHOW ALL MINES
    
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].clicked == false && mines.contains(buttons[r][c]) == false){
          buttons[r][c].clicked = true;
          }}}
        
      }
    
    //for(int i = 0; i < mines.size(); i++)
    //  //if(mines.get(i).isFlagged() == false)
    //    mines.get(i).mousePressed();

public void displayWinningMessage()  //STEP #15
{
    buttons[0][0].setLabel("W");
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
        if(isValid(r,c) == true && mines.contains(buttons[r][c]) == true){
          numMines++;
        }}}
    if(mines.contains(buttons[row][col]) == true)
      numMines--;
    return numMines;
}

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
        
        if(mouseButton == RIGHT){
          flagged = !flagged;
          if(flagged == false)
            {clicked = false;}
        }
        else if(mines.contains(this)){
          displayLosingMessage(); 
        }
        else if(countMines(myRow,myCol) > 0){
          setLabel(countMines(myRow,myCol));
        }
        else{
    
              if(isValid(myRow-1,myCol-1) == true && buttons[myRow-1][myCol-1].clicked == true)
                buttons[myRow-1][myCol-1].mousePressed();
              if(isValid(myRow-1,myCol) == true && buttons[myRow-1][myCol].clicked == true)
                buttons[myRow-1][myCol].mousePressed();
              if(isValid(myRow-1,myCol+1) == true && buttons[myRow-1][myCol+1].clicked == true)
                buttons[myRow-1][myCol+1].mousePressed();
                
              if(isValid(myRow,myCol-1) == true && buttons[myRow][myCol-1].clicked == true)
                buttons[myRow][myCol-1].mousePressed();
              if(isValid(myRow,myCol+1) == true && buttons[myRow][myCol-1].clicked == true)
                buttons[myRow][myCol+1].mousePressed();
                
              if(isValid(myRow+1,myCol-1) == true && buttons[myRow+1][myCol-1].clicked == true)
                buttons[myRow+1][myCol-1].mousePressed();
              if(isValid(myRow+1,myCol) == true && buttons[myRow-1][myCol].clicked == true)
                buttons[myRow+1][myCol].mousePressed();
              if(isValid(myRow+1,myCol+1) == true && buttons[myRow-1][myCol+1].clicked == true)
                buttons[myRow+1][myCol+1].mousePressed();

        }
    } //END public void mousePressed()
 
          //if(blobs[r][c-1].isValid(r, c-1) == true && blobs[r][c-1].isMarked() == true){
          //  blobs[r][c-1].mousePressed();

    public void draw () 
    {    
        if (flagged)
            fill(252, 248, 3);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

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

/* - CALL ALL 8
          if(isValid(r-1,c-1) && buttons[r-1][c-1].isFlagged() == true)
            buttons[r-1][c-1].mousePressed();
          if(isValid(r-1,c) && buttons[r-1][c].isFlagged() == true)
            buttons[r-1][c].mousePressed();
          if(isValid(r-1,c+1) && buttons[r-1][c+1].isFlagged() == true)
            buttons[r-1][c+1].mousePressed();
            
          if(isValid(r,c-1) && buttons[r][c-1].isFlagged() == true)
            buttons[r][c-1].mousePressed();
          if(isValid(r,c+1) && buttons[r][c-1].isFlagged() == true)
            buttons[r][c+1].mousePressed();
            
          if(isValid(r+1,c-1) && buttons[r-1][c-1].isFlagged() == true)
            buttons[r+1][c-1].mousePressed();
          if(isValid(r+1,c) && buttons[r-1][c].isFlagged() == true)
            buttons[r+1][c].mousePressed();
          if(isValid(r+1,c+1) && buttons[r-1][c+1].isFlagged() == true)
            buttons[r+1][c+1].mousePressed();
*/     
     
