//
//  ComputerPlay.swift
//  TicTacTeo
//
//  Created by Manvitha on 30/08/25.
//

class ComputerPlay{
    
   static var board = ["", "", "",
                "", "", "",
                "", "" , ""]
    
    private static func isWinner(_ player: String, _ board: [String]) -> Bool {
        let winningCombos = [
            [0,1,2], [3,4,5], [6,7,8], // rows
            [0,3,6], [1,4,7], [2,5,8], // columns
            [0,4,8], [2,4,6]           // diagonals
        ]
        return winningCombos.contains { combo in
            combo.allSatisfy { board[$0] == player }
        }
    }
   private static func isBoardFull(_ board: [String]) -> Bool {
        return !board.contains("")
    }
   private static func minimax(board: [String], depth: Int, isMaximizing: Bool) -> Int {
        if isWinner("O", board) { return 10 - depth }
        if isWinner("X", board) { return depth - 10 }
        if isBoardFull(board) { return 0 }
        
        if isMaximizing {
            var bestScore = Int.min
            for i in 0..<9 {
                if board[i] == "" {
                    var newBoard = board
                    newBoard[i] = "O"
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: false)
                    bestScore = max(bestScore, score)
                }
            }
            return bestScore
        } else {
            var bestScore = Int.max
            for i in 0..<9 {
                if board[i] == "" {
                    var newBoard = board
                    newBoard[i] = "X"
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: true)
                    bestScore = min(bestScore, score)
                }
            }
            return bestScore
        }
    }

   static func bestMove() -> Int? {
        var bestScore = Int.min
        var move: Int? = nil
        
        for i in 0..<9 {
            if ComputerPlay.board[i] == "" {
                var newBoard = ComputerPlay.board
                newBoard[i] = "O"
                let score = minimax(board: newBoard, depth: 0, isMaximizing: false)
                
                if score > bestScore {
                    bestScore = score
                    move = i
                }
            }
        }
        return move
    }
    
    static func randomMove() -> Int?{
        if isBoardFull(ComputerPlay.board){
            return nil
        }
        let randomIndex = Int.random(in: 0..<board.count)
        if(board[randomIndex] == ""){
            return randomIndex
        }
        return randomMove()
    }
    
    static func mediumMove() -> Int?{
        for i in 0..<9 {
                if board[i] == "" {
                    var newBoard = board
                    newBoard[i] = "O"
                    if isWinner("O", newBoard) {
                        return i
                    }
                }
            }
        for i in 0..<9{
            if board[i] == "" {
                var newBoard = board
                newBoard[i] = "X"
                if isWinner("X", newBoard){
                    return i
                }
            }
        }
        
        return randomMove()
    }
    
}
