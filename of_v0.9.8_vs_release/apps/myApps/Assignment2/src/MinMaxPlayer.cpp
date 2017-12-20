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
		int tempScore = -getMinMaxScore(boardCopy, ~current_field);
		// determines the best move, based on the score
		if (tempScore > score) {
			score = tempScore;
			bestMove = i;
		}
	}
	return possible_moves[bestMove];
}

int MinMaxPlayer::getMinMaxScore(Board const& board, Field current_field, int depth) {
	int depth = 2;
	int heuristicScore = -20;
	int twoX;
	int oneX;
	int twoO;
	int oneO;

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
	if (board.getField(0, 0) != Field::Empty && board.getField(0, 0) == board.getField(1, 1) || board.getField(1, 1) == board.getField(2, 2) || board.getField(0, 0) == board.getField(2, 2) && board.getField == current_field) {

	}
	if (board.getField(0, 2) != Field::Empty && board.getField(0, 2) == board.getField(1, 1) && board.getField(1, 1) == board.getField(2, 0)) {

	}


	heuristicScore = (3 * twoX + oneX) - (3 * twoO + oneO);





	// determines the score 
	if (board.isWinner(current_field)) {
		return 10;
	}
	else if (board.isWinner(~current_field)) {
		return -10;
	}
	else if (board.isFull()) {
		return 0;
	}

	//get all possible moves and initialize a score 
	std::vector<Position> possible_moves = board.getEmptyPositions();
	int score = -1000;

	// loop through all the possible moves and make a copy of the board
	for (int i = 0; i < possible_moves.size(); i++) {
		Board boardCopy = Board(board);
		// player moves to a position, does not matter where yet
		boardCopy.doMove(possible_moves[i], current_field);
		//recursive function to determine the score, if the score is bigger than the initialized score -> update
		int tempScore = -getMinMaxScore(boardCopy, ~current_field);
		if (tempScore > score) {
			score = tempScore;
		}
	}
	return score;
}
