//
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/24/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
        
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(score: Int) {
        let context = persistentContainer.viewContext
        let newScore = Score(context: context)
        
        print("score trying to print: \(score)")
        
        newScore.score = Int16(score)
        
        do {
            print("trying to save")
            try context.save()
            print("saved")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            print("error in 'addScore")
        }
    }
    
    /**
     Retrieve all the scores from CoreData.
     */
    func fetchScores() -> [Score] {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Score> = Score.fetchRequest()
        
        do {
            
            let scoresArray = try context.fetch(request)
            print("Inside CoreDataManager: \(scoresArray)")
            return scoresArray
            
        } catch {
            
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            return []
        }
    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> Int {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Score> = Score.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        
        request.fetchLimit = 1
        
        do {
            let score = try context.fetch(request)
            
            if let highScore = score.first {
                return Int(highScore.score)
            } else {
                return 0
            }
        } catch {
            fatalError("Unresolved error in calculateHighScore")
            return 0
        }
    }
}
