//
//  GameScene.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 7/23/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var gamestate = [1, 2, 3, 4, 5, 6]
    var nodelist: [SKShapeNode] = []
    // let button1 = SKShapeNode(circleOfRadius: 50)
    // let triangle = SKShapeNode()
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
        var i=0
        while i<6 {
            let triangle = SKShapeNode()
            triangle.name = "triangle"
            triangle.path = path.cgPath
            triangle.lineWidth = 10.0
            triangle.strokeColor = UIColor.green
            triangle.fillColor = UIColor.yellow
            triangle.position = CGPoint(x: 0, y: -150.0-50*Double(i))
            // triangle.name = "triangle"
            // SKShapeNode(path: path.cgPath)
            nodelist.append(triangle)
            self.addChild(triangle)
            i=i+1
        }
        let triangle = SKShapeNode()
        triangle.name = "triangle"
        triangle.path = path.cgPath
        triangle.lineWidth = 10.0
        triangle.strokeColor = UIColor.green
        triangle.fillColor = UIColor.yellow
        triangle.position = CGPoint(x: 0, y: -150.0)
        // triangle.name = "triangle"
        // SKShapeNode(path: path.cgPath)
        self.addChild(triangle)
        let button1 = SKShapeNode(circleOfRadius: 50.0)
        button1.fillColor = UIColor.red
        button1.position = CGPoint(x: 0, y: -50)
        button1.name = "button1"
        addChild(button1)
        let button2 = SKShapeNode(circleOfRadius: 50.0)
        button2.fillColor = UIColor.red
        button2.position = CGPoint(x: 50, y: 50)
        button2.name = "button2"
        addChild(button2)
        let button3 = SKShapeNode(circleOfRadius: 50.0)
        button3.fillColor = UIColor.red
        button3.position = CGPoint(x: -50, y: 50)
        button3.name = "button3"
        addChild(button3)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print(location)
            let nodes = self.nodes(at: location)
            for node in nodes {
                print(node.name!)
                if node.name! == "button1" {
                    move1()
                    print(gamestate)
                }
                else if node.name! == "button2" {
                    move2()
                    print(gamestate)
                }
                else if node.name! == "button3" {
                    move3()
                    print(gamestate)
                }
            }
        }
        let spinaction = SKAction.rotate(byAngle: 3.14, duration: 5)
        if let mytriangle = childNode(withName: "triangle") as? SKShapeNode {
            mytriangle.run(spinaction)}
        else {
            print("node not found")
        }
    }
    
    func move1() {
        print("move1")
        let temp = gamestate[2]
        gamestate[2]=gamestate[0]
        gamestate[0]=gamestate[1]
        gamestate[1]=temp
        
    }
    
    func move2() {
        print("move2")
        let temp = gamestate[4]
        gamestate[4]=gamestate[1]
        gamestate[1]=gamestate[3]
        gamestate[3]=temp
    }
    
    func move3() {
        print("move3")
        let temp = gamestate[5]
        gamestate[5]=gamestate[2]
        gamestate[2]=gamestate[4]
        gamestate[4]=temp
    }
}
