import SwiftUI
import StoreKit

private struct RequestReviewProxy: EnvironmentKey {
    static let defaultValue: RequestReviewAction? = nil
}

public extension EnvironmentValues {
    var requestReviewProxy: RequestReviewAction? {
        get { self[RequestReviewProxy.self] }
        set { self[RequestReviewProxy.self] = newValue }
    }
}

extension View {
    public func requestReviewProxy(_ action: RequestReviewAction) -> some View {
        environment(\.requestReviewProxy, action)
    }
}
