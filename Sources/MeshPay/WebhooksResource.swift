import Foundation
import CryptoKit

public struct WebhooksResource {
    public init() {}

    public func verifySignature(payload: String, signature: String, secret: String) -> Bool {
        let key = SymmetricKey(data: Data(secret.utf8))
        let sig = HMAC<SHA256>.authenticationCode(for: Data(payload.utf8), using: key)
        let hex = sig.map { String(format: "%02x", $0) }.joined()
        return hex == signature
    }
}
