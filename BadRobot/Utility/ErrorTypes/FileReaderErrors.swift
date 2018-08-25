//
//  FileReaderErrors.swift
//  BadRobot
//
//  Created by Timothy Storey on 23/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

enum FileReaderError: Error {
    case invalidPath(path: String)
    case unreadableFile(path: String)
    case dataReadError(error: String)
    case invalidFormat
}
