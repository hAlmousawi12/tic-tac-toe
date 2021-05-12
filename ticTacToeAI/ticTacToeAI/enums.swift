//
//  enums.swift
//  ticTacToeAI
//
//  Created by Hussain on 5/5/21.
//

import SwiftUI

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        player == .human ? "xmark" : "circle"
    }
}
