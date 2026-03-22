import Foundation

public class MeshPay {
    private let apiKey: String
    private let baseURL: String
    private let useXApiKey: Bool

    public init(
        apiKey: String,
        baseURL: String = "https://YOUR_PROJECT_REF.supabase.co/functions/v1/api",
        useXApiKey: Bool = false
    ) {
        self.apiKey = apiKey
        self.useXApiKey = useXApiKey
        self.baseURL = baseURL.hasSuffix("/") ? String(baseURL.dropLast()) : baseURL
    }

    public var health: HealthResource { HealthResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var accounts: AccountsResource { AccountsResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var wallets: WalletsResource { WalletsResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var charges: ChargesResource { ChargesResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var escrows: EscrowsResource { EscrowsResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var webhookEndpoints: WebhookEndpointsResource { WebhookEndpointsResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var onRamp: OnRampResource { OnRampResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var offRamp: OffRampResource { OffRampResource(baseURL: baseURL, apiKey: apiKey, useXApiKey: useXApiKey) }
    public var webhooks: WebhooksResource { WebhooksResource() }
}
