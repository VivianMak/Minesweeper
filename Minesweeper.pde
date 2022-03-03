import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
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
public void setMines()
{
    //STEP #9
    //Add multiple?? 
    //with while(mines.size() < NUM_MINES)
    int r, c;
    r = (int)(Math.random()* NUM_ROWS)+1;
    c = (int)(Math.random()* NUM_COLS)+1;
    //contain only works with arraylist and strings
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
    }
    System.out.println(mines);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    //STEP #11
    if(r >= 0 && r < 5 && c >= 0 && c < 5)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //STEP #12
    for(int r = row-1;r<=row+1;r++)
      for(int c = col-1; c<=col+1;c++)
        if(isValid(r,c) && buttons[r][c].isFlagged()==true)
          numMines++;
    if(buttons[row][col].isFlagged()==true)
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
    public void mousePressed () 
    {
        clicked = true;
        //STEP #13
        int r = myRow;
        int c = myCol;
        
        if(mouseButton == RIGHT){
          if(buttons[r][c].flagged == true){
            buttons[r][c].flagged = false;
            clicked = false;
          }else{
            buttons[r][c].flagged = true;
          }
        }else if(mines.contains(this)){
          displayLosingMessage(); 
        }else if(countMines(r,c) > 0){
          setLabel(countMines(r,c));
        }else{
          //have to call all 8
          buttons[r-1][c-1].mousePressed();
          buttons[r-1][c].mousePressed();
          buttons[r-1][c+1].mousePressed();
          
          buttons[r][c-1].mousePressed();
          buttons[r][c+1].mousePressed();
          
          buttons[r+1][c-1].mousePressed();
          buttons[r+1][c].mousePressed();
          buttons[r+1][c+1].mousePressed();
        }
        
        //recursion to go all directions
        //chekc if valid first and unclicked??
 
    public void draw () 
    {    
        if (flagged)
            fill(0);
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
}
