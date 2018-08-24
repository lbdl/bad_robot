//
//  CommandParserErrors.swift
//  BadRobot
//
//  Created by Timothy Storey on 24/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation


enum CommandParserError: Error {
    case IncorrectFileFormatError(msg: String)
}
