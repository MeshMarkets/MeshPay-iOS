import Foundation

public class MeshPay {
    private let apiKey: String
    private let baseURL: String

    public init(apiKey: String, baseURL: String = "http://localhost:3000") {
        self.apiKey = apiKey
        self.baseURL = baseURL.hasSuffix("/") ? String(baseURL.dropLast()) : baseURL
    }

    public var health: HealthResource { HealthResource(baseURL: baseURL, apiKey: apiKey) }
    public var accounts: AccountsResource { AccountsResource(baseURL: baseURL, apiKey: apiKey) }
    public var wallets: WalletsResource { WalletsResource(baseURL: baseURL, apiKey: apiKey) }
    public var charges: ChargesResource { ChargesResource(baseURL: baseURL, apiKey: apiKey) }
    public var escrows: EscrowsResource { EscrowsResource(baseURL: baseURL, apiKey: apiKey) }
    public var payouts: PayoutsResource { PayoutsResource(baseURL: baseURL, apiKey: apiKey) }
    public var apiKeys: ApiKeysResource { ApiKeysResource(baseURL: baseURL, apiKey: apiKey) }
    public var webhookEndpoints: WebhookEndpointsResource { WebhookEndpointsResource(baseURL: baseURL, apiKey: apiKey) }
    public var onRamp: OnRampResource { OnRampResource(baseURL: baseURL, apiKey: apiKey) }
    public var offRamp: OffRampResource { OffRampResource(baseURL: baseURL, apiKey: apiKey) }
    public var webhooks: WebhooksResource { WebhooksResource() }
}
