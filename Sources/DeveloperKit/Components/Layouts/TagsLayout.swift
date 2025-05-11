//
//  TagsLayout.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 10/5/25.
//

import SwiftUI

/// https://www.reddit.com/r/SwiftUI/comments/18pvz6g/comment/kf4xabg/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
public struct TagsLayoutOld: Layout {
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    
    public init(verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0) {
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
    }
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        if let w = proposal.width, w > 0 {
            let h = coordinates(boundsWidth: w, proposal: proposal, subviews: subviews).reduce(0, { max($0, $1.maxY) })
            return CGSize(width: w, height: h)
        }
        
        return proposal.replacingUnspecifiedDimensions()
    }
    
    private func coordinates(boundsWidth: CGFloat, proposal: ProposedViewSize, subviews: Subviews) -> [CGRect] {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        var rectangles = [CGRect]()
        
        for subview in subviews {
            let viewDimensions = subview.dimensions(in: proposal)
            // Find a vector with an appropriate size and rotation.
            
            if x > 0, x + viewDimensions.width > boundsWidth {
                y += rowHeight + verticalSpacing
                x = 0
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, viewDimensions.height)
            
            rectangles.append(CGRect(x: x, y: y, width: viewDimensions.width, height: viewDimensions.height))
            
            x += viewDimensions.width + horizontalSpacing
        }
        
        return rectangles
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            let viewDimensions = subview.dimensions(in: proposal)
            // Find a vector with an appropriate size and rotation.
            
            if x > 0, x + viewDimensions.width > bounds.width {
                y += rowHeight + verticalSpacing
                x = 0
                rowHeight = 0
            }
            
            rowHeight = max(rowHeight, viewDimensions.height)
            
            var point = CGPoint(x: bounds.minX + x, y: bounds.minY + y)
            point.x += viewDimensions.width / 2
            point.y += viewDimensions.height / 2
            
            // Place the subview.
            subview.place(at: point, anchor: .center, proposal: .unspecified)
            
            x += viewDimensions.width + horizontalSpacing
        }
    }
}

/// Algo parcido, pero más complejo: https://www.youtube.com/watch?v=FzL11vRhzs8&ab_channel=Kavsoft
public struct TagLayout: Layout {
    let alignment: Alignment
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    
    public init(alignment: Alignment = .center, verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0) {
        self.alignment = alignment
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
    }
    
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        print("sizeThatFits:")
        let maxWidth = proposal.width ?? .zero
        let rows = generateRows(maxWidth, proposal, subviews)
        
        var height: CGFloat = .zero
        
        for (index, row) in rows.enumerated() {
            if index == (rows.count - 1) {
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + verticalSpacing
            }
//            print("height: \(height)")
        }
//        print("width: \(maxWidth), height: \(height)")
        return .init(width: maxWidth, height: height)
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxWidth = bounds.width
        let rows = generateRows(maxWidth, proposal, subviews)
        
        var origin = bounds.origin
        
        for row in rows {
            let leading: CGFloat = bounds.maxX - maxWidth
            let trailing: CGFloat = bounds.maxX - (row.reduce(CGFloat.zero) { partialResult, view in
                let width = view.sizeThatFits(proposal).width
                if view == row.last {
                    return partialResult + width
                }
                
                return partialResult + width + horizontalSpacing
            })
            let center = (trailing + leading) / 2
            
            origin.x = alignment == .leading ? leading : alignment == .trailing ? trailing : center
            
            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                
                origin.x += viewSize.width + horizontalSpacing
            }
            
            origin.y += row.maxHeight(proposal) + verticalSpacing
        }
    }
    
    /// Generating Rows based on available Size
    func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
        
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        
        var origin = CGRect.zero.origin
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + horizontalSpacing) > maxWidth {
                rows.append(row)
                row.removeAll()
                
                origin.x = .zero
            }
            
            row.append(view)
            origin.x += (viewSize.width + horizontalSpacing)
        }
        
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
        
        return rows
    }
}

extension [LayoutSubviews.Element] {
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
        let result =  self.compactMap({ view in
            return view.sizeThatFits(proposal).height
        }).max() ?? .zero
        
//        print("maxHeight: \(result)")
        
        return result
    }
}

private struct TagsLayoutView: View {
    let data: [String] = ["apple", "banana", "orange", "grape", "pineapple", "mango", "strawberry", "blueberry", "blackberry", "cherry", "peach", "plum", "apricot", "avocado", "kiwi", "lime", "lemon", "melon", "nectarine", "watermelon"]
//    let data: [String] = Array(repeating: ["apple", "banana", "orange", "grape", "pineapple", "mango", "strawberry", "blueberry", "blackberry", "cherry", "peach", "plum", "apricot", "avocado", "kiwi", "lime", "lemon", "melon", "nectarine", "watermelon"], count: 10).flatten().shuffled()
    
    var body: some View {
        ScrollView {
            VStack {
                TagLayout(verticalSpacing: 10, horizontalSpacing: 10) {
                    ForEach(data, id: \.self) { item in
                        Text(item)
                            .padding(.horizontal, 8)
                            .background(.gray.opacity(0.2))
                            .clipShape(.capsule)
                            .shadow(radius: 8)
                    }
                }
                .background(.red)
            }
        }
    }
}

#Preview {
    TagsLayoutView()
}
