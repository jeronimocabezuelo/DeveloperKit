//
//  TagsLayout.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 10/5/25.
//

import SwiftUI

/// https://www.reddit.com/r/SwiftUI/comments/18pvz6g/comment/kf4xabg/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
/// Algo parcido, pero más complejo: https://www.youtube.com/watch?v=FzL11vRhzs8&ab_channel=Kavsoft
public struct TagsLayout: Layout {
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
