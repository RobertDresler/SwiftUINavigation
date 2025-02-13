import SwiftUI

public final class FlagsRepository: ObservableObject {

    @Published public var isUserLogged = true
    @Published public var isUserPremium = false
    @Published public var isWaitingWindowOpen = false
    #if os(iOS)
    @Published public var isAppLocked = false
    #endif

    public init() {}

}
