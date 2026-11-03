//
//  AccordionChoice.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/28/26.
//
struct AccordionChoice: Decodable, Hashable, Identifiable, Equatable {
    let icon: String
    let label: String
    let elements: [PageBlock]
    
    // Enables Identifiable; works because Hashables are able to be used as identifiers
    var id: Self {
        self
    }
}
