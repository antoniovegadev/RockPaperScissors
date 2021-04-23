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
    
    @State private var animationAmount = 0.0
    @State private var scaleAmount: CGFloat = 1

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack {
                GameInfo(score: score, round: round)
                    .padding()
                
                ExpectedView(move: moves[appMove], shouldWin: shouldWin)
                    .rotation3DEffect(.degrees(animationAmount),axis: (x: 0.0, y: 1.0, z: 0.0))
                    .frame(width: 125, height: 100)
                    .foregroundColor(.white)
                    .background(shouldWin ? Color.green : Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
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
                .offset(y: -80)
                
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
            score += moveToWin[appMove] == move ? 1 : 0;
        } else {
            score += moveToLose[appMove] == move ? 1 : 0;
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
        withAnimation {
            animationAmount += 360
            shouldWin = Bool.random()
        }
    }
    
    func newGame() {
        newRound()
        score = 0
        round = 1
    }
    
}

struct GameInfo: View {
    let score: Int
    let round: Int
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Score: \(score)")
                .font(.title2)
            Text("\(round) / 10")
                .font(.title2)
        }
        .frame(width: 150, height: 75)
        .background(Color.yellow)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.yellow, lineWidth: 10))
    }
}

struct ExpectedView: View {
    let move: String
    let shouldWin: Bool
    
    var body: some View {
        VStack {
            Text(move)
                .font(.largeTitle)
            Text(shouldWin ? "Win" : "Lose")
                .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
