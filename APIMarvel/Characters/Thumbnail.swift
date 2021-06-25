//
//  Thumbnail.swift
//  APIMarvel
//
//  Created by admin on 22/6/21.
//

import Foundation

struct Thumbnail: Codable {
    let path: String?
    let thumbExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case thumbExtension = "extension"
    }
}

