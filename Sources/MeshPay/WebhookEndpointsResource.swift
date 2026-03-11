import Foundation

public struct WebhookEndpointsResource {
    let baseURL: String
    let apiKey: String

    public func list() async throws -> [[String: Any]] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/webhook-endpoints")
        return (try JSONSerialization.jsonObject(with: data) as? [[String: Any]]) ?? []
    }

    public func get(id: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/webhook-endpoints/\(id)")
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func create(url: String, events: [String], secret: String? = nil) async throws -> [String: Any] {
        var b: [String: Any] = ["url": url, "events": events]
        if let s = secret { b["secret"] = s }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/webhook-endpoints", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func update(id: String, active: Bool? = nil, events: [String]? = nil) async throws -> [String: Any] {
        var b: [String: Any] = [:]
        if let a = active { b["active"] = a }
        if let e = events { b["events"] = e }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "PATCH", path: "/webhook-endpoints/\(id)", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func delete(id: String) async throws {
        _ = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "DELETE", path: "/webhook-endpoints/\(id)")
    }
}
