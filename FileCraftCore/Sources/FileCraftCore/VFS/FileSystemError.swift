//
//  FileSystemError.swift
//  FileCraftCore
//
//  Created by Sergey on 23.03.2025.
//

public enum FileSystemError: Error {
    case directoryExpected
    case fileExpected
    case invalidNodeType
    case badUrl
}
