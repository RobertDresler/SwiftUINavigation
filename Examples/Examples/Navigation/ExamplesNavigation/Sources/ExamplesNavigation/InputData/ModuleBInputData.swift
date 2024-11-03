import SwiftUINavigation

public struct ModuleBInputData: Hashable {

    public enum ShowRule: Hashable {
        case present
        case push(StackDeepLink.Transition)
        case setRoot
    }

    public let text: String
    public let showRule: ShowRule

    public init(text: String, showRule: ShowRule) {
        self.text = text
        self.showRule = showRule
    }

}
