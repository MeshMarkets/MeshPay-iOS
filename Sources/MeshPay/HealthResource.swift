import Foundation

public struct HealthResource {
    let baseURL: String
    let apiKey: String

    public func get() async throws -> [String: Any] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/health")
        return (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
