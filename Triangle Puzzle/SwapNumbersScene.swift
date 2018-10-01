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
    var moveSize = 2
    var board: [Int] = []
    var moveArray: [[[Int]]] = []
    var nodelist: [SKShapeNode] = []
    var chosennumbers: [Int] = []
    var nodesselected = 0
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var theSize: CGFloat = 0
    var frameOffset: Int = 100
    // new comment
    // another new comment
    override func didMove(to view: SKView) {
        // chosennumbers.append(0)
        // chosennumbers.append(0)
        if let mode = self.userData?.value(forKey: "mode") {
            print("mode is \(mode)")
            moveSize = mode as! Int
        }
        
        initializeMoves()
        // test changes array

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
        framesize = Int(2/3*theSize)
        let backButton = SKShapeNode(circleOfRadius: 50)
        backButton.fillColor = UIColor.green
        backButton.position = CGPoint(x: -100, y: -500)
        backButton.name="back"
        self.addChild(backButton)
        let moveButton = SKShapeNode(circleOfRadius: 50)
        moveButton.fillColor = UIColor.blue
        moveButton.position = CGPoint(x: -100, y: -400)
        moveButton.name="move"
        self.addChild(moveButton)
        let myframe = SKShapeNode(rect: CGRect(x: -framesize/2, y: -framesize/2-frameOffset, width: framesize, height: framesize))
        myframe.fillColor = UIColor.red
        myframe.zPosition = 3
        myframe.name = "frame"
        self.addChild(myframe)
        for i in 0...(puzzleSize*puzzleSize-1) {
            // print(i)
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
            gamePiece.position = CGPoint(x: -framesize/2+column*framesize/puzzleSize, y: framesize/2-framesize/puzzleSize-row*framesize/puzzleSize-frameOffset)
         
            
            
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
        // print(board)
        mix(nummoves: 50)
        let testArray = [[1,2,3],[4,5]]
        print("test array")
        print(testArray)
        let newarray = changesarray(myarray: testArray)
        print(newarray)
        //self.addChild(myframe)
    }
    
    func initializeMoves() {
        moveArray.append([[1,2,3],[4,5]])
        moveArray.append([[6,8,9]])
    }
    func addMoveList() {
        let numMoves = 3
        framesize = Int(2/3*theSize)
        let boxWidth = 3/4*screenWidth
        let boxHeight = 0.25*screenHeight
        let boxCenter: CGPoint = CGPoint(x: 0, y: screenHeight/2-boxHeight/2-50)
        let moveBox = SKSpriteNode(color: UIColor.blue, size: CGSize(width: boxWidth, height: boxHeight))
        // let moveBox = SKShapeNode(rect: CGRect(x: boxCenter.x-boxWidth/2, y: boxCenter.y+boxHeight/2, width: boxWidth, height: boxHeight))
        // moveBox.fillColor = UIColor.blue
        moveBox.position = boxCenter
        moveBox.zPosition = 3
        
        moveBox.name = "movebox"
        
        // add buttons to movebox
        let buttonWidth: CGFloat = 0.3*boxWidth
        let buttonHeight: CGFloat = 0.15*boxHeight
        for i in 0..<12 {
            let moveButton = SKShapeNode(rectOf: CGSize(width: buttonWidth, height: buttonHeight))
            // let moveButton = SKShapeNode(rect: CGRect(x: CGFloat(i*20)+buttonWidth/2, y: CGFloat(i*20)-buttonHeight/2, width: buttonWidth, height: buttonHeight))
            moveButton.fillColor = UIColor.orange
            moveButton.name = "movebutton,"+String(i+1)
            moveButton.zPosition = 5
            // moveButton.position = convert(moveButton.position, from: moveBox)
            moveBox.addChild(moveButton)
            moveButton.position = CGPoint(x: -CGFloat(boxWidth)/3+CGFloat(boxWidth/3)*CGFloat(i%3), y: CGFloat(boxHeight)/3-boxHeight/4*CGFloat(Int(i/3)))
            // moveButton.position.x = 100
            // moveButton.position.y = 100
        }
        self.addChild(moveBox)
        
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
            // print("in mix")
    //        print(numbers)
            // let subarray = numbers[0...2]
            for i in 0..<moveSize {
                movearray.append(numbers[i]-1)
            }
            // print(movearray)
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
                if let thename = node.name {
                    print(thename)
                    if thename == "move" {
                        // need to make it so the positions are given
                        print(changesarray(myarray: [[1,2],[3,4,5]]))
                        // makemoves(myarray: [[board[1]-1,board[2]-1],[board[3]-1,board[4]-1,board[5]-1]])
                        makemoves(myarray: changesarray(myarray: [[1,2],[3,4,5]]))
                    }
                    if thename.hasPrefix("movebutton") {
                        print("found a movebutton!")
                        let thenumberstring = Int(thename.components(separatedBy: ",")[1])
                        let thenumber = Int(thenumberstring!)
                        print("move number \(thenumber)")
                        // print(moveArray[Int(thenumber) ?? 1-1])
                        if thenumber <= moveArray.count {
                            print(moveArray[thenumber-1])
                            makemoves(myarray: changesarray(myarray: moveArray[thenumber-1]))
                        }
                    }
                }
                if Array(node.name!)[0] == "p" {
                    let n=Int(node.name!.components(separatedBy: ",")[1])!
                    // print("nodeclicked")
                    // print(n)
                    // print(chosennumbers.count)
                    // print(chosennumbers)
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
                    }
                }
                else if Array(node.name!)[0] == "b" {
                    let scene = MainMenuScene(fileNamed: "MainMenuScene")
                    scene!.scaleMode = .aspectFit
                    self.view?.presentScene(scene)
                }

            }
        }

    }
    
    func changesarray(myarray: [[Int]]) -> [[Int]] {
        var returnarray: [[Int]] = []
        for i in 0..<myarray.count {
            var subarray: [Int] = []
            for j in 0..<myarray[i].count {
                print("\(i) and \(j)")
                print(myarray[i][j])
                subarray.append(board[myarray[i][j]]-1)
            }
            returnarray.append(subarray)
        }
        return(returnarray)
    }
    
    func takesarray(myarray: [Int]) {
        print("takesarray")
        print(myarray.count)
    }
    
    func takesarrayofarrays(myarray: [[Int]]) {
        for i in myarray {
            for j in i {
                print(j)
            }
        }
    }
    
    func makemoves(myarray: [[Int]]) {
        for i in myarray {
                makemove(myarray: i, howLong: 0.5)
            }
    }
    
    func makemove(myarray: [Int], howLong: TimeInterval) {
        print("makemove \(myarray)")
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
        for j in 0..<myarray.count {
            // print(1+myarray[j])
            // print(board.firstIndex(of: 1+myarray[j]))
            posarray.append(board.firstIndex(of: 1+myarray[j])!)
        }
        // print("posarray")
        // print(posarray)
        let tempint = board[posarray[posarray.count-1]]
        for j in 0..<myarray.count-1 {
            // print("moving \(j) to \(j+1)")
            board[posarray[j+1]] = myarray[j]+1
            // print(board)
        }
        // board[myarray[1]] = board[myarray[0]]
        board[posarray[0]] = tempint
        // print(board)
        
        // print(board)
        // chosennumbers[0]=0
        // chosennumbers[1]=0
        chosennumbers.removeAll()
        nodesselected = 0
    }
}
