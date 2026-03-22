import Foundation

public struct OffRampResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func createSession(body: [String: Any]) async throws -> [String: Any] {
        let b = try JSONSerialization.data(withJSONObject: body)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/off-ramp/sessions", body: b, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }
}
