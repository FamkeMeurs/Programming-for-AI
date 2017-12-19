//
//  RandomPlayer.hpp
//  TicTacToe
//
//  Created by David Stritzl on 29/11/15.
//
//

#ifndef Heuristics_hpp
#define Heuristics_hpp

#include "ComputerPlayer.hpp"

class Heuristics : public ComputerPlayer {
public:
    // use constructor of computer player
    using ComputerPlayer::ComputerPlayer;
    
    // returns the position of the next move for this player (given the current board and the symbol(Field) of the current player)
    Position getNextMove(Board const&, Field) override;
};

#endif /* RandomPlayer_hpp */
