import Foundation

public struct ApiKeysResource {
    let baseURL: String
    let apiKey: String

    public func list() async throws -> [[String: Any]] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/api-keys")
        return (try JSONSerialization.jsonObject(with: data) as? [[String: Any]]) ?? []
    }

    public func create(name: String? = nil) async throws -> [String: Any] {
        let b: [String: Any] = name.map { ["name": $0] } ?? [:]
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/api-keys", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func delete(id: String) async throws {
        _ = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "DELETE", path: "/api-keys/\(id)")
    }
}
