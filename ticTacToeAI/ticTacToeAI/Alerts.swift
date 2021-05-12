//
//  Alerts.swift
//  ticTacToeAI
//
//  Created by Hussain on 5/5/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContent {
   static let humanWin = AlertItem(title: Text("You Win!"), message: Text("You Are so smart. you beat your own AI"), buttonTitle: Text("Hell, Yeah"))
   static let computerWin = AlertItem(title: Text("You Lost"), message: Text("You programmed a super AI"), buttonTitle: Text("Rematch"))
   static let draw = AlertItem(title: Text("Draw"), message: Text("What a battle of wits we have here..."), buttonTitle: Text("Try again"))
}
