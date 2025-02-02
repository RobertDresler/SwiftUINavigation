@attached(extension, conformances: NavigationModel, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro NavigationModel() = #externalMacro(module: "Macros", type: "NavigationModel")

@attached(extension, conformances: TabsRootNavigationModel, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro TabsRootNavigationModel() = #externalMacro(module: "Macros", type: "TabsRootNavigationModel")

@attached(extension, conformances: SwitchedNavigationModel, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro SwitchedNavigationModel() = #externalMacro(module: "Macros", type: "SwitchedNavigationModel")

@attached(extension, conformances: StackRootNavigationModel, names: arbitrary)
@attached(member, names: arbitrary)
@attached(memberAttribute)
public macro StackRootNavigationModel() = #externalMacro(module: "Macros", type: "StackRootNavigationModel")
