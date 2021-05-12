//
//  GameView.swift
//  ticTacToeAI
//
//  Created by Hussain on 5/5/21.
//

import SwiftUI

struct GameView: View {
    @StateObject var VM = GameViewModel()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    GameBoard(VM: VM, geometry: geometry)
                    Spacer()
                }
                .disabled(VM.isBoardDis)
                .padding()
                .alert(item: $VM.alertItem, content: { AT in
                    Alert(title: AT.title, message: AT.message, dismissButton: .default(AT.buttonTitle, action: { VM.restartGame() }))
                })
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct GameSquareView: View {
    var geometry: GeometryProxy
    var body: some View {
        Rectangle()
            .foregroundColor(Color("red"))
            .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
            .cornerRadius(15)
    }
}

struct PlayerIndecator: View {
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.black)
    }
}

struct GameBoard: View {
    var VM: GameViewModel
    var geometry: GeometryProxy
    var body: some View {
        LazyVGrid(columns: VM.columns) {
            ForEach(0 ..< 9) { i in
                ZStack {
                    GameSquareView(geometry: geometry)
                    
                    PlayerIndecator(systemImageName: VM.moves[i]?.indicator ?? "")
                }.onTapGesture {
                    VM.proccessPlayerMove(for: i)
                }
                .shadow(color: Color("red").opacity(0.4), radius: 5, x: 0, y: 5)
            }
        }
    }
}
