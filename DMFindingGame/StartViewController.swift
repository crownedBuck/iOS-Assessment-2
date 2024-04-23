//
//  StartViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import UIKit

class StartViewController: UIViewController {
    
    let highScore = CoreDataManager.shared.calculateHighScore()
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        highScoreLabel.text = "High Score: \(highScore)"
        
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
        
        //        let destinationVc = GameViewController()
        //        destinationVc.modalPresentationStyle = .fullScreen
        //        present(destinationVc, animated: true)
        
        /* Need shouldPreformSeque? maybe? */
    }
    
    @IBSegueAction func scoresPressed(_ coder: NSCoder) -> ScoresViewController? {
        ScoresViewController(
            coder: coder
        )
    }
    
}
