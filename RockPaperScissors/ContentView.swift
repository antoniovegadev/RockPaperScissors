//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Antonio Vega on 4/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var showGameOverAlert = false
    @State private var round = 1

    let moves = ["✊","✋","✌️"]
    let moveToWin = [2, 0, 1]
    let moveToLose = [1, 2, 0]

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Score: \(score)")
                        .font(.title2)
                    Text("Round \(round)")
                }.padding()
                
                Text(moves[appMove])
                    .font(.largeTitle)
                Text(shouldWin ? "Win" : "Lose")
                    .font(.title)
                
                Spacer()
                
                HStack {
                    ForEach(0 ..< moves.count) { index in
                        Button(action: {
                            shoot(move: index)
                        }) {
                            Text(moves[index])
                                .font(.system(size: 75))
                        }
                    }
                }
                
                Spacer()
            }
        }
        
        .alert(isPresented: $showGameOverAlert, content: {
            Alert(title: Text("Game Over"), message: Text("You got \(score)/10"), dismissButton: .default(Text("New Game")) {
                newGame()
            })
        })
    }
    
    func shoot(move: Int) {
        if shouldWin {
            score += moveToWin[appMove] == move ? 1 : -1;
        } else {
            score += moveToLose[appMove] == move ? 1 : -1;
        }
        
        if round+1 > 10 {
            showGameOverAlert = true
        } else {
            newRound()
        }
    }
    
    func newRound() {
        round += 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func newGame() {
        newRound()
        score = 0
        round = 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
