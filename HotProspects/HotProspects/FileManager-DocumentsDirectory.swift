//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Gabriel on 21/06/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
