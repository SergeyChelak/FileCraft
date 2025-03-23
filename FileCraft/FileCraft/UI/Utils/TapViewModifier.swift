//
//  TapViewModifier.swift
//  FileCraft
//
//  Created by Sergey on 23.03.2025.
//

import Foundation
import SwiftUI


struct TapViewModifier: ViewModifier {
    typealias TapCallback = () -> Void

    private let singleTapHandler: TapCallback
    private let doubleTapHandler: TapCallback
    
    init(
        singleTapHandler: @escaping TapCallback,
        doubleTapHandler: @escaping TapCallback
    ) {
        self.singleTapHandler = singleTapHandler
        self.doubleTapHandler = doubleTapHandler
    }
    
    func body(content: Content) -> some View {
        content
            .gesture(
                TapGesture(count: 2)
                    .onEnded(doubleTapHandler)
                    .simultaneously(with: TapGesture(count: 1)
                        .onEnded(singleTapHandler)
                    )
            )
    }
}

extension View {
    func onTap(
        once: @escaping TapViewModifier.TapCallback,
        twice: @escaping TapViewModifier.TapCallback) -> some View {
        let modifier = TapViewModifier(
            singleTapHandler: once,
            doubleTapHandler: twice
        )
        return self.modifier(modifier)
    }
}
