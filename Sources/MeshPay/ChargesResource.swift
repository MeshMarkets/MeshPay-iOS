import Foundation

public struct ChargesResource {
    let baseURL: String
    let apiKey: String

    public func list(limit: Int? = nil, cursor: String? = nil, status: String? = nil) async throws -> [String: Any] {
        var items: [URLQueryItem] = []
        if let limit = limit { items.append(URLQueryItem(name: "limit", value: "\(limit)")) }
        if let cursor = cursor { items.append(URLQueryItem(name: "cursor", value: cursor)) }
        if let status = status { items.append(URLQueryItem(name: "status", value: status)) }
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/charges", queryItems: items.isEmpty ? nil : items)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func get(chargeId: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/charges/\(chargeId)")
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func create(buyerId: String, sellerAccountId: String, amount: Double, currency: String? = "USDC", idempotencyKey: String? = nil) async throws -> [String: Any] {
        var b: [String: Any] = ["buyer_id": buyerId, "seller_account_id": sellerAccountId, "amount": amount]
        if let c = currency { b["currency"] = c }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges", body: body, idempotencyKey: idempotencyKey)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func fund(chargeId: String, entitySecretCiphertext: String, idempotencyKey: String? = nil) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["entity_secret_ciphertext": entitySecretCiphertext])
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges/\(chargeId)/fund", body: body, idempotencyKey: idempotencyKey)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func refund(chargeId: String, amount: Double? = nil, idempotencyKey: String? = nil) async throws -> [String: Any] {
        let b: [String: Any] = amount.map { ["amount": $0] } ?? [:]
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges/\(chargeId)/refund", body: body, idempotencyKey: idempotencyKey)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
