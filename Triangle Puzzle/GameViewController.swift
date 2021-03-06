//
//  GameViewController.swift
//  Triangle Puzzle
//
//  Created by Gary Old Mac on 7/23/18.
//  Copyright © 2018 com.garyrubinstein. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
// import StoreKit

class GameViewController: UIViewController {

    // let ProductID = "permutantunlock"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                // Set the scale mode to scale to fit the window
                // scene.scaleMode = .aspectFill
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false // true
            view.showsNodeCount = false // true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
