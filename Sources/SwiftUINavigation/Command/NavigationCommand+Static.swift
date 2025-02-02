import Foundation

public extension NavigationCommand where Self == PresentNavigationCommand {
    static func present(_ presentedModel: any PresentedNavigationModel, animated: Bool = true) -> PresentNavigationCommand {
        PresentNavigationCommand(presentedModel: presentedModel, animated: animated)
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
    static func stackAppend(_ model: StackNavigationModel, animated: Bool = true) -> StackAppendNavigationCommand {
        StackAppendNavigationCommand(appendedModel: model, animated: animated)
    }

    static func stackAppend(_ model: any NavigationModel, animated: Bool = true) -> StackAppendNavigationCommand {
        StackAppendNavigationCommand(appendedModel: model, animated: animated)
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
        _ rootModel: any NavigationModel,
        clear: Bool,
        animated: Bool = true
    ) -> StackSetRootNavigationCommand {
        StackSetRootNavigationCommand(rootModel: rootModel, clear: clear, animated: animated)
    }
}

public extension NavigationCommand where Self == StackMapNavigationCommand {
    static func stackMap(
        _ transform: @escaping ([StackNavigationModel]) -> [StackNavigationModel],
        animated: Bool = true
    ) -> StackMapNavigationCommand {
        StackMapNavigationCommand(animated: animated, transform: transform)
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
    static func switchModel(_ switchedModel: any NavigationModel) -> SwitchNavigationCommand {
        SwitchNavigationCommand(switchedModel: switchedModel)
    }
}

public extension NavigationCommand where Self == TabsSelectItemNavigationCommand {
    static func tabsSelectItem(id: AnyHashable) -> TabsSelectItemNavigationCommand {
        TabsSelectItemNavigationCommand(itemID: id)
    }
}
