//
//  TouchHandler.swift
//  Fabric
//
//  Created by Hanjie Liu on 3/30/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import Foundation
import SceneKit

public extension UniverseViewController {
    
    private func computeWoldClippingZFromScreenPointY(screenPoint p: CGFloat) -> CGFloat{
        let z1 = fabricVanishPoint.z
        let z0 = fabricZero.z
        
        let y1 = fabricVanishPoint.y
        let y0 = fabricZero.y
        
        let a = -(z1 - z0)
        let z = a * ((SCNFloat(p) - y1) / (y0 - y1)) + z1
        
        return CGFloat(z)
    }

    
    func handlePan(_ gestureRecognize: UIPanGestureRecognizer){
        let p = gestureRecognize.location(in: scnView)
        
        // add touch points to queue for velocity calculation
        previousTouchedPoints.enqueue(point: p)
        
        switch gestureRecognize.state{
        case .began:
            let hitResults = scnView.hitTest(p, options: nil)
            
            if hitResults.count > 0 {
                let result = hitResults[0]
                
                let node = result.node
                
                // avoid moving the spacetime fabic
                if (node.name == Constants.fabricName) {
                    return
                }
                
                selectedNode = node
                objectPicked = true
                
                if (selectedNode?.physicsBody?.type == .static) {
                    // play sound effect
                    playFabricSound(node: selectedNode!)
                }
            }
            
        case .changed:
            // move objects
            if objectPicked {
                // enter scene
                if (selectedNode?.physicsBody?.type == .none){
                    let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: selectedNode!.geometry!, options: nil))
                    body.isAffectedByGravity = false
                    body.friction = 0
                    body.damping = 0
                    //body.angularVelocity.y = 0.5
                    
                    switch selectedNode!.name! {
                    case "earth":
                        body.mass = 1
                    case "mars":
                        body.mass = 0.8
                    case "venus":
                        body.mass = 0.7
                    case "jupiter":
                        body.mass = 3
                    case "neptune":
                        body.mass = 2
                    default:
                        break
                    }
                    
                    selectedNode!.physicsBody = body
                    
                    // play sound effect
                    playFabricSound(node: selectedNode!)
                }
                
                // remove velocity when select an object
                let v = selectedNode?.physicsBody?.velocity.norm()
                
                if (v != 0) {
                    selectedNode?.physicsBody?.type = .static
                }
                
                let z = computeWoldClippingZFromScreenPointY(screenPoint: p.y)
                let worldPoint = scnView.unprojectPoint(SCNVector3(p.x, p.y, z))
                
                let action = SCNAction.move(to: worldPoint, duration: Constants.refreshRate)
                selectedNode?.runAction(action)
            }
            
            // change camera angle
            else {
                let fingers = gestureRecognize.numberOfTouches
                
                // pitch camera
                if (fingers == 2) {
                    // positive velocity means downwards
                    let v = gestureRecognize.velocity(in: scnView).y
                    
                    if (v < 0) {
                        camera?.eulerAngles.x += 0.008
                        camera?.position.y -= 0.1
                    } else {
                        camera?.eulerAngles.x -= 0.008
                        camera?.position.y += 0.1
                    }
                }
            }
            
        case .ended:
            if objectPicked {
                // apply force
                let head = previousTouchedPoints.first()
                
                let z0 = computeWoldClippingZFromScreenPointY(screenPoint: head.y)
                let p0 = scnView.unprojectPoint(SCNVector3(head.x, head.y, z0))
                
                let z1 = computeWoldClippingZFromScreenPointY(screenPoint: p.y)
                let p1 = scnView.unprojectPoint(SCNVector3(p.x, p.y, z1))
                
                let dx = p1 - p0
                let dt = SCNFloat(Constants.touchSampleRate) / Constants.screenRefreshRate
                
                var vel = dx / dt
                
                // avoid flying error
                if (dx.norm() < 1) {
                    selectedNode?.physicsBody?.type = .dynamic
                    return
                }
                
                // smoothing factor to avoid quick swipe resulting in huge velocity
                let fineTuneFactor = Constants.fingerStrengthFactor / log(vel.norm())
                vel = (vel / vel.norm()) * fineTuneFactor
                
                selectedNode?.physicsBody?.type = .dynamic
                selectedNode?.physicsBody?.velocity = vel
            }
            
            previousTouchedPoints.clear()
            objectPicked = false
            
        default: break
        }
        
    }
    
    /// camera zoom
    func handlePintch(_ gestureRecognize: UIPinchGestureRecognizer) {
        switch gestureRecognize.state {
        case .changed:
            let s = gestureRecognize.scale
            
            if (s > 1) {
                // zoom in
                if (camera!.camera!.xFov < 40) {break}
                camera?.camera?.xFov -= 0.9
                camera?.camera?.yFov -= 0.9
            } else {
                if (s == 1) {return}
                //zoom out
                if (camera!.camera!.xFov > 100) {break}
                camera?.camera?.xFov += 1.1
                camera?.camera?.yFov += 1.1
            }
        default:
            break
        }

    }
}

