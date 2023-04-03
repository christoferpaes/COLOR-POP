//
//  GameViewController.swift
//  Color Pop
//
//  Created by Valentina Carfagno on 5/8/19.
//  Copyright © 2019 RSC. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import os.log



var sizeOfView : CGSize!
var notWhiteColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
var notBlackColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)



class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeOfView = view.frame.size
        gameAchievements()
        //Load Title Scene
        if let view = self.view as! SKView? {
            if let scene = TitleScene(fileNamed: "TitleScene") {
                
                //Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //for now there should only be one score saved, but could be modified for the multiple players
                highScore = scores[0].score
                //Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
        
      
        } 
    //Mark: Private Functions
    
    private func gameAchievements() {
        //Load any saved score, otherwise load sample score.
        
        if let savedScores = loadScores() {
            scores += savedScores
        }
        else{
            //load the sample data.
            loadSampleScores()
        }
    }
    
    private func loadSampleScores() {
        guard let saved1 = SavedGame(name: "Color Pop", score: 0)else{
            fatalError("Unable to instatiate saved1")
        }
        scores += [saved1]
    }
    private func loadScores() -> [SavedGame]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SavedGame.ArchiveURL.path) as? [SavedGame]
    }
}
