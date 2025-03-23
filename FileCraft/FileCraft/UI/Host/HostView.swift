//
//  HostView.swift
//  FileCraft
//
//  Created by Sergey on 23.03.2025.
//

import SwiftUI

struct HostView: View {
    var body: some View {
        HStack(spacing: 8) {
            PanelView()
            PanelView()
        }
        .padding(2)
    }
}

#Preview {
    HostView()
}
