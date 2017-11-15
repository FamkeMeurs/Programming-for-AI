//
//  GridElement.cpp
//  SearchStragies
//
//  Created by David Stritzl on 08/11/15.
//
//

#include "GridElement.hpp"

#include <cstdio>

#include "ofMain.h"
#include "constants.h"

GridElement::GridElement() {
    // reset all neighbours
    for(int direction = 0; direction < N_DIRECTIONS; direction++) {
        neighbours[direction] = NULL;
    }
    
    reset();
}

void GridElement::reset() {
    // reset all walls
    for(int direction = 0; direction < N_DIRECTIONS; direction++) {
        walls[direction] = true;
    }
    
    visited = false;
    marked = false;
    parent = NULL;
    length_of_path = -1;
    score = 0;
}

void GridElement::draw() {
    // draw background if visited
    if(visited) {
        ofSetColor(200);
        ofDrawRectangle(x * GRID_ELEMENT_WIDTH, y * GRID_ELEMENT_HEIGHT, GRID_ELEMENT_WIDTH, GRID_ELEMENT_HEIGHT);
    }
    
    // draw circle if marked
    if(marked) {
        ofSetColor(255, 0, 0);
        ofDrawEllipse((x + 0.5) * GRID_ELEMENT_WIDTH, (y + 0.5) * GRID_ELEMENT_HEIGHT, GRID_ELEMENT_WIDTH * 0.5, GRID_ELEMENT_HEIGHT * 0.5);
    }
    
    // draw all walls
    for(int direction = 0; direction < N_DIRECTIONS; direction++) {
        if(walls[direction]) {
            drawWall((Direction)direction);
        }
    }
}

void GridElement::drawWall(Direction direction) {
    ofSetColor(0);
    
    switch(direction) {
        case DirectionNorth:
            ofDrawLine(x * GRID_ELEMENT_WIDTH, y * GRID_ELEMENT_HEIGHT, (x + 1) * GRID_ELEMENT_WIDTH, y * GRID_ELEMENT_HEIGHT);
            break;
        case DirectionEast:
            ofDrawLine((x + 1) * GRID_ELEMENT_WIDTH, y * GRID_ELEMENT_HEIGHT, (x + 1) * GRID_ELEMENT_WIDTH, (y + 1) * GRID_ELEMENT_HEIGHT);
            break;
        case DirectionSouth:
            ofDrawLine(x * GRID_ELEMENT_WIDTH, (y + 1) * GRID_ELEMENT_HEIGHT, (x + 1) * GRID_ELEMENT_WIDTH, (y + 1) * GRID_ELEMENT_HEIGHT);
            break;
        case DirectionWest:
            ofDrawLine(x * GRID_ELEMENT_WIDTH, y * GRID_ELEMENT_HEIGHT, x * GRID_ELEMENT_WIDTH, (y + 1) * GRID_ELEMENT_HEIGHT);
            break;
    }
}

void GridElement::setWall(Direction direction, bool is_solid) {
    walls[direction] = is_solid;
    
    // set opposite wall if it exists
    if(neighbours[direction] != NULL) {
        neighbours[direction]->walls[oppositeDirection(direction)] = is_solid;
    }
}
