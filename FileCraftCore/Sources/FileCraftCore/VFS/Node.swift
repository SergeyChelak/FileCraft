//
//  Node.swift
//  FileCraftCore
//
//  Created by Sergey on 23.03.2025.
//

import Foundation

public enum NodeType: Equatable {
    case directory, file
}

public typealias NodeSize = UInt64

public protocol Node {
    var name: String { get }
    
    var type: NodeType { get }
    var size: NodeSize { get }
    
    var parent: Node? { get }
    func levelUp() -> Node?
    
    var url: URL? { get }
    var path: String? { get }
}
