//
//  GameScene.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 7/23/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let triangle = SKShapeNode()
    override func didMove(to view: SKView) {
        print("hello")
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        print(screenWidth)
        print(screenHeight)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 50.0, y: -36.6))
        path.addLine(to: CGPoint(x: -50.0, y: -36.6))
        path.addLine(to: CGPoint(x: 0.0, y: 50.0))
        triangle.path = path.cgPath
        triangle.lineWidth = 10.0
        triangle.strokeColor = UIColor.green
        triangle.name = "triangle"
        SKShapeNode(path: path.cgPath)
        self.addChild(triangle)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let spinaction = SKAction.rotate(byAngle: 3.14, duration: 5)
        triangle.run(spinaction)
    }
}
