//
//  PageBlock.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 9/21/26.
//
import SwiftUI

enum PageBlock: Decodable, Hashable, Identifiable, Equatable {
    case text(data: String)
    case title(data: String)
    case image(name: String)
    case list(type: ListType, elements: [PageBlock])
    case horizontalRule
    
    case boxedText(backgroundColor: String, data: String) // is color a String, though?
    case chips(multiSelect: Bool, savedName: String, choices: [String])
    case accordion(choices: [AccordionChoice], defaultElements: [PageBlock])
    case input(size: String, savedName: String, watermark: String) // is size a String, though?
    case navigationButton(text: String, destination: Int)
    case showIfSaved(check: [String], elements: [PageBlock])
    
    // Enables Identifiable; works because Hashables are able to be used as identifiers
    var id: Self {
        self
    }
    
    // Can be called directly to flatten a .list instance with no fuss
    // Works on non-lists too, but will do nothing useful
    @FlattenedListBuilder
    var flattened: [FlattenedListElement] {
        self
    }
}
