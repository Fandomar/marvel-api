
import Foundation


struct CharacterResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterData?
    let etag: String?
}

