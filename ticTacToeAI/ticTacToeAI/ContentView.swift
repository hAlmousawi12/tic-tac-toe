//
//  ContentView.swift
//  ticTacToeAI
//
//  Created by Hussain on 5/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var aColor: Color = Color("red")
    var body: some View {
        NavigationView {
            selectDifficulty(aColor: $aColor)
        }.accentColor(aColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
