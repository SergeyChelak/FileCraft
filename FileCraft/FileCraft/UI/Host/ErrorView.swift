//
//  ErrorView.swift
//  FileCraft
//
//  Created by Sergey on 24.03.2025.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let completion: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(error.localizedDescription)
            
            Button("Dismiss", action: completion)
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .overlay(
            Rectangle()
                .stroke(.white, lineWidth: 2)
        )
        
    }
}

#Preview {
    ErrorView(
        error: NSError(domain: "Domain", code: 0),
        completion: {
            // no op
        }
    )
}
