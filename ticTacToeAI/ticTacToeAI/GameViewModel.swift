//
//  GameViewModel.swift
//  ticTacToeAI
//
//  Created by Hussain on 5/5/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDis = false
    @Published var alertItem: AlertItem?
    @Published var dif: Difficulty = .veryEasy
    @Published var color: Color = Color("red")
    
    func proccesPlayerMove(for i: Int) {
        if isSquareOccupied(in: moves, forIndex: i) { return }
        moves[i] = Move(player: .human, boardIndex: i)
        
        if checkWinCon(for: .human, in: moves) {
            alertItem = AlertContent.humanWin
            return
        }
        
        if checkDraw(in: moves) {
            alertItem = AlertContent.draw
            return
        }
        isBoardDis = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isBoardDis = false
            if checkWinCon(for: .computer, in: moves) {
                alertItem = AlertContent.computerWin
                return
            }
            if checkDraw(in: moves) {
                alertItem = AlertContent.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPos = Set(computerMoves.map { $0.boardIndex })
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPos = Set(humanMoves.map { $0.boardIndex })
        let centerSquare = 4
        var movePosition = Int.random(in: 0..<9)
        
        
        
        if dif == .hard {
            // if can win, win
            for pattern in winPatterns {
                let winPos = pattern.subtracting(computerPos)
                
                if winPos.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPos.first!)
                    if isAvailable { return winPos.first! }
                }
            }
            
            
            // cant win, block
            for pattern in winPatterns {
                let winPos = pattern.subtracting(humanPos)
                
                if winPos.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPos.first!)
                    if isAvailable { return winPos.first! }
                }
            }
            
            
            // cant block, mid
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {
                return centerSquare
            }
            
            // no mid, random
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
        } else if dif == .medium {
            // cant win, block
            for pattern in winPatterns {
                let winPos = pattern.subtracting(humanPos)
                
                if winPos.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPos.first!)
                    if isAvailable { return winPos.first! }
                }
            }
            
            
            // cant block, mid
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {
                return centerSquare
            }
            
            // no mid, random
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
        } else if dif == .easy {
            // cant block, mid
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {
                return centerSquare
            }
            
            // no mid, random
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
        } else if dif == .veryEasy {
            // no mid, random
            while isSquareOccupied(in: moves, forIndex: movePosition) {
                movePosition = Int.random(in: 0..<9)
            }
        }
        return movePosition
    }
    
    
    func checkWinCon(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPos = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPos) { return true }
        
        return false
    }
    func checkDraw(in moves: [Move?]) -> Bool {
        moves.compactMap { $0 }.count == 9
    }
    
    func restartGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
