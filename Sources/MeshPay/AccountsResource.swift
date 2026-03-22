import Foundation

public struct AccountsResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func list() async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/accounts", useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func create(email: String) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["email": email])
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/accounts", body: body, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func deleteMembership(_ membershipId: String) async throws {
        _ = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "DELETE", path: "/accounts/\(membershipId)", useXApiKey: useXApiKey
        )
    }
}
