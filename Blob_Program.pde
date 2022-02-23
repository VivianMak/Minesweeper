import de.bezier.guido.*;
private Blob[][] blobs; 

void setup ()
{
  size(400, 400);
  // make the manager
  Interactive.make( this );
  blobs = new Blob[10][10];
  for (int r = 0; r < 10; r++)
    for (int c = 0; c < 10; c++)
      blobs[r][c] = new Blob(r, c);
}
void draw() {
}//empty

public class Blob
{
  private int r, c;
  private float x, y, width, height;
  private boolean marked;

  public Blob ( int rr, int cc )
  {
    width = 40;
    height = 40;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    marked = Math.random() < .5;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isValid(int row, int col)
  {
    if (row>=0 && row<10 && col>=0 && col<10)
      return true;
    else
      return false;
  }

  public void mousePressed () 
  {
    marked = false;
    //your code here
    //if position to left is valid and marked
    //call mousePressed for the blob on left
  }
  public void draw () 
  {    
    if (marked)
      fill(50);
    else 
    fill( 255 );

    rect(x, y, width, height);
    fill(0);
  }
}
