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
    var sidelen: CGFloat = 200
    var triside: CGFloat = 50
    var toppoint: CGFloat = 150
    var buttonsize: CGFloat = 20
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
        path.move(to: CGPoint(x: 0.0, y: triside))
        path.addLine(to: CGPoint(x: triside, y: -triside*0.73205))
        path.addLine(to: CGPoint(x: -triside, y: -triside*0.73205))
        path.addLine(to: CGPoint(x: 0.0, y: triside))
        var i=0
        while i<6 {
            let tritext = SKLabelNode(text: String(i+1))
            tritext.fontColor = UIColor.black
            let triangle = SKShapeNode()
            triangle.name = "triangle"+String(i+1)
            triangle.path = path.cgPath
            triangle.lineWidth = 10.0
            triangle.strokeColor = UIColor.green
            triangle.fillColor = UIColor.yellow
            // triangle.position = CGPoint(x: 0, y: -150.0-50*Double(i))
            // triangle.name = "triangle"
            // SKShapeNode(path: path.cgPath)
            nodelist.append(triangle)
            triangle.addChild(tritext)
            self.addChild(triangle)
            i=i+1
        }
        for tri in nodelist {
            if tri.name == "triangle1" {
                tri.position = CGPoint(x: 0, y: toppoint)
                tri.fillColor = UIColor.red
            }
            if tri.name == "triangle2" {
                tri.position = CGPoint(x: 0-sidelen/4, y: toppoint-sidelen/4*1.73)
                tri.fillColor = UIColor.orange
            }
            if tri.name == "triangle3" {
                tri.position = CGPoint(x: 0+sidelen/4, y: toppoint-sidelen/4*1.73)
                tri.fillColor = UIColor.yellow
            }
            if tri.name == "triangle4" {
                tri.position = CGPoint(x: 0-sidelen/2, y: toppoint-sidelen/2*1.73)
                tri.fillColor = UIColor.green
            }
            if tri.name == "triangle5" {
                tri.position = CGPoint(x: 0, y: toppoint-sidelen/2*1.73)
                tri.fillColor = UIColor.blue
            }
            if tri.name == "triangle6" {
                tri.position = CGPoint(x: 0+sidelen/2, y: toppoint-sidelen/2*1.73)
                tri.fillColor = UIColor.purple
            }
            
        }
        let button1 = SKShapeNode(circleOfRadius: buttonsize)
        button1.fillColor = UIColor.red
        button1.position = CGPoint(x: 0, y: toppoint-sidelen*0.33)
        button1.name = "button1"
        addChild(button1)
        let button2 = SKShapeNode(circleOfRadius: buttonsize)
        button2.fillColor = UIColor.red
        button2.position = CGPoint(x: -sidelen*0.25, y: toppoint-sidelen*0.77)
        button2.name = "button2"
        addChild(button2)
        let button3 = SKShapeNode(circleOfRadius: buttonsize)
        button3.fillColor = UIColor.red
        button3.position = CGPoint(x: sidelen*0.25, y: toppoint-sidelen*0.77)
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
        
        let temppos = nodelist[2].position
        nodelist[2].position = nodelist[1].position
        nodelist[1].position = nodelist[0].position
        nodelist[0].position = temppos

        let temp1 = nodelist[2]
        nodelist[2]=nodelist[0]
        nodelist[0]=nodelist[1]
        nodelist[1]=temp1
    }
    
    func move2() {
        print("move2")
        let temp = gamestate[4]
        gamestate[4]=gamestate[1]
        gamestate[1]=gamestate[3]
        gamestate[3]=temp
        
        let temppos = nodelist[4].position
        nodelist[4].position = nodelist[3].position
        nodelist[3].position = nodelist[1].position
        nodelist[1].position = temppos
        
        let temp1 = nodelist[4]
        nodelist[4]=nodelist[1]
        nodelist[1]=nodelist[3]
        nodelist[3]=temp1
    }
    
    func move3() {
        print("move3")
        let temp = gamestate[5]
        gamestate[5]=gamestate[2]
        gamestate[2]=gamestate[4]
        gamestate[4]=temp
        
        let temppos = nodelist[5].position
        nodelist[5].position = nodelist[4].position
        nodelist[4].position = nodelist[2].position
        nodelist[2].position = temppos
        
        let temp1 = nodelist[5]
        nodelist[5]=nodelist[2]
        nodelist[2]=nodelist[4]
        nodelist[4]=temp1
    }
}
