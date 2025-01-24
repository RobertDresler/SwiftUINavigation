import Foundation

public extension NavigationCommand where Self == PresentNavigationCommand {
    static func present(_ presentedNode: any PresentedNavigationNode, animated: Bool = true) -> PresentNavigationCommand {
        PresentNavigationCommand(presentedNode: presentedNode, animated: animated)
    }
}

public extension NavigationCommand where Self == DismissNavigationCommand {
    static func dismiss(animated: Bool = true) -> DismissNavigationCommand {
        DismissNavigationCommand(animated: animated)
    }
}

public extension NavigationCommand where Self == ResolvedHideNavigationCommand {
    static func hide(animated: Bool = true) -> ResolvedHideNavigationCommand {
        ResolvedHideNavigationCommand(animated: animated)
    }
}

public extension NavigationCommand where Self == DismissJustFromPresentedNavigationCommand {
    static func dismissJustFromPresented(animated: Bool = true) -> DismissJustFromPresentedNavigationCommand {
        DismissJustFromPresentedNavigationCommand(animated: animated)
    }
}

public extension NavigationCommand where Self == StackAppendNavigationCommand {
    static func stackAppend(_ node: StackNavigationNode, animated: Bool = true) -> StackAppendNavigationCommand {
        StackAppendNavigationCommand(appendedNode: node, animated: animated)
    }

    static func stackAppend(_ node: any NavigationNode, animated: Bool = true) -> StackAppendNavigationCommand {
        StackAppendNavigationCommand(appendedNode: node, animated: animated)
    }
}

public extension NavigationCommand where Self == StackDropLastNavigationCommand {
    static func stackDropLast(_ k: UInt = 1, animated: Bool = true) -> StackDropLastNavigationCommand {
        StackDropLastNavigationCommand(k: k, animated: animated)
    }
}

public extension NavigationCommand where Self == StackDropToRootNavigationCommand {
    static func stackDropToRoot(animated: Bool = true) -> StackDropToRootNavigationCommand {
        StackDropToRootNavigationCommand(animated: animated)
    }
}

public extension NavigationCommand where Self == StackSetRootNavigationCommand {
    static func stackSetRoot(
        _ rootNode: any NavigationNode,
        clear: Bool,
        animated: Bool = true
    ) -> StackSetRootNavigationCommand {
        StackSetRootNavigationCommand(rootNode: rootNode, clear: clear, animated: animated)
    }
}

public extension NavigationCommand where Self == StackMapNavigationCommand {
    static func stackMap(
        _ transform: @escaping ([StackNavigationNode]) -> [StackNavigationNode],
        animated: Bool = true
    ) -> StackMapNavigationCommand {
        StackMapNavigationCommand(animated: animated, transform: transform)
    }
}

public extension NavigationCommand where Self == DefaultHandleDeepLinkNavigationCommand {
    static func handleDeepLink(
        _ deepLink: any NavigationDeepLink,
        messageListener: NavigationMessageListener? = nil
    ) -> NavigationCommand {
        DefaultHandleDeepLinkNavigationCommand(deepLink: deepLink, messageListener: messageListener)
    }
}

public extension NavigationCommand where Self == DismissWindowNavigationCommand {
    static func dismissWindow(id: String) -> DismissWindowNavigationCommand {
        DismissWindowNavigationCommand(id: id)
    }
}

public extension NavigationCommand where Self == OpenWindowNavigationCommand {
    static func openWindow(id: String) -> OpenWindowNavigationCommand {
        OpenWindowNavigationCommand(id: id)
    }
}

public extension NavigationCommand where Self == OpenURLNavigationCommand {
    static func openURL(_ url: URL) -> OpenURLNavigationCommand {
        OpenURLNavigationCommand(url: url)
    }
}

public extension NavigationCommand where Self == SwitchNavigationCommand {
    static func switchNode(_ switchedNode: any NavigationNode) -> SwitchNavigationCommand {
        SwitchNavigationCommand(switchedNode: switchedNode)
    }
}

public extension NavigationCommand where Self == TabsSelectItemNavigationCommand {
    static func tabsSelectItem(id: AnyHashable) -> TabsSelectItemNavigationCommand {
        TabsSelectItemNavigationCommand(itemID: id)
    }
}
