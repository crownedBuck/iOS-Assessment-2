//
//  StartViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import UIKit

class StartViewController: UIViewController {
    
    let gameBrain = GameBrain.shared
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("----")
        print("viewWillAppear was hit")
        print("\(gameBrain.highScore)")
        print("----")
        
        highScoreLabel.text = "High Score: \(gameBrain.highScore)"
        
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
        
//        let destinationVc = GameViewController()
//        destinationVc.modalPresentationStyle = .fullScreen
//        present(destinationVc, animated: true)
        
        /* Need shouldPreformSeque? maybe? */
    }
    
}
