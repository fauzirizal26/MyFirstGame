//
//  GameViewController.swift
//  MyFirstGame
//
//  Created by Marilyn Martha Yusnita Devi Parhusip on 18/05/19.
//  Copyright © 2019 Apple Academy. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    
    let position = SCNVector3(x: 2, y: 3, z: 5)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
        
        let x = position.x
        let y = position.y
        let z = position.z
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        
        
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
//            SCNTransaction.begin()
//            SCNTransaction.animationDuration = 0.5
//
//            // on completion - unhighlight
//            SCNTransaction.completionBlock = {
//                SCNTransaction.begin()
//                SCNTransaction.animationDuration = 0.5
//
//                material.emission.contents = UIColor.black
//
//                SCNTransaction.commit()
//            }
//
//            material.emission.contents = UIColor.red
//
//            SCNTransaction.commit()
            performSegue(withIdentifier: "transform_segue", sender: nil)
            
        }

        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        
        
        return true
    }
    
    func setupView(){
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
    }
    
    func setupScene(){
        scnScene = SCNScene()
        scnView.scene = scnScene
        
    }

    func setupCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0 , z: 10)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape(){
        var geometry: SCNGeometry
        
        switch ShapeType.random(){
        default:
            geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        }
        
        let color = randomColor()
//        geometry.materials.first?.diffuse.contents = color
        
        let geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
        
        
        
    }
    
    
    
    func randomColor() -> UIColor{
        
        
        let randomRed = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        let color = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        return color
    }
    
    func moveCamera(){
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    

}
