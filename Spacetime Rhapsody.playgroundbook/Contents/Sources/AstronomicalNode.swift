//
//  AstronomicalNode.swift
//  Fabric
//
//  Created by Hanjie Liu on 3/30/17.
//  Copyright © 2017 Hanjie Liu. All rights reserved.
//

import UIKit
import SceneKit

public enum AstronomicalType {
    case star
    case planet
    case neutronStar
}

public enum ObjectType: String {
    case sun = "sun"
    case earth = "earth"
    case mars = "mars"
    case jupiter = "jupiter"
    case neptune = "neptune"
    case venus = "venus"
    case neutronStar = "neutron"
}

public struct AstronomicalObject {
    var obj: ObjectType?
    
    public init(name n: ObjectType, type t: AstronomicalType) {
        obj = n
    }
    
    public func toString() -> String{
        return obj!.rawValue
    }
}
