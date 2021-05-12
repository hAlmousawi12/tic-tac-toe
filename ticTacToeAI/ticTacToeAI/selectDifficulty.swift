//
//  selectDifficulty .swift
//  ticTacToeAI
//
//  Created by Hussain on 5/12/21.
//

import SwiftUI

struct selectDifficulty: View {
    @StateObject var VM = GameViewModel()
    @State var selection: Int? = nil
    @Binding var aColor: Color
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: 50) {
                    Spacer()
                    linkk(selection: $selection, geometry: geometry, VM: VM, dif: .veryEasy, color: Color("blue"), txt: "Very Easy", aColor: $aColor)
                    linkk(selection: $selection, geometry: geometry, VM: VM, dif: .easy, color: Color("yellow"), txt: "Easy", aColor: $aColor)
                    linkk(selection: $selection, geometry: geometry, VM: VM, dif: .medium, color: Color("orange"), txt: "Medium", aColor: $aColor)
                    linkk(selection: $selection, geometry: geometry, VM: VM, dif: .hard, color: Color("red"), txt: "Hard", aColor: $aColor)
                    Spacer()
                }
            }
        }.navigationBarHidden(true)
    }
}

struct linkk: View {
    @Binding var selection: Int?
    var geometry: GeometryProxy
    var VM: GameViewModel
    
    var dif: Difficulty
    var color: Color
    var txt: String
    @Binding var aColor: Color
    var body: some View {
        NavigationLink(destination: GameView(VM: VM), tag: 1, selection: $selection) {
            Button(action: {
                self.VM.color = color
                self.VM.dif = dif
                self.selection = 1
                self.aColor = color
            }) {
                HStack {
                    Spacer()
                    Text(txt)
                        .bold()
                        .font(.title2)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            .frame(width: geometry.size.width - 30, height: 75)
            .background(color)
            .cornerRadius(15)
            .shadow(color: color, radius: 5, x: 0, y: 5)
        }
    }
}
