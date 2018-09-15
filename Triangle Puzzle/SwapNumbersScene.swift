//
//  SwapNumbersScene.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 9/13/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class SwapNumbersScene: SKScene {
    var framesize = 0
    let puzzleSize = 5
    override func didMove(to view: SKView) {
        print("hi")
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        print(screenWidth)
        print(screenHeight)
        framesize = Int(4/3*screenWidth)
        
        let myframe = SKShapeNode(rect: CGRect(x: -framesize/2, y: -framesize/2, width: framesize, height: framesize))
        myframe.fillColor = UIColor.red
        myframe.zPosition = 3
        self.addChild(myframe)
        /*
        // let testcircle = SKShapeNode(circleOfRadius: 50)
        let testcircle = SKShapeNode(rect: CGRect(x: 0.5, y: 0.5, width: 100, height: 100))
        testcircle.fillColor = UIColor.green
        
        testcircle.zPosition = 4
        let tritext = SKLabelNode(text: "10")
        tritext.fontColor = UIColor.black
        tritext.fontName = "AvenirNext-Bold"
        tritext.fontSize = 64
        tritext.zPosition = 5
        testcircle.addChild(tritext)
        myframe.addChild(testcircle)
        testcircle.position = CGPoint(x: 150, y: 0)
        */
        for i in 0...(puzzleSize*puzzleSize-1) {
            print(i)
            let row = Int(i/puzzleSize)
            let column = i%puzzleSize
            print(row)
            print(column)
            let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: framesize/puzzleSize, height: framesize/puzzleSize))
            gamePiece.name = "piece"+String(i)
            gamePiece.fillColor = UIColor.yellow
            gamePiece.strokeColor = UIColor.black
            gamePiece.zPosition = 4
            gamePiece.position = CGPoint(x: -framesize/2+column*framesize/puzzleSize, y: framesize/2-framesize/puzzleSize-row*framesize/puzzleSize)
         
            
            
            let tritext = SKLabelNode(text: String(i+1))
            tritext.fontColor = UIColor.black
            tritext.fontName = "AvenirNext-Bold"
            tritext.fontSize = 64
            tritext.horizontalAlignmentMode = .center
            tritext.verticalAlignmentMode = .center
            tritext.position = CGPoint(x: framesize/(puzzleSize*2), y: framesize/(puzzleSize*2))
            tritext.zPosition = 5
            gamePiece.addChild(tritext)
            myframe.addChild(gamePiece)
            // tritext.position = CGPoint(x: 0, y: 0)
            
            
        }
        //self.addChild(myframe)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
    }
}
