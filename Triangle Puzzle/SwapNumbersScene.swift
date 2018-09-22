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
    let puzzleSize = 4
    let moveSize = 3
    var board: [Int] = []
    var nodelist: [SKShapeNode] = []
    var chosennumbers: [Int] = []
    var nodesselected = 0
    override func didMove(to view: SKView) {
        // chosennumbers.append(0)
        // chosennumbers.append(0)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = self.size.width //screenSize.width
        let screenHeight = self.size.height // screenSize.height
        print(screenWidth)
        print(screenHeight)
        print("self.size")
        print(self.size.height)
        print(self.size.width)
        let theSize = min(screenWidth,screenHeight)
        print("theSize")
        print(theSize)
        framesize = Int(2/3*theSize)
        
        let myframe = SKShapeNode(rect: CGRect(x: -framesize/2, y: -framesize/2, width: framesize, height: framesize))
        myframe.fillColor = UIColor.red
        myframe.zPosition = 3
        myframe.name = "frame"
        self.addChild(myframe)
        for i in 0...(puzzleSize*puzzleSize-1) {
            print(i)
            board.append(Int(i+1))
            let row = Int(i/puzzleSize)
            let column = i%puzzleSize
            // print(row)
            // print(column)
            let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: framesize/puzzleSize, height: framesize/puzzleSize))
            gamePiece.name = "piece,"+String(i)
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
            tritext.name = "text"+String(i+1)
            tritext.zPosition = 5
            gamePiece.addChild(tritext)
            nodelist.append(gamePiece)
            myframe.addChild(gamePiece)
            // tritext.position = CGPoint(x: 0, y: 0)
            
            
        }
        print(board)
        mix(nummoves: 50)
        //self.addChild(myframe)
    }
    
    func mix(nummoves: Int) {
        // makemove(myarray: [0,4,5], howLong: 0.05)
        for _ in 0...nummoves {
            var movearray: [Int] = []
            var numbers: [Int] = []
            for i in 1...puzzleSize*puzzleSize {
                numbers.append(i)
            }
            numbers.shuffle()
            print("in mix")
    //        print(numbers)
            // let subarray = numbers[0...2]
            for i in 0..<moveSize {
                movearray.append(numbers[i]-1)
            }
            print(movearray)
            makemove(myarray: movearray, howLong: 0.05)
        }
        /* for _ in 0...nummoves {
            let number1 = Int.random(in: 0 ..< puzzleSize*puzzleSize)
            let number2 = Int.random(in: 0 ..< puzzleSize*puzzleSize)
            makemove(myarray: [number1, number2], howLong: 0.05)
            // makemove(firstnum: number1, secondnum: number2, howLong: 0.05)
        } */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // print("touch")
        if let touch = touches.first {
            let location = touch.location(in: self)
            // print(location)
            let nodes = self.nodes(at: location)
            for node in nodes {
                // print(node.name!)
                if Array(node.name!)[0] == "p" {
                    let n=Int(node.name!.components(separatedBy: ",")[1])!
                    print("nodeclicked")
                    print(n)
                    print(chosennumbers.count)
                    print(chosennumbers)
                    if chosennumbers.count < moveSize {
                        if !chosennumbers.contains(n) {
                            chosennumbers.append(n)
                            nodelist[n].fillColor = UIColor.green
                        }
                        if chosennumbers.count == moveSize {
                            // takesarray(myarray: chosennumbers)
                            makemove(myarray: chosennumbers, howLong: 0.5)
                            // makemove(firstnum: chosennumbers[0],secondnum: chosennumbers[1], howLong: 0.5)
                        }
                        // chosennumbers[0] = n
                        // let firstnode = childNode(withName: "piece,1") as! SKShapeNode
                        //  = UIColor.green

                        
                        // nodesselected = 1
                        
                    }
                    /*
                    else if nodesselected == 1 && chosennumbers[0] != n {
                        chosennumbers[1] = n
                        nodelist[n].fillColor = UIColor.green
                        makemove(firstnum: chosennumbers[0],secondnum: chosennumbers[1], howLong: 0.5)
                    }
                    */
                    /*
                    else {
                        nodesselected = 0
                        chosennumbers[0] = 0
                        nodelist[n].fillColor = UIColor.yellow
                    }
                    */
                }
            }
        }

    }
    
    func takesarray(myarray: [Int]) {
        print("takesarray")
        print(myarray.count)
    }
    
    func makemove(myarray: [Int], howLong: TimeInterval) {
        // print("makemove \(myarray)")
    //func makemove(firstnum: Int, secondnum: Int, howLong: TimeInterval) {
        // print("makemove \(firstnum) \(secondnum) ")
        // print("in makemove")
        // print(myarray)

        nodelist[0].run(SKAction.fadeAlpha(to: 1, duration: howLong), completion: {
            let temppos = self.nodelist[myarray[0]].position
            self.nodelist[myarray[0]].fillColor = UIColor.yellow
            for j in 0..<myarray.count-1 {
                // print("in makemove j= \(j)")
                self.nodelist[myarray[j]].fillColor = UIColor.yellow
                self.nodelist[myarray[j]].position = self.nodelist[myarray[j+1]].position
            }
            // self.nodelist[myarray[1]].fillColor = UIColor.yellow
            self.nodelist[myarray[myarray.count-1]].position = temppos
            self.nodelist[myarray[myarray.count-1]].fillColor = UIColor.yellow


        })
        // need to fix this to update board
        // make a new ray with the positions of each of the numbers in the move
        var posarray: [Int] = []
        for j in 0..<moveSize {
            // print(1+myarray[j])
            // print(board.firstIndex(of: 1+myarray[j]))
            posarray.append(board.firstIndex(of: 1+myarray[j])!)
        }
        print("posarray")
        print(posarray)
        let tempint = board[posarray[posarray.count-1]]
        for j in 0..<myarray.count-1 {
            // print("moving \(j) to \(j+1)")
            board[posarray[j+1]] = myarray[j]+1
            // print(board)
        }
        // board[myarray[1]] = board[myarray[0]]
        board[posarray[0]] = tempint
        // print(board)
        
        print(board)
        // chosennumbers[0]=0
        // chosennumbers[1]=0
        chosennumbers.removeAll()
        nodesselected = 0
    }
}
