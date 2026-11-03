//
//  FlattenedListBuilder.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 9/22/26.
//
@resultBuilder
struct FlattenedListBuilder {
    // Basic final mapper
    static func buildBlock(_ components: [FlattenedListElement]...) -> [FlattenedListElement] {
        components.flatMap { $0 }
    }
    
    // Custom internal builder that handles type and level
    // replacement and incrementation
    static func buildExpression(_ expression: PageBlock, listType: ListType, listLevel: Int, elementNumber: Int) -> [FlattenedListElement] {
        switch expression {
        case let .list(subType, subElements):
            return buildExpression(subElements, listType: subType, listLevel: listLevel + 1)
        default:
            return [FlattenedListElement(listLevel: listLevel, listType: listType, elementNumber: elementNumber, block: expression)]
        }
    }
    
    // Custom internal builder that can chain back and forth
    // with the above for recursive sublists
    static func buildExpression(_ expression: [PageBlock], listType: ListType, listLevel: Int) -> [FlattenedListElement] {
        var elements = [FlattenedListElement]()
        var elementNumber = 0
        for element in expression {
            elementNumber += 1
            elements.append(contentsOf: buildExpression(element, listType: listType, listLevel: listLevel, elementNumber: elementNumber))
        }
        return elements
    }
    
    // Basic single-item builder
    static func buildExpression(_ expression: PageBlock) -> [FlattenedListElement] {
        buildExpression(expression, listType: .none, listLevel: 0, elementNumber: 0)
    }
    
    // Basic multi-item builder
    static func buildExpression(_ expression: [PageBlock]) -> [FlattenedListElement] {
        buildExpression(expression, listType: .none, listLevel: 0)
    }
    
    // Basic optional builder
    static func buildOptional(_ components: [PageBlock]?) -> [FlattenedListElement] {
        if let expression = components {
            return buildExpression(expression)
        }
        else {
            return []
        }
    }
    
    // Basic if statement builders
    static func buildEither(first components: [PageBlock]) -> [FlattenedListElement] {
        buildExpression(components)
    }

    static func buildEither(second components: [PageBlock]) -> [FlattenedListElement] {
        buildExpression(components)
    }
    
    // Basic array builder (for loops)
    static func buildArray(_ components: [[PageBlock]]) -> [FlattenedListElement] {
        buildExpression(components.flatMap { $0 })
    }
}
