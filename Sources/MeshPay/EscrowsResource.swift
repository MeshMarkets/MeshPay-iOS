import Foundation

public struct EscrowsResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func list(limit: Int? = nil, status: String? = nil) async throws -> [String: Any] {
        var items: [URLQueryItem] = []
        if let limit = limit { items.append(URLQueryItem(name: "limit", value: "\(limit)")) }
        if let status = status { items.append(URLQueryItem(name: "status", value: status)) }
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/escrows",
            queryItems: items.isEmpty ? nil : items, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func get(escrowId: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/escrows/\(escrowId)", useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func release(escrowId: String, idempotencyKey: String) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: [String: Any]())
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/escrows/\(escrowId)/release",
            body: body, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func openDispute(escrowId: String, txHash: String) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["tx_hash": txHash])
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/escrows/\(escrowId)/open-dispute",
            body: body, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func resolveDispute(escrowId: String, releaseToSeller: Bool, idempotencyKey: String) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["release_to_seller": releaseToSeller])
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/escrows/\(escrowId)/resolve-dispute",
            body: body, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }
}
