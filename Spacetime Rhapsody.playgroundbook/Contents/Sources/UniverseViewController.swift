//
//  ViewController.swift
//  Fabric
//
//  Created by Hanjie Liu on 3/14/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import UIKit
import SceneKit
import PlaygroundSupport

public struct Constants {
    static let fabricWidth: SCNFloat = 20
    static let refreshRate: TimeInterval = 0.12
    static let screenRefreshRate: SCNFloat = 60 // frames per second
    static let touchSampleRate: Int = 20 // Point per second
    
    static let fingerStrengthFactor: Float = 3 // preferably 1 - 5
    
    static let fabricName: String = "fabric"
    static let cameraName: String = "camera"
}

public class UniverseViewController: UIViewController, SCNSceneRendererDelegate, PlaygroundLiveViewMessageHandler {
    
    var universeList: Set = ["sun", "earth", "mars"]
    
    let scnView = SCNView()
    let scene = SCNScene(named: "Universe.scn")!

    // spacetime fabric
    var root: SCNNode?
    var fabric: SCNNode?
    var camera: SCNNode?
    
    var isOpen = false
    
    public init(isOpeningScene open: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        if open {
            isOpen = true
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("This method has not been implemented.")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        scnView.delegate = self
        
        // add scene view to liveview
        scnView.scene = scene
        scnView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scnView)
        scnView.frame = view.bounds
        
        // configure skybox
        scene.background.contents = [UIImage(named: "Skybox_PositiveX.jpg"), UIImage(named: "Skybox_NegativeX.jpg"),UIImage(named: "Skybox_PositiveY.jpg"), UIImage(named: "Skybox_NegativeY.jpg"),UIImage(named: "Skybox_PositiveZ.jpg"), UIImage(named: "Skybox_NegativeZ.jpg")]
                
        root = scene.rootNode
        fabric = root!.childNode(withName: Constants.fabricName, recursively: false)
        camera = root!.childNode(withName: Constants.cameraName, recursively: false)
        
        // hide unwanted nodes
        hideNodes()
        
        // set openning scene
        if (isOpen) {
            setupOpenScene()
        }
        
        // add a tap gesture recognizer
        let pintchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePintch(_:)))
        scnView.addGestureRecognizer(pintchGesture)
        
        // add a pan gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scnView.addGestureRecognizer(panGesture)
        
        // play background music
        setupBackgroundAudio()
    }
    
    // MARK:- audio setup
    var player: SCNAudioPlayer?
    
    // MARK:- touch helper vars
    var objectPicked = false
    var selectedNode: SCNNode?
    var previousTouchedPoints = FixedSizedPointQueue(size: Constants.touchSampleRate)
    
    // screen pixel bounds of the fabric
    var fabricVanishPoint: SCNVector3 {
        get{
            return scnView.projectPoint(SCNVector3(Constants.fabricWidth,0,Constants.fabricWidth))
        }
    }
    
    var fabricZero: SCNVector3 {
        get{
            return scnView.projectPoint(SCNVector3(0,0,0))
        }
    }
    
    /// set up a opening scene
    private func setupOpenScene() {
        let mars = root?.childNode(withName: "mars", recursively: false)
        let earth = root?.childNode(withName: "earth", recursively: false)
        let sun = root?.childNode(withName: "sun", recursively: false)
        
        sun?.position = SCNVector3(6,0,6)
        earth?.position = SCNVector3(6,0,11)
        mars?.position = SCNVector3(15,0,6)
        
        let earthBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: earth!.geometry!, options: nil))
        earthBody.isAffectedByGravity = false
        earthBody.friction = 0
        earthBody.damping = 0
        earthBody.mass = 1
        earthBody.velocity = SCNVector3(1,0,0)
        
        earth?.physicsBody = earthBody
        
        let marsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: mars!.geometry!, options: nil))
        marsBody.isAffectedByGravity = false
        marsBody.friction = 0
        marsBody.damping = 0
        marsBody.mass = 1
        marsBody.velocity = SCNVector3(0,0,-1)
        
        mars?.physicsBody = marsBody
    }

}

