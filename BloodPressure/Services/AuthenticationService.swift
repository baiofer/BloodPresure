import Foundation
import SwiftUI

class AuthenticationService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    private let usersKey = "users"
    private let currentUserKey = "currentUser"
    
    init() {
        loadCurrentUser()
    }
    
    func register(username: String, password: String) -> Bool {
        var users = loadUsers()
        
        // Check if username already exists
        if users.contains(where: { $0.username == username }) {
            return false
        }
        
        // Hash the password before storing
        let passwordHash = PasswordSecurity.hashPassword(password)
        let newUser = User(username: username, passwordHash: passwordHash)
        users.append(newUser)
        saveUsers(users)
        
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        let users = loadUsers()
        
        // Hash the entered password and compare with stored hash
        let passwordHash = PasswordSecurity.hashPassword(password)
        if let user = users.first(where: { $0.username == username && $0.passwordHash == passwordHash }) {
            currentUser = user
            saveCurrentUser(user)
            isAuthenticated = true
            return true
        }
        
        return false
    }
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    private func loadUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: usersKey),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return users
    }
    
    private func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }
    
    private func loadCurrentUser() {
        guard let data = UserDefaults.standard.data(forKey: currentUserKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return
        }
        currentUser = user
        isAuthenticated = true
    }
    
    private func saveCurrentUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: currentUserKey)
        }
    }
}
