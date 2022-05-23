//
//  FileManager-DocumentsDirectory.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


