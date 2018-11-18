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
    var shuffleStart = true
    let puzzleSize = 4
    var puzzleWidth = 4
    var puzzleHeight = 4
    var moveSize = 0
    var board: [Int] = []
    var restartboard: [Int] = []
    var moveArray: [[[Int]]] = []
    var startPosition: [[Int]] = []
    var nodelist: [SKShapeNode] = []
    var chosennumbers: [Int] = []
    var originalPositions: [CGPoint] = []
    var nodesselected = 0
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var theSize: CGFloat = 0
    var numShuffle: Int = 50
    var scalePieces: CGFloat = 1.0
    var frameOffset: Int = 100
    var frameOffsetX: Int = 0
    var theMode: Int = 0
    var menuMoves: Bool = true
    var LShape: Bool = false // for the L shape 15 like puzzle
    var fifteen: Bool = false // for 15 game
    var numcube: Bool = false // for number cube
    // new comment
    // another new comment
    override func didMove(to view: SKView) {
        // print("testing makeinverse")
        // print(makeInverse(myarray: [[1,2,3],[4,5]]))
        // chosennumbers.append(0)
        // chosennumbers.append(0)
        if let mode = self.userData?.value(forKey: "mode") {
            print("mode is \(mode)")
            theMode = mode as! Int
            theMode = theMode-2
            moveSize = mode as! Int
        }
        
        initializeMoves()
        print("shuffleStart is \(shuffleStart)")
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
        framesize = Int(2/3*theSize*scalePieces)
        let menuButtonSize: CGFloat = 50
        let menuButtonY: CGFloat = -520
        let backButton = SKShapeNode(circleOfRadius: menuButtonSize)
        backButton.fillColor = UIColor.green
        backButton.position = CGPoint(x: -100, y: menuButtonY)
        backButton.name="back"
        let menuText = SKLabelNode(text: "MENU")
        menuText.name = "textmenu"
        menuText.fontName = "AvenirNext-Bold"
        menuText.fontSize = 18.0
        // startOverText.color = UIColor.black
        menuText.zPosition = 6
        backButton.addChild(menuText)
        self.addChild(backButton)
        let solveButton = SKShapeNode(circleOfRadius: menuButtonSize)
        solveButton.fillColor = UIColor.blue
        solveButton.position = CGPoint(x: 0, y: menuButtonY)
        solveButton.name="solve"
        let solveText = SKLabelNode(text: "SOLVE")
        solveText.name = "textsolve"
        solveText.fontName = "AvenirNext-Bold"
        solveText.fontSize = 18.0
        // startOverText.color = UIColor.black
        solveText.zPosition = 6
        solveButton.addChild(solveText)
        self.addChild(solveButton)
        let shuffleButton = SKShapeNode(circleOfRadius: menuButtonSize)
        shuffleButton.fillColor = UIColor.orange
        shuffleButton.position = CGPoint(x: 100, y: menuButtonY)
        shuffleButton.name="shuffle"
        let shuffleText = SKLabelNode(text: "MIX")
        shuffleText.fontName = "AvenirNext-Bold"
        shuffleText.fontSize = 18.0
        shuffleText.name = "textshuffle"
        // startOverText.color = UIColor.black
        shuffleText.zPosition = 6
        shuffleButton.addChild(shuffleText)
        self.addChild(shuffleButton)
        
        let startOverButton = SKShapeNode(circleOfRadius: menuButtonSize)
        startOverButton.fillColor = UIColor.purple
        // startOverButton.alpha = 0.5
        startOverButton.position = CGPoint(x: 200, y: menuButtonY)
        startOverButton.name="startover"
        let startOverText = SKLabelNode(text: "RESTART")
        startOverText.name = "textstartover"
        startOverText.fontName = "AvenirNext-Bold"
        startOverText.fontSize = 18.0
        // startOverText.color = UIColor.black
        startOverText.zPosition = 6
        startOverButton.addChild(startOverText)
        self.addChild(startOverButton)
        
        let moveButton = SKShapeNode(circleOfRadius: 50)
        moveButton.fillColor = UIColor.blue
        moveButton.position = CGPoint(x: -100, y: -400)
        moveButton.name="move"
        // self.addChild(moveButton)
        let myframe = SKShapeNode(rect: CGRect(x: -framesize/2-frameOffsetX, y: -framesize/2-frameOffset, width: framesize, height: framesize))
        myframe.fillColor = UIColor.red
        myframe.zPosition = 3
        myframe.name = "frame"
        self.addChild(myframe)
        print("framesize \(framesize)")
        for i in 0...(puzzleWidth*puzzleHeight-1) {
            // print(i)
            board.append(Int(i+1))
            let row = Int(i/puzzleWidth)
            let column = i%puzzleWidth
            var squareWidth: CGFloat = CGFloat(framesize/puzzleWidth)
            var squareHeight: CGFloat = CGFloat(framesize/puzzleWidth)
            // print(row)
            // print(column)
            // let pieceWidth = scalePieces*CGFloat(framesize/puzzleWidth)
            // let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: pieceWidth, height: pieceWidth))
            // let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: framesize/puzzleSize, height: framesize/puzzleSize))
            let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: squareWidth, height: squareWidth))
            // let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: framesize/puzzleWidth, height: framesize/puzzleHeight))
            gamePiece.name = "piece,"+String(i)
            if !(theMode==4) {
                gamePiece.fillColor = UIColor.yellow
            }
            else {
                gamePiece.fillColor = UIColor.white
            }
            if fifteen && i==15 {
                gamePiece.fillColor = UIColor.black
            }
            gamePiece.strokeColor = UIColor.black
            gamePiece.zPosition = 4
            // let gamePiecePosition = CGPoint(x: -framesize/2+column*framesize/puzzleSize, y: framesize/2-framesize/puzzleSize-row*framesize/puzzleSize-frameOffset)
            let gamePiecePosition = CGPoint(x: -framesize/2+column*framesize/puzzleWidth-frameOffsetX, y: framesize/2-framesize/puzzleHeight-row*framesize/puzzleWidth-frameOffset)
            
            
            originalPositions.append(gamePiecePosition)
            // gamePiece.position = CGPoint(x: -framesize/2+column*framesize/puzzleSize, y: framesize/2-framesize/puzzleSize-row*framesize/puzzleSize-frameOffset)
            gamePiece.position = gamePiecePosition
         
            
            
            let tritext = SKLabelNode(text: String(i+1))
            tritext.fontColor = UIColor.black
            if numcube && [1,3,7,9,19,21,25,27].contains(i+1) {
                tritext.fontColor = UIColor.red
            }
            if numcube && [2,4,6,8,10,12,16,18,20,22,24,26].contains(i+1) {
                tritext.fontColor = UIColor.blue
            }
            tritext.fontName = "AvenirNext-Bold"
            tritext.fontSize = 64
            tritext.horizontalAlignmentMode = .center
            tritext.verticalAlignmentMode = .center
            tritext.position = CGPoint(x: framesize/(puzzleWidth*2), y: framesize/(puzzleWidth*2))
            tritext.name = "text"+String(i+1)
            tritext.zPosition = 5
            gamePiece.addChild(tritext)
            nodelist.append(gamePiece)
            myframe.addChild(gamePiece)
            // tritext.position = CGPoint(x: 0, y: 0)
            
            
        }
        // print(board)
        if shuffleStart {
            mix(nummoves: numShuffle)
            restartboard = Array(board)
        }
        else {
            makemoves(myarray: startPosition)
        }
        // let testArray = [[1,2,3],[4,5]]
        // print("test array")
        // print(testArray)
        // let newarray = changesarray(myarray: testArray)
        // print(newarray)
        //self.addChild(myframe)
    }
    
    func initializeMoves() {
        print("in initializeMoves theMode is \(theMode)")
        print("shuffleStart was \(self.shuffleStart)")
        if theMode == 0 {
            moveSize = 2
            self.shuffleStart = true
            menuMoves = false
        }
        if theMode == 1 {
            moveSize = 3
            self.shuffleStart = true
            menuMoves = false
        }
        if theMode == 2 {
            moveSize = 3
            self.shuffleStart = true
            menuMoves = false
            self.LShape = true
            // moveArray.append([[1,2,3],[4,5]])
            // moveArray.append([[6,8,9]])
        }
        if theMode == 3 {
            moveSize = 3
            self.fifteen = true
            self.shuffleStart = true
            menuMoves = false
            // moveArray.append([[1,2,3],[4,5]])
            // moveArray.append([[6,8,9]])
        }
        else if theMode == 4 {
            // moveSize = 0
            self.frameOffset = -270
            self.frameOffsetX = 100
            self.scalePieces = 0.60
            self.puzzleWidth = 3
            self.puzzleHeight = 9
            self.shuffleStart = false
            self.numcube = true
            moveArray.append([[1,2,3],[4,5]])
            moveArray.append([[6,8,9]])
        }
        else if theMode == 5 {
            // moveSize = 0
            self.shuffleStart = false
            startPosition = [[0,4],[3,7]]
            moveArray.append([[0,3],[4,7]])
            moveArray.append([[3,7],[8,10,9,12],[11,15]])
            moveArray.append([[3,7],[12,9,10,8],[15,11]])

        }
        else if theMode > 5 {
            moveSize = 0
            self.shuffleStart = false
            moveArray.append([[1,6]])
            // moveArray.append([[6,8,9]])
        }
        print("ending initialize shuffleStart is now \(self.shuffleStart)")
    }
    func addMoveList() {
        let numMoves = 3
        framesize = Int(2/3*theSize)
        let boxWidth = 3/4*screenWidth
        let boxHeight = 0.25*screenHeight
        let boxCenter: CGPoint = CGPoint(x: 0, y: screenHeight/2-boxHeight/2-50)
        let moveBox = SKSpriteNode(color: UIColor.clear, size: CGSize(width: boxWidth, height: boxHeight))
        // let moveBox = SKShapeNode(rect: CGRect(x: boxCenter.x-boxWidth/2, y: boxCenter.y+boxHeight/2, width: boxWidth, height: boxHeight))
        // moveBox.fillColor = UIColor.blue
        moveBox.position = boxCenter
        moveBox.zPosition = 3
        
        moveBox.name = "movebox"
        
        // add buttons to movebox
        let buttonWidth: CGFloat = 0.3*boxWidth
        let buttonHeight: CGFloat = 0.15*boxHeight
        for i in 0..<moveArray.count {
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
        // moveBox.alpha = 0.0
        self.addChild(moveBox)
        
    }
    
    func mix(nummoves: Int) {
        // makemove(myarray: [0,4,5], howLong: 0.05)
        for _ in 0...nummoves {
            if LShape {
                let n = Int.random(in: 1...16)
                if let pos = board.firstIndex(of: n) {
                    if pos/4 < 3 && pos%4 != 3 {
                        // nodelist[n].fillColor = UIColor.green
                        // nodelist[board[pos+1]-1].fillColor = UIColor.green
                        // nodelist[board[pos+4]-1].fillColor = UIColor.green
                        makemove(myarray: [board[pos]-1,board[pos+1]-1,board[pos+4]-1], howLong: 0.5)
                        
                    }
                }
            }
            else if !menuMoves {
                var movearray: [Int] = []
                var numbers: [Int] = []
                for i in 1...puzzleWidth*puzzleHeight {
                    numbers.append(i)
                }
                numbers.shuffle()
                // print("in mix")
        //        print(numbers)
                // let subarray = numbers[0...2]
                for i in 0..<moveSize {
                    movearray.append(numbers[i]-1)
                }
                print("about to make move \(movearray)")
                makemove(myarray: movearray, howLong: 0.05) //0.05)
                print("in mix")
                print("after makemove")
                print("the board is now \(board)")
                print("the restartboard is now \(restartboard)")
            }
            else {
                makemoves(myarray: moveArray.randomElement()!)
                // makemove(myarray: moveArray.randomElement(), howLong: 0.05)
            }
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
                    else if thename == "shuffle" {
                        print("board before shuffle is")
                        print(board)
                        restartboard = Array(board)
                        print("restart board before shuffle is")
                        print(restartboard)
                        mix(nummoves: numShuffle)
                        print("board after shuffle is")
                        print(board)
                        restartboard = Array(board)
                        print("restartboard after shuffle is")
                        print(restartboard)
                    }
                    else if thename == "solve" || thename == "startover" {
                        print(thename)
                        print(board)
                        for i in 0..<puzzleWidth*puzzleHeight {
                            // self.nodelist[i].position = originalPositions[self.nodelist[i]]
                            // print(i)
                            // print(board[i])
                            // print(self.nodelist[board[i]-1].position)
                            // print(originalPositions[board[i]-1])
                            self.nodelist[board[i]-1].position = self.originalPositions[board[i]-1]
                        }
                        for i in 1...(puzzleWidth*puzzleHeight) {
                            // print(i)
                            board[i-1]=i
                        }
                        print("the board should be new now")
                        print(board)
                        if thename == "startover" {
                            if shuffleStart {
                                print(restartboard)
                                for i in 0..<puzzleWidth*puzzleHeight {
                                    // self.nodelist[i].position = originalPositions[self.nodelist[i]]
                                    // print(i)
                                    // print(board[i])
                                    // print(self.nodelist[board[i]-1].position)
                                    // print(originalPositions[board[i]-1])
                                    // self.nodelist[board[i]-1].position = self.originalPositions[board[i]-1]
                                    // go through the restart [4,2,7, etc], get
                                    // nodelist[restart[i]] and change position to
                                    // nodelist[i] so when i=0, node 4 goes to position 0.
                                    // print(i)
                                    // print(restartboard[i]-1)
                                    self.nodelist[restartboard[i]-1].position = self.originalPositions[i]
                                }
                                board = Array(restartboard)
                            }
                            else {
                                makemoves(myarray: startPosition)
                            }
                        }
                    }
                    else if thename.hasPrefix("movebutton") {
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
                if !menuMoves && Array(node.name!)[0] == "p" {
                    let n=Int(node.name!.components(separatedBy: ",")[1])!
                    // print("nodeclicked")
                    // print(n)
                    // print(chosennumbers.count)
                    // print(chosennumbers)
                    if LShape {
                        if let pos = board.firstIndex(of: n+1) {
                            if pos/4 < 3 && pos%4 != 3 {
                                nodelist[n].fillColor = UIColor.green
                                nodelist[board[pos+1]-1].fillColor = UIColor.green
                                nodelist[board[pos+4]-1].fillColor = UIColor.green
                                makemove(myarray: [board[pos]-1,board[pos+1]-1,board[pos+4]-1], howLong: 0.5)

                            }
                            

                            // print("pos \(pos) n \(n)")
                            // print(board)
                            // print("\(board[pos]-1) and \(board[pos+1]-1) and \(board[pos+4]-1)")
                            // makemove(myarray: [board[pos]-1,board[pos+1]-1,board[pos+4]-1], howLong: 0.5)
                        } // if let pos
                        
                        

                    } // if LShape
                    else if fifteen {
                        // check if the 16 is adjacent to it
                        if let pos = board.firstIndex(of: n+1) {
                            var up: Int = -1
                            var down: Int = -1
                            var right: Int = -1
                            var left: Int = -1
                            if pos>3 {
                                up = pos-4
                                // print(board[up])
                                if board[up]==16 {
                                    makemove(myarray: [n,15], howLong: 0.05)
                                }
                            }
                            // print(board[up])
                            if pos<12 {
                                down = pos+4
                                if board[down]==16 {
                                    makemove(myarray: [n,15], howLong: 0.05)
                                }
                                //print(board[down])
                            }
                            // print(board[down])
                            if pos%4<3 {
                                right = pos+1
                                if board[right]==16 {
                                    makemove(myarray: [n,15], howLong: 0.05)
                                }

                                //print(board[right])
                            }
                            // print(board[right])
                            if pos%4>0 {
                                left = pos-1
                                if board[left]==16 {
                                    makemove(myarray: [n,15], howLong: 0.05)
                                }

                                // print(board[left])
                            }
//                            print(board[left])
                        }
                    }
                    else if chosennumbers.count < moveSize {
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
    
    func makeInverse(myarray: [[Int]]) -> [[Int]] {
        // makes the inverse of a given permutation
        // for example
        // makeInverse([[1,2],[3,4,5]]) will return [[5,4,3],[2,1]]
        var reversedArray: [[Int]] = []
        for i in 0..<myarray.count {
            // print(i)
            // print(myarray[myarray.count-1-i])
            var tempArray: [Int] = []
            for j in 0..<myarray[myarray.count-1-i].count {
                print(myarray[myarray.count-1-i][j])
                tempArray.insert(myarray[myarray.count-1-i][j], at: 0)
            }
            // print(tempArray)
            reversedArray.append(tempArray)
        }
        // print("finished")
        // print(reversedArray)
        return reversedArray
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
        // print("makemove \(myarray)")
    //func makemove(firstnum: Int, secondnum: Int, howLong: TimeInterval) {
        // print("makemove \(firstnum) \(secondnum) ")
        // print("in makemove")
        // print(myarray)
        var customHowLong = howLong
        if self.fifteen {
            customHowLong = 0.05
        }
        nodelist[0].run(SKAction.fadeAlpha(to: 1, duration: customHowLong), completion: {
            let temppos = self.nodelist[myarray[0]].position
            if !self.fifteen {
                self.nodelist[myarray[0]].fillColor = UIColor.yellow
            }
            for j in 0..<myarray.count-1 {
                // print("in makemove j= \(j)")
                if !self.fifteen {
                    self.nodelist[myarray[j]].fillColor = UIColor.yellow
                }
                self.nodelist[myarray[j]].position = self.nodelist[myarray[j+1]].position
            }
            // self.nodelist[myarray[1]].fillColor = UIColor.yellow
            self.nodelist[myarray[myarray.count-1]].position = temppos
            if !self.fifteen {
                self.nodelist[myarray[myarray.count-1]].fillColor = UIColor.yellow
            }


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
