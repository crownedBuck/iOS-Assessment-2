//
//  ScoresViewController.swift
//  DMFindingGame
//
//  Created by Laura Hart on 4/22/24.
//

import UIKit

class ScoresViewController: UITableViewController {
    
    var scoresArray: [Score] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresArray = CoreDataManager.shared.fetchScores()
        print("Scores: \(scoresArray)")
        tableView.reloadData()
//        print(scoresArray)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(scoresArray.count)
        return scoresArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scores", for: indexPath)
        
        let score = scoresArray[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = "Score: \(score.score)"
        
        cell.contentConfiguration = config
        
        return cell
    }
    
    
}
