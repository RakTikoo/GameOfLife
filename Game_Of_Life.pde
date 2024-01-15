// Initialize variables


float cell_size;
int i, j;
int[][] cell_val, cell_next_val;
int cell_cnt_x;
int cell_cnt_y;

boolean paused;
boolean p_pressed;
//int cnt;

void setup() {
  // Grid size
  size(1000, 1000);
  

  // Set cell values
  cell_size = 10; // Each cell size
  cell_cnt_x = int(width/cell_size);
  cell_cnt_y = int(height/cell_size);
  //println(cell_cnt_x, cell_cnt_y);
  
  cell_val = new int[cell_cnt_x][cell_cnt_y];
  cell_next_val = new int[cell_cnt_x][cell_cnt_y];
  
  p_pressed = false;
  paused = true;
  
  // Init Cells to non
  for (i = 0; i < cell_cnt_x; i+=1) {
    for (j = 0; j < cell_cnt_y; j+=1) {
      cell_val[i][j] = 0;
    }
  }

}








void draw() {
  // Set style
  background(255);
  if(paused) frameRate(30);
  else frameRate(30);
  stroke(0, 0, 0, 185);
  strokeWeight(1);
  
  // Draw Grid
  for (i = 0; i <= width; i+=cell_size) {
    line(i, 0, i, height);
  }

  for (i = 0; i <= height; i+=cell_size) {
    line(0, i, width, i);
  }


  // Draw All Cells
  rectMode(CENTER);
  for (i = 0; i < cell_cnt_x; i+=1) {
    for (j = 0; j < cell_cnt_y; j+=1) {
      if (cell_val[i][j] == 1) {
        fill((i+25)%255, (j+25)%255, 155, 255);
        square(i*cell_size + cell_size/2, j*cell_size +cell_size/2, cell_size);
      }
    }
  }
  
  
  
  
    // Pass Values for next state
    for (i = 0; i < cell_cnt_x; i+=1) {
      for (j = 0; j < cell_cnt_y; j+=1) {
        cell_next_val[i][j] = cell_val[i][j];
      }
    }
    
  
 
  //Evolving State
  // Update Cells using game of life rules
  if (!paused) {
    for (i = 0; i < cell_cnt_x; i+=1) {
      for (j = 0; j < cell_cnt_y; j+=1) {
        int cell_alive_cnt = 0;
        //left
        if (cell_val[emod(i-1, cell_cnt_x)][emod(j, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        //right
        if (cell_val[emod(i+1, cell_cnt_x)][emod(j, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        //top
        if (cell_val[emod(i, cell_cnt_x)][emod(j+1, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        //bottom
        if (cell_val[emod(i, cell_cnt_x)][emod(j-1, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        //top right
        if (cell_val[emod(i+1, cell_cnt_x)][emod(j+1, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        // top left
        if (cell_val[emod(i-1, cell_cnt_x)][emod(j+1, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        //bottom right
        if (cell_val[emod(i+1, cell_cnt_x)][emod(j-1, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        //bottom left
        if (cell_val[emod(i-1, cell_cnt_x)][emod(j-1, cell_cnt_y)] == 1) cell_alive_cnt += 1;
        
        if (cell_val[i][j] == 1) { // Cell is alive
          if (cell_alive_cnt != 2 && cell_alive_cnt != 3) cell_next_val[i][j] = 0;
        } else { // Cell is dead
          if (cell_alive_cnt == 3) cell_next_val[i][j] = 1;
        }
      }
    }
  }





  // Pausing Logic
  if (keyPressed) {
    if ((key == 'P' || key == 'p')) {
      if (!p_pressed) {
        //println("P Pressed", cnt);
        p_pressed = true;
        paused = !paused;
        //cnt+=1;
      }
    } else {
      p_pressed = false;
    }
    // Reset logic
    if ((key == 'R' || key == 'r')) {

      paused = true;
      for (i = 0; i < cell_cnt_x; i+=1) {
        for (j = 0; j < cell_cnt_y; j+=1) {
          cell_next_val[i][j] = 0;
        }
      }
    }
  } else {
    p_pressed = false;
  }


  // Drawing on grid 
  if (mousePressed) {
    if (mouseButton == LEFT) {
      cell_next_val[floor(mouseX/cell_size)][floor(mouseY/cell_size)] = 1;
    } else {
      cell_next_val[floor(mouseX/cell_size)][floor(mouseY/cell_size)] = 0;
    }
  }
  
  
  
  // Pass Values to draw in next cycle
  for (i = 0; i < cell_cnt_x; i+=1) {
      for (j = 0; j < cell_cnt_y; j+=1) {
        cell_val[i][j] = cell_next_val[i][j];
      }
    }
  
}


// Basic Emod for edge index wrap around
int emod(int a, int b) {
  return ((a+b)%b)%b;
}
