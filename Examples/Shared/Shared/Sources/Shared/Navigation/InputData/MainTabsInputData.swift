public struct MainTabsInputData {

    public enum Tab {
        case commands
        case flows
    }

    public let initialTab: Tab

    public init(initialTab: Tab) {
        self.initialTab = initialTab
    }

}
