//
//  ListView.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/29/26.
//
import SwiftUI

struct ListView: View {
        
    let elements: [FlattenedListElement]
    
    var body: some View {
        // Docs say to use sections to group items in a LazyVStack,
        // though admittedly I'm not 100% sure this is what they meant...
        Section {
            ForEach(elements) { element in
                // Ensure we don't have any padding for non-indicated lists
                let bulletSize = .none ~= element.listType ? .zero : SessionView.margin // TODO not scaled
                // Indent one text-scaled magin-width per level
                // Bullet itself precedes the block, thus level - 1,
                let elementPadding = bulletSize * CGFloat(element.listLevel - 1)
                
                // HStack to keep the bullet and element horizontally adjacent
                // Alignment keeps bullet in line with top of text rather than centered
                // We're already handling horizontal spacing directly
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    // The bullet's textual representation (incl. nothing)
                    Text(Self.getBulletText(element))
                    // Aligns to start of numbers
                        .frame(width: bulletSize, alignment: .leading)
                    // Monospaced bullets (literal) look nicer
                        .monospaced(.bullet ~= element.listType)
                    // Padding will persist to the actual element
                        .padding(.leading, elementPadding)
                    // The actual block we're here for!
                    PageBlockView(block: element.block)
                }
            }
        }
    }
    
    // External switch statement that returns a String for each bullet type
    private static func getBulletText(_ inElement: FlattenedListElement) -> String {
        switch inElement.listType {
        case .bullet:
            "•"
        case .decimal:
            inElement.elementNumber.description + "."
        case .none:
            ""
        }
    }
}
