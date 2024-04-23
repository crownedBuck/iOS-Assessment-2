//
//  GameBrain.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import Foundation
//import CoreData
//import UIKit

class GameBrain {
    
    static let shared = GameBrain()
    
    var targetLetter = ""
    var randomLetters: [String] = []
    var score = 0
    var highScore = 0
    var numLetters = 0
    var secondsRemaining = 30
    
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func generateRandomLetters() -> [String] {
        
        var currentRandomLetters = [String]()
        var number: Int
        
        currentRandomLetters = Array(letters.shuffled().prefix(numLetters))
//        print("generateRandomLetters just before inserting targetLetter: \(currentRandomLetters)")
//        print("Number in currentRandomLetters: \(currentRandomLetters.count)")
        if currentRandomLetters.count != 0 {
            number = Int.random(in: 0..<currentRandomLetters.count)
            
            if (!(currentRandomLetters.contains(targetLetter))) {
                currentRandomLetters[number] = targetLetter
            }
        }
        
//        targetLetter = currentRandomLetters.randomElement()!
//                print(targetLetter)
//        print("generateRandomLetters: \(currentRandomLetters)")
        return currentRandomLetters
    }
    
    func newRound() {
        targetLetter = letters.randomElement()!
//        print("targetLetter: \(targetLetter)")
        randomLetters = generateRandomLetters()
//        print("newRound: \(randomLetters)")
        print("")
                
    }
    
    func newGame(numLetters: Int) {
        self.numLetters = numLetters
        score = 0
        secondsRemaining = 30
        newRound()
    }
    
    func letterSelected(letter: String) {
        if letter == targetLetter {
            score += 1
            if score > highScore {
                highScore += 1
                print("highScore hit!")
                print("\(highScore)")
            }
        }
        
        newRound()
    }
}
