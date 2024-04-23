//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer: Timer!
    let gameBrain = GameBrain.shared
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet var buttonsLabelArray: Array<UIButton>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numbOfButtons = buttonsLabelArray?.count ?? 0
        gameBrain.newGame(numLetters: Int(numbOfButtons))
        updateUI()
        configureTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
    
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func fireTimer(timer: Timer) {
        gameBrain.secondsRemaining -= 1
        updateUI()
        let updatedScore = gameBrain.score

        
        if gameBrain.secondsRemaining <= 0 {
            CoreDataManager.shared.addScore(score: updatedScore)
            print(updatedScore)
            timer.invalidate()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//    func newRound() {
//        
//        targetLetter = letters.randomElement()!
//        print("targetLetter: \(targetLetter)")
//        randomLetters = generateRandomLetters(numLetters: 12)
//        print("newRound: \(randomLetters)")
//        print("")
//        updateTargetLetterLabel()
//        updateLetterButtons()
//    }
//    
//    func generateRandomLetters(numLetters: Int) -> [String] {
//        var currentRandomLetters = [String]()
//        var number: Int
//        
//        currentRandomLetters = Array(letters.shuffled().prefix(numLetters))
//        print("generateRandomLetters just before inserting targetLetter: \(currentRandomLetters)")
//        print("Number in currentRandomLetters: \(currentRandomLetters.count)")
//        number = Int.random(in: 0..<currentRandomLetters.count)
//        
//        if (!(currentRandomLetters.contains(targetLetter))) {
//            currentRandomLetters[number] = targetLetter
//        }
////        targetLetter = currentRandomLetters.randomElement()!
////        print(targetLetter)
//        print("generateRandomLetters: \(currentRandomLetters)")
//        return currentRandomLetters
//    }
//    
//    func calculateNewScore(selectedLetter: String) {
//        if selectedLetter == targetLetter {
//            score += 1
//        }
//    }

    
    @IBAction func letterButtonTouched(_ sender: UIButton) {
        
        gameBrain.letterSelected(letter: "\(sender.currentTitle!)")
        updateUI()
    }
    
    func updateUI() {
        var loopingNumber = 0
        
        let randomLetters = gameBrain.randomLetters
        let updatedScore = gameBrain.score
        
        
        // creating the buttons
        while loopingNumber < buttonsLabelArray?.count ?? 0 {
                    
            buttonsLabelArray![loopingNumber].setTitle(randomLetters[loopingNumber], for: .normal)
                    
            loopingNumber += 1
        }
        
        scoreLabel.text = "Score: \(updatedScore)"
        letterLabel.text = "\(gameBrain.targetLetter)"
        secondsLabel.text = "Seconds: \(gameBrain.secondsRemaining)"
    }
    
}
