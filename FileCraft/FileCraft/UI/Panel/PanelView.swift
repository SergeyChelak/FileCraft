//
//  PanelView.swift
//  FileCraft
//
//  Created by Sergey on 23.03.2025.
//

import SwiftUI
import FileCraftCore

struct PanelView: View {
    @StateObject
    var viewModel = PanelViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    viewModel.levelUp()
                } label: {
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .rotationEffect(.degrees(90))
                        .scaleEffect(x: -1, y: 1)  // flip horizontally
                }
                Spacer()
                Text(viewModel.path)
                    .lineLimit(1)
                    .truncationMode(.head)
            }
            .padding([.leading, .trailing, .top], 8)
            Divider()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.nodes, id: \.path) { node in
                        Text(node.name)
                            .foregroundStyle(color(node))
                            .fontWeight(fontWeight(node))
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .background(backgroundColor(node))
                            .onTap(once: {
                                viewModel.singleTap(node)
                            }, twice: {
                                viewModel.doubleTap(node)
                            })
                    }
                }
            }
            Spacer()
        }
        .overlay(
            Rectangle()
                .stroke(.white, lineWidth: 2)
        )
        .overlay {
          errorView()
        }
        .task {
            await viewModel.load()
        }
    }
    
    private func backgroundColor(_ node: Node) -> Color {
        viewModel.isSelected(node) ? Color.blue : Color.clear
    }
    
    private func fontWeight(_ node: Node) -> Font.Weight {
        node.type == .directory ? .bold : .light
    }
    
    private func color(_ node: Node) -> Color {
        node.type == .directory ? .yellow : .white
    }
    
    private func errorView() -> AnyView {
        guard let error = viewModel.error else {
            return AnyView(EmptyView())
        }
        let view = ErrorView(
            error: error,
            completion: viewModel.dismissError
        )
        return AnyView(view)
    }

}

#Preview {
    PanelView()
}
