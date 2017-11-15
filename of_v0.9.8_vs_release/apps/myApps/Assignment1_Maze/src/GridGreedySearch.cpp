//
//  GridGreedySearch.cpp
//  SearchStragies
//
//  Created by David Stritzl on 08/11/2016.
//
//

#include "Grid.hpp"

#include <iostream>

#include "PriorityQueue.hpp"

// distance comparison class for priority queue
class DistanceCompare {
public:
    bool operator()(GridElement const *a, GridElement const *b) const {
        return MANHATTAN_DISTANCE_TO_END(a) > MANHATTAN_DISTANCE_TO_END(b);
    }
};

void Grid::greedySearch() {
    // priority queue which sorts elements based on its score (score is a member of GridElement)
    // for greedy search, this score could be the manhattan distance (from the current element) to the end
    PriorityQueue<GridElement *, DistanceCompare> queue;
    
    //
    // USAGE
    //
    // - add element (of type GridElement *) to the the queue:
    // queue.push(element)
    //
    // - remove the element with the lowest score from the queue: (note: this will crash the program if the queue is empty)
    // queue.pop()
    //
    // - get element from the front of the queue: (note: this will crash the program if the queue is empty)
    // queue.front()
    //   example:
    // GridElement *element = queue.front();
    //
    // - check if the queue is empty:
    // queue.empty()
    //   example:
    // bool is_empty = queue.empty();
    //
    // - remove a given element (of type GridElement *) (at any position) from the queue:
    // queue.erase(element)
    //   example: (updating the score of an element in the queue (and therefore its position))
    // queue.erase(element);
    // element->score = new_score; // the calculation of the value new_score is left to the user
    // queue.push(element);
    //
}
