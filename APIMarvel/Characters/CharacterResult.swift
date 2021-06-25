
import Foundation

struct CharacterResult: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    let urls: [CharacterURL]?
    let thumbnail: Thumbnail?
    let comics: Comics?
    let stories: Stories?
    let events: Events?
    let series: Series?
}
