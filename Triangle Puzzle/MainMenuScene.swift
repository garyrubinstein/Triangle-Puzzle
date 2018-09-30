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
        button1.position = CGPoint(x: 0, y: 150)
        button1.name = "button1"
        addChild(button1)
        let button2 = SKShapeNode(rectOf: CGSize(width: 200.0, height: 100.0))
        button2.fillColor = UIColor.yellow
        button2.position = CGPoint(x: 0, y: 0)
        button2.name = "button2"
        addChild(button2)
        let button3 = SKShapeNode(rectOf: CGSize(width: 200.0, height: 100.0))
        button3.fillColor = UIColor.blue
        button3.position = CGPoint(x: 0, y: -150)
        button3.name = "button3"
        addChild(button3)
        self.userData = NSMutableDictionary()
        self.userData?.setValue(-1, forKey: "mode")
        // print(self.userData?.value(forKey: "mode")! ?? 5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var scenename = ""
        if let touch = touches.first {
            let location = touch.location(in: self)
            // print(location)
            
            let nodes = self.nodes(at: location)
            for node in nodes {
                // print(node.name!)
                if Array(node.name!)[0] == "b" {
                    let buttonname = node.name!
                    if buttonname == "button1" {
                        scenename = "SwapNumbersScene"
                        self.userData?.setValue(2, forKey: "mode")
                    }
                    else if buttonname == "button2" {
                        scenename = "SwapNumbersScene"
                        self.userData?.setValue(3, forKey: "mode")
                    }
                    else if buttonname == "button3" {
                        scenename = "GameScene"
                    }
                }
            }
        }
        /* let mode = 2
        // var scenename = ""
        if mode == 1 {
            scenename = "GameScene"
        }
        if mode == 2 {
            scenename = "SwapNumbersScene"
        }
        else {
            scenename = "GameScene"
        }
        */
        if scenename != "" {
        let scene = SKScene(fileNamed: scenename)
        scene!.scaleMode = .aspectFit
        scene?.userData = NSMutableDictionary()
        scene?.userData?.setValue(self.userData?.value(forKey: "mode"), forKey: "mode")
        
        self.view?.presentScene(scene)
        }
    }
}











