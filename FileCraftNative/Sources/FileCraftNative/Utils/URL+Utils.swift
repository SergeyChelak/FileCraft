//
//  URL+Utils.swift
//  FileCraftNative
//
//  Created by Sergey on 23.03.2025.
//

import Foundation

extension URL {
    // that isn't working correctly
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
