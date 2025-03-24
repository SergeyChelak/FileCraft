
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
    
    public func exist(_ node: any FileCraftCore.Node) -> FileCraftCore.ExistType {
        guard let path = node.path else {
            return .notFound
        }
        var isDirectory: ObjCBool = true
        guard fileManager.fileExists(atPath: path, isDirectory: &isDirectory) else {
            return .notFound
        }
        return isDirectory.boolValue ? .directory : .file
    }
    
    public func isSupported(_ node: any FileCraftCore.Node) -> Bool {
        node.url?.scheme == "file"
    }
    
    public func create(_ node: any FileCraftCore.Node) -> Result<(), any Error> {
        fatalError()
    }
    
    public func delete(_ node: any FileCraftCore.Node) -> Result<(), any Error> {
        fatalError()
    }
    
    public func list(at node: any FileCraftCore.Node) -> Result<[any FileCraftCore.Node], any Error> {
        guard isSupported(node), exist(node) == .directory else {
            return .failure(FileSystemError.directoryExpected)
        }
        
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
