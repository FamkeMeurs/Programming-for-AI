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
	int depth = 0;
	
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
