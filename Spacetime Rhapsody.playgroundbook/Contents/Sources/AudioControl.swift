//
//  AudioControl.swift
//  Fabric
//
//  Created by Hanjie Liu on 4/1/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import Foundation
import SceneKit

extension UniverseViewController {
    func setupBackgroundAudio() {
        let source = SCNAudioSource(fileNamed: "peace.mp3")
        
        source?.loops = true
        source?.isPositional = false
        source?.volume = 0.25
        
        player = SCNAudioPlayer(source: source!)
        
        root?.addAudioPlayer(player!)
    }
    
    func playFabricSound(node n: SCNNode) {
        let source = SCNAudioSource(fileNamed: "stretch.mp3")
        
        source?.loops = false
        source?.isPositional = true
        source?.volume = 0.1
        
        player = SCNAudioPlayer(source: source!)
        
        n.addAudioPlayer(player!)
    }
}
