//
//  FileCraftApp.swift
//  FileCraft
//
//  Created by Sergey on 23.03.2025.
//

import SwiftUI

@main
struct FileCraftApp: App {
    var body: some Scene {
        WindowGroup {
            HostView()
                .onDisappear {
                    NSApplication.shared.terminate(nil)
                }
        }
    }
}
