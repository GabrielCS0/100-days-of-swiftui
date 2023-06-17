//
//  FileManager-DocumentsDirectory.swift
//  C5-Eventfy
//
//  Created by Gabriel on 15/06/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
