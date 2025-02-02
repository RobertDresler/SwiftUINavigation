import SwiftUI
import StoreKit

public extension EnvironmentValues {
    @Entry var requestReviewProxy: RequestReviewAction?
}

extension View {
    public func requestReviewProxy(_ action: RequestReviewAction) -> some View {
        environment(\.requestReviewProxy, action)
    }
}
