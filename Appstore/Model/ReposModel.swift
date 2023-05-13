import Foundation

// MARK: - UserRepoElement
struct UserRepoElement: Codable {
    let id: Int
    let name, fullName: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description = "description"
    }
}
