@attached(extension, conformances: NavigationNode, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro NavigationNode() = #externalMacro(module: "Macros", type: "NavigationNode")

@attached(extension, conformances: NavigationNode, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro TabsRootNavigationNode() = #externalMacro(module: "Macros", type: "TabsRootNavigationNode")

@attached(extension, conformances: NavigationNode, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro SwitchedNavigationNode() = #externalMacro(module: "Macros", type: "SwitchedNavigationNode")

@attached(extension, conformances: NavigationNode, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro StackRootNavigationNode() = #externalMacro(module: "Macros", type: "StackRootNavigationNode")
