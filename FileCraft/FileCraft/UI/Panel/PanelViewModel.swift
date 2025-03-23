//
//  PanelViewModel.swift
//  FileCraft
//
//  Created by Sergey on 23.03.2025.
//

import Foundation
import FileCraftCore
import FileCraftNative

final class PanelViewModel: ObservableObject {
    private let fileSystem: FileSystem = NativeFileSystem()
    
    @Published
    private(set) var nodes: [Node] = []
    @Published
    private(set) var error: Error?
    private var current: Node = FileNode("/")!

    var path: String {
        current.path ?? "Unknown Location"
    }
    
    @Published
    private(set) var cursorAt: Node?
    
    func load() async {
        await load(current)
    }
    
    private func load(_ node: Node) async {
        let result = fileSystem.list(at: node)
        Task { @MainActor in
            switch result {
            case .success(let nodes):
                self.nodes = nodes.sorted { first, second in
                    first.path! < second.path!
                }
                cursorAt = self.nodes.first
                current = node
            case .failure(let error):
                self.error = error
                print(error)
            }
        }
    }
    
    func singleTap(_ node: Node) {
        cursorAt = node
    }
    
    func doubleTap(_ node: Node) {
        guard node.type == .directory else {
            return
        }
        Task { await load(node) }
    }
    
    func levelUp() {
        guard let next = current.levelUp() else {
            return
        }
        Task { await load(next) }
    }
    
    func isSelected(_ node: Node) -> Bool {
        cursorAt?.url == node.url
    }
    
    func dismissError() {
        self.error = nil
    }
}
