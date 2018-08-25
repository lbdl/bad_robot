//
//  Robot.swift
//  BadRobot
//
//  Created by Timothy Storey on 24/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

struct Robot {
    var currentPosition: RobotCoord
    var finalPosition: RobotCoord?
    var commands: String
    
    init(sPos: RobotCoord, cmds: String) {
        currentPosition = sPos
        commands = cmds
    }
    
    init(original: Robot, newPos nPos: RobotCoord, fPos: RobotCoord?) {
        currentPosition = nPos
        commands = original.commands
        finalPosition = fPos
    }
}

