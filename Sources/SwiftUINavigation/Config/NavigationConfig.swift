@MainActor
public struct NavigationConfig {

    public static var shared = NavigationConfig(
        isDebugPrintEnabled: false
    )

    public var isDebugPrintEnabled: Bool

}
