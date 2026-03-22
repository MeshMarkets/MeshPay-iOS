import Foundation

public struct ChargesResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func list(limit: Int? = nil, cursor: String? = nil, status: String? = nil) async throws -> [String: Any] {
        var items: [URLQueryItem] = []
        if let limit = limit { items.append(URLQueryItem(name: "limit", value: "\(limit)")) }
        if let cursor = cursor { items.append(URLQueryItem(name: "cursor", value: cursor)) }
        if let status = status { items.append(URLQueryItem(name: "status", value: status)) }
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/charges",
            queryItems: items.isEmpty ? nil : items, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func get(chargeId: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/charges/\(chargeId)", useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func create(body: [String: Any], idempotencyKey: String) async throws -> [String: Any] {
        let b = try JSONSerialization.data(withJSONObject: body)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges",
            body: b, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func fund(chargeId: String, body: [String: Any], idempotencyKey: String) async throws -> [String: Any] {
        let b = try JSONSerialization.data(withJSONObject: body)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges/\(chargeId)/fund",
            body: b, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func cancel(chargeId: String, idempotencyKey: String) async throws -> [String: Any] {
        let b = try JSONSerialization.data(withJSONObject: [String: Any]())
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges/\(chargeId)/cancel",
            body: b, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func refund(chargeId: String, body: [String: Any], idempotencyKey: String) async throws -> [String: Any] {
        let b = try JSONSerialization.data(withJSONObject: body)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/charges/\(chargeId)/refund",
            body: b, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }
}
