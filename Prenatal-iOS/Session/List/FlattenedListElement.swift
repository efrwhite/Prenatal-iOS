//
//  FlattenedListElement.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 9/22/26.
//
struct FlattenedListElement: Hashable, Identifiable, Equatable {
    let listLevel: Int
    let listType: ListType
    let elementNumber: Int
    let block: PageBlock
    
    // Enables Identifiable; works because Hashables are able to be used as identifiers
    var id: Self {
        self
    }
}
