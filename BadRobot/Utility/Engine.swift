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
    
    func getNextDirection(_ dir: Dir, nxtMove: Move) -> Dir {
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

    func getNextCoordinate(_ move: Move, direction: Dir, position: Pos) -> Pos {
        switch move {
        case .F:
            switch direction {
            case .N:
                return Pos(x: position.x, y: position.y + 1)
            case .E:
                return Pos(x: position.x + 1, y: position.y)
            case .S:
                return Pos(x: position.x, y: position.y - 1)
            case .W:
                return Pos(x: position.x - 1, y: position.y)
            }
        case .L:
            return position
        case .R:
            return position
        }
    }

    func updatePosition(_ pos: RobotCoord, cmd: String) -> RobotCoord {
        let newDir = getNextDirection(pos.direction, nxtMove: Move(rawString: cmd)!)
        let newPosition = getNextCoordinate(Move(rawString: cmd)!, direction: newDir, position: pos.position)
        return RobotCoord(direction: newDir, position: newPosition)
    }

    func runRobot(_ bot: Robot) {

        var myBot = bot

        func runCommands(_ commands: inout String ) {
            if let cmd = commands.first {
                let newPos = updatePosition(myBot.startPos, cmd: String(cmd))
                let updatedBot = Robot(original: myBot, newPos: newPos, fPos: nil)
                myBot = updatedBot
                let newSeq = commands.dropFirst()
                var newCmds = String(newSeq)
                runCommands(&newCmds)
            } else {
                print("Robot final position: facing:\(myBot.startPos.direction) at:\(myBot.startPos.position)")
                return
            }
        }


        runCommands(&myBot.commands)

    }
}
