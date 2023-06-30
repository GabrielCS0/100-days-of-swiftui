//
//  FileManager-DocumentsDirectory.swift
//  SnowSeeker
//
//  Created by Gabriel on 29/06/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
