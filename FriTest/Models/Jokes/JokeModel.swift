//
//  JokeModel.swift
//  FriTest
//
//  Created by Ali Gutierrez on 10/11/22.
//

import Foundation

// MARK: - Welcome
struct Joke: Codable, Hashable {
    let id: String
    let iconURL: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case id
        case iconURL = "icon_url"
        case value
    }
}
