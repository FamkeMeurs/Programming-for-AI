//
//  GridElement.hpp
//  SearchStragies
//
//  Created by David Stritzl on 08/11/15.
//
//

#ifndef GridElement_hpp
#define GridElement_hpp

#include "Direction.hpp"

class GridElement {
public:
    GridElement();
    
    void reset();
    
    void draw();
    void drawWall(Direction);
    
    void setWall(Direction, bool);
    
    int x, y;
    
    GridElement *neighbours[N_DIRECTIONS];
    bool walls[N_DIRECTIONS];
    
    // variables for maze generation and path finding
    bool visited;
    bool marked;
    
    GridElement *parent;
    int length_of_path;
    int score;
};

#endif /* GridElement_hpp */
