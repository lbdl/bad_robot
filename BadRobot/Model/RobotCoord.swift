//
//  RobotCoord.swift
//  BadRobot
//
//  Created by Timothy Storey on 24/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

enum Dir: Int {
    case N, E, S, W
}

extension Dir {
    static var dirDict: [String: Dir] = [
        "N": .N,
        "E": .E,
        "S": .S,
        "W": .W
    ]
}

enum Move: Int {
    case L, R, F
}

extension Move {
    static var moveDict: [String: Move] = [
        "L": .L,
        "R": .R,
        "F": .F
    ]
}

struct Pos {
    var x: Int
    var y: Int
}

struct RobotCoord {
    var direction: Dir
    var position: Pos
}

struct DirectionFinder {
    
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
