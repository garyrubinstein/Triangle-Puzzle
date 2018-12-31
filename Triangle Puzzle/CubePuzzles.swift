//
//  CubePuzzles.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 12/30/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit
//
//  GameScene.swift
//  mixing spritekit and scenekit
//
//  Created by Gary Old Mac on 10/16/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import SpriteKit
import GameplayKit

class CubePuzzles: SKScene {
    // var scnScene: SCNScene
    var cubieArray: [SCNNode] = []
    var buttonOffset: Int = 0
    var showControls: Bool = false
    var colorArray: [UIColor] = []
    var squareColor: UIColor = UIColor.white
    var board: [Int] = []
    var testerCube: SCNNode = SCNNode()
    var testerCubeInitialPivot: SCNMatrix4? = nil
    var originalPosArray: [SCNVector3] = []
    var stateArray: [Int] = []
    var solveMoves: [Int] = []
    var convertStickers: [Int] = []
    var stickersArray: [[Int]] = []
    var pivotArray: [SCNMatrix4] = []
    var colors: Bool = true
    var showFlat: Bool = false
    var isMoving = false
    var yHeight: Int = 0
    var cycleLen: Int = 0
    var cycleText: String = ""
    var cycleArray: [Int] = []
    var cameraText1 = SKLabelNode()
    var showPatternButtons = false
    var winPosx: CGFloat = 300
    var winPosy: CGFloat = 300
    var winSize: CGFloat = 600
    var nodelist: [SKShapeNode] = []
    var flipButtonList: [SKShapeNode] = []
    var nodetextlist: [SKLabelNode] = []
    var cornernodetextlist: [SKLabelNode] = []
    var edgenodetextlist: [SKLabelNode] = []
    var chosennumbers: [Int] = []
    // var originalPositions: [CGPoint] = []
    var nodesselected = 0
    var originalPositions: [CGPoint] = []
    var rotateCorners: Bool = false
    var doCorners: Bool = false
    var doEdges: Bool = false
    var flipEdge: Bool = false
    var flipCorner: Bool = false
    var pauseSpeed: Float = 0.5
    var moveSpeed: Float = 0.5
    var showFaceMoves: Bool = true
    var moveSize: Int = 3
    var mixing: Bool = false
    var rotateFlat: Bool = false
    var edgeOrientations: [Int] = []
    var cornerOrientations: [Int] = []
    // var nodelist: [SKShapeNode] = []
    var showFlipButtons: Bool = false
    var showSolveButton: Bool = true
    var hasFlat: Bool = false
    var flipOneCorner: Bool = false
    var flipTwoCorners: Bool = false
    var startPattern: String = ""
    var flipOneEdge: Bool = false
    var centerState: [Int] = []
    var showMixButton: Bool = true
    
    
    // can access any of the small cubies in this array
    // this has the pointer to the cubies by number
    // need another number array to have which cube is in which position
    // so when one of the rotations happens, I can tell which cubies need
    // to be added to the moving center node so they rotate properly
    // after each move, the position array needs to change accordingly
    let sideLen: CGFloat = 5.0
    override func didMove(to view: SKView) {
        if let mode = self.userData?.value(forKey: "mode") {
            print("mode is \(mode)")
            var theMode = mode as! Int
            theMode = theMode - 13 // to makeup for the fact that it is number 14 on the menu
            if theMode == 1 {
                colors = true
                winPosx = 0
                winPosy = 0
            }
            else if theMode == 2 {
                colors = false
                winPosx = 0
                winPosy = 0
            }
            else if theMode == 3 {
                colors = true
                winPosx = 200
                winPosy = 500
                winSize = 500
                showFlat = true
                buttonOffset = -100
                pauseSpeed = 0.25
                moveSpeed = 0.125
                showFaceMoves = false
                rotateFlat = true
                showFlipButtons = true
                showSolveButton = false
                hasFlat = true
            }
            else if theMode == 4 {
                colors = false
                winPosx = 200
                winPosy = 500
                winSize = 500
                buttonOffset = -100
                showFlat = true
                pauseSpeed = 0.25
                moveSpeed = 0.125
                showFaceMoves = false
                rotateFlat = false
                showSolveButton = false
                hasFlat = true
            }
            else if theMode == 5 {
                colors = true
                winPosx = 0
                winPosy = 0
                flipOneCorner = true
                startPattern = "FdfrdR"
                showMixButton = false
            }
            else if theMode == 6 {
                colors = true
                winPosx = 0
                winPosy = 0
                flipTwoCorners = true
                startPattern = "FdfrdRurDRFDfU"
                showMixButton = false
            }
            else if theMode == 7 {
                colors = false
                winPosx = 0
                winPosy = 0
                // flipTwoCorners = true
                showMixButton = false
                startPattern = "DRUrdRur"
            }
            else if theMode == 8 {
                colors = true
                winPosx = 0
                winPosy = 0
                flipOneCorner = true
                startPattern =  "urddUULLDuf" //"FUdlluuDDRU" //"rUUddlluDfu"
                showMixButton = false
            }
            else if theMode == 9 {
                colors = true
                winPosx = 0
                winPosy = 0
                // flipOneCorner = true
                startPattern = "FUdlluuDDRUrUUddlluDfu"
                showMixButton = false
            }
            else if theMode == 10 {
                colors = false
                winPosx = 0
                winPosy = 0
                // flipOneCorner = true
                startPattern = "dfEFDfeF" // fEFdfeFD"
                showMixButton = false
            }
            // theMode = theMode-2
            // moveSize = mode as! Int
        }
        
        if showFlat {
            initSquares()
        }
        edgeOrientations = [0,0,0,0,0,0,0,0,0,0,0,0]
        cornerOrientations = [0,0,0,0,0,0,0,0]
        centerState = [0,1,2,3,4,5,6] // as middle slice moves, the 1,5,4,2 will get moved around
        initializeStickerArray()
        // make text label
        cameraText1 = SKLabelNode(text: "hello")
        cameraText1.fontName = "Helvetica"
        cameraText1.fontColor = UIColor.black
        cameraText1.fontSize = 32
        cameraText1.zPosition = 5
        cameraText1.position = CGPoint(x: -100, y: 400)
        if showControls {
            addChild(cameraText1)
            
        }
        // make control buttons
        let colorsList = makeColors()
        let centerArray: [Int] = [15,17,5,13,11,23,14]
        for i in 1...7 {
            var redNode = SKSpriteNode(imageNamed: String(centerArray[i-1])+"pic.png")
            redNode.size = CGSize(width: 60.0, height: 60.0)
            redNode.color = colorsList[i-1]
            if colors {
                // redNode.texture = SKTexture(
                redNode = SKSpriteNode(color: colorsList[i-1], size: CGSize(width: 60.0, height: 60.0))
                redNode.colorBlendFactor = 1.0
            }
            // let redNode = SKShapeNode(rectOf: CGSize(width: 60.0, height: 60.0))
            // let redNode2 = SKShapeNode(circleOfRadius: 35.0)
            // redNode.fillColor = colorsList[i-1]
            redNode.position = CGPoint(x: -200+i*70, y: -500)
            redNode.name = "button,"+String(i)
            if showFaceMoves {
                self.addChild(redNode)
            }
            
        }
        for i in 1...8 {
            let blueNode = SKShapeNode(circleOfRadius: 35.0)
            blueNode.fillColor = UIColor.blue
            blueNode.position = CGPoint(x: -200+i*70, y: 500)
            blueNode.name = "cbutton,"+String(i)
            if showControls {
                self.addChild(blueNode)
            }
        }
        let solveNode = SKShapeNode(circleOfRadius: 35.0)
        solveNode.fillColor = UIColor.blue
        solveNode.position = CGPoint(x: -200+buttonOffset, y: 600)
        solveNode.name = "solver"
        if showSolveButton {
            self.addChild(solveNode)
        }
        let mixNode = SKShapeNode(circleOfRadius: 35.0)
        mixNode.fillColor = UIColor.purple
        mixNode.position = CGPoint(x: -100+buttonOffset, y: 600)
        mixNode.name = "mixer"
        if showMixButton {
            self.addChild(mixNode)
        }
        let patternNode = SKShapeNode(circleOfRadius: 35.0)
        patternNode.fillColor = UIColor.black
        patternNode.position = CGPoint(x: 0+buttonOffset, y: 600)
        patternNode.name = "pattern"
        self.addChild(patternNode)
        for i in 1...8 {
            let purpleNode = SKShapeNode(circleOfRadius: 35.0)
            purpleNode.fillColor = UIColor.white
            // purpleNode.fillColor = colorsList[i-1]
            purpleNode.position = CGPoint(x: -400+i*70, y: 500)
            purpleNode.name = "makepattern,"+String(i)
            let numstr = String(i)
            let newtextNode = SKLabelNode(text: numstr)
            newtextNode.name = "text"
            newtextNode.fontSize = 64
            newtextNode.fontColor = UIColor.black
            newtextNode.position = CGPoint(x: -400+i*70, y: 525)
            // self.addChild(purpleNode)
            // self.addChild(newtextNode)
        }
        for i in 1...12 {
            let purpleNode = SKShapeNode(circleOfRadius: 30.0)
            purpleNode.fillColor = UIColor.white
            // purpleNode.fillColor = colorsList[i-1]
            purpleNode.position = CGPoint(x: -400+i*60, y: 450)
            purpleNode.name = "makeedgepattern,"+String(i)
            let numstr = String(i)
            let newtextNode = SKLabelNode(text: numstr)
            newtextNode.name = "text"
            newtextNode.fontSize = 64
            newtextNode.fontColor = UIColor.black
            newtextNode.position = CGPoint(x: -400+i*60, y: 475)
            // purpleNode.addChild(newtextNode)
            if showControls {
                self.addChild(purpleNode)
                self.addChild(newtextNode)
            }
        }
        let purpleNode = SKShapeNode(circleOfRadius: 30.0)
        purpleNode.fillColor = UIColor.blue
        purpleNode.name = "middleslice"
        purpleNode.position = CGPoint(x: -200, y: -100)
        // self.addChild(purpleNode)
        let patternText = SKLabelNode(text: "")
        patternText.name = "patternText"
        patternText.fontSize = 64
        patternText.fontColor = UIColor.black
        patternText.position = CGPoint(x: -250, y: 400)
        if hasFlat {
            self.addChild(patternText)
        }
        let middlebackNode = SKShapeNode(circleOfRadius: 30.0)
        middlebackNode.fillColor = UIColor.green
        middlebackNode.name = "middleback"
        middlebackNode.position = CGPoint(x: -200, y: 0)
        // self.addChild(middlebackNode)
        let flipedgebutton = SKShapeNode(rectOf: CGSize(width: 60.0, height: 60.0)) // SKShapeNode(circleOfRadius: 30.0)
        flipedgebutton.fillColor = UIColor.blue
        flipedgebutton.name = "flipedge"
        flipedgebutton.position = CGPoint(x: -200, y: -300)
        flipButtonList.append(flipedgebutton)
        if hasFlat {
            self.addChild(flipedgebutton)
        }
        
        let flipcornerbutton = SKShapeNode(rectOf: CGSize(width: 60.0, height: 60.0))
        flipcornerbutton.fillColor = UIColor.red
        flipcornerbutton.name = "flipcorner"
        flipcornerbutton.position = CGPoint(x: -200, y: -400)
        flipButtonList.append(flipcornerbutton)
        if hasFlat {
            self.addChild(flipcornerbutton)
        }
        
        /*         let middlebackNode = SKShapeNode(circleOfRadius: 30.0)
         middlebackNode.fillColor = UIColor.green
         middlebackNode.name = "middleback"
         middlebackNode.position = CGPoint(x: -200, y: 0)
         self.addChild(middlebackNode) */
        for i in 1...6 {
            let purpleNode = SKShapeNode(circleOfRadius: 35.0)
            purpleNode.fillColor = UIColor.purple
            // purpleNode.fillColor = colorsList[i-1]
            purpleNode.position = CGPoint(x: -200+i*70, y: -600)
            purpleNode.name = "pbutton,"+String(i)
            if showControls {
                self.addChild(purpleNode)
                
            }
        }
        // let centerArray: [Int] = [17,15,5,11,13,23]
        // moves 7 to 12
        for i in 1...7 {
            // let greenNode2 = SKShapeNode(rectOf: CGSize(width: 60.0, height: 60.0))
            // let greenNode = SKShapeNode(circleOfRadius: 35.0)
            var greenNode = SKSpriteNode(imageNamed: String(centerArray[i-1])+"pic.png")
            greenNode.size = CGSize(width: 60.0, height: 60.0)
            greenNode.color = colorsList[i-1]
            if colors {
                greenNode = SKSpriteNode(color: colorsList[i-1], size: CGSize(width: 60.0, height: 60.0))
                greenNode.colorBlendFactor = 1.0
            }
            // greenNode.fillColor = colorsList[i-1] //UIColor.green
            greenNode.position = CGPoint(x: -200+i*70, y: -400)
            greenNode.name = "gbutton,"+String(i)
            if showFaceMoves {
                self.addChild(greenNode)
            }
        }
        let scnScene: SCNScene = {
            let scnScene = SCNScene()
            // this is the cube that moves
            let cubeGeometry = SCNBox(width: sideLen, height: sideLen, length: sideLen, chamferRadius: 0.5)
            cubeGeometry.name = "cubeG"
            cubeGeometry.firstMaterial?.diffuse.contents = UIColor.red
            let cubeNode = SCNNode(geometry: cubeGeometry)
            cubeNode.position = SCNVector3(0, yHeight, 0)
            cubeNode.name = "cubeN"
            
            // this is the stationary cube
            let cubeGeometrys = SCNBox(width: sideLen, height: sideLen, length: sideLen, chamferRadius: 0.5)
            cubeGeometrys.name = "cubesG"
            cubeGeometrys.firstMaterial?.diffuse.contents = UIColor.clear
            let cubeNodes = SCNNode(geometry: cubeGeometrys)
            cubeNodes.position = SCNVector3(0, yHeight, 0)
            cubeNodes.name = "cubesN"
            
            
            
            var k = 0
            
            // make top layer
            for i in -1...1 {
                for j in -1...1 {
                    stateArray.append(k)
                    k=k+1
                    let cubeGeometry2 = SCNBox(width: sideLen, height: sideLen, length: sideLen, chamferRadius: 0.5)
                    
                    
                    
                    cubeGeometry2.name = "toplayer"+String(k)
                    // cubeGeometry2.firstMaterial?.diffuse.contents = UIColor.green
                    let blackMaterial = SCNMaterial()
                    blackMaterial.diffuse.contents = UIColor.black //UIImage(named: "w")
                    blackMaterial.locksAmbientWithDiffuse   = false;
                    if(colors) {
                        
                        // cubeGeometry2.materials = makeColorArray()
                        // var imageMaterial = SCNMaterial()
                        var materialArray: [SCNMaterial] = []
                        for i in 0...5 {
                            if stickersArray[k-1].contains(i) {
                                materialArray.append(makeColorArray()[i])
                            }
                            else {
                                materialArray.append(blackMaterial)
                            }
                        }
                        cubeGeometry2.materials = materialArray
                    }
                    else {
                        // cubeGeometry2.materials = [blueMaterial, blueMaterial, blueMaterial, blueMaterial, blueMaterial, blueMaterial]
                        var imageMaterial = SCNMaterial()
                        let image = UIImage(named: String(convertStickers[k-1])+"pic.png")
                        imageMaterial.diffuse.contents = image
                        var materialArray: [SCNMaterial] = []
                        for i in 0...5 {
                            if stickersArray[k-1].contains(i) {
                                materialArray.append(imageMaterial)
                            }
                            else {
                                materialArray.append(blackMaterial)
                            }
                        }
                        cubeGeometry2.materials = materialArray // [imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial]
                    }
                    let cubeNode2 = SCNNode(geometry: cubeGeometry2)
                    cubieArray.append(cubeNode2)
                    cubeNodes.addChildNode(cubeNode2)
                    cubeNode2.position = SCNVector3(i*5, 5, j*5)
                    originalPosArray.append(SCNVector3(i*5,5,j*5))
                    
                }
            }
            let grayMaterial = SCNMaterial()
            grayMaterial.diffuse.contents = UIColor.gray // UIImage(named: "y")
            grayMaterial.locksAmbientWithDiffuse = true;
            // make middle layer
            for i in -1...1 {
                for j in -1...1 {
                    stateArray.append(k)
                    k=k+1
                    let cubeGeometry2 = SCNBox(width: sideLen, height: sideLen, length: sideLen, chamferRadius: 0.5)
                    
                    // cubeGeometry2.materials =  makeColorArray()
                    let blackMaterial = SCNMaterial()
                    blackMaterial.diffuse.contents = UIColor.black //UIImage(named: "w")
                    blackMaterial.locksAmbientWithDiffuse   = false;
                    
                    
                    if(colors) {
                        
                        // cubeGeometry2.materials = makeColorArray()
                        // var imageMaterial = SCNMaterial()
                        var materialArray: [SCNMaterial] = []
                        for i in 0...5 {
                            if stickersArray[k-1].contains(i) {
                                // print("in middle \(k)")
                                if !flipOneCorner || [11,13,15,17].contains(k){
                                    materialArray.append(makeColorArray()[i])
                                }
                                else {
                                    materialArray.append(grayMaterial)
                                }
                                
                            }
                            else {
                                materialArray.append(blackMaterial)
                            }
                        }
                        cubeGeometry2.materials = materialArray
                    }
                    else {
                        // cubeGeometry2.materials = [blueMaterial, blueMaterial, blueMaterial, blueMaterial, blueMaterial, blueMaterial]
                        var imageMaterial = SCNMaterial()
                        var tileName: String = String(convertStickers[k-1])+"pic.png"
                        // print("the tilename is \(tileName)")
                        var image = UIImage(named: tileName)
                        imageMaterial.diffuse.contents = image
                        var materialArray: [SCNMaterial] = []
                        for i in 0...5 {
                            if stickersArray[k-1].contains(i) {
                                materialArray.append(imageMaterial)
                            }
                            else {
                                materialArray.append(blackMaterial)
                            }
                        }
                        cubeGeometry2.materials = materialArray
                    }
                    
                    
                    
                    cubeGeometry2.name = "midlayer"+String(k)
                    // cubeGeometry2.firstMaterial?.diffuse.contents = UIColor.red
                    let cubeNode2 = SCNNode(geometry: cubeGeometry2)
                    cubieArray.append(cubeNode2)
                    cubeNodes.addChildNode(cubeNode2)
                    cubeNode2.position = SCNVector3(i*5, 0, j*5)
                    originalPosArray.append(SCNVector3(i*5,0,j*5))
                    
                    
                }
            }
            
            // make bottom layer
            for i in -1...1 {
                for j in -1...1 {
                    stateArray.append(k)
                    k=k+1
                    let cubeGeometry2 = SCNBox(width: sideLen, height: sideLen, length: sideLen, chamferRadius: 0.5)
                    let blackMaterial = SCNMaterial()
                    blackMaterial.diffuse.contents = UIColor.black //UIImage(named: "w")
                    blackMaterial.locksAmbientWithDiffuse   = false;
                    if(colors) {
                        
                        // cubeGeometry2.materials = makeColorArray()
                        // var imageMaterial = SCNMaterial()
                        var materialArray: [SCNMaterial] = []
                        for i in 0...5 {
                            if stickersArray[k-1].contains(i) {
                                if !flipOneCorner {
                                    materialArray.append(makeColorArray()[i])
                                }
                                else {
                                    materialArray.append(grayMaterial)
                                }
                                
                            }
                            else {
                                materialArray.append(blackMaterial)
                            }
                        }
                        cubeGeometry2.materials = materialArray
                    }
                    else {
                        // cubeGeometry2.materials = [blueMaterial, blueMaterial, blueMaterial, blueMaterial, blueMaterial, blueMaterial]
                        var imageMaterial = SCNMaterial()
                        var tileName: String = String(convertStickers[k-1])+"pic.png"
                        // print("the tilename is \(tileName)")
                        var image = UIImage(named: tileName)
                        imageMaterial.diffuse.contents = image
                        var materialArray: [SCNMaterial] = []
                        for i in 0...5 {
                            if stickersArray[k-1].contains(i) {
                                materialArray.append(imageMaterial)
                            }
                            else {
                                materialArray.append(blackMaterial)
                            }
                        }
                        cubeGeometry2.materials = materialArray
                    }
                    //cubeGeometry2.materials = makeColorArray()
                    cubeGeometry2.name = "botlayer"+String(k)
                    // cubeGeometry2.firstMaterial?.diffuse.contents = UIColor.red
                    let cubeNode2 = SCNNode(geometry: cubeGeometry2)
                    cubieArray.append(cubeNode2)
                    cubeNodes.addChildNode(cubeNode2)
                    cubeNode2.position = SCNVector3(i*5, -5, j*5)
                    originalPosArray.append(SCNVector3(i*5,-5,j*5))
                    
                    
                }
            }
            testerCube = makeTesterCube()
            // cubeNodes.addChildNode(testerCube)
            
            // making pivot array
            // for pi in [14,16,12,10,4,22] {
            // pivotArray.append(cubieArray[pi].pivot) // for F
            // }
            
            
            // print(stateArray)
            // let torusGeometry = SCNTorus(ringRadius: 10, pipeRadius: 3)
            // torusGeometry.name = "torusG"
            // torusGeometry.firstMaterial?.diffuse.contents = UIColor.red
            // let torusNode = SCNNode(geometry: torusGeometry)
            // torusNode.name = "torusN"
            // torusNode.position = SCNVector3(0, 60, 0)
            // torusNode.eulerAngles = SCNVector3(x: Float(CGFloat.pi / 2), y: 0, z: 0)
            // scnScene.rootNode.addChildNode(torusNode)
            scnScene.rootNode.addChildNode(cubeNode)
            scnScene.rootNode.addChildNode(cubeNodes)
            return scnScene
        }()
        
        let node = SK3DNode(viewportSize: CGSize(width: winSize, height: winSize))
        node.scnScene = scnScene
        node.position = CGPoint(x: winPosx, y: winPosy)
        node.name = "3d"
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.intensity = 40
        node.pointOfView?.light = ambientLight
        // node.scnScene?.rootNode.addChildNode(ambientLight)
        node.autoenablesDefaultLighting = false
        let blueMaterial  = SCNMaterial()
        blueMaterial.diffuse.contents = UIColor.black
        // node.scnScene?.background.contents  = blueMaterial
        // node.scnScene?.contents. = UIColor.white
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 23, y: Float(yHeight+23), z: 23)
        if let lookAtTarget = scnScene.rootNode.childNode(withName: "cubesN", recursively: true) { //
            //scnScene.rootNode.childNodes.first {
            var abc = 7
            print("found cubesN")
            // let constraint = SCNLookAtConstraint.init(target: lookAtTarget)
            // let constraint = SCNLookAtConstraint(target: lookAtTarget)
            // cameraNode.constraints = [ constraint ]
        }
        node.pointOfView = cameraNode
        //cameraNode.constraints = [SCNLookAtConstraint(target: scnScene.rootNode.childNode(withName: "cubesN", recursively: true))]
        // node.scnScene.background =
        // node.pointOfView?.position = SCNVector3(x: 23, y: Float(yHeight+23), z: 23)
        // node.pointOfView?.constraints = [SCNLookAtConstraint(target: )]
        node.pointOfView?.rotation = SCNVector4(-4, 5, 1, 0.95)
        if #available(iOS 11.0, *) {
            node.pointOfView?.camera?.fieldOfView = 45.0
        } else {
            // Fallback on earlier versions
        }
        //
        // let ambientLight = SCNLight()
        // ambientLight.type = .ambient
        // ambientLight.intensity = 40
        // scnScene.rootNode.addChildNode(ambientLight)
        // self.addChild(ambientLight)
        node.zPosition = 3
        self.addChild(node)
        // let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        // backgroundView.backgroundColor = UIColor.black
        // self.addChild(backgroundView)
        let backgroundSquare = SKShapeNode(rect: CGRect(x: -winSize/2+winPosx, y: -winSize/2+winPosy, width: winSize, height: winSize))
        backgroundSquare.fillColor = UIColor.brown
        backgroundSquare.zPosition = 1
        self.addChild(backgroundSquare)
        if !(startPattern == "") {
            rotateLayer(face: doPattern(moves: startPattern), pauseTime: 0.0, rotateTime: 0.0)
        }
        
    }
    
    // end of didMoveTo
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var faceToRotate: Int = -1
        var clockwise: Bool = true
        // var rotateCorners: Bool = true
        let cornerSquares: [Int] = [1,3,7,9,19,21,25,27]
        let edgeSquares: [Int] = [2,4,6,8,10,12,16,18,20,22,24,26]
        // let moveSize = 3
        let numcube: Bool = true
        var nodeName = ""
        print("touch")
        if hasFlat {
            var mySprite: SKLabelNode = childNode(withName: "patternText") as! SKLabelNode
            if isSynced() {
                mySprite.text = ""
            }
            else {
                mySprite.text = "\(chosennumbers) ERROR"
            }
            
        }
        // .text = "changed"
        // makemoves(myarray: [[2,3]])
        // figure out which button is pressed
        for touch in touches {
            // let moveSize = 3
            // let numcube: Bool = true
            let location = touch.location(in: self)
            var node: SKNode = self.atPoint(location)
            let nodesatpoint: [SKNode] = self.nodes(at: location)
            // go through all nodes on the list and stop when you get one with 'piece'
            var done: Bool = false
            
            outerLoop: for i in nodesatpoint {
                if let nodeName2 = i.name {
                    print(nodeName)
                    if nodeName2.hasPrefix("piece") {
                        done = true
                        node = i
                        break outerLoop
                    }
                }
                if done {
                    break
                }
            }
            if let nodeName = node.name {
                print(nodeName)
                
                if !isMoving && !flipEdge && chosennumbers.count==0 && node.name?.hasPrefix("flipedge") ?? false {
                    print("flipedge")
                    flipEdge = true
                    moveSize=2
                    flipButtonList[0].fillColor = UIColor.green
                }
                if !isMoving && !flipCorner && chosennumbers.count==0 && node.name?.hasPrefix("flipcorner") ?? false {
                    print("flipcorner")
                    flipCorner = true
                    flipButtonList[1].fillColor = UIColor.green
                    
                    moveSize=2
                }
                if !isMoving && flipEdge && node.name?.hasPrefix("piece") ?? false {
                    let n=Int(node.name!.components(separatedBy: ",")[1])!
                    if !chosennumbers.contains(n) && [1,3,5,7,9,11,15,17,19,21,23,25].contains(n){
                        chosennumbers.append(n)
                        nodelist[n].fillColor = UIColor.green
                    }
                    if chosennumbers.count == 2 {
                        print("making edge flip")
                        print(chosennumbers)
                        let copyofchosennumbers: [Int] = Array(chosennumbers)
                        makeemptymove(myarray: chosennumbers, howLong: 0.5)
                        // chosennumbers = []
                        edgeFlip(myarray: copyofchosennumbers)
                        flipEdge=false
                        moveSize = 3
                    }
                }
                
                if !isMoving && flipCorner && node.name?.hasPrefix("piece") ?? false {
                    let n=Int(node.name!.components(separatedBy: ",")[1])!
                    if !chosennumbers.contains(n) && [0,2,6,8,18,20,24,26].contains(n){
                        chosennumbers.append(n)
                        nodelist[n].fillColor = UIColor.green
                    }
                    if chosennumbers.count == 2 {
                        print("making corner flip")
                        print(chosennumbers)
                        let copyofchosennumbers: [Int] = Array(chosennumbers)
                        makeemptymove(myarray: chosennumbers, howLong: 0.5)
                        // chosennumbers = []
                        cornerFlip(myarray: copyofchosennumbers)
                        flipCorner=false
                        moveSize = 3
                    }
                }
                    
                else if !isMoving && node.name?.hasPrefix("piece") ?? false {
                    let n=Int(node.name!.components(separatedBy: ",")[1])!
                    // print("piece \(n) is clicked")
                    if !numcube && chosennumbers.count < moveSize {
                        if !chosennumbers.contains(n) {
                            chosennumbers.append(n)
                            nodelist[n].fillColor = UIColor.green
                        }
                        if chosennumbers.count == moveSize {
                            // takesarray(myarray: chosennumbers)
                            // print("about to make move")
                            // print(chosennumbers)
                            // print(board.firstIndex(of: chosennumbers[0]))
                            // print(board.firstIndex(of: chosennumbers[1]))
                            // print(board.firstIndex(of: chosennumbers[2]))
                            makemove(myarray: chosennumbers, howLong: 0.5)
                            // makemove(firstnum: chosennumbers[0],secondnum: chosennumbers[1], howLong: 0.5)
                        }
                    }
                    else if numcube && [22,16,14,4,10,12].contains(n) && chosennumbers.count == 0 {
                        let  movenum: Int = [4,10,12,14,16,22,13].firstIndex(of: n) ?? 0
                        let letters: [String] = ["U","B","L","R","F","d"]
                        // print("n==22")
                        var nums: [[Int]] = []
                        nums.append([2,8,6,0,5,7,3,1])
                        nums.append([2,0,18,20,1,9,19,11])
                        nums.append([6,24,18,0,15,21,9,3])
                        nums.append([2,20,26,8,11,23,17,5])
                        nums.append([8,26,24,6,17,25,15,7])
                        nums.append([20,26,24,18,23,25,21,19])
                        makemoves(myarray: [[board[nums[movenum][0]]-1,board[nums[movenum][1]]-1,board[nums[movenum][2]]-1,board[nums[movenum][3]]-1],[board[nums[movenum][4]]-1,board[nums[movenum][5]]-1,board[nums[movenum][6]]-1,board[nums[movenum][7]]-1 ]])
                        rotateLayer(face: doPattern(moves: letters[movenum]))
                        // makemove(myarray: [18,19,20,23,26,25,24,21], howLong: 0.5)
                    }
                    else if numcube && chosennumbers.count < moveSize {
                        if chosennumbers.count==0 && !chosennumbers.contains(n) && (cornerSquares.contains(n+1) || edgeSquares.contains(n+1)) {
                            chosennumbers.append(n)
                            nodelist[n].fillColor = UIColor.green
                            if cornerSquares.contains(n+1) {
                                rotateCorners = true
                            }
                            else {
                                rotateCorners = false
                            }
                        }
                        else if chosennumbers.count<moveSize && !chosennumbers.contains(n) {
                            if (rotateCorners && cornerSquares.contains(n+1)) || (!rotateCorners && edgeSquares.contains(n+1)) {
                                chosennumbers.append(n)
                                nodelist[n].fillColor = UIColor.green
                            }
                        }
                        if chosennumbers.count == moveSize {
                            // takesarray(myarray: chosennumbers)
                            if rotateCorners {
                                doCorners = true
                                let cornerNums: [Int] = [1, 3, 7, 9, 19, 21, 25, 27]
                                print("about to make move")
                                print(board)
                                print(chosennumbers)
                                cycleArray = [cornerNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[0]+1)!)!+1,cornerNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[1]+1)!)!+1,cornerNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[2]+1)!)!+1]
                                print(cornerNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[0]+1)!)!+1)
                                print(cornerNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[1]+1)!)!+1)
                                print(cornerNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[2]+1)!)!+1)
                                
                            }
                            else {
                                doEdges = true
                                // let edgeNums: [Int] = [2,4,6,8,10,12,16,18,20,22,24,26]
                                let edgeNums: [Int] = [2,6,8,4,10,12,18,16,20,24,26,22]
                                cycleArray = [edgeNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[0]+1)!)!+1,edgeNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[1]+1)!)!+1,edgeNums.firstIndex(of: 1+board.firstIndex(of: chosennumbers[2]+1)!)!+1]
                                
                            }
                            print("making move")
                            print(chosennumbers)
                            print(cycleArray)
                            makemove(myarray: chosennumbers, howLong: 0.5)
                            // makemove(firstnum: chosennumbers[0],secondnum: chosennumbers[1], howLong: 0.5)
                        }
                    }
                }
                
                
                
                if nodeName.hasPrefix("button") {
                    let buttonNumber = nodeName.split(separator: ",")[1]
                    print(buttonNumber)
                    faceToRotate = Int(buttonNumber) ?? 0
                    clockwise = false
                    
                }
                else if nodeName.hasPrefix("middleslice") {
                    if hasFlat {
                        syncBoard()
                    }
                    /*                    let conversion: [Int] = [0,3,6,1,4,7,2,5,8,9,12,15,10,13,16,11,14,17,18,21,24,19,22,25,20,23,26]
                     var switched: [Int] = []
                     for i in 0...26 {
                     switched.append(conversion[stateArray[i]])
                     }
                     // print("converted")
                     // print(switched)
                     var switchrows: [Int] = []
                     for i in 0...26 {
                     switchrows.append(switched[conversion[i]])
                     }
                     for i in 0...26 {
                     print(i)
                     print(board[i])
                     print(self.originalPositions[i])
                     self.nodelist[switchrows[i]].position = self.originalPositions[i]
                     print("")
                     
                     }
                     // rotateLayer(face: [13])
                     // print("doing middle slice move")
                     */
                }
                else if nodeName.hasPrefix("middleback") {
                    // rotateLayer(face: [14])
                    // rotateLayer(face: doPattern(moves: "fEFdfeFD", front: 1, top: 6))
                    // print("doing middleback slice move")
                    print("flat")
                    print(board)
                    // print("cube")
                    // print(stateArray)
                    let conversion: [Int] = [0,3,6,1,4,7,2,5,8,9,12,15,10,13,16,11,14,17,18,21,24,19,22,25,20,23,26]
                    var switched: [Int] = []
                    for i in 0...26 {
                        switched.append(conversion[stateArray[i]])
                    }
                    // print("converted")
                    // print(switched)
                    var switchrows: [Int] = []
                    var switchrowsplusone: [Int] = []
                    for i in 0...26 {
                        switchrows.append(switched[conversion[i]])
                        switchrowsplusone.append(switched[conversion[i]]+1)
                    }
                    print("switchrowsplusone")
                    print(switchrowsplusone)
                    if !(switchrowsplusone==board) {
                        print("NOT synced")
                    }
                    else {
                        print("synced")
                    }
                }
                else if !isMoving && nodeName.hasPrefix("solve") && self.solveMoves.count > 0 {
                    // print("solving")
                    // print(solveMoves)
                    // print(solveMoves.reversed())
                    rotateLayer(face: solveMoves.reversed(), pauseTime: 0.0, rotateTime: 0.0)
                    // rotateLayer(face: solveMoves.reversed(), )
                    self.solveMoves = []
                }
                else if !isMoving && nodeName.hasPrefix("pattern") {
                    /* let nums: [Int] = doPattern(moves: "RUrDRurd", front: 1, top: 2)
                     print("pattern has been turned into ")
                     print(nums)
                     isMoving = true
                     rotateLayer(face: nums)
                     isMoving = false
                     */
                    if let view = self.view as! SKView? {
                        if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            
                            // Present the scene
                            view.presentScene(scene)
                        }
                    }
                    
                    /*
                     
                     if let view = self.view as! SKView? {
                     // Load the SKScene from 'GameScene.sks'
                     if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                     // Set the scale mode to scale to fit the window
                     scene.scaleMode = .aspectFill
                     
                     // Present the scene
                     view.presentScene(scene)
                     }
                     */
                }
                else if !isMoving && nodeName.hasPrefix("mix") {
                    var mixArray: [Int] = []
                    mixing = true
                    var mixstring: String = ""
                    let moveletters: [Character] = ["R","F","U","L","B","D","r","f","u","l","b","d"]
                    for i in 0...30 {
                        let move = Int.random(in: 1...12)
                        mixstring.append(moveletters[move-1])
                        mixArray.append(move)
                        if move == 13 {
                            solveMoves.append(14)
                        }
                        else if move == 14 {
                            solveMoves.append(13)
                        }
                        else if move>6 {
                            solveMoves.append(move-6)
                        }
                        else {
                            solveMoves.append(move+6)
                        }
                        
                    }
                    // print("cube before")
                    // print(stateArray)
                    // rotateLayer(face: mixArray, pauseTime: 0.5, rotateTime: self.moveSpeed)
                    print("mixstring is \(mixstring)")
                    print("solvemoves")
                    print(solveMoves)
                    rotateLayer(face: doPattern(moves: mixstring), pauseTime: 0.0, rotateTime: 0.0)
                    // print("cube after")
                    // print(stateArray)
                    // rotateLayer(face: solveMoves.reversed(), )
                    // self.solveMoves = []
                }
                else if nodeName.hasPrefix("gbutton") {
                    let buttonNumber = nodeName.split(separator: ",")[1]
                    // print("custom button \(buttonNumber)")
                    var customButton = Int(buttonNumber) ?? 0
                    if !isMoving && customButton < 13 {
                        if customButton == 7 {
                            customButton = 14
                        }
                        if customButton != 14 {
                            customButton = centerState[customButton]
                        }
                        rotateLayer(face: [customButton], pauseTime: self.pauseSpeed, rotateTime: self.moveSpeed)
                        // print("custom button is \(customButton)")
                        if customButton == 14 {
                            solveMoves.append(13)
                        }
                        else {
                            solveMoves.append(customButton+6)
                        }
                        // rotateCubieStickers(n: 0, d: 0)
                    }
                    else if !isMoving && customButton == 2{
                        moveCamera(d: 5.0)
                    }
                    else if !isMoving && customButton == 3{
                        moveCameraUp(d: 5.0)
                    }
                    else if !isMoving && customButton == 4 {
                        rotateCubie(theCube: testerCube, face: 1)
                    }
                    else if !isMoving && customButton == 5 {
                        rotateCubie(theCube: testerCube, face: 2)
                    }
                    else if !isMoving && customButton == 6 {
                        rotateCubie(theCube: testerCube, face: 3)
                    }
                    
                }
                else if doCorners { // } nodeName.hasPrefix("makepattern") {
                    doCorners = false
                    // let buttonNumber = Int(nodeName.split(separator: ",")[1])
                    // print("makepattern \(buttonNumber!)")
                    // cycleText=cycleText+String(buttonNumber!)
                    //cycleArray.append(buttonNumber!)
                    // cycleArray = [1,2,3]
                    cycleLen = 3
                    // print("cycleText is now \(cycleText)")
                    // var mySprite: SKLabelNode = childNode(withName: "patternText") as! SKLabelNode
                    // mySprite.text = cycleText
                    // cycleLen+=1
                    if cycleLen == 3 {
                        var mapArray: [Int] = []
                        var inTop: Int = 0
                        var inRight: Int = 0
                        var inFront: Int = 0
                        var front: Int = 2
                        var top: Int = 3
                        for i in cycleArray {
                            if [1,2,3,4].contains(i) {
                                inTop = inTop+1
                            }
                            if [3,4,7,8].contains(i) {
                                inFront = inFront+1
                            }
                            if [2,4,6,8].contains(i) {
                                inRight = inRight+1
                            }
                        }
                        if inTop == 1 {
                            front = 2
                            top = 3
                            mapArray = [0,1,2,3,4,5,6,7,8]
                        }
                        else if inTop == 2 {
                            front = 2
                            top = 6
                            mapArray = [0,6,5,8,7,2,1,4,3]
                            // cycleArray[0]=mapArray[cycleArray[0]]
                            // cycleArray[1]=mapArray[cycleArray[1]]
                            // cycleArray[2]=mapArray[cycleArray[2]]
                        }
                        else if inTop == 3 && inFront == 1 {
                            front = 1
                            top = 2
                            mapArray = [0,6,8,2,4,5,7,1,3]
                        }
                        else if inTop == 3 && inFront == 2 {
                            front = 1
                            top = 5
                            mapArray = [0,1,3,5,7,2,4,6,8]
                        }
                        else if inTop == 0 && inFront == 1 {
                            front = 6
                            top = 2
                            mapArray = [0,5,6,1,2,7,8,3,4]
                        }
                        else if inTop == 0 && inFront == 2 {
                            front = 6
                            top = 5
                            mapArray = [0,2,1,6,5,4,3,8,7]
                        }
                        else {
                            print("not one of the cases")
                            print("cycle array was")
                            print(cycleArray)
                        }
                        cycleArray[0]=mapArray[cycleArray[0]]
                        cycleArray[1]=mapArray[cycleArray[1]]
                        cycleArray[2]=mapArray[cycleArray[2]]
                        
                        var shiftedPattern: [Int] = [0,0,0]
                        var lowest: Int = cycleArray.min()!
                        if cycleArray[0] == lowest {
                            shiftedPattern[0]=cycleArray[0]
                            shiftedPattern[1]=cycleArray[1]
                            shiftedPattern[2]=cycleArray[2]
                        }
                        else if cycleArray[1] == lowest {
                            shiftedPattern[0]=cycleArray[1]
                            shiftedPattern[1]=cycleArray[2]
                            shiftedPattern[2]=cycleArray[0]
                        }
                        else {
                            shiftedPattern[0] = cycleArray[2]
                            shiftedPattern[1] = cycleArray[0]
                            shiftedPattern[2] = cycleArray[1]
                        }
                        cycleArray = Array(shiftedPattern)
                        var firstPart: String = ""
                        var secondPart: String = ""
                        var thirdPart: String = "RUr"
                        var fourthPart: String = ""
                        var fifthPart: String = "Rur"
                        var sixthPart: String = ""
                        var seventhPart: String = ""
                        print("doing move \(cycleArray)")
                        // testing for top with 1 and bottom with 2
                        if cycleArray[0] == 4 {
                            firstPart = ""
                            seventhPart = ""
                        }
                        else if cycleArray[0] == 3 {
                            firstPart = "u"
                            seventhPart = "U"
                        }
                        else if cycleArray[0] == 1 {
                            firstPart = "UU"
                            seventhPart = "uu"
                        }
                        else if cycleArray[0] == 2 {
                            firstPart = "U"
                            seventhPart = "u"
                        }
                        if cycleArray.dropFirst() == [8,7] {
                            secondPart = ""
                            fourthPart = "D"
                            sixthPart = "d"
                        }
                        else if cycleArray.dropFirst() == [8,6] {
                            secondPart = ""
                            fourthPart = "d"
                            sixthPart = "D"
                        }
                        else if cycleArray.dropFirst() == [8,5] {
                            secondPart = ""
                            fourthPart = "DD"
                            sixthPart = "dd"
                        }
                        else if cycleArray.dropFirst() == [7,8] {
                            secondPart = "D"
                            fourthPart = "d"
                            sixthPart = ""
                        }
                        else if cycleArray.dropFirst() == [7,6] {
                            secondPart = "D"
                            fourthPart = "DD"
                            sixthPart = "D"
                        }
                        else if cycleArray.dropFirst() == [7,5] {
                            secondPart = "D"
                            fourthPart = "D"
                            sixthPart = "DD"
                        }
                        else if cycleArray.dropFirst() == [5,6] {
                            secondPart = "DD"
                            fourthPart = "D"
                            sixthPart = "D"
                        }
                        else if cycleArray.dropFirst() == [5,7] {
                            secondPart = "DD"
                            fourthPart = "d"
                            sixthPart = "d"
                        }
                        else if cycleArray.dropFirst() == [5,8] {
                            secondPart = "DD"
                            fourthPart = "DD"
                            sixthPart = ""
                        }
                        else if cycleArray.dropFirst() == [6,5] {
                            secondPart = "d"
                            fourthPart = "d"
                            sixthPart = "DD"
                        }
                        else if cycleArray.dropFirst() == [6,7] {
                            secondPart = "d"
                            fourthPart = "DD"
                            sixthPart = "d"
                        }
                        else if cycleArray.dropFirst() == [6,8] {
                            secondPart = "d"
                            fourthPart = "D"
                            sixthPart = ""
                        }
                        else {
                            print("there was a problem, it wasn't one of the 48 types")
                        }
                        print("doing move")
                        let theMove = firstPart+secondPart+thirdPart+fourthPart+fifthPart+sixthPart+seventhPart
                        rotateLayer(face: doPattern(moves: theMove, front: front, top: top ), pauseTime: self.pauseSpeed, rotateTime: self.moveSpeed) // doPattern(moves: theMove))
                        cycleLen = 0
                        cycleText = ""
                        cycleArray = []
                    }
                }
                else if doEdges { // } nodeName.hasPrefix("makeedgepattern") {
                    // let buttonNumber = Int(nodeName.split(separator: ",")[1])
                    // print("makepattern \(buttonNumber!)")
                    // cycleText=cycleText+String(buttonNumber!)
                    // cycleArray.append(buttonNumber!)
                    // print("cycleText is now \(cycleText)")
                    // var mySprite: SKLabelNode = childNode(withName: "patternText") as! SKLabelNode
                    // mySprite.text = cycleText
                    // cycleLen+=1
                    doEdges = false
                    cycleLen = 3
                    if cycleLen == 3 {
                        print("edge move \(cycleText)")
                        var mapArray: [Int] = []
                        var inTop: Int = 0
                        var inFront: Int = 0
                        var inRight: Int = 0
                        var inMiddle: Int = 0
                        var inBottom: Int = 0
                        var front: Int = 2
                        var top: Int = 3
                        var setup: String = ""
                        var setupinv: String = ""
                        var presetup: String = ""
                        var presetupinv: String = ""
                        for i in cycleArray {
                            if [1,2,3,4].contains(i) {
                                inTop = inTop+1
                            }
                            if [5,6,7,8].contains(i) {
                                inMiddle = inMiddle+1
                            }
                            if [9,10,11,12].contains(i) {
                                inBottom = inBottom+1
                            }
                        }
                        if inBottom == 3 {
                            if cycleArray.contains(11) {
                                presetup = "f"
                                presetupinv = "F"
                                cycleArray[cycleArray.firstIndex(of: 11)!]=7
                            }
                            else if cycleArray.contains(10) {
                                presetup = "r"
                                presetupinv = "R"
                                cycleArray[cycleArray.firstIndex(of: 10)!]=6
                            }
                            inBottom = 2
                            inMiddle = 1
                        }
                        if inMiddle == 3 {
                            var emptyspot = 0
                            if !cycleArray.contains(7) {
                                presetup = "f"
                                presetupinv = "F"
                                cycleArray[cycleArray.firstIndex(of: 8)!]=11
                            }
                            else if !cycleArray.contains(8) {
                                presetup = "F"
                                presetupinv = "f"
                                cycleArray[cycleArray.firstIndex(of: 7)!]=11
                            }
                            inMiddle = 2
                            inBottom = 1
                        }
                        if inTop == 3 {
                            if cycleArray.contains(3) {
                                presetup = "R"
                                presetupinv = "r"
                                cycleArray[cycleArray.firstIndex(of: 3)!]=7
                            }
                            else if cycleArray.contains(2) {
                                presetup = "f"
                                presetupinv = "F"
                                cycleArray[cycleArray.firstIndex(of: 2)!]=7
                            }
                            inTop = 2
                            inMiddle = 1
                        }
                        if inBottom == 1 && inTop==1 && inMiddle == 1 {
                            print("in 111")
                            var topPiece: Int = 0
                            var middlePiece: Int = 0
                            var bottomPiece: Int = 0
                            for k in 0...2 {
                                if cycleArray[k]<5 {
                                    topPiece = cycleArray[k]
                                }
                                else if cycleArray[k]<9 {
                                    middlePiece = cycleArray[k]
                                }
                                else {
                                    bottomPiece = cycleArray[k]
                                }
                            }
                            // move top to position 3
                            if topPiece == 1 {
                                presetup = "UU"
                                presetupinv = "uu"
                            }
                            else if topPiece == 2 {
                                presetup = "U"
                                presetupinv = "u"
                            }
                            else if topPiece == 4 {
                                presetup = "u"
                                presetupinv = "U"
                            }
                            else {
                                presetup = ""
                                presetupinv = ""
                            }
                            // print("after top move to 3 presetup is \(presetup)")
                            cycleArray[cycleArray.firstIndex(of: topPiece)!]=3
                            // move bottom to position 11
                            if bottomPiece == 9 {
                                presetup = presetup + "dd"
                                presetupinv = "DD"+presetupinv
                            }
                            else if bottomPiece == 10 {
                                presetup = presetup + "d"
                                presetupinv = "D"+presetupinv
                            }
                            else if bottomPiece == 12 {
                                presetup = presetup + "D"
                                presetupinv = "d"+presetupinv
                            }
                            else {
                                presetup = presetup+""
                                presetupinv = ""+presetupinv
                            }
                            cycleArray[cycleArray.firstIndex(of: bottomPiece)!]=11
                            // move middle to bottom
                            if middlePiece == 5 {
                                presetup += "l"
                                presetupinv = "L"+presetupinv
                                cycleArray[cycleArray.firstIndex(of: middlePiece)!]=12
                            }
                            else if middlePiece == 6 {
                                // print("before adding R presetup was \(presetup)")
                                presetup = presetup + "R"
                                // print("after adding R presetup is \(presetup)")
                                presetupinv = "r"+presetupinv
                                cycleArray[cycleArray.firstIndex(of: middlePiece)!]=10
                            }
                            else if middlePiece == 7 {
                                presetup = presetup + "r"
                                presetupinv = "R"+presetupinv
                                cycleArray[cycleArray.firstIndex(of: middlePiece)!]=10
                            }
                            else {
                                presetup = presetup + "L"
                                presetupinv = "l"+presetupinv
                                cycleArray[cycleArray.firstIndex(of: middlePiece)!]=12
                            }
                            // print("presetup is now \(presetup)")
                            // print("cycle array is now")
                            // print(cycleArray)
                            inBottom=2
                            inTop=1
                        }
                        if inBottom == 2 && inTop == 1 {
                            // need to move the top to the middle without bringing one of the bottoms up
                            var bottoms: [Int] = []
                            var topPiece: Int = 0
                            for k in 0...2 {
                                if cycleArray[k]<5 {
                                    topPiece = cycleArray[k]
                                }
                                else {
                                    bottoms.append(cycleArray[k])
                                }
                            }
                            if topPiece==1 {
                                if !bottoms.contains(9) {
                                    setup = "b"
                                    setupinv = "B"
                                    cycleArray[cycleArray.firstIndex(of: 1)!]=6
                                }
                                else if !bottoms.contains(10) {
                                    setup = "UR"
                                    setupinv = "ru"
                                    cycleArray[cycleArray.firstIndex(of: 1)!]=6
                                }
                                else {
                                    setup = "uL"
                                    setupinv = "lU"
                                    cycleArray[cycleArray.firstIndex(of: 1)!]=8
                                    
                                }
                            }
                            else if topPiece==2 {
                                if !bottoms.contains(10) {
                                    setup = "R"
                                    setupinv = "r"
                                    cycleArray[cycleArray.firstIndex(of: 2)!]=6
                                }
                                else if !bottoms.contains(11) {
                                    setup = "UF"
                                    setupinv = "fu"
                                    cycleArray[cycleArray.firstIndex(of: 2)!]=7
                                }
                                else {
                                    setup = "ub"
                                    setupinv = "BU"
                                    cycleArray[cycleArray.firstIndex(of: 2)!]=6
                                }
                            }
                            else if topPiece==3 {
                                if !bottoms.contains(11) {
                                    setup = "F"
                                    setupinv = "f"
                                    cycleArray[cycleArray.firstIndex(of: 3)!]=7
                                }
                                else if !bottoms.contains(10) {
                                    setup = "uR"
                                    setupinv = "rU"
                                    cycleArray[cycleArray.firstIndex(of: 3)!]=6
                                }
                                else {
                                    setup = "UL"
                                    setupinv = "lu"
                                    cycleArray[cycleArray.firstIndex(of: 3)!]=8
                                    
                                }
                            }
                            else { // top == 4
                                if !bottoms.contains(12) {
                                    setup = "L"
                                    setupinv = "l"
                                    cycleArray[cycleArray.firstIndex(of: 4)!]=8
                                }
                                else if !bottoms.contains(11) {
                                    setup = "uF"
                                    setupinv = "fU"
                                    cycleArray[cycleArray.firstIndex(of: 4)!]=7
                                }
                                else {
                                    setup = "uuR"
                                    setupinv = "rUU"
                                    cycleArray[cycleArray.firstIndex(of: 4)!]=6
                                    
                                }
                            }
                            inMiddle = 1
                            inBottom = 2
                            
                        }
                        if inBottom == 1 && inTop == 2 {
                            // need to move the bottom to the middle without bringing one of the tops down
                            var tops: [Int] = []
                            var bottomPiece: Int = 0
                            for k in 0...2 {
                                if cycleArray[k]>8 {
                                    bottomPiece = cycleArray[k]
                                }
                                else {
                                    tops.append(cycleArray[k])
                                }
                            }
                            if bottomPiece==9 {
                                if !tops.contains(1) {
                                    setup = "L"
                                    setupinv = "l"
                                    cycleArray[cycleArray.firstIndex(of: 9)!]=6
                                }
                                else if !tops.contains(2) {
                                    setup = "uf"
                                    setupinv = "FU"
                                    cycleArray[cycleArray.firstIndex(of: 9)!]=6
                                }
                                else {
                                    setup = "UUr"
                                    setupinv = "Ruu"
                                    cycleArray[cycleArray.firstIndex(of: 9)!]=7
                                    
                                }
                            }
                            else if bottomPiece==10 {
                                if !tops.contains(2) {
                                    setup = "f"
                                    setupinv = "F"
                                    cycleArray[cycleArray.firstIndex(of: 10)!]=6
                                }
                                else if !tops.contains(1) {
                                    setup = "UL"
                                    setupinv = "lu"
                                    cycleArray[cycleArray.firstIndex(of: 10)!]=6
                                }
                                else {
                                    setup = "ur"
                                    setupinv = "RU"
                                    cycleArray[cycleArray.firstIndex(of: 10)!]=7
                                }
                            }
                            else if bottomPiece==11 {
                                if !tops.contains(3) {
                                    setup = "r"
                                    setupinv = "R"
                                    cycleArray[cycleArray.firstIndex(of: 11)!]=7
                                }
                                else if !tops.contains(2) {
                                    setup = "Uf"
                                    setupinv = "Fu"
                                    cycleArray[cycleArray.firstIndex(of: 11)!]=6
                                }
                                else {
                                    setup = "ub"
                                    setupinv = "BU"
                                    cycleArray[cycleArray.firstIndex(of: 11)!]=8
                                    
                                }
                            }
                            else { //  bottomPiece == 12
                                if !tops.contains(4) {
                                    setup = "b"
                                    setupinv = "B"
                                    cycleArray[cycleArray.firstIndex(of: 12)!]=8
                                }
                                else if !tops.contains(3) {
                                    setup = "Ur"
                                    setupinv = "Ru"
                                    cycleArray[cycleArray.firstIndex(of: 12)!]=7
                                }
                                else {
                                    setup = "uL"
                                    setupinv = "lU"
                                    cycleArray[cycleArray.firstIndex(of: 12)!]=6
                                    
                                }
                            }
                            inMiddle = 1
                            inTop = 2
                            
                        }
                        if inMiddle==2 && inBottom==1 {
                            // need to do a setup and then convert to
                            // inMiddle==1 && inBottom==2
                            var middles: [Int] = []
                            var bottomPiece: Int = 0
                            for k in 0...2 {
                                if cycleArray[k]>8 {
                                    bottomPiece = cycleArray[k]
                                }
                                else {
                                    middles.append(cycleArray[k])
                                }
                            }
                            if middles.contains(8) {
                                if bottomPiece==11 {
                                    setup = "L"
                                    setupinv = "l"
                                    cycleArray[cycleArray.firstIndex(of: 8)!]=12
                                }
                                else {
                                    setup = "f"
                                    setupinv = "F"
                                    cycleArray[cycleArray.firstIndex(of: 8)!]=11
                                }
                            }
                            else if middles.contains(7) {
                                if bottomPiece==11 {
                                    setup = "r"
                                    setupinv = "R"
                                    cycleArray[cycleArray.firstIndex(of: 7)!]=10
                                }
                                else {
                                    setup = "F"
                                    setupinv = "f"
                                    cycleArray[cycleArray.firstIndex(of: 7)!]=11
                                }
                            }
                            else if middles.contains(6) {
                                if bottomPiece==10 {
                                    setup = "b"
                                    setupinv = "B"
                                    cycleArray[cycleArray.firstIndex(of: 6)!]=9
                                }
                                else {
                                    setup = "R"
                                    setupinv = "r"
                                    cycleArray[cycleArray.firstIndex(of: 6)!]=10
                                }
                            }
                            inMiddle=1
                            inBottom=2
                        }
                        if inMiddle==2 && inTop==1 {
                            // need to do a setup and then convert to
                            // inMiddle==1 && inBottom==2
                            var middles: [Int] = []
                            var topPiece: Int = 0
                            for k in 0...2 {
                                if cycleArray[k]<5 {
                                    topPiece = cycleArray[k]
                                }
                                else {
                                    middles.append(cycleArray[k])
                                }
                            }
                            if middles.contains(5) && middles.contains(6) {
                                // print("in 5 6 edge situation")
                                // print("topPiece \(topPiece)")
                                if topPiece==2 {
                                    setup = "B"
                                    setupinv = "b"
                                    cycleArray[cycleArray.firstIndex(of: 5)!]=4
                                }
                                else {
                                    setup = "f"
                                    setupinv = "F"
                                    cycleArray[cycleArray.firstIndex(of: 6)!]=2
                                }
                            }
                            if middles.contains(5) && middles.contains(7) {
                                // print("in 5 7 edge situation")
                                // print("topPiece \(topPiece)")
                                if topPiece==2 {
                                    setup = "r"
                                    setupinv = "R"
                                    cycleArray[cycleArray.firstIndex(of: 7)!]=3
                                }
                                else {
                                    setup = "F"
                                    setupinv = "f"
                                    cycleArray[cycleArray.firstIndex(of: 7)!]=2
                                }
                            }
                            if middles.contains(5) && middles.contains(8) {
                                // print("in 5 8 edge situation")
                                // print("topPiece \(topPiece)")
                                if topPiece==3 {
                                    setup = "l"
                                    setupinv = "L"
                                    cycleArray[cycleArray.firstIndex(of: 5)!]=1
                                }
                                else {
                                    setup = "R"
                                    setupinv = "r"
                                    cycleArray[cycleArray.firstIndex(of: 8)!]=3
                                }
                            }
                            // need to do other 3 cases
                            if middles.contains(6) && middles.contains(7) {
                                // print("in 5 8 edge situation")
                                // print("topPiece \(topPiece)")
                                if topPiece==3 {
                                    setup = "L"
                                    setupinv = "l"
                                    cycleArray[cycleArray.firstIndex(of: 6)!]=1
                                }
                                else {
                                    setup = "r"
                                    setupinv = "R"
                                    cycleArray[cycleArray.firstIndex(of: 7)!]=3
                                }
                            }
                            // need to do other 2 cases
                            if middles.contains(6) && middles.contains(8) {
                                // print("in 5 8 edge situation")
                                // print("topPiece \(topPiece)")
                                if topPiece==2 {
                                    setup = "R"
                                    setupinv = "r"
                                    cycleArray[cycleArray.firstIndex(of: 8)!]=3
                                }
                                else {
                                    setup = "f"
                                    setupinv = "F"
                                    cycleArray[cycleArray.firstIndex(of: 6)!]=2
                                }
                            }
                            // need to do other 1 case
                            if middles.contains(7) && middles.contains(8) {
                                // print("in 5 8 edge situation")
                                // print("topPiece \(topPiece)")
                                if topPiece==2 {
                                    setup = "b"
                                    setupinv = "B"
                                    cycleArray[cycleArray.firstIndex(of: 8)!]=3
                                }
                                else {
                                    setup = "F"
                                    setupinv = "f"
                                    cycleArray[cycleArray.firstIndex(of: 7)!]=2
                                }
                            }
                            /*                            else if middles.contains(8) {
                             if topPiece==4 {
                             setup = "R"
                             setupinv = "r"
                             cycleArray[cycleArray.firstIndex(of: 8)!]=3
                             }
                             else {
                             setup = "b"
                             setupinv = "B"
                             cycleArray[cycleArray.firstIndex(of: 8)!]=4
                             }
                             }
                             else if middles.contains(7) {
                             if topPiece==3 {
                             setup = "F"
                             setupinv = "f"
                             cycleArray[cycleArray.firstIndex(of: 7)!]=2
                             }
                             else {
                             setup = "r"
                             setupinv = "R"
                             cycleArray[cycleArray.firstIndex(of: 7)!]=3
                             }
                             }
                             else if middles.contains(6) {
                             if topPiece==2 {
                             setup = "L"
                             setupinv = "l"
                             cycleArray[cycleArray.firstIndex(of: 6)!]=1
                             }
                             else {
                             setup = "f"
                             setupinv = "F"
                             cycleArray[cycleArray.firstIndex(of: 6)!]=2
                             }
                             } */
                            inMiddle=1
                            inTop=2
                        }
                        // these are not elses since they will get run after the setup has changed to one of these cases
                        if inMiddle==1 && inBottom==2 {
                            front = 2
                            top = 3
                            mapArray = [0,1,2,3,4,5,6,7,8,9,10,11,12]
                        }
                        else if inMiddle == 1 && inTop == 2 {
                            front = 1
                            top = 6
                            mapArray = [0,12,11,10,9,5,8,7,6,4,3,2,1]
                        }
                        else if inTop == 2 {
                            front = 2
                            top = 6
                            mapArray = [0,6,5,8,7,2,1,4,3]
                            // cycleArray[0]=mapArray[cycleArray[0]]
                            // cycleArray[1]=mapArray[cycleArray[1]]
                            // cycleArray[2]=mapArray[cycleArray[2]]
                        }
                        else if inTop == 3 && inFront == 1 {
                            front = 1
                            top = 2
                            mapArray = [0,6,8,2,4,5,7,1,3]
                        }
                        else if inTop == 3 && inFront == 2 {
                            front = 1
                            top = 5
                            mapArray = [0,1,3,5,7,2,4,6,8]
                        }
                        else if inTop == 0 && inFront == 1 {
                            front = 6
                            top = 2
                            mapArray = [0,5,6,1,2,7,8,3,4]
                        }
                        else if inTop == 0 && inFront == 2 {
                            front = 6
                            top = 5
                            mapArray = [0,1,3,5,7,2,4,6,8]
                        }
                        else {
                            print("not one of the cases")
                            print("cycle array was")
                            print(cycleArray)
                            mapArray = [0,1,2,3,4,5,6,7,8,9,10,11,12]
                        }
                        cycleArray[0]=mapArray[cycleArray[0]]
                        cycleArray[1]=mapArray[cycleArray[1]]
                        cycleArray[2]=mapArray[cycleArray[2]]
                        
                        var shiftedPattern: [Int] = [0,0,0]
                        var lowest: Int = cycleArray.min()!
                        if cycleArray[0] == lowest {
                            shiftedPattern[0]=cycleArray[0]
                            shiftedPattern[1]=cycleArray[1]
                            shiftedPattern[2]=cycleArray[2]
                        }
                        else if cycleArray[1] == lowest {
                            shiftedPattern[0]=cycleArray[1]
                            shiftedPattern[1]=cycleArray[2]
                            shiftedPattern[2]=cycleArray[0]
                        }
                        else {
                            shiftedPattern[0] = cycleArray[2]
                            shiftedPattern[1] = cycleArray[0]
                            shiftedPattern[2] = cycleArray[1]
                        }
                        cycleArray = Array(shiftedPattern)
                        var firstPart: String = ""
                        var secondPart: String = ""
                        var thirdPart: String = "fEF"
                        var fourthPart: String = ""
                        var fifthPart: String = "feF"
                        var sixthPart: String = ""
                        var seventhPart: String = ""
                        print("doing move \(cycleArray)")
                        // testing for top with 1 and bottom with 2
                        if cycleArray[0] == 6 {
                            firstPart = ""
                            seventhPart = ""
                        }
                        else if cycleArray[0] == 5 {
                            firstPart = "E"
                            seventhPart = "e"
                        }
                        else if cycleArray[0] == 7 {
                            firstPart = "e"
                            seventhPart = "E"
                        }
                        else if cycleArray[0] == 8 {
                            firstPart = "EE"
                            seventhPart = "ee"
                        }
                        if cycleArray.dropFirst() == [11,10] {
                            secondPart = ""
                            fourthPart = "d"
                            sixthPart = "D"
                        }
                        else if cycleArray.dropFirst() == [11,9] {
                            secondPart = ""
                            fourthPart = "DD"
                            sixthPart = "dd"
                        }
                        else if cycleArray.dropFirst() == [11,12] {
                            secondPart = ""
                            fourthPart = "D"
                            sixthPart = "d"
                        }
                        else if cycleArray.dropFirst() == [10,9] {
                            secondPart = "d"
                            fourthPart = "d"
                            sixthPart = "DD"
                        }
                        else if cycleArray.dropFirst() == [10,11] {
                            secondPart = "d"
                            fourthPart = "D"
                            sixthPart = ""
                        }
                        else if cycleArray.dropFirst() == [10,12] {
                            secondPart = "d"
                            fourthPart = "DD"
                            sixthPart = "d"
                        }
                        else if cycleArray.dropFirst() == [9,10] {
                            secondPart = "DD"
                            fourthPart = "D"
                            sixthPart = "D"
                        }
                        else if cycleArray.dropFirst() == [9,11] {
                            secondPart = "DD"
                            fourthPart = "DD"
                            sixthPart = ""
                        }
                        else if cycleArray.dropFirst() == [9,12] {
                            secondPart = "DD"
                            fourthPart = "d"
                            sixthPart = "d"
                        }
                        else if cycleArray.dropFirst() == [12,9] {
                            secondPart = "D"
                            fourthPart = "D"
                            sixthPart = "DD"
                        }
                        else if cycleArray.dropFirst() == [12,10] {
                            secondPart = "D"
                            fourthPart = "DD"
                            sixthPart = "D"
                        }
                        else if cycleArray.dropFirst() == [12,11] {
                            secondPart = "D"
                            fourthPart = "d"
                            sixthPart = ""
                        }
                        else {
                            print("there was a problem, it wasn't one of the 48 types")
                        }
                        print("doing move")
                        var theMove = presetup+setup+firstPart+secondPart+thirdPart+fourthPart+fifthPart+sixthPart+seventhPart+setupinv+presetupinv
                        print("the entire move will be \(theMove)")
                        /* if cycleArray == [8,11,10] {
                         theMove = "fEFdfeFD"
                         }
                         else {
                         theMove = "fF"
                         }
                         */
                        rotateLayer(face: doPattern(moves: theMove, front: front, top: top ), pauseTime: self.pauseSpeed, rotateTime: self.moveSpeed) // doPattern(moves: theMove))
                        cycleLen = 0
                        cycleText = ""
                        cycleArray = []
                    }
                }
                    
                else if nodeName.hasPrefix("pbutton") {
                    let buttonNumber = Int(nodeName.split(separator: ",")[1])
                    print("purple \(buttonNumber)")
                    if buttonNumber == 1 {
                        moveCamera(d: 1.0)
                    }
                    else if buttonNumber == 2 {
                        moveCamera(d: -1.0)
                    }
                    else if buttonNumber == 3 {
                        moveCameraUp(d: 1.0)
                    }
                    else if buttonNumber == 4 {
                        moveCameraUp(d: -1.0)
                    }
                    else if buttonNumber == 5 {
                        moveCameraOver(d: 1.0)
                    }
                    else if buttonNumber == 6 {
                        moveCameraOver(d: -1.0)
                    }
                    let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
                    let posPoint = my3d.pointOfView?.position
                    let posRot = my3d.pointOfView?.rotation
                    self.cameraText1.text = "\(posPoint!.x) \(posPoint!.y) \(posPoint!.z) \(posRot!.x) \(posRot!.y) \(posRot!.z) \(round(100*posRot!.w)/100)"
                    // cameraText1.text = String(my3d.pointOfView!.position.x)
                    // cameraText1.text = "changed"
                }
                else if nodeName.hasPrefix("cbutton") {
                    let buttonNumber = Int(nodeName.split(separator: ",")[1])
                    print("blue \(buttonNumber)")
                    if buttonNumber == 1 {
                        print("")
                        changeCamera(d: 1.0, m: 0)
                    }
                    else if buttonNumber == 2 {
                        changeCamera(d: -1.0, m: 0)
                        print("")
                    }
                    else if buttonNumber == 3 {
                        changeCamera(d: 1.0, m: 1)
                    }
                    else if buttonNumber == 4 {
                        changeCamera(d: -1.0, m: 1)
                    }
                    else if buttonNumber == 5 {
                        changeCamera(d: 1.0, m: 2)
                    }
                    else if buttonNumber == 6 {
                        changeCamera(d: -1.0, m: 2)
                    }
                    else if buttonNumber == 7 {
                        changeCamera(d: 0.05, m: 3)
                    }
                    else if buttonNumber == 8 {
                        changeCamera(d: -0.05, m: 3)
                    }
                    let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
                    let posPoint = my3d.pointOfView?.position
                    let posRot = my3d.pointOfView?.rotation
                    self.cameraText1.text = "\(posPoint!.x) \(posPoint!.y) \(posPoint!.z) \(posRot!.x) \(posRot!.y) \(posRot!.z) \(round(100*posRot!.w)/100)"
                    
                    
                    
                    
                }
            }
        }
        
        
        
        let gname = "cubeG"
        let nname = "cubeN"
        // let mynode: SCNTorus = childNode(withName: "torusG") as SCNTorus
        let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        // print(my3d.name)
        
        // my3d.scnScene?.rootNode.addChildNode(ambientLight)
        // let thetorus = my3d.scnScene?.rootNode.childNode(withName: gname, recursively: true) as? SCNTorus
        let thetorus = my3d.scnScene?.rootNode.childNode(withName: nname, recursively: true) as? SCNNode
        let thetorus2 = my3d.scnScene?.rootNode.childNode(withName: "cubesN", recursively: true) as? SCNNode
        // print("my3d.position was \(my3d.position)")
        // my3d.position = CGPoint(x: winPosx, y: winPosy)
        // print("my3d.position is now \(my3d.position)")
        
        // my3d.scnScene = scnScene
        // testing the camera
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        /* if let lookAtTarget = scnScene.rootNode.childNodes.first {
         
         let constraint = SCNLookAtConstraint(target: lookAtTarget)
         cameraNode.constraints = [ constraint ]
         }
         my3d.pointOfView = cameraNode
         my3d.pointOfView?.position = SCNVector3(x: 0, y: 0, z: 20)
         */
        
        
        
        // change color of torus here???
        // print(thetorus?.name)
        let therealtorus = thetorus?.childNode(withName: "torusG", recursively: true) as? SCNTorus
        // print(thetorus?.geometry?.name)
        
        
        thetorus?.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // let action = SCNAction.moveBy(x: 20, y: 20, z: 20, duration: 2.0)
        // thetorus?.runAction(action)
        let rotationAnimation = CABasicAnimation(keyPath: "rotation")
        rotationAnimation.toValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, .pi * 2))
        rotationAnimation.duration = 2
        rotationAnimation.repeatCount = FLT_MAX
        // thetorus?.addAnimation(rotationAnimation, forKey: nil)
        // cameraNode.addAnimation(rotationAnimation, forKey: nil)
        
        // this one looks good
        // thetorus?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1.0, y: 2.0, z: 3.0, duration: 0.5)))
        // print(self.cubieArray[0].position)
        // print(self.cubieArray[0].convertPosition(self.cubieArray[0].position, to: thetorus2))
        thetorus?.runAction(SCNAction.rotate(by: CGFloat(-Float.pi/2*0), around: SCNVector3(0, 1, 0), duration: 0.0), completionHandler: {
            // top face rotation
            if faceToRotate>0 && self.isMoving==false {
                if clockwise == false {
                    if faceToRotate==7 {
                        self.solveMoves.append(14)
                    }
                    else {
                        self.solveMoves.append(faceToRotate)
                    }
                    faceToRotate = faceToRotate + 6
                }
                // self.turnFace2(face: faceToRotate)
                self.rotateLayer(face: [faceToRotate], pauseTime: self.pauseSpeed, rotateTime: self.moveSpeed)
                // self.rotateLayer(face: [faceToRotate]) //, 3, 4, 1])
            }
        })
    }
    
    func initializeStickerArray() {
        stickersArray.append([2,3,4])
        stickersArray.append([3,4])
        stickersArray.append([0,3,4])
        stickersArray.append([2,4])
        stickersArray.append([4])
        stickersArray.append([0,4])
        stickersArray.append([1,2,4])
        stickersArray.append([1,4])
        stickersArray.append([0,1,4])
        stickersArray.append([3,2])
        stickersArray.append([3])
        stickersArray.append([3,0])
        stickersArray.append([2])
        stickersArray.append([])
        stickersArray.append([0])
        stickersArray.append([2,1])
        stickersArray.append([1])
        stickersArray.append([0,1])
        stickersArray.append([5,3,2])
        stickersArray.append([5,3])
        stickersArray.append([5,0,3])
        stickersArray.append([2,5])
        stickersArray.append([5])
        stickersArray.append([0,5])
        stickersArray.append([2,1,5])
        stickersArray.append([1,5])
        stickersArray.append([0,1,5])
        convertStickers = [1,4,7,2,5,8,3,6,9,10,13,16,11,14,17,12,15,18,19,22,25,20,23,26,21,24,27]
    }
    
    func turnFace2(face: Int) {
        // print("in turnFace before")
        // print(stateArray)
        var perm: [Int] = []
        var center: Int = 0
        var rot: [Float] = []
        var sign: Int = 1
        // var faceToPivotArray: [Int] = [4, 1, 3, 0, 5, 2]
        // var topPivot: SCNMatrix4 = pivotArray[faceToPivotArray[face-1]]
        if face%6==3 { // this is for U
            perm = [0,2,8,6,1,5,7,3] //,4]
            rot = [0,-1,0]
            center = 4
            
        } // if
        else if face%6 == 1 { // this is for R
            perm = [6,8,26,24,7,17,25,15] //,6]
            center = 16
            rot = [-1,0,0]
        } // else if
            
        else if face%6 == 4 { // this for for L
            perm = [2,0,18,20,1,9,19,11] //,11]
            center = 10
            rot = [1,0,0]
        } // else if
        else if face%6 == 2 { // this for for F
            perm = [8,2,20,26,5,11,23,17] // ,17]
            rot = [0,0,-1]
            center = 14
            sign = 1
        } // else if
        else if face%6 == 0 { // this for for D
            perm = [24,26,20,18,21,25,23,19] //,19]
            rot = [0,1,0]
            center = 22
        } // else if
        else if face%6 == 5 { // this for for B
            perm = [0,6,24,18,3,15,21,9] //,9]
            rot = [0,0,1]
            center = 12
        } // else if
        if face>0 {
            if face>6 && face<=12 {
                // let center: Int = perm[8]
                // var arrayToReverse: [Int] = []
                // arrayToReverse.append(center)
                // arrayToReverse = arrayToReverse + perm.dropLast()
                // var rev: [Int] = Array(perm.dropLast().reversed())
                perm=perm.reversed()
                // let center: Int = perm.first!
                // perm=Array(perm.dropFirst())
                // perm.append(center)
            }
            if face==13 {
                // middle layer move
                perm = [9,11,17,15,10,14,16,12] //,9]
                rot = [0,-1,0]
                center = 13
            }
            if face==14 {
                // middle layer move
                perm = [9,15,17,11,10,12,16,14] //,9]
                rot = [0,1,0]
                center = 13
            }
            // print("this is where the error happened.  perm[0] is ")
            // print("\(perm[0])")
            var temp = self.stateArray[perm[0]]
            self.stateArray[perm[0]]=self.stateArray[perm[1]]
            self.stateArray[perm[1]]=self.stateArray[perm[2]]
            self.stateArray[perm[2]]=self.stateArray[perm[3]]
            self.stateArray[perm[3]]=temp
            temp = self.stateArray[perm[4]]
            self.stateArray[perm[4]]=self.stateArray[perm[5]]
            self.stateArray[perm[5]]=self.stateArray[perm[6]]
            self.stateArray[perm[6]]=self.stateArray[perm[7]]
            self.stateArray[perm[7]]=temp
            // print("after")
            // print(self.stateArray)
            // print("perm is")
            // print(perm)
            // print("face is \(face)")
            for i in perm {
                // put this back in to get the things to 'move' rather than
                // rotate to the spot
                // I'm trying this with rotate again and changing the
                // pivot since everytime I move the cubies, the rotation
                // is off no matter what I do, with rotating or with
                // changing Euler angles
                self.cubieArray[self.stateArray[i]].position = self.originalPosArray[i]
                
                //trying to rotate around another pivot
                // self.cubieArray[self.stateArray[i]].pivot = topPivot
                // self.cubieArray[self.stateArray[i]].rotation = SCNVector4(0,1,0,-Float.pi/2)
                // let currentAngle: Float = //self.cubieArray[self.stateArray[i]].rotation.w
                // let currentAngle: Float = 0
                rotateCubie(theCube: self.cubieArray[self.stateArray[i]], face: face)
            } // if face>0
            rotateCubie(theCube: self.cubieArray[self.stateArray[center]], face: face)
        } // end function
    } // end function
    
    
    func makeColorArray()->[SCNMaterial] {
        // try to color the faces
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor(red: 0, green: 0.6392, blue: 0.0078, alpha: 1.0) /* #00a302 */ // UIImage(named: "g")
        greenMaterial.locksAmbientWithDiffuse = true;
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red // UIImage(named: "r")
        redMaterial.locksAmbientWithDiffuse = true;
        
        
        let blueMaterial  = SCNMaterial()
        blueMaterial.diffuse.contents = UIColor.blue // UIImage(named: "b")
        blueMaterial.locksAmbientWithDiffuse = true;
        
        
        let yellowMaterial = SCNMaterial()
        yellowMaterial.diffuse.contents = UIColor.yellow // UIImage(named: "y")
        yellowMaterial.locksAmbientWithDiffuse = true;
        
        
        let orangeMaterial = SCNMaterial()
        orangeMaterial.diffuse.contents = UIColor(red: 0.8784, green: 0.7098, blue: 0.3922, alpha: 1.0) /* #e0b564 */
        // UIImage(named: "p")
        orangeMaterial.locksAmbientWithDiffuse = true;
        
        
        let WhiteMaterial = SCNMaterial()
        WhiteMaterial.diffuse.contents = UIColor.white //UIImage(named: "w")
        WhiteMaterial.locksAmbientWithDiffuse   = true;
        
        return [greenMaterial,  redMaterial,    blueMaterial,
                orangeMaterial, WhiteMaterial, yellowMaterial]
    }
    
    func makeColors()->[UIColor] {
        // try to color the faces
        var returnColors: [UIColor] = []
        returnColors.append(UIColor.red) // UIImage(named: "r")
        
        returnColors.append(UIColor(red: 0, green: 0.6392, blue: 0.0078, alpha: 1.0)) /* #00a302 */ // UIImage(named: "g")
        returnColors.append(UIColor.white)
        
        returnColors.append(UIColor(red: 0.8784, green: 0.7098, blue: 0.3922, alpha: 1.0) /* #e0b564 */)
        returnColors.append(UIColor.blue)
        
        returnColors.append(UIColor.yellow)
        returnColors.append(UIColor.black)
        return returnColors // [greenMaterial,  redMaterial,    blueMaterial,
        // orangeMaterial, WhiteMaterial, yellowMaterial]
    }
    
    
    func makeTesterCube()->SCNNode {
        // this returns a tester cube with the faces labeled 1 to 6
        let cubeGeometry2 = SCNBox(width: 2*sideLen, height: 2*sideLen, length: 2*sideLen, chamferRadius: 0.5)
        cubeGeometry2.name = "tester"
        cubeGeometry2.materials = makeColorArray()
        let cubeNode2 = SCNNode(geometry: cubeGeometry2)
        cubeNode2.position = SCNVector3(0, 0, 0)
        testerCubeInitialPivot = cubeNode2.pivot
        return cubeNode2
    }
    
    func changeCamera(d: Float, m: Int) {
        let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        if m==0 {
            my3d.pointOfView?.rotation.x = my3d.pointOfView!.rotation.x + d
        }
        else if m==1 {
            my3d.pointOfView?.rotation.y = my3d.pointOfView!.rotation.y + d
        }
        else if m==2 {
            my3d.pointOfView?.rotation.z = my3d.pointOfView!.rotation.z + d
            
        }
        else if m==3 {
            my3d.pointOfView?.rotation.w = my3d.pointOfView!.rotation.w + d
            
        }
        print("rotation vector for camera is")
        print(my3d.pointOfView!.rotation)
    }
    
    func moveCamera(d: CGFloat) {
        let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        my3d.pointOfView!.position.z = my3d.pointOfView!.position.z-Float(d)
        
    }
    func moveCameraUp(d: CGFloat) {
        let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        my3d.pointOfView!.position.y = my3d.pointOfView!.position.y-Float(d)
        // var numArray: [Float] = []
        let posPoint = my3d.pointOfView?.position
        let posRot = my3d.pointOfView?.rotation
        self.cameraText1.text = "\(posPoint!.x) \(posPoint!.y) \(posPoint!.z) \(posRot!.x) \(posRot!.y) \(posRot!.z)"
        
    }
    func moveCameraOver(d: CGFloat) {
        let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        my3d.pointOfView!.position.x = my3d.pointOfView!.position.x-Float(d)
        
    }
    
    func doPattern(moves: String, front: Int = 2, top: Int = 3) -> [Int] {
        // print("in doPattern")
        var toReturn: [Int] = []
        var mapping: [Int] = [1,2,3,4,5,6] // this will change based on the 24 possible orientations ranging from 01 to 54
        // 3 is top face
        if front==2 && top==3 {
            mapping = [1,2,3,4,5,6]
        }
        else if front==1 && top==3 {
            mapping = [5, 1, 3, 2, 4, 6]
        }
        else if front==5 && top==3 {
            mapping = [4, 5, 3, 1, 2, 6]
        }
        else if front==4 && top==3 {
            mapping = [2, 4, 3, 5, 1, 6]
        }
            // 2 is top face
        else if front==1 && top==2 {
            mapping = [3,1,2,6,4,5]
        }
        else if front==3 && top==2 {
            mapping = [4,3,2,1,6,5]
        }
        else if front==4 && top==2 {
            mapping = [6,4,2,3,1,5]
        }
        else if front==6 && top==2 {
            mapping = [1,6,2,4,3,5]
        }
            // 1 is top face
        else if front==2 && top==1 {
            mapping = [6,2,1,3,5,4]
        }
        else if front==3 && top==1 {
            mapping = [2,3,1,5,6,4]
        }
        else if front==5 && top==1 {
            mapping = [3,5,1,6,2,4]
        }
        else if front==6 && top==1 {
            mapping = [5,6,1,2,3,4]
        }
            // 4 is top face
        else if front==2 && top==4 {
            mapping = [3,2,4,6,5,1]
        }
        else if front==3 && top==4 {
            mapping = [5,3,4,2,5,1]
        }
        else if front==5 && top==4 {
            mapping = [6,5,4,3,5,1]
        }
        else if front==6 && top==4 {
            mapping = [2,6,4,5,3,1]
        }
            // 5 is top face
        else if front==6 && top==5 {
            mapping = [4,6,5,1,3,2]
        }
        else if front==4 && top==5 {
            mapping = [3,4,5,6,1,2]
        }
        else if front==3 && top==5 {
            mapping = [1,3,5,4,6,2]
        }
        else if front==1 && top==5 {
            mapping = [6,1,5,3,4,2]
        }
            // 6 is top face
        else if front==1 && top==6 {
            mapping = [2,1,6,5,4,3]
        }
        else if front==2 && top==6 {
            mapping = [4,2,6,1,5,3]
        }
        else if front==4 && top==6 {
            mapping = [5,4,6,2,1,3]
        }
        else if front==5 && top==6 {
            mapping = [1,5,6,4,2,3]
        }
        for i in mapping {
            if i <= 6 {
                mapping.append(i+6)
            }
            else {
                mapping.append(i-6)
            }
        }
        if front==1 && top==6 {
            mapping.append(14)
            mapping.append(13)
        }
        else {
            mapping.append(13)
            mapping.append(14)
        }
        
        let letters: [Character] = ["R","F","U","L","B","D","r","f","u","l","b","d","E","e"]
        let orientNum = 6*(front-1)+(top-1) // this is basically a base 6 number from 00 to 55 ie 0 to 35.  Only 24 of these are valid
        // there will be a 35 element array with 11 blanks and 24 int arrays
        // for mapping R, F, U, L, B, D to 1, 2, 3, 4, 5, 6
        var mappings: [[Int]] = []
        for i in 0...35 {
            
        }
        
        for char in moves {
            // print("\(char)")
            let ind = letters.firstIndex(of: char)
            // print("ind is")
            // print(ind)
            // print(mapping[ind!])
            toReturn.append(mapping[ind!])
            // if char=="R" {
            //     print("found the R")
            // }
            // print("ind is \(ind)")
            // print("move number is \(String(letters[ind]))"
        }
        return toReturn
    }
    
    func rotateLayer(face: [Int], pauseTime: Float=0.5, rotateTime: Float=0.5) {
        // let face = 1
        // print("in rotateLayer with face \(face[0])")
        if face[0] == 14 {
            let temp: Int = centerState[2]
            centerState[2]=centerState[1]
            centerState[1]=centerState[5]
            centerState[5]=centerState[4]
            centerState[4]=temp
        }
        else if face[0] == 13 {
            let temp: Int = centerState[2]
            centerState[2]=centerState[4]
            centerState[4]=centerState[5]
            centerState[5]=centerState[1]
            centerState[1]=temp
        }
        isMoving = true
        let cornerconversion: [Int] = [1,0,7,0,0,0,3,0,9,0,0,0,0,0,0,0,0,0,19,0,25,0,0,0,21,0,27]
        if rotateFlat && [2,8].contains(face[0]) {
            // doing a front move so need to change orientation of the four edge pieces affected by the move
            let edgeconversion: [Int] = [0,4,0,2,0,8,0,6,0,10,0,16,0,0,0,12,0,18,0,22,0,20,0,26,0,24,0]
            let affectededges: [Int] = [edgeconversion[stateArray[5]],edgeconversion[stateArray[11]],edgeconversion[stateArray[17]],edgeconversion[stateArray[23]]]
            for i in affectededges {
                self.nodetextlist[i-1].zRotation += .pi
            }
            let affectedcorners: [Int] = [cornerconversion[stateArray[2]],cornerconversion[stateArray[8]],cornerconversion[stateArray[26]],cornerconversion[stateArray[20]]]
            var cornernum = 0
            var multiplier: CGFloat = 1.0
            if face[0]==8 {
                multiplier = 1.0
            }
            for i in affectedcorners {
                if cornernum%2 == 0 {
                    self.nodetextlist[i-1].zRotation -= .pi*multiplier*2/3
                }
                else {
                    self.nodetextlist[i-1].zRotation += .pi*multiplier*2/3
                }
                cornernum += 1
            }
            
            // print("rotating front face with edges \(affectededges)")
        }
        else if rotateFlat && [5,11].contains(face[0]) {
            // doing a back move so need to change orientation of the four edge pieces affected by the move
            let edgeconversion: [Int] = [0,4,0,2,0,8,0,6,0,10,0,16,0,0,0,12,0,18,0,22,0,20,0,26,0,24,0]
            let affectededges: [Int] = [edgeconversion[stateArray[3]],edgeconversion[stateArray[9]],edgeconversion[stateArray[15]],edgeconversion[stateArray[21]]]
            for i in affectededges {
                self.nodetextlist[i-1].zRotation += .pi
            }
            let affectedcorners: [Int] = [cornerconversion[stateArray[6]],cornerconversion[stateArray[0]],cornerconversion[stateArray[18]],cornerconversion[stateArray[24]]]
            var cornernum = 0
            var multiplier: CGFloat = 1.0
            if face[0]==11 {
                multiplier = 1.0
            }
            for i in affectedcorners {
                if cornernum%2 == 0 {
                    self.nodetextlist[i-1].zRotation -= .pi*multiplier*2/3
                }
                else {
                    self.nodetextlist[i-1].zRotation += .pi*multiplier*2/3
                }
                cornernum += 1
            }
        }
        else if rotateFlat && [13,14].contains(face[0]) {
            // doing a middle slice move so need to change orientation of the four edge pieces affected by the move
            // print("doing middle slice \(face[0])")
            let edgeconversion: [Int] = [0,4,0,2,0,8,0,6,0,10,0,16,0,0,0,12,0,18,0,22,0,20,0,26,0,24,0]
            let affectededges: [Int] = [edgeconversion[stateArray[9]],edgeconversion[stateArray[15]],edgeconversion[stateArray[17]],edgeconversion[stateArray[11]]]
            for i in affectededges {
                self.nodetextlist[i-1].zRotation += .pi
            }
        }
        else if rotateFlat && [1,7].contains(face[0]) {
            // doing a right move so orientation of 4 corners needs to change
            let affectedcorners: [Int] = [cornerconversion[stateArray[8]],cornerconversion[stateArray[6]],cornerconversion[stateArray[24]],cornerconversion[stateArray[26]]]
            var cornernum = 0
            var multiplier: CGFloat = 1.0
            if face[0]==7 {
                multiplier = 1.0
            }
            // print(affectedcorners)
            for i in affectedcorners {
                if cornernum%2 == 0 {
                    self.nodetextlist[i-1].zRotation -= .pi*multiplier*2/3
                }
                else {
                    self.nodetextlist[i-1].zRotation += .pi*multiplier*2/3
                }
                cornernum += 1
            }
        }
        else if rotateFlat && [4,10].contains(face[0]) {
            // doing a left move so orientation of 4 corners needs to change
            let affectedcorners: [Int] = [cornerconversion[stateArray[0]],cornerconversion[stateArray[2]],cornerconversion[stateArray[20]],cornerconversion[stateArray[18]]]
            var cornernum = 0
            var multiplier: CGFloat = 1.0
            if face[0]==10 {
                multiplier = 1.0
            }
            for i in affectedcorners {
                if cornernum%2 == 0 {
                    self.nodetextlist[i-1].zRotation -= .pi*multiplier*2/3
                }
                else {
                    self.nodetextlist[i-1].zRotation += .pi*multiplier*2/3
                }
                cornernum += 1
            }
        }
        var cubesToRotateArray: [[Int]] = []
        cubesToRotateArray.append([6,7,8,15,16,17,24,25,26])
        cubesToRotateArray.append([2,5,8,11,14,17,20,23,26])
        cubesToRotateArray.append([0,1,2,3,4,5,6,7,8])
        cubesToRotateArray.append([0,1,2,9,10,11,18,19,20])
        cubesToRotateArray.append([0,3,6,9,12,15,18,21,24])
        cubesToRotateArray.append([18,19,20,21,22,23,24,25,26])
        //
        cubesToRotateArray.append([6,7,8,15,16,17,24,25,26].reversed())
        cubesToRotateArray.append([2,5,8,11,14,17,20,23,26].reversed())
        cubesToRotateArray.append([0,1,2,3,4,5,6,7,8].reversed())
        cubesToRotateArray.append([0,1,2,9,10,11,18,19,20].reversed())
        cubesToRotateArray.append([0,3,6,9,12,15,18,21,24].reversed())
        cubesToRotateArray.append([18,19,20,21,22,23,24,25,26].reversed())
        // for middle slice
        cubesToRotateArray.append([9,11,17,15,10,14,16,12])
        // for middle back
        cubesToRotateArray.append([9,11,17,15,10,14,16,12].reversed())
        
        var vectorRotateArray: [[Int]] = []
        vectorRotateArray.append([1,0,0])
        vectorRotateArray.append([0,0,1])
        vectorRotateArray.append([0,1,0])
        vectorRotateArray.append([-1,0,0])
        vectorRotateArray.append([0,0,-1])
        vectorRotateArray.append([0,-1,0])
        //
        vectorRotateArray.append([-1,0,0])
        vectorRotateArray.append([0,0,-1])
        vectorRotateArray.append([0,-1,0])
        vectorRotateArray.append([1,0,0])
        vectorRotateArray.append([0,0,1])
        vectorRotateArray.append([0,1,0])
        // for middle slice
        vectorRotateArray.append([0,1,0])
        // for middle back
        vectorRotateArray.append([0,-1,0])
        
        var cubesToRotate = cubesToRotateArray[face[0]-1]
        var vectorToRotate = vectorRotateArray[face[0]-1]
        // rotate top face
        // let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        let gname = "cubeG"
        let nname = "cubeN"
        // let mynode: SCNTorus = childNode(withName: "torusG") as SCNTorus
        let my3d: SK3DNode = childNode(withName: "3d") as! SK3DNode
        // print(my3d.name)
        let thetorus = my3d.scnScene?.rootNode.childNode(withName: nname, recursively: true) as? SCNNode
        let stationaryCube = my3d.scnScene?.rootNode.childNode(withName: "cubesN", recursively: true) as? SCNNode
        let movingCube = my3d.scnScene?.rootNode.childNode(withName: "cubeN", recursively: true) as? SCNNode
        // print(movingCube?.eulerAngles)
        // print("moving cubes euler angles")
        // print("cubesToRotate")
        // print(cubesToRotate)
        for i in cubesToRotate {
            cubieArray[self.stateArray[i]].removeFromParentNode()
            movingCube?.addChildNode(cubieArray[self.stateArray[i]])
        }
        movingCube?.runAction(SCNAction.rotate(by: CGFloat(-Float.pi/2), around: SCNVector3(vectorToRotate[0], vectorToRotate[1], vectorToRotate[2]), duration: TimeInterval(pauseTime)), completionHandler: {
            for i in cubesToRotate {
                // self.cubieArray[self.stateArray[i]].isHidden = true
                self.cubieArray[self.stateArray[i]].removeFromParentNode()
                stationaryCube?.addChildNode(self.cubieArray[self.stateArray[i]])
                
                // self.cubieArray[self.stateArray[i]].isHidden = false
            }
            movingCube?.runAction(SCNAction.rotate(by: CGFloat(+Float.pi/2), around: SCNVector3(vectorToRotate[0], vectorToRotate[1], vectorToRotate[2]), duration: 0.0))
            self.turnFace2(face: face[0])
            
            // top face rotation
            // if faceToRotate>0 {
            // self.turnFace2(face: faceToRotate)
            //}
            if face.count > 1 {
                // print("recursively working")
                movingCube?.runAction(SCNAction.rotate(by: 0, around: SCNVector3(vectorToRotate[0], vectorToRotate[1], vectorToRotate[2]), duration: TimeInterval(rotateTime)), completionHandler: { // self.rotateLayer(face: Array(face.dropFirst()))})
                    self.rotateLayer(face: Array(face.dropFirst()), pauseTime: pauseTime, rotateTime: rotateTime)
                    // self.syncBoard()
                })
                // self.syncBoard()
                
            }
            else {
                // print("last turn in pattern")
                self.isMoving = false
                if self.hasFlat {
                    self.syncBoard()
                }
                self.mixing = false
                // print("statearray is now")
                // print(self.stateArray)
            }
        })
        
        
    }
    
    func rotateCubie(theCube: SCNNode, face: Int) {
        // print("in rotateCubie with face \(face)")
        var rotVec: [Float] = []
        if face==1 { //right face
            rotVec = [1,0,0]
        }
        if face==2 { //front face
            rotVec = [0,0,1]
        }
        if face==3 { //up face
            rotVec = [0,1,0]
        }
        if face==4 { //left face
            rotVec = [-1,0,0]
        }
        if face==5 { //back face
            rotVec = [0,0,-1]
        }
        if face==6 { //down face
            rotVec = [0,-1,0]
        }
        if face==7 { //right face
            rotVec = [-1,0,0]
        }
        if face==8 { //front face
            rotVec = [0,0,-1]
        }
        if face==9 { //up face
            rotVec = [0,-1,0]
        }
        if face==10 { //left face
            rotVec = [1,0,0]
        }
        if face==11 { //back face
            rotVec = [0,0,1]
        }
        if face==12 { //down face
            rotVec = [0,1,0]
        }
        if face==13 { // middle slice
            rotVec = [0, 1, 0]
        }
        if face==14 { // middle slice
            rotVec = [0, -1, 0]
        }
        let oldPosition = theCube.position
        theCube.position = SCNVector3Make(0, 0, 0)
        theCube.transform = SCNMatrix4Mult(theCube.transform, SCNMatrix4MakeRotation(-Float.pi/2, rotVec[0], rotVec[1], rotVec[2]))
        theCube.position = oldPosition
    }
    
    func makeCube() {
        
    }
    func initSquares() {
        let screenSize: CGRect = UIScreen.main.bounds
        var screenWidth = self.size.width //screenSize.width
        var screenHeight = self.size.height // screenSize.height
        print(screenWidth)
        print(screenHeight)
        print("self.size")
        print(self.size.height)
        print(self.size.width)
        // var board: [Int] = []
        var restartboard: [Int] = []
        // var squareColor: UIColor = UIColor.white
        var theSize = min(screenWidth,screenHeight)
        var shuffleStart: Bool = false
        var numShuffle: Int = 10
        var startPosition: [[Int]] = [[1,2]]
        var fifteen: Bool = false
        //var originalPositions: [CGPoint] = []
        //var nodelist: [SKShapeNode] = []
        var frameOffset: Int = -25
        var theMode: Int = 4
        var frameOffsetX: Int = 0
        var puzzleWidth: Int = 3
        var puzzleHeight: Int = 9
        var numcube: Bool = true
        var scalePieces: CGFloat = 0.6
        var framesize: Int = Int(2/3*theSize*scalePieces)
        let myframe = SKShapeNode(rect: CGRect(x: -framesize/2-frameOffsetX, y: -framesize/2-frameOffset, width: framesize, height: framesize))
        myframe.fillColor = UIColor.red
        myframe.zPosition = 3
        myframe.name = "frame"
        self.addChild(myframe)
        print("framesize \(framesize)")
        for i in 0...(puzzleWidth*puzzleHeight-1) {
            // print(i)
            board.append(Int(i+1))
            // print("board so far is")
            // print(board)
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
                gamePiece.fillColor = squareColor
            }
            else {
                gamePiece.fillColor = squareColor
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
            nodetextlist.append(tritext)
            if [1,3,7,9,19,21,25,27].contains(i+1) {
                cornernodetextlist.append(tritext)
            }
            else if [2,4,6,8,10,12,16,18,20,22,24,26].contains(i+1) {
                edgenodetextlist.append(tritext)
            }
            nodelist.append(gamePiece)
            myframe.addChild(gamePiece)
            // tritext.position = CGPoint(x: 0, y: 0)
            
            
        }
        // print(board)
        if shuffleStart {
            // mix(nummoves: numShuffle)
            restartboard = Array(board)
        }
        else {
            print("making start position")
            // makemoves(myarray: startPosition)
        }
        // let testArray = [[1,2,3],[4,5]]
        // print("test array")
        // print(testArray)
        // let newarray = changesarray(myarray: testArray)
        // print(newarray)
        // self.addChild(myframe)
        
    }
    func makemoves(myarray: [[Int]]) {
        // print("rotateFlat is \(rotateFlat)")
        if rotateFlat && false {
            // print("flipping edges")
            print(self.edgenodetextlist)
            if self.edgenodetextlist[1].zRotation == 0 {
                self.edgenodetextlist[1].zRotation = .pi
            }
            else {
                self.edgenodetextlist[1].zRotation = 0
            }
        }
        print("makemove \(myarray)")
        for i in myarray {
            makemove(myarray: i, howLong: 0.0)
        }
    }
    
    func makemove(myarray: [Int], howLong: TimeInterval) {
        
        //func makemove(firstnum: Int, secondnum: Int, howLong: TimeInterval) {
        // print("makemove \(firstnum) \(secondnum) ")
        // print("in makemove")
        // print(myarray)
        var fifteen: Bool = false
        var customHowLong = howLong
        nodelist[0].run(SKAction.fadeAlpha(to: 1, duration: customHowLong), completion: {
            let temppos = self.nodelist[myarray[0]].position
            if !fifteen {
                self.nodelist[myarray[0]].fillColor = self.squareColor
            }
            for j in 0..<myarray.count-1 {
                // print("in makemove j= \(j)")
                if !fifteen {
                    self.nodelist[myarray[j]].fillColor = self.squareColor
                }
                // may need to put this back in
                self.nodelist[myarray[j]].position = self.nodelist[myarray[j+1]].position
            }
            // self.nodelist[myarray[1]].fillColor = UIColor.yellow
            // may need to put this back in
            self.nodelist[myarray[myarray.count-1]].position = temppos
            if !fifteen {
                self.nodelist[myarray[myarray.count-1]].fillColor = self.squareColor
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
        print("flatboard is now")
        // print(board)
        
        // print(board)
        // chosennumbers[0]=0
        // chosennumbers[1]=0
        chosennumbers.removeAll()
        nodesselected = 0
    }
    
    
    func makeemptymove(myarray: [Int], howLong: TimeInterval) {
        
        //func makemove(firstnum: Int, secondnum: Int, howLong: TimeInterval) {
        // print("makemove \(firstnum) \(secondnum) ")
        // print("in makemove")
        // print(myarray)
        var fifteen: Bool = false
        var customHowLong = howLong
        nodelist[0].run(SKAction.fadeAlpha(to: 1, duration: customHowLong), completion: {
            let temppos = self.nodelist[myarray[0]].position
            if !fifteen {
                self.nodelist[myarray[0]].fillColor = self.squareColor
            }
            for j in 0..<myarray.count-1 {
                // print("in makemove j= \(j)")
                if !fifteen {
                    self.nodelist[myarray[j]].fillColor = self.squareColor
                }
            }
            // self.nodelist[myarray[1]].fillColor = UIColor.yellow
            // may need to put this back in
            // self.nodelist[myarray[myarray.count-1]].position = temppos
            if !fifteen {
                self.nodelist[myarray[myarray.count-1]].fillColor = self.squareColor
            }
            
            
        })
        // need to fix this to update board
        // make a new ray with the positions of each of the numbers in the move
        var posarray: [Int] = []
        
        // print("posarray")
        // print(posarray)
        // let tempint = board[posarray[posarray.count-1]]
        
        // board[myarray[1]] = board[myarray[0]]
        // board[posarray[0]] = tempint
        // print("flatboard is now")
        // print(board)
        
        // print(board)
        // chosennumbers[0]=0
        // chosennumbers[1]=0
        chosennumbers.removeAll()
        nodesselected = 0
    }
    func syncBoard() {
        let conversion: [Int] = [0,3,6,1,4,7,2,5,8,9,12,15,10,13,16,11,14,17,18,21,24,19,22,25,20,23,26]
        var switched: [Int] = []
        for i in 0...26 {
            switched.append(conversion[stateArray[i]])
        }
        // print("converted")
        // print(switched)
        var switchrows: [Int] = []
        for i in 0...26 {
            switchrows.append(switched[conversion[i]])
        }
        for i in 0...26 {
            // print(i)
            // print(board[i])
            // print(self.originalPositions[i])
            self.nodelist[switchrows[i]].position = self.originalPositions[i]
            // print("")
            board[i]=switchrows[i]+1
        }
        // rotateLayer(face: [13])
        // print("doing middle slice move")
        
    }
    func isSynced () -> Bool {
        let conversion: [Int] = [0,3,6,1,4,7,2,5,8,9,12,15,10,13,16,11,14,17,18,21,24,19,22,25,20,23,26]
        var switched: [Int] = []
        for i in 0...26 {
            switched.append(conversion[stateArray[i]])
        }
        // print("converted")
        // print(switched)
        var switchrows: [Int] = []
        var switchrowsplusone: [Int] = []
        for i in 0...26 {
            switchrows.append(switched[conversion[i]])
            switchrowsplusone.append(switched[conversion[i]]+1)
        }
        print("switchrowsplusone")
        print(switchrowsplusone)
        if !(switchrowsplusone==board) {
            print("NOT synced")
            return false
        }
        else {
            print("synced")
            return true
        }
    }
    func edgeFlip(myarray: [Int], howLong: TimeInterval=0.25) {
        let edgeNums: [Int] = [2,6,8,4,10,12,18,16,20,24,26,22]
        var positions = [edgeNums.firstIndex(of: 1+board.firstIndex(of: myarray[0]+1)!)!+1,edgeNums.firstIndex(of: 1+board.firstIndex(of: myarray[1]+1)!)!+1]
        print("in positions \(positions)")
        var setup: String = ""
        var setupInv: String = ""
        var presetup: String = ""
        var presetupInv: String = ""
        var inTop: Int = 0
        var inMiddle: Int = 0
        var inBottom: Int = 0
        for i in positions {
            if [1,2,3,4].contains(i) {
                inTop+=1
            }
            else if [5,6,7,8].contains(i) {
                inMiddle+=1
            }
            else {
                inBottom+=1
            }
        }
        
        if inBottom == 2 {
            if positions.contains(9) {
                setup += "BB"
                setupInv = "bb"+setupInv
                positions[positions.firstIndex(of: 9)!]=1
            }
            if positions.contains(10) {
                setup += "RR"
                setupInv = "rr"+setupInv
                positions[positions.firstIndex(of: 10)!]=2
            }
            if positions.contains(11) {
                setup += "ff"
                setupInv = "FF"+setupInv
                positions[positions.firstIndex(of: 11)!]=3
            }
            if positions.contains(12) {
                setup += "ll"
                setupInv = "LL"+setupInv
                positions[positions.firstIndex(of: 12)!]=4
            }
            inBottom = 0
            inTop = 2
        }
        
        if inTop == 1 && inBottom == 1 {
            var bottomNum = 0
            var topNum = 0
            if [1,2,3,4].contains(positions[0]) {
                topNum = positions[0]
                bottomNum = positions[1]
            }
            else {
                topNum = positions[1]
                bottomNum = positions[0]
            }
            if bottomNum == 9 {
                if !(topNum==1) {
                    setup = "BB"
                    setupInv = "bb"
                    positions[positions.firstIndex(of: 9)!]=1
                }
                else {
                    setup = "ddff"
                    setupInv = "FFDD"
                    positions[positions.firstIndex(of: 9)!]=3
                }
            }
            if bottomNum == 10 {
                if !(topNum==2) {
                    setup = "RR"
                    setupInv = "rr"
                    positions[positions.firstIndex(of: 10)!]=2
                }
                else {
                    setup = "dff"
                    setupInv = "FFD"
                    positions[positions.firstIndex(of: 10)!]=3
                }
            }
            if bottomNum == 11 {
                if !(topNum==3) {
                    setup = "ff"
                    setupInv = "FF"
                    positions[positions.firstIndex(of: 11)!]=3
                }
                else {
                    setup = "DRR"
                    setupInv = "rrd"
                    positions[positions.firstIndex(of: 11)!]=2
                }
            }
            if bottomNum == 12 {
                if !(topNum==4) {
                    setup = "ll"
                    setupInv = "LL"
                    positions[positions.firstIndex(of: 12)!]=4
                }
                else {
                    setup = "DFF"
                    setupInv = "ffd"
                    positions[positions.firstIndex(of: 12)!]=3
                }
            }
            inBottom = 0
            inTop = 2
        }
        if inBottom == 1 && inMiddle == 1 {
            var bottomNum = 0
            var middleNum = 0
            if [9,10,11,12].contains(positions[0]) {
                bottomNum = positions[0]
                middleNum = positions[1]
            }
            else {
                bottomNum = positions[1]
                middleNum = positions[0]
            }
            // move bottom to top and do the top1 middle1
            if bottomNum == 9 {
                if [7,8].contains(middleNum) {
                    presetup = "BB"
                    presetupInv = "bb"
                    positions[positions.firstIndex(of: 9)!]=1
                }
                else {
                    presetup = "ddFF"
                    presetupInv = "ffDD"
                    positions[positions.firstIndex(of: 9)!]=3
                }
            }
            else if bottomNum == 10 {
                if [5,8].contains(middleNum) {
                    presetup = "RR"
                    presetupInv = "rr"
                    positions[positions.firstIndex(of: 10)!]=2
                }
                else {
                    presetup = "ddll"
                    presetupInv = "LLDD"
                    positions[positions.firstIndex(of: 10)!]=4
                }
            }
            if bottomNum == 11 {
                if [5,6].contains(middleNum) {
                    presetup = "FF"
                    presetupInv = "ff"
                    positions[positions.firstIndex(of: 11)!]=3
                }
                else {
                    presetup = "ddbb"
                    presetupInv = "BBDD"
                    positions[positions.firstIndex(of: 11)!]=1
                }
            }
            if bottomNum == 12 {
                if [6,7].contains(middleNum) {
                    presetup = "ll"
                    presetupInv = "LL"
                    positions[positions.firstIndex(of: 12)!]=4
                }
                else {
                    presetup = "ddRR"
                    presetupInv = "rrDD"
                    positions[positions.firstIndex(of: 12)!]=2
                }
            }
            inTop = 1
            inMiddle = 1
        }
        
        if inMiddle == 2 {
            if positions.contains(5) {
                if positions.contains(6) {
                    presetup = "L"
                    presetupInv = "l"
                    positions[positions.firstIndex(of: 5)!]=3
                }
                else {
                    presetup = "b"
                    presetupInv = "B"
                    positions[positions.firstIndex(of: 5)!]=1
                }
            }
            else if positions.contains(6) {
                if positions.contains(7) {
                    presetup = "B"
                    presetupInv = "b"
                    positions[positions.firstIndex(of: 6)!]=1
                }
                else {
                    presetup = "r"
                    presetupInv = "R"
                    positions[positions.firstIndex(of: 6)!]=2
                }
            }
            else if positions.contains(7) {
                if positions.contains(6) {
                    presetup = "f"
                    presetupInv = "F"
                    positions[positions.firstIndex(of: 7)!]=3
                }
                else {
                    presetup = "R"
                    presetupInv = "r"
                    positions[positions.firstIndex(of: 7)!]=2
                }
            }
            inTop = 1
            inMiddle = 1
        }
        
        if inTop == 1 && inMiddle == 1 {
            var topNum = 0
            var middleNum = 0
            if [1,2,3,4].contains(positions[0]) {
                topNum = positions[0]
                middleNum = positions[1]
            }
            else {
                topNum = positions[1]
                middleNum = positions[0]
            }
            if middleNum == 5 {
                if !(topNum==1) {
                    setup = "b"
                    setupInv = "B"
                    positions[positions.firstIndex(of: 5)!]=1
                }
                else {
                    setup = "L"
                    setupInv = "l"
                    positions[positions.firstIndex(of: 5)!]=4
                    
                }
            }
            if middleNum == 6 {
                if !(topNum==1) {
                    setup = "B"
                    setupInv = "b"
                    positions[positions.firstIndex(of: 6)!]=1
                }
                else {
                    setup = "r"
                    setupInv = "R"
                    positions[positions.firstIndex(of: 6)!]=2
                    
                }
            }
            if middleNum == 7 {
                if !(topNum==3) {
                    setup = "f"
                    setupInv = "F"
                    positions[positions.firstIndex(of: 7)!]=3
                }
                else {
                    setup = "r"
                    setupInv = "R"
                    positions[positions.firstIndex(of: 7)!]=2
                    
                }
            }
            if middleNum == 8 {
                if !(topNum==3) {
                    setup = "F"
                    setupInv = "f"
                    positions[positions.firstIndex(of: 8)!]=3
                }
                else {
                    setup = "l"
                    setupInv = "L"
                    positions[positions.firstIndex(of: 8)!]=4
                    
                }
            }
            inTop = 2
            inMiddle = 0
        }
        
        if inTop == 2 {
            var zeroPart: String = ""
            var secondPart: String = ""
            var fourthPart: String = ""
            var fifthPart: String = ""
            if positions[0]==3 {
                zeroPart = ""
                if positions[1] == 1 {
                    secondPart = "UU"
                    fourthPart = "uu"
                }
                if positions[1] == 2 {
                    secondPart = "U"
                    fourthPart = "u"
                }
                if positions[1] == 4 {
                    secondPart = "u"
                    fourthPart = "U"
                }
            }
            else if positions[0]==2 {
                zeroPart = "U"
                fifthPart = "u"
                if positions[1] == 1 {
                    secondPart = "U"
                    fourthPart = "u"
                }
                if positions[1] == 3 {
                    secondPart = "u"
                    fourthPart = "U"
                }
                if positions[1] == 4 {
                    secondPart = "UU"
                    fourthPart = "uu"
                }
            }
            else if positions[0]==1 {
                zeroPart = "UU"
                fifthPart = "uu"
                if positions[1] == 2 {
                    secondPart = "u"
                    fourthPart = "U"
                }
                if positions[1] == 3 {
                    secondPart = "UU"
                    fourthPart = "uu"
                }
                if positions[1] == 4 {
                    secondPart = "U"
                    fourthPart = "u"
                }
            }
            else if positions[0]==4 {
                zeroPart = "u"
                fifthPart = "U"
                if positions[1] == 1 {
                    secondPart = "u"
                    fourthPart = "U"
                }
                if positions[1] == 2 {
                    secondPart = "UU"
                    fourthPart = "uu"
                }
                if positions[1] == 3 {
                    secondPart = "U"
                    fourthPart = "u"
                }
            }
            let firstPart: String = "FUdllUUddRU"
            // secondPart = "U"
            let thirdPart: String = "urDDuuLLDuf"
            // fourthPart = "u"
            let pattern: String = presetup+setup+zeroPart+firstPart+secondPart+thirdPart+fourthPart+fifthPart+setupInv+presetupInv
            flipButtonList[0].fillColor = UIColor.blue
            rotateLayer(face: doPattern(moves: pattern), pauseTime: 0.25, rotateTime: 0.25)
        }
    }
    
    func cornerFlip(myarray: [Int], howLong: TimeInterval=0.25) {
        let cornerNums: [Int] = [1,3,7,9,19,21,25,27]
        var positions = [cornerNums.firstIndex(of: 1+board.firstIndex(of: myarray[0]+1)!)!+1,cornerNums.firstIndex(of: 1+board.firstIndex(of: myarray[1]+1)!)!+1]
        print("in positions \(positions)")
        var setup: String = ""
        var setupInv: String = ""
        var presetup: String = ""
        var presetupInv: String = ""
        var inTop: Int = 0
        var inBottom: Int = 0
        var zeroPart: String = ""
        var ninthPart: String = ""
        var firstPart: String = ""
        var secondPart: String = ""
        var thirdPart: String = ""
        var fourthPart: String = ""
        var fifthPart: String = ""
        var sixthPart: String = ""
        var seventhPart: String = ""
        var eighthPart: String = ""
        for i in positions {
            if [1,2,3,4].contains(i) {
                inTop+=1
            }
            else if [5,6,7,8].contains(i) {
                inBottom+=1
            }
        }
        if inTop == 0 {
            if positions.contains(5) {
                if positions.contains(6) || positions.contains(8) {
                    zeroPart = "L"
                    ninthPart = "l"
                }
                else {
                    zeroPart = "b"
                    ninthPart = "B"
                }
                positions[positions.firstIndex(of: 5)!]=1
                // if positions.contains(7) {
                // positions[positions.firstIndex(of: 7)!]=5
                // }
            }
            else if positions.contains(6) {
                if positions.contains(5) || positions.contains(7) {
                    zeroPart = "r"
                    ninthPart = "R"
                }
                else {
                    zeroPart = "B"
                    ninthPart = "b"
                }
                positions[positions.firstIndex(of: 6)!]=2
            }
            else if positions.contains(7) {
                if positions.contains(6) || positions.contains(8) {
                    zeroPart = "l"
                    ninthPart = "L"
                }
                else {
                    zeroPart = "F"
                    ninthPart = "f"
                }
                positions[positions.firstIndex(of: 7)!]=3
            }
            else if positions.contains(8) {
                if positions.contains(5) || positions.contains(7) {
                    zeroPart = "R"
                    ninthPart = "r"
                }
                else {
                    zeroPart = "f"
                    ninthPart = "F"
                }
                positions[positions.firstIndex(of: 8)!]=4
            }
            inTop = 1
            inBottom = 1
        }
        if inTop == 1 {
            var topNumber: Int = 0
            var bottomNumber: Int = 0
            if [1,2,3,4].contains(positions[0]) {
                topNumber = positions[0]
                bottomNumber = positions[1]
            }
            else {
                topNumber = positions[1]
                bottomNumber = positions[0]
            }
            if bottomNumber == 5 {
                if [1,3,4].contains(topNumber) {
                    firstPart = "b"
                    eighthPart = "B"
                    positions[positions.firstIndex(of: 5)!]=1
                    if topNumber == 1 {
                        positions[positions.firstIndex(of: 1)!]=2
                    }
                }
                else if topNumber == 2 {
                    firstPart = "L"
                    eighthPart = "l"
                    positions[positions.firstIndex(of: 5)!]=1
                }
            }
            if bottomNumber == 6 {
                if [1,2,3].contains(topNumber) {
                    firstPart = "r"
                    eighthPart = "R"
                    positions[positions.firstIndex(of: 6)!]=2
                    if topNumber == 2 {
                        positions[positions.firstIndex(of: 2)!]=4
                    }
                }
                else if topNumber == 4 {
                    firstPart = "B"
                    eighthPart = "b"
                    positions[positions.firstIndex(of: 6)!]=2
                }
            }
            if bottomNumber == 7 {
                if [2,3,4].contains(topNumber) {
                    firstPart = "l"
                    eighthPart = "L"
                    positions[positions.firstIndex(of: 7)!]=3
                    if topNumber == 3 {
                        positions[positions.firstIndex(of: 3)!]=1
                    }
                }
                else if topNumber == 1 {
                    firstPart = "F"
                    eighthPart = "f"
                    positions[positions.firstIndex(of: 7)!]=3
                }
            }
            if bottomNumber == 8 {
                if [1,3,4].contains(topNumber) {
                    firstPart = "R"
                    eighthPart = "r"
                    positions[positions.firstIndex(of: 8)!]=4
                    if topNumber == 4 {
                        positions[positions.firstIndex(of: 4)!]=2
                    }
                }
                else if topNumber == 2 {
                    firstPart = "f"
                    eighthPart = "F"
                    positions[positions.firstIndex(of: 8)!]=4
                }
            }
            inTop = 2
            inBottom = 0
        }
        if inTop == 2 {
            if positions[0] == 4 {
                secondPart = ""
                seventhPart = ""
                if positions[1] == 3 {
                    fourthPart = "u"
                    sixthPart = "U"
                }
                else if positions[1] == 1 {
                    fourthPart = "uu"
                    sixthPart = "UU"
                }
                else if positions[1] == 2 {
                    fourthPart = "U"
                    sixthPart = "u"
                }
            }
            else if positions[0] == 1 {
                secondPart = "UU"
                seventhPart = "uu"
                if positions[1] == 2 {
                    fourthPart = "u"
                    sixthPart = "U"
                }
                else if positions[1] == 3 {
                    fourthPart = "U"
                    sixthPart = "u"
                }
                else if positions[1] == 4 {
                    fourthPart = "uu"
                    sixthPart = "UU"
                }
            }
            else if positions[0] == 2 {
                secondPart = "U"
                seventhPart = "u"
                if positions[1] == 1 {
                    fourthPart = "U"
                    sixthPart = "u"
                }
                else if positions[1] == 3 {
                    fourthPart = "uu"
                    sixthPart = "UU"
                }
                else if positions[1] == 4 {
                    fourthPart = "u"
                    sixthPart = "U"
                }
            }
            else if positions[0] == 3 {
                secondPart = "u"
                seventhPart = "U"
                if positions[1] == 1 {
                    fourthPart = "u"
                    sixthPart = "U"
                }
                else if positions[1] == 2 {
                    fourthPart = "uu"
                    sixthPart = "UU"
                }
                else if positions[1] == 4 {
                    fourthPart = "U"
                    sixthPart = "u"
                }
            }
        }
        thirdPart = "rDRdrDR"
        fifthPart = "rdRDrdR"
        let pattern: String = zeroPart+firstPart+secondPart+thirdPart+fourthPart+fifthPart+sixthPart+seventhPart+eighthPart+ninthPart
        print("in corner flip")
        print(pattern)
        flipButtonList[1].fillColor = UIColor.red
        rotateLayer(face: doPattern(moves: pattern), pauseTime: 0.25, rotateTime: 0.25)
    }
}
