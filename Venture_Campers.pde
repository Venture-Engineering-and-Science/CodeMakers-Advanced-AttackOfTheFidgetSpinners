// Filename: Attack of the Fidget Spinners
// Camp: Venture Codemakers Advanced
// Date: Summer 2017
// Camper Name: 
// FOR USE WITH: www.semmy.me/ide

/************************************************************************
*                         GLOBAL VARIABLES
*  
*  These are variables that are used throughout the game. They set up 
*  things such as the player and lists for enemies and projectiles.
*
*
***********************************************************************/
Player p = new Player(200, 550, 25, 25, 10);
String url = "https://www.spigotmc.org/data/resource_icons/41/41184.jpg?1495413880";
PImage img;

ArrayList <Enemy> spinners = new ArrayList<Enemy>();
ArrayList <Projectile> shots = new ArrayList <Projectile>();
int EnemyTimer = 0;

// Set the level and lives variable values.
int level = 100;                                                              // Level should be 0
int lives = 0;                                                                // Lives should be 3


/************************************************************************
*                         SETUP METHOD
*  
*   This code is run ONLY once at the very begining of the program.
*
*
***********************************************************************/
void setup() {
                                                                            // Screen must be set to 600x600
  imageMode(CENTER);
  img = loadImage(url, "png");
  fill(230);
  textAlign(CENTER, CENTER);
  textSize(32);
}


/************************************************************************
*                         DRAW METHOD
*  
*   This code is run EVERY FRAME while the programming is running.
*
*
***********************************************************************/
void draw() {
// Set the background color
  background(0);
                                                                          // Display the player to the screen using its class method.
  
// Make sure the game is not over and you have lives.
  if (lives > 0) {
    fill(230);
    
    // Display the number of lives
    text("Lives: ", 0, 0, 150, 50 );                                      // Display the lives by adding +lives variable.
    // Display the score
    text("Score: "+level, 450, 0, 150, 50 );
    
    // Display the Enemies
    displayEnemies();
    
    // Display the shots fired
    displayShots();
    
    // Check the collisions of the shots and the spinners
    checkCollisions();
    
  } else {
    // Display the Game Over Text & Score
    text("Game Over", 0, 0, 600, 600 );
    text("Score: "+level, 0, 100, 600, 500);
  }
}


/************************************************************************
*                         keyPressed METHOD
*  
*  This method is run everytime an input is recieved from the keyboard.
*  By using if(), else if(), and else statements, you can bind commands
*  to specific keys.
*
***********************************************************************/
void keyPressed() {
  if (key == 'a') {
    p.moveLeft();
  }                                                                     // Add an else if statement to move the player right.
  
  else if (key == ' ') {
    shots.add(p.shoot());
  }
}


/************************************************************************
*                         displayEnemies METHOD
*  
*  This code is creates a series of enemies based on the level then draws
*  them to the screen.
*
*
***********************************************************************/
void displayEnemies() {
  if (EnemyTimer == 120 - 1 * level) {
    spinners.add(new Enemy(int(random(25, 575)), 0, 50, 50, 1, img));
    EnemyTimer = 0;
    level++;
  }
  if (spinners.size()>0) {
  // If the spinner list is populated, draw the enemies.
  for (Enemy i : spinners){
      i.draw();
  }
  }
  EnemyTimer++;
}

/************************************************************************
*                         displayShots METHOD
*  
*  This code is creates a shot and draws all the current shots to the
*  screen.
*
*
***********************************************************************/
void displayShots() {
  for (Projectile p : shots) {
    p.draw();
  }
}

/************************************************************************
*                         checkCollisions METHOD
*  
*  This method looks to see if the shots hit any of the enemies. For this
*  to work best, this method should be called every frame.
*  
*  IF there is a collision, then the shot and the enemy is removed from
*  their respecitive lists (and subsequently not draw)
*
*  IF an enemy passes the bottom of the screen, the enemy is removed along
*  with one of the player's lives.
*
*
***********************************************************************/
void checkCollisions() {
  for (int j = spinners.size() - 1; j >= 0; j--) {
    Enemy e = spinners.get(j);
    for (int i = shots.size() - 1; i >= 0; i--) {
      Projectile p = shots.get(i);
      if (p.x > e.x-(e.w/2) && p.x < (e.x+(e.w/2))) {
        if (p.y > e.y-(e.h/2) && p.y < (e.y+(e.h/2))) {
          shots.remove(i);
          spinners.remove(j);
        }
      }
    }
    if (e.y > 600) {
      spinners.remove(j);
      lives--;
    }
  }
}


/************************************************************************
*                         SPRITE CLASS
* This is a bunch of code you really don't need to worry about.
* In a normal Processing file, this would be in a different tab / file.
*
*
***********************************************************************/

public class Sprite {
  boolean alive = true;
  int x;
  int y;
  int w;
  int h;
 
  public Sprite(int xArg, int yArg, int wArg, int hArg) {
    x = xArg;
    y = yArg;
    w = wArg;
    h = hArg;
  }
}
 
public class Player extends Sprite {
  int xSpeed;
 
  public Player(int xArg, int yArg, int wArg, int hArg, int speed) {
    super(xArg, yArg, wArg, hArg);
    xSpeed = speed;
  }
 
  public void draw() {
    if (super.alive) {
      fill(color(100, 100, 200));
      rect(super.x, super.y, super.w, super.h);
    }
  }
 
  public void moveLeft() {
    super.x = super.x-xSpeed;
  }
 
  public void moveRight() {
    super.x = super.x+xSpeed;
  }
 
  public Projectile shoot() {
    return (new Projectile(super.x+(super.w/2), super.y));
  }
}


/************************************************************************
*                         ENEMY CLASS
* This is a bunch of code you really don't need to worry about.
* In a normal Processing file, this would be in a different tab / file.
*
*
***********************************************************************/
public class Enemy extends Sprite {
  int ySpeed;
  PImage img;
 
  public Enemy(int xArg, int yArg, int wArg, int hArg, int speed, PImage imgArg) {
    super(xArg, yArg, wArg, hArg);
    ySpeed = speed;
    img = imgArg;
  }
 
  public void draw() {
    if (super.alive) {
      image(img, super.x, super.y, super.w, super.h);
      super.y = super.y + ySpeed;
 
      if (super.y < 0) {
        alive = false;
      }
    }
  }
}
 
 
/************************************************************************
*                         Projectile CLASS
* This is a bunch of code you really don't need to worry about.
* In a normal Processing file, this would be in a different tab / file.
*
*
***********************************************************************/
public class Projectile extends Sprite {
  public Projectile(int x, int y) {
    super(x, y, 5, 25);
  }
  private void draw() {
    if (alive) {
      fill(color(150, 0, 0));
      rect(super.x, super.y, super.w, super.h, 25);
      super.y = super.y - 5;
    }
  }
}
