//
//  Game.swift
//  TicTacToe
//
//  Created by Iyin Raphael on 10/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Game {
    
    enum GameState {
        case active(GameBoard.Mark) // Active player
        case cat
        case won(GameBoard.Mark) // Winning player
    }
    
    mutating internal func restart() {
        board = GameBoard()
        var _ = GameState.active(.x)
        winningPlayer = nil 
        
    }
    
    
    mutating internal func makeMark(at coordinate: Coordinate) throws {
        guard case let GameState.active(activePlayer) = gameState else {
            NSLog("Game is over")
            return
        }
        
        do {
            try board.place(mark: activePlayer, on: coordinate)
            if game(board: board, isWonBy: activePlayer) {
                gameState = .won(activePlayer)
                gameIsOver = true
            } else if board.isFull {
                gameState = .cat
                winningPlayer = nil
            } else {
                let newPlayer = activePlayer == .x ? GameBoard.Mark.o : GameBoard.Mark.x
                gameState = .active(newPlayer)
            }
        } catch {
            NSLog("Illegal move")
        }
    }
    
    private(set) var board: GameBoard
    var gameState: GameState
    internal var activePlayer: GameBoard.Mark?
    internal var gameIsOver: Bool = false
    internal var winningPlayer: GameBoard.Mark?
    
}
