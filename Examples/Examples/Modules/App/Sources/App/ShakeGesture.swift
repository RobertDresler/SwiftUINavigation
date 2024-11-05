import SwiftUI

/// Thanks to https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-shake-gestures
// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> AnyView {
        AnyView(
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
        )
    }
}

@MainActor
protocol NavigationNodeResolvedViewModifier {
    associatedtype Body: View
    func body(content: AnyView) -> Body
}

struct AnyM: NavigationNodeResolvedViewModifier {
    func body(content: AnyView) -> some View {
        content
    }
}

struct AnyN: NavigationNodeResolvedViewModifier {
    func body(content: AnyView) -> some View {
        content
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }

    func addModifers() -> some View {
        let modifiers: [any NavigationNodeResolvedViewModifier] = [AnyM(), AnyN()]
        return modifiers.reduce(AnyView(self)) { resultView, modifier in
            AnyView(modifier.body(content: resultView))
        }
    }
}
