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
}

#Preview {
    PanelView()
}
