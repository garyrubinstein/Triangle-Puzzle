//
//  MainMenuScene.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 8/20/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    var framesize = 0
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var theSize: CGFloat = 0
    var frameOffset: Int = 100
    var buttonOffset: Int = 200
    var totalButtons: Int = 35
    var buttonsOnSceen: Int = 26
    var sceneNames: [String] = []
    var numberPuzzles: Int = 12
    var trianglePuzzles: Int = 2
    var cubePuzzles: Int = 12
    var buttonArray: [SKShapeNode] = []
    var buttonStringArray: [SKLabelNode] = []
    var pageNum: Int = 1
    
    override func didMove(to view: SKView) {
        initialize()
    }
    func initialize() {
        for _ in 0...numberPuzzles-1 {
            sceneNames.append("SwapNumbersScene")
        }
        for _ in 0...trianglePuzzles-1 {
            sceneNames.append("GameScene")
        }
        for _ in 0...cubePuzzles-1 {
            sceneNames.append("CubePuzzles")
        }
        for _ in 0...30 {
            sceneNames.append("")
        }
        
        let button1 = SKShapeNode(rectOf: CGSize(width: 200.0, height: 100.0))
        button1.fillColor = UIColor.red
        button1.position = CGPoint(x: 0, y: 150-Double(buttonOffset))
        button1.name = "button1"
        // addChild(button1)
        let button2 = SKShapeNode(rectOf: CGSize(width: 200.0, height: 100.0-Double(buttonOffset)))
        button2.fillColor = UIColor.yellow
        button2.position = CGPoint(x: 0, y: 0-Double(buttonOffset))
        button2.name = "button2"
        // addChild(button2)
        let button3 = SKShapeNode(rectOf: CGSize(width: 200.0, height: 100.0))
        button3.fillColor = UIColor.blue
        button3.position = CGPoint(x: 0, y: -150-Double(buttonOffset))
        button3.name = "button3"
        // addChild(button3)
        self.userData = NSMutableDictionary()
        self.userData?.setValue(-1, forKey: "mode")
        // print(self.userData?.value(forKey: "mode")! ?? 5)
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = self.size.width //screenSize.width
        screenHeight = self.size.height // screenSize.height
        print(screenWidth)
        print(screenHeight)
        print("self.size")
        print(self.size.height)
        print(self.size.width)
        theSize = min(screenWidth,screenHeight)
        print("theSize")
        print(theSize)
        addMoveList()
    }
    
    func addMoveList() {
        let numMoves = 3
        let framesize = Int(2/3*theSize)
        let boxWidth = 3/4*screenWidth
        let boxHeight = 0.4*screenHeight
        let boxCenter: CGPoint = CGPoint(x: 0, y: screenHeight/2-boxHeight/2-50)
        let moveBox = SKSpriteNode(color: UIColor.clear , size: CGSize(width: boxWidth, height: boxHeight))
        // let moveBox = SKShapeNode(rect: CGRect(x: boxCenter.x-boxWidth/2, y: boxCenter.y+boxHeight/2, width: boxWidth, height: boxHeight))
        // moveBox.fillColor = UIColor.blue
        moveBox.position = boxCenter
        moveBox.zPosition = 3
        
        moveBox.name = "movebox"
        
        // add buttons to movebox
        let buttonWidth: CGFloat = 0.3*boxWidth
        let buttonHeight: CGFloat = 0.15*boxHeight
        for i in 0...buttonsOnSceen {
            let moveButton = SKShapeNode(rectOf: CGSize(width: buttonWidth, height: buttonHeight))
            // let moveButton = SKShapeNode(rect: CGRect(x: CGFloat(i*20)+buttonWidth/2, y: CGFloat(i*20)-buttonHeight/2, width: buttonWidth, height: buttonHeight))
            moveButton.fillColor = UIColor.orange
            moveButton.name = "movebutton,"+String(i+1)
            moveButton.zPosition = 5
            // moveButton.position = convert(moveButton.position, from: moveBox)
            buttonArray.append(moveButton)
            moveBox.addChild(moveButton)
            moveButton.position = CGPoint(x: -CGFloat(boxWidth)/3+CGFloat(boxWidth/3)*CGFloat(i%3), y: CGFloat(boxHeight)/3-boxHeight/4*CGFloat(Int(i/3))+boxHeight/16)
            var buttonText = SKLabelNode(text: String(i+1))
            if i==buttonsOnSceen {
                buttonText.text = "MORE"
            }
            buttonText.fontName = "AvenirNext-Bold"
            buttonText.fontColor=UIColor.white
            buttonText.fontSize=48
            buttonText.position = CGPoint(x: -CGFloat(boxWidth)/3+CGFloat(boxWidth/3)*CGFloat(i%3)+boxCenter.x, y: CGFloat(boxHeight)/3-boxHeight/4*CGFloat(Int(i/3))+boxCenter.y)
            buttonText.zPosition = 10
            buttonStringArray.append(buttonText)
            self.addChild(buttonText)
            // moveButton.position.x = 100
            // moveButton.position.y = 100
        }
        self.addChild(moveBox)
        // moveBox.alpha = 0.0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var scenename = ""
        if let touch = touches.first {
            let location = touch.location(in: self)
            // print(location)
            
            let nodes = self.nodes(at: location)
            for node in nodes {
                // print(node.name!)
                if let nodeName = node.name {
                    print("The node name is \(nodeName)")
                    if nodeName.hasPrefix("movebutton") {
                        print("found a movebutton!")
                        var offset: Int = 0
                        if pageNum == 2 {
                            offset = buttonsOnSceen
                        }
                        let thenumberstring = Int(nodeName.components(separatedBy: ",")[1])
                        var thenumber = Int(thenumberstring!)
                        if thenumber != 27 {
                            thenumber=thenumber+offset
                        }
                        
                        
                        
                        print("move number \(thenumber)")
                        if thenumber != 27 {
                            scenename = sceneNames[thenumber-1]
                            self.userData?.setValue(thenumber+1, forKey: "mode")
                        }
                        else {
                            scenename = ""
                            changePage()
                        }
                    }
                }
                /* if Array(node.name!)[0] == "b" {
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
                } */
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
    func changePage() {
        if pageNum==1 {
            pageNum = 2
        }
        else if pageNum == 2 {
            pageNum = 1
        }
        
        if pageNum == 2 {
            var numToShow: Int = totalButtons - buttonsOnSceen
            for i in 0...numToShow-1 {
                buttonStringArray[i].text = String(i+buttonsOnSceen+1)
            }
            for i in numToShow...buttonArray.count-2 {
                // buttonStringArray[i].text = String("new")
                buttonStringArray[i].isHidden = true
                buttonArray[i].isHidden = true
            }
        }
        else if pageNum == 1 {
            for i in 0...buttonArray.count-2 {
                buttonStringArray[i].text = String(i+1)
                buttonStringArray[i].isHidden = false
                buttonArray[i].isHidden = false
            }
        }
    }
}











