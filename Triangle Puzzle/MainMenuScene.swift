//
//  MainMenuScene.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 8/20/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        initialize()
    }
    func initialize() {
        let button1 = SKShapeNode(rectOf: CGSize(width: 200.0, height: 100.0))
        button1.fillColor = UIColor.red
        button1.position = CGPoint(x: 0, y: 0)
        addChild(button1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mode = 2
        var scenename = ""
        if mode == 1 {
            scenename = "GameScene"
        }
        if mode == 2 {
            scenename = "SwapNumbersScene"
        }
        else {
            scenename = "GameScene"
        }
        let scene = SKScene(fileNamed: scenename)
        scene!.scaleMode = .aspectFill
        self.view?.presentScene(scene)
    }
}











