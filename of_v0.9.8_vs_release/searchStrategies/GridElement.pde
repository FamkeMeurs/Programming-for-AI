class GridElement {
  boolean visited;  // some search algorithms need the info whether a cell was already visited
  boolean marked;
  boolean wallNorth, wallEast, wallWest, wallSouth; // has this cell a wall in n/e/s/w direction
  int xCoord, yCoord;                     // a cell needs to know its coordinates for drawing
  GridElement north, east, west, south;   // these are the neighbours in all directions
  GridElement parent;                     // for recovering the path back in bfs
  int xCenter, yCenter, xDistance, yDistance; // the center of a cell and its dimensions
  int costs;

  GridElement( int i, int j) {
    visited = false;
    marked = false;
    // initially all walls are there
    wallNorth = true;
    wallEast = true;
    wallSouth = true;
    wallWest = true;

    xCoord=i;
    yCoord=j;

    // initially no neighbours
    north = null;
    east = null;
    west = null;
    south = null;

    // initially no parent
    parent=null;

    // values for drwaing that can be treated as constants for the class
    // determine the coordinates of the center of the cell
    xDistance = int(width/(GRIDSIZE+2));
    yDistance=  int(height/(GRIDSIZE+2));
    xCenter= (xCoord+2) * xDistance;
    yCenter= (yCoord+2) * yDistance;
  }

  void drawElement() {
    // draw the four walls of a cell, if they are there
    if (this.wallNorth) line(xCenter-(xDistance/2), yCenter-(yDistance/2), xCenter+(xDistance/2), yCenter-(yDistance/2));
    if (this.wallEast) line(xCenter+(xDistance/2), yCenter-(yDistance/2), xCenter+(xDistance/2), yCenter+(yDistance/2));
    if (this.wallSouth) line(xCenter-(xDistance/2), yCenter+(yDistance/2), xCenter+(xDistance/2), yCenter+(yDistance/2));
    if (this.wallWest) line(xCenter-(xDistance/2), yCenter-(yDistance/2), xCenter-(xDistance/2), yCenter+(yDistance/2));
    //if (this.visited) {fill(0,0,200); ellipse(xCenter, yCenter, 5,5);}
  }

  void drawWall(int direction) {
    // draw only the wall indicated - used to visualize the walls removed later
    stroke(200, 0, 0);
    switch (direction) {   
    case 0: 
      line(xCenter-(xDistance/2), yCenter-(yDistance/2), xCenter+(xDistance/2), yCenter-(yDistance/2)); 
      break; // north
    case 1: 
      line(xCenter+(xDistance/2), yCenter-(yDistance/2), xCenter+(xDistance/2), yCenter+(yDistance/2)); 
      break; // east
    case 2: 
      line(xCenter-(xDistance/2), yCenter+(yDistance/2), xCenter+(xDistance/2), yCenter+(yDistance/2)); 
      break; // south
    case 3: 
      line(xCenter-(xDistance/2), yCenter-(yDistance/2), xCenter-(xDistance/2), yCenter+(yDistance/2));        // west
    }
    stroke(0);
  }



  void markCell() {  
    // sometimes it is useful to mark an actual cell, during search, for visualisation
    fill(200, 0, 0); 
    noStroke(); 
    ellipse(xCenter, yCenter, 5, 5); 
    stroke(0);
  }

  void markCell(color c) {
    // sometimes it is useful to mark an actual cell, during search, for visualisation
    // here with colour
    fill(c);
    noStroke(); 
    ellipse(xCenter, yCenter, 5, 5); 
    stroke(0);
  }


  void removeEast() {
    // in our grid walls are double: if a cell has an east-wall its east-neighbour has a west-wall
    // and both walls need to be removed
    if (wallEast && this.east != null) { 
      this.wallEast=false;
      this.east.wallWest = false;
    }
  }

  void removeSouth() {
    // in our grid walls are double: if a cell has an east-wall its east-neighbour has a west-wall
    // and both walls need to be removed
    if (wallSouth && this.south != null) { 
      this.wallSouth=false;
      this.south.wallNorth = false;
    }
  }

  void removeWest() {
    // in our grid walls are double: if a cell has an east-wall its east-neighbour has a west-wall
    // and both walls need to be removed
    if (wallWest && this.west != null ) { 
      this.wallWest=false;
      this.west.wallEast = false;
    }
  }
  void removeNorth() {
    // in our grid walls are double: if a cell has an east-wall its east-neighbour has a west-wall
    // and both walls need to be removed
    if (wallNorth) { 
      this.wallNorth=false;
      if (this.north != null) {
        this.north.wallSouth = false;
      }
    }
  }

  void resetWalls() {
    // put all walls back
    // does not take into account the double walls: 
    // the neigbouging cell still might have no wall
    wallNorth = true;
    wallEast = true;
    wallSouth = true;
    wallWest = true;
  }

  void resetWalls2() {
    // put all walls back
    // take double walls and borders into account
    wallNorth = true; 
    if (this.north != null) {
      this.north.wallSouth = true;
    }
    wallEast = true;
    if (this.east != null) {
      this.east.wallWest = true;
    }
    wallSouth = true;
    if (this.south != null) {
      this.south.wallNorth = true;
    }
    wallWest = true;
    if (this.west != null) {
      this.west.wallEast = true;
    }
  }

  void removeWalls() {
    // first remove all walls, here only the single walls
    wallNorth = false;
    wallEast = false;
    wallSouth = false;
    wallWest = false;

    // then set walls if it is the border
    if (this.north == null) {
      this.wallNorth = true;
    }
    if (this.east == null) {
      this.wallEast = true;
    };
    if (this.south == null) {
      this.wallSouth = true;
    };
    if (this.west == null) {
      this.wallWest = true;
    };
  }


  void removeWalls2() {
    // remove the double walls

    if (this.north != null) {
      wallNorth = false; 
      this.north.wallSouth = false;
    }

    if (this.east != null) {
      wallEast = false;
      this.east.wallWest = false;
    }

    if (this.south != null) {
      wallSouth = false;
      this.south.wallNorth = false;
    }

    if (this.west != null) {
      wallWest = false;
      this.west.wallEast = false;
    }

    // then set walls if it is the border
    if (this.north == null) {
      this.wallNorth = true;
      if (this.east == null) {
        this.wallEast = true;
      };
      if (this.south == null) {
        this.wallSouth = true;
      };
      if (this.west == null) {
        this.wallWest = true;
      }
    }
  }



  void removeAllWalls() {
    if (wallNorth && this.north != null ) { 
      this.wallNorth=false;
    }
    if (wallEast && this.east != null ) { 
      this.wallEast=false;
    }
    if (wallSouth && this.south != null ) { 
      this.wallSouth=false;
    }
    if (wallWest && this.west != null ) { 
      this.wallWest=false;
    }
  }
}