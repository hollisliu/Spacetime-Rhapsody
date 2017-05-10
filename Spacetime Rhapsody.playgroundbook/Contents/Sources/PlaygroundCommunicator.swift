//
//  PlaygroundCommunicator.swift
//  Fabric
//
//  Created by Hanjie Liu on 4/2/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import Foundation
import PlaygroundSupport

public extension UniverseViewController {
    func hideNodes() {
        let children = root!.childNodes
        
        for c in children {
            let name = c.name
            
            if (name == "fabric" || name == "camera" || name == "spot" || name == "ambient") {continue}
            
            if (!universeList.contains(name!)){
                if (c.physicsBody?.type != .none) {
                    c.physicsBody = nil
                }
                c.isHidden = true
            } else {
                c.isHidden = false
            }
        }
    }
    
    public func receive(_ message: PlaygroundValue) {
        if case let .array(text) = message {
            var res = [String]()
            
            for e in text {
                if case let .string(t) = e {
                    res.append(t)
                }
            }
            
            universeList = Set(res.map{$0})
            
            hideNodes()
        }
    }
}
