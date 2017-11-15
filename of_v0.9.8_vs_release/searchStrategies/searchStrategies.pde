// framework for search strategies
// generates maze, obstacles and room scenarios for the search algorithms 
// for the course programming, module 6, assignment 1
// angelika mader, version november 2016

/* for the assignment you have to fill in the methods
   depthFirstSearch(), breadthFirstSearch(), greedeySearch() and aStarSearch() in the class Grid
*/

/*
 press "m" for generation of a new maze
 press "d" for a depth first search
 press "b" for a breadth first search
 press "g"  for greedy search
 press "a" for A* search
 press "c" to clear the actual maze (but keep it)
 press "o" for a grid with obstacles
 press "r" for a room based grid
 
 press the mouse on gridcells to add or remove walls of individual cells
 
 */

import java.util.Deque;
import java.util.ArrayDeque;
import java.util.PriorityQueue;
import java.util.Queue;

int GRIDSIZE=30;
int n_rooms =5;


Grid grid;

void setup() {
  size (500, 500);
  grid = new Grid (GRIDSIZE);
}


void draw() {
  background(200, 255, 255);
  grid.drawGrid();  // 
  grid.drawMarkedCells();
}

void keyPressed() {
  switch (key) {
  case 'm': background(200, 255, 255); grid.generateMaze(); grid.drawGrid(); break; // maze generation
  case 'c': background(200, 255, 255); grid.clearCells(); grid.drawGrid(); break;  // clear cells of maze
  case 'o': background(200, 255, 255); grid.obstacles(); grid.drawGrid(); break; // generate obstacles
  case 'r': background(200, 255, 255); grid.rooms(); grid.drawGrid(); break; //generate rooms
  case 'd': grid.depthFirstSearch(); grid.drawMarkedCells(); break;  //depth first search
  case 'b': grid.breadthFirstSearch(); break;   // breadth first search
  case 'g': grid.greedySearch(); break; // greedy search
  case 'a': grid.aStarSearch(); break; // A* search
  
  }
}

void mousePressed() {
  // mark or unmark a cell manually, ie add or remove walls
  grid.markGridElement(mouseX, mouseY);
}