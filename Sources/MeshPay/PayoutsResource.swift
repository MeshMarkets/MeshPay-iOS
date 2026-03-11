import Foundation

public struct PayoutsResource {
    let baseURL: String
    let apiKey: String

    public func list(limit: Int? = nil, cursor: String? = nil, status: String? = nil) async throws -> [String: Any] {
        var items: [URLQueryItem] = []
        if let limit = limit { items.append(URLQueryItem(name: "limit", value: "\(limit)")) }
        if let cursor = cursor { items.append(URLQueryItem(name: "cursor", value: cursor)) }
        if let status = status { items.append(URLQueryItem(name: "status", value: status)) }
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/payouts", queryItems: items.isEmpty ? nil : items)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func get(payoutId: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/payouts/\(payoutId)")
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func create(accountId: String, amount: Double, idempotencyKey: String? = nil) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["account_id": accountId, "amount": amount])
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/payouts", body: body, idempotencyKey: idempotencyKey)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
