//
//  ChipsState.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/29/26.
//
import SwiftUI
import OrderedCollections

@Observable
class ChipsState: PageBlockState {
    
    // Keys are the choices from the PageBlock, values are whether they are selected
    var choices: OrderedDictionary<String, Bool>
    
    init(choices: [String]) {
        // Populate the dictionary with the provided keys, all assumed false
        self.choices = OrderedDictionary(uniqueKeysWithValues: choices.map { ($0, false) })
    }
    
    func description() -> String {
        // Reduces the dict to only ones that are true (e.g. selected) and then returns a concatenated string of any results
        choices.filter { $0.value }.keys.joined(separator: ", ")
    }
}
