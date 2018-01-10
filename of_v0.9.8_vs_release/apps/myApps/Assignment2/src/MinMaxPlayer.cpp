//
//  MinMaxPlayer.cpp
//  TicTacToe
//
//  Created by David Stritzl on 29/11/15.
//
// Famke van Meurs & Maartje Aalders

#include "MinMaxPlayer.hpp"
#include <iostream>
#include <cassert>
#include <climits>
#include <cstdlib>
#include <vector>

Position MinMaxPlayer::getNextMove(Board const& board, Field current_field) {
	//get all the empty positions and initialize score and bestMove
	std::vector<Position> possible_moves = board.getEmptyPositions();
	int score = -1000;
	int bestMove = 0;

	//loops through all the moves and make a copy of the board
	for (int i = 0; i < possible_moves.size(); i++) {
		Board boardCopy = Board(board);
		// player moves to a position, does not matter where yet
		boardCopy.doMove(possible_moves[i], current_field);
		//recursive function to determine the score 
		int tempScore = -getMinMaxScore(boardCopy, ~current_field, 0);
		// determines the best move, based on the score
		if (tempScore > score) {
			score = tempScore;
			bestMove = i;
		}
	}
	return possible_moves[bestMove];
}

int MinMaxPlayer::getMinMaxScore(Board const& board, Field current_field, int depth) {


	// determines the score 
	if (board.isWinner(current_field)) {
		return 1000;
	}
	else if (board.isWinner(~current_field)) {
		return -1000;
	}
	else if (board.isFull()) {
		return 0;
	}
	else if (depth >= 2) {
		
		int heuristicScore = -20;
		int twoX = 0;
		int oneX = 0;
		int twoO = 0;
		int oneO = 0;

		// loops through the grid fields vertical, checks the rows
		for (int y = 0; y < GRID_SIZE; y++) {
			int current = 0;
			int other = 0;
			//check horizontal positions
			for (int x = 0; x < GRID_SIZE; x++) {
				// when there is an X then it should get counted
				if (board.getField(0, y) == current_field) {
					current++;
				}
				//when there is an O then it should get counted
				if (board.getField(0, y) == ~current_field) {
					other++;
				}
			}
			//see if two symbols are next to each other and what the score should be then
			if (other == 2 && current == 0) {
				twoO++;
			}
			if (current == 2 && other == 0) {
				twoX++;
			}
			if (other == 1 && current == 0) {
				oneO++;
			}
			if (current == 1 && other == 0) {
				oneX++;
			}
		}


		// loops through the grid fields horizontal, checks the columns 
		for (int x = 0; x < GRID_SIZE; x++) {
			int current = 0;
			int other = 0;
			//check vertical positions
			for (int y = 0; y < GRID_SIZE; y++) {
				// when there is an X then it should get counted
				if (board.getField(0, y) == current_field) {
					current++;
				}
				//when there is an O then it should get counted
				if (board.getField(0, y) == ~current_field) {
					other++;
				}
			}
			//see if two symbols are next to each other and what the score should be then
			if (other == 2 && current == 0) {
				twoO++;
			}
			if (current == 2 && other == 0) {
				twoX++;
			}
			if (other == 1 && current == 0) {
				oneO++;
			}
			if (current == 1 && other == 0) {
				oneX++;
			}
		}

		// diagonal
		int numberofX = 0;
		int numberofO = 0;
		//loop through diagonal from left to right, checks how many X's and O's are there
		for (int i = 0; i < GRID_SIZE; i++) {
			if (board.getField(i, i) == current_field) {
				numberofX++;
			}
			else if (board.getField(i, i) == ~current_field) {
				numberofO++;
			}
		}
		//loop through diagonal from right to left, checks how many X's and O's are there
		for (int x = 0; x < GRID_SIZE; x++) {
			int y = GRID_SIZE - 1 - x;
			if (board.getField(x, y) == current_field) {
				numberofX++;
			}
			else if (board.getField(x, y) == ~current_field) {
				numberofO++;
			}
		}
		// determines the values for the score
		if (numberofX == 1) {
			oneX++;
		}
		if (numberofO == 1) {
			oneO++;
		}
		if (numberofX == 2) {
			twoX++;
		}
		if (numberofO == 2) {
			twoO++;
		}

		//formula for heuristics 
		heuristicScore = (3 * twoX + oneX) - (3 * twoO + oneO);
		
		return heuristicScore;
	}

	//get all possible moves and initialize a score 
	std::vector<Position> possible_moves = board.getEmptyPositions();
	int score = -10000;

	// loop through all the possible moves and make a copy of the board
	for (int i = 0; i < possible_moves.size(); i++) {
		Board boardCopy = Board(board);
		// player moves to a position, does not matter where yet
		boardCopy.doMove(possible_moves[i], current_field);
		//recursive function to determine the score, if the score is bigger than the initialized score -> update
		int tempScore = -getMinMaxScore(boardCopy, ~current_field, depth++);
		if (tempScore > score) {
			score = tempScore;
		}
	}
	return score;
}
