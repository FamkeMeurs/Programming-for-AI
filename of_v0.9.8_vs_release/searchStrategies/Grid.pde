


class Grid {
  GridElement [][] grid ;   // the grid is a two-dimensional array of cells
  int gridSize;             

  Grid(int grdsz) {
    gridSize= grdsz;
    grid = new GridElement[grdsz][grdsz];

    // create the gridelements
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        grid[i][j]= new GridElement(i, j);
      }
    }

    // set the neighbours of the gridelements correctly
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        if (i%gridSize!=0) grid[i][j].west = grid[i-1][j];
        if ((i+1)%gridSize!=0) grid[i][j].east = grid[i+1][j];
        if (j!=0) grid[i][j].north = grid[i][j-1];
        if (j!=gridSize-1) grid[i][j].south = grid[i][j+1];
      }
    }
  }

  //insert here your methods for depth first search
  void depthFirstSearch() {
    // stack to organize the depth first search search
    Deque<GridElement> stack = new ArrayDeque<GridElement>(); // dfs requires a stack of GridElements

    // usage
    /* 
     GridElement myGridElement = new GridElement(10,10);  //generate a grid element
     stack.push( myGridElement);   
     
     GridElement top;
     top = stack.pop(); // get top element of the stack and store it in top
     
     */
  }

  //insert here your methods for breadth first search 
  void breadthFirstSearch() {
    // queue to organize the breadth first search
    Deque<GridElement> queue = new ArrayDeque<GridElement>(); // bfs requires a stack of GridElements
    // usage
    /* 
     GridElement myGridElement = new GridElement(10,10);  //generate a grid element
     stack.add( myGridElement);    // adds an element at the end
     
     GridElement top;
     top = stack.remove(); // get first element of the stack and store it in top
     
     */
  }

  //insert here your methods for greedy search
  void greedySearch() {
    
    // priority queue to organize the greedy search
    Queue<GridElement> queue = new PriorityQueue<GridElement>(10, new DistanceComparator());
   
    /* example for usage of the priority queue
     GridElement one = new GridElement();
     GridElement two = new GridElement();
     GridElement three = new GridElement();
     queue.add(one);
     queue.add(two);
     queue.add(three);
     
     // remove element from the middle of the queue
     queue.remove(two);
     
     // remove all elements, one by one, always the first
     while (queue.size () != 0) {
     GridElement el = queue.remove();
     
     
     */
  }

  //insert here your methods for A* search
  void aStarSearch() {
    // priority queue to organize the A* search
    Queue<GridElement> queue = new PriorityQueue<GridElement>(10, new DistanceComparator());
    
    /* example for usage of the priority queue
     GridElement one = new GridElement();
     GridElement two = new GridElement();
     GridElement three = new GridElement();
     queue.add(one);
     queue.add(two);
     queue.add(three);
     
     // remove element from the middle of the queue
     queue.remove(two);
     
     // remove all elements, one by one, always the first
     while (queue.size () != 0) {
     GridElement el = queue.remove();
     */
  }


  void generateMaze() {

    GridElement actual; // actual always points at the gridcell that we are looking at
    Deque<GridElement> stack = new ArrayDeque<GridElement>(); // grid generation requires a stack of GridElements

    // reset grid
    clearCells();
    resetWalls();

    // initialize stack and search
    actual=grid[0][0];
    actual.visited=true;

    stack.push(actual);


    // start mazegeneration
    while (!stack.isEmpty()) {    // termination: the stack is empty when it was backtracked to the startpoint
      //  while (actual.xcoord!=0 || actual.ycoord!=0 ){ // alternative termination condition

      // find whether there are unvisited neighbours of the actual cell
      // and put them in a list lon
      int countNeighbours = 0; 
      int [] lon = new int [4];
      if (actual.north !=null) { 
        if (!(actual.north.visited)) { 
          lon[countNeighbours]=0; 
          countNeighbours++;
        }
      }
      if (actual.east !=null) { 
        if (!(actual.east.visited)) { 
          lon[countNeighbours]=1;
          countNeighbours++;
        }
      }
      if (actual.south !=null) { 
        if (!(actual.south.visited)) { 
          lon[countNeighbours]=2; 
          countNeighbours++;
        }
      }
      if (actual.west !=null) { 
        if (!(actual.west.visited)) { 
          lon[countNeighbours]=3; 
          countNeighbours++;
        }
      }

      if (countNeighbours==0) { // if there are no neighbours backtrack
        // case all neighbours are visited
        actual=stack.pop();
      } else {
        //choose randomly an unvisited neighbour from the list lon
        switch (lon[int(random(countNeighbours))]) {
        case 0: 
          actual.removeNorth(); 
          stack.push(actual); 
          actual=actual.north; 
          actual.visited=true; 
          break;
        case 1: 
          actual.removeEast(); 
          stack.push(actual); 
          actual=actual.east; 
          actual.visited=true; 
          break;
        case 2: 
          actual.removeSouth(); 
          stack.push(actual); 
          actual=actual.south; 
          actual.visited=true; 
          break;
        case 3: 
          actual.removeWest(); 
          stack.push(actual); 
          actual=actual.west; 
          actual.visited=true; 
          break;
        }
      }
    }

    // maze generation is finished. but because there is only one way from start to goal
    // we randomly remove a number of walls

    { // remove randomly 20 walls
      int count = 0;
      while (count<20) {
        // choose first a random cell
        int xc=int(random(gridSize)); 
        int yc=int(random(gridSize));
        // choose a random direction: 0 is north, 1 east, 2 south, 3 west
        switch ( (int)(random(4)) ) {
        case 0: 
          if (grid[xc][yc].wallNorth && grid[xc][yc].north!=null) { // if there is a wall and it is no border
            count++;                       // one wall to remove found
            grid[xc][yc].removeNorth();   // remove it
            grid[xc][yc].drawWall(0);     // draw it red in the maze to see what was removed
          };  
          break;
        case 1: 
          if (grid[xc][yc].wallEast && grid[xc][yc].east!=null) { // if there is a wall and it is no border
            count++;                       // one wall to remove found
            grid[xc][yc].removeEast();    // remove it
            grid[xc][yc].drawWall(1);     // draw it red in the maze to see what was removed
          };  
          break;
        case 2: 
          if (grid[xc][yc].wallSouth && grid[xc][yc].south!=null) { // if there is a wall and it is no border
            count++;                       // one wall to remove found 
            grid[xc][yc].removeSouth();   // remove it
            grid[xc][yc].drawWall(2);     // draw it red in the maze to see what was removed
          };  
          break;
        case 3: 
          if (grid[xc][yc].wallWest && grid[xc][yc].west!=null) { // if there is a wall and it is no border
            count++;                       // one wall to remove found 
            grid[xc][yc].removeWest();    // remove it
            grid[xc][yc].drawWall(3);     // draw it red in the maze to see what was removed
          };  
          break;
        };
      };
    }
  }

  void drawGrid() {
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        grid[i][j].drawElement();
      }
    }
  }

  void drawMarkedCells() {
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        if (grid[i][j].marked) {
          grid[i][j].markCell();
        };
      }
    }
  }



  boolean goalReached ( GridElement g ) {
    if ((g.xCoord==gridSize-1) && (g.yCoord==gridSize-1)) {
      return true;
    } else return false;
  }

  boolean startReached ( GridElement g ) {
    if ((g.xCoord==0) && (g.yCoord==0)) {
      return true;
    } else return false;
  }


  void clearCells() {
    // reset all cells to not being visited
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        grid[i][j].visited = false;
        grid[i][j].marked = false;
      }
    }
  }

  void removeWalls() {
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        grid[i][j].removeWalls();
      }
    }
  }


  void resetWalls() {
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        grid[i][j].resetWalls();
      }
    }
  }


  void obstacles() {
    clearCells();
    removeWalls();

    //determine a circle
    // first circle around the center
    int center1x = int(random(gridSize/2-gridSize/10, gridSize/2+gridSize/10));
    int center1y = int(random(gridSize/2-gridSize/10, gridSize/2+gridSize/10));
    int radius1 = int(random(gridSize/7, gridSize/5));

    //the angles determine  the position of the gap and its size
    float angle1_1 = random(-4*PI/3, -2*PI/4); 
    float angle1_2 = random(PI/4, PI/3);

    makeCircleWalls(center1x, center1y, radius1, angle1_1, angle1_2);

    // second circle in lower part
    int radius2 = int(random(gridSize/9, (center1x-radius1)/1.5));
    int center2x = int(random(radius2, center1x-radius1-radius2));
    int center2y = int(random(radius2, center1y-radius1-radius2));

    //the angles determine  the position of the gap and its size
    float angle2_1 = random(-4*PI/3, -2*PI/4); 
    float angle2_2 = random(PI/4, PI/3);

    makeCircleWalls(center2x, center2y, radius2, angle2_1, angle2_2);

    // third circle in lower part
    int radius3 = int(random(gridSize/9, (center1x-radius1)/2));
    int center3x = int(random(center1x+radius1+gridSize/10, center1x+radius3+radius1 ));
    int center3y = int(random(center1y+radius1+gridSize/10, center1y+radius3+radius1 ));

    //the angles determine  the position of the gap and its size
    float angle3_1 = random(-4*PI/3, -2*PI/4); 
    float angle3_2 = random(PI/4, PI/3);

    makeCircleWalls(center3x, center3y, radius3, angle3_1, angle3_2);
  }

  void makeCircleWalls(int cx, int cy, int radius, float angle1, float angle2) {
    for (int i=0; i< gridSize; i++) {
      for (int j=0; j< gridSize; j++) {
        // if the circle goes through the gridelement set its walls
        if ( abs(dist(i, j, cx, cy)-radius)<0.4) { 
          grid[i][j].resetWalls2();

          // determine if in this direction should be the gap
          float minangle= angle1-angle2;
          float maxangle= angle1+angle2;
          float direction = atan2(-cy+grid[i][j].yCoord, -cx+grid[i][j].xCoord);

          if (minangle<-PI && direction>minangle+2*PI ) {
            grid[i][j].removeWalls2();
          }
          if (minangle<-PI && direction<maxangle ) {
            grid[i][j].removeWalls2();
          }
          if (minangle>-PI && direction>minangle && direction<maxangle) {
            grid[i][j].removeWalls2();
          }
        }
      }
    }
  }

  void clearArea(int first_x, int first_y, int area_width, int area_height) {
    int last_x = first_x + area_width - 1;
    int last_y = first_y + area_height - 1;

    for (int y = first_y; y <= last_y; y++) {
      for (int x = first_x; x <= last_x; x++) {
        if (x != first_x) {
          grid[x][y].wallWest = false;
        }
        if (x != last_x) {
          grid[x][y].wallEast = false;
        }
        if (y != first_y) {
          grid[x][y].wallNorth = false;
        }
        if (y != last_y) {
          grid[x][y].wallSouth = false;
        }
      }
    }
  }

  void rooms() {
    clearCells();
    resetWalls();

    float roomWidth = (float)gridSize / n_rooms;
    int room_height = gridSize / 3;

    for (int i = 0; i < n_rooms; i++) {
      int first_x = floor(i * roomWidth);
      int last_x = floor((i + 1) * roomWidth) - 1;
      int r_width = last_x - first_x + 1;

      float door_center_x = (first_x + last_x) / 2.0;
      int door_x = floor(door_center_x);
      int door_width = ceil(door_center_x + 1) - door_x;

      // clear room and door
      clearArea(first_x, 0, r_width, room_height);
      clearArea(door_x, room_height - 1, door_width, 2);

      // repeat for bottom
      clearArea(first_x, gridSize - room_height, r_width, room_height);
      clearArea(door_x, gridSize - room_height - 1, door_width, 2);
    }

    // clear center area
    clearArea(0, room_height, gridSize, gridSize - 2 * room_height);
  }

  void markGridElement(int xPosition, int yPosition) {
    // let a user mark or unmark a grid cell
    // the size of a grid element
    int xDistance = int(width/(gridSize+2));
    int yDistance=  int(height/(gridSize+2));

    // mapping the mouse position to a grid element
    int i = floor((xPosition-(xDistance/2))  / xDistance - 1);
    int j = floor( (yPosition-(xDistance/2)) / yDistance - 1);

    // add or remove cell walls depending on whether the cell is marked or not
    if (0<=i && i<gridSize && 0<=j & j<gridSize) {
      if (this.grid[i][j].marked) {
        this.grid[i][j].removeAllWalls(); 
        this.grid[i][j].marked=false;
      } else {
        this.grid[i][j].resetWalls(); 
        this.grid[i][j].marked=true;
      }
    }
  }
}