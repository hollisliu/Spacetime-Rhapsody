//
//  FixedSizeQueue.swift
//  Fabric
//
//  Created by Hanjie Liu on 4/1/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import Foundation
import UIKit

/// a queue to hold the last n touched points on screen
public class FixedSizedPointQueue {
    var size = 0
    var q: [CGPoint] = []
    
    init (size s: Int) {
        size = s
    }
    
    public func enqueue(point p: CGPoint) {
        if q.count <= size {
            q.append(p)
        } else {
            q.remove(at: 0)
            q.append(p)
        }
    }
    
    public func first() -> CGPoint {
        return q[0]
    }
    
    public func clear() {
        q.removeAll()
    }
}
