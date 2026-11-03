//
//  Session.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 9/21/26.
//
import Foundation

struct Session: Decodable, Identifiable, Equatable {
    // Has to be "id" to comply with Identifiable
    let id: UUID
    let title: String
    let pages: [SessionPage]
    
    // Assigns JSON keys to different names than the Swift variables
    enum CodingKeys: String, CodingKey {
        // Feels more appropriate to have it called "uuid" in the JSON
        case id = "uuid"
        case title
        case pages
    }
}
