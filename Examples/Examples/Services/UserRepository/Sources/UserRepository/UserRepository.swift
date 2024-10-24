import SwiftUI

public final class UserRepository: ObservableObject {

    @Published public var isUserLogged = false

    public init() {}

}
