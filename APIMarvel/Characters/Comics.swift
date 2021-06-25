//
//  Comics.swift
//  APIMarvel
//
//  Created by admin on 22/6/21.
//

import Foundation

struct Comics: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [Items]?
}
