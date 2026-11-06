//
//  ActionButton.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/27/26.
//
import SwiftUI

struct ActionButton: Decodable, Equatable {
    let type: ActionButtonType
    let text: String
    let destination: Int?
    let customText: String?
    let customDestination: Int?
    let subscriptText: String?
    
    // Assigns JSON keys to different names than the Swift variables
    enum CodingKeys: String, CodingKey {
        case type
        case text
        case destination
        case customText
        case customDestination
        // "subscript" is a keyword in Swift; go figure
        case subscriptText = "subscript"
    }
}
