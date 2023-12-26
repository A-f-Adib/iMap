//
//  FileManagerDoc.swift
//  iMap
//
//  Created by A.f. Adib on 12/27/23.
//

import Foundation

extension FileManager {
    static var doccumentsDirectory : URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
