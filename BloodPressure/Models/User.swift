import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var username: String
    var passwordHash: String // Hashed password, not plain text
    
    init(id: UUID = UUID(), username: String, passwordHash: String) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
    }
}
