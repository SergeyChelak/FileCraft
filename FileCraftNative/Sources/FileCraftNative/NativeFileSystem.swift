
import Foundation
import FileCraftCore

public final class NativeFileSystem: FileSystem {
    private let fileManager: FileManager = .default
    
    public init() {
        //
    }
    
    public var name: String {
        "Local File Storage"
    }
    
    public func isExists(_ node: any FileCraftCore.Node) -> Bool {
        guard let path = node.path else {
            return false
        }
        // TODO: add check if node type is matches a founded dir/file
        return fileManager.fileExists(atPath: path)
    }
    
    public func isSupported(_ node: any FileCraftCore.Node) -> Bool {
        return node.url?.isFileURL == true
    }
    
    public func create(_ node: any FileCraftCore.Node) -> Result<(), any Error> {
        fatalError()
    }
    
    public func delete(_ node: any FileCraftCore.Node) -> Result<(), any Error> {
        fatalError()
    }
    
    public func list(at node: any FileCraftCore.Node) -> Result<[any FileCraftCore.Node], any Error> {
//        guard isSupported(node), node.type == .directory else {
//            return .failure(FileSystemError.directoryExpected)
//        }
        
        guard let url = node.url else {
            return .failure(FileSystemError.badUrl)
        }
        
        do {
            let nodes = try fileManager.contentsOfDirectory(
                at: url,
                includingPropertiesForKeys: nil
            )
            .map {
                FileNode($0)
            }
            return .success(nodes)
        } catch {
            return .failure(error)
        }
    }
}
