import SwiftUI

public final class UserRepository: ObservableObject {

    @Published public var isUserLogged = true

    public init() {}

}
