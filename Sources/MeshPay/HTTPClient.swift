import Foundation

/// Internal HTTP client used by resources.
enum HTTPClient {
    static func request(
        baseURL: String,
        apiKey: String,
        method: String,
        path: String,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        idempotencyKey: String? = nil,
        useXApiKey: Bool = false,
        skipAuth: Bool = false
    ) async throws -> Data {
        var urlString = baseURL.hasSuffix("/") ? String(baseURL.dropLast()) : baseURL
        urlString += path.hasPrefix("/") ? path : "/" + path
        if let query = queryItems, !query.isEmpty {
            var comp = URLComponents(string: urlString)
            comp?.queryItems = query
            urlString = comp?.url?.absoluteString ?? urlString
        }
        guard let url = URL(string: urlString) else {
            throw MeshPayError.invalidURL(urlString)
        }
        var req = URLRequest(url: url)
        req.httpMethod = method
        if body != nil {
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if !skipAuth {
            if useXApiKey {
                req.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
            } else {
                req.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            }
        }
        if let k = idempotencyKey { req.setValue(k, forHTTPHeaderField: "Idempotency-Key") }
        req.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: req)
        guard let http = response as? HTTPURLResponse else { return data }
        guard (200..<300).contains(http.statusCode) else {
            throw MeshPayError.apiError(http.statusCode, String(data: data, encoding: .utf8))
        }
        return data
    }
}

public enum MeshPayError: Error {
    case invalidURL(String)
    case apiError(Int, String?)
}
