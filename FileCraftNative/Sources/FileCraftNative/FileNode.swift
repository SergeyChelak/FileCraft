//
//  FileNode.swift
//  FileCraftNative
//
//  Created by Sergey on 23.03.2025.
//

import Foundation
import FileCraftCore

public final class FileNode: Node {
    private let location: URL
    
    public init(_ location: URL) {
        self.location = location
    }
    
    public convenience init?(_ path: String) {
        guard let url = URL(string: path) else {
            return nil
        }
        self.init(url)
    }
    
    public var url: URL? {
        location
    }
    
    public var path: String? {
        location.path
    }
    
    public var name: String {
        location.lastPathComponent
    }
    
    public var type: FileCraftCore.NodeType {
        location.isDirectory ? .directory : .file
    }
    
    public var size: FileCraftCore.NodeSize {
        fatalError()
    }
    
    public var parent: (any FileCraftCore.Node)? {
        fatalError()
    }
    
    public func levelUp() -> (any FileCraftCore.Node)? {
        fatalError()
    }
}
