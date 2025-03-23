//
//  FileSystem.swift
//  FileCraftCore
//
//  Created by Sergey on 23.03.2025.
//

import Foundation

public typealias PartialDataHandler = (Result<Data, Error>) -> Result<NodeSize, Error>

public enum WriteMode {
    case append, overwrite
}

public protocol FileSystem {
    var name: String { get }
    func isExists(_ node: Node) -> Bool
    func isSupported(_ node: Node) -> Bool
    func create(_ node: Node) -> Result<(), Error>
    func delete(_ node: Node) -> Result<(), Error>
    func list(at node: Node) -> Result<[Node], Error>
    
    // TODO: this should be better designed
//    func read(_ node: Node, dataHandler: @escaping PartialDataHandler)
//    func write(_ node: Node, mode: WriteMode, data: Data) -> Result<NodeSize, Error>
    
    // TODO: ...
    // copy
    // move: rename or copy + delete if different physical disks?
}
