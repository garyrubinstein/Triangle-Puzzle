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
    var inaction: Bool = false
    var nodelist: [SKShapeNode] = []
    var originalPositionList: [CGPoint] = []
    var sidelen: CGFloat = 200
    var triside: CGFloat = 50
    var toppoint: CGFloat = 75
    var buttonsize: CGFloat = 20
    var gamemode: Int = 0
    var multiplier: CGFloat = 1.0
    var clockwise: Bool = true
    var startingPattern: [Int] = []
    // let button1 = SKShapeNode(circleOfRadius: 50)
    // let triangle = SKShapeNode()
    override func didMove(to view: SKView) {
        print("hello")
        if let mode = self.userData?.value(forKey: "mode") {
            print("mode is \(mode)")
            var theMode = mode as! Int
            gamemode = theMode - 13 // to makeup for the fact that it is number 14 on the menu
            print("trianglegame \(gamemode)")
        }
        if gamemode == 1 {
            startingPattern = [1,2,1,2,2,1,1]
        }
        else if gamemode == 2 {
            for i in 1...12 {
                var randnum = Int.random(in: 0...5)
                if randnum < 3 {
                    startingPattern.append(randnum)
                }
                else {
                    startingPattern.append(randnum-3)
                    startingPattern.append(randnum-3)
                }
            }
            // startingPattern = [1,2,2,1,0]
        }
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
            tritext.fontColor = UIColor.white
            tritext.fontName = "AvenirNext-Bold"
            let triangle = SKShapeNode()
            triangle.name = "triangle"+String(i+1)
            triangle.path = path.cgPath
            triangle.lineWidth = 10.0
            // triangle.alpha = 0.3
            triangle.strokeColor = UIColor(red: 0, green: 0.6392, blue: 0.0078, alpha: 1.0)
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
                tri.fillColor = UIColor(red: 0, green: 0.6392, blue: 0.0078, alpha: 1.0)
            }
            if tri.name == "triangle5" {
                tri.position = CGPoint(x: 0, y: toppoint-sidelen/2*1.73)
                tri.fillColor = UIColor.blue
            }
            if tri.name == "triangle6" {
                tri.position = CGPoint(x: 0+sidelen/2, y: toppoint-sidelen/2*1.73)
                tri.fillColor = UIColor.purple
            }
            originalPositionList.append(tri.position)
            
        }
        print(originalPositionList)
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
        let backButton = SKShapeNode(circleOfRadius: 20)
        backButton.fillColor = UIColor(red: 0, green: 0.6392, blue: 0.0078, alpha: 1.0)
        backButton.position = CGPoint(x: 0, y: -200)
        backButton.name="back"
        backButton.zPosition = 5
        addChild(backButton)
        let menuText = SKLabelNode(text: "menu")
        menuText.fontColor = UIColor.black
        menuText.fontSize = 24
        menuText.fontName = "Helvetica"
        menuText.position = CGPoint(x: backButton.position.x, y: backButton.position.y-35)
        self.addChild(menuText)
        
        
        let shuffleButton = SKShapeNode(circleOfRadius: 20)
        shuffleButton.fillColor = UIColor.blue
        shuffleButton.position = CGPoint(x: -100, y: -200)
        shuffleButton.name="shuffle"
        shuffleButton.zPosition = 5
        addChild(shuffleButton)
        let mixText = SKLabelNode(text: "mix")
        mixText.fontColor = UIColor.black
        mixText.fontSize = 24
        mixText.fontName = "Helvetica"
        mixText.position = CGPoint(x: shuffleButton.position.x, y: shuffleButton.position.y-35)
        self.addChild(mixText)
        
        let solveButton = SKShapeNode(circleOfRadius: 20)
        solveButton.fillColor = UIColor.black
        solveButton.position = CGPoint(x: 100, y: -200)
        solveButton.name="solve"
        solveButton.zPosition = 5
        addChild(solveButton)
        let solveText = SKLabelNode(text: "solve")
        solveText.fontColor = UIColor.black
        solveText.fontSize = 24
        solveText.fontName = "Helvetica"
        solveText.position = CGPoint(x: solveButton.position.x, y: solveButton.position.y-35)
        self.addChild(solveText)

        
        
        
        let clockwiseButton = SKShapeNode(circleOfRadius: 20)
        clockwiseButton.fillColor = UIColor.purple
        clockwiseButton.position = CGPoint(x: -125, y: 125)
        clockwiseButton.name="clockwise"
        clockwiseButton.zPosition = 5
        addChild(clockwiseButton)
        let counterText = SKLabelNode(text: "counter")
        counterText.fontColor = UIColor.black
        counterText.name = "countertext"
        counterText.fontSize = 24
        counterText.fontName = "Helvetica"
        counterText.position = CGPoint(x: clockwiseButton.position.x, y: clockwiseButton.position.y-35)
        counterText.isHidden = true
        let clockwiseText = SKLabelNode(text: "clockwise")
        clockwiseText.fontColor = UIColor.black
        clockwiseText.fontSize = 24
        clockwiseText.fontName = "Helvetica"
        clockwiseText.position = CGPoint(x: clockwiseButton.position.x, y: clockwiseButton.position.y-65)
        
        addChild(clockwiseText)
        addChild(counterText)

        genericmoves(pattern: startingPattern, len: 0.0)
        // genericmoves(pattern: startingPattern)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print(location)
            var theNodeName: String = ""
            let nodes = self.nodes(at: location)
            for node in nodes {
                if let nodeName = node.name {
                    print(nodeName)
                    theNodeName = nodeName
                }
                else {
                    theNodeName = "noname"
                }
                // print(theNodeName)
                // print(!inaction)
                // print(theNodeName=="shuffle")
                // print(node.name!)
                if !inaction && theNodeName == "button1" {
                    // move1()
                    inaction = true
                    // genericmove(button: 1, top: 0, bottomleft: 1, bottomright: 2)
                    genericmoves(pattern: [0])
                    print(gamestate)
                }
                else if !inaction && theNodeName == "button2" {
                    // move2()
                    inaction = true
                    // genericmove(button:2, top: 1, bottomleft: 3, bottomright: 4)
                    genericmoves(pattern: [1])
                    print(gamestate)
                }
                else if !inaction && theNodeName == "button3" {
                    // move3()
                    inaction = true
                    genericmoves(pattern: [2])
                    // genericmove(button: 3, top: 2, bottomleft: 4, bottomright: 5)
                    print(gamestate)
                }
                else if !inaction && theNodeName == "clockwise" {
                    let counterText = self.childNode(withName: "countertext") as! SKLabelNode
                    if clockwise {
                        clockwise = false
                        counterText.isHidden = false
                        let cwButton: SKShapeNode = node as! SKShapeNode
                        cwButton.fillColor = UIColor.blue
                        multiplier = -1.0
                    }
                    else {
                        clockwise = true
                        counterText.isHidden = true
                        let cwButton: SKShapeNode = node as! SKShapeNode
                        cwButton.fillColor = UIColor.purple
                        multiplier = 1.0

                    }
                    // move3()
                    // inaction = true
                    // genericmove(button: 3, top: 2, bottomleft: 4, bottomright: 5)
                    // print(gamestate)
                }
                else if !inaction && theNodeName == "solve" {
                    print("solving")
                    print(gamestate)
                    print(originalPositionList)
                    var tempnodelist: [SKShapeNode] = []
                    for i in 1...6 {
                        print(i)
                        nodelist[gamestate.firstIndex(of: i)!].position = originalPositionList[i-1]
                        tempnodelist.append(nodelist[gamestate.firstIndex(of: i)!])
                    }
                    nodelist=Array(tempnodelist)
                    gamestate = Array([1,2,3,4,5,6])
                    print("now gamestate is")
                    print(gamestate)
                }
                else if !inaction && theNodeName == "shuffle" {
                    var thePattern: [Int] = []

                    for i in 1...12 {
                        var randnum = Int.random(in: 0...5)
                        if randnum < 3 {
                            thePattern.append(randnum)
                        }
                        else {
                            thePattern.append(randnum-3)
                            thePattern.append(randnum-3)
                        }
                    }
                    inaction = true
                    genericmoves(pattern: thePattern, len: 0.0)
                }
                else if theNodeName == "back" {
                    let scene = MainMenuScene(fileNamed: "MainMenuScene")
                    scene!.scaleMode = .aspectFit
                    self.view?.presentScene(scene)
                }
                else {
                    print("not a button node")
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
    
    func moves(pattern: [Int]) {
        print("in moves")
        print(pattern)
        var thePattern = Array(pattern)
        let maps: [[Int]] = [[0,1,2],[1,3,4],[2,4,5]]
        if pattern.count > 0 {
            genericmove(button: pattern[0]+1, top: maps[0][0], bottomleft: maps[0][1], bottomright: maps[0][2])
            moves(pattern: [thePattern.removeFirst()])
        }
    }
    
    func genericmove(button: Int, top: Int, bottomleft: Int, bottomright: Int) {
        let buttonname = "button"+String(button)
        // print("generic move")
        let temp = gamestate[bottomright]
        gamestate[bottomright]=gamestate[top]
        gamestate[top]=gamestate[bottomleft]
        gamestate[bottomleft]=temp
        
        let temp1 = nodelist[bottomright]
        nodelist[bottomright]=nodelist[top]
        nodelist[top]=nodelist[bottomleft]
        nodelist[bottomleft]=temp1
        
        let buttonx: CGFloat = (childNode(withName: buttonname)?.position.x)!
        let buttony: CGFloat = (childNode(withName: buttonname)?.position.y)!
        
        nodelist[top].removeFromParent()
        nodelist[top].position = CGPoint(x: nodelist[top].position.x-buttonx, y: nodelist[top].position.y-buttony)
        
        childNode(withName: buttonname)?.addChild(nodelist[top])
        
        nodelist[bottomleft].removeFromParent()
        nodelist[bottomleft].position = CGPoint(x: nodelist[bottomleft].position.x-buttonx, y: nodelist[bottomleft].position.y-buttony)
        childNode(withName: buttonname)?.addChild(nodelist[bottomleft])
        
        nodelist[bottomright].removeFromParent()
        nodelist[bottomright].position = CGPoint(x: nodelist[bottomright].position.x-buttonx, y: nodelist[bottomright].position.y-buttony)
        childNode(withName: buttonname)?.addChild(nodelist[bottomright])
        childNode(withName: buttonname)?.zPosition = 5
        
        let spinaction = SKAction.rotate(byAngle: -3.14*2/3, duration: 0.5)
        // childNode(withName: "button1")?.run(spinaction)
        if let mybutton = childNode(withName: buttonname) as? SKShapeNode {
            mybutton.run(spinaction, completion: {
                self.childNode(withName: buttonname)?.zPosition = 0
                self.inaction = false
                self.nodelist[top].removeFromParent()
                self.nodelist[top].position = CGPoint(x: self.nodelist[top].position.x+buttonx, y: self.nodelist[top].position.y+buttony)
                
                self.addChild(self.nodelist[top])
                
                self.nodelist[bottomleft].removeFromParent()
                self.nodelist[bottomleft].position = CGPoint(x: self.nodelist[bottomleft].position.x+buttonx, y: self.nodelist[bottomleft].position.y+buttony)
                self.addChild(self.nodelist[bottomleft])
                
                self.nodelist[bottomright].removeFromParent()
                self.nodelist[bottomright].position = CGPoint(x: self.nodelist[bottomright].position.x+buttonx, y: self.nodelist[bottomright].position.y+buttony)
                self.addChild(self.nodelist[bottomright])
                let temppos = self.nodelist[bottomright].position
                self.nodelist[bottomright].position = self.nodelist[bottomleft].position
                self.nodelist[bottomleft].position = self.nodelist[top].position
                self.nodelist[top].position = temppos
                
                mybutton.run(SKAction.rotate(byAngle: 3.14*2/3, duration: 0))
                
            })
        }

    }
    
    func genericmoves(pattern: [Int], len: TimeInterval = 0.5) { //button: Int, top: Int, bottomleft: Int, bottomright: Int) {
        if pattern.count > 0 {
            var thePattern: [Int] = Array(pattern)
            let maps: [[Int]] = [[0,1,2],[1,3,4],[2,4,5]]
            var ccw: Int = 0
            if !clockwise {
                ccw = 3
            }
            let button: Int = pattern[0]+1
            let top: Int = maps[pattern[0]][0]
            var bottomleft: Int = maps[pattern[0]][1]
            var bottomright: Int = maps[pattern[0]][2]
            if !clockwise {
                bottomleft = maps[pattern[0]][2]
                bottomright = maps[pattern[0]][1]
            }
            let buttonname = "button"+String(button)
            // print("generic move")
            let temp = gamestate[bottomright]
            gamestate[bottomright]=gamestate[top]
            gamestate[top]=gamestate[bottomleft]
            gamestate[bottomleft]=temp
            
            let temp1 = nodelist[bottomright]
            nodelist[bottomright]=nodelist[top]
            nodelist[top]=nodelist[bottomleft]
            nodelist[bottomleft]=temp1
            
            let buttonx: CGFloat = (childNode(withName: buttonname)?.position.x)!
            let buttony: CGFloat = (childNode(withName: buttonname)?.position.y)!
            
            nodelist[top].removeFromParent()
            nodelist[top].position = CGPoint(x: nodelist[top].position.x-buttonx, y: nodelist[top].position.y-buttony)
            
            childNode(withName: buttonname)?.addChild(nodelist[top])
            
            nodelist[bottomleft].removeFromParent()
            nodelist[bottomleft].position = CGPoint(x: nodelist[bottomleft].position.x-buttonx, y: nodelist[bottomleft].position.y-buttony)
            childNode(withName: buttonname)?.addChild(nodelist[bottomleft])
            
            nodelist[bottomright].removeFromParent()
            nodelist[bottomright].position = CGPoint(x: nodelist[bottomright].position.x-buttonx, y: nodelist[bottomright].position.y-buttony)
            childNode(withName: buttonname)?.addChild(nodelist[bottomright])
            childNode(withName: buttonname)?.zPosition = 5
            let spinaction = SKAction.rotate(byAngle: -3.14*2/3*multiplier, duration: len)
            // childNode(withName: "button1")?.run(spinaction)
            if let mybutton = childNode(withName: buttonname) as? SKShapeNode {
                mybutton.run(spinaction, completion: {
                    self.childNode(withName: buttonname)?.zPosition = 0
                    self.inaction = false
                    self.nodelist[top].removeFromParent()
                    self.nodelist[top].position = CGPoint(x: self.nodelist[top].position.x+buttonx, y: self.nodelist[top].position.y+buttony)
                    
                    self.addChild(self.nodelist[top])
                    
                    self.nodelist[bottomleft].removeFromParent()
                    self.nodelist[bottomleft].position = CGPoint(x: self.nodelist[bottomleft].position.x+buttonx, y: self.nodelist[bottomleft].position.y+buttony)
                    self.addChild(self.nodelist[bottomleft])
                    
                    self.nodelist[bottomright].removeFromParent()
                    self.nodelist[bottomright].position = CGPoint(x: self.nodelist[bottomright].position.x+buttonx, y: self.nodelist[bottomright].position.y+buttony)
                    self.addChild(self.nodelist[bottomright])
                    let temppos = self.nodelist[bottomright].position
                    self.nodelist[bottomright].position = self.nodelist[bottomleft].position
                    self.nodelist[bottomleft].position = self.nodelist[top].position
                    self.nodelist[top].position = temppos
                    
                    // mybutton.run(SKAction.rotate(byAngle: 3.14*2/3, duration: 0))
                    
                    mybutton.run(SKAction.rotate(byAngle: 3.14*2/3*self.multiplier, duration: 0) , completion: {
                        thePattern.removeFirst()
                        self.genericmoves(pattern: thePattern, len: len)}
                    )
                })
            }
            
        }
    
    }
}
