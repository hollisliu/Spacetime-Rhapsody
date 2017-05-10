//
//  RenderLookCallbacks.swift
//  Fabric
//
//  Created by Hanjie Liu on 3/30/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import SceneKit

public extension UniverseViewController {
    /// pass up to 8 uniforms to the geometry shader after physics is simulated, 
    /// unused uniforms are set to have negative mass
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        let activeNodes = getAllNodesLocation()
        
        var count = 0
        for n in activeNodes{
                        
            passUniform(node: fabric!, value: n, uniform: "pt\(count)")
            
            count += 1
            
            if (count > 7) {break}
        }
        
        if (count < 7){
            for i in count...7{
                // negative mass means no object
                passUniform(node: fabric!, value: SCNVector4(0,0,-1,0), uniform: "pt\(i)")
            }
        }
    }
    
    /// Get all astronomical nodes in the scene
    private func getAllNodesLocation() -> [SCNVector4]{
        let children = root!.childNodes
        
        var res = [SCNVector4]()
        
        for c in children{
            // only compute for visable stars
            if (c.isHidden) {continue}
            
            let pos = c.presentation.position
            
            var mass: SCNFloat = 0
            var diameter: SCNFloat = 0
            
            // compute uniforms
            switch c.name! {
            case "earth":
                mass = 1
                diameter = 0.8
            case "sun":
                mass = 5
                diameter = 3
            case "mars":
                mass = 1
                diameter = 0.7
            case "venus":
                mass = 0.8
                diameter = 0.6
            case "jupiter":
                mass = 3
                diameter = 2
            case "neptune":
                mass = 2
                diameter = 1.5
            case "neutron":
                mass = 4
                diameter = 0.3
                
            default:
                continue
            }
            
            res.append(SCNVector4(pos.x, pos.z, mass, diameter))

        }
        
        return res
    }
    
    func passUniform(node n: SCNNode, value v: SCNVector4, uniform s: String){
        let mat = n.geometry!.firstMaterial!
        mat.setValue(NSValue(scnVector4: v), forKey: s)
    }
    
}

