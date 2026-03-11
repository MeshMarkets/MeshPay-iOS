import Foundation

public struct AccountsResource {
    let baseURL: String
    let apiKey: String

    public func create(email: String) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["email": email])
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/accounts", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
