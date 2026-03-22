import Foundation

public struct WebhookEndpointsResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func list() async throws -> [[String: Any]] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/webhook-endpoints", useXApiKey: useXApiKey
        )
        return JSONUtil.objectArray(data)
    }

    public func get(id: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/webhook-endpoints/\(id)", useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func create(url: String, events: [String], secret: String? = nil) async throws -> [String: Any] {
        var b: [String: Any] = ["url": url, "events": events]
        if let s = secret { b["secret"] = s }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/webhook-endpoints", body: body, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func update(id: String, active: Bool? = nil, events: [String]? = nil) async throws -> [String: Any] {
        var b: [String: Any] = [:]
        if let a = active { b["active"] = a }
        if let e = events { b["events"] = e }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "PATCH", path: "/webhook-endpoints/\(id)", body: body, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func delete(id: String) async throws {
        _ = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "DELETE", path: "/webhook-endpoints/\(id)", useXApiKey: useXApiKey
        )
    }

    public func listDeliveries(id: String, limit: Int? = nil) async throws -> [[String: Any]] {
        var items: [URLQueryItem] = []
        if let limit = limit { items.append(URLQueryItem(name: "limit", value: "\(limit)")) }
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/webhook-endpoints/\(id)/deliveries",
            queryItems: items.isEmpty ? nil : items, useXApiKey: useXApiKey
        )
        return JSONUtil.objectArray(data)
    }
}
