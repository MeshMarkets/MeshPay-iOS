import Foundation

public struct HealthResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func get() async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/health",
            useXApiKey: useXApiKey, skipAuth: true
        )
        return JSONUtil.object(data)
    }
}
