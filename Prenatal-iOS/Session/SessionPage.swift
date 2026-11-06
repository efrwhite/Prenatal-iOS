//
//  SessionPage.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/27/26.
//
struct SessionPage: Decodable, Identifiable, Equatable {
    let id: Int
    let audio: String
    let progress: Double
    let blocks: [PageBlock]
    let actionButton: ActionButton
    
    // Assigns JSON keys to different names than the Swift variables
    enum CodingKeys: String, CodingKey {
        // Feels more appropriate to have it called "uuid" in the JSON
        case id = "pageNumber"
        case audio
        case progress
        case blocks
        case actionButton
    }
}
