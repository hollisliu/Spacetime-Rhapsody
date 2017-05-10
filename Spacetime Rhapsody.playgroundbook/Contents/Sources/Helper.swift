//
//  MathHelper.swift
//  Fabric
//
//  Created by Hanjie Liu on 3/23/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import Foundation
import SceneKit

func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3(l.x - r.x, l.y - r.y, l.z - r.z)
}

func * (l: SCNVector3, r: SCNFloat) -> SCNVector3 {
    return SCNVector3(l.x * r, l.y * r, l.z * r)
}

func / (l: SCNVector3, r: SCNFloat) -> SCNVector3 {
    return SCNVector3(l.x / r, l.y / r, l.z / r)
}

public extension SCNVector3 {
    
    func norm() -> SCNFloat {
        return sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
    }
    
    func reverse() -> SCNVector3 {
        return SCNVector3(-self.x, -self.y, -self.z)
    }
    
    // exclude y
    func log () -> SCNVector3 {
        return SCNVector3(Darwin.log(self.x), self.y, Darwin.log(self.z))
    }
    
//    func euclideanDistanceTo(_ a: Float) -> Float{
//       return sqrt(self*self + a*a);
//    }
}
