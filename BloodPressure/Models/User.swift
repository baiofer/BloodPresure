import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var username: String
    var password: String
    
    init(id: UUID = UUID(), username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
