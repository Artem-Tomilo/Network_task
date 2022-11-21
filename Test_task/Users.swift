//
//  Users.swift
//  Test_task
//
//  Created by Артем Томило on 28.10.22.
//

import Foundation

struct Users: Codable {
    let users: [User]
    let hasMore: Int
    
    enum CodingKeys: String, CodingKey {
        case users
        case hasMore = "has_more"
    }
}

// MARK: - User
struct User: Codable {
//    let gender: Gender
    let id: String
    let photos: [Photo]
    let name: String
}

enum Gender: Codable {
    case f
}

// MARK: - Photo
struct Photo: Codable {
    let isAvatar: Bool
    let id: String
    let isLive: Bool
    let isModerated: Bool
    let url: String
    let hidden: Bool
    
    enum CodingKeys: String, CodingKey {
        case isAvatar = "is_avatar"
        case id
        case isLive = "is_live"
        case isModerated = "is_moderated"
        case url
        case hidden
    }
}
