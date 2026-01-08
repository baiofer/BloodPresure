import Foundation
import CryptoKit

/// Utility for handling password security
/// Note: In production, passwords should be stored in Keychain Services
/// This implementation provides basic hashing for demonstration purposes
struct PasswordSecurity {
    
    /// Hash a password using SHA256
    /// - Parameter password: Plain text password
    /// - Returns: Hashed password as hex string
    static func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    /// Verify a password against a hash
    /// - Parameters:
    ///   - password: Plain text password to verify
    ///   - hash: Stored hash to compare against
    /// - Returns: True if password matches hash
    static func verifyPassword(_ password: String, hash: String) -> Bool {
        return hashPassword(password) == hash
    }
}
