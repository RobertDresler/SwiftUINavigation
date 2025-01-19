# SwiftUINavigation

Framework for Implementing Clean Navigation in SwiftUI


![](READMEAssets/appIcon.png)

If anything is unclear, feel free to reach out! I'm happy to clarify or update the documentation to make things more straightforward. 🚀

---------

## Features

- ✅ Handles both simple concepts, like presenting/stack navigation, and complex concepts, such as content-driven (deep linking) and step-by-step navigation ([See Examples app](#Explore-Examples-App))
- ✅ Built on native SwiftUI components, leveraging state-driven architecture in the background
- ✅ Clearly separates the navigation and presentation layers
- ✅ Perfect for everything from simple apps to large-scale projects
- ✅ Manages navigation while leaving the presentation layer architecture entirely up to you—even compatible with TCA ([See Examples app](#Explore-Examples-App))
- ✅ Fully customizable to fit your specific needs
- ✅ Inspired by the well-known Coordinator pattern but without the hassle of manually managing parent-child relationships
- ✅ Supports iOS 16 and later—with zoom transition on the stack available starting from iOS 18  
- ✅ Supports iPad as well – optimized for multi-window experiences 
- ✅ Enables calling environment actions, such as `requestReview`
- ✅ Supports backward compatibility with UIKit via `UIViewRepresentable` and `UIViewControllerRepresentable` – easily present `SFSafariViewController` or `UIActivityViewController`
- ✅ Supports Swift 6 and is concurrency safe

![](READMEAssets/commands.png)

![](READMEAssets/flows.png)

## Simple Idea

The main idea of this framework is that the navigation graph consists of `NavigationNode`s, which are connected by different relationships—such as stack, tab, or presented. This graph is then interpreted and displayed on the screen, as each node has its representation as a `View`. You can modify the graph using `NavigationCommand`s.

I recommend starting with the [Examples app](#Explore-Examples-App) to get a feel for the framework. Then, you can explore it further [on your own](#Explore-on-Your-Own). For more comprehensive details, refer to the [Documentation](#Documentation).

## Getting Started

### Explore Examples App

I highly recommend starting by exploring the Examples app. The app features many commands that you can use to handle navigation, as well as showcases common flows found in many apps. It includes everything from easy login/logout flows to custom navigation bars with multiple windows.

1. Get the repo

    - Clone the repo: `git clone https://github.com/RobertDresler/SwiftUINavigation`
    - Download the repo (don't forget to **rename** the downloaded folder to `SwiftUINavigation`)

2. Open the app at path `SwiftUINavigation/Examples/Examples.xcodeproj`

3. Run the app

    - On simulator
    - On a real device (set your development team)

4. Explore the app


### Explore on Your Own

To get started, first add the package to your project:

- In Xcode, add the package by using this URL: `https://github.com/RobertDresler/SwiftUINavigation` and choose the dependency rule **up to next major version** from `1.0.3`
- Alternatively, add it to your `Package.swift` file: `.package(url: "https://github.com/RobertDresler/SwiftUINavigation", from: "1.0.3")`

Once the package is added, you can copy this code and begin exploring the framework by yourself:

```swift
import SwiftUI
import SwiftUINavigation

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationWindow(
                rootNode: StackRootNavigationNode(
                    stackNodes: [HomeNavigationNode()]
                )
            )
        }
    }
}

final class HomeNavigationNode: NavigationNode {

    override var view: AnyView {
        AnyView(HomeView())
    }

    func showDetail() {
        executeCommand(
            PresentNavigationCommand(
                presentedNode: SheetPresentedNavigationNode.stacked(
                    node: DetailNavigationNode()
		)
            )
        )
    }

}

struct HomeView: View {

    @EnvironmentNavigationNode private var navigationNode: HomeNavigationNode

    var body: some View {
	VStack {
            Text("Hello world from Home!")
            Button(action: { navigationNode.showDetail() }) {
            	Text("Go to Detail")
	    }
	}
    }

}

final class DetailNavigationNode: NavigationNode {

    override var view: AnyView {
        AnyView(DetailView())
    }

}

struct DetailView: View {

    @EnvironmentNavigationNode private var navigationNode: DetailNavigationNode

    var body: some View {
        Text("Hello world from Detail!")
    }

}

```

## Documentation

To see the framework in action, check out the code in the [Examples App](#Explore-Examples-App). If anything is unclear, feel free to reach out! I'm happy to clarify or update the documentation to make things more straightforward. 🚀

### NavigationWindow

The `NavigationWindow` is the top-level hierarchy element. It is placed inside a `WindowGroup` and holds a reference to the root node.

### NavigationNode

A `NavigationNode` represents a single node in the navigation graph, similar to what you might know as a Coordinator or Router. The best practice is to have one `NavigationNode` for each module or screen. A `NavigationNode` manages the navigation layer of your app. To use it, simply subclass any `NavigationNode`.

```swift
final class HomeNavigationNode: NavigationNode {
    
    override var view: AnyView {
        AnyView(HomeView())
    }
    
}
```

It is represented by an overridden `view` property. The code within the `view` can be written using any architecture (MVVM, Composable, or any other of your choice — see [Examples App](#Check-Examples-App)).

You can access the `NavigationNode` from your `View` using the following:

```swift
@EnvironmentNavigationNode private var navigationNode: YourNavigationNode
```

The framework provides several predefined `NavigationNode` types:

#### Predefined Nodes:
- **`StackRootNavigationNode`**  
  Represents what you would typically associate with a `NavigationStack` or `UINavigationController`.

- **`TabsRootNavigationNode`**  
  Represents what you would typically associate with a `TabView` or `UITabBarController`.

- **`SwitchedNavigationNode`**  
  A node that can dynamically switch between different child nodes. For example, it can display a tab bar node when the user is logged in or a welcome screen node when the user is not logged in.

- **`SFSafariNavigationNode`**  
  A node that opens a URL in an in-app browser.

### NavigationCommand

To perform common navigation actions like append, present, or dismiss, you need to modify the navigation graph. In the framework, this is handled using `NavigationCommand`s. These commands allow you to dynamically update the graph to reflect the desired navigation flow. Many commands are already predefined within the framework (see [Examples App](#Explore-Examples-App)).

A command is executed in a `NavigationNode` using the `execute(on:)` method:

```swift
final class HomeNavigationNode: NavigationNode {

    ...

    func showDetail() {
        executeCommand(
            PresentNavigationCommand(
                presentedNode: SheetPresentedNavigationNode.stacked(node: DetailNavigationNode())
            )
        )
    }

}
```

#### Predefined Commands

##### Stack Commands
- **`StackAppendNavigationCommand`**  
  Adds a new node to the stack - you can think of it as a push
- **`StackDropLastNavigationCommand`**  
  Hides the last `k` nodes in the stack - you can think of it as a pop
- **`StackDropToRootNavigationCommand`**  
  Leaves only the first node in the stack - you can think of it as a pop to root
- **`StackSetRootNavigationCommand`**  
  Replaces the root node in the stack
- **`StackMapNavigationCommand`**  
  Changes the stack - you can create your own command using this one

##### Presentation Commands
- **`PresentNavigationCommand`**  
  Presents a node on the highest node that can present
- **`PresentOnGivenNodeNavigationCommand`**  
  Presents a node on the specified node

##### Dismiss Commands
- **`DismissNavigationCommand`**  
  Dismisses the highest presented node
- **`DismissJustFromPresentedNavigationCommand`**  
  Dismisses the node on which it is called, if it is the highest presented node

##### Other Commands
- **`ResolvedHideNavigationCommand`**  
  Dismisses the node if possible, otherwise drops the last node in the stack
- **`TabsSelectItemNavigationCommand`**  
  Changes the selected tab in the nearest tab bar
- **`SwitchNavigationCommand`**  
  If the called node is a `SwitchedNavigationNode`, it switches its `switchedNode`
- **`OpenWindowNavigationCommand`**  
  Opens a new window with ID
- **`DismissWindowNavigationCommand`**  
  Closes the window with ID
- **`DefaultHandleDeepLinkNavigationCommand`**  
  Handles a deep link on the most appropriate node (see [NavigationDeepLink](#NavigationDeepLink))
- **`OpenURLNavigationCommand`**  
  Opens a URL using `NavigationEnvironmentTrigger` (see [NavigationEnvironmentTrigger](#NavigationEnvironmentTrigger))

The framework is designed to allow you to easily create your own commands as well (see [Examples App](#Explore-Examples-App)).

### PresentedNavigationNode

If you want to present a node, you use `PresentedNavigationNode` (which holds your `NavigationNode`) in combination with `PresentNavigationCommand`.

#### Predefined PresentedNavigationNodes
- **`FullScreenCoverPresentedNavigationNode`**  
  Displays a full-screen modal, similar to `fullScreenCover` in SwiftUI. It's preferable to create it using `stack(node:)` if you want to add it to a new stack, or `standalone(node:)` if you don't want to wrap it in a stack
- **`SheetPresentedNavigationNode`**  
  Displays a sheet, similar to `sheet` in SwiftUI (you can adjust the detents to show it as a bottom sheet). It's preferable to create it using `stack(node:)` if you want to add it to a new stack, or `standalone(node:)` if you don't want to wrap it in a stack
- **`AlertPresentedNavigationNode`**  
  Presents a standard `alert`
- **`ConfirmationDialogPresentedNavigationNode`**  
  Presents an alert as `actionSheet`

When presenting nodes like `ConfirmationDialogPresentedNavigationNode`, you may want to present it from a specific view, so that on iPad, it appears as a popover originating from that view. To do this, use the `presentingNavigationSource(_:)` modifier to modify the view:

```swift
Button(...) { ... }
    .presentingNavigationSource(id: "logoutButton")
```

Then, when presenting it, pass the 
`sourceID` to the command's `presentedNode`:

```swift
PresentNavigationCommand(
    presentedNode: ConfirmationDialogPresentedNavigationNode(
        inputData: ...,
	sourceID: "logoutButton"
    )
)
```

You can also define your own custom presentable nodes, such as for handling a `PhotosPicker`. In this case, you need to register these nodes on the `NavigationWindow` using the `registerCustomPresentableNavigationNodes(_:)` method (see [Examples App](#Explore-Examples-App)).

### NavigationMessage

A `NavigationNode` can send a `NavigationMessage` through a message listener. You can add the listener using `addMessageListener(_:)`, and then send the message using `sendMessage(_:)`. The recipient can then check which type of message it is and handle it accordingly.

```swift
addMessageListener({ [weak self] message in
    if message is RemovalNavigationMessage {
        // Handle RemovalNavigationMessage
    }    
})
```

The framework provides a predefined message, `RemovalNavigationMessage`, which is triggered whenever a `NavigationNode` is removed from its `parent`, so you know it is being deallocated, dismissed, or dropped from the stack.

### NavigationDeepLink

Sometimes you need content-driven navigation, for example, when backend data or notifications direct users to different screens. This data is called a `NavigationDeepLink`. The specific screen and how it should be displayed is handled by `NavigationDeepLinkHandler`, which you provide during the initialization of `NavigationWindow`.

If you want a specific node to handle the deep link, execute the `DefaultHandleDeepLinkNavigationCommand`, for example, from the root node. This will route the deep link to the correct node. Alternatively, you can create a custom command for this purpose.

### NavigationEnvironmentTrigger

Sometimes, we need to use `View`'s API, which can only be triggered from the `View` itself via its `EnvironmentValues`. To do this, we can send a `NavigationEnvironmentTrigger` using `sendEnvironmentTrigger(_:)` on a `NavigationNode`. This will invoke the `DefaultNavigationEnvironmentTriggerHandler` which calls the value from `EnvironmentValues`.

#### Predefined triggers
- **`OpenURLNavigationEnvironmentTrigger`**  
  By default, calls `EnvironmentValues.openURL`
- **`OpenWindowNavigationEnvironmentTrigger`**  
  By default, calls `openWindow`
- **`DismissNavigationEnvironmentTrigger`**  
  By default, calls `EnvironmentValues.dismiss`
- **`DismissWindowNavigationEnvironmentTrigger`**  
  By default, calls `EnvironmentValues.dismissWindow`
  
If you want to customize the handler (e.g., sending a custom trigger), subclass `DefaultNavigationEnvironmentTriggerHandler` and set it on a `NavigationWindow` using `navigationEnvironmentTriggerHandler(_:)` (see [Examples App](#Explore-Examples-App)).

### NavigationNodeResolvedView

When creating a custom wrapper view, like in [`SegmentedTabsNavigationNode` in the Examples App](#Explore-Examples-App), use `NavigationNodeResolvedView` to display the node within the view hierarchy (this is e.g. how `StackRootNavigationNode` works internally).

### Custom transitions

Custom transitions like zoom are supported since iOS 18+ for Stack (see [Examples App](#Explore-Examples-App)).

### Debugging

To enable debug printing, set the following:

```swift
NavigationConfig.shared.isDebugPrintEnabled = true
```

By default, this will print the initialization and deinitialization of nodes with their IDs, helping you ensure there are no memory leaks.

```
. [SomeNavigationNode E34...]: Init
. [SomeNavigationNode F34...]: Deinit
```

You can also print the debug graph from a given `NavigationNode` and its successors using `printDebugGraph()`. This will help you understand the hierarchy structure.

![](READMEAssets/debugging.png)

### Relationships

You can explore the graph using different relationships. It's important to know that the parent/child relationship is handled automatically, so you only need to call commands. This is true unless you're implementing a custom container, in which case you can simply override `childrenPublishers` (see [SegmentedTabsNavigationNode in Examples App](#Explore-Examples-App)).

## Contribution, Issues, & Feature Requests

Contributions are welcome! Feel free to report any issues or request features—I'll be happy to assist!

## Contact

If you need further assistance, feel free to reach out:

- Email: robertdreslerjr@gmail.com
- LinkedIn: [Robert Dresler](https://www.linkedin.com/in/robert-dresler/)

## Support

If this repo has been helpful to you, consider supporting me using the link below:


[!["Buy me a coffee ☕️ or just support me"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://bmc.link/robertdresler)

