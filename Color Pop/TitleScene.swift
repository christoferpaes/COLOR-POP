//
//  TitleScene.swift
//  Color Pop
//
//  Created by Christofer Patrick Paes on 5/9/19.
//  Copyright © 2019 Christofer Patrick Paes RSC. All rights reserved.
//

import Foundation
import SpriteKit
import os.log


var highScore : Int = 0
var scores = [SavedGame]()
var COUNTDOWN = 10


class TitleScene : SKScene {
    
    var btnPlay : UIButton!
    var btnReset : UIButton!
    var achievementTitle : UILabel!
    
    
    var gameTitle = SKLabelNode()
    var gameFAQS = SKLabelNode()
    var gameFAQ1 = SKLabelNode()
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = notBlackColor
        setUpText()
        
    }
    @objc func playTheGame() {
        
        self.view?.presentScene(GameScene(), transition:
            SKTransition.fade(withDuration: 1.0))
        btnPlay.removeFromSuperview()
        
        btnReset.removeFromSuperview()
        achievementTitle.removeFromSuperview()
        
        gameTitle.removeFromParent()
        gameFAQ1.removeFromParent()
        gameFAQS.removeFromParent()
        
        if let scene = GameScene(fileNamed: "GameScene") {
            let skView = self.view! as SKView
            skView.ignoresSiblingOrder = true
            
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
        }
    }
    @objc func resetTheGame() {
        
        achievementTitle.text = " "
        scores[0].score = 0
        highScore = 0
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(scores, toFile: SavedGame.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("High Score successfully saved", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save high score...", log: OSLog.default, type: .error)
        }
    }
    func setUpText() {
        //Be sure to scale the fonts to lable positions to fit the device view
        sizeOfView = view!.frame.size
        let ScaleYPosition = sizeOfView.height
        let btnSize : CGFloat = view!.frame.size.width/3.8
        
        
        gameTitle = SKLabelNode(fontNamed: "Marker Felt")
        gameTitle.fontColor = notWhiteColor
        gameTitle.fontSize = ScaleYPosition/9
        gameTitle.position = CGPoint(x: self.frame.midX, y: self.frame.midY + ScaleYPosition/2.7)
        gameTitle.text = " Color Pop"
        
        self.addChild(gameTitle)
        
        
        gameFAQS = SKLabelNode(fontNamed: "Marker Felt")
        gameFAQS.fontColor = notWhiteColor
        gameFAQS.fontSize = ScaleYPosition/36
        gameFAQS.position = CGPoint(x: self.frame.midX, y: self.frame.midY + ScaleYPosition/3.1)
        gameFAQS.text = "--Pick the right color balloon based on the name of the color--"
        
        self.addChild(gameFAQS)
    
        
        
        gameFAQ1 = SKLabelNode(fontNamed: "Marker Felt")
        gameFAQ1.fontColor = notWhiteColor
        gameFAQ1.fontSize = ScaleYPosition/36
        gameFAQ1.position = CGPoint(x: self.frame.midX, y: self.frame.midY + ScaleYPosition/3.4)
        gameFAQ1.text = "--  NOT the color of the font for the displayed color name  --"
        
        self.addChild(gameFAQ1)
        
        spawnBallon0()
        spawnBallon1()
        spawnBallon3()
        spawnBallon2()
 //PLAY BUTTON with image
        btnPlay = UIButton(frame: CGRect(x: 0, y: 0, width: btnSize, height: btnSize))
        btnPlay.backgroundColor = notBlackColor
        
        //left of Center
        btnPlay.center = CGPoint(x: sizeOfView.width/2, y: (sizeOfView.height/2))
        btnPlay.setImage(UIImage(named: "playColorPopButton"), for: UIControl.State.normal)
        btnPlay.addTarget(self, action: (#selector(TitleScene.playTheGame)), for: UIControl.Event.touchUpInside)
        self.view?.addSubview(btnPlay)
        
        
        //HIGH SCORE
        
        achievementTitle = UILabel(frame: CGRect(x: self.frame.midX + 20, y: (ScaleYPosition/1.18), width: sizeOfView.width - btnSize, height: 100))
        
        achievementTitle.textColor = notWhiteColor
        achievementTitle.font = UIFont(name: "Mark felt", size: ScaleYPosition/20)
        
        achievementTitle.textAlignment = NSTextAlignment.center
        
        if highScore != 0 {
            achievementTitle.text = "High Score : \(highScore)"
        }
        
        self.view?.addSubview(achievementTitle)
        
        //RESET THE HIGH SCORE
        
        btnReset = UIButton(frame: CGRect(x: 0, y: 0, width: btnSize/1.5, height: btnSize/1.5))
        
        btnReset.backgroundColor = notBlackColor
        btnReset.center = CGPoint(x: achievementTitle.frame.maxX, y: achievementTitle.frame.midY)
        btnReset.setImage(UIImage(named: "resetColorPopButton"), for: UIControl.State.normal)
        
        btnReset.addTarget(self, action: (#selector(TitleScene.resetTheGame)), for: UIControl.Event.touchUpInside)
        self.view?.addSubview(btnReset)
    }
    
    //spawn slightly smaller balloons with room for the play button
    
    func spawnBallon0() {
        
        balloon0 = SKSpriteNode(imageNamed: "orangeBalloon")
        balloon0?.size = CGSize(width: (balloonSize.width * 0.8), height: (balloonSize.height * 0.8))
        balloon0?.position = CGPoint(x: self.frame.midX - (balloonPositionOffset + 40), y: self.frame.midY + (balloonPositionOffset + 20))
        self.addChild(balloon0!)
    }
    func spawnBallon1() {
        
        balloon1 = SKSpriteNode(imageNamed: "greenBalloon")
        balloon1?.size = CGSize(width: (balloonSize.width * 0.8), height: (balloonSize.height * 0.8))
        balloon1?.position = CGPoint(x: self.frame.midX + (balloonPositionOffset + 40), y: self.frame.midY + (balloonPositionOffset + 20))
        self.addChild(balloon1!)
    }
    func spawnBallon2() {
        
        balloon2 = SKSpriteNode(imageNamed: "blueBalloon")
        balloon2?.size = CGSize(width: (balloonSize.width * 0.8), height: (balloonSize.height * 0.8))
        balloon2?.position = CGPoint(x: self.frame.midX - (balloonPositionOffset + 40), y: self.frame.midY - (balloonPositionOffset + 40))
        self.addChild(balloon2!)
    }
    func spawnBallon3() {
        
        balloon3 = SKSpriteNode(imageNamed: "purpleBalloon")
        balloon3?.size = CGSize(width: (balloonSize.width * 0.8), height: (balloonSize.height * 0.8))
        balloon3?.position = CGPoint(x: self.frame.midX + (balloonPositionOffset + 40), y: self.frame.midY - (balloonPositionOffset + 40))
        self.addChild(balloon3!)
    }
}
