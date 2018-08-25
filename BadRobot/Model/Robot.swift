//
//  Robot.swift
//  BadRobot
//
//  Created by Timothy Storey on 24/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

struct Robot {
    var startPos: RobotCoord
    var finalPosition: RobotCoord?
    var commands: String
    
    init(sPos: RobotCoord, cmds: String) {
        startPos = sPos
        commands = cmds
    }
    
    init(original: Robot, finalPos fPos: RobotCoord) {
        startPos = original.startPos
        commands = original.commands
        finalPosition = fPos
    }
}

