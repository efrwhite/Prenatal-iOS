//
//  ListType.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 9/21/26.
//
enum ListType: String, Decodable {
    // Option names taken from ItemListStyle:
    // https://developer.apple.com/documentation/applenewsformat/listitemstyle
    // Unfortunately, it doesn't seem to be directly useful to us...?
    case bullet
    case decimal
    //case lower_alphabetical
    //case upper_alphabetical
    //case lower_roman
    //case upper_roman
    // case character // Harder to implement
    case none
}
