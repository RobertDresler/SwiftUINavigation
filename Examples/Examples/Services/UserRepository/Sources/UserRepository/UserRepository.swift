import SwiftUI

public final class UserRepository: ObservableObject {

    @Published public var isUserLogged = true
    @Published public var isUserPremium = false

    public init() {}

}
