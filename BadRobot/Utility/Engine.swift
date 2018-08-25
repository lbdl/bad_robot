//
//  Engine.swift
//  BadRobot
//
//  Created by Timothy Storey on 25/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

class Engine: NSObject {
    
    var robots: [Robot]
    var grid: PlanetGrid
    
    init(_ robots: [Robot], grid: PlanetGrid) {
        self.robots = robots
        self.grid = grid

        super.init()

    }
    
    static func getDirection(_ dir: Dir, nxtMove: Move) -> Dir {
        
        switch nxtMove {
        case .L:
            let nxt = (dir.rawValue - 1) % 4
            return Dir(rawValue: nxt)!
        case .R:
            let nxt = (dir.rawValue + 1) % 4
            return Dir(rawValue: nxt)!
        case .F:
            return dir
        }
    }
}
